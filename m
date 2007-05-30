From: Timur Tabi <timur@freescale.com>
Subject: Re: ASoC and a codec that can't be controlled
Date: Wed, 30 May 2007 10:46:12 -0500
Message-ID: <465D9C44.5020902@freescale.com>
References: <46531097.5040600@freescale.com>	
	<1179934677.12071.30.camel@a10072.wolfsonmicro.main>	
	<46574453.10808@freescale.com>	
	<1180354247.5816.30.camel@a10072.wolfsonmicro.main>	
	<465CB19C.7080602@freescale.com>
	<1180530395.29590.57.camel@a10072.wolfsonmicro.main>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from az33egw01.freescale.net (az33egw01.freescale.net
	[192.88.158.102])
	by alsa0.perex.cz (Postfix) with ESMTP id D9A86244A1
	for <alsa-devel@alsa-project.org>;
	Wed, 30 May 2007 17:46:23 +0200 (CEST)
In-Reply-To: <1180530395.29590.57.camel@a10072.wolfsonmicro.main>
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

> Fwiw, you should be ok in the mean time as most audio data is stored on
> file in little endian format. Your media player should open such little
> endian files as *_LE when it configures the ALSA pcm. This should work
> if your I2S, DMA and codec are marked as supporting LE formats.

What about this snippet in asound.h:

#ifdef  __LITTLE_ENDIAN
#define SNDRV_LITTLE_ENDIAN
#else
#ifdef __BIG_ENDIAN
#define SNDRV_BIG_ENDIAN

...

#ifdef SNDRV_LITTLE_ENDIAN
#define	SNDRV_PCM_FORMAT_S16		SNDRV_PCM_FORMAT_S16_LE
#define	SNDRV_PCM_FORMAT_U16		SNDRV_PCM_FORMAT_U16_LE
#define	SNDRV_PCM_FORMAT_S24		SNDRV_PCM_FORMAT_S24_LE
...
#endif
#ifdef SNDRV_BIG_ENDIAN
#define	SNDRV_PCM_FORMAT_S16		SNDRV_PCM_FORMAT_S16_BE
#define	SNDRV_PCM_FORMAT_U16		SNDRV_PCM_FORMAT_U16_BE
#define	SNDRV_PCM_FORMAT_S24		SNDRV_PCM_FORMAT_S24_BE
...
#endif

I could then do this:

#define CS4270_FORMATS SNDRV_PCM_FMTBIT_S24

On big-endian platforms like mine, CS4270_FORMATS will be SNDRV_PCM_FORMAT_S24_BE and on 
little-endian platforms it will be SNDRV_PCM_FORMAT_S24_LE.  Assuming the I2S registers 
are the same endian as the platform, will this work?

If not, then what about this:

#define CS4270_FORMATS (SNDRV_PCM_FMTBIT_S24_LE | SNDRV_PCM_FMTBIT_S24_BE)

That would tell ALSA that the CS4270 supports both formats, which isn't technically true, 
but it wouldn't matter because the I2S interface is what determines the actual 
"endianness" of the serial data.

-- 
Timur Tabi
Linux Kernel Developer @ Freescale
