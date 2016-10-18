From: Mark Brown <broonie@kernel.org>
Subject: Re: configuring machine specific DAPM for codec +
	headset jack detect
Date: Tue, 18 Oct 2016 19:30:37 +0100
Message-ID: <20161018183037.GF10208@sirena.org.uk>
References: <CAJ+vNU2a5G8HxJjZ+0g_NkC1jtMg1jKVq6xOfWqx94tbyA=rLA@mail.gmail.com>
 <20161018110236.GD10208@sirena.org.uk>
 <CAJ+vNU2x-i77=VEskXGECYTqK4PdBBn1Z9Y5FE=_vmU6iNNtOg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============7830403665851449319=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id BC397266F03
 for <alsa-devel@alsa-project.org>; Tue, 18 Oct 2016 20:30:47 +0200 (CEST)
In-Reply-To: <CAJ+vNU2x-i77=VEskXGECYTqK4PdBBn1Z9Y5FE=_vmU6iNNtOg@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Tim Harvey <tharvey@gateworks.com>
Cc: alsa-devel@alsa-project.org, Dylan Reid <dgreid@chromium.org>
List-Id: alsa-devel@alsa-project.org


--===============7830403665851449319==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="p8PhoBjPxaQXD0vg"
Content-Disposition: inline


--p8PhoBjPxaQXD0vg
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Oct 18, 2016 at 11:16:40AM -0700, Tim Harvey wrote:
> On Tue, Oct 18, 2016 at 4:02 AM, Mark Brown <broonie@kernel.org> wrote:

> > No, you need to write that code if you want it - we do mark not
> > connected things with the intention that someone could implement this
> > but nobody did yet.

> OK - that explains why 'snd_soc_dapm_disable_pin' and
> 'snd_soc_dapm_enable_pin' didn't have any noticeable affect when I was
> calling those from a machine driver. I will plan on having to setup
> all the ALSA controls manually in my OS configuration (Android in this
> use case using tinyalsa_hal).

No, those do useful things with DAPM but not what you're looking for.
For things that are disconnected you want _nc_pin().

> > You can ramp the power down time up but no, there's no way to disable it
> > completely in the kernel - this is normally done in the sound server and
> > tends to work better that way as starting and stopping the digital audio
> > stream tends to be glitchy.

> I haven't found where the power down time is specified/configured -
> can you point me to that?

pmdown_time.

> I'm not quite understanding the DAPM widgets in the driver. These
> registers are configured by:
>         SND_SOC_DAPM_PGA("Left HP Out", HPLOUT_CTRL, 0, 0, NULL, 0),
>         SND_SOC_DAPM_PGA("Right HP Out", HPROUT_CTRL, 0, 0, NULL, 0),

> yet those don't show up in amixer as controls so they are somehow used
> internally.

DAPM widgets are not controls, they're purely internal to the kernel.
The kernel will power up any DAPM widgets that form part of a complete
audio path from input to output or which are forced on.

> Looking at the tlv32aic3105 datasheet
> (http://www.ti.com/lit/ds/symlink/tlv320aic3105.pdf) Register 51
> (0x33) has its mute control in bit3 so I would expect that bit to be
> cleared before and set after applying this stuff. Is there a missing
> SND_SOC_DAPM* in that driver perhaps?

You *can* hook mutes into DAPM with _AUTODISABLE controls but it's
rarely required.

> Incidentally, the board I'm working with has a DC biased headphone. If
> I modify the board to AC bias the headphone the pop goes away, but I'm
> thinking that isn't really the right solution and that there is
> something instead missing from the tlv320aic3x.c driver that should be
> muting/unmuting the outputs around the above register changes.

I'm not sure what you mean by DC and AC bias here, sorry.  Do you mean
VMID referenced vs ground referenced?  If it's that then it sounds like
the driver ought to be biasing the headphones in set_bias_level()
probably based on some DT information, though I'd also say that I can't
think of any reason why you wouldn't want ground referenced outputs so
perhaps I'm missing something.

> Regarding the ts3a227e headset detect/config switch
> (http://www.ti.com/lit/ds/symlink/ts3a227e.pdf), what is the proper
> way to hook that into the Linux input layer via the simple-sound-card
> driver? The ts3a227e_enable_jack_detect function exported from the
> ts3a227e.c driver is only currently called by two machine drivers that
> have explicit support. I suppose if I want to add support for this
> using simple-sound-card I would need to add a custom dt binding to
> that driver?

There was a thread a while back where Dylan Reid proposed a custom jack
binding ("Add a gpio jack device" IIRC) but that ground to a halt.
Right now I'd expect a custom machine driver for something like this
which is obviously not ideal but is going to be a lot easier for you to
implement.

--p8PhoBjPxaQXD0vg
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJYBmpMAAoJECTWi3JdVIfQqpIH/igYRqAFMJcWUjS5GU7U9fYg
lZsXpiZ4YE6kjbYP3/hQyzoouoq/CS5HYOPep/H68LFYvBSVfw8z1P87M7j8Qs10
UlrO0z7kxnxyZS6FEpZCiTtJobEY/ZK+p9UmgWvOlLoGes39sMuSRCjhG1Be+wfI
1jojOKoRdliGmknYS1STjTQ61Qe0NbIq6xhEN/ZUge/1TtY1dX2LchUN791b6MS6
413cBjKJiwjlW/ublqZQ73CfwQx8JZbgXMvwk/hhCA5tURB+CtQu4rxc5g6qirxL
QdRG11ly/YUwUrMP5uM4MKqsnbVOP+G+bs376exCgKAN6oQHNTZQSm4QyaVShkw=
=cEUG
-----END PGP SIGNATURE-----

--p8PhoBjPxaQXD0vg--

--===============7830403665851449319==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============7830403665851449319==--
