From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: It looks like snd-soc-rx51 only works as built-in, not as a module
Date: Fri, 30 Dec 2011 22:00:55 +0200
Message-ID: <CAMP44s0EzmhdZ4X91c5X7Rn9q44QcUDm2KNDO81ue16SBWM6_g@mail.gmail.com>
References: <CAMP44s1DPE3ey+Cf48ShbAu_-vv2NC8ppkABT7fDmsE3_j9AmQ@mail.gmail.com>
	<20111210082741.GA32605@earth.universe>
	<CAMP44s3c68z-+3j9OR3pyBFVzH-LJ7WcMu-BnejhkfrxnF4rqA@mail.gmail.com>
	<20111229183712.GB32392@sirena.org.uk>
	<CAMP44s2Vo0iPa6aq6PGy8YSEnEQuNVi1345BtLV9U8zng61uFA@mail.gmail.com>
	<20111229212707.GA9737@opensource.wolfsonmicro.com>
	<CAMP44s2SU_M0Fpt43YDLLhPrgsGzkgpHRWHLcJO4f8N=0HHdvg@mail.gmail.com>
	<20111229215407.GB9737@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
In-Reply-To: <20111229215407.GB9737@opensource.wolfsonmicro.com>
Sender: linux-omap-owner@vger.kernel.org
To: Mark Brown <broonie@opensource.wolfsonmicro.com>
Cc: Sebastian Reichel <sre@debian.org>, Jarkko Nikula <jarkko.nikula@bitmer.com>, linux-omap@vger.kernel.org, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On Thu, Dec 29, 2011 at 11:54 PM, Mark Brown
<broonie@opensource.wolfsonmicro.com> wrote:
> On Thu, Dec 29, 2011 at 11:51:11PM +0200, Felipe Contreras wrote:
>> On Thu, Dec 29, 2011 at 11:27 PM, Mark Brown
>> > On Thu, Dec 29, 2011 at 11:25:50PM +0200, Felipe Contreras wrote:
>> >> On Thu, Dec 29, 2011 at 8:37 PM, Mark Brown
>> >> > On Sat, Dec 10, 2011 at 05:59:57PM +0200, Felipe Contreras wrot=
e:
>
>> >> >> It was not working for me, but it seems the problem was relate=
d to
>> >> >> mdev/udev; snd_soc_tlv320aic3x has to be loaded before snd-soc=
-rx51.
>
>> >> > That should not be required, the modules should be loadable in =
any
>> >> > order.
>
>> >> Are you sure? I recall having a similar discussion with Rusell Ki=
ng,
>> >> and the conclusion is that certain modules are supposed to be loa=
ded
>> >> by udev at boot time, and it seems snd_soc_tlv320aic3x is one of =
them.
>
>> > I'm absolutely positive. =C2=A0ASoC supports loading the modules i=
n any
>> > order. =C2=A0udev is supposed to load anything autoloadable at boo=
t time,
>> > including I2C devices, but that's orthogonal to the order in which
>> > things actually get loaded - udev can randomly reorder things if i=
t
>> > feels like it.
>
>> Yes, but udev loads snd_soc_tlv320aic3x, not snd-soc-rx51.
>
> That is compltelely orthogonal to what you were saying above about th=
e
> ordering of module loading.

Not really, because if both are compiled as modules,
snd_soc_tlv320aic3x will always be loaded first (automatically by
udev).

> The reason the driver is not loaded automatically is that the OMAP
> machine drivers have not been converted to platform devices.

Well, if that's the case then there's a real issue. There doesn't seem
to be a MODULE_DEPENDS(), or anything like that.

snd-soc-rx51 seems to depend on snd_soc_tlv320aic3x through
codec_dai_name, and codec_name, and so on. I don't know how this
dependency is supposed to work out.

Cheers.

--=20
=46elipe Contreras
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
