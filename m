From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH] ASoC: rt5645: Add codec driver
Date: Tue, 22 Apr 2014 11:53:27 +0100
Message-ID: <20140422105327.GL12304@sirena.org.uk>
References: <1397212459-26495-1-git-send-email-oder_chiou@realtek.com>
 <20140414202837.GA25182@sirena.org.uk>
 <CAD+35SMEmaqRkytk7oGLLD0baq_n3GWsm2RZg1m4nRF7jcb0RQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============6942474760641003072=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 4876D261A92
 for <alsa-devel@alsa-project.org>; Tue, 22 Apr 2014 12:53:38 +0200 (CEST)
In-Reply-To: <CAD+35SMEmaqRkytk7oGLLD0baq_n3GWsm2RZg1m4nRF7jcb0RQ@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Oder <oder_chiou@realtek.com>
Cc: Bard Liao <bardliao@realtek.com>, alsa-devel@alsa-project.org, lgirdwood@gmail.com, Flove <flove@realtek.com>
List-Id: alsa-devel@alsa-project.org


--===============6942474760641003072==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="oSvtmtnH4bRUIYpj"
Content-Disposition: inline


--oSvtmtnH4bRUIYpj
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Apr 22, 2014 at 09:10:19AM +0800, Oder wrote:

> > Since the device can power up and down very quickly it should make sense
> > to set idle_bias_off for a power saving when idle.

> We've set the idle_bias_off as true in struct "soc_codec_dev_rt5645",
> is there any thing i miss it?

No, nothing - sorry, I didn't notice that.

--oSvtmtnH4bRUIYpj
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJTVkokAAoJELSic+t+oim9FDYP/2p/tctuOmkOuf2sIHn5GDlD
SlCi1XQbpsXxT/tVIdqfzmcjBtwdLN/e+TT3Ca3p2EWMQ96+1rLR6YNpRuPSNWAt
cVXMScwQP7ywXjRGxdm1/jMo974zVO5WI9rvOLLbUD+iZ39GiE8xEwEclLsZvTXn
wrU44nSEm7QuiwUeLnLHUDgQWuQ3d9Nbo425ufZDbqdzAOWVMB1r0wzrvzcHGDW8
JPPSiLLbwh41cLJIh43Xs2rFK/AvIsRxtdJnzs2NkaG9XZ1lJ/laXHaHQzpicmYx
lkTWNQPtVKUvJWyyqZL3R4b8QuOSVXzoH1IMzL55pQ364WPgaiJkfpnYYiZVYXdz
GvYQwjZbXGV/nEIK+i9vT7e7LoNirOmi6k6lidTT4gRIk6yGYxikPnwNqyGijJNf
NxOp6owQCdGUq6sHB6GEv37oLPw7kQ6saM5eldZxoJe5w1aaBHc9OXIewpfAqs2H
CvgM7KwsYdyz1aLrMMbk6xNUNjMX+1EQV4vvt1CL+3xFl+9h3ZVZ1nygChQOoUnR
VFghwyhtU9beHJYU328gCXTMcXetqHsQrmn2IherqUnoamu9QNO6+dqT5icm4ttG
fZtUqqLW47wsyCNr/76uT9sTwX8ylhw2euxnKjTrN/m14LhVww9wqqtSQSHk+rqu
MXCVd3igZFO357P0cSIe
=bS3Z
-----END PGP SIGNATURE-----

--oSvtmtnH4bRUIYpj--

--===============6942474760641003072==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============6942474760641003072==--
