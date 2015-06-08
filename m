From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH v3 1/3] ASoC: rt5645: make
	RT5650_TDM_CTRL_4 readable
Date: Mon, 8 Jun 2015 19:27:42 +0100
Message-ID: <20150608182742.GW14071@sirena.org.uk>
References: <1433481857-28437-1-git-send-email-bardliao@realtek.com>
 <20150608180925.GS14071@sirena.org.uk>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============4358097180209222348=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 98D432604C7
 for <alsa-devel@alsa-project.org>; Mon,  8 Jun 2015 20:27:54 +0200 (CEST)
In-Reply-To: <20150608180925.GS14071@sirena.org.uk>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Bard Liao <bardliao@realtek.com>
Cc: oder_chiou@realtek.com, alsa-devel@alsa-project.org, lars@metafoo.de, zhengxing@rock-chips.com, yang.a.fang@intel.com, lgirdwood@gmail.com, john.lin@realtek.com, koro.chen@mediatek.com, drinkcat@chromium.org, flove@realtek.com
List-Id: alsa-devel@alsa-project.org


--===============4358097180209222348==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="yemHoCqAZaCul8x8"
Content-Disposition: inline


--yemHoCqAZaCul8x8
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Jun 08, 2015 at 07:09:25PM +0100, Mark Brown wrote:
> On Fri, Jun 05, 2015 at 01:24:15PM +0800, Bard Liao wrote:
> > Register RT5650_TDM_CTRL_4(0x7A) is readable and used for mixer
> > setting. It should be added in rt5645_readable_register function.
>=20
> Applied all, thanks.

=2E..then dropped as this seems to have lots of non-trivial conficts with
the fix/rt5645 branch.  Can you please check what's going on there and
resend?  Please use the tag I just sent to Takashi (asoc-v4.2) as the
thing to base your patches on for this resend.

--yemHoCqAZaCul8x8
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJVdd6dAAoJECTWi3JdVIfQGggH+gNc93fxp23wlP/Tz95yThWO
d+OTOXMDAZ6MpR4oodtQ1yfpI0futv6it3zl1FU74sz1PWdvnqYlMXzUphTbD0oD
6c54T8eC/VnIQeCbmARd7ueI4fuGP+C3jDrXNJ4tWMg1OUEZXMf6zGLOPxdX6sCB
RxMbhKPvPQczKdz4tnXU4lyRPMmlfO/MuYMyEYTeW9jQYOBqo2cU5s/Tdd6W4UY1
IfioJ/T984lud4gjudffZVgcRZKoiPHhxEnHEu/UteO2T3UX3R53F2R8mdtHsCxe
c85TcZCeUznaOsnyerNrDvovqpb/OvKx2yAxT/FENAnwp974fekKBEdDaDCY+4o=
=xHpQ
-----END PGP SIGNATURE-----

--yemHoCqAZaCul8x8--

--===============4358097180209222348==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============4358097180209222348==--
