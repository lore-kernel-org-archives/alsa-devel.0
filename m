From: Mark Brown <broonie@kernel.org>
Subject: Re: Ordering in soc_pcm_hw_params()
Date: Tue, 12 Aug 2014 12:57:56 +0100
Message-ID: <20140812115755.GO17528@sirena.org.uk>
References: <CAKON4OzQF8sDigvcDFsJaJRVX9o4X1FiC2FEU8D6n=oaQkX+Uw@mail.gmail.com>
 <53E9D383.5060103@metafoo.de>
 <CAKON4Ow3HFL0Sv2AV7+-XS0PBHnP9WW_8FBgrV=cKp14LER9XA@mail.gmail.com>
 <CAKON4OzrJSAD0RUL5TO6n8mxG0q9rRau0MWaAXvXVo+bSB8Ygg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============8442103416085584704=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id D16FB264F10
 for <alsa-devel@alsa-project.org>; Tue, 12 Aug 2014 13:58:07 +0200 (CEST)
In-Reply-To: <CAKON4OzrJSAD0RUL5TO6n8mxG0q9rRau0MWaAXvXVo+bSB8Ygg@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: "jonsmirl@gmail.com" <jonsmirl@gmail.com>
Cc: alsa-devel mailing list <alsa-devel@alsa-project.org>, Lars-Peter Clausen <lars@metafoo.de>, Liam Girdwood <lgirdwood@gmail.com>, Nicolin Chen <Guangyu.Chen@freescale.com>
List-Id: alsa-devel@alsa-project.org


--===============8442103416085584704==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="JySPVzwy9A38dqw7"
Content-Disposition: inline


--JySPVzwy9A38dqw7
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Aug 12, 2014 at 07:46:58AM -0400, jonsmirl@gmail.com wrote:
> On Tue, Aug 12, 2014 at 7:45 AM, jonsmirl@gmail.com <jonsmirl@gmail.com> wrote:

> > The machine driver is simple-card. It is not smart enough to change
> > the sysclk between 22.5Mhz and 24.5Mhz depending on what music is
> > being played.

> Having said that, should we make simple-card smart enough to do that?

Yes, as has been said several times now it's the responsibility of the
machine driver to coordinate clocking in the card so if you want to use
simple-card that means you need to add the feature to simple-card.

--JySPVzwy9A38dqw7
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBAgAGBQJT6gFAAAoJELSic+t+oim9pKsP/27WFV+k2uuXTOozukko75fw
zTpHgVlFudMk2VkCNddXufp2kZ+f/o0K0rMYTNvDTau0O14nn76tVIrvJGU+1UBb
TGJ7kjqbi4hYTRFoMEUhd2frq6xIHRRpfagOkLVA9eggGMjjUmOe3HWqM5KtX1vf
tXP19+2m4m4haCOyn5Vjs/tOhkmnjBUEQOrom3ZuETdHrY92YMDUb1A4YyWVtxIv
kVZCl8v/Uoqkt3qbFbbKlOWELtT6DFPIJyCsVqtJpja97MTIn3ZL/atHvZUk9b77
CvpQO+uxCbtYShfyh7Ht/1oUqmCZf8hLSKFUhvNEzzESb71yb2CmiRkv8VA0eNHx
S9AsWq1Rwq9avtXdbKdDyFCOTfSTemppGbf/we+ozY19b3f4FdoPh+dWSCB1SP4q
6YdzpfmvNigz6x4UwmPz8DScP96qcQHj6vOu2PgBuUnEzdmuFmf40pmYDDtoHFOj
2qp6MMI3hXrvX3G/xZcSLZbUyNUl6Mv26qp2afFyxA9Ej+ianI4w1xuBQqXDxxmi
WJDZ60o0nun1D495f1gIvruPRSzu/vhApCncPTWhJopDmoulRdQs6GsJNJqmYvfS
TBhkHbrH8l0aP/J6LcNFkXyWKThDcYPBngIAStXvn2kDGiISmcrmo3POPtL+OlTJ
Ednx2Vn5ybCm+daF2Ltp
=ynlY
-----END PGP SIGNATURE-----

--JySPVzwy9A38dqw7--

--===============8442103416085584704==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============8442103416085584704==--
