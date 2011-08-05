From: Scott Jiang <scott.jiang.linux@gmail.com>
Subject: Re: snd soc spi read/write
Date: Fri, 5 Aug 2011 14:26:33 +0800
Message-ID: <CAHG8p1AkbrfX3dkLw=MNf24V3peMB33z-vLdVyzRxvGmSNTWSg@mail.gmail.com>
References: <CAHG8p1AsKZdVvTj-ydWhDCEKjJcx9Q82srEOVZS45Q5J486YBw@mail.gmail.com>
	<20110804103558.GA25976@opensource.wolfsonmicro.com>
	<CAHG8p1AeeqL+Cj-4V4NwQpD33H4ogV0rfekHjMqfvG7wQ49fCA@mail.gmail.com>
	<20110805054210.GB16956@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-qw0-f51.google.com (mail-qw0-f51.google.com
	[209.85.216.51])
	by alsa0.perex.cz (Postfix) with ESMTP id 70F7B103984
	for <alsa-devel@alsa-project.org>;
	Fri,  5 Aug 2011 08:26:34 +0200 (CEST)
Received: by qwf7 with SMTP id 7so81932qwf.38
	for <alsa-devel@alsa-project.org>; Thu, 04 Aug 2011 23:26:33 -0700 (PDT)
In-Reply-To: <20110805054210.GB16956@opensource.wolfsonmicro.com>
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

2011/8/5 Mark Brown <broonie@opensource.wolfsonmicro.com>:
> On Fri, Aug 05, 2011 at 10:24:43AM +0800, Scott Jiang wrote:
>
>> hw_write use 16bit reg, cache use 8bit reg, in former version
>>
>> =A0 =A0 =A0 =A0 data[0] =3D (reg >> 8) & 0xff;
>> =A0 =A0 =A0 =A0 data[1] =3D reg & 0xff;
>> =A0 =A0 =A0 =A0 data[2] =3D value;
>>
>> =A0 =A0 =A0 =A0 reg &=3D 0xff;
>> =A0 =A0 =A0 =A0 if (reg < codec->reg_cache_size)
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 cache[reg] =3D value;
>>
>> =A0 =A0 =A0 =A0 ret =3D codec->hw_write(codec->control_data, data, 3);
>
> Which is just obviously insane and buggy as with that code the same
> cache slot will be used for 256 different registers that differ only in
> the upper byte.
>
>> now in do_hw_write
>> =A0 =A0 =A0 =A0 if (!snd_soc_codec_volatile_register(codec, reg) &&
>> =A0 =A0 =A0 =A0 =A0 =A0 reg < codec->driver->reg_cache_size &&
>> =A0 =A0 =A0 =A0 =A0 =A0 !codec->cache_bypass) {
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 ret =3D snd_soc_cache_write(codec, reg, =
value);
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (ret < 0)
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 return -1;
>> =A0 =A0 =A0 =A0 }
>> reg > reg_cache_size, so will not write to cache
>
> Which is exactly what we'd expect - we won't have allocated a cache
> beyond register reg_cache_size and the driver is telling us not to cache
> those registers.
>
>> > Note that all this code will be replaced with regmap for 3.2.
>
>> Do you mean I must update to 3.2 to solve this problem?
>
> I don't see any problem here. =A0What is the problem you're experiencing?
>

My register address is 0x806(8bit global addr + 8bit reg addr), for
example,  reg_cache_size is 0x20.
snd_soc_cache_write will not be called. And kernel oops in do_hw_read

BUG_ON(!codec->hw_read);

That is what I found when asoc was upgraded to 3.0, my codec is ad1938.

The key issue is register is 8 bits, hardware needs 16 bits addr. If I
change reg_cache_size to 2^16=3D64K, I think everything goes well.
But it will waste a lot of memory for only 32 registers.
