From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH v2 1/4] ASoC: omap-pcm: Request the DMA
 channel differently when DT is involved
Date: Thu, 11 Jul 2013 17:38:29 +0100
Message-ID: <20130711163829.GS24508@sirena.org.uk>
References: <1373546146-30271-1-git-send-email-peter.ujfalusi@ti.com>
 <1373546146-30271-2-git-send-email-peter.ujfalusi@ti.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============2001220912209237627=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
 by alsa0.perex.cz (Postfix) with ESMTP id 8D1D6265087
 for <alsa-devel@alsa-project.org>; Thu, 11 Jul 2013 18:38:34 +0200 (CEST)
In-Reply-To: <1373546146-30271-2-git-send-email-peter.ujfalusi@ti.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Peter Ujfalusi <peter.ujfalusi@ti.com>
Cc: alsa-devel@alsa-project.org, Lars-Peter Clausen <lars@metafoo.de>, Liam Girdwood <lgirdwood@gmail.com>, Jarkko Nikula <jarkko.nikula@bitmer.com>
List-Id: alsa-devel@alsa-project.org


--===============2001220912209237627==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="JWOY2/vB4uO4FuME"
Content-Disposition: inline


--JWOY2/vB4uO4FuME
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Jul 11, 2013 at 02:35:43PM +0200, Peter Ujfalusi wrote:
> When booting with DT the platform_get_resource_byname() is not available to
> get the DMA resource. In this case the DAI drivers will set the filter_data to
> the name of the DMA and omap-pcm can use this to request the DMA channel.

Applied all, thanks.

--JWOY2/vB4uO4FuME
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.20 (GNU/Linux)

iQIcBAEBAgAGBQJR3t+BAAoJELSic+t+oim9WMQP/0N0N23HuDcCHQYGWQcJFhTz
/l/jB7RSQv7TCKu2AO9ySg4iS99DfRecidb+hmb3Qi9kNnU7Kaha/oDGpnchUmns
tQWG8wDdpW43nvDLgCX1e1dllrWHrv3hJiWXJ59vFMWuMKwcscJHvZLOWc53bbrk
Yopm1TkyFfC6r6hl09NWuR69rxetVIN+JFiJ8LlB2j4wxsle8U+6aWp4/Yvn+K3A
p5VCLyBsJNI3QNfwwHjw7iza4b8LBA2OB4DuPrLmBI7XZ863yp2b+nmu3eK6n4FP
ELdblQc1IZxfIcQgZZjSZylE/J7YGBrlzrWrQMciJEc/ceOxLFCFv3LlgZjHOX3L
E2HgfexLqbKbcpK9xvrEoc5gXav7jFdgQPTz980S0flDJSMEisgLNTPf+uAsB73T
4GFPzLLfP/Vr8gTDLKCxpxK9al7EXe6sIbNtLjKMHKOMs2mKt/kgnUmaX0Fm3vaA
zZ2ciCTef7b0hCzDweL/uoXVjScbAr4LqAvfEueCTJAX25Qt9uAAoOD4ixneWwhr
VKxgn4EEAe08+x0XGW5cZTFW/3XwZprXPRC1s9F1j7LWVkjMeDUyjp0QNfCAUfW8
l+fRYnEhZXYp4OP8QALd03PBmtfI3HZU9+dBJ2jYwRwnBXUpaVfGNyj7/in8dyNg
kKWWXge0BGENpSH3MwJr
=IeBR
-----END PGP SIGNATURE-----

--JWOY2/vB4uO4FuME--

--===============2001220912209237627==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============2001220912209237627==--
