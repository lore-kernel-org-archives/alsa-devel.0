From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: question on snd_soc_dai_link_event
Date: Thu, 22 Nov 2012 09:32:41 +0900
Message-ID: <20121122003239.GA4371@opensource.wolfsonmicro.com>
References: <9C1683ABA24673439FCD019782C9F4BBDA2A1C1582@SAFEX1MAIL1.st.com>
 <20121026170142.GZ18814@opensource.wolfsonmicro.com>
 <9C1683ABA24673439FCD019782C9F4BBDE4BD6E569@SAFEX1MAIL1.st.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1025367948205522096=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource.wolfsonmicro.com (opensource.wolfsonmicro.com
 [80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 5198A265DB0
 for <alsa-devel@alsa-project.org>; Thu, 22 Nov 2012 01:32:47 +0100 (CET)
In-Reply-To: <9C1683ABA24673439FCD019782C9F4BBDE4BD6E569@SAFEX1MAIL1.st.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Sebastien LEDUC <sebastien.leduc@st.com>
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, "Liam  Girdwood (lrg@ti.com)" <lrg@ti.com>
List-Id: alsa-devel@alsa-project.org


--===============1025367948205522096==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="OgqxwSJOaUobr8KG"
Content-Disposition: inline


--OgqxwSJOaUobr8KG
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Nov 21, 2012 at 06:56:55PM +0100, Sebastien LEDUC wrote:

> For a capture stream, it creates the following routes:
> Cpu_dai widget -> dai_link widget -> codec_dai widget

> And for a playback stream:
> Codec_dai widget -> dai_link widget -> cpu_dai widget

Remember that for a CODEC<->CODEC link both devices will be CODECs so
their widgets have the opposite sense as everything is named in a CPU
centric fashion.  The important thing is that we link playback to
capture and capture to playback.

--OgqxwSJOaUobr8KG
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIcBAEBAgAGBQJQrXKVAAoJELSic+t+oim98IUQAJgU6d0qW87BhLxuZgajZHTY
s7uFE1IPJt536m/T5Y02HRpoNtygLx4dY3+c+oB9nkCtR/Ud3SzxJT1C1ZRghUDM
H6zSf4kPWda9+hjvjvPHWn3p/px5TvGkMqiWL9DQkTMCQ4M85cNF4GDUBoJz4Jr+
fXbtIC/oxXHlUFy6G8Pe5OiqLdv9w6YUhu0qRHjVvoQlNQonlGe/upPAscXCKev2
pLfrf8ld9Fe1fOAtmn1OGOCeMtdHdq5lTp/3tCjIuctIFx+eLdBIKaC+StRKZQQ3
DLJRAkfeKgFn70o+wJdwn9tp/90HDxXtaeDsZ7ZF61PJ+O3hnYpViGwuZv6NRcUU
KcCFE6KFGgpIsup1CStsTPnwBVqq3Ok0uILE6lluBJ/jZ/2LearEbczksSJWe2TK
kxak9PPyVVUvGQqxqXD8hMOdXqiYgZzAuWztWICbXxZuHcZYGjbNYacYLH45RQKb
OQhYNgcQ41551LnP5lLVnuE4TDeFHlJg41sTDdF7UKc9lYermOipjBPmv1M0jpxD
tuQ9dYs3fZ8W0B9neKkslTSqslPQgKStcTHFCKNxIb4b3Xv5tonlmCuri0mjdks2
AQ0XfD4Ol1hhvAq59aI8MhnKr4H+xXwTu0GS5LVvZBt43wrN1sZtsIJBqS0DnTxr
WghdPx8BP6xwAReI08tt
=2opF
-----END PGP SIGNATURE-----

--OgqxwSJOaUobr8KG--

--===============1025367948205522096==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============1025367948205522096==--
