From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH RESEND] ASoC: dont call dapm_sync while
 reporting jack always
Date: Tue, 22 Oct 2013 09:32:23 +0100
Message-ID: <20131022083223.GA20821@sirena.org.uk>
References: <1382362654-26213-1-git-send-email-vinod.koul@intel.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============8403290994274300283=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
 by alsa0.perex.cz (Postfix) with ESMTP id AE3FB2652B0
 for <alsa-devel@alsa-project.org>; Tue, 22 Oct 2013 10:33:04 +0200 (CEST)
In-Reply-To: <1382362654-26213-1-git-send-email-vinod.koul@intel.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Vinod Koul <vinod.koul@intel.com>
Cc: alsa-devel@alsa-project.org, lgirdwood@gmail.com
List-Id: alsa-devel@alsa-project.org


--===============8403290994274300283==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="SLDf9lqlvOQaIe6s"
Content-Disposition: inline


--SLDf9lqlvOQaIe6s
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Oct 21, 2013 at 07:07:34PM +0530, Vinod Koul wrote:
> While reporting the jack status snd_soc_jack_report() invokes snd_soc_dapm_sync()
> always. This should be required when we have pins associated with jack and
> reporting enables or disables these.
> So add a check for this case

Applied, thanks.  It'd be good when doing things like this to say what
the advantage is; with DAPM the general thing is that it gets called a
lot so it should be cheap enough to just call all the time.

--SLDf9lqlvOQaIe6s
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJSZjgNAAoJELSic+t+oim97VwP/1A3k4h1km+jeAfI1JcAAj2q
q6J/VcobUtoM/VaFrWAk50GEs4d5YEHIMyhyHw2zupUHgmudIHgtFco+A1mBu7tV
jCOKCoBnM7xAWBnRiNnbVe5pwDX3Wy8DEu61v0QZy7S6jzC29RU/YiFdOazNkDhj
QaiZ5++3VsbsesK2QtEDSzqITImWNEKkuYdKKfwDka08/NM4uM9Q+KTBf49IIiFb
wV5fcr2HX40rcgTNitUxRTjmDo6w/z2DnwLTNYQJHLmzHCkpYpqI1VriMIJSqfof
CIiGOuiU8HfI/HeL8zB/qVfwDAk555jHY0f8VBMkKPh+toMnN0uPCziRXdShwBLc
uZtL91NHBMzA7/zzGzBnBBnHrs9Sf+RQTymxszhwZQZ9zvG2ld0XZHwxQdskcU0m
ecsCMTbnXFGzOYI9kI548k74aRe0Mjx2Qqin220tOxAWMRVgPsNlfMLFs96Tphci
FUKdcpK4QOB5dRLxfX9aovmC4vvFJymB1wDYTvh1ZDoA1Dn4ADa+2s1sL8rjPlx2
321kzBOm5HJKe7PMDL9wDa5aSTwGNKNT0kouIJLHCwd8mrE1IssQRvT2BJ++t9Bb
0Rzt1M8vw9ADZ22K/raP5N3yuqzi3HDI5XHurgZsBY1VH8gXr7A1WZfC2MqPJo2g
g05oOAO+13G2NG/fIvCS
=TZFf
-----END PGP SIGNATURE-----

--SLDf9lqlvOQaIe6s--

--===============8403290994274300283==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============8403290994274300283==--
