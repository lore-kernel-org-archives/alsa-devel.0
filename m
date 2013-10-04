From: Anssi Hannula <anssi.hannula@iki.fi>
Subject: [PATCH 6/7] ALSA: hda - hdmi: Fix available channel
	maps missing from TLV
Date: Sat,  5 Oct 2013 02:25:43 +0300
Message-ID: <1380929144-24944-7-git-send-email-anssi.hannula@iki.fi>
References: <1380929144-24944-1-git-send-email-anssi.hannula@iki.fi>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from sinikuusama.dnainternet.net (sinikuusama.dnainternet.net
 [83.102.40.134])
 by alsa0.perex.cz (Postfix) with ESMTP id E3F7A2617A6
 for <alsa-devel@alsa-project.org>; Sat,  5 Oct 2013 01:26:20 +0200 (CEST)
In-Reply-To: <1380929144-24944-1-git-send-email-anssi.hannula@iki.fi>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Currently the available channel maps TLV only contains channel maps that
are limited to the traditional 7.1 speakers.

Since the other HDMI channel mapping functions have been fixed to
properly handle all CEA-861-E specified speakers, allow them to be
listed.

Signed-off-by: Anssi Hannula <anssi.hannula@iki.fi>
---

Unless there was another reason for this?


 sound/pci/hda/patch_hdmi.c | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/sound/pci/hda/patch_hdmi.c b/sound/pci/hda/patch_hdmi.c
index 3c89e48..9f2c396 100644
--- a/sound/pci/hda/patch_hdmi.c
+++ b/sound/pci/hda/patch_hdmi.c
@@ -1666,8 +1666,6 @@ static int hdmi_chmap_ctl_tlv(struct snd_kcontrol *kcontrol, int op_flag,
 	struct snd_pcm_chmap *info = snd_kcontrol_chip(kcontrol);
 	struct hda_codec *codec = info->private_data;
 	struct hdmi_spec *spec = codec->spec;
-	const unsigned int valid_mask =
-		FL | FR | RL | RR | LFE | FC | RLC | RRC;
 	unsigned int __user *dst;
 	int chs, count = 0;
 
@@ -1685,8 +1683,6 @@ static int hdmi_chmap_ctl_tlv(struct snd_kcontrol *kcontrol, int op_flag,
 			int chs_bytes = chs * 4;
 			if (cap->channels != chs)
 				continue;
-			if (cap->spk_mask & ~valid_mask)
-				continue;
 			if (size < 8)
 				return -ENOMEM;
 			if (put_user(SNDRV_CTL_TLVT_CHMAP_VAR, dst) ||
-- 
1.8.1.5
