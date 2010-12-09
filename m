From: Alexander <subaparts@yandex.ru>
Subject: Re: [PATCH 1/3] ASoC: EP93xx I2S and PCM fixes
Date: Thu, 09 Dec 2010 03:37:31 +0300
Message-ID: <1291855051.31916.85.camel@r60e>
References: <1291809693.31916.2.camel@r60e>
	<20101208124637.GD16418@rakim.wolfsonmicro.main>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from forward11.mail.yandex.net (forward11.mail.yandex.net
	[95.108.130.93])
	by alsa0.perex.cz (Postfix) with ESMTP id 043E5103B7D
	for <alsa-devel@alsa-project.org>; Thu,  9 Dec 2010 01:37:38 +0100 (CET)
In-Reply-To: <20101208124637.GD16418@rakim.wolfsonmicro.main>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@opensource.wolfsonmicro.com>
Cc: alsa-devel@alsa-project.org, ryan@bluewatersys.com, linux-arm-kernel@lists.infradead.org, lrg@slimlogic.co.uk
List-Id: alsa-devel@alsa-project.org



On Wed, 2010-12-08 at 12:46 +0000, Mark Brown wrote:
> On Wed, Dec 08, 2010 at 03:01:33PM +0300, Alexander wrote:
> 
> > Changes to I2S code:
> 
> This should be split into a patch series, there's a bunch of changes
> here that are pretty much unrelated.  Having everything in one patch
> makes review harder as more changes have to be thought about
> simultaneously and means that the different changes get tied up with
> each other and a problem with one can hold up others.
> 

I'll split it.


> > - SCLK and LRCLK rates are corrected, assuming we always send 32 bits * 2 channels to codec.
> 
> What was the problem?
> 
> > - Formats list shortened to just S32_LE, this makes all the DMA transactions right,
> >   while ALSA will do all sample format translation for us.
> 
> Again, what was the actual problem?  32 bit samples seem very large if
> the hardware is capable of other formats, especially given that things
> like MP3 tend to produce 16 bit data.

It seems that EP93xx DMA could only operate 32 bit words. So the I2S
module is always feed by 32 bit samples. Incorrect setting of LRCLK (2
times slower) in original ep93xx-i2s.c masks the problem. DMA takes two
16 bit samples instead of one, overall sound speed seems to be normal,
but you get actually 4000 sampling rate instead of requested 8000 and
therefore some noise... This is also the reason why the capture function
not worked at all in this driver...

Best regards,
	Alexander A. Sverdlin.
