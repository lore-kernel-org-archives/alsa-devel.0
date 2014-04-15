From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH] ASoC: wm8997: Fix compile error
Date: Tue, 15 Apr 2014 10:06:16 +0100
Message-ID: <20140415090616.GI12304@sirena.org.uk>
References: <1397540765-30843-1-git-send-email-lars@metafoo.de>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============9004227008230097912=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 193EE261AF9
 for <alsa-devel@alsa-project.org>; Tue, 15 Apr 2014 11:06:39 +0200 (CEST)
In-Reply-To: <1397540765-30843-1-git-send-email-lars@metafoo.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Lars-Peter Clausen <lars@metafoo.de>
Cc: Stephen Rothwell <sfr@canb.auug.org.au>, Charles Keepax <ckeepax@opensource.wolfsonmicro.com>, patches@opensource.wolfsonmicro.com, Liam Girdwood <lgirdwood@gmail.com>, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org


--===============9004227008230097912==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="J+eNKFoVC4T1DV3f"
Content-Disposition: inline


--J+eNKFoVC4T1DV3f
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Apr 15, 2014 at 07:46:05AM +0200, Lars-Peter Clausen wrote:
> The macro's name is SOC_ENUM, not SOC_VALUE.

Applied, thanks.  Nothing from the zero day tester...  :/

--J+eNKFoVC4T1DV3f
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJTTPaFAAoJELSic+t+oim9Tg0P/jwaNsdVJbG5D0cevVgWM5FE
DPjJ1EHyQ9JFtm5JE8XqH5cbzBXazGafeh3JFWHO+PObe3i5cTE/DV3EILWuYkF/
6B0/I6YYC6z1mWl6CHGkCvs3GdjtXEi1shwCXQW6NmIYZ/JrqpmUMi+rE8CtZB0i
h3Wur3y2pebw0t2kowZ3fL4HRzYYTOYPLaFGiE/+sThUbfPyVB6Eobr/M46jefPK
VuAV4fiVlx9S2TQcVoO58p513Uc9321vH0Iu1PANpozHsljMe6rh3cEG1SUXrNsK
aR/409viTY+jeKaNNZDo8TJGaDFRE4pKIzBk5DgrNiJokjVV4fiVyE4hJSpwB3VI
wpf+a4vj7EEm6Ut8o7cFc8jRcqFLS5Bcxz2Ntn57N5xKJjpE/Vj9+g/mPR4QBL6S
eVnQr5yPJSo+XFgEV6aUpq8Aj6z9PPNxsRpWX6a2iIe5cbyBPx3HQqhv+nf8QdOF
9owSRdcnPOpfcDvNSeoDphldspdBDSTMOZqh4VlTqBlrL9TaiEpUB5fYLPCep8oD
L/a084l6t6M8PYKKxkLLBG/0iPWdV2CXBnoFDmChGZxQKjXW8pqMSatYtlMxoaZX
GkdEi8uKP4B++G2K/OpWT0pczVFCaAiddtdnG76KMTMlHOPcS03nDi54ar6xqHPw
EOZghZ3hC6mIsIKJyQY8
=x3R3
-----END PGP SIGNATURE-----

--J+eNKFoVC4T1DV3f--

--===============9004227008230097912==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============9004227008230097912==--
