From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH 2/2] ASoC: dapm: Add cache to speed up
	adding of routes
Date: Thu, 7 May 2015 15:09:46 +0100
Message-ID: <20150507140946.GB31465@sirena.org.uk>
References: <1430994839-32584-1-git-send-email-ckeepax@opensource.wolfsonmicro.com>
 <1430994839-32584-2-git-send-email-ckeepax@opensource.wolfsonmicro.com>
 <20150507124811.GV15510@sirena.org.uk>
 <20150507135222.GB3480@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============6743525252174850586=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id B321C26517F
 for <alsa-devel@alsa-project.org>; Thu,  7 May 2015 16:10:05 +0200 (CEST)
In-Reply-To: <20150507135222.GB3480@opensource.wolfsonmicro.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Charles Keepax <ckeepax@opensource.wolfsonmicro.com>
Cc: alsa-devel@alsa-project.org, lars@metafoo.de, lgirdwood@gmail.com, patches@opensource.wolfsonmicro.com
List-Id: alsa-devel@alsa-project.org


--===============6743525252174850586==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="xXmbgvnjoT4axfJE"
Content-Disposition: inline


--xXmbgvnjoT4axfJE
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, May 07, 2015 at 02:52:22PM +0100, Charles Keepax wrote:

> > This is the only place where we have _check_path_cache() calls so n is
> > always 2 here and it is unclear where that number comes from or what it
> > means without going and peering at the implementation and the commit
> > log.  It seems it would be better to hide that number inside the
> > function.

> I was sort of thinking along the lines of if anyone wanted to add
> CODEC specific levels of searching the cache or some such. But I
> have no problem moving this into the function, probably was a bit
> premature generalisation there.

I think there's probably a long way to go with making the generic cache
more performant before we need to start adding CODEC specific code.

> :-) The original version I did put the pointers in the DAPM
> context, but I somehow managed to talk myself out of it as I was
> nervous of bloating the DAPM context and it felt like this only
> applied to adding routes. Adding it to the card feels kinda
> reasonable as that is where the lists we are caching reside.

If it's just one or two pointers it's not that big a deal in the DAPM
context, we don't have that many of those per card or per system - if it
was going into the widgets that'd hurt a lot more.

--xXmbgvnjoT4axfJE
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJVS3IpAAoJECTWi3JdVIfQcIgH/3dbm0ACLTdrYcAn8HIeGdsc
Ow9Tj/XTLuniZHnm6FVfWGYuQSd8evVJ9KYJgkG2LHHK0tum8yWC066AG1XeE+9/
Z+ntaYdaN12x645GlyT/s9F6yNFJcVuxqcATZ9mFO3I2bA44WS8X1i9/OB15t/u+
fS2xo3sZQvHBDPeXiDTBdJRXWfHMmNmXJYMeqZ1MSGOtucSMDF2FIuXk8GjV2nu0
ieHAD8AxPATdde3YiyYz3uGHRpzX7j7Fhebo0MgMfaL59KdAl4Uw1VSLSg9ITxXB
jI8JZvu7K24fkZFWGXm6fhu0WoRpWRmAL8Z59Hyx0KbAe+YOe3AW+kNOYlnAsco=
=G7NP
-----END PGP SIGNATURE-----

--xXmbgvnjoT4axfJE--

--===============6743525252174850586==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============6743525252174850586==--
