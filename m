From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH v2 09/11] ASoC: sh: Don't set unused struct
 snd_pcm_hardware fields
Date: Thu, 9 Jan 2014 14:30:00 +0000
Message-ID: <20140109143000.GA31886@sirena.org.uk>
References: <1389014356-7014-1-git-send-email-lars@metafoo.de>
 <1389014356-7014-9-git-send-email-lars@metafoo.de>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============2146906273055407642=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 94C21261AEC
 for <alsa-devel@alsa-project.org>; Thu,  9 Jan 2014 15:30:07 +0100 (CET)
In-Reply-To: <1389014356-7014-9-git-send-email-lars@metafoo.de>
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
Cc: alsa-devel@alsa-project.org, Liam Girdwood <lgirdwood@gmail.com>, Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
List-Id: alsa-devel@alsa-project.org


--===============2146906273055407642==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="MZonI8ZGRtxCOYmo"
Content-Disposition: inline


--MZonI8ZGRtxCOYmo
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Jan 06, 2014 at 02:19:14PM +0100, Lars-Peter Clausen wrote:
> The ASoC core assumes that the PCM component of the ASoC card transparently
> moves data around and does not impose any restrictions on the memory layout or
> the transfer speed. It ignores all fields from the snd_pcm_hardware struct for
> the PCM driver that are related to this. Setting these fields in the PCM driver
> might suggest otherwise though, so rather not set them.

Applied, thanks.

--MZonI8ZGRtxCOYmo
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJSzrJlAAoJELSic+t+oim9viIP/AxmUgLYl3fog4m1mpFXZLrm
2kr+gG8y5YkyKAiQ/fsxHjKR9n3o01eMupEMdhExc4kekIS8Hg6Nw2iQ33OiyBS+
bZ8/h5kael0ISl9H69JG7OIfMQhVGN65iOyMZ+QS2RQ9wGCeb3sQxdKwPtf5G2pJ
1n5CWlPxCk8Jo2TpaIe8iAnBlu+otVzca/9Y8Jnk0y9If9bSkogt8sf0wkEpbM7c
NODmJYlQK5usyrfwFYHx8LugbvBSODXd3k0Rdchy1JpGjphZnT4A6XkoPR+Wv7RF
2i82zfyG7p77OHkuWp4/Ft82m9hM1wgWUhuHpaYdy3PNKdQvv1DuTHJhSfuFgRWY
r4WxoaAiSzbpdxDbGEMsHvTfVezxgEhyeTxyXyZTBV/6Bh+xMddSwM2PgYwmMPxn
llPc1wgRv6DmYOBpOcPiJOLJO3RqWbJ96CsttTPp4Ej90ZCmpfGXQovxFHd5RL/D
/o9YjIBQFIedd3WiXkLc2QGJHfC5qJY8AmowR2GIsL4wAQGTL1HDpvRTw0ZkaaMI
NYgYuMG2HOn8C1I3DfkEsJ3oX/S5ewM76EzYGiqgMTsFLEo/dd7jbu2l1J/Vg09w
NTgV/rLvYhXIadPAp1vfzqmjABJi97ZUPa62X4O39pBFKpm+CuRCwsK8DDR9zHy6
lPYir1TiLkU7+9NZouyV
=WGVM
-----END PGP SIGNATURE-----

--MZonI8ZGRtxCOYmo--

--===============2146906273055407642==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============2146906273055407642==--
