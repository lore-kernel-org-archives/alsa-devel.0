From: Manuel Lauss <manuel.lauss@googlemail.com>
Subject: Re: [alsa-devel] [PATCH 4/7] Alchemy: DB1200 AC97+I2S audio support.
Date: Mon, 8 Jun 2009 13:25:57 +0200
Message-ID: <f861ec6f0906080425i388a99a1kb89667c749a815c8@mail.gmail.com>
References: <1244399944-29043-1-git-send-email-manuel.lauss@gmail.com>
	 <1244399944-29043-2-git-send-email-manuel.lauss@gmail.com>
	 <1244399944-29043-3-git-send-email-manuel.lauss@gmail.com>
	 <1244399944-29043-4-git-send-email-manuel.lauss@gmail.com>
	 <1244399944-29043-5-git-send-email-manuel.lauss@gmail.com>
	 <20090608092521.GA7858@sirena.org.uk>
	 <f861ec6f0906080243g6be8e613p7ab9c2df66576be8@mail.gmail.com>
	 <20090608102018.GA6547@rakim.wolfsonmicro.main>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-mips-bounce@linux-mips.org>
In-Reply-To: <20090608102018.GA6547@rakim.wolfsonmicro.main>
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
To: Mark Brown <broonie@opensource.wolfsonmicro.com>
Cc: Linux-MIPS <linux-mips@linux-mips.org>, Ralf Baechle <ralf@linux-mips.org>, Manuel Lauss <manuel.lauss@gmail.com>, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Hi Mark,

On Mon, Jun 8, 2009 at 12:20 PM, Mark
Brown<broonie@opensource.wolfsonmicro.com> wrote:
> On Mon, Jun 08, 2009 at 11:43:41AM +0200, Manuel Lauss wrote:
>> On Mon, Jun 8, 2009 at 11:25 AM, Mark
>> Brown<broonie@opensource.wolfsonmicro.com> wrote:
>
>> > If this is going to go in during the merge window I'm happy for it=
 to go
>> > in via the MIPS tree but otherwise I'd much rather it goes via ASo=
C in
>> > case API changes cause merge issues. =A0I don't know what you pref=
er,
>> > Ralf?
>
>> I'd rather have it all go through the MIPS tree; this is the only pa=
tch of
>> 7 which touches files outside it, and it depends on another one to
>> apply cleanly.
>
> Well, like I say if it's going via MIPS I'd really prefer it to go in
> this merge window. =A0If not then I'd expect that splitting out the
> architecture parts from the machine driver as I suggested ought to de=
al
> with the merge issues.

I'll split it in two:  pure ASoC part and pure board part.  Agreed?


>> I'd actually love to move this file to the actual board code, howeve=
r due
>> to the way ASoC is organized this isn't at all possible. =A0This is =
one of two
>> things I don't like about ASoC: the machine registration is extremel=
y awkward
>> compared to other platform drivers. (the other being that ASoC doesn=
't
>> support multiple machines [i.e. I could actually run both AC97 and I=
2S
>> simultaneously one of my boards, as independent sound cards])
>
> I've got a board sitting on my desk here which has multiple sound
> systems. =A0Unfortunately the architecture code for it is a bit of a
> shambles at this point so it's more trouble to work on the platform
> than it's worth at the minute.

Alchemy's can have up to 4 PSCs with variable base addresses and variab=
le
functions.  Currently, ASoC can't handle more than 1 AC97 codec (no ide=
a
how to pass DAI private data to the ac97 callbacks), and I also don't s=
ee how
to handle for instance 2 I2S machines with a WM8731 attached to each
(i.e. how do I tell ASoC that wm8731 at bus0/0x1b belongs to machine A
 and wm8731 at bus0/0x1c belongs to machine B?)

This isn't a problem with the DB1200, as AC97 and I2S are connected to
the same PSC, but the DB1550 and DB1300 do have independent AC97 and
I2S.


>> >> +static struct resource psc1_res[] =3D {
>
>> > If you conver the I2S driver to use the standard device probing mo=
del
>> > this could all me moved into the architecture code rather than pla=
ced in
>> > machine drivers.
>
>> Again, I'd love to, but can't: the AC97/I2S/DBDMA drivers extract ba=
se address
>> and DMA information from the platform device resource structure; =A0=
however
>> I can't just copy the resource info from the this db1200_sound platf=
orm_driver
>> to the soc_audio platform driver because the driver core complains a=
bout
>> resource conflicts (two platform_devices sharing the same resources)=
=2E
>> Unless I missed a flag which needs to be passed to the resource.flag=
s member?
>
> If you move the selection of the switch position to the architecture
> code then it can arrange to register only the device that is in use i=
n
> the current configuration. =A0If the DMA and DAI drivers both need th=
e
> same resources they can cooperate with each other - the system will o=
nly
> bring the card on-line once both the DMA and DAI driver are present.

I think you misuderstood me.  Could you point out an in-kernel machine =
which
already implements what you suggested?

The AC97/I2S dai drivers (psc-ac97/psc-i2s) extract the base address of=
 the PSC
they're supposed to drive from the platform_device passed via the probe=
()
callbacks, these in turn are called when a "soc_audio" platform device
is called.
I need to set either the ac97 or I2S platform data for soc_audio based =
on the
switch setting.  I can't register a "db1200_audio" platform device in t=
he board
code which in turn registers the "soc_audio" device and have them share
the PSC mmio/irq/dma resources.

        Manuel Lauss
