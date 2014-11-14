From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH v2] ASoC: Fix kerneldoc errors
Date: Fri, 14 Nov 2014 17:29:24 +0000
Message-ID: <20141114172924.GJ3815@sirena.org.uk>
References: <1415652427-827-1-git-send-email-tiwai@suse.de>
 <20141114125704.GA3815@sirena.org.uk>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============4787730141277676831=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 9E823260554
 for <alsa-devel@alsa-project.org>; Fri, 14 Nov 2014 18:30:50 +0100 (CET)
In-Reply-To: <20141114125704.GA3815@sirena.org.uk>
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


--===============4787730141277676831==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="g9b6WCOLI3ybFZyi"
Content-Disposition: inline


--g9b6WCOLI3ybFZyi
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Nov 14, 2014 at 12:57:04PM +0000, Mark Brown wrote:
> On Mon, Nov 10, 2014 at 09:47:07PM +0100, Takashi Iwai wrote:
> > Lots of typos and missing parameter descriptions.
> >=20
> > Some private struct fields are moved to the end of struct and put
> > markers to make kerneldoc happy (and it make even easier for human
> > readers).
>=20
> This would've been better split up more.  I've applied it, a couple of
> smaller things though:

Actually I had to revert this, it applies cleanly against Linus' tree
but is causing annoying merge/apply issues with my current tree.

--g9b6WCOLI3ybFZyi
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBAgAGBQJUZjv0AAoJECTWi3JdVIfQG7oH/AqyPCOUCg8F+wiE3JJ+ZsMM
5G3akCevgJrHcsTh5bRXMzG2xL7q1QeoLNvzDTyiSH6sxVkDuqt5IyeIG0r0635t
QUahkw9lEKfixoy/3GJESyEPkhPv0UP71nax5HCl0Y4q2+CDyHshXMjpfeoM5/5t
YvWH/EKmmUe+Pnc5AHmBc9TXdshzOCy+AbxSkDsekgGezUUuERzGetL5b3/GNHYJ
bMZz9zgYpQT108izsLY8XBlfS9RtVzsVBnIcO1uzR1EPaPGBZb84GEhAScsxEeSp
6htPv14dXlIzyBlcI3j5nTI0P1L6beVTLlxVnOVlzJeOnhi+O8dYB/Nk0in2ti0=
=vmMn
-----END PGP SIGNATURE-----

--g9b6WCOLI3ybFZyi--

--===============4787730141277676831==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============4787730141277676831==--
