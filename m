From: Lars-Peter Clausen <lars@metafoo.de>
Subject: Re: snd soc spi read/write
Date: Wed, 10 Aug 2011 23:31:06 +0200
Message-ID: <4E42F89A.2020008@metafoo.de>
References: <20110805072908.GA28149@opensource.wolfsonmicro.com>	<CAHG8p1BSW1_enLqJL4fxxHvTd3MdwmS+Av+zy4i23BH+TuhJqw@mail.gmail.com>	<20110805083058.GB4977@opensource.wolfsonmicro.com>	<CAHG8p1AG2mteW0Bw6ScHCsM5okLr7Vd7Hqy=T8zz+C746qpn+g@mail.gmail.com>	<20110809160447.GM15861@opensource.wolfsonmicro.com>	<s5hwrela3d8.wl%tiwai@suse.de>	<20110810145549.GA5724@opensource.wolfsonmicro.com>	<s5hk4al9uql.wl%tiwai@suse.de>	<20110810150316.GF5724@opensource.wolfsonmicro.com>	<s5hhb5p9u2e.wl%tiwai@suse.de>
	<20110810153457.GG5724@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mailhost.informatik.uni-hamburg.de
	(mailhost.informatik.uni-hamburg.de [134.100.9.70])
	by alsa0.perex.cz (Postfix) with ESMTP id 43E60103918
	for <alsa-devel@alsa-project.org>;
	Wed, 10 Aug 2011 23:33:23 +0200 (CEST)
In-Reply-To: <20110810153457.GG5724@opensource.wolfsonmicro.com>
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
Cc: Takashi Iwai <tiwai@suse.de>, uclinux-dist-devel@blackfin.uclinux.org, Scott Jiang <scott.jiang.linux@gmail.com>, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On 08/10/2011 05:34 PM, Mark Brown wrote:
> On Wed, Aug 10, 2011 at 05:15:21PM +0200, Takashi Iwai wrote:
>> Mark Brown wrote:
> 
>>> The idea is that the CODEC drivers will end up using regmap directly
>>> once it gets cache support migrated over to it.  There's nothing ALSA
>>> specific about the cache support.  Though right just not bothering to
>>> cache this device (it has readback support after all) is probably good
>>> enough.
> 
>> OK, I like the idea, but it sounds a bit like a long way to go.
>> I guess the cache-in-regmap won't be merged in 3.1 cycle?
> 
> Well, regmap is only in 3.2.
> 
>> Basically I don't care too much about this, but the fact we leave this
>> being broken over two release cycles doesn't appear nice, especially
>> when there is a quick-n-easy fix...
> 
> I don't see a problem with the idea of just making the registers
> volatile.  There's no real need to cache the registers on a small SPI
> device with readback support, the caches mainly benefit I2C (which is
> much slower) and devices with no readback support with some other
> benefits for larger devices.
> 

The problem is that there is no read-back support out of the box. Readback
requires setting the read bit in the registers address. Since this is not the
upper-most bit, the default regmap spi read wont work.

And if we have to add our own read function we could as very well add our own
write function which simply reinstates the old caching behavior.

In my opinion it would be nice if we could add a register cache base address,
which specifies the offset at which the cache-able registers start. For example
I have a codec driver in the queue where all non-volatile registers at 0x8000
and I don't really want to add 16k of zeros to the driver for the default
register cache.

- Lars
