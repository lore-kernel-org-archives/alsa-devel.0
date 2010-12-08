From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH 1/3] ASoC: EP93xx I2S and PCM fixes
Date: Wed, 8 Dec 2010 12:46:37 +0000
Message-ID: <20101208124637.GD16418@rakim.wolfsonmicro.main>
References: <1291809693.31916.2.camel@r60e>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 4A37A103B27
	for <alsa-devel@alsa-project.org>; Wed,  8 Dec 2010 13:46:39 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <1291809693.31916.2.camel@r60e>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Alexander <subaparts@yandex.ru>
Cc: alsa-devel@alsa-project.org, ryan@bluewatersys.com, linux-arm-kernel@lists.infradead.org, lrg@slimlogic.co.uk
List-Id: alsa-devel@alsa-project.org

On Wed, Dec 08, 2010 at 03:01:33PM +0300, Alexander wrote:

> Changes to I2S code:

This should be split into a patch series, there's a bunch of changes
here that are pretty much unrelated.  Having everything in one patch
makes review harder as more changes have to be thought about
simultaneously and means that the different changes get tied up with
each other and a problem with one can hold up others.

> - MCLK is turned on on driver probe. This is done for several codecs that need this for 
>   registers access (like CS4271).

This seems like a retrograde step for systems that don't need it.  Would
it not be better to make this configurable by the machine driver?

> - SCLK and LRCLK rates are corrected, assuming we always send 32 bits * 2 channels to codec.

What was the problem?

> - Formats list shortened to just S32_LE, this makes all the DMA transactions right,
>   while ALSA will do all sample format translation for us.

Again, what was the actual problem?  32 bit samples seem very large if
the hardware is capable of other formats, especially given that things
like MP3 tend to produce 16 bit data.
