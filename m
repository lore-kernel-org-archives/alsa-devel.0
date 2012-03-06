From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH 2/2] ASoC: DAPM - Make sure DAPM widget IO
 ops hold the component mutex.
Date: Tue, 6 Mar 2012 20:03:54 +0000
Message-ID: <20120306200354.GB19635@opensource.wolfsonmicro.com>
References: <1331057779-4630-1-git-send-email-lrg@ti.com>
	<1331057779-4630-2-git-send-email-lrg@ti.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============4495864488220297426=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id AD35E24402
	for <alsa-devel@alsa-project.org>; Tue,  6 Mar 2012 21:03:55 +0100 (CET)
In-Reply-To: <1331057779-4630-2-git-send-email-lrg@ti.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Liam Girdwood <lrg@ti.com>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org


--===============4495864488220297426==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="ri7MIv52hxsKkbzo"
Content-Disposition: inline


--ri7MIv52hxsKkbzo
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Mar 06, 2012 at 06:16:19PM +0000, Liam Girdwood wrote:

> +	if (w->codec)
> +		mutex_lock(&w->codec->mutex);

Actually for CODECs we don't need to hold the CODEC mutex for I/O if
we've pushed the cache down into regmap - regmap does all the locking
for us.  I'll send a followup patch.

--ri7MIv52hxsKkbzo
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iQIcBAEBAgAGBQJPVm2jAAoJEBus8iNuMP3d4aIP/A8+sJGG/zAklzsALSOORLQM
Bv0gscNJkWrWxZ7wGA5F04XK6CDoR36jkxc7esyoXaH6eeQiufDcAzYQgdEy09dU
9JApVnGGk71awJE26tnQT/0NxROLYgoVoQ1DmR4t89ryhg4Izsj6xUOFxhjk/NmO
Kwp7cJstu7Ixq89i7bL6j96aDim05M2tM40ije4cK/upqr6FHTDhmGx+j8HiCusm
ATOC9AcFvmroCbuSQIPrFF/QwFq9HkF9yUnwG9BR+m1cyJDwHYzWsQcPz80OzJ8v
Y23PiG7P6BB1NcefN3tq1JSlyaP/gEQviAjlBXgRLKUyHU25gQKThoV5Jk8WrUYF
GUOD1oAzOxk+CTtHqYRJyra5oP5L8vPegcXQ4ICaFVDh/johO+eb6LZIWv7U+JyY
mL/RUDRQ5vCAYL6797jGE6hCXq56YRL8iiYVLrIoGuan/ROe1um5YQxniCWhVXlN
JjCtkrI8C7t6j9tXF/oTDyKFaVUQvtDbxEPUE22BzVhLiyXIdcRtZ/gbjvXk6yaG
2Hej6kEBytzW1TiGbB/G11rWOZwJgACyGAr2Yi+y5e/sKxt+s5N5QYgpEtoYSCO3
BtttjZr+O5lS1W9Y56CSQKCG+PdaQmjsZpCzS53KEBO7lBOSK1K+/1yyPGj6XZt/
BUZc9Rxrn/YTyvx3j6ea
=rVqy
-----END PGP SIGNATURE-----

--ri7MIv52hxsKkbzo--

--===============4495864488220297426==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============4495864488220297426==--
