From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH] ASoC: Intel: remove unneeded variable
Date: Sun, 12 Apr 2015 12:40:21 +0100
Message-ID: <20150412114021.GX6023@sirena.org.uk>
References: <alpine.DEB.2.02.1504120753060.2112@localhost6.localdomain6>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0484176878967817704=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 4BE5A26056A
 for <alsa-devel@alsa-project.org>; Sun, 12 Apr 2015 13:40:41 +0200 (CEST)
In-Reply-To: <alpine.DEB.2.02.1504120753060.2112@localhost6.localdomain6>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Julia Lawall <julia.lawall@lip6.fr>
Cc: Wenkai Du <wenkai.du@intel.com>, alsa-devel@alsa-project.org, Kees Cook <keescook@chromium.org>, Takashi Iwai <tiwai@suse.de>, Imre Deak <imre.deak@intel.com>, Liam Girdwood <lgirdwood@gmail.com>, Jarkko Nikula <jarkko.nikula@linux.intel.com>
List-Id: alsa-devel@alsa-project.org


--===============0484176878967817704==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="bfY1ATG2XARAaYxF"
Content-Disposition: inline


--bfY1ATG2XARAaYxF
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Apr 12, 2015 at 07:55:30AM +0200, Julia Lawall wrote:
> Removes unneeded variable used to store return value.

> +++ b/sound/soc/intel/baytrail/sst-baytrail-ipc.c
> @@ -511,7 +511,6 @@ static int sst_byt_process_notification(
>  	struct sst_byt_stream *stream;
>  	u64 header;
>  	u8 msg_id, stream_id;
> -	int handled =3D 1;
> =20
>  	header =3D sst_dsp_shim_read64_unlocked(sst, SST_IPCD);
>  	msg_id =3D sst_byt_header_msg_id(header);
> @@ -531,7 +530,7 @@ static int sst_byt_process_notification(
>  		break;
>  	}
> =20
> -	return handled;
> +	return 1;

This seems like the script has identified an error - it looks like we
should be managing handled more actively in the function.

--bfY1ATG2XARAaYxF
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJVKlmlAAoJECTWi3JdVIfQXSEH/jJ+0kgXpbehpB8N47VnYzGv
QVfMgv4DXTpQ9pJAUYhgfuMsRfBeZZfhAHqYckKtNbwV13w5XHYbzPctvD5VUmfM
QY2m2ahjS/a9yb9A+gnzoOXJbuxF5qqgW7pEinG+37vO+/zZvcGQ1KsHcFAiROhx
961Kp0acjTlGMBEVdj5IQppvC4LHhh8Hzqj0Wo+WBrJJdXmweoitunKltDhKWT5B
lhdhEcyl+H7VmJ4kPbvgqjU8/MEGmw5Otd1WaIEgJ5YfdcHzvBjMWUjO3/V6ktJ1
cgefBcJ8b0r+gJHpQO+mW/d9enJ+/+hz+hWGe6FLfDzgVOmMqYXSSG+lrQAjuos=
=O3Qu
-----END PGP SIGNATURE-----

--bfY1ATG2XARAaYxF--

--===============0484176878967817704==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============0484176878967817704==--
