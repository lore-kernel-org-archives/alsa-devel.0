From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: snd soc spi read/write
Date: Fri, 5 Aug 2011 06:42:10 +0100
Message-ID: <20110805054210.GB16956@opensource.wolfsonmicro.com>
References: <CAHG8p1AsKZdVvTj-ydWhDCEKjJcx9Q82srEOVZS45Q5J486YBw@mail.gmail.com>
	<20110804103558.GA25976@opensource.wolfsonmicro.com>
	<CAHG8p1AeeqL+Cj-4V4NwQpD33H4ogV0rfekHjMqfvG7wQ49fCA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 8C7FF103984
	for <alsa-devel@alsa-project.org>;
	Fri,  5 Aug 2011 07:42:12 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <CAHG8p1AeeqL+Cj-4V4NwQpD33H4ogV0rfekHjMqfvG7wQ49fCA@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Scott Jiang <scott.jiang.linux@gmail.com>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On Fri, Aug 05, 2011 at 10:24:43AM +0800, Scott Jiang wrote:

> hw_write use 16bit reg, cache use 8bit reg, in former version
> 
>         data[0] = (reg >> 8) & 0xff;
>         data[1] = reg & 0xff;
>         data[2] = value;
> 
>         reg &= 0xff;
>         if (reg < codec->reg_cache_size)
>                 cache[reg] = value;
> 
>         ret = codec->hw_write(codec->control_data, data, 3);

Which is just obviously insane and buggy as with that code the same
cache slot will be used for 256 different registers that differ only in
the upper byte.

> now in do_hw_write
>         if (!snd_soc_codec_volatile_register(codec, reg) &&
>             reg < codec->driver->reg_cache_size &&
>             !codec->cache_bypass) {
>                 ret = snd_soc_cache_write(codec, reg, value);
>                 if (ret < 0)
>                         return -1;
>         }
> reg > reg_cache_size, so will not write to cache

Which is exactly what we'd expect - we won't have allocated a cache
beyond register reg_cache_size and the driver is telling us not to cache
those registers.

> > Note that all this code will be replaced with regmap for 3.2.

> Do you mean I must update to 3.2 to solve this problem?

I don't see any problem here.  What is the problem you're experiencing?
