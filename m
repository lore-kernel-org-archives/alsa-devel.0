From: Mark Brown <broonie@kernel.org>
Subject: Re: ASoC: sgtl5000: SMALL_POP and loud click noise 5
 secs after playback stopped
Date: Tue, 7 Jun 2016 00:52:32 +0100
Message-ID: <20160606235232.GQ7510@sirena.org.uk>
References: <20160606220025.GA2308@archie.localdomain>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============2703787107847691613=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id C368A265755
 for <alsa-devel@alsa-project.org>; Tue,  7 Jun 2016 01:52:40 +0200 (CEST)
In-Reply-To: <20160606220025.GA2308@archie.localdomain>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Clemens Gruber <clemens.gruber@pqgruber.com>
Cc: Fabio Estevam <festevam@gmail.com>, alsa-devel@alsa-project.org, Axel Lin <axel.lin@ingics.com>, Alexander Stein <alexander.stein@systec-electronic.com>
List-Id: alsa-devel@alsa-project.org


--===============2703787107847691613==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="XQ/JOjNzrAcf1KaA"
Content-Disposition: inline


--XQ/JOjNzrAcf1KaA
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Jun 07, 2016 at 12:00:26AM +0200, Clemens Gruber wrote:

> since commit b101acfabc9377469af3abfb7cb63112da367284 I can hear a loud
> click / pop noise, always occuring 5 seconds after playback stopped.

Please include human readable descriptions of things like commits and
issues being discussed in e-mail in your mails, this makes them much
easier for humans to read especially when they have no internet access.
I do frequently catch up on my mail on flights or while otherwise
travelling so this is even more pressing for me than just being about
making things a bit easier to read.

> Axel: Did changing SGTL5000_SMALL_POP to 1 remove a click/pop noise on
> your board or did you just notice the error with the mask argument of
> snd_soc_update_bits and fixed it?

I would be very surprised if Axel has one of these boards, he does a lot
of cleanup work based on code/datasheet analysis.  I suspect it's more
likely that the chip feature simply doesn't work properly and we're
better off not using it.

--XQ/JOjNzrAcf1KaA
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJXVgzAAAoJECTWi3JdVIfQ1nUH/0jOcXTWx60H9CvJ7/Kuclha
tMm+tZkfqkSQQiHMsmeqoGWgmAM0mGOp9sLTNQYVfNy4RFllb7N9PHWUX4X9D6Z9
fQCHIUiVH6hVMqKQP8QCAtM7IifLWKxozSAv4ka9ohpRc7vAwocszXy7KdnAubt7
LhOar+bWq0fE8nH70rMxcsUxJFyxst5MYZ4WxkSkuniwaSEBA/0EPt096BUcnFy9
WMnj0hbl3R1sfgpnLtmqnCoERe/PRUkQs5VZ1EPTGCqcY6m8B/942W1/GQ8cWIA5
TjZ9h8XMxEWeeToFM+opbT73EiTFGxXqrSk9/GAjFyB7cn5KQos5hCbU/ZdFVRI=
=LAE4
-----END PGP SIGNATURE-----

--XQ/JOjNzrAcf1KaA--

--===============2703787107847691613==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============2703787107847691613==--
