From: Arun Raghavan <arun.raghavan@collabora.co.uk>
Subject: [PATCH] Implement snd_mixer_selem_ask_*
Date: Wed, 21 Dec 2011 19:47:51 +0530
Message-ID: <1324477071-5481-1-git-send-email-arun.raghavan@collabora.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [93.93.128.226])
	by alsa0.perex.cz (Postfix) with ESMTP id 4D4422437E
	for <alsa-devel@alsa-project.org>; Wed, 21 Dec 2011 15:17:26 +0100 (CET)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel@alsa-project.org, Arun Raghavan <arun.raghavan@collabora.co.uk>
List-Id: alsa-devel@alsa-project.org

This implements the snd_mixer_selem_ask_* family of functions. These are
needed by PulseAudio.
---
 src/mixer.c        |   19 +++++++++++++++
 src/mixer_macros.h |   64 ++++++++++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 83 insertions(+), 0 deletions(-)

diff --git a/src/mixer.c b/src/mixer.c
index 3f87eca..c502d33 100644
--- a/src/mixer.c
+++ b/src/mixer.c
@@ -1067,6 +1067,25 @@ int _snd_selem_vol_get_dB(snd_selem_vol_item_t *item, int channel,
 				     item->vol[RAW_IDX(channel)], value);
 }
 
+int _snd_selem_ask_vol_dB(snd_selem_vol_item_t *item, long value, long *dBvalue)
+{
+	if (init_db_info(item) < 0)
+		return -EINVAL;
+	return snd_tlv_convert_to_dB(item->db_info,
+				     item->raw_min, item->raw_max,
+				     value, dBvalue);
+}
+
+int _snd_selem_ask_dB_vol(snd_selem_vol_item_t *item, long dBvalue, long *value,
+                          int xdir)
+{
+	if (init_db_info(item) < 0)
+		return -EINVAL;
+	return snd_tlv_convert_from_dB(item->db_info,
+				     item->raw_min, item->raw_max,
+				     dBvalue, value, xdir);
+}
+
 int _snd_selem_vol_get_dB_range(snd_selem_vol_item_t *item,
 				long *min, long *max)
 {
diff --git a/src/mixer_macros.h b/src/mixer_macros.h
index 8c8ae86..4c8d9c5 100644
--- a/src/mixer_macros.h
+++ b/src/mixer_macros.h
@@ -564,6 +564,11 @@ extern int _snd_selem_vol_get_dB(snd_selem_vol_item_t *item, int channel,
 extern int _snd_selem_vol_set_dB(snd_selem_vol_item_t *item,
 				 snd_mixer_selem_channel_id_t channel,
 				 long db_gain, int xdir);
+extern int _snd_selem_ask_vol_dB(snd_selem_vol_item_t *item, long value,
+				 long *dBvalue);
+extern int _snd_selem_ask_dB_vol(snd_selem_vol_item_t *item, long dBvalue,
+				 long *value, int xdir);
+
 __SALSA_EXPORT_FUNC
 int snd_mixer_selem_get_playback_dB_range(snd_mixer_elem_t *elem,
 					  long *min, long *max)
@@ -582,6 +587,22 @@ int snd_mixer_selem_get_playback_dB(snd_mixer_elem_t *elem,
 }
 
 __SALSA_EXPORT_FUNC
+int snd_mixer_selem_ask_playback_vol_dB(snd_mixer_elem_t *elem, long value,
+					long *dBvalue)
+{
+	return _snd_selem_ask_vol_dB((snd_selem_vol_item_t *)elem->items[SND_SELEM_ITEM_PVOLUME],
+				     value, dBvalue);
+}
+
+__SALSA_EXPORT_FUNC
+int snd_mixer_selem_ask_playback_dB_vol(snd_mixer_elem_t *elem, long dBvalue,
+					int dir, long *value)
+{
+	return _snd_selem_ask_dB_vol((snd_selem_vol_item_t *)elem->items[SND_SELEM_ITEM_PVOLUME],
+				     dBvalue, value, dir);
+}
+
+__SALSA_EXPORT_FUNC
 int snd_mixer_selem_set_playback_dB(snd_mixer_elem_t *elem,
 				    snd_mixer_selem_channel_id_t channel,
 				    long value, int dir)
@@ -628,6 +649,22 @@ int snd_mixer_selem_get_capture_dB(snd_mixer_elem_t *elem,
 }
 
 __SALSA_EXPORT_FUNC
+int snd_mixer_selem_ask_capture_vol_dB(snd_mixer_elem_t *elem, long value,
+				       long *dBvalue)
+{
+	return _snd_selem_ask_vol_dB((snd_selem_vol_item_t *)elem->items[SND_SELEM_ITEM_CVOLUME],
+				     value, dBvalue);
+}
+
+__SALSA_EXPORT_FUNC
+int snd_mixer_selem_ask_capture_dB_vol(snd_mixer_elem_t *elem, long dBvalue,
+				       int dir, long *value)
+{
+	return _snd_selem_ask_dB_vol((snd_selem_vol_item_t *)elem->items[SND_SELEM_ITEM_CVOLUME],
+				     dBvalue, value, dir);
+}
+
+__SALSA_EXPORT_FUNC
 int snd_mixer_selem_set_capture_dB(snd_mixer_elem_t *elem,
 				   snd_mixer_selem_channel_id_t channel,
 				   long value, int dir)
@@ -673,6 +710,19 @@ int snd_mixer_selem_get_playback_dB(snd_mixer_elem_t *elem,
 }
 
 __SALSA_EXPORT_FUNC __SALSA_NOT_IMPLEMENTED
+int snd_mixer_selem_ask_playback_vol_dB(snd_mixer_elem_t *elem, long value,
+					long *dBvalue)
+{
+	return -ENXIO;
+}
+
+__SALSA_EXPORT_FUNC __SALSA_NOT_IMPLEMENTED
+int snd_mixer_selem_ask_playback_dB_vol(snd_mixer_elem_t *elem, long dBvalue,
+					int dir, long *value)
+{
+	return -ENXIO;
+}
+__SALSA_EXPORT_FUNC __SALSA_NOT_IMPLEMENTED
 int snd_mixer_selem_set_playback_dB(snd_mixer_elem_t *elem,
 				    snd_mixer_selem_channel_id_t channel,
 				    long value, int dir)
@@ -703,6 +753,20 @@ int snd_mixer_selem_get_capture_dB(snd_mixer_elem_t *elem,
 }
 
 __SALSA_EXPORT_FUNC __SALSA_NOT_IMPLEMENTED
+int snd_mixer_selem_ask_capture_vol_dB(snd_mixer_elem_t *elem, long value,
+				       long *dBvalue)
+{
+	return -ENXIO;
+}
+
+__SALSA_EXPORT_FUNC __SALSA_NOT_IMPLEMENTED
+int snd_mixer_selem_ask_capture_dB_vol(snd_mixer_elem_t *elem, long value,
+				       int dir, long *dBvalue)
+{
+	return -ENXIO;
+}
+
+__SALSA_EXPORT_FUNC __SALSA_NOT_IMPLEMENTED
 int snd_mixer_selem_set_capture_dB(snd_mixer_elem_t *elem,
 				   snd_mixer_selem_channel_id_t channel,
 				   long value, int dir)
-- 
1.7.8
