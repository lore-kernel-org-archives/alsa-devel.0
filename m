From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: es8316: Add DAC mono mix switch mixer
	control" to the asoc tree
Date: Fri,  4 Jan 2019 17:09:01 +0000 (GMT)
Message-ID: <20190104170901.1639811270A3@debutante.sirena.org.uk>
References: <20190103134535.13861-3-hdegoede@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [172.104.155.198])
 by alsa0.perex.cz (Postfix) with ESMTP id 0ECDD267CB6
 for <alsa-devel@alsa-project.org>; Fri,  4 Jan 2019 18:09:02 +0100 (CET)
In-Reply-To: <20190103134535.13861-3-hdegoede@redhat.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Hans de Goede <hdegoede@redhat.com>
Cc: alsa-devel@alsa-project.org, Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>, Daniel Drake <drake@endlessm.com>, Liam Girdwood <liam.r.girdwood@linux.intel.com>, Mark Brown <broonie@kernel.org>, linux@endlessm.com
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: es8316: Add DAC mono mix switch mixer control

has been applied to the asoc tree at

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git 

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

>From 24b53f17a3f24967b8b523243f9f7fc361427119 Mon Sep 17 00:00:00 2001
From: Hans de Goede <hdegoede@redhat.com>
Date: Thu, 3 Jan 2019 14:45:27 +0100
Subject: [PATCH] ASoC: es8316: Add DAC mono mix switch mixer control

Export the DAC functionality to mix left + right together and then output
the same (mixed) signal on both outputs.

Various (x86) tablets with an ES8316 codec use a single speaker
connected between the headhpone LOUT and ROUT pins, expecting the output
to be in a mono differential mode. Presumably this is done to use the
power of both the left and right outputs to allow the speaker to be
louder.

The ES8316 codec does not have a differential output mode, but we can
emulate this by making both channels output the same through the mono mix
switch, combined with setting the Playback Polarity control to "R Invert",
which applias a 180 degrees phase inversion to the right channel.

Signed-off-by: Hans de Goede <hdegoede@redhat.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/codecs/es8316.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/sound/soc/codecs/es8316.c b/sound/soc/codecs/es8316.c
index 26413851e434..98464ba1046c 100644
--- a/sound/soc/codecs/es8316.c
+++ b/sound/soc/codecs/es8316.c
@@ -101,6 +101,7 @@ static const struct snd_kcontrol_new es8316_snd_controls[] = {
 	SOC_SINGLE("DAC Notch Filter Switch", ES8316_DAC_SET2, 6, 1, 0),
 	SOC_SINGLE("DAC Double Fs Switch", ES8316_DAC_SET2, 7, 1, 0),
 	SOC_SINGLE("DAC Stereo Enhancement", ES8316_DAC_SET3, 0, 7, 0),
+	SOC_SINGLE("DAC Mono Mix Switch", ES8316_DAC_SET3, 3, 1, 0),
 
 	SOC_ENUM("Capture Polarity", adcpol),
 	SOC_SINGLE("Mic Boost Switch", ES8316_ADC_D2SEPGA, 0, 1, 0),
-- 
2.20.1
