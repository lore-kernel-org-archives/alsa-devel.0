From: Takashi Iwai <tiwai@suse.de>
Subject: [PATCH 1/4] ASoC: rt5645: read jd1_1 status for jd
	detection
Date: Wed, 28 Jun 2017 14:49:36 +0200
Message-ID: <20170628124939.11696-2-tiwai@suse.de>
References: <20170628124939.11696-1-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx1.suse.de (mx2.suse.de [195.135.220.15])
 by alsa0.perex.cz (Postfix) with ESMTP id 2AF6B266B85
 for <alsa-devel@alsa-project.org>; Wed, 28 Jun 2017 14:49:41 +0200 (CEST)
In-Reply-To: <20170628124939.11696-1-tiwai@suse.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@kernel.org>
Cc: Oder Chiou <oder_chiou@realtek.com>, Bard Liao <bardliao@realtek.com>, alsa-devel@alsa-project.org, Hans de Goede <hdegoede@redhat.com>
List-Id: alsa-devel@alsa-project.org

From: Bard Liao <bardliao@realtek.com>

Read the jd status after invert control. The benefit is we don't need
to invert the reading jd status when jd invert is needed.

Signed-off-by: Bard Liao <bardliao@realtek.com>
Tested-by: Hans de Goede <hdegoede@redhat.com>
Signed-off-by: Takashi Iwai <tiwai@suse.de>
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
