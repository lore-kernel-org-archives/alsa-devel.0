From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH] Allow snd_soc_update_bits use 32 bits
	register
Date: Mon, 7 Apr 2014 10:53:13 +0100
Message-ID: <20140407095313.GA14763@sirena.org.uk>
References: <1396769321-32694-1-git-send-email-bardliao@realtek.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============7723150332386467241=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id D4E532610A8
 for <alsa-devel@alsa-project.org>; Mon,  7 Apr 2014 11:53:24 +0200 (CEST)
In-Reply-To: <1396769321-32694-1-git-send-email-bardliao@realtek.com>
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
Cc: oder_chiou@realtek.com, alsa-devel@alsa-project.org, lars@metafoo.de, lgirdwood@gmail.com, flove@realtek.com
List-Id: alsa-devel@alsa-project.org


--===============7723150332386467241==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="NP+fiIeNjDlB/E6h"
Content-Disposition: inline


--NP+fiIeNjDlB/E6h
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Apr 06, 2014 at 03:28:41PM +0800, bardliao@realtek.com wrote:
> From: Bard Liao <bardliao@realtek.com>
>=20
> Change reg's type from unsigned short to unsigned int. So that we can
> use 32 bits reg value in snd_soc_update_bits.

I've applied this since it's a move in the right direction but you've
only done half the job - like I said previously you should be doing the
same thing for _locked() too.  Please also use subject lines appropraite
for the subsystem and word wrap within paragraphs in your commit
message.

--NP+fiIeNjDlB/E6h
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJTQnWGAAoJELSic+t+oim94woQAIezbUDwjiSSsKvb3OUV0Dxx
ccwYiSm91VD0GJ4FZliyDeQpMfEeQNd15074fUBQ3LJysiacjQiaoQoMB08U0SHh
z10Ye70jeIBKR4QDF0/FA4JXpn3deu3El2hnm9xYMr1udv3LpHocBGk3GiM8+Ca/
PIFVwppXgWC5a//NgHskt565ih78v7ADmgqOW1jRBAYaZw8PHnlJCEHb6aE3paPb
l88o+hiGg+wpWvqZ7zI8hJfg3YVXcJIf0JEn9vK343QgoV/MmAdOMxLEepaHULTi
zSXOz/nc1HNh+++pkTa6OzPNbaXBkCMv4UlTTREdIOCU7f1PYpSYWPB5yaUFvi4F
u58ONfqO9l8yRZ0Hc+ki54hS7cJQqZ16KqbIUp4jRlbigIMmfZDg3dffQDN2TJUK
2M6nR0hbAobrItWrQfxk1dAG3hkmPdRBPJ+ZniGXdSxE2nSPkJVVpYQETIbOLyz0
r5mGKExIt3MRiuSRSiq5gwBTfbCHrDCl56FjzNMQmR6vwnzY5oRAm2RzK6axdvJM
kgbsMZGn/EtH/l78/DZSYig9KjcvdfG2gmObsAAWc/PrD5Jk29w4dpmAl4hMLYz+
qRcnjShHapY1R2/K535SuvMBAJpay94Vkkmnk3hVZvxq6wzbMG77nz8/C0uhMMKr
5JYi7ZrMgViyzl5eARwb
=DyiG
-----END PGP SIGNATURE-----

--NP+fiIeNjDlB/E6h--

--===============7723150332386467241==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============7723150332386467241==--
