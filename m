From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH v3 1/2] ASoC: rt5645: add API to select
	ASRC clock source
Date: Wed, 4 Feb 2015 20:31:43 +0000
Message-ID: <20150204203143.GH21293@sirena.org.uk>
References: <1422991551-28544-2-git-send-email-yang.a.fang@intel.com>
 <1422993828-29292-1-git-send-email-yang.a.fang@intel.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============6416811489149225675=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 3871B26053D
 for <alsa-devel@alsa-project.org>; Wed,  4 Feb 2015 21:31:49 +0100 (CET)
In-Reply-To: <1422993828-29292-1-git-send-email-yang.a.fang@intel.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: yang.a.fang@intel.com
Cc: alsa-devel@alsa-project.org, denny.iriawan@intel.com, harshapriya.n@intel.com, praveen.k.jain@intel.com, lgirdwood@gmail.com, kevin.strasser@intel.com, vinod.koul@intel.com, mengdong.lin@intel.com, bardliao@realtek.com
List-Id: alsa-devel@alsa-project.org


--===============6416811489149225675==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="BKkPHfnwJkbQWWrn"
Content-Disposition: inline


--BKkPHfnwJkbQWWrn
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Feb 03, 2015 at 12:03:47PM -0800, yang.a.fang@intel.com wrote:
> From: "Fang, Yang A" <yang.a.fang@intel.com>
>=20
> This patch defines an API to select the clock source for specified filter=
s.

This doesn't apply against current code, looks like a conflict with the
rt5650 support patch.  Please check and resend.

> +	if ((clk_src !=3D RT5645_CLK_SEL_SYS) &&
> +	    (clk_src !=3D RT5645_CLK_SEL_I2S1_ASRC) &&
> +	    (clk_src !=3D RT5645_CLK_SEL_I2S2_ASRC) &&
> +	    (clk_src !=3D RT5645_CLK_SEL_SYS2))
> +			return -EINVAL;

That return statement is indented a bit far (it should just be a tab,
it's not really anything to do with the constants so shouldn't be lined
up with them).  The whole thing would be better written as a switch
statement (return -EINVAL in the default case and break on a known
source).

--BKkPHfnwJkbQWWrn
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJU0oGvAAoJECTWi3JdVIfQOL0H/3Lv6VH8y4mkAbCmnNXv9sX3
vaQD7GsFirqVh1H5kcqUE3rOX06gNrk0OuskMwslVoGWkv6uCSMHR+tS3B4XOCBu
/flg4dB6oPi9HatB8z2aBTuxdQXglaminb128G0diBDXPLqv4u892LV5wuGzPRYy
6zz1I5UBN8ccVEqlWHju2B/x6/FfLWeQKIdaKCQqF9d6+Mye5Rszdaak3dtGW52E
pDNLQSoLSeM9D940aIn1TTerMVVD/mVrLtH9pvqF5VEDiy4Txh3Ucch0KMwBPu9U
qKYHFzJHXHArb2g7yIK9OAunPQPd4PWSYoBt4aFY5A1ao6kpFDbKdpT9yhtcfwc=
=AJ18
-----END PGP SIGNATURE-----

--BKkPHfnwJkbQWWrn--

--===============6416811489149225675==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============6416811489149225675==--
