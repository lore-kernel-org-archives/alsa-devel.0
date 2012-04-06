From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH 2/2] ASoC: tegra: complete Tegra->Tegra20
	renaming
Date: Fri, 6 Apr 2012 14:23:25 +0100
Message-ID: <20120406132324.GD19424@opensource.wolfsonmicro.com>
References: <1333662894-22672-1-git-send-email-swarren@wwwdotorg.org>
	<1333662894-22672-2-git-send-email-swarren@wwwdotorg.org>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============5795264625327989845=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 771EE24440
	for <alsa-devel@alsa-project.org>;
	Fri,  6 Apr 2012 15:23:29 +0200 (CEST)
In-Reply-To: <1333662894-22672-2-git-send-email-swarren@wwwdotorg.org>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Stephen Warren <swarren@wwwdotorg.org>
Cc: alsa-devel@alsa-project.org, Stephen Warren <swarren@nvidia.com>, Liam Girdwood <lrg@ti.com>
List-Id: alsa-devel@alsa-project.org


--===============5795264625327989845==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="RhUH2Ysw6aD5utA4"
Content-Disposition: inline


--RhUH2Ysw6aD5utA4
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Apr 05, 2012 at 03:54:54PM -0600, Stephen Warren wrote:
> From: Stephen Warren <swarren@nvidia.com>
>=20
> Rename Tegra20-specific Kconfig variables, module filenames, all internal
> symbol names, clocks, and platform devices, to reflect the fact the DAS
> and I2S drivers are for a specific HW version.

Oops, sorry - replied to the wrong one - this one doesn't seem to apply
against for-3.5, I applied 1/2 though.  I believe this is due to 3.4
fixes not having propagated over 3.5 yet.  Can you regenerate against
for-3.5 please, or perhaps it's best to wait until things have merged
back up?

--RhUH2Ysw6aD5utA4
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iQIcBAEBAgAGBQJPfu41AAoJEBus8iNuMP3d+ksP/3tqlWwpWY3nDl8dBAEfTx4k
DO1bWFocuyEASQiv04W54+4Hh/PAXlKT9QB1X303MP+7HSGw66Jkg0b2m2TUcw2Y
DivBxobqUlvod+oTclqmcnI8bgCOChwEBSh6GznknKKNEY4mKdnExAEDspGyNiRa
WHblHvQrLSInzvXcnZQnf7ie3Yc97OyAsV4yKMTmn2DT/3i1fnhRpPH/h65qNnNh
TNToR/f43iWky1mdw6lOHglhHX5DKRLc1kUzvd5gUSdbFTbN87yjUYcGmvwaQFud
F/ZM5eHe41FffiLE/FwIcYhHx4gTNBRV9WMfOoMogEHLsrdFPDpaI0S/Cm5tJUDN
79x3p+zDfVeoGG6OJYViRfDO2AV84Oqx+MUeY9IFvyd+DEjcs/jLQ8R561ufN4aO
SyYpC6FfYyMrLdZB8xQidHJf8kOEcgbmasN5ZkKND7pYcX8PtwijRdNKIIW3NhOc
ZozMprkYExMmN20K90VZ74FLQ0eZyOQGtwmC1T2dZwOUa8VYthYDMZ5kge/LrDBz
cwq8vAysLVY5wsKGaQEQT42WEQdoB3Wejfk4Ksoh+OjfDmlpcUSk3TPOz0ANzoP3
5KB3dVIwCMw/SHMt+6C7WV9lHbO7LwqT8Z624/c8BCSXpOMPKxLGF4HRVkJg0DFZ
GnwLsG3vkkD7YaI3cxMc
=1tpX
-----END PGP SIGNATURE-----

--RhUH2Ysw6aD5utA4--

--===============5795264625327989845==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============5795264625327989845==--
