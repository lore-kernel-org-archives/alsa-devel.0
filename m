From: Maris <maris.rob@vdi.de>
Subject: inserting operations while in rate conversion
Date: Wed, 22 Apr 2009 20:17:48 +0200
Message-ID: <op.ussvry0i7fwl0e@rob-desktop.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail1.vdi-online.de (mail1.vdi-online.de [194.245.126.17])
	by alsa0.perex.cz (Postfix) with ESMTP id C57301037EE
	for <alsa-devel@alsa-project.org>;
	Wed, 22 Apr 2009 20:17:49 +0200 (CEST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

I'm running uClinux with ALSA in an Analog Devices' Blackfin CPU
environment.
Actually I'm checking possibilities in doing special things while ALSA is
going to do automatic rate conversion.

Specific description:
ADC is sampled with 32 or 64 ksps rate. The corresponding hardware driver
is specified to operate at one of these rates (which I'll specify later).
The application reads the ADC input stream at the output end of the ALSA
processing as a stream with a rate of 8 ksps. I need some information
about inside details of ALSA's automatic rate conversion (pointers to
appropriate information would be helpful).

What I want to do: insert a digital anti-aliasing filter algorithm which
limits the effective bandwidth of the ADC stream to 4 kHz prior to
actually have the rate converted.
Of course, I could also add the filter algorithm in the hardware device
driver - at the cost of not inherently being available as a hardware
independent algorithm.

Some detail info:
- ADC = AD73311 (speech codec). Basic drivers that allow e.g. arecord &
aplay are available.
- CPU: convergent DSP/microcontroller core @ 500 MHz and fixed point
processing.

Thanks for attention. BTW: this is my first dig into ALSA details...

Rob


Code snippet:
(currently only one rate is defined as a correspondence to the hardware
driver rate)

#define AD73311_RATES (SNDRV_PCM_RATE_8000  |	\
		      SNDRV_PCM_RATE_16000 |	\
		      SNDRV_PCM_RATE_32000 |	\
		      SNDRV_PCM_RATE_64000)

struct snd_soc_dai ad73311_dai = {
	.name = "AD73311",
	.playback = {
		.stream_name = "Playback",
		.channels_min = 1,
		.channels_max = 1,
		.rates = SNDRV_PCM_RATE_32000,
		.formats = SNDRV_PCM_FMTBIT_S16_LE, },
	.capture = {
		.stream_name = "Capture",
		.channels_min = 1,
		.channels_max = 1,
		.rates = SNDRV_PCM_RATE_32000,
		.formats = SNDRV_PCM_FMTBIT_S16_LE, },
};
EXPORT_SYMBOL_GPL(ad73311_dai);
