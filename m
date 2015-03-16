From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH] ASoC: nuc900: No need to track the dma
 buffer in the driver state struct
Date: Mon, 16 Mar 2015 11:41:01 +0000
Message-ID: <20150316114101.GO28806@sirena.org.uk>
References: <1426418124-1096-1-git-send-email-lars@metafoo.de>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============9180761170367717195=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 6569D2606D8
 for <alsa-devel@alsa-project.org>; Mon, 16 Mar 2015 12:41:07 +0100 (CET)
In-Reply-To: <1426418124-1096-1-git-send-email-lars@metafoo.de>
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
Cc: alsa-devel@alsa-project.org, Liam Girdwood <lgirdwood@gmail.com>, Wan ZongShun <mcuos.com@gmail.com>
List-Id: alsa-devel@alsa-project.org


--===============9180761170367717195==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="tiH+Y7KRmUKKY6DB"
Content-Disposition: inline


--tiH+Y7KRmUKKY6DB
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Sun, Mar 15, 2015 at 12:15:24PM +0100, Lars-Peter Clausen wrote:
> The DMA buffer and address can be accessed through the snd_pcm_runtime.
> There is no need to manually track them in the driver's state struct.

Applied, thanks.

--tiH+Y7KRmUKKY6DB
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJVBsFMAAoJECTWi3JdVIfQsY8H/0OlB21jKa+Nvl1Yc7wrhDM+
HWlqJAqtUsYN+amN9edL9oZep9hKsx3C7QkXlnQ5JIswBYg1W00QLg7zhZODdbyP
MzHD9DheTO1LI2sbpXixIyCZKED7GT45r81IUvgeJfvPYBJxhR7kPL5BRMpv031g
Zl1YIHL4fiED8AUHxNWHnzYX2FBr6anHcJ5czxWVJk7/tqV30Kjy/0yTS8zt2nD6
yM4ysrfrhxq0M9BOfz9K4aIjPzHfF2eYR1WTcT50onrGJzDCYCKorQKaLADMja8J
VzQVd3NZGb5Gh3fewwQyVtTLfrV3Ltit8BM4DfJphuLxzfDhO8aBoEKawUOY8Jw=
=rDrC
-----END PGP SIGNATURE-----

--tiH+Y7KRmUKKY6DB--

--===============9180761170367717195==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============9180761170367717195==--
