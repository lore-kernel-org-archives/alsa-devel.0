From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH v3] ASoC: rt5677: make volume TLV closer to
	reality
Date: Fri, 5 Dec 2014 11:08:28 +0000
Message-ID: <20141205110828.GK11764@sirena.org.uk>
References: <1417741213-11326-1-git-send-email-dgreid@chromium.org>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============4447509984367914845=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 53109260599
 for <alsa-devel@alsa-project.org>; Fri,  5 Dec 2014 12:08:45 +0100 (CET)
In-Reply-To: <1417741213-11326-1-git-send-email-dgreid@chromium.org>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Dylan Reid <dgreid@chromium.org>
Cc: oder_chiou@realtek.com, alsa-devel@alsa-project.org, tiwai@suse.de, anatol@chromium.org, benzh@chromium.org, bardliao@realtek.com
List-Id: alsa-devel@alsa-project.org


--===============4447509984367914845==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="8tUgZ4IE8L4vmMyh"
Content-Disposition: inline


--8tUgZ4IE8L4vmMyh
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Dec 04, 2014 at 05:00:13PM -0800, Dylan Reid wrote:
> The volume blocks have an step of 0.375dB, but TLV uses 0.01dB for
> units.  Only use the resolution supported, ignoring the LSB of the
> volume register.  This results in half the steps and 0.75dB per step,
> but reports accurate levels through TLV.  Update the masks to reflect
> that these are registers have the LSB ignored.

Applied, thanks.

--8tUgZ4IE8L4vmMyh
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBAgAGBQJUgZIsAAoJECTWi3JdVIfQVo0H/2rpX3KMHJZ+u5FrhyuMRbz6
jvWyq3mB2ftOTL3fH3qju+9kQZMXsqqpfhDJNsxaN3uOYPUG7n06qoGjdCZoNt78
B9hQEOViiy4JYBeEWCUPxOtmUgBgY4QAvJuzYlDbQjBtzK1O4pXd8AUOJMnvxXqt
K38ugRnkWsKifX/5derMYpMJonPiIwOYPxJZOjQ1t9IZR0iQ05ThA8K6D2eG2sDQ
C8PXKqwtnHRBLWzO5AomRGMp4CBD7vpbxCEkAL+RoPs7ATmCLcp60Y8QugCIIM+h
MZW9h6ySqjY7HUldj3O91Mx5kqba9+W7aS5kmQvxg6hjgykmId2d4AugjhwjBoA=
=0bWb
-----END PGP SIGNATURE-----

--8tUgZ4IE8L4vmMyh--

--===============4447509984367914845==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============4447509984367914845==--
