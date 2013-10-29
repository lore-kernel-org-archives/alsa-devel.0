From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH v2] ASoC: Add pinctrl PM to components of
 active DAIs
Date: Tue, 29 Oct 2013 09:19:59 -0700
Message-ID: <20131029161959.GF16686@sirena.org.uk>
References: <1383016374-30919-1-git-send-email-b42378@freescale.com>
 <CAH9JG2X3HHLYLuyPzT3TPX4N0nwJR7xU4yhnkFWyMxHeEV3mbg@mail.gmail.com>
 <20131029032512.GA8812@MrMyself> <20131029034220.GB8812@MrMyself>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0722302534860869091=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
 by alsa0.perex.cz (Postfix) with ESMTP id DE01B26109A
 for <alsa-devel@alsa-project.org>; Tue, 29 Oct 2013 17:20:19 +0100 (CET)
In-Reply-To: <20131029034220.GB8812@MrMyself>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Nicolin Chen <b42378@freescale.com>
Cc: alsa-devel@alsa-project.org, Kyungmin Park <kmpark@infradead.org>
List-Id: alsa-devel@alsa-project.org


--===============0722302534860869091==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="oFbHfjnMgUMsrGjO"
Content-Disposition: inline


--oFbHfjnMgUMsrGjO
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Oct 29, 2013 at 11:42:20AM +0800, Nicolin Chen wrote:

> So I think maybe I was right at the first place that it's okay not to set
> a condition here? Since the card is going to suspend, why do we need to
> care codec's behavior? Please correct me if I'm wrong.

There's no reason CODECs can't implement pinctrl if they want to.

--oFbHfjnMgUMsrGjO
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJSb+AsAAoJELSic+t+oim9FsIP/jQMlcwrvUDrzwEaHkvzkF5R
YvEphai5ne6Fltc0xlK2cEZpS0Fe7pObCsrmGkjrbniDkHTQy7u3RNo6+c+jsIk3
iFwzZW2xaftcQDFQfetrnkLEZ8TExuCX1/BQ1vnzKIifqqthdyCOWlybhOPZWv9A
corCSopNOM4Eap9JOBNIf75A54HMD3w/VizA9W7Mjkc2XcCGuJgIE9534OFI08U6
nVbI5Vf6BJw5iOviJFUyl0Fnp+bwTni+npkpUNWv/xhcU+S8Ag2y5I8aSEzwouIa
AvqElim4ZK4VEnfLkD2iVEY8rLttnWfeoe3D7dShjmEBjCAskxBNsxthW2OyJOMP
dDsmhKoWR3dInnxvZhjhJ48BUzCwSnuNpEXl9Ma0T8Tg3C/F5cR+5WH1ZTIt8K9i
ANifI5nWRClAPoTWE59Ua6XgIuvZlX4Rz1pZZL074Uqaez1F7ay6OO23jMc1IV6h
01I0BNdWvX+ihUrdsOkfrg6Au+I3QAat0Fs55Dg8NTDvJTdR2BB6K7PQ2gU1KS89
GyzHd8KNtdPvDvQSfmclEsKMwqYEp6SznDNNsSkkVQhQx7jT6P6pf60y9aAjXDUa
CO5Mje97oMr+IbqdI6INEDqwVdkAHdz8g8N1X2uCY5DhTF4XCQ6xc0JoDcQazBse
xclu4ty3Q5eOuOeF4ihJ
=gBB8
-----END PGP SIGNATURE-----

--oFbHfjnMgUMsrGjO--

--===============0722302534860869091==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============0722302534860869091==--
