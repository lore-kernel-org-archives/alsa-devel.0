From: Mark Brown <broonie@kernel.org>
Subject: Re: How to select input from muxer in front of SSI on
	i.MX6
Date: Mon, 22 Sep 2014 18:51:34 -0700
Message-ID: <20140923015134.GE27755@sirena.org.uk>
References: <CAL8zT=iopOiRmo8vT5RNOowucDif-oY2skdrJu=vijiUqpHz-w@mail.gmail.com>
 <20140919175205.GB1736@Asurada>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============6027669511803083105=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 6646C261600
 for <alsa-devel@alsa-project.org>; Tue, 23 Sep 2014 03:51:46 +0200 (CEST)
In-Reply-To: <20140919175205.GB1736@Asurada>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Nicolin Chen <nicoleotsuka@gmail.com>
Cc: Jean-Michel Hautbois <jean-michel.hautbois@vodalys.com>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, Michael Trimarchi <michael@amarulasolutions.com>, lgirdwood@gmail.com
List-Id: alsa-devel@alsa-project.org


--===============6027669511803083105==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="cPi+lWm09sJ+d57q"
Content-Disposition: inline


--cPi+lWm09sJ+d57q
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Sep 19, 2014 at 10:52:06AM -0700, Nicolin Chen wrote:

> This looks like a DPCM (Documentation/sound/alsa/soc/DPCM.txt) to me.

> I'm not sure how to write a DT for DPCM either. But it seems that you
> might need a specific machine driver (guessing).

> I saw Morimoto-san plans to add DPCM into Simple Card, but not sure
> when they will finish it. Otherwise, you may use Simple Card while
> following their defined DT formats.

Depending on what the system looks like it's not at all clear that there
should be any visibility at all of DPCM in the DT - it's a detail of how
Linux is implemented at the end of the day.

--cPi+lWm09sJ+d57q
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBAgAGBQJUINIlAAoJECTWi3JdVIfQRBAH/14WBUFeVt+WbFcW+9DZ4dkT
nQrRq/4vybsxCHwIXSMDoAAhGgv6JxFPWo2wlGWaDXJmGp4ajASrlqPLI+808GRO
DH3E1TIz/33vwrgqVYVM7+F6yp3MSGsWxq1N4W3jc/MvFAi4Chg5935hXsOavDuK
ygWtQ1JAmkiQnrQFMHYVbIjVb4OQWxRlmEntG59Gx7RNVu5TQIEzb2DfVLKjpkYV
tEIOUZ7V4bWDKVmtGSKuaCx57FgSJtQuGAO3ow2d/694EH48MFRyQg4ScJp6xNVv
ElkHTd+khTtcqaNZbmkgTsfD9qnIZ+csrG2l6REtDFyz8B/tj3qZXAVaRM55FP0=
=yV1I
-----END PGP SIGNATURE-----

--cPi+lWm09sJ+d57q--

--===============6027669511803083105==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============6027669511803083105==--
