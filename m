From: Pierre Ossman <pierre-list@ossman.eu>
Subject: Re: radeon multi-channel lpcm
Date: Wed, 5 Sep 2012 19:22:39 +0200
Message-ID: <20120905192239.6a212683@mjolnir.ossman.eu>
References: <20120831223447.065fcb62@mjolnir.ossman.eu>
 <20120905181923.2e330a63@mjolnir.ossman.eu>
 <s5h4nnczaoq.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============8753699189189154075=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp-relay.ossman.eu (saehrimnir.ossman.eu [193.12.253.10])
 by alsa0.perex.cz (Postfix) with ESMTP id D7E9526007E
 for <alsa-devel@alsa-project.org>; Wed,  5 Sep 2012 19:22:44 +0200 (CEST)
In-Reply-To: <s5h4nnczaoq.wl%tiwai@suse.de>
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

--===============8753699189189154075==
Content-Type: multipart/signed; micalg=PGP-SHA256; protocol="application/pgp-signature"; boundary="=_freyr.ossman.eu-26335-1346865763-0001-2"

This is a MIME-formatted message.  If you see this text it means that your
E-mail software does not support MIME-formatted messages.

--=_freyr.ossman.eu-26335-1346865763-0001-2
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

On Wed, 05 Sep 2012 18:39:01 +0200
Takashi Iwai <tiwai@suse.de> wrote:

> At Wed, 5 Sep 2012 18:19:23 +0200,
> Pierre Ossman wrote:
> >=20
> > Noone with any insight? I'm ready to do some leg work, but I couldn't
> > find anything in either the HDA specification, or the AMD
> > documentation. :/
>=20
> Well, HD-audio HDMI codec driver just extracts the available channel
> setup from the given ELD, and the ELD data is sent from the graphics
> driver.  So, if anything missing in ELD, it's supposed to be in the
> graphics driver side.  In other words, if ELD doesn't give 6 channels,
> HD-audio codec won't follow that channel setup, too.
>=20

I see. I got a bit confused by this code though:

	/* Restrict capabilities by ELD if this isn't disabled */
	if (!static_hdmi_pcm && eld->eld_valid) {

Which made me think that the ELD was just used to make sure you didn't
send something the other end couldn't handle. IOW, eld_valid =3D=3D false
would give you all features the hw was capable off.


Some follow up questions, to confirm I haven't confused things:

 - The ELD really needs to go into the hardware, not just end up in the
   hands of the audio driver? IOW, we cannot override this?

 - The HDA interface only defines reading the ELD, so writing it would
   have to be done by the graphics driver using some GPU interface?

If so, I need to poke the AMD guys as I couldn't find any information
in the public documentation about writing the ELD.

Thanks
--=20
     -- Pierre Ossman

  WARNING: This correspondence is being monitored by FRA, a
  Swedish intelligence agency. Make sure your server uses
  encryption for SMTP traffic and consider using PGP for
  end-to-end encryption.

--=_freyr.ossman.eu-26335-1346865763-0001-2
Content-Type: application/pgp-signature; name="signature.asc"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment; filename=signature.asc

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.18 (GNU/Linux)

iF4EAREIAAYFAlBHimIACgkQopDLsoqlmEK0rQEAyQaf87b4u8DDp9IZRFPmKtUZ
UuplEHWK5d/0b7WKaoMA/1E3sEZTnXMfnjxv7MbiToB3X3vbVAq3XWp1R3peCTRh
=XPno
-----END PGP SIGNATURE-----

--=_freyr.ossman.eu-26335-1346865763-0001-2--

--===============8753699189189154075==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============8753699189189154075==--
