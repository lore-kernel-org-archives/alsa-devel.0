From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: nau8825: fix jack type detection issue
	after resume" to the asoc tree
Date: Fri, 23 Jun 2017 13:04:00 +0100
Message-ID: <E1dONJg-0006Or-Bi@debutante>
References: <1498028390-10952-1-git-send-email-KCHSU0@nuvoton.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id AFC1D26748E
 for <alsa-devel@alsa-project.org>; Fri, 23 Jun 2017 14:04:17 +0200 (CEST)
In-Reply-To: <1498028390-10952-1-git-send-email-KCHSU0@nuvoton.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: John Hsu <supercraig0719@gmail.com>
Cc: alsa-devel@alsa-project.org, anatol.pomozov@gmail.com, benzh@chromium.org, John Hsu <KCHSU0@nuvoton.com>, lgirdwood@gmail.com, YHCHuang@nuvoton.com, mac.chiang@intel.com, broonie@kernel.org, CTLIN0@nuvoton.com, yong.zhi@intel.com, mhkuo@nuvoton.com
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: nau8825: fix jack type detection issue after resume

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

>From 8fe19795da1b9dea2353f016622842a2f163039e Mon Sep 17 00:00:00 2001
From: John Hsu <supercraig0719@gmail.com>
Date: Thu, 22 Jun 2017 11:21:01 +0800
Subject: [PATCH] ASoC: nau8825: fix jack type detection issue after resume

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
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/codecs/nau8825.c | 17 ++++++++++++++++-
 1 file changed, 16 insertions(+), 1 deletion(-)

diff --git a/sound/soc/codecs/nau8825.c b/sound/soc/codecs/nau8825.c
index c00b86dd80dc..503a6d8130b7 100644
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
2.13.1
