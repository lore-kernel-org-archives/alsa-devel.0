From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
Subject: [PATCH v2] ALSA: echoaudio: purge contradictions
	between dimension matrix members and total number of members
Date: Sat, 16 Jul 2016 22:24:32 +0900
Message-ID: <1468675472-32282-1-git-send-email-o-takashi@sakamocchi.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp-proxy004.phy.lolipop.jp (smtp-proxy004.phy.lolipop.jp
 [157.7.104.45]) by alsa0.perex.cz (Postfix) with ESMTP id 6FE9026509E
 for <alsa-devel@alsa-project.org>; Sat, 16 Jul 2016 15:24:37 +0200 (CEST)
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
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Currently, sound device drivers for PCI cards produced by Echo Audio
support dimension parameter of element information. But the information
has contradictions to the number of members of each element. I guess that
this comes from the assumption that these sound cards are used only by
'echomixer' in userspace. But ideally, they should be used with usual ALSA
control applications.

This commit removes the contradiction. As a result, 'Monitor Mixer Volume'
and 'VMixer Volume' elements are shown in usual ALSA control applications
such as 'amixer' and 'alsamixer' in series.

Signed-off-by: Takashi Sakamoto <o-takashi@sakamocchi.jp>
---
 sound/pci/echoaudio/echoaudio.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/sound/pci/echoaudio/echoaudio.c b/sound/pci/echoaudio/echoaudio.c
index 1cb85ae..3a8e8d5 100644
--- a/sound/pci/echoaudio/echoaudio.c
+++ b/sound/pci/echoaudio/echoaudio.c
@@ -1272,11 +1272,11 @@ static int snd_echo_mixer_info(struct snd_kcontrol *kcontrol,
 
 	chip = snd_kcontrol_chip(kcontrol);
 	uinfo->type = SNDRV_CTL_ELEM_TYPE_INTEGER;
-	uinfo->count = 1;
 	uinfo->value.integer.min = ECHOGAIN_MINOUT;
 	uinfo->value.integer.max = ECHOGAIN_MAXOUT;
 	uinfo->dimen.d[0] = num_busses_out(chip);
 	uinfo->dimen.d[1] = num_busses_in(chip);
+	uinfo->count = uinfo->dimen.d[0] * uinfo->dimen.d[1];
 	return 0;
 }
 
@@ -1344,11 +1344,11 @@ static int snd_echo_vmixer_info(struct snd_kcontrol *kcontrol,
 
 	chip = snd_kcontrol_chip(kcontrol);
 	uinfo->type = SNDRV_CTL_ELEM_TYPE_INTEGER;
-	uinfo->count = 1;
 	uinfo->value.integer.min = ECHOGAIN_MINOUT;
 	uinfo->value.integer.max = ECHOGAIN_MAXOUT;
 	uinfo->dimen.d[0] = num_busses_out(chip);
 	uinfo->dimen.d[1] = num_pipes_out(chip);
+	uinfo->count = uinfo->dimen.d[0] * uinfo->dimen.d[1];
 	return 0;
 }
 
@@ -1728,7 +1728,6 @@ static int snd_echo_vumeters_info(struct snd_kcontrol *kcontrol,
 				  struct snd_ctl_elem_info *uinfo)
 {
 	uinfo->type = SNDRV_CTL_ELEM_TYPE_INTEGER;
-	uinfo->count = 96;
 	uinfo->value.integer.min = ECHOGAIN_MINOUT;
 	uinfo->value.integer.max = 0;
 #ifdef ECHOCARD_HAS_VMIXER
@@ -1738,6 +1737,7 @@ static int snd_echo_vumeters_info(struct snd_kcontrol *kcontrol,
 #endif
 	uinfo->dimen.d[1] = 16;	/* 16 channels */
 	uinfo->dimen.d[2] = 2;	/* 0=level, 1=peak */
+	uinfo->count = uinfo->dimen.d[0] * uinfo->dimen.d[1] * uinfo->dimen.d[2];
 	return 0;
 }
 
-- 
2.7.4
