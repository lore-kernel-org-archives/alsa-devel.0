From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: linux-next: Tree for Aug 11 (sound/soc + regmap)
Date: Fri, 12 Aug 2011 09:11:59 +0900
Message-ID: <1313107919.19990.4.camel@finisterre.wolfsonmicro.main>
References: <20110811162058.42b462bc80e67d7a80ecff93@canb.auug.org.au>
	 <20110811121459.b235aff5.rdunlap@xenotime.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20110811121459.b235aff5.rdunlap@xenotime.net>
Sender: linux-kernel-owner@vger.kernel.org
To: Randy Dunlap <rdunlap@xenotime.net>
Cc: Stephen Rothwell <sfr@canb.auug.org.au>, Liam Girdwood <lrg@ti.com>, linux-next@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On Thu, 2011-08-11 at 12:14 -0700, Randy Dunlap wrote:


> When CONFIG_SPI is not enabled (so REGMAP_SPI is not enabled):
> (on i386 and x86_64)

> sound/built-in.o: In function `snd_soc_codec_set_cache_io':
> (.text+0x85635): undefined reference to `regmap_init_spi'

Fixed before you reported it by Axel.
