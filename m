From: Ian Molton <ian@mnementh.co.uk>
Subject: [Patch] WM9705 tweak
Date: Mon, 19 Jan 2009 13:24:30 +0000
Message-ID: <49747F0E.6080600@mnementh.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mnementh.co.uk (mail.mnementh.co.uk [173.45.232.4])
	by alsa0.perex.cz (Postfix) with ESMTP id 6008F1037F0
	for <alsa-devel@alsa-project.org>; Mon, 19 Jan 2009 14:23:50 +0100 (CET)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: ALSA development <alsa-devel@alsa-project.org>, Takashi Iwai <tiwai@suse.de>, Mark Brown <broonie@sirena.org.uk>
List-Id: alsa-devel@alsa-project.org

Hi folks,

Just a little patch to make recording work properly on wm9705  (the mute 
is hidden on alsamixer otherwise. (that and the control was poorly named).

-Ian

 From 47fa5f6a17ff9a7e546c7fae84b0a9c0b97bc74d Mon Sep 17 00:00:00 2001
From: Ian Molton <ian@mnementh.co.uk>
Date: Mon, 19 Jan 2009 12:46:54 +0000
Subject: [PATCH] ASoC: codec: WM9705 Fix capture switch name

This patch fixes the acpture switch name so that it shows up in alsamixer.

Without this, its not possible to unmute the capture PGA.

Signed-off-by: Ian Molton <iann@mnementh.co.uk>
---
  sound/soc/codecs/wm9705.c |    4 ++--
  1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/sound/soc/codecs/wm9705.c b/sound/soc/codecs/wm9705.c
index cb26b6a..01bfd5d 100644
--- a/sound/soc/codecs/wm9705.c
+++ b/sound/soc/codecs/wm9705.c
@@ -57,8 +57,8 @@ static const struct snd_kcontrol_new 
wm9705_snd_ac97_controls[] = {
  	SOC_DOUBLE("CD Playback Volume", AC97_CD, 8, 0, 31, 1),
  	SOC_SINGLE("Mic Playback Volume", AC97_MIC, 0, 31, 1),
  	SOC_SINGLE("Mic 20dB Boost Switch", AC97_MIC, 6, 1, 0),
-	SOC_DOUBLE("PCM Capture Volume", AC97_REC_GAIN, 8, 0, 15, 0),
-	SOC_SINGLE("PCM Capture Switch", AC97_REC_GAIN, 15, 1, 1),
+	SOC_DOUBLE("Capture Volume", AC97_REC_GAIN, 8, 0, 15, 0),
+	SOC_SINGLE("Capture ADC Switch", AC97_REC_GAIN, 15, 1, 1),
  };

  static const char *wm9705_mic[] = {"Mic 1", "Mic 2"};
-- 
1.5.6.5
