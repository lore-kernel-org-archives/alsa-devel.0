From: Manuel Lauss <manuel.lauss@googlemail.com>
Subject: Re: [alsa-devel] [PATCH 4/7] Alchemy: DB1200 AC97+I2S audio support.
Date: Mon, 8 Jun 2009 11:43:41 +0200
Message-ID: <f861ec6f0906080243g6be8e613p7ab9c2df66576be8@mail.gmail.com>
References: <1244399944-29043-1-git-send-email-manuel.lauss@gmail.com>
	 <1244399944-29043-2-git-send-email-manuel.lauss@gmail.com>
	 <1244399944-29043-3-git-send-email-manuel.lauss@gmail.com>
	 <1244399944-29043-4-git-send-email-manuel.lauss@gmail.com>
	 <1244399944-29043-5-git-send-email-manuel.lauss@gmail.com>
	 <20090608092521.GA7858@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-mips-bounce@linux-mips.org>
In-Reply-To: <20090608092521.GA7858@sirena.org.uk>
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
To: Mark Brown <broonie@opensource.wolfsonmicro.com>
Cc: Linux-MIPS <linux-mips@linux-mips.org>, Ralf Baechle <ralf@linux-mips.org>, Manuel Lauss <manuel.lauss@gmail.com>, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Hi Mark!

On Mon, Jun 8, 2009 at 11:25 AM, Mark
Brown<broonie@opensource.wolfsonmicro.com> wrote:
> On Sun, Jun 07, 2009 at 08:39:01PM +0200, Manuel Lauss wrote:
>> Replaces the sample Alchemy PSC AC97 machine code with a DB1200 mach=
ine
>> driver with AC97 and I2S support.
>
> Acked-by: Mark Brown <broonie@opensource.wolfsonmicro.com>
>
> If this is going to go in during the merge window I'm happy for it to=
 go
> in via the MIPS tree but otherwise I'd much rather it goes via ASoC i=
n
> case API changes cause merge issues. =A0I don't know what you prefer,
> Ralf?

I'd rather have it all go through the MIPS tree; this is the only patch=
 of
7 which touches files outside it, and it depends on another one to
apply cleanly.


> We could also split the MIPS and ASoC parts into separate patches if
> that helps.
>
>> +/* it sucks that the ASoC headers are not under include/ */
>> +#include "../codecs/ac97.h"
>> +#include "../codecs/wm8731.h"
>
> This is because they're internal to ASoC - having them out of include
> should set off big red warning flags for something outside ASoC is
> looking at them. =A0If there are things that should be referenced out=
side
> ASoC they should be in a separate header in include/sound like the
> WM9081 platform data.

I'd actually love to move this file to the actual board code, however d=
ue
to the way ASoC is organized this isn't at all possible.  This is one o=
f two
things I don't like about ASoC: the machine registration is extremely a=
wkward
compared to other platform drivers. (the other being that ASoC doesn't
support multiple machines [i.e. I could actually run both AC97 and I2S
simultaneously one of my boards, as independent sound cards])


>> +static int db1200_ac97_init(struct snd_soc_codec *codec)
>> +{
>> + =A0 =A0 snd_soc_dapm_sync(codec);
>> + =A0 =A0 return 0;
>> +}
>
> This could be removed but it does no harm.

I'll  drop it.


>> +/*------------------------- =A0COMMON PART =A0---------------------=
------*/
>> +
>> +static struct resource psc1_res[] =3D {
>> + =A0 =A0 [0] =3D {
>> + =A0 =A0 =A0 =A0 =A0 =A0 .start =A0=3D CPHYSADDR(PSC1_BASE_ADDR),
>> + =A0 =A0 =A0 =A0 =A0 =A0 .end =A0 =A0=3D CPHYSADDR(PSC1_BASE_ADDR) =
+ 0x000fffff,
>> + =A0 =A0 =A0 =A0 =A0 =A0 .flags =A0=3D IORESOURCE_MEM,
>
> If you conver the I2S driver to use the standard device probing model
> this could all me moved into the architecture code rather than placed=
 in
> machine drivers.

Again, I'd love to, but can't: the AC97/I2S/DBDMA drivers extract base =
address
and DMA information from the platform device resource structure;  howev=
er
I can't just copy the resource info from the this db1200_sound platform=
_driver
to the soc_audio platform driver because the driver core complains abou=
t
resource conflicts (two platform_devices sharing the same resources).
Unless I missed a flag which needs to be passed to the resource.flags m=
ember?

Thanks!
        Manuel Lauss
