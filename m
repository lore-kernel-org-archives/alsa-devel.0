From: <twischer@de.adit-jv.com>
Subject: [PATCH - extplug without conversion 1/1] pcm: extplug:
	Use same format and channels for slave
Date: Fri, 7 Dec 2018 17:12:13 +0100
Message-ID: <1544199133-15051-2-git-send-email-twischer@de.adit-jv.com>
References: <1544199133-15051-1-git-send-email-twischer@de.adit-jv.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp1.de.adit-jv.com (smtp1.de.adit-jv.com [93.241.18.167])
 by alsa0.perex.cz (Postfix) with ESMTP id D9F0A267D14
 for <alsa-devel@alsa-project.org>; Fri,  7 Dec 2018 17:12:27 +0100 (CET)
In-Reply-To: <1544199133-15051-1-git-send-email-twischer@de.adit-jv.com>
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

if conversion is not supported by the implemented extplug.

Currently only the parameters for client and slave PCM can be limited
separately. But there is no dependency between this parameters.
This patch allows the user to link both parameter sets also if
snd_pcm_extplug_set_param*() was used to limit the capabilities of the
plugin.

Signed-off-by: Timo Wischer <twischer@de.adit-jv.com>

diff --git a/include/pcm_extplug.h b/include/pcm_extplug.h
index e3b71bc..27ae848 100644
--- a/include/pcm_extplug.h
+++ b/include/pcm_extplug.h
@@ -31,6 +31,8 @@
 #ifndef __ALSA_PCM_EXTPLUG_H
 #define __ALSA_PCM_EXTPLUG_H
 
+#include <stdbool.h>
+
 /**
  * \defgroup PCM_ExtPlug External Filter plugin SDK
  * \ingroup Plugin_SDK
@@ -180,17 +182,25 @@ int snd_pcm_extplug_delete(snd_pcm_extplug_t *ext);
 void snd_pcm_extplug_params_reset(snd_pcm_extplug_t *ext);
 
 /* hw_parameter setting */
-int snd_pcm_extplug_set_param_list(snd_pcm_extplug_t *extplug, int type, unsigned int num_list, const unsigned int *list);
-int snd_pcm_extplug_set_param_minmax(snd_pcm_extplug_t *extplug, int type, unsigned int min, unsigned int max);
+int snd_pcm_extplug_set_param_list(snd_pcm_extplug_t *extplug, int type,
+				   unsigned int num_list,
+				   const unsigned int *list,
+				   const bool conversion_supported);
+int snd_pcm_extplug_set_param_minmax(snd_pcm_extplug_t *extplug, int type,
+				     unsigned int min, unsigned int max,
+				     const bool conversion_supported);
 int snd_pcm_extplug_set_slave_param_list(snd_pcm_extplug_t *extplug, int type, unsigned int num_list, const unsigned int *list);
 int snd_pcm_extplug_set_slave_param_minmax(snd_pcm_extplug_t *extplug, int type, unsigned int min, unsigned int max);
 
 /**
  * set the parameter constraint with a single value
  */
-static __inline__ int snd_pcm_extplug_set_param(snd_pcm_extplug_t *extplug, int type, unsigned int val)
+static __inline__ int snd_pcm_extplug_set_param(snd_pcm_extplug_t *extplug,
+						int type, unsigned int val,
+						const bool conversion_supported)
 {
-	return snd_pcm_extplug_set_param_list(extplug, type, 1, &val);
+	return snd_pcm_extplug_set_param_list(extplug, type, 1, &val,
+					      conversion_supported);
 }
 
 /**
diff --git a/src/pcm/pcm_extplug.c b/src/pcm/pcm_extplug.c
index 1004f54..d1c451e 100644
--- a/src/pcm/pcm_extplug.c
+++ b/src/pcm/pcm_extplug.c
@@ -41,6 +41,7 @@ const char *_snd_module_pcm_extplug = "";
 typedef struct snd_pcm_extplug_priv {
 	snd_pcm_plugin_t plug;
 	snd_pcm_extplug_t *data;
+	bool conversion_supported[SND_PCM_EXTPLUG_HW_PARAMS];
 	struct snd_ext_parm params[SND_PCM_EXTPLUG_HW_PARAMS];
 	struct snd_ext_parm sparams[SND_PCM_EXTPLUG_HW_PARAMS];
 } extplug_priv_t;
@@ -232,7 +233,7 @@ static int snd_pcm_extplug_hw_refine_sprepare(snd_pcm_t *pcm,
 	return 0;
 }
 
-static unsigned int get_links(struct snd_ext_parm *params)
+static unsigned int get_links(extplug_priv_t *ext, struct snd_ext_parm *params)
 {
 	int i;
 	unsigned int links = (SND_PCM_HW_PARBIT_FORMAT |
@@ -249,7 +250,10 @@ static unsigned int get_links(struct snd_ext_parm *params)
 			      SND_PCM_HW_PARBIT_TICK_TIME);
 
 	for (i = 0; i < SND_PCM_EXTPLUG_HW_PARAMS; i++) {
-		if (params[i].active)
+		/* only disable the link if the param is set and conversion is
+		 * supported by the extplug
+		 */
+		if (params[i].active && ext->conversion_supported[i])
 			links &= ~excl_parbits[i];
 	}
 	return links;
@@ -260,7 +264,7 @@ static int snd_pcm_extplug_hw_refine_schange(snd_pcm_t *pcm,
 					     snd_pcm_hw_params_t *sparams)
 {
 	extplug_priv_t *ext = pcm->private_data;
-	unsigned int links = get_links(ext->sparams);
+	unsigned int links = get_links(ext, ext->sparams);
 
 	return _snd_pcm_hw_params_refine(sparams, links, params);
 }
@@ -270,7 +274,7 @@ static int snd_pcm_extplug_hw_refine_cchange(snd_pcm_t *pcm,
 					     snd_pcm_hw_params_t *sparams)
 {
 	extplug_priv_t *ext = pcm->private_data;
-	unsigned int links = get_links(ext->params);
+	unsigned int links = get_links(ext, ext->params);
 
 	return _snd_pcm_hw_params_refine(params, links, sparams);
 }
@@ -698,6 +702,9 @@ int snd_pcm_extplug_create(snd_pcm_extplug_t *extplug, const char *name,
 
 	ext->data = extplug;
 	extplug->stream = stream;
+	/* keep the old behaviour as default */
+	for (int i = 0; i < SND_PCM_EXTPLUG_HW_PARAMS; i++)
+		ext->conversion_supported[i] = true;
 
 	snd_pcm_plugin_init(&ext->plug);
 	ext->plug.read = snd_pcm_extplug_read_areas;
@@ -772,6 +779,11 @@ int snd_pcm_extplug_set_slave_param_list(snd_pcm_extplug_t *extplug, int type, u
 		SNDERR("EXTPLUG: invalid parameter type %d", type);
 		return -EINVAL;
 	}
+	if (!ext->conversion_supported[type]) {
+		SNDERR("EXTPLUG: do not call %s(%d) if conversion is not supported",
+		       __func__, type);
+		return -EINVAL;
+	}
 	return snd_ext_parm_set_list(&ext->sparams[type], num_list, list);
 }
 
@@ -798,6 +810,11 @@ int snd_pcm_extplug_set_slave_param_minmax(snd_pcm_extplug_t *extplug, int type,
 		SNDERR("EXTPLUG: invalid parameter type %d", type);
 		return -EINVAL;
 	}
+	if (!ext->conversion_supported[type]) {
+		SNDERR("EXTPLUG: do not call %s(%d) if conversion is not supported",
+		       __func__, type);
+		return -EINVAL;
+	}
 	return snd_ext_parm_set_minmax(&ext->sparams[type], min, max);
 }
 
@@ -807,19 +824,30 @@ int snd_pcm_extplug_set_slave_param_minmax(snd_pcm_extplug_t *extplug, int type,
  * \param type parameter type
  * \param num_list number of available values
  * \param list the list of available values
+ * \param conversion_supported set true if the extplug is capabile to convert
+ * to any slave format/channels (defined by type)
  * \return 0 if successful, or a negative error code
  *
  * Sets the master parameter as the list.
  * The available values of the given parameter type of this PCM (as input) is restricted
  * to the ones of the given list.
  */
-int snd_pcm_extplug_set_param_list(snd_pcm_extplug_t *extplug, int type, unsigned int num_list, const unsigned int *list)
+int snd_pcm_extplug_set_param_list(snd_pcm_extplug_t *extplug, int type,
+				   unsigned int num_list,
+				   const unsigned int *list,
+				   const bool conversion_supported)
 {
 	extplug_priv_t *ext = extplug->pcm->private_data;
 	if (type < 0 || type >= SND_PCM_EXTPLUG_HW_PARAMS) {
 		SNDERR("EXTPLUG: invalid parameter type %d", type);
 		return -EINVAL;
 	}
+	if (!conversion_supported && ext->sparams[type].active) {
+		SNDERR("EXTPLUG: do not call snd_pcm_extplug_set_slave_param*(%d) if conversion is not supported",
+		       type);
+		return -EINVAL;
+	}
+	ext->conversion_supported[type] = conversion_supported;
 	return snd_ext_parm_set_list(&ext->params[type], num_list, list);
 }
 
@@ -829,13 +857,17 @@ int snd_pcm_extplug_set_param_list(snd_pcm_extplug_t *extplug, int type, unsigne
  * \param type parameter type
  * \param min the minimum value
  * \param max the maximum value
+ * \param conversion_supported set true if the extplug is capabile to convert
+ * to any slave format/channels (defined by type)
  * \return 0 if successful, or a negative error code
  *
  * Sets the master parameter as the min/max values.
  * The available values of the given parameter type of this PCM (as input) is restricted
  * between the given minimum and maximum values.
  */
-int snd_pcm_extplug_set_param_minmax(snd_pcm_extplug_t *extplug, int type, unsigned int min, unsigned int max)
+int snd_pcm_extplug_set_param_minmax(snd_pcm_extplug_t *extplug, int type,
+				     unsigned int min, unsigned int max,
+				     const bool conversion_supported)
 {
 	extplug_priv_t *ext = extplug->pcm->private_data;
 	if (type < 0 || type >= SND_PCM_EXTPLUG_HW_PARAMS) {
@@ -846,6 +878,12 @@ int snd_pcm_extplug_set_param_minmax(snd_pcm_extplug_t *extplug, int type, unsig
 		SNDERR("EXTPLUG: invalid parameter type %d", type);
 		return -EINVAL;
 	}
+	if (!conversion_supported && ext->sparams[type].active) {
+		SNDERR("EXTPLUG: do not call snd_pcm_extplug_set_slave_param*(%d) if conversion is not supported",
+		       type);
+		return -EINVAL;
+	}
+	ext->conversion_supported[type] = conversion_supported;
 	return snd_ext_parm_set_minmax(&ext->params[type], min, max);
 }
 
-- 
2.7.4
