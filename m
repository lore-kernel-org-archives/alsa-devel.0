From: Pierre Ossman <pierre-list@ossman.eu>
Subject: Re: radeon multi-channel lpcm
Date: Thu, 6 Sep 2012 09:09:00 +0200
Message-ID: <20120906090900.63328552@mjolnir.ossman.eu>
References: <20120831223447.065fcb62@mjolnir.ossman.eu>
 <20120905181923.2e330a63@mjolnir.ossman.eu>
 <s5h4nnczaoq.wl%tiwai@suse.de>
 <20120905192239.6a212683@mjolnir.ossman.eu>
 <s5hpq5zitd3.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============3147681848262334688=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp-relay.ossman.eu (saehrimnir.ossman.eu [193.12.253.10])
 by alsa0.perex.cz (Postfix) with ESMTP id 49E76265CA7
 for <alsa-devel@alsa-project.org>; Thu,  6 Sep 2012 09:09:05 +0200 (CEST)
In-Reply-To: <s5hpq5zitd3.wl%tiwai@suse.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

This is a MIME-formatted message.  If you see this text it means that your
E-mail software does not support MIME-formatted messages.

--===============3147681848262334688==
Content-Type: multipart/signed; micalg=PGP-SHA256; protocol="application/pgp-signature"; boundary="=_freyr.ossman.eu-18617-1346915343-0001-2"

This is a MIME-formatted message.  If you see this text it means that your
E-mail software does not support MIME-formatted messages.

--=_freyr.ossman.eu-18617-1346915343-0001-2
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

On Thu, 06 Sep 2012 07:59:52 +0200
Takashi Iwai <tiwai@suse.de> wrote:

> At Wed, 5 Sep 2012 19:22:39 +0200,
> Pierre Ossman wrote:
> >=20
> > Some follow up questions, to confirm I haven't confused things:
> >=20
> >  - The ELD really needs to go into the hardware, not just end up in the
> >    hands of the audio driver? IOW, we cannot override this?
>=20
> Usually ELD won't go to the hardware as is but translated in a
> different way in the graphics side.
>=20
> >  - The HDA interface only defines reading the ELD, so writing it would
> >    have to be done by the graphics driver using some GPU interface?
>=20
> Yes.
>=20
> > If so, I need to poke the AMD guys as I couldn't find any information
> > in the public documentation about writing the ELD.
>=20
> It's not about "writing" ELD.  If you got no valid ELD, it is the
> graphics driver who didn't send it.  The graphics hardware certainly
> sends some audio information, and the graphics driver translates into
> an ELD and notifies to the audio codec.  This part is missing or
> wrongly done, supposedly.
>=20

I've studied the Intel driver to get some feel for it, and it seems to
work like this:

 1) The graphics driver gets the EDID data from the GPU.

 2) The kernel constructs the ELD structure from the EDID.

 3) The graphics driver writes the ELD to some GPU registers.

 4) The audio driver reads the ELD via the HDA interface.

But if you're saying that the hardware doesn't really need the ELD,
then steps 3-4 could be replaced by a pure software channel. This would
be convenient as it is currently unknown how to do 3) on radeon.

(2 is currently missing in the radeon driver, but it is trivial to add
AFAICT)

I am a bit confused though. If the hardware doesn't actually look at
the ELD, why are the widgets caps not indicating support for 8
channels? Isn't that coming straight from the hardware?

And static_hdmi_pcm is described as "Don't restrict PCM parameters per
ELD info", which doesn't seem to be the case as I cannot get more than
2 channels no matter the setting of that parameter.

Rgds
--=20
     -- Pierre Ossman

  WARNING: This correspondence is being monitored by FRA, a
  Swedish intelligence agency. Make sure your server uses
  encryption for SMTP traffic and consider using PGP for
  end-to-end encryption.

--=_freyr.ossman.eu-18617-1346915343-0001-2
Content-Type: application/pgp-signature; name="signature.asc"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment; filename=signature.asc

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.18 (GNU/Linux)

iF4EAREIAAYFAlBITA8ACgkQopDLsoqlmELYiAEAu0oYHNRa+KTd38jpSB+NPDyM
bgzO3/pHMWuwbsqPITsA/06gNCgyZYBO1WC3Sr1px3PVKQlocyRDM+YowUfywC78
=xmI1
-----END PGP SIGNATURE-----

--=_freyr.ossman.eu-18617-1346915343-0001-2--

--===============3147681848262334688==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============3147681848262334688==--
