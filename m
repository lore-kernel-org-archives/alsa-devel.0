From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH v2 3/7] ASoC: pcm512x: Change register
 default to match actual content after reset
Date: Wed, 28 Jan 2015 19:12:17 +0000
Message-ID: <20150128191217.GF21293@sirena.org.uk>
References: <1422454572-7847-1-git-send-email-peda@lysator.liu.se>
 <1422454572-7847-4-git-send-email-peda@lysator.liu.se>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============6223819811956975951=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 2ACD626262D
 for <alsa-devel@alsa-project.org>; Wed, 28 Jan 2015 20:12:42 +0100 (CET)
In-Reply-To: <1422454572-7847-4-git-send-email-peda@lysator.liu.se>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Peter Rosin <peda@lysator.liu.se>
Cc: Mark Rutland <mark.rutland@arm.com>, devicetree@vger.kernel.org, alsa-devel@alsa-project.org, Lars-Peter Clausen <lars@metafoo.de>, Pawel Moll <pawel.moll@arm.com>, Ian Campbell <ijc+devicetree@hellion.org.uk>, Takashi Iwai <tiwai@suse.de>, linux-kernel@vger.kernel.org, Clemens Ladisch <clemens@ladisch.de>, Liam Girdwood <lgirdwood@gmail.com>, Rob Herring <robh+dt@kernel.org>, Kumar Gala <galak@codeaurora.org>, Peter Rosin <peda@axentia.se>
List-Id: alsa-devel@alsa-project.org


--===============6223819811956975951==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="D0SLKVBHTY2PnTRz"
Content-Disposition: inline


--D0SLKVBHTY2PnTRz
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Jan 28, 2015 at 03:16:08PM +0100, Peter Rosin wrote:

> @@ -78,7 +78,7 @@ static const struct reg_default pcm512x_reg_defaults[] = {
>  	{ PCM512x_DIGITAL_VOLUME_2,  0x30 },
>  	{ PCM512x_DIGITAL_VOLUME_3,  0x30 },
>  	{ PCM512x_DIGITAL_MUTE_1,    0x22 },
> -	{ PCM512x_DIGITAL_MUTE_2,    0x00 },
> +	{ PCM512x_DIGITAL_MUTE_2,    0x02 },

The datasheet claims these have undefined values as reserved bits - what
would be a more robust change here would be to remove the register
default entirely so that we take the value the hardware has, giving
robustness against any hardware revisions.  Of course the device has
rather a lot of such reserved bits which is unfortunate.

--D0SLKVBHTY2PnTRz
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJUyTSQAAoJECTWi3JdVIfQHbEH/2KTA7lklj4WLNDJ706ddWpj
RTieI5BM4hah+P+2UZrhufBXqTyQsg8ihJKMmNk8GWEgZ4WOYUkWr62qut7P9tXD
PLFcx8fIstV4CcHUPAn4WAd40emxED0TPZ6FEPPtr3FCpdv5Bdb4VGKU0I4uBvlB
rmClU8/c9b0krrSFv6CV+zobQCf5KjxMoCx7p+QESxm1JryeG9W2iN//kiJDT0rY
ynSL/OaCvARWY6H7qveTD0HSwSc1/YE29jJtcEzKg7W1512Kr7M7XvayBXTN0dbT
yrqAWfWbritrjjpb/izneUZoDPYBqwtQt1cgQnKNNLTZqmTP3lmeMeg5Eqbp7gQ=
=rL61
-----END PGP SIGNATURE-----

--D0SLKVBHTY2PnTRz--

--===============6223819811956975951==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============6223819811956975951==--
