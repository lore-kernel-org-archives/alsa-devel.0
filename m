From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: rt5645: read jd1_1 status for jd
	detection" to the asoc tree
Date: Wed, 28 Jun 2017 20:24:16 +0100
Message-ID: <E1dQIZU-0004PX-6w@finisterre>
References: <20170628124939.11696-2-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 32B8A2671E8
 for <alsa-devel@alsa-project.org>; Wed, 28 Jun 2017 21:24:27 +0200 (CEST)
In-Reply-To: <20170628124939.11696-2-tiwai@suse.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Bard Liao <bardliao@realtek.com>
Cc: Takashi Iwai <tiwai@suse.de>, Hans de Goede <hdegoede@redhat.com>, Oder Chiou <oder_chiou@realtek.com>, Mark Brown <broonie@kernel.org>, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: rt5645: read jd1_1 status for jd detection

has been applied to the asoc tree at

   git://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git 

All being well this means that it will be integrated into the linux-next
tree (usually sometime in the next 24 hours) and sent to Linus during
the next merge window (or sooner if it is a bug fix), however if
problems are discovered then the patch may be dropped or reverted.  

You may get further e-mails resulting from automated or manual testing
and review of the tree, please engage with people reporting problems and
send followup patches addressing any issues that are reported if needed.

If any updates are required or you are submitting further changes they
should be sent as incremental updates against current git, existing
patches will not be replaced.

Please add any relevant lists and maintainers to the CCs when replying
to this mail.

Thanks,
Mark

>From 6b5da66322c50b4fa22f9343dcb968496f831361 Mon Sep 17 00:00:00 2001
From: Bard Liao <bardliao@realtek.com>
Date: Wed, 28 Jun 2017 14:49:36 +0200
Subject: [PATCH] ASoC: rt5645: read jd1_1 status for jd detection

Read the jd status after invert control. The benefit is we don't need
to invert the reading jd status when jd invert is needed.

Signed-off-by: Bard Liao <bardliao@realtek.com>
Tested-by: Hans de Goede <hdegoede@redhat.com>
Signed-off-by: Takashi Iwai <tiwai@suse.de>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/codecs/rt5645.c | 31 ++++++++-----------------------
 1 file changed, 8 insertions(+), 23 deletions(-)

diff --git a/sound/soc/codecs/rt5645.c b/sound/soc/codecs/rt5645.c
index 87844a45886a..8e419ea418e9 100644
--- a/sound/soc/codecs/rt5645.c
+++ b/sound/soc/codecs/rt5645.c
@@ -3238,24 +3238,16 @@ static void rt5645_jack_detect_work(struct work_struct *work)
 		snd_soc_jack_report(rt5645->mic_jack,
 				    report, SND_JACK_MICROPHONE);
 		return;
-	case 1: /* 2 port */
-		val = snd_soc_read(rt5645->codec, RT5645_A_JD_CTRL1) & 0x0070;
-		break;
-	default: /* 1 port */
-		val = snd_soc_read(rt5645->codec, RT5645_A_JD_CTRL1) & 0x0020;
+	default: /* read rt5645 jd1_1 status */
+		val = snd_soc_read(rt5645->codec, RT5645_INT_IRQ_ST) & 0x1000;
 		break;
 
 	}
 
-	switch (val) {
-	/* jack in */
-	case 0x30: /* 2 port */
-	case 0x0: /* 1 port or 2 port */
-		if (rt5645->jack_type == 0) {
-			report = rt5645_jack_detect(rt5645->codec, 1);
-			/* for push button and jack out */
-			break;
-		}
+	if (!val && (rt5645->jack_type == 0)) { /* jack in */
+		report = rt5645_jack_detect(rt5645->codec, 1);
+	} else if (!val && rt5645->jack_type != 0) {
+		/* for push button and jack out */
 		btn_type = 0;
 		if (snd_soc_read(rt5645->codec, RT5645_INT_IRQ_ST) & 0x4) {
 			/* button pressed */
@@ -3302,19 +3294,12 @@ static void rt5645_jack_detect_work(struct work_struct *work)
 			mod_timer(&rt5645->btn_check_timer,
 				msecs_to_jiffies(100));
 		}
-
-		break;
-	/* jack out */
-	case 0x70: /* 2 port */
-	case 0x10: /* 2 port */
-	case 0x20: /* 1 port */
+	} else {
+		/* jack out */
 		report = 0;
 		snd_soc_update_bits(rt5645->codec,
 				    RT5645_INT_IRQ_ST, 0x1, 0x0);
 		rt5645_jack_detect(rt5645->codec, 0);
-		break;
-	default:
-		break;
 	}
 
 	snd_soc_jack_report(rt5645->hp_jack, report, SND_JACK_HEADPHONE);
-- 
2.13.2
