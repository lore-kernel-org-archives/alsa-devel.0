From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH 1/2] ASoC: rt5645: fix jack type detect
	error
Date: Mon, 11 May 2015 17:06:19 +0100
Message-ID: <20150511160619.GL3458@sirena.org.uk>
References: <1431064414-27676-1-git-send-email-john.lin@realtek.com>
 <20150508171413.GE2761@sirena.org.uk>
 <14AE6189BDA733429BF8455FEEF63298010D9346@RTITMBSV02.realtek.com.tw>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1863432288349889400=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 1BB37264F45
 for <alsa-devel@alsa-project.org>; Mon, 11 May 2015 18:06:28 +0200 (CEST)
In-Reply-To: <14AE6189BDA733429BF8455FEEF63298010D9346@RTITMBSV02.realtek.com.tw>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: John Lin <john.lin@realtek.com>
Cc: Oder Chiou <oder_chiou@realtek.com>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, "zhengxing@rock-chips.com" <zhengxing@rock-chips.com>, "yang.a.fang@intel.com" <yang.a.fang@intel.com>, "koro.chen@mediatek.com" <koro.chen@mediatek.com>, "lgirdwood@gmail.com" <lgirdwood@gmail.com>, Bard Liao <bardliao@realtek.com>, Flove <flove@realtek.com>
List-Id: alsa-devel@alsa-project.org


--===============1863432288349889400==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="dfmC41YZQlborXoK"
Content-Disposition: inline


--dfmC41YZQlborXoK
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, May 11, 2015 at 02:33:36AM +0000, John Lin wrote:
> > -----Original Message-----
> > From: Mark Brown [mailto:broonie@kernel.org]
> > Sent: Saturday, May 09, 2015 1:14 AM
> > To: John Lin
> > Cc: lgirdwood@gmail.com; alsa-devel@alsa-project.org; Bard Liao; Flove;
> > Oder Chiou; koro.chen@mediatek.com; yang.a.fang@intel.com;
> > zhengxing@rock-chips.com
> > Subject: Re: [PATCH 1/2] ASoC: rt5645: fix jack type detect error

> > On Fri, May 08, 2015 at 01:53:33PM +0800, John Lin wrote:
> > > rt5645_jack_detect doesn't report the correct jack type consistently.
> > > This patch can make it more stable.

> > Can you be more specific about what the problem is and how this fixes it
> > pleased?  It's a bit hard to review based on your changelog.

> It mistakes OMTP type headset to CTIA type if "LDO2" power is disable in=
=20
> jack detection function. So, we keep "LDO2" power enabled until jack out.
> We also change the register sequence to make it more stable and remove=20
> unnecessary power such as "micbias1" and "micbias2" for jack detection.

This stuff needs to be in the changelog.  It also sounds like there's at
least two probably three patches here - one to keep the LDO power
enabled for lonnger and one or more changes to the register sequence.

--dfmC41YZQlborXoK
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJVUNN7AAoJECTWi3JdVIfQ5PIH/AjDekf9dajeG9BZDp9K7nuf
JP+iZK9HEryJKtSfHHXEQBgMOb3qvXxH9pWQvmvnmTTJzBMpMdC092qv+L5+mDou
aRLehyHr+lNGMYB+qooFtyxS06y1AXJTzomTRzwoNVKH+wnO5V0khtaV6tbYFgcU
JcxKRFgBtGyx9r0yMxAxvf13wcJqj3X1u5r029p6SGHrmqP1jKLWvNyUuDZ4Agrz
G1cXdIxVIF2EW//zng+F3LdumbV68EQv6OItBbGDyGpg98P54Z66LQhIzBslLyD+
WQx39tAiQ90RGxaKEODq635f+4BU/QfqiGRgIb2lQe2/X0pldtHbgBUfVLB/ycs=
=cajt
-----END PGP SIGNATURE-----

--dfmC41YZQlborXoK--

--===============1863432288349889400==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============1863432288349889400==--
