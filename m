From: Timur Tabi <timur@freescale.com>
Subject: Re: ASoC and a codec that can't be controlled
Date: Tue, 29 May 2007 18:05:00 -0500
Message-ID: <465CB19C.7080602@freescale.com>
References: <46531097.5040600@freescale.com>	
	<1179934677.12071.30.camel@a10072.wolfsonmicro.main>	
	<46574453.10808@freescale.com>
	<1180354247.5816.30.camel@a10072.wolfsonmicro.main>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from de01egw02.freescale.net (de01egw02.freescale.net
	[192.88.165.103])
	by alsa0.perex.cz (Postfix) with ESMTP id 53D00243A4
	for <alsa-devel@alsa-project.org>;
	Wed, 30 May 2007 01:05:08 +0200 (CEST)
In-Reply-To: <1180354247.5816.30.camel@a10072.wolfsonmicro.main>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Liam Girdwood <lg@opensource.wolfsonmicro.com>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Liam Girdwood wrote:

> Yes, although my feeling is that a codec "driver" would still be needed
> to define the capabilities of your codec within the audio subsystem.

Ok, I just noticed this:

at91-i2s.c:

#define AT91_I2S_RATES (SNDRV_PCM_RATE_8000  | SNDRV_PCM_RATE_11025 |\
			SNDRV_PCM_RATE_16000 | SNDRV_PCM_RATE_22050 |\
			SNDRV_PCM_RATE_32000 | SNDRV_PCM_RATE_44100 |\
			SNDRV_PCM_RATE_48000 | SNDRV_PCM_RATE_88200 |\
			SNDRV_PCM_RATE_96000)

struct snd_soc_cpu_dai at91_i2s_dai[NUM_SSC_DEVICES] = {
	{	.name = "at91_ssc0/i2s",
		.id = 0,
		.type = SND_SOC_DAI_I2S,
		.suspend = at91_i2s_suspend,
		.resume = at91_i2s_resume,
		.playback = {
			.channels_min = 1,
			.channels_max = 2,
			.rates = AT91_I2S_RATES,
			.formats = SNDRV_PCM_FMTBIT_S16_LE,},
		.capture = {
			.channels_min = 1,
			.channels_max = 2,
			.rates = AT91_I2S_RATES,
			.formats = SNDRV_PCM_FMTBIT_S16_LE,},

wm8731.c:

#define WM8731_RATES (SNDRV_PCM_RATE_8000 | SNDRV_PCM_RATE_11025 |\
		SNDRV_PCM_RATE_16000 | SNDRV_PCM_RATE_22050 |\
		SNDRV_PCM_RATE_32000 | SNDRV_PCM_RATE_44100 |\
		SNDRV_PCM_RATE_48000 | SNDRV_PCM_RATE_88200 |\
		SNDRV_PCM_RATE_96000)

#define WM8731_FORMATS (SNDRV_PCM_FMTBIT_S16_LE | SNDRV_PCM_FMTBIT_S20_3LE |\
	SNDRV_PCM_FMTBIT_S24_LE)

struct snd_soc_codec_dai wm8731_dai = {
	.name = "WM8731",
	.playback = {
		.stream_name = "Playback",
		.channels_min = 1,
		.channels_max = 2,
		.rates = WM8731_RATES,
		.formats = WM8731_FORMATS,},
	.capture = {
		.stream_name = "Capture",
		.channels_min = 1,
		.channels_max = 2,
		.rates = WM8731_RATES,
		.formats = WM8731_FORMATS,},

So does this mean that ALSA looks at the rate and format capabilities of the I2S interface 
and the codec, and then only chooses ones that both support?

Also, what does it mean for the codec to support little-endian?  On PowerPC, all registers 
are big-endian, so my version of at91-i2s.c has to have SNDRV_PCM_FMTBIT_S24_BE.

Your codec driver says it's little-endian.  But the I2S standard is serial, so endianness 
doesn't apply.  Yet if I say the codec is little-endian, but the I2S interface is 
big-endian, how can ALSA resolve that?

-- 
Timur Tabi
Linux Kernel Developer @ Freescale
