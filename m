From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH 09/17 v2] ASoC: wm8996: Update locking around use of DAPM
 pin API
Date: Thu, 20 Feb 2014 19:27:14 +0900
Message-ID: <20140220102714.GK2669@sirena.org.uk>
References: <1392736948-26623-1-git-send-email-ckeepax@opensource.wolfsonmicro.com>
 <1392736948-26623-10-git-send-email-ckeepax@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="UEyd/hAv58AC+/Rf"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1392736948-26623-10-git-send-email-ckeepax@opensource.wolfsonmicro.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Charles Keepax <ckeepax@opensource.wolfsonmicro.com>
Cc: myungjoo.ham@samsung.com, cw00.choi@samsung.com, dmitry.torokhov@gmail.com, lgirdwood@gmail.com, lars@metafoo.de, peter.ujfalusi@ti.com, jarkko.nikula@bitmer.com, eric.y.miao@gmail.com, haojian.zhuang@gmail.com, linux-kernel@vger.kernel.org, patches@opensource.wolfsonmicro.com, alsa-devel@alsa-project.org, linux@arm.linux.org.uk
List-Id: alsa-devel@alsa-project.org


--UEyd/hAv58AC+/Rf
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Feb 18, 2014 at 03:22:20PM +0000, Charles Keepax wrote:
> The pin updates in this driver look like they are intended to be done
> atomically, update to do so.

Applied, thanks.

--UEyd/hAv58AC+/Rf
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJTBdh+AAoJELSic+t+oim9pN0P+gNsczrswxqrY3KV2RtVYMHT
WkhNj4cT1CX2Gv2QaDR2G1P1rQgN9tnuYyj+7D0I9GpQAQJ3FpCYNtGeardOTCkh
FDEG2NUVF/1GQnCYZHCbwinVQncoR9tJGzA1UTp4FID0iRRSXjVUlOsi6m4KHsf1
kXhofsiYfqMP4D8TCwMoiNn/BSEsffZbaasTVo8C9CFVKXs6g2BQWWmDc/chBSF2
YTkTO0IkwEiAl634GnHy0V1l80KbwnLsO7N6eURQqHoqplVFb3B8f1n3OcaYaZBS
blaTOo3Ff1XXX0vrkd7Q55t6MRHT707Rl+r/+rg2nwvaGZIwSZCuK7WHnweqae7m
Wn7oMM594Bf3oH3Uq79nZhrscV1OOCslfx3TP1xReq76HLBBYfEvbDLFe/CwNE3L
IZ7cg1uRUecUWCpJG/Hh6mJDutEiSw5czImbmSFyPnEzXOtSW9guGhxHF6lZlyw9
iGdaY6FfKKZ/1LdMhqHM5lQrE+Rvlg+8DbKFpwEwQ3WrGct/++jlwPN+EYCsW4iR
CZGzZUi9jcBM51XZUhujDR7absmxkRaUAtLL8iSY/Ptywcmwc0myLbkE5/OjpIxh
atrrVfsrLFH4GuKntnSn8F17BifDlh+r+Dgg3YQMZIBtcH8L5NA5QFj0pabv/lVL
IDwiGXz/aXid6Y+rrtIM
=o/Nt
-----END PGP SIGNATURE-----

--UEyd/hAv58AC+/Rf--
