From: Vinod Koul <vinod.koul@intel.com>
Subject: Re: [PATCH 03/10] ASoC: Intel: Skylake: Add D0iX IPCs
Date: Mon, 31 Oct 2016 03:10:20 +0530
Message-ID: <20161030214020.GK3000@localhost>
References: <1474868137-29712-1-git-send-email-vinod.koul@intel.com>
 <1474868137-29712-4-git-send-email-vinod.koul@intel.com>
 <20161028180628.2wylswqs7rddvcds@sirena.org.uk>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1794790869856542234=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
 by alsa0.perex.cz (Postfix) with ESMTP id C63E726648D
 for <alsa-devel@alsa-project.org>; Sun, 30 Oct 2016 22:31:13 +0100 (CET)
In-Reply-To: <20161028180628.2wylswqs7rddvcds@sirena.org.uk>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@kernel.org>
Cc: liam.r.girdwood@linux.intel.com, patches.audio@intel.com, alsa-devel@alsa-project.org, Jayachandran B <jayachandran.b@intel.com>, Pardha Saradhi K <pardha.saradhi.kesapragada@intel.com>
List-Id: alsa-devel@alsa-project.org


--===============1794790869856542234==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="OaZoDhBhXzo6bW1J"
Content-Disposition: inline


--OaZoDhBhXzo6bW1J
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Oct 28, 2016 at 07:06:28PM +0100, Mark Brown wrote:
> On Mon, Sep 26, 2016 at 11:05:30AM +0530, Vinod Koul wrote:
>=20
> > To set D0iX, driver needs to tell the DSP to go into D0iX mode by
> > sending "Set D0iX IPC". Add support for that IPC.
>=20
> What is "D0iX"?

It is an intermediate state between D0 and D3. It is low powered state where
DSP is functional but with reduced functionality to reduce power consumed.

I will add this in changelog

Thanks
--=20
~Vinod

--OaZoDhBhXzo6bW1J
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJYFmjEAAoJEHwUBw8lI4NHwD0QAMCix+l+9nckVAJvQckHX4TL
Olmvn7QhfiWCDRMbgWAlV8Dlyp0FNCWwdOsFA3vTWR4eG0OGBmn3rlk3pmYDWaRs
BEA4lv+7HYofdX5a3d1HCD8ewOXpbdvDCC/NnYWSWbVj0YxWb2baxBSpI+ZbQbHP
dyHc1t7ee8mc0AVPmYUv+wzqfbInd6iLEkjubOoWpTXIp2ZGSQ/VB5RddQaMYRx4
qVAC7WTbEpwEp30TntnCuFg+bY4Wk3ZBJujLDh/sw1MOw1qbYpSK5ljV2SNgkF2f
bsh6zQf2rTrGDkzvP8B18ThEoz+f3gghBEKnBANmHJAfFj47Efu2RH0VjGpUYrah
PAbtq9/9jGcMZOte4WUqdItkIkBS43LxzeTI/x0VLU3czcvTAx26KvNETIxwIuq1
ehGLDKwcEO01ORIF/MKZTYP2kibV7utLbmBaqsN6fpmGE3s0Uv2l2kqucznbQYEl
GqJkgtp96hPVWFbFpkGrzrxQXYtabIcTImIZ10E5kgJeYL4b7JRIvC+RZ1qtsAl8
D9um/HQ0HT+wQy91+1rmBNn2bCM6hXUwFYyJnaHC6oe22wc3/FT2wcDXOsnDo53F
CDNPoaK95K/XiD6uJGV4sglS7vmSLglQLrm2ZVppLOkQ71Y83GVZ6BxFiFOSxh50
iwhQPjvl/VZYjb4dqsjI
=yoca
-----END PGP SIGNATURE-----

--OaZoDhBhXzo6bW1J--

--===============1794790869856542234==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============1794790869856542234==--
