From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH v2 1/2] ASoC: samsung: s3c24{xx,
 12}-i2s: port to use generic dmaengine API
Date: Wed, 21 May 2014 11:49:01 +0100
Message-ID: <20140521104901.GO12304@sirena.org.uk>
References: <1400617569-7187-1-git-send-email-anarsoul@gmail.com>
 <20140520221918.GI12304@sirena.org.uk>
 <CA+E=qVdAuZGYZ95AQDkF_P1rU-_vEs2=qL6UtvzPXepERFZFjw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============2872603653869573822=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 18A29261A18
 for <alsa-devel@alsa-project.org>; Wed, 21 May 2014 12:49:20 +0200 (CEST)
In-Reply-To: <CA+E=qVdAuZGYZ95AQDkF_P1rU-_vEs2=qL6UtvzPXepERFZFjw@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Vasily Khoruzhick <anarsoul@gmail.com>
Cc: Sangbeom Kim <sbkim73@samsung.com>, alsa-devel@alsa-project.org, Kukjin Kim <kgene.kim@samsung.com>, Liam Girdwood <lgirdwood@gmail.com>, Lars-Peter Clausen <lars@metafoo.de>
List-Id: alsa-devel@alsa-project.org


--===============2872603653869573822==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="x+rkQjivMPZpOl42"
Content-Disposition: inline


--x+rkQjivMPZpOl42
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, May 21, 2014 at 09:42:21AM +0300, Vasily Khoruzhick wrote:
> On Wed, May 21, 2014 at 1:19 AM, Mark Brown <broonie@kernel.org> wrote:
> > On Tue, May 20, 2014 at 11:26:08PM +0300, Vasily Khoruzhick wrote:
> >> Use dmaengine instead of legacy s3c24xx DMA API for s3c24xx and s3c2412

> > Do these depend on any other code or can they just be applied
> > immediately?

> For compile time everything is present, for runtime they depend on
> cyclic transfers support for s3c24xx-dmac (already submitted).
> Also s3c24xx machines lack a platform device DMA (one-liner, not submitted yet).

OK, in that case I think it might be better to hold off until either the
DMA patches are merged or after the merge window (should be very soon)
so that the driver still works in v3.16 - does that seem sensible?  The
changes look OK, just a question of getting them merged safely.

--x+rkQjivMPZpOl42
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJTfISaAAoJELSic+t+oim9AI8QAIatIG9OQhGeE+q+k1wo584v
+U6TxDNlkhS099/IsvQPy757vj5Sav09/Roi01Rh8FGbj4rv5TPJ6hw8hhTChKpB
VZM313LsRT5zz1nB+VtqextLdt3Yw83RB418jM/j1Iuq+mVGHPBJHVKBaWQeLGQ4
IvmNqOnU0r+DmRrBcmTaQbq24rFaSWZ1Uy5rsd6+CS+6xCtITtcieYL3AF0VXVJ2
eDQ5K0y4STcSKZ1dmS6HWO87xlKp3ub/J/sYVNPEzItLniAdFSjC6F3CC/t3BxGA
ckr0g7lrZR7xJuL5IZSD8Cj1QKqjvV7Tj+ZEkGd2SpsNZmYqb8Vz06kGIl8rNsKa
EHMBMbnk+Hipq6j8I0XzXkb39Ooc/ZRZoLM2sAgm4YXX5BdqTCE0ZFgFBXj3wkOR
4ZECoxBk/ZEgOcrXWySGcRqawvyNHtSu/Bei7vxnRkYLVCeObFJC9ewPvlYsdYqz
ZR318pBlSPp4lAmSEC/cq2GM1BU/FDESg8mCC+v8DqjCeidEQHMYTAybS6iFFuEY
8SwgEIRiPgvaDSqN9mSX89c3sYPO4xFjCqTgmkO7YuJ+cjBDT7FMgS0PL38jn+Vv
o5zb6VuWXDwhx9xXoqCp63K14MdIfn4KK+ewCmLtrvEdurJCx1VT4go8gOAl6583
gmwMI/9aoyjAAQdfR1Ux
=FvjY
-----END PGP SIGNATURE-----

--x+rkQjivMPZpOl42--

--===============2872603653869573822==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============2872603653869573822==--
