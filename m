From: Pierre Ossman <pierre-list@ossman.eu>
Subject: Re: radeon multi-channel lpcm
Date: Thu, 6 Sep 2012 09:52:51 +0200
Message-ID: <20120906095251.65f81ffc@mjolnir.ossman.eu>
References: <20120831223447.065fcb62@mjolnir.ossman.eu>
 <20120905181923.2e330a63@mjolnir.ossman.eu>
 <s5h4nnczaoq.wl%tiwai@suse.de>
 <20120905192239.6a212683@mjolnir.ossman.eu>
 <s5hpq5zitd3.wl%tiwai@suse.de>
 <20120906090900.63328552@mjolnir.ossman.eu>
 <s5h7gs7ip8r.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============6610112485246468878=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp-relay.ossman.eu (saehrimnir.ossman.eu [193.12.253.10])
 by alsa0.perex.cz (Postfix) with ESMTP id 54DBB265CAA
 for <alsa-devel@alsa-project.org>; Thu,  6 Sep 2012 09:52:57 +0200 (CEST)
In-Reply-To: <s5h7gs7ip8r.wl%tiwai@suse.de>
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

--===============6610112485246468878==
Content-Type: multipart/signed; micalg=PGP-SHA256; protocol="application/pgp-signature"; boundary="=_freyr.ossman.eu-21391-1346917974-0001-2"

This is a MIME-formatted message.  If you see this text it means that your
E-mail software does not support MIME-formatted messages.

--=_freyr.ossman.eu-21391-1346917974-0001-2
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

On Thu, 06 Sep 2012 09:28:52 +0200
Takashi Iwai <tiwai@suse.de> wrote:

> At Thu, 6 Sep 2012 09:09:00 +0200,
> Pierre Ossman wrote:
> >=20
> > But if you're saying that the hardware doesn't really need the ELD,
> > then steps 3-4 could be replaced by a pure software channel.
>=20
> No, what I meant is about the audio codec perspective.  From the audio
> codec, it has no direct hardware access to GPU that actually handles
> the ELD register things.  It always communicate via HD-audio verbs to
> send/receive DIP bytes so the actual work is purely in the graphics
> driver side.
>=20

I assume "codec" here is in the HDA sense, as in the hardware hiding
somewhere behind the HDA interface.

In the Intel case, I'd say the audio hardware as a whole does have some
back channel to the GPU since a write to a GPU register somehow results
in data in the audio hardware. But yes, it would be a purely graphics
driver thing as it has both the ELD, and access to the registers you
can write to.

I'm working on the assumption that the radeon hardware works in similar
fashion as the Intel ones.

> > This would
> > be convenient as it is currently unknown how to do 3) on radeon.
> >=20
> > (2 is currently missing in the radeon driver, but it is trivial to add
> > AFAICT)
>=20
> Yeah, that's the big missing piece.
>=20

So I'll go poke the AMD people, as I cannot find anything in the public
docs about ELD registers. Hopefully it's not something that's still
classified... :/

Thanks
--=20
     -- Pierre Ossman

  WARNING: This correspondence is being monitored by FRA, a
  Swedish intelligence agency. Make sure your server uses
  encryption for SMTP traffic and consider using PGP for
  end-to-end encryption.

--=_freyr.ossman.eu-21391-1346917974-0001-2
Content-Type: application/pgp-signature; name="signature.asc"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment; filename=signature.asc

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.18 (GNU/Linux)

iF4EAREIAAYFAlBIVlUACgkQopDLsoqlmEI7mAEAip5fpN493q5vqJRF4Wq320qn
HGxPt0miEF4zzSKzHB4A/j1tU3QHhOreYRCKjulM1LFmzQZlMzhC2pUd+daylYAx
=pzQS
-----END PGP SIGNATURE-----

--=_freyr.ossman.eu-21391-1346917974-0001-2--

--===============6610112485246468878==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============6610112485246468878==--
