From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: snd soc spi read/write
Date: Thu, 11 Aug 2011 00:03:18 +0900
Message-ID: <20110810150316.GF5724@opensource.wolfsonmicro.com>
References: <20110805063414.GB20809@opensource.wolfsonmicro.com>
	<CAHG8p1BBza_M_Cgrq2O2U+Xc-=rPHeNBKMD_KwfZsLX5Npz9jA@mail.gmail.com>
	<20110805072908.GA28149@opensource.wolfsonmicro.com>
	<CAHG8p1BSW1_enLqJL4fxxHvTd3MdwmS+Av+zy4i23BH+TuhJqw@mail.gmail.com>
	<20110805083058.GB4977@opensource.wolfsonmicro.com>
	<CAHG8p1AG2mteW0Bw6ScHCsM5okLr7Vd7Hqy=T8zz+C746qpn+g@mail.gmail.com>
	<20110809160447.GM15861@opensource.wolfsonmicro.com>
	<s5hwrela3d8.wl%tiwai@suse.de>
	<20110810145549.GA5724@opensource.wolfsonmicro.com>
	<s5hk4al9uql.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 23D5410380E
	for <alsa-devel@alsa-project.org>;
	Wed, 10 Aug 2011 17:03:24 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <s5hk4al9uql.wl%tiwai@suse.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Takashi Iwai <tiwai@suse.de>
Cc: uclinux-dist-devel@blackfin.uclinux.org, Scott Jiang <scott.jiang.linux@gmail.com>, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On Wed, Aug 10, 2011 at 05:00:50PM +0200, Takashi Iwai wrote:
> Mark Brown wrote:

> > That would fall within the definition of "teach the register map about
> > this stuff"...

> Yeah, I expected that.  But it also would include the changes of
> register definitions in the codec driver, right?

The idea is that the CODEC drivers will end up using regmap directly
once it gets cache support migrated over to it.  There's nothing ALSA
specific about the cache support.  Though right just not bothering to
cache this device (it has readback support after all) is probably good
enough.

It's a shame the bodge snuck through :/
