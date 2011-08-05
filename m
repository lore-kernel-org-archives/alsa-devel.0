From: Scott Jiang <scott.jiang.linux@gmail.com>
Subject: Re: snd soc spi read/write
Date: Fri, 5 Aug 2011 10:24:43 +0800
Message-ID: <CAHG8p1AeeqL+Cj-4V4NwQpD33H4ogV0rfekHjMqfvG7wQ49fCA@mail.gmail.com>
References: <CAHG8p1AsKZdVvTj-ydWhDCEKjJcx9Q82srEOVZS45Q5J486YBw@mail.gmail.com>
	<20110804103558.GA25976@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-qy0-f179.google.com (mail-qy0-f179.google.com
	[209.85.216.179])
	by alsa0.perex.cz (Postfix) with ESMTP id D7BC9103956
	for <alsa-devel@alsa-project.org>;
	Fri,  5 Aug 2011 04:24:48 +0200 (CEST)
Received: by qyk35 with SMTP id 35so1376471qyk.17
	for <alsa-devel@alsa-project.org>; Thu, 04 Aug 2011 19:24:43 -0700 (PDT)
In-Reply-To: <20110804103558.GA25976@opensource.wolfsonmicro.com>
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
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

2011/8/4 Mark Brown <broonie@opensource.wolfsonmicro.com>:
> On Thu, Aug 04, 2011 at 06:24:04PM +0800, Scott Jiang wrote:
>
>> My version is linux 3.0, I found snd_soc_spi_read/write didn't work at
>> 16-8 bit mode.
>> The addr is 16bit, the function compares reg with reg_cache_size. This
>> certainly causes failure.
>> In the former version, reg &= 0xff seems right. So how to use
>> snd_soc_16_8_write now?
>
> reg &= 0xff is clearly broken for 16 bit register values...

hw_write use 16bit reg, cache use 8bit reg, in former version

        data[0] = (reg >> 8) & 0xff;
        data[1] = reg & 0xff;
        data[2] = value;

        reg &= 0xff;
        if (reg < codec->reg_cache_size)
                cache[reg] = value;

        ret = codec->hw_write(codec->control_data, data, 3);

now in do_hw_write
        if (!snd_soc_codec_volatile_register(codec, reg) &&
            reg < codec->driver->reg_cache_size &&
            !codec->cache_bypass) {
                ret = snd_soc_cache_write(codec, reg, value);
                if (ret < 0)
                        return -1;
        }
reg > reg_cache_size, so will not write to cache

>
> Note that all this code will be replaced with regmap for 3.2.
>

Do you mean I must update to 3.2 to solve this problem?
