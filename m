From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
Subject: [PATCH 1/3] ALSA: echoaudio: purge contradictions
	between dimension matrix members and total number of members
Date: Fri,  1 Jul 2016 20:10:11 +0900
Message-ID: <1467371413-16895-2-git-send-email-o-takashi@sakamocchi.jp>
References: <1467371413-16895-1-git-send-email-o-takashi@sakamocchi.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp-proxy003.phy.lolipop.jp (smtp-proxy003.phy.lolipop.jp
 [157.7.104.44]) by alsa0.perex.cz (Postfix) with ESMTP id 481BA265338
 for <alsa-devel@alsa-project.org>; Fri,  1 Jul 2016 13:10:19 +0200 (CEST)
In-Reply-To: <1467371413-16895-1-git-send-email-o-takashi@sakamocchi.jp>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: clemens@ladisch.de, tiwai@suse.de
Cc: alsa-devel@alsa-project.org, ffado-devel@lists.sf.net
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
