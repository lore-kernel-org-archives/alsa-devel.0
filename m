From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH v3] ASoC: imx: Allow using sound with DT
	descriptions only
Date: Mon, 13 Jan 2014 17:45:36 +0000
Message-ID: <20140113174536.GH29039@sirena.org.uk>
References: <1389358827-381-1-git-send-email-shc_work@mail.ru>
 <20140113035626.GI23525@S2101-09.ap.freescale.net>
 <20140113183212.22f73787442da8af0879d012@mail.ru>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============4963703207068253564=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id CAF4C2607B6
 for <alsa-devel@alsa-project.org>; Mon, 13 Jan 2014 18:45:44 +0100 (CET)
In-Reply-To: <20140113183212.22f73787442da8af0879d012@mail.ru>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Alexander Shiyan <shc_work@mail.ru>
Cc: Takashi Iwai <tiwai@suse.de>, alsa-devel@alsa-project.org, Shawn Guo <shawn.guo@linaro.org>, Liam Girdwood <lgirdwood@gmail.com>
List-Id: alsa-devel@alsa-project.org


--===============4963703207068253564==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="mlnxvmnLyWgus2CN"
Content-Disposition: inline


--mlnxvmnLyWgus2CN
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Jan 13, 2014 at 06:32:12PM +0400, Alexander Shiyan wrote:
> Shawn Guo <shawn.guo@linaro.org> wrote:

> > Just want to understand the direction of this change.  Besides
> > FSL_SSI, we will have other CPU DAIs FSL_SPDIF, FSL_ESAI and FSL_SAI.
> > Will we select all of them from SND_IMX_SOC, or we only do it for
> > FSL_SSI?  Note, IMX_AUDMUX should be only needed for machine drivers
> > that use SSI CPU DAI.

> Not clear how to do it right ...
> I conclude that the first version of the patch was the best, do a separate
> symbol for DT and select all required options.
> Rewrite in this way?

No, that just means that the same problem that Shawn identified affects
all DT users which isn't really moving us forwards since all these
systems use DT and they probably shouldn't suffer anyway.  Why not just
make each of the drivers selectable?

--mlnxvmnLyWgus2CN
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJS1CY8AAoJELSic+t+oim9+FQP/1x0p7WytaIW7wXl3zJOlg9z
kkAL9qV7+4jKXL7g9O1DeA0BLYRylgZEVmoiHcaK6am9oRyjY5ml1RBOeUjNV9sk
KrsZB7GTgW1jyQsODNOITTlBxCZjNF6z02MDeMYpIj3fRSEJNz64yu1nk2l6cFgX
8T1Ms1and3jdfpxoKclKjm8NQ0hXz8YqHW7MuHkNRMmypBn9fuhK3Nf+qy/U8GKg
u82yCuNozeSjgS3XNN/lZ3+mdiwHej68WNN2011oXCU4yDJrg7hHS9EHF3RRV+Xc
kKg9Tj2Ird8eKJmKT2faGgc597dkioGcqg+n0TcqQtDVCf5UskOUjVVikBb0iDNV
I5TFfzqmWechibtnJyfMHjrvpxE9F8Vzzt8vJvYRCIl3ZQCT0SDbMHEPq/Drvt4G
hnzYf+wbsNs0FxK0hNaGzvX31Y9fBF4BU0B17hlDtLMzBIEKwxSiJFHYVppeaqmI
D2+9ULGScVFXRrdpzyssASRrOQ1WmeUCQdtyF3Xx0w75pJyDumJHLuGksi/vdn9R
N9yrZU8TSjmgC44Rnur3PyKau7q3ZSk539d5Zi2QQJaSvTTXjUi0eEIDCCoDfbHO
kjaPPi0aX66FwseXThKGphzxmnPLvw8kRwXsxmYZIhA9gJP9MuhH3VsN6NJpWsEn
u64uJBt8zxhJbwdadWQ8
=S1k1
-----END PGP SIGNATURE-----

--mlnxvmnLyWgus2CN--

--===============4963703207068253564==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============4963703207068253564==--
