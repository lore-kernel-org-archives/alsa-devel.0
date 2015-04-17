From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH -next] ASoC: Intel: sst_byt: remove kfree
 for memory allocated with devm_kzalloc
Date: Fri, 17 Apr 2015 14:32:57 +0100
Message-ID: <20150417133257.GE10513@sirena.org.uk>
References: <1429191989-25919-1-git-send-email-weiyj_lk@163.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============4029958502866584051=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 5149D2605F1
 for <alsa-devel@alsa-project.org>; Fri, 17 Apr 2015 15:34:27 +0200 (CEST)
In-Reply-To: <1429191989-25919-1-git-send-email-weiyj_lk@163.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: weiyj_lk@163.com
Cc: alsa-devel@alsa-project.org, Wei Yongjun <yongjun_wei@trendmicro.com.cn>, Takashi Iwai <tiwai@suse.de>, linux-kernel@vger.kernel.org, Liam Girdwood <lgirdwood@gmail.com>, Jin Yao <yao.jin@linux.intel.com>, Jarkko Nikula <jarkko.nikula@linux.intel.com>, Andy Shevchenko <andriy.shevchenko@linux.intel.com>
List-Id: alsa-devel@alsa-project.org


--===============4029958502866584051==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="PPYy/fEw/8QCHSq3"
Content-Disposition: inline


--PPYy/fEw/8QCHSq3
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Apr 16, 2015 at 09:46:29PM +0800, weiyj_lk@163.com wrote:
> From: Wei Yongjun <yongjun_wei@trendmicro.com.cn>
>=20
> It's not necessary to free memory allocated with devm_kzalloc
> and using kfree leads to a double free.

Applied, thanks.

--PPYy/fEw/8QCHSq3
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJVMQuIAAoJECTWi3JdVIfQzFIH/2EprM1KrXqRLNRRuL8n+uYG
x0R2JULdfDxrAqomRG0C4uVF0kvYP8LNiGcsMoLpKH1XvsKw/d3lPGG+8YT2/OoO
ZuPjAgyXXTkqi7JJQ8Vi+GBpXoYKKG6KuEA30TuLc7Z1lnv9rDpewkh2y8cMy7CM
SMS94TERI4RHH5wxVMs85h9epPVcEG5Jcn5VuvnS0tYRBRy6LWEHWJlP/vsppgQ9
ueqVyLtfs0SKHZfQapCXlxGYNrZVxB7JRVcMESqbp/8WbNbcL0Wqn00RuxsxaMgu
a6wMqEPVCNS7bBhpsYgNS5YJxisiO9B+nlmRTXY+tOz5quYbM2W4azgq4FDVPmw=
=ow6y
-----END PGP SIGNATURE-----

--PPYy/fEw/8QCHSq3--

--===============4029958502866584051==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============4029958502866584051==--
