From: Timur Tabi <timur@freescale.com>
Subject: Re: ASoC and a codec that can't be controlled
Date: Thu, 31 May 2007 13:55:27 -0500
Message-ID: <465F1A1F.6070009@freescale.com>
References: <46531097.5040600@freescale.com>	
	<1179934677.12071.30.camel@a10072.wolfsonmicro.main>	
	<46574453.10808@freescale.com>	
	<1180354247.5816.30.camel@a10072.wolfsonmicro.main>	
	<465CB19C.7080602@freescale.com>	
	<1180530395.29590.57.camel@a10072.wolfsonmicro.main>	
	<465D9C44.5020902@freescale.com>
	<1180632733.29590.115.camel@a10072.wolfsonmicro.main>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from de01egw01.freescale.net (de01egw01.freescale.net
	[192.88.165.102])
	by alsa0.perex.cz (Postfix) with ESMTP id 36487245E9
	for <alsa-devel@alsa-project.org>;
	Thu, 31 May 2007 20:55:35 +0200 (CEST)
In-Reply-To: <1180632733.29590.115.camel@a10072.wolfsonmicro.main>
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

>> On big-endian platforms like mine, CS4270_FORMATS will be SNDRV_PCM_FORMAT_S24_BE and on 
>> little-endian platforms it will be SNDRV_PCM_FORMAT_S24_LE.  Assuming the I2S registers 
>> are the same endian as the platform, will this work?
>>
> 
> I think this probably depends on how your audio FIFO's align the data
> received from memory/DMA.  They should do any bit reordering based on
> the audio format, and size etc set in the control register. (Although,
> ymmv.)

Ok, I'm a little confused.  I was going to specify the SNDRV_PCM_FORMAT_S24_BE for my I2C 
device because the actual 32-bit memory-mapped registers are big-endian.  The structure 
definition even uses __be32 for each field.

My goal was to specify a single value (i.e. SNDRV_PCM_FORMAT_S24_BE) such that ALSA would 
give me a 32-bit quantity that exactly matches what my device expects.

I wish asound.h had more documentation.  I don't know what any of these macros *really* mean.

>> #define CS4270_FORMATS (SNDRV_PCM_FMTBIT_S24_LE | SNDRV_PCM_FMTBIT_S24_BE)
>>
>> That would tell ALSA that the CS4270 supports both formats, which isn't technically true, 
>> but it wouldn't matter because the I2S interface is what determines the actual 
>> "endianness" of the serial data.
> 
> This looks fine as a workaround atm, I'll try and have a look at this
> bug tomorrow so we don't need to do this.

Ok, I'll do this for now.



-- 
Timur Tabi
Linux Kernel Developer @ Freescale
