From: Takashi Iwai <tiwai@suse.de>
Subject: [PATCH 09/10] ALSA: hda - Remove channel mode helper
	functions
Date: Thu, 26 Feb 2015 18:00:24 +0100
Message-ID: <1424970025-8082-10-git-send-email-tiwai@suse.de>
References: <1424970025-8082-1-git-send-email-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx2.suse.de (cantor2.suse.de [195.135.220.15])
 by alsa0.perex.cz (Postfix) with ESMTP id DCF07264F0F
 for <alsa-devel@alsa-project.org>; Thu, 26 Feb 2015 18:00:31 +0100 (CET)
Received: from relay1.suse.de (charybdis-ext.suse.de [195.135.220.254])
 by mx2.suse.de (Postfix) with ESMTP id 88911ADD6
 for <alsa-devel@alsa-project.org>; Thu, 26 Feb 2015 17:00:31 +0000 (UTC)
In-Reply-To: <1424970025-8082-1-git-send-email-tiwai@suse.de>
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
List-Id: alsa-devel@alsa-project.org

They are no longer used, let's kill them.

Signed-off-by: Takashi Iwai <tiwai@suse.de>
---
 sound/pci/hda/hda_codec.c | 82 -----------------------------------------------
 sound/pci/hda/hda_local.h | 23 -------------
 2 files changed, 105 deletions(-)

diff --git a/sound/pci/hda/hda_codec.c b/sound/pci/hda/hda_codec.c
index 6580a367023e..db86b446743c 100644
--- a/sound/pci/hda/hda_codec.c
+++ b/sound/pci/hda/hda_codec.c
@@ -4844,88 +4844,6 @@ EXPORT_SYMBOL_GPL(snd_hda_check_amp_list_power);
 #endif
 
 /*
- * Channel mode helper
- */
-
-/**
- * snd_hda_ch_mode_info - Info callback helper for the channel mode enum
- * @codec: the HDA codec
- * @uinfo: pointer to get/store the data
- * @chmode: channel mode array
- * @num_chmodes: channel mode array size
- */
-int snd_hda_ch_mode_info(struct hda_codec *codec,
-			 struct snd_ctl_elem_info *uinfo,
-			 const struct hda_channel_mode *chmode,
-			 int num_chmodes)
-{
-	uinfo->type = SNDRV_CTL_ELEM_TYPE_ENUMERATED;
-	uinfo->count = 1;
-	uinfo->value.enumerated.items = num_chmodes;
-	if (uinfo->value.enumerated.item >= num_chmodes)
-		uinfo->value.enumerated.item = num_chmodes - 1;
-	sprintf(uinfo->value.enumerated.name, "%dch",
-		chmode[uinfo->value.enumerated.item].channels);
-	return 0;
-}
-EXPORT_SYMBOL_GPL(snd_hda_ch_mode_info);
-
-/**
- * snd_hda_ch_mode_get - Get callback helper for the channel mode enum
- * @codec: the HDA codec
- * @ucontrol: pointer to get/store the data
- * @chmode: channel mode array
- * @num_chmodes: channel mode array size
- * @max_channels: max number of channels
- */
-int snd_hda_ch_mode_get(struct hda_codec *codec,
-			struct snd_ctl_elem_value *ucontrol,
-			const struct hda_channel_mode *chmode,
-			int num_chmodes,
-			int max_channels)
-{
-	int i;
-
-	for (i = 0; i < num_chmodes; i++) {
-		if (max_channels == chmode[i].channels) {
-			ucontrol->value.enumerated.item[0] = i;
-			break;
-		}
-	}
-	return 0;
-}
-EXPORT_SYMBOL_GPL(snd_hda_ch_mode_get);
-
-/**
- * snd_hda_ch_mode_put - Put callback helper for the channel mode enum
- * @codec: the HDA codec
- * @ucontrol: pointer to get/store the data
- * @chmode: channel mode array
- * @num_chmodes: channel mode array size
- * @max_channelsp: pointer to store the max channels
- */
-int snd_hda_ch_mode_put(struct hda_codec *codec,
-			struct snd_ctl_elem_value *ucontrol,
-			const struct hda_channel_mode *chmode,
-			int num_chmodes,
-			int *max_channelsp)
-{
-	unsigned int mode;
-
-	mode = ucontrol->value.enumerated.item[0];
-	if (mode >= num_chmodes)
-		return -EINVAL;
-	if (*max_channelsp == chmode[mode].channels)
-		return 0;
-	/* change the current channel setting */
-	*max_channelsp = chmode[mode].channels;
-	if (chmode[mode].sequence)
-		snd_hda_sequence_write_cache(codec, chmode[mode].sequence);
-	return 1;
-}
-EXPORT_SYMBOL_GPL(snd_hda_ch_mode_put);
-
-/*
  * input MUX helper
  */
 
diff --git a/sound/pci/hda/hda_local.h b/sound/pci/hda/hda_local.h
index 2f7d9646a41d..8588813163e3 100644
--- a/sound/pci/hda/hda_local.h
+++ b/sound/pci/hda/hda_local.h
@@ -273,29 +273,6 @@ int snd_hda_add_imux_item(struct hda_codec *codec,
 			  int index, int *type_index_ret);
 
 /*
- * Channel mode helper
- */
-struct hda_channel_mode {
-	int channels;
-	const struct hda_verb *sequence;
-};
-
-int snd_hda_ch_mode_info(struct hda_codec *codec,
-			 struct snd_ctl_elem_info *uinfo,
-			 const struct hda_channel_mode *chmode,
-			 int num_chmodes);
-int snd_hda_ch_mode_get(struct hda_codec *codec,
-			struct snd_ctl_elem_value *ucontrol,
-			const struct hda_channel_mode *chmode,
-			int num_chmodes,
-			int max_channels);
-int snd_hda_ch_mode_put(struct hda_codec *codec,
-			struct snd_ctl_elem_value *ucontrol,
-			const struct hda_channel_mode *chmode,
-			int num_chmodes,
-			int *max_channelsp);
-
-/*
  * Multi-channel / digital-out PCM helper
  */
 
-- 
2.3.0
