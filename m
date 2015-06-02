From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH] ASoC: add config to enable/disable asoc
	compress
Date: Tue, 2 Jun 2015 11:58:14 +0100
Message-ID: <20150602105814.GM14071@sirena.org.uk>
References: <1432992511-864-1-git-send-email-yang.jie@intel.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============9196361145571743116=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 9FD5F265142
 for <alsa-devel@alsa-project.org>; Tue,  2 Jun 2015 12:58:20 +0200 (CEST)
In-Reply-To: <1432992511-864-1-git-send-email-yang.jie@intel.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Jie Yang <yang.jie@intel.com>
Cc: tiwai@suse.de, alsa-devel@alsa-project.org, vivian.zhang@intel.com, liam.r.girdwood@intel.com
List-Id: alsa-devel@alsa-project.org


--===============9196361145571743116==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="Sr6hGnsCY8KeifOY"
Content-Disposition: inline


--Sr6hGnsCY8KeifOY
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Sat, May 30, 2015 at 09:28:31PM +0800, Jie Yang wrote:

> +ifneq ($(CONFIG_SND_SOC_COMPRESS),)
> +snd-soc-core-objs += soc-compress.o
> +endif

If you want to make this optional why not make it a module so that the
Makefile looks more idiomatic?

--Sr6hGnsCY8KeifOY
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJVbYxGAAoJECTWi3JdVIfQsqEH/ipq5tnHL69LWDL40TsFyhLd
uUIW0YuzWuWSw+olSREa6bt3JWrARzzFNo02rgKLD9F6raac855AK2cpuz1MZ2Kn
BzKiQS9ajMGq0zXgSlbxNm6u2cv3tlSAQ+G7jLxFlxMocrbQV0eVWMamBTsr1V+A
J+UGhl1JXIkqnTqrDTlE60iBlL5KKI4m3KOTER1J24AqrbX4yrk20TTuiY9YARjF
Y1kyZcbnYV62/HVY/F9jESuKqjUJdH5zwIJ2JF/TCRQOuNB7dt0/D1YlYyLbu+2a
ZSc/xMC28Xn3pRPvXSdWmCRFukNNJBARkUD83Egxgq8yrDQVDeBtl2PXuN329iU=
=7ctL
-----END PGP SIGNATURE-----

--Sr6hGnsCY8KeifOY--

--===============9196361145571743116==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============9196361145571743116==--
