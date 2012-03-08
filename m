From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH] ASoC: dapm: Add API call to query valid
	DAPM paths.
Date: Thu, 8 Mar 2012 12:05:54 +0000
Message-ID: <20120308120554.GL3638@opensource.wolfsonmicro.com>
References: <1331142952-6502-1-git-send-email-lrg@ti.com>
	<20120307191547.GX3107@opensource.wolfsonmicro.com>
	<1331206950.3782.5.camel@odin>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============3333029842707710469=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 54CB010BA57
	for <alsa-devel@alsa-project.org>; Thu,  8 Mar 2012 13:05:56 +0100 (CET)
In-Reply-To: <1331206950.3782.5.camel@odin>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Liam Girdwood <lrg@ti.com>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org


--===============3333029842707710469==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="lbQeYSs6J2ITmUo7"
Content-Disposition: inline


--lbQeYSs6J2ITmUo7
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Mar 08, 2012 at 11:42:30AM +0000, Liam Girdwood wrote:
> On Wed, 2012-03-07 at 19:15 +0000, Mark Brown wrote:

> > I might be blind but I think the hunk that actually declares the widget
> > list got dropped from the header...  probably in some other part of the
> > series you haven't pushed out yet?

> I had to double check myself to be sure and Stephen added it a while
> back :-

> fafd2176f72148e83c64a1f818ff33fceed83d08

Oh, sorry about that - I didn't check the actual code for that one as I
saw you adding the forward declaration and normally we're fairly good
about always adding those so I figured it was a missing diff hunk.

> > > +	dapm_reset(card);

> > This function isn't in mainline, another patch series reordering thing I
> > expect. =20

> It's in 6c120e19fa587710d80757a6e364961a017fb6c3

This one I definitely did check, must've been on a separate branch and
didn't notice properly.

--lbQeYSs6J2ITmUo7
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iQIcBAEBAgAGBQJPWKCbAAoJEBus8iNuMP3dm0IQAIdLALiR7EFziV9KlNIfGyq8
eejKOzfgmPdWVNlJ8tGx7BEpWFnO1EXKhcfSxlBUbNL8gFI3TXXP649HDkkDqkA2
LnKbgZ29il9Bt1PU6EaawsEOl/ZVl1GwKkalMMuTILj+WS/j+abgvG3306szpRW8
6pEzCLpoiBVATPPoWPOkmYFRZFGoFYiL+7feZngQ2M6uVHp5ixoIe8mY8BjJll9x
9o9waib0ZDX+oOw+SrC3yXTdRR4Lc0vwKuoaMcvTSMdkhw5DfegeKDTA0A+UYOMX
vENBN+XvQQXE5VQlz1JLERNZALoLWcNO/VZdKDf27ZmquKjfZz5INsBSCYiOCt3L
CIDzB1Sy2BiFTG5PZ63MmsGhsvgEFxMDT0yDCqwaARcsnefYCgd571TMK+/azXny
vZZ2yY7j7SfmeF+5TqwzZoi00VQ3iF3dvGUniBFhsclmW4xSNgaK00SRPwZgm0pD
5dwIla/CZDfcsynztFvVHnmvIsEPGSzY+MR2dRLqOkbllKDbCtRLYG+DESvED52o
r3MMZoLeeB1p94Frx3EI3GTen/40v4Qx4IcGHjaoa9yG4+TwCxARpJ0qm7cP37kd
wu2ATQgbTINz4ynM0dkhlBY8F4C7Myk/DOpStxQDMeT8RKRilpLCb7/9qm5sd+0n
9XfR1oKvIvgpj+VvqKEa
=2G4o
-----END PGP SIGNATURE-----

--lbQeYSs6J2ITmUo7--

--===============3333029842707710469==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============3333029842707710469==--
