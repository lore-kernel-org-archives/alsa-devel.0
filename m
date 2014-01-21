From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH] ASoC: da9055: Partially fix device
Date: Tue, 21 Jan 2014 11:07:01 +0000
Message-ID: <20140121110701.GA17314@sirena.org.uk>
References: <20140109121353.GG31886@sirena.org.uk>
 <2E89032DDAA8B9408CB92943514A03376B7CC9BE@SW-EX-MBX01.diasemi.com>
 <20140109202446.GQ12858@sirena.org.uk>
 <2E89032DDAA8B9408CB92943514A03376B7CCB98@SW-EX-MBX01.diasemi.com>
 <20140113211858.GK29039@sirena.org.uk>
 <2E89032DDAA8B9408CB92943514A03376B7CCF27@SW-EX-MBX01.diasemi.com>
 <20140114195159.GW15567@sirena.org.uk>
 <2E89032DDAA8B9408CB92943514A03376B7CD24A@SW-EX-MBX01.diasemi.com>
 <20140117172025.GW17314@sirena.org.uk>
 <2E89032DDAA8B9408CB92943514A03376B7CDC48@SW-EX-MBX01.diasemi.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============7018870953267146711=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id DB22F2610D7
 for <alsa-devel@alsa-project.org>; Tue, 21 Jan 2014 12:07:09 +0100 (CET)
In-Reply-To: <2E89032DDAA8B9408CB92943514A03376B7CDC48@SW-EX-MBX01.diasemi.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: "Opensource [Adam Thomson]" <Adam.Thomson.Opensource@diasemi.com>
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, "linaro-kernel@lists.linaro.org" <linaro-kernel@lists.linaro.org>, "Opensource [Anthony Olech]" <anthony.olech.opensource@diasemi.com>
List-Id: alsa-devel@alsa-project.org


--===============7018870953267146711==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="aPIqI//Qhze8VsLV"
Content-Disposition: inline


--aPIqI//Qhze8VsLV
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Jan 21, 2014 at 12:35:11AM +0000, Opensource [Adam Thomson] wrote:
> On Fri, 17 Jan 2014 17:20:25 +0000, Mark Brown wrote:

> > What I would suggest doing is writing a binding document for the device
> > (which seems to be missing anyway) and sending that along with patches
> > changing both the MFD and CODEC compatible strings and IDs and adding
> > comments saying that this is intentional to ensure that nobody cleans
> > this up again.

> Ok, I'll look into that. I guess it makes sense to write one document for the
> PMIC and one for the CODEC as well, given their individual nature?

I don't really mind either way but if they are split then the documents
should reference each other to avoid confusion.

--aPIqI//Qhze8VsLV
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJS3lTRAAoJELSic+t+oim9rikP/16/5A7R2Q+DlQ1mmXInknYe
4vLCxJ7YPDpFKAJ5I64ps9tuDaQWbU872D5/DjUL1wbSIdzpueD6XCtXglyfd49Q
lKCuH4+J9Tg5O4sQuqQDvwh/31UkPt4/bDR9Os8+LlESWfQS+3tRGYdUuvTvwa3u
PCpuYFeniuZt5wuujkoN9djtEZQgjrsn4AXwRtOGN7Cwy9Qg81q8dzaJtke/m+FK
KxhL5yY/tDFxBlpMj57q6llF4dLKC8g7TWen5M2OSGyVGoHKa6o71cUezQ24Gy/a
SrbQh12I7IIm19GyTgibZfMuTVwy0hZPIiwBfIS87OLqbs8du9Q1wFZiXwkxOoi0
DaxaFG7h9948bN0uW2Z8wu/z90jTrM99q3cD0hSyTQFblNYXd11UDOZ5wKqjj+qV
9BtcZwtd7BxW+e7EDSvPmU+Ob6daRJHvDhBXAaKxi+2wSVG8muLqW12WHPCfLcHg
DGWAfuXr4bQWMxRHJ7VJDpy9DB3k7o3v+ZRUIRzM+Xi+bhmF8z5qYC4vpQ/y2Yqm
Qmt0zsRe5R6jH7XN3CeeqP9DLVWt53OGIwiFvqrUeDal7ZRp9YNpknKIPmnMGCCb
PRkGuyuWzl3ajB8qhSV2dauw/141yvSLyhfN/emDiUKJWhD29xiiaw4zMMhboLRh
Aef/zfEQT6k2WsIWuNxt
=zL6M
-----END PGP SIGNATURE-----

--aPIqI//Qhze8VsLV--

--===============7018870953267146711==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============7018870953267146711==--
