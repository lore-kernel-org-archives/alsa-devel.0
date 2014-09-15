From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH 2/2] ASoC: rt5677: Add the GPIO function
Date: Mon, 15 Sep 2014 14:46:42 -0700
Message-ID: <20140915214641.GY7960@sirena.org.uk>
References: <1410782325-10541-1-git-send-email-oder_chiou@realtek.com>
 <1410782325-10541-2-git-send-email-oder_chiou@realtek.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============5437472332387737348=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 33C7C26599B
 for <alsa-devel@alsa-project.org>; Mon, 15 Sep 2014 23:48:55 +0200 (CEST)
In-Reply-To: <1410782325-10541-2-git-send-email-oder_chiou@realtek.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Oder Chiou <oder_chiou@realtek.com>
Cc: bardliao@realtek.com, alsa-devel@alsa-project.org, lgirdwood@gmail.com, flove@realtek.com
List-Id: alsa-devel@alsa-project.org


--===============5437472332387737348==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="AQDb5/OyJPRJL1y9"
Content-Disposition: inline


--AQDb5/OyJPRJL1y9
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Sep 15, 2014 at 07:58:45PM +0800, Oder Chiou wrote:

> +	switch (offset) {
> +	case RT5677_GPIO1:
> +		regmap_update_bits(rt5677->regmap, RT5677_GPIO_CTRL2,
> +			RT5677_GPIO1_OUT_MASK, !!value << RT5677_GPIO1_OUT_SFT);
> +		break;

All these functions could be cut down quite a bit - rather than having
individual switch statements for every single operation for every single
GPIO we can calculate the required shifts, we just need to look up the
register to write into (or calculate it).  This would be much nicer from
a code point of view.

--AQDb5/OyJPRJL1y9
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBAgAGBQJUF149AAoJECTWi3JdVIfQQr4H/3FI1jf7V0rVJCwKHSChAXu3
tbACrYmv3vdHWTrdPEeFa3I3elSIlUrodUlQV06JBbBZed8x2dXR8zPAmPQtMN+O
vDwQOKQDn2Nw5VxI5g/RaodLG0wqoTgduVriJ+M3jy0yEBqhY2rUhdgDHjQP4d3N
URDqG1mNV2x4OcMHPF4jtbR7uran7KZyubOqxX6w+479kDViYsNhbpG1OjFwbSpb
mC9m9/ZuahJN0L02C/7HnGZEUOnzgDWWrZ5bvUdasVM6yH08wbh4a/Al1fd3yMuN
6R859Glnrc1Q+P+0+F/JiAogCvVb46a7d1pp0s5nuigE5+1cy3ip3N1nRbscW98=
=mplJ
-----END PGP SIGNATURE-----

--AQDb5/OyJPRJL1y9--

--===============5437472332387737348==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============5437472332387737348==--
