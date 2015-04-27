From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH v2] ASoC: rt5645: Adds push button support
	for rt5650
Date: Mon, 27 Apr 2015 21:47:21 +0100
Message-ID: <20150427204721.GM22845@sirena.org.uk>
References: <1429704835-28201-1-git-send-email-bardliao@realtek.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============5912728019044332642=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 7712E260815
 for <alsa-devel@alsa-project.org>; Mon, 27 Apr 2015 22:47:31 +0200 (CEST)
In-Reply-To: <1429704835-28201-1-git-send-email-bardliao@realtek.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: bardliao@realtek.com
Cc: oder_chiou@realtek.com, alsa-devel@alsa-project.org, lars@metafoo.de, zhengxing@rock-chips.com, yang.a.fang@intel.com, mengdong.lin@intel.com, lgirdwood@gmail.com, john.lin@realtek.com, koro.chen@mediatek.com, jason.ym.lin@realtek.com, yao.jin@intel.com, flove@realtek.com
List-Id: alsa-devel@alsa-project.org


--===============5912728019044332642==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="Yzd3n0fjcrTXF6/a"
Content-Disposition: inline


--Yzd3n0fjcrTXF6/a
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Apr 22, 2015 at 08:13:55PM +0800, bardliao@realtek.com wrote:

> Can we have a separate codec driver for rt5650?
> rt5650 will be more popular than rt5645. Many customers are searching
> rt5650.c but can't find one. We have to told them rt5650 and rt5645
> share the same codec driver. Also, some registers or functions are
> different between rt5645 and rt5650.

I really don't want to end up with a precedent for duplicating code due
to user confusion like this - it's something people are going to have to
get used to with Linux since it happens quite often and we don't want
code duplication.  However something like what the Wolfson drivers do
with sharing the common code in arizona.c and wm_hubs.c isn't a problem
at all.=20

>  sound/soc/intel/cht_bsw_rt5645.c |   2 +-

This doesn't apply against current code, the Intel drivers have been
moved around and split into multiple directories.  Please redo against
current code.

--Yzd3n0fjcrTXF6/a
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJVPqBYAAoJECTWi3JdVIfQdOAH/27hyJp5tJvrZ2zLpIQMR3k8
PvRiWfRJbsjn/+PhkFo+93OWs9NCP+S4ajyld0qSv48ec0BxHeOMw0V74fF7vYnQ
+2s+WDqE0QUAXlKvRa7UpD1sWNnBjdcfNdV+F85YPrm8HZcRnMgDne2X6dvy/VsI
pr6Gq8Fm73gVG4QvaeQUzCMirGDYaibjghjJYWY8pASy612FMhNtRE+Qz43hitfF
h1iqU54bHxqVu8MGR0oxHYZfZdl3AznPFwl5zZQorNmhdItGQuTkwZT2UPfRGCdC
/uPAT56uBztt8dPGuCtoYuKDoXQ9OOGSb60H8e0+zPWNvrC5hkfu9X9wftwv6pE=
=OrT4
-----END PGP SIGNATURE-----

--Yzd3n0fjcrTXF6/a--

--===============5912728019044332642==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============5912728019044332642==--
