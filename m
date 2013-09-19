From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH] ASoC: rt5640: ifdef for ACPI module table
Date: Thu, 19 Sep 2013 13:02:36 +0100
Message-ID: <20130919120236.GN21013@sirena.org.uk>
References: <1379484624-11029-1-git-send-email-olof@lixom.net>
 <20130918094158.GL21013@sirena.org.uk>
 <CAOesGMj52_xcKS4q54i_gw_T2xWt=c6rwBtP9Ds2LbytjRuNKQ@mail.gmail.com>
 <20130918153842.GA21013@sirena.org.uk>
 <20130918165334.GA26446@quad.lixom.net>
 <20130918172858.GE21013@sirena.org.uk>
 <20130918173620.GA28143@quad.lixom.net>
 <20130918183401.GG21013@sirena.org.uk>
 <CAOesGMh1zSFnYTBjLdUPBv6od_K0okrTTipnhu6BjO-QX1X6PA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============3174108151284270474=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
 by alsa0.perex.cz (Postfix) with ESMTP id 9FA04261A10
 for <alsa-devel@alsa-project.org>; Thu, 19 Sep 2013 14:02:46 +0200 (CEST)
In-Reply-To: <CAOesGMh1zSFnYTBjLdUPBv6od_K0okrTTipnhu6BjO-QX1X6PA@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Olof Johansson <olof@lixom.net>
Cc: liam.r.girdwood@linux.intel.com, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, Arnd Bergmann <arnd@arndb.de>
List-Id: alsa-devel@alsa-project.org


--===============3174108151284270474==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="dRZtNaFcRiL7vj6v"
Content-Disposition: inline


--dRZtNaFcRiL7vj6v
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Sep 18, 2013 at 11:44:18AM -0700, Olof Johansson wrote:

> > Hrm, perhaps that was what was supposed to happen - have
> > MODULE_DEVICE_TABLE() create the appropriate eliminateable static
> > reference so the compiler can figure things out and we don't need the
> > ifdefs.  It'd certainly be nice to elimiante more of these ifdefs.

> Easiest way to do that is probably to provide a new macro to declare
> the match tables with, that compiles out and/or gives appropriate
> attributes depending on what is enabled or not in the config. That
> gets rid of the ifdefs but we don't have anything like it today.

Yup.

> I'm honestly not sure I think it's needed, the ifdef for the table
> doesn't bother me. But if people feel strongly about it then it's
> likely the best way forward.

For me it's not the tables per se, it's the general proliferation of
options to get coverage on making things more error prone - the more
things always get seen by the compiler the better.  I'm not sure I care
enough to actually do the work but it's nice when someone has done it.

Anyway Thierry sent the #ifdef version of the patch so this is sorted
now.

--dRZtNaFcRiL7vj6v
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.21 (GNU/Linux)

iQIcBAEBAgAGBQJSOufYAAoJELSic+t+oim9APIQAIfFl3fwvwu5aIoQANlFprLy
YOhf56guMTkZNWqSJ8CJ5p7Petic98FwUSRW8LLFfTkkpA408zBCvW0Uq4o+k70H
hBxj4Wv+wdMfjNExLBgXt5fh+KEQinetTD6I0kuU8lBpUaxkMBhb37QBMG28u41Z
Pf+Ve20ahnUCgHSbNThxtHF6QSMfsw7rDb/SdWYqlQBZJ6tYDX9i3FCQZsnJwayy
I7jutMxVChKJKUz2NNF57EBypU1OP4fFGL6bxQSNqqP4vIbhBPQm+YhjfqYYNGaK
Z0x5op5c7OsRXiXwgkDZqgiOY1r33nQwOepBuwTLdmAdAdtTm65pD4ux2DCaXUzL
qIgary0MpXliEFzRNW3tmDUVNaAYrvXJKL07lewROKpi65CU0CdhAhR4NF8e4g+l
QtWO1XzHNfKx4aoPP64CDD7TcH5D9P0hLiiHCE1l3f4TC+S7/7NSEDOckVCem7Fu
rkBp9kr3YfCrpxSQFozhipXu9uWKH7hRw+Ph13VGl/DfHzyqyWaAfAcTWMOw2kuw
G7J1l9zYGu1zVq2ii9XxFg9sRZlzuQkmVGI/DD33rBooTPeOnEYhTq/HAmjtfGBB
94XmGzJ/FnuN9opOzfjiEHPk9pgBXqA6vXsuzYCiNObvlBEY2XzZHY+P3zjcefF5
GzqOc1zQkMSe2R70GeGa
=k3M+
-----END PGP SIGNATURE-----

--dRZtNaFcRiL7vj6v--

--===============3174108151284270474==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============3174108151284270474==--
