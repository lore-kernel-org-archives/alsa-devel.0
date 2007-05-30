From: Liam Girdwood <lg@opensource.wolfsonmicro.com>
Subject: Re: ASoC and a codec that can't be controlled
Date: Wed, 30 May 2007 14:06:35 +0100
Message-ID: <1180530395.29590.57.camel@a10072.wolfsonmicro.main>
References: <46531097.5040600@freescale.com>
	<1179934677.12071.30.camel@a10072.wolfsonmicro.main>
	<46574453.10808@freescale.com>
	<1180354247.5816.30.camel@a10072.wolfsonmicro.main>
	<465CB19C.7080602@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource.wolfsonmicro.com (unknown [80.75.67.54])
	by alsa0.perex.cz (Postfix) with ESMTP id 907572446E
	for <alsa-devel@alsa-project.org>;
	Wed, 30 May 2007 15:06:36 +0200 (CEST)
In-Reply-To: <465CB19C.7080602@freescale.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Timur Tabi <timur@freescale.com>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On Tue, 2007-05-29 at 18:05 -0500, Timur Tabi wrote:
> Liam Girdwood wrote:
> 
> > Yes, although my feeling is that a codec "driver" would still be needed
> > to define the capabilities of your codec within the audio subsystem.
> 
> Ok, I just noticed this:
> 
> at91-i2s.c:
> 
> #define AT91_I2S_RATES (SNDRV_PCM_RATE_8000  | SNDRV_PCM_RATE_11025 |\
> 			SNDRV_PCM_RATE_16000 | SNDRV_PCM_RATE_22050 |\
> 			SNDRV_PCM_RATE_32000 | SNDRV_PCM_RATE_44100 |\
> 			SNDRV_PCM_RATE_48000 | SNDRV_PCM_RATE_88200 |\
> 			SNDRV_PCM_RATE_96000)
> 
> struct snd_soc_cpu_dai at91_i2s_dai[NUM_SSC_DEVICES] = {
> 	{	.name = "at91_ssc0/i2s",
> 		.id = 0,
> 		.type = SND_SOC_DAI_I2S,
> 		.suspend = at91_i2s_suspend,
> 		.resume = at91_i2s_resume,
> 		.playback = {
> 			.channels_min = 1,
> 			.channels_max = 2,
> 			.rates = AT91_I2S_RATES,
> 			.formats = SNDRV_PCM_FMTBIT_S16_LE,},
> 		.capture = {
> 			.channels_min = 1,
> 			.channels_max = 2,
> 			.rates = AT91_I2S_RATES,
> 			.formats = SNDRV_PCM_FMTBIT_S16_LE,},
> 
> wm8731.c:
> 
> #define WM8731_RATES (SNDRV_PCM_RATE_8000 | SNDRV_PCM_RATE_11025 |\
> 		SNDRV_PCM_RATE_16000 | SNDRV_PCM_RATE_22050 |\
> 		SNDRV_PCM_RATE_32000 | SNDRV_PCM_RATE_44100 |\
> 		SNDRV_PCM_RATE_48000 | SNDRV_PCM_RATE_88200 |\
> 		SNDRV_PCM_RATE_96000)
> 
> #define WM8731_FORMATS (SNDRV_PCM_FMTBIT_S16_LE | SNDRV_PCM_FMTBIT_S20_3LE |\
> 	SNDRV_PCM_FMTBIT_S24_LE)
> 
> struct snd_soc_codec_dai wm8731_dai = {
> 	.name = "WM8731",
> 	.playback = {
> 		.stream_name = "Playback",
> 		.channels_min = 1,
> 		.channels_max = 2,
> 		.rates = WM8731_RATES,
> 		.formats = WM8731_FORMATS,},
> 	.capture = {
> 		.stream_name = "Capture",
> 		.channels_min = 1,
> 		.channels_max = 2,
> 		.rates = WM8731_RATES,
> 		.formats = WM8731_FORMATS,},
> 
> So does this mean that ALSA looks at the rate and format capabilities of the I2S interface 
> and the codec, and then only chooses ones that both support?
> 

Yes.

> Also, what does it mean for the codec to support little-endian?  On PowerPC, all registers 
> are big-endian, so my version of at91-i2s.c has to have SNDRV_PCM_FMTBIT_S24_BE.
> 
> Your codec driver says it's little-endian.  But the I2S standard is serial, so endianness 
> doesn't apply.  Yet if I say the codec is little-endian, but the I2S interface is 
> big-endian, how can ALSA resolve that?
> 

This was added as some controllers and codecs can shift out data in
different formats (e.g. LSB or MSB first). It's only really used atm for
data size (e.g. 16, 24 bits) as the endianess is currently not dealt
with correctly. I've logged bug :-

https://bugtrack.alsa-project.org/alsa-bug/view.php?id=3132

Fwiw, you should be ok in the mean time as most audio data is stored on
file in little endian format. Your media player should open such little
endian files as *_LE when it configures the ALSA pcm. This should work
if your I2S, DMA and codec are marked as supporting LE formats.

Liam
