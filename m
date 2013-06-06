From: Mark Brown <broonie@kernel.org>
Subject: Re: Generic clock divider indices
Date: Thu, 6 Jun 2013 14:56:05 +0100
Message-ID: <20130606135605.GB9980@sirena.org.uk>
References: <51B09224.9050409@gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============4843100004797554165=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
 by alsa0.perex.cz (Postfix) with ESMTP id 93ACA261ACC
 for <alsa-devel@alsa-project.org>; Thu,  6 Jun 2013 15:56:08 +0200 (CEST)
In-Reply-To: <51B09224.9050409@gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Daniel Mack <zonque@gmail.com>
Cc: ALSA development <alsa-devel@alsa-project.org>, Liam Girdwood <lgirdwood@gmail.com>
List-Id: alsa-devel@alsa-project.org


--===============4843100004797554165==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="+g7M9IMkV8truYOl"
Content-Disposition: inline


--+g7M9IMkV8truYOl
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Jun 06, 2013 at 03:44:04PM +0200, Daniel Mack wrote:

> Would it be an idea to define some commonly used dividers in the core?
> If they start at 0x80000000, they won't collide with existing ones, and
> we could simply add them as alternative case statements to existing drivers.

I don't think this is a terribly sensible idea; as soon as you start
relying on these dividers in machine code you're going to run into
drivers that just don't implement them either due to hardware or due to
them being able to figure things out by themselves and...

> Some commonly used ones I can think of are

> 	MCLK / BCLK
> 	MCLK / LRCLK
> 	BCLK / LRCLK

> That way, platform code could just pass the values dows to the codec
> drivers, whether or not they know what to do with it.

...frankly the above all look like dividers that the drivers should just
be figuring out all by themselves anyway without bothering the machine
driver.  If that's the sort of stuff you're having to do it seems more
generally useful to work on making the relevant drivers require less
manual control by the machine driver.

--+g7M9IMkV8truYOl
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.20 (GNU/Linux)

iQIcBAEBAgAGBQJRsJTyAAoJELSic+t+oim9RtwP/1BQ1yaArtiPHIabtne30O6B
VmmrEV2wBkxP0xJxgKXKChrbkhMWaco3a5cGpOkuiyhGIXrr1BXlNWj+Yqy9SGQC
7lFpdxDy/34TQXHddeYZOaFLAIIsdLQwHwL+ypqkUAV5d+2D4WWBlK4XST0utqmm
Cc6qWkJrlF74Yq/3CcGcQACvVVSVSopJzmrQqdwaDRA4an92wmfTYn5zHozpC2hz
GxI1gpuIv6xzYcOJnNRFACV5OtqhiZymeM7vfZC2cj/AdshmVFz682RosNxh5t1m
rjCwy9+k+aJ4vm42GMAnrRo3JI8dXmaa0CkwE/suvKSW5xLfEijdtg450WDlHtdk
KXw/deyS7PJo94eXLjTHT3tG4r6i6cmZ+p+4EDl9WMXG+r1245XseuMJUAIKMeMS
BMwCZ1QvjVgz7Ky3qYQhK86kDa4mpGA4z+UxuZQFtIJqykWSwPHQ5zVXHuXzFdga
b5zCylokTAO1Qse4bU4PNLunvaCRc+mg6VIPeK+1EUJifVY+2knOC4770Mk7/16H
GywTgxiA1lJhBe4ZX36qWyRY6MxKTcGyxxxhwDCzgqX+kvaT6KaXVW20OtlrMbhQ
+/3aJXw3Lc54WxO4uDgeXvpec6xIehpKXfhyhaHtjpI8socrFSnTFbPrQTfEcRU4
jKorBCu8fMFonzhGzQAm
=3zmC
-----END PGP SIGNATURE-----

--+g7M9IMkV8truYOl--

--===============4843100004797554165==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============4843100004797554165==--
