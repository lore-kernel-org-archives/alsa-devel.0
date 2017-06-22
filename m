From: John Hsu <supercraig0719@gmail.com>
Subject: [PATCH] ASoC: nau8825: fix jack type detection issue
	after resume
Date: Thu, 22 Jun 2017 11:21:01 +0800
Message-ID: <1498101661-8951-1-git-send-email-KCHSU0@nuvoton.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-pg0-f67.google.com (mail-pg0-f67.google.com [74.125.83.67])
 by alsa0.perex.cz (Postfix) with ESMTP id 666FA2664EB
 for <alsa-devel@alsa-project.org>; Thu, 22 Jun 2017 05:21:14 +0200 (CEST)
Received: by mail-pg0-f67.google.com with SMTP id u62so730666pgb.0
 for <alsa-devel@alsa-project.org>; Wed, 21 Jun 2017 20:21:13 -0700 (PDT)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: broonie@kernel.org
Cc: alsa-devel@alsa-project.org, anatol.pomozov@gmail.com, YHCHuang@nuvoton.com, John Hsu <KCHSU0@nuvoton.com>, lgirdwood@gmail.com, benzh@chromium.org, mac.chiang@intel.com, CTLIN0@nuvoton.com, mhkuo@nuvoton.com, John Hsu <supercraig0719@gmail.com>, yong.zhi@intel.com
List-Id: alsa-devel@alsa-project.org

Fix the issue that mic type detection error after resume.
The microphone type detection procedure will recognize
testing signal on JKSLV pin, but before the procedure,
JKSLV already had supply voltage, that results in the failure.
Therefore, the patch turns off the power and reset the jack type
configuration before suspend. Then redo the jack detection
procedure after resume.

The patch help to fix the issue as follows:
Google issue 37973093: CTIA/OMTP jack type detection failure after resume
Reported Issue
Chrome OS Version  :  ChromeOS R59-9460.13.0
Type of hardware   :  DVT sample

What steps will reproduce the problem?
(1 Play a music
(2 Insert a headphones 
(3 Close laptop lid 3 sec then open it
What is the expected output?
The music is normal in the headphones.
What do you see instead?
Singer voice in the music is not clear.

How frequently does this problem reproduce?
Always

What is the impact to the user, and is there a workaround?
If so, what is it?
Re-insert the headset or close the laptop lid and
then open it again can be repaired.

Signed-off-by: John Hsu <KCHSU0@nuvoton.com>
Signed-off-by: John Hsu <supercraig0719@gmail.com>
---
 sound/soc/codecs/nau8825.c | 17 ++++++++++++++++-
 1 file changed, 16 insertions(+), 1 deletion(-)

diff --git a/sound/soc/codecs/nau8825.c b/sound/soc/codecs/nau8825.c
index 588805c..a8c7a55 100644
--- a/sound/soc/codecs/nau8825.c
+++ b/sound/soc/codecs/nau8825.c
@@ -1612,7 +1612,6 @@ static int nau8825_jack_insert(struct nau8825 *nau8825)
 		snd_soc_dapm_sync(dapm);
 		break;
 	case 2:
-	case 3:
 		dev_dbg(nau8825->dev, "CTIA (micgnd2) mic connected\n");
 		type = SND_JACK_HEADSET;
 
@@ -1632,6 +1631,11 @@ static int nau8825_jack_insert(struct nau8825 *nau8825)
 		snd_soc_dapm_force_enable_pin(dapm, "SAR");
 		snd_soc_dapm_sync(dapm);
 		break;
+	case 3:
+		/* detect error case */
+		dev_err(nau8825->dev, "detection error; disable mic function\n");
+		type = SND_JACK_HEADPHONE;
+		break;
 	}
 
 	/* Leaving HPOL/R grounded after jack insert by default. They will be
@@ -2328,6 +2332,13 @@ static int nau8825_set_bias_level(struct snd_soc_codec *codec,
 		break;
 
 	case SND_SOC_BIAS_OFF:
+		/* Reset the configuration of jack type for detection */
+		/* Detach 2kOhm Resistors from MICBIAS to MICGND1/2 */
+		regmap_update_bits(nau8825->regmap, NAU8825_REG_MIC_BIAS,
+			NAU8825_MICBIAS_JKSLV | NAU8825_MICBIAS_JKR2, 0);
+		/* ground HPL/HPR, MICGRND1/2 */
+		regmap_update_bits(nau8825->regmap,
+			NAU8825_REG_HSD_CTRL, 0xf, 0xf);
 		/* Cancel and reset cross talk detection funciton */
 		nau8825_xtalk_cancel(nau8825);
 		/* Turn off all interruptions before system shutdown. Keep the
@@ -2351,6 +2362,10 @@ static int __maybe_unused nau8825_suspend(struct snd_soc_codec *codec)
 
 	disable_irq(nau8825->irq);
 	snd_soc_codec_force_bias_level(codec, SND_SOC_BIAS_OFF);
+	/* Power down codec power; don't suppoet button wakeup */
+	snd_soc_dapm_disable_pin(nau8825->dapm, "SAR");
+	snd_soc_dapm_disable_pin(nau8825->dapm, "MICBIAS");
+	snd_soc_dapm_sync(nau8825->dapm);
 	regcache_cache_only(nau8825->regmap, true);
 	regcache_mark_dirty(nau8825->regmap);
 
-- 
2.6.4
