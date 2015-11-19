From: mengdong.lin@linux.intel.com
Subject: [PATCH v2 1/2] topology: Not compare a for loop
	iterator with ABI __le32 variables
Date: Thu, 19 Nov 2015 03:33:05 -0500
Message-ID: <f972d64a34ad6969cd8bbb0e427a5058779a415a.1447921888.git.mengdong.lin@linux.intel.com>
References: <cover.1447921888.git.mengdong.lin@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
 by alsa0.perex.cz (Postfix) with ESMTP id 8D438265DF4
 for <alsa-devel@alsa-project.org>; Thu, 19 Nov 2015 09:17:57 +0100 (CET)
In-Reply-To: <cover.1447921888.git.mengdong.lin@linux.intel.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
Cc: Mengdong Lin <mengdong.lin@linux.intel.com>, tiwai@suse.de, mengdong.lin@intel.com, vinod.koul@intel.com, liam.r.girdwood@intel.com, subhransu.s.prusty@intel.com
List-Id: alsa-devel@alsa-project.org

From: Mengdong Lin <mengdong.lin@linux.intel.com>

The iterator 'i' in a loop is a usually a integer. But ABI variables use
type _le32, which is converted to host unsigned integer. Comparing them
can cause gcc warning: comparison between signed and unsigned integer
expressions[-Wsign-compare].

Signed-off-by: Mengdong Lin <mengdong.lin@linux.intel.com>

diff --git a/src/topology/ctl.c b/src/topology/ctl.c
index 7d8787f..1c073f7 100644
--- a/src/topology/ctl.c
+++ b/src/topology/ctl.c
@@ -676,7 +676,7 @@ int tplg_add_mixer(snd_tplg_t *tplg, struct snd_tplg_mixer_template *mixer,
 	struct snd_soc_tplg_private *priv = mixer->priv;
 	struct snd_soc_tplg_mixer_control *mc;
 	struct tplg_elem *elem;
-	int ret, i;
+	int ret, i, num_channels;
 
 	tplg_dbg(" Control Mixer: %s\n", mixer->hdr.name);
 
@@ -708,9 +708,10 @@ int tplg_add_mixer(snd_tplg_t *tplg, struct snd_tplg_mixer_template *mixer,
 	for (i = 0; i < SND_SOC_TPLG_MAX_CHAN; i++)
 		mc->channel[i].reg = -1;
 
-	if (mixer->map)
-		mc->num_channels = mixer->map->num_channels;
-	for (i = 0; i < mc->num_channels; i++) {
+	num_channels = mixer->map ? mixer->map->num_channels : 0;
+	mc->num_channels = num_channels;
+
+	for (i = 0; i < num_channels; i++) {
 		struct snd_tplg_channel_elem *channel = &mixer->map->channel[i];
 
 		mc->channel[i].size = channel->size;
@@ -743,7 +744,7 @@ int tplg_add_enum(snd_tplg_t *tplg, struct snd_tplg_enum_template *enum_ctl,
 {
 	struct snd_soc_tplg_enum_control *ec;
 	struct tplg_elem *elem;
-	int ret, i;
+	int ret, i, num_items;
 
 	tplg_dbg(" Control Enum: %s\n", enum_ctl->hdr.name);
 
@@ -765,15 +766,14 @@ int tplg_add_enum(snd_tplg_t *tplg, struct snd_tplg_enum_template *enum_ctl,
 		return ret;
 	}
 
-	ec->items = enum_ctl->items;
-	if (ec->items > SND_SOC_TPLG_NUM_TEXTS)
-		ec->items = SND_SOC_TPLG_NUM_TEXTS;
-
+	num_items =  enum_ctl->items < SND_SOC_TPLG_NUM_TEXTS ?
+		enum_ctl->items : SND_SOC_TPLG_NUM_TEXTS;
+	ec->items = num_items;
 	ec->mask = enum_ctl->mask;
 	ec->count = enum_ctl->items;
 
 	if (enum_ctl->texts != NULL) {
-		for (i = 0; i < ec->items; i++) {
+		for (i = 0; i < num_items; i++) {
 			if (enum_ctl->texts[i] != NULL)
 				strncpy(ec->texts[i], enum_ctl->texts[i],
 					SNDRV_CTL_ELEM_ID_NAME_MAXLEN);
@@ -781,7 +781,7 @@ int tplg_add_enum(snd_tplg_t *tplg, struct snd_tplg_enum_template *enum_ctl,
 	}
 
 	if (enum_ctl->values != NULL) {
-		for (i = 0; i < ec->items; i++) {
+		for (i = 0; i < num_items; i++) {
 			if (enum_ctl->values[i])
 				continue;
 
diff --git a/src/topology/pcm.c b/src/topology/pcm.c
index 8eb62e4..d75aad8 100644
--- a/src/topology/pcm.c
+++ b/src/topology/pcm.c
@@ -550,7 +550,7 @@ int tplg_add_pcm_object(snd_tplg_t *tplg, snd_tplg_obj_template_t *t)
 	}
 
 	pcm->num_streams = pcm_tpl->num_streams;
-	for (i = 0; i < pcm->num_streams; i++)
+	for (i = 0; i < pcm_tpl->num_streams; i++)
 		tplg_add_stream_object(&pcm->stream[i], &pcm_tpl->stream[i]);
 
 	return 0;
@@ -583,7 +583,7 @@ int tplg_add_link_object(snd_tplg_t *tplg, snd_tplg_obj_template_t *t)
 	lk->id = link->id;
 	lk->num_streams = link->num_streams;
 
-	for (i = 0; i < lk->num_streams; i++)
+	for (i = 0; i < link->num_streams; i++)
 		tplg_add_stream_object(&lk->stream[i], &link->stream[i]);
 
 	return 0;
-- 
2.5.0
