From: "Fischer, Christian" <fischerc@swissphone.de>
Subject: AW: [PATCH] ASoC: sgtl5000: fix powerup/down of micbias-voltage
Date: Thu, 11 Jan 2018 16:14:31 +0000
Message-ID: <DD64F087E8F0B540A1C9216D6716FFBDF9947CB6@defrsexc01.swissphone.de>
References: <1515660031-9183-1-git-send-email-fischerc@swissphone.de>
 <20180111150704.GC7834@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180111150704.GC7834@sirena.org.uk>
Content-Language: de-DE
Sender: linux-kernel-owner@vger.kernel.org
To: Mark Brown <broonie@kernel.org>
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, "lgirdwood@gmail.com" <lgirdwood@gmail.com>, "perex@perex.cz" <perex@perex.cz>, "tiwai@suse.com" <tiwai@suse.com>, "richard.leitner@skidata.com" <richard.leitner@skidata.com>, "fabio.estevam@nxp.com" <fabio.estevam@nxp.com>, "bhumirks@gmail.com" <bhumirks@gmail.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
List-Id: alsa-devel@alsa-project.org

Hi Mark,

Unfortunately, this was not the case with my tests.
The supply is switched off at the start of the driver, but when starting a recording not started.
The function "mic_bias_event" only consumes SND_SOC_DAPM_POST_PMU (0x02) and SND_SOC_DAPM_PRE_PMD (0x04).

I changed:
> SND_SOC_DAPM_SUPPLY("Mic Bias", SGTL5000_CHIP_MIC_CTRL, 8, 0, 
> mic_bias_event, SND_SOC_DAPM_POST_PMU | SND_SOC_DAPM_PRE_PMD),
to:
> SND_SOC_DAPM_SUPPLY("Mic Bias", SGTL5000_CHIP_MIC_CTRL, 8, 0, 
> mic_bias_event, 0xFF),
To receive all events.

And added this to "mic_bias_event":
> dev_info(codec->dev, "mic_bias_event event: %d\n", event);

At probing I got this:
sgtl5000 1-000a: mic_bias_event event: 128
sgtl5000 1-000a: mic_bias_event event: 4 --> /* before widget power down, this disables the mic-bias-resistor */
sgtl5000 1-000a: mic_bias_event event: 8 --> /* after widget power down */

Testing:
arecord -D "hw:0,1" -c 2 -f S16_LE -t wav test_recording.wav
Recording WAVE 'test_recording.wav' : Signed 16 bit Little Endian, Rate 8000 Hz, Stereo
==> no event was fired

With my patch included, at probing:
sgtl5000 1-000a: mic_bias_event event: 128
sgtl5000 1-000a: mic_bias_event event: 4 --> /* before widget power down, this disables the mic-bias-resistor */
sgtl5000 1-000a: mic_bias_event event: 8 --> /* after widget power down */

Testing:
arecord -D "hw:0,1" -c 2 -f S16_LE -t wav test_recording.wav
Recording WAVE 'test_recording.wav' : Signed 16 bit Little Endian, Rate 8000 Hz, Stereo
[   82.341376] sgtl5000 1-000a: mic_bias_event event: 1 --> /* before widget power up */
[   82.762701] sgtl5000 1-000a: mic_bias_event event: 2  --> /* after widget power up, this enables the supply */
^CAborted by signal Interrupt...
[   90.362685] sgtl5000 1-000a: mic_bias_event event: 4 --> /* before widget power down, this disables the mic-bias-resistor */
[   90.369561] sgtl5000 1-000a: mic_bias_event event: 8 --> /* after widget power down */
==> events are working

The disadvantage is that this is also done when playing audio:
aplay -D "hw:0,0" -c 2 -f S16_LE -t wav test_recording.wav
sgtl5000 1-000a: mic_bias_event event: 1
sgtl5000 1-000a: mic_bias_event event: 2
Playing WAVE 'test_recording.wav' : Signed 16 bit Little Endian, Rate 8000 Hz, Stereo
sgtl5000 1-000a: mic_bias_event event: 4
sgtl5000 1-000a: mic_bias_event event: 8

I'm not so into ALSA, maybe there is another way to set the event properly.

Kind regards,
Christian

-----Ursprüngliche Nachricht-----
Von: Mark Brown [mailto:broonie@kernel.org] 
Gesendet: Donnerstag, 11. Januar 2018 16:07
An: Fischer, Christian <fischerc@swissphone.de>
Cc: alsa-devel@alsa-project.org; lgirdwood@gmail.com; perex@perex.cz; tiwai@suse.com; richard.leitner@skidata.com; fabio.estevam@nxp.com; bhumirks@gmail.com; linux-kernel@vger.kernel.org
Betreff: Re: [PATCH] ASoC: sgtl5000: fix powerup/down of micbias-voltage

On Thu, Jan 11, 2018 at 09:40:31AM +0100, fischerc@swissphone.de wrote:

> The mic-bias-voltage should get powered up/down automatically.
> Added missing DAPM_PRE and DAPM_POST widgets to fire up the mic_bias_event function.

> +	SND_SOC_DAPM_PRE("MIC_BIAS_PRE", mic_bias_event),
> +	SND_SOC_DAPM_POST("MIC_BIAS_POST", mic_bias_event),

I don't understand what this is intended to do.  The mic_bias_event() callback is already hooked up to the Mic Bias supply widget, it should be invoked whenever the bias is turned on and off already?
