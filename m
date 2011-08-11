From: Randy Dunlap <rdunlap@xenotime.net>
Subject: Re: linux-next: Tree for Aug 11 (sound/soc + regmap)
Date: Thu, 11 Aug 2011 12:14:59 -0700
Message-ID: <20110811121459.b235aff5.rdunlap@xenotime.net>
References: <20110811162058.42b462bc80e67d7a80ecff93@canb.auug.org.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20110811162058.42b462bc80e67d7a80ecff93@canb.auug.org.au>
Sender: linux-kernel-owner@vger.kernel.org
To: Stephen Rothwell <sfr@canb.auug.org.au>, Liam Girdwood <lrg@ti.com>, Mark Brown <broonie@opensource.wolfsonmicro.com>
Cc: linux-next@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On Thu, 11 Aug 2011 16:20:58 +1000 Stephen Rothwell wrote:

> Hi all,

When CONFIG_SPI is not enabled (so REGMAP_SPI is not enabled):
(on i386 and x86_64)

sound/built-in.o: In function `snd_soc_codec_set_cache_io':
(.text+0x85635): undefined reference to `regmap_init_spi'


---
~Randy
*** Remember to use Documentation/SubmitChecklist when testing your code ***
