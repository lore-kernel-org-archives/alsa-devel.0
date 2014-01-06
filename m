From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH v3 5/5] ASoC: sirf-inner: add mach driver
 for SiRFSoC internal codec
Date: Mon, 6 Jan 2014 17:35:13 +0000
Message-ID: <20140106173513.GO31886@sirena.org.uk>
References: <1388729104-28643-1-git-send-email-rongjun.ying@csr.com>
 <1388729104-28643-6-git-send-email-rongjun.ying@csr.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============2727669458384766043=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id D097C261ACD
 for <alsa-devel@alsa-project.org>; Mon,  6 Jan 2014 18:35:24 +0100 (CET)
In-Reply-To: <1388729104-28643-6-git-send-email-rongjun.ying@csr.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: RongJun Ying <rjying@gmail.com>
Cc: alsa-devel@alsa-project.org, Takashi Iwai <tiwai@suse.de>, Liam Girdwood <lgirdwood@gmail.com>, Workgroup.linux@csr.com, Rongjun Ying <Rongjun.Ying@csr.com>
List-Id: alsa-devel@alsa-project.org


--===============2727669458384766043==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="2j1mLUaeHP5SPh5F"
Content-Disposition: inline


--2j1mLUaeHP5SPh5F
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Jan 03, 2014 at 02:05:04PM +0800, RongJun Ying wrote:

> +	struct sirf_inner_card *sinner_card = snd_soc_card_get_drvdata(card);

I see where it comes from but "sinner" is a really odd abbrevation to
use in a mostly English context.

Otherwise this looks fine.

--2j1mLUaeHP5SPh5F
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJSyulNAAoJELSic+t+oim98iUP/RPlioSgSMO2KxQa8T3OoLZo
FwVNA6Oac06fktmGUAv/f7jgjtVwC0fDB+dZFxiWTQZGfE5zA12Lbv08bPec/rNq
MwmwjTJ04ui1MG4SlJYXis6Y6waCL4QS3Wr2uJ4U1AlOJchblEtqN+3dJQlbmBcJ
Sg9C7BGffmt5sjuDOXhAA5lzMlhBkoERXDX8esVUOcpbaG9TYfA7aMPh6iay0nRG
oej+evI3U/Ui4uCm7MeOjDXzLrfuKbrWBCKCK5XCRhbhs+elZdgZeVDx1+fgcDc+
Ss4RnPre0nXD1ws5JZtHIlszI0jTRW9KY+nYjxc/aTMPTx/oJZGC46kF1Rcq9kSu
6snBZ4MOqFXYEIjj81R3xROa7/UY3k2JNEM0ajZnqfRznX12vRd7kkUggm0mPiCr
xsrkKSpgny0EmKyy3EaNk/kzAOYVH8isdDvpI+g/6vIdlmz0bgovVWcT/OTgWcyg
5tx5oip/KL3CbdipQlLd604RQjA9f7I5gzm39ooSkSZF+isL3CLi4Xt1ftbxHCJk
eGPg/8lgunmpjZq3fQq/aCyu5KYdMmO72ozw+NkNpkspqpZ+YC633xtacnOvQ5Sz
LxJ0Gc6Mc7asq9W0cvG8cGEcXbMy8URdj7VA6m87wQ36/+NUdWkxsQFgjLXMmicM
nwS+iHGUUTJUoETvTUzH
=zNWj
-----END PGP SIGNATURE-----

--2j1mLUaeHP5SPh5F--

--===============2727669458384766043==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============2727669458384766043==--
