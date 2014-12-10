From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH] ASoC: samsung: Fix non-DT use of I2S
 controller
Date: Wed, 10 Dec 2014 13:19:37 +0000
Message-ID: <20141210131937.GR11764@sirena.org.uk>
References: <1417809427-5126-1-git-send-email-broonie@kernel.org>
 <CAAgF-Bfv5OaDYu2Ti=9CCoZ9k-1ZhOG-KRfgXJYanKpLWp9ffQ@mail.gmail.com>
 <20141208121200.GV11764@sirena.org.uk>
 <CAAgF-BfCQ8sfT-dH8+yNUrPA=qPChv6G_8bX0qHnkj-Phb=zhw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============5495697099074217443=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 6A5C72604E4
 for <alsa-devel@alsa-project.org>; Wed, 10 Dec 2014 14:19:53 +0100 (CET)
In-Reply-To: <CAAgF-BfCQ8sfT-dH8+yNUrPA=qPChv6G_8bX0qHnkj-Phb=zhw@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Padma Venkat <padma.kvr@gmail.com>
Cc: alsa-devel@alsa-project.org, Padmavathi Venna <padma.v@samsung.com>
List-Id: alsa-devel@alsa-project.org


--===============5495697099074217443==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="ZFN9GYGE3tAy85aa"
Content-Disposition: inline


--ZFN9GYGE3tAy85aa
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Dec 09, 2014 at 09:33:00AM +0530, Padma Venkat wrote:
> On 12/8/14, Mark Brown <broonie@kernel.org> wrote:

> > OK, though I presume that's wrong too (otherwise it should be v4).

> Yes. It does not have secondary dai, internal DMA, reset control. It
> has only 5.1ch support. Register offsets are similar to i2sv3_regs. So
> I think one V4 dai type with name "samsung,s3c64xx-i2s" is required.

OK, then can you or someone else with access to the documentation please
provide that?

--ZFN9GYGE3tAy85aa
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBAgAGBQJUiEhpAAoJECTWi3JdVIfQj4UH/i5wE2jCF6oTidMArbRO+uda
sj0NR40QQAvgaarwgrqdYUWGduIqe93dXpbqs8KR7Jq8tGqQsCFlv2p80K3tfX+Z
QdUxIStE83Ep/Nk5f0JaJNMV4cB6NrrCCjjoCiXvChZtwZ9lSK985uBjRDfpGWGL
jYN2chtwiLDnemRTDmK8PrWG7sZPhltsAxdp+vpykbHYVk2yUrKONn8V8PF03r8e
sBaPkUs+HRN1ldn2fyBSusB+kzB2DSPBFHArPzUrZvvTJTlTz3eqUhmwnoW9q7Wj
3FBB6QH5VDeptSncv20o7IStuh1tQdI/kn6CftLSXzMCjzFL3/10BR5JwsozBD4=
=HoNL
-----END PGP SIGNATURE-----

--ZFN9GYGE3tAy85aa--

--===============5495697099074217443==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============5495697099074217443==--
