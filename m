From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH V2 1/3] ASoC: tegra: add tegra30-ahub driver
Date: Fri, 13 Apr 2012 11:17:48 +0100
Message-ID: <20120413101748.GO3168@opensource.wolfsonmicro.com>
References: <1334097121-18897-1-git-send-email-swarren@wwwdotorg.org>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============8132413369279932072=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 85278243D0
	for <alsa-devel@alsa-project.org>;
	Fri, 13 Apr 2012 12:17:51 +0200 (CEST)
In-Reply-To: <1334097121-18897-1-git-send-email-swarren@wwwdotorg.org>
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


--===============8132413369279932072==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="GPOl6LAGMgeiWDic"
Content-Disposition: inline


--GPOl6LAGMgeiWDic
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Apr 10, 2012 at 04:31:59PM -0600, Stephen Warren wrote:
> From: Stephen Warren <swarren@nvidia.com>
>=20
> The AHUB (Audio Hub) is a mux/crossbar which links all audio-related
> devices except the HDA controller on Tegra30. The devices include the
> DMA FIFOs, DAM (Digital Audio Mixers), I2S controllers, and SPDIF
> controller. Audio data may be routed between these devices in various
> combinations as required by board design/application.

Applied all, thanks.  I'd have been slightly happier if we'd had the
machine driver to show how this is used but there's enough plans to
continue updating the code anyway so it doesn't seem like a big deal.

--GPOl6LAGMgeiWDic
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iQIcBAEBAgAGBQJPh/z3AAoJEBus8iNuMP3df3AP/3m36ce1O1kkFWMAM/nCATuB
SlUPi4F5hn83ub2NmDQxvWlecoNavo7w2/MH6x2/F/Dvbq8mdAQpJWohpvOUBdtm
rJg+PlpDhjxh1uRFerwyW4BI7QCApNDNuu4uIGlL0StMbyqm9JOrXl25nrA8DqUU
nSUO3+3qDsOv1ROiOl04b9MCN8bL99hfRKSlaThgyO981dj6bNseGlzrii58rtyR
Ue3g/qcJDttMfg7kpt9tIh34ieWmJxNJPzCBss5ERddqarWVpjaZtNUCCuYA2499
KIa2MlGmYr+QjsR1z22bF/MyxATjogm7yr2/35Q1GXMlcJOgMUIdonskaZ7Prr7r
QBYHFRMK0wdG9zAc/VfR1Anx1B8vb5LcvBiLgGkVpd5Xdm7FhPqu9hKYeBUYCtwt
u9bY3A1JJoeImL3fhEg/HT4CE77aTYh8KCNhWY8yYQVkwRN5pk/Heqkql1GKWuZd
5PetkJEPLI34Jk/sL5mh9/UogyHmYH9AytL/vRCE7rcu2U+xwPPMMwUId41PkdCA
zZ7ObmWlyeTQN9D5N+rVzykPbONWTTtwzCz3VXWNYUOrfxu7THxGJcTi+7689OE0
b5L/6pm+k0DiCT9X/bV4OtaR+JCb3GHTRnaASW48KZvgitkQmEOtvtXIVzyN9wzc
mNdRS4rGzr40j5k6hYMY
=Q59b
-----END PGP SIGNATURE-----

--GPOl6LAGMgeiWDic--

--===============8132413369279932072==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============8132413369279932072==--
