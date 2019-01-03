From: Hans de Goede <hdegoede@redhat.com>
Subject: [PATCH 02/10] ASoC: es8316: Add DAC mono mix switch
	mixer control
Date: Thu,  3 Jan 2019 14:45:27 +0100
Message-ID: <20190103134535.13861-3-hdegoede@redhat.com>
References: <20190103134535.13861-1-hdegoede@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx1.redhat.com (mx1.redhat.com [209.132.183.28])
 by alsa0.perex.cz (Postfix) with ESMTP id 07CB5267BD2
 for <alsa-devel@alsa-project.org>; Thu,  3 Jan 2019 14:45:43 +0100 (CET)
In-Reply-To: <20190103134535.13861-1-hdegoede@redhat.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>, Liam Girdwood <liam.r.girdwood@linux.intel.com>, Mark Brown <broonie@kernel.org>
Cc: Hans de Goede <hdegoede@redhat.com>, alsa-devel@alsa-project.org, linux@endlessm.com, Daniel Drake <drake@endlessm.com>
List-Id: alsa-devel@alsa-project.org

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
