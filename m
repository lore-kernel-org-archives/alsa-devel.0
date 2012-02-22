From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH 1/2] ALSA: Use a define for the number of
 jack switch types
Date: Wed, 22 Feb 2012 16:34:12 +0000
Message-ID: <20120222163411.GQ7340@opensource.wolfsonmicro.com>
References: <1328644128-32630-1-git-send-email-broonie@opensource.wolfsonmicro.com>
	<20120222150210.GB14463@sirena.org.uk>
	<s5hmx8a25o7.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============4713578961885343819=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 8CB7D245AE
	for <alsa-devel@alsa-project.org>; Wed, 22 Feb 2012 17:34:13 +0100 (CET)
In-Reply-To: <s5hmx8a25o7.wl%tiwai@suse.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel@alsa-project.org, patches@opensource.wolfsonmicro.com
List-Id: alsa-devel@alsa-project.org


--===============4713578961885343819==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="K9fy5ol1Oes4Q/ix"
Content-Disposition: inline


--K9fy5ol1Oes4Q/ix
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Feb 22, 2012 at 05:28:56PM +0100, Takashi Iwai wrote:

> I'm fine to apply the first patch, certainly it's just a define.
> Or just commit into your tree with my ack:
> 	Reviewed-by: Takashi Iwai <tiwai@suse.de>

Seems like it'd be sensible to push it through your tree, there's
nothing particularly ASoC related about it and hopefully none of this
stuff will have any impact on anything except HDA (as we'll need to back
out the bodges in there).

--K9fy5ol1Oes4Q/ix
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iQIcBAEBAgAGBQJPRRj1AAoJEBus8iNuMP3dnt4P/3r/s07roQqFLD8/I1CzLeSQ
bJhsaxJr1NKSckoKo7PlO+74cadrlphZR2WMDhf87LNLrWE7lKSUB8Y+CowKCDFy
sy665puaeQU1/P6P4nBtGe4QT4NccYsZMuKxHDh4bgCm8oxtg0wVICDcXo5pSR/W
JUKemxMxO5D+uUs5z7MSfr38+nwWOpigsog9nzsRVshYVabk/PsUxV2olZMK3gDB
hJJ/u3Mz/CRd/MTjbldOAuobnULrBxQ1PMnvWN+Th5jotjnWQxHd3J11vD+gsD+3
a3kGdrSFZNhu0EdVjXqhX9mKO9DRWrCw+ObxxhHRaadO0EP8YlH56f4mStXGQsIz
ZQhLIabwgQ+3wnxozN+IYjJZtTmZw3gboKqKZedJ4wBbtddFEyp67hryjM9uFaay
c1BKMpLJ0IHZ9cNhgipK6miEJg4yhCyW9yvfUj/oT8JURfGd/wxxRJDQ7DXx4twE
uXYcUxrEqfV9hQ0mbcc2Lq11Te71V90llEWJp0G7QqzB9KrLLiwvtC2uSxzAZfIr
UE2Qax853qab8IrXZRdNX/Q0Eb09sttE2vzfgqZRgf6zbjEoSAxlo7+Xj6kUIJ91
CxJ9ZiAQS5JN0z58l4wboR3JZsI/vWQB1jog9T0mnrMHfPgoWLjviFdhKQC48RFs
I3LyZG4ZdOs97a4GLyUX
=Suim
-----END PGP SIGNATURE-----

--K9fy5ol1Oes4Q/ix--

--===============4713578961885343819==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============4713578961885343819==--
