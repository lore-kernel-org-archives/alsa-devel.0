From: <twischer@de.adit-jv.com>
Subject: [PATCH - snd_pcm_extplug_set_param_link() 1/1] pcm:
	extplug: Keep format and channels the same if requested
Date: Mon, 10 Dec 2018 11:33:16 +0100
Message-ID: <1544437996-1311-1-git-send-email-twischer@de.adit-jv.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp1.de.adit-jv.com (smtp1.de.adit-jv.com [93.241.18.167])
 by alsa0.perex.cz (Postfix) with ESMTP id 2148F267ACB
 for <alsa-devel@alsa-project.org>; Mon, 10 Dec 2018 11:33:33 +0100 (CET)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: tiwai@suse.de
Cc: Timo Wischer <twischer@de.adit-jv.com>, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

From: Timo Wischer <twischer@de.adit-jv.com>

Without this patch it is not possible to link the channel and format
parameter if snd_pcm_extplug_set_param_*() or
snd_pcm_extplug_set_slave_param_*() is called. Therefore the client and
slave parameter can differ. So the extplug has to implement conversion.
To avoid this the new snd_pcm_extplug_set_param_link() function can be
called.
As a reproduction sceanrio the following extplug source code can be used:
static snd_pcm_sframes_t my_transfer(snd_pcm_extplug_t *e,
	const snd_pcm_channel_area_t *da, snd_pcm_uframes_t dof,
	const snd_pcm_channel_area_t *sa, snd_pcm_uframes_t sof,
	snd_pcm_uframes_t s) {
	return s;
}
static const snd_pcm_extplug_callback_t my_own_callback = {
	.transfer = my_transfer
};
SND_PCM_PLUGIN_DEFINE_FUNC(my_plug) {
	snd_config_iterator_t i, next;
	snd_config_t *slave = NULL;
	snd_pcm_extplug_t *myplug;
	snd_config_for_each(i, next, conf) {
		snd_config_t *n = snd_config_iterator_entry(i);
		const char *id;
		if (snd_config_get_id(n, &id) < 0)
			continue;
		if (strcmp(id, "comment") == 0 || strcmp(id, "type") == 0)
			continue;
		if (strcmp(id, "slave") == 0) {
			slave = n;
			continue;
		}
		return -EINVAL;
	}
	myplug = calloc(1, sizeof(*myplug));
	myplug->version = SND_PCM_EXTPLUG_VERSION;
	myplug->callback = &my_own_callback;
	snd_pcm_extplug_create(myplug, name, root, slave, stream, mode);

	snd_pcm_extplug_set_param_minmax(myplug,
		SND_PCM_EXTPLUG_HW_CHANNELS, 1, 16);
//	snd_pcm_extplug_set_param_link(myplug, SND_PCM_EXTPLUG_HW_CHANNELS, 1);

	*pcmp = myplug->pcm;
	return 0;
}
SND_PCM_PLUGIN_SYMBOL(my_plug);

To use this plugin the following ALSA configuration is required:
pcm.myplug {
    type my_plug
    slave.pcm hw:Dummy
}

With this configuration without this patch
snd_pcm_hw_params_get_channels_max() will always return 16 channels
independent of the supported channels of the dummy device. Due to that for
example the start up of JACK would fail:
$ modprobe snd_dummy
$ jackd -d alsa -P myplug
ALSA: cannot set channel count to 16 for playback
ALSA: cannot configure playback channel

Signed-off-by: Timo Wischer <twischer@de.adit-jv.com>

diff --git a/include/pcm_extplug.h b/include/pcm_extplug.h
index ced934f..e5c02d4 100644
--- a/include/pcm_extplug.h
+++ b/include/pcm_extplug.h
@@ -184,6 +184,8 @@ int snd_pcm_extplug_set_param_list(snd_pcm_extplug_t *extplug, int type, unsigne
 int snd_pcm_extplug_set_param_minmax(snd_pcm_extplug_t *extplug, int type, unsigned int min, unsigned int max);
 int snd_pcm_extplug_set_slave_param_list(snd_pcm_extplug_t *extplug, int type, unsigned int num_list, const unsigned int *list);
 int snd_pcm_extplug_set_slave_param_minmax(snd_pcm_extplug_t *extplug, int type, unsigned int min, unsigned int max);
+int snd_pcm_extplug_set_param_link(snd_pcm_extplug_t *extplug, int type,
+				   int keep_link);
 
 /**
  * set the parameter constraint with a single value
diff --git a/src/pcm/pcm_ext_parm.h b/src/pcm/pcm_ext_parm.h
index d25f2ab..7b99bef 100644
--- a/src/pcm/pcm_ext_parm.h
+++ b/src/pcm/pcm_ext_parm.h
@@ -5,6 +5,7 @@ struct snd_ext_parm {
 	unsigned int *list;
 	unsigned int active: 1;
 	unsigned int integer: 1;
+	unsigned int keep_link: 1;
 };
 
 static inline snd_mask_t *hw_param_mask(snd_pcm_hw_params_t *params,
diff --git a/src/pcm/pcm_extplug.c b/src/pcm/pcm_extplug.c
index 1f887c5..94002dc 100644
--- a/src/pcm/pcm_extplug.c
+++ b/src/pcm/pcm_extplug.c
@@ -249,7 +249,7 @@ static unsigned int get_links(struct snd_ext_parm *params)
 			      SND_PCM_HW_PARBIT_TICK_TIME);
 
 	for (i = 0; i < SND_PCM_EXTPLUG_HW_PARAMS; i++) {
-		if (params[i].active)
+		if (params[i].active && !params[i].keep_link)
 			links &= ~excl_parbits[i];
 	}
 	return links;
@@ -642,6 +642,17 @@ as former functions.
 To clear the parameter constraints, call #snd_pcm_extplug_params_reset()
 function. 
 
+When using snd_pcm_extplug_set_param_*() or snd_pcm_extplug_set_slave_param_*()
+for any parameter. This parameter is no longer linked between the client and
+slave PCM. Therefore it could differ and the extplug has to support conversion
+between all valid parameter configurations. To keep the client and slave
+parameter linked #snd_pcm_extplug_set_param_link() can be used for the
+corresponding parameter. For example if the extplug does not support channel nor
+format conversion the supported client parameters can be limited with
+snd_pcm_extplug_set_param_*() and afterwards
+#snd_pcm_extplug_set_param_link(ext, SND_PCM_EXTPLUG_HW_FORMAT, 1) and
+#snd_pcm_extplug_set_param_link(ext, SND_PCM_EXTPLUG_HW_CHANNELS, 1) should be
+called to keep the client and slave parameters the same.
 */
 
 /**
@@ -849,3 +860,26 @@ int snd_pcm_extplug_set_param_minmax(snd_pcm_extplug_t *extplug, int type, unsig
 	return snd_ext_parm_set_minmax(&ext->params[type], min, max);
 }
 
+/**
+ * @brief Keep the client and slave format/channels the same if requested. This
+ * is for example useful if this extplug does not support any channel
+ * conversion.
+ * @param extplug the extplug handle
+ * @param type parameter type
+ * @param keep_link if 1 the parameter identified by type will be kept the same
+ * for the client and slave PCM of this extplug
+ * @return 0 if successful, or a negative error code
+ */
+int snd_pcm_extplug_set_param_link(snd_pcm_extplug_t *extplug, int type,
+				   int keep_link)
+{
+	extplug_priv_t *ext = extplug->pcm->private_data;
+
+	if (type < 0 || type >= SND_PCM_EXTPLUG_HW_PARAMS) {
+		SNDERR("EXTPLUG: invalid parameter type %d", type);
+		return -EINVAL;
+	}
+	ext->params[type].keep_link = keep_link ? 1 : 0;
+	ext->sparams[type].keep_link = keep_link ? 1 : 0;
+	return 0;
+}
-- 
2.7.4
