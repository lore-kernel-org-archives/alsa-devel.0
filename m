From: Ian Molton <ian@mnementh.co.uk>
Subject: Re: [Patch] WM9705 tweak
Date: Mon, 19 Jan 2009 17:23:11 +0000
Message-ID: <4974B6FF.6000900@mnementh.co.uk>
References: <49747F0E.6080600@mnementh.co.uk>
	<20090119133656.GB22473@sirena.org.uk>
	<49749D2C.3010003@mnementh.co.uk>
	<20090119155534.GC22473@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mnementh.co.uk (mail.mnementh.co.uk [173.45.232.4])
	by alsa0.perex.cz (Postfix) with ESMTP id 8261724396
	for <alsa-devel@alsa-project.org>; Mon, 19 Jan 2009 18:23:25 +0100 (CET)
In-Reply-To: <20090119155534.GC22473@sirena.org.uk>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@sirena.org.uk>
Cc: Takashi Iwai <tiwai@suse.de>, ALSA development <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

Mark Brown wrote:

> I'm testing this with the WM9713 (which has "Capture Volume" and
> "Capture Switch") and the control is visible.  It is presented
> differently (as a capture facility switch which is toggled using space
> rather than as a mute) but it's there.

Quite correct.  I just checked and it works as you say. I never knew 
alsamixer behaved like that. How unintuitive!

Would this patch be acceptable this late in the game? The control is 
still not very well named, despite not being broken :-)

-Ian

 From 3781e5184da68791d16e7403c748d9e39a68a565 Mon Sep 17 00:00:00 2001
From: Ian Molton <ian@mnementh.co.uk>
Date: Mon, 19 Jan 2009 12:46:54 +0000
Subject: [PATCH] ASoC: codec: WM9705 Fix capture switch name

This patch fixes the acpture switch name so that it better reflects its 
purpose.

Signed-off-by: Ian Molton <iann@mnementh.co.uk>
---
  sound/soc/codecs/wm9705.c |    4 ++--
  1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/sound/soc/codecs/wm9705.c b/sound/soc/codecs/wm9705.c
index cb26b6a..5e1937a 100644
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
+	SOC_SINGLE("Capture Switch", AC97_REC_GAIN, 15, 1, 1),
  };

  static const char *wm9705_mic[] = {"Mic 1", "Mic 2"};
-- 
1.5.6.5
