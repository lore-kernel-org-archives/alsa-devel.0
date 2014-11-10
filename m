From: "Dr. H. Nikolaus Schaller" <hns@goldelico.com>
Subject: Re: [Gta04-owner] [PATCH 2/3] ASoC: twl4030: allow voice port to be connected externally.
Date: Mon, 10 Nov 2014 07:46:50 +0100
Message-ID: <1B5F0B4F-2F19-4692-BB95-C6D916DAD3A7@goldelico.com>
References: <20141108002637.6561.19002.stgit@notabene.brown> <20141108003803.6561.57464.stgit@notabene.brown> <20141108092622.GC2722@sirena.org.uk> <20141110102551.2678d342@notabene.brown>
Mime-Version: 1.0 (Mac OS X Mail 7.3 \(1878.6\))
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20141110102551.2678d342@notabene.brown>
Sender: linux-kernel-owner@vger.kernel.org
To: List for communicating with real GTA04 owners <gta04-owner@goldelico.com>
Cc: Mark Brown <broonie@kernel.org>, Mark Rutland <mark.rutland@arm.com>, alsa-devel@alsa-project.org, Pawel Moll <pawel.moll@arm.com>, Ian Campbell <ijc+devicetree@hellion.org.uk>, Liam Girdwood <lgirdwood@gmail.com>, linux-kernel@vger.kernel.org, Peter Ujfalusi <peter.ujfalusi@ti.com>, devicetree@vger.kernel.org, Rob Herring <robh+dt@kernel.org>
List-Id: alsa-devel@alsa-project.org


Am 10.11.2014 um 00:25 schrieb NeilBrown <neilb@suse.de>:

> On Sat, 8 Nov 2014 09:26:22 +0000 Mark Brown <broonie@kernel.org> wro=
te:
>=20
>> On Sat, Nov 08, 2014 at 11:38:03AM +1100, NeilBrown wrote:
>>=20
>>> If voice port on twl4030 is not connected to a McBSP (or similar)
>>> then we cannot configure the format the way we normally do for a DA=
I.
>>=20
>> Yes we can, you need to represent the DAI link to whatever else the
>> device is connected to in the driver like we do anything else - and =
in
>> any case this isn't a device specific issue so we shouldn't be doing
>> something driver specific to solve it.  Look at something like speys=
ide.
>=20
> Hi Mark,
> thanks for the reply ... I might need a little bit more help though.
>=20
> I had a look at sound/soc/samsung/speyside.c, but I'm not entirely su=
re what
> I'm looking for.
> Presumably this is an audio processor not unlike the audio module in =
the
> twl4030.
>=20
> I see that there are 3 dai-links:
>  CPU-DSP
>  DSP-CODEC
>  Baseband
>=20
> Presumably "Baseband" is similar, in purpose at least, to the "voice"
> interface on the twl4030.
>=20
> Each dai-link has a "cpu_dai_name" and a "codec_dai_name", even thoug=
h it
> appears that only "CPU-DSP" is connected to the CPU.  Maybe that nami=
ng is
> the source of some of my confusion.
>=20
> "Baseband" declares
>                .cpu_dai_name =3D "wm8996-aif2",
> so wm8996 is something with 2 audio interfaces, (aif), and this is th=
e second
> one?  Maybe the  wm8996 is the audio module, so what is the "speyside=
"?
>=20
> http://opensource.wolfsonmicro.com/content/speyside-audio
>=20
> says it is a "reference platform".  Does that mean it is a board with=
 a bunch
> of chips soldered onto it?  If it were a board it should be described=
 by a
> dts file, not by a pile of C code (I thought), so I must be wrong abo=
ut that.
>=20
>=20
> In my case, I have a board with a GSM module and the twl4030 module. =
 Each
> has an audio interface and these are connected.  I assume that I need=
 to
> express this connection in the dts file.
> The GSM module doesn't currently appear in the dts file as it is usb-=
attached.
> However I've been thinking that we will need to add it so we can expr=
ess
> power-on controls (twiddling some GPIOs).  So let's suppose we have t=
he GSM
> module in the dts file (child of a USB interface)

It is a quite complex connection pattern and I am not sure if the modem=
 is really
a logical child of the USB interface. Powering up/down the USB interfac=
e has nothing
to do with the modem power. Rather, it continues to operate if USB is s=
uspended
and the modem notifies USB that it has become active.

The connections on this GTA04 board are:

Modem USB <=97> CPU USB
Modem PCM <=97> TWL4030 Voice <=97> OMAP3 McBSP4 (yes, it is a 3-way co=
nnection)
Modem Power control <=97> 1 or 2 GPIOs (depending on board variant)

The reason for the 3-way connection is that user space can chose if the=
 GSM
voice is routed directly to the TWL codec (low latency, independent of =
CPU) or
goes through the CPU (e.g. for DTAM or voice scrambling by software) an=
d
then through the other PCM link between the CPU and the TWL.

This is why I would make the McBSP4 a separate sound card.

And, this is why it needs some control and tri-state of the TWL4030 and=
 OMAP3
McBSP4 since only one can provide a digital PCM stream to the modem.

One more thing to consider for a general solution is that there are mod=
em modules
that communicate data through UART or SPI - but otherwise have a simila=
r connection
for digital audio. So forcing the power control driver to be a subnode =
of USB doesn=92t
appear general enough to me.

=46inally, this connection pattern is not specific to this modem (OPTIO=
N GTM601) on this
GTA04 board. We plan to use a Gemalto PHS8  in the Pyra-Handheld and th=
e Neo900
devices - but the general connection pattern as defined above remains t=
he same.

So my proposal is to have a specific wwan-power driver for this type of=
 modems.
And power control can and should be kept separately from USB (except th=
e case
where only 1 GPIO exists and USB must be tapped to detect the modem pow=
er
state). You can find work in progress for this approach here:

<http://git.goldelico.com/?p=3Dgta04-kernel.git;a=3Dblob;f=3Ddrivers/mi=
sc/wwan-on-off.c;h=3De13f47dbd734d14f4e38ea9cf622982dc3550212;hb=3D154b=
cd388a8f5bcc7fcf0e57e93b6388daa16980>

> and the twl4030 as well
> (beneath an i2c interface).
>=20
> The twl4030 needs to know the master/polarity of the clk/frm lines.  =
The GSM
> module declares that these are.  So presumably we need some sort of l=
inkage.
> Ahhhh... I found Documentation/devicetree/bindings/sound/simple-card.=
txt
>=20
> So I need to make the "voice" port on the twl4030 look like a "cpu" e=
nd of a
> dai-link, and create a "codec" end in the GSM module, and use "sound-=
dai" to
> point from the twl4030 to the GSM module.

What I wonder a little is that we have all these dai-links working sinc=
e your 3.7
kernel for GTA04. Is it necessary to re-invent a solution or should we =
just make
the solution device tree compatible?

> Then I use frame-master, bitclock-master, bitclock-inversion, frame-i=
nversion
> for the settings I need.
>=20
> I suspect I can make that work.
>=20
> Am I on the right track?
>=20
> Thanks,
> NeilBrown
> _______________________________________________
> Gta04-owner mailing list
> Gta04-owner@goldelico.com
> http://lists.goldelico.com/mailman/listinfo.cgi/gta04-owner
