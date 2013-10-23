From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH RESEND] ASoC: dont call dapm_sync while
 reporting jack always
Date: Wed, 23 Oct 2013 09:25:08 +0100
Message-ID: <20131023082508.GG9388@sirena.org.uk>
References: <1382362654-26213-1-git-send-email-vinod.koul@intel.com>
 <20131022083223.GA20821@sirena.org.uk>
 <20131022153654.GQ14013@intel.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============8183214815604977634=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
 by alsa0.perex.cz (Postfix) with ESMTP id 86B1126109E
 for <alsa-devel@alsa-project.org>; Wed, 23 Oct 2013 10:25:19 +0200 (CEST)
In-Reply-To: <20131022153654.GQ14013@intel.com>
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


--===============8183214815604977634==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="XRI2XbIfl/05pQwm"
Content-Disposition: inline


--XRI2XbIfl/05pQwm
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Oct 22, 2013 at 09:06:54PM +0530, Vinod Koul wrote:
> On Tue, Oct 22, 2013 at 09:32:23AM +0100, Mark Brown wrote:

> > Applied, thanks.  It'd be good when doing things like this to say what
> > the advantage is; with DAPM the general thing is that it gets called a
> > lot so it should be cheap enough to just call all the time.

> Okay, my thoughts were that it was obvious. We saw an issue when monkey testing
> with jack, bunch of dapm_sync's got triggered (insertion, reroute from usermode,
> removal, again reroute from usermode, and so on). The insertion and removal ones
> were quite not required for cases with no pins

It's obvious what it's saving but what's not obvious is what the benefit
of those savings is.  That's the bit it'd be good to cover.

--XRI2XbIfl/05pQwm
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJSZ4fbAAoJELSic+t+oim9B2IQAIOExIUSw6NCpAwlgLDL7Ljd
AacK2sVWkFZw8Gmi9kGfGYE0xbXmuWJBNySRoULa36W/QIpKXzCgiwCWzBpv7ue/
ebLjVT9CaPuILTt+VijzrFzclT9HCC1WheJmsISRLwPSacyIOrNnCsWq5T7fC+lS
Gq1etyZWMJDTCTuGL9wZjdnQgsUzy8diO8CBQJph3793IHDcN4ct9YTEM40+MlPR
7+tsLrlGA+YBqTYGPIdtwMatjbpj6rHBNS4VpUqQKXsF8wsJyYQhhp4JuN9Iu3Os
AW7iD2TMQl8l6PHl1wMI1R8lQ8v89ObjsZ7Z/Xjgo59Id3guc8Cgg5hkOQEj/Jqq
O2rzRAqpFid5jtxD8QViGhBha2vYSJFn6bIj33YGfOa+bH0/3JgHYYQ81m1mpFao
j+3Kv1IqH8UAJd4SFeZCz0sU54Ma80e+tywS3S6KfoTRGNxbbOF0aV0dX4Iaxqt8
kzuWfrSkRbv/FjU0TxTosPNyWJyh01DlTnp3cCWQZ312A0ETCzExRNn4cS3vzWyt
W/l2HkCGEqMAxcpxZaUz/M4fWJxmopoQ0eplakTsBULb63UEsukCvPJUPRTV65O5
T27YuKCka5K32EfbrKbh/6eRNSOhsrredGwBJEgOK4hvpBIe6jHVuVAqbwfjFhBl
lLXH/GLGb/NNryC3PeL5
=Uwp7
-----END PGP SIGNATURE-----

--XRI2XbIfl/05pQwm--

--===============8183214815604977634==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============8183214815604977634==--
