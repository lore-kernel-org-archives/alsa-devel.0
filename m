From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH 07/10] ASoC: atmel: Fix unlocked
 snd_pcm_stop() call
Date: Mon, 15 Jul 2013 17:00:20 +0100
Message-ID: <20130715160020.GO11538@sirena.org.uk>
References: <1373893582-17116-1-git-send-email-tiwai@suse.de>
 <1373893582-17116-8-git-send-email-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============4721546053719360546=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
 by alsa0.perex.cz (Postfix) with ESMTP id 93075261661
 for <alsa-devel@alsa-project.org>; Mon, 15 Jul 2013 18:00:23 +0200 (CEST)
In-Reply-To: <1373893582-17116-8-git-send-email-tiwai@suse.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org


--===============4721546053719360546==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="96dIhm/ZjrNld+BP"
Content-Disposition: inline


--96dIhm/ZjrNld+BP
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Jul 15, 2013 at 03:06:19PM +0200, Takashi Iwai wrote:
> snd_pcm_stop() must be called in the PCM substream lock context.
>=20
> Cc: <stable@vger.kernel.org>
> Signed-off-by: Takashi Iwai <tiwai@suse.de>

Acked-by: Mark Brown <broonie@linaro.org>

--96dIhm/ZjrNld+BP
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.20 (GNU/Linux)

iQIcBAEBAgAGBQJR5ByRAAoJELSic+t+oim9+pMP/3vrkzEjcS25FVHg9sfGsFoY
VAhQCpTDjY3h3XgFd8ma9wbkHX5ED62GpdoWVY0TtoZhEmgDYKXHuzuq5500cPGe
buVpAc/QUcBF6yvzq57RDVyoHWcoibQ8G6yCGej0gAK5zcNFGEPXqgQtbCtxY/fJ
MqkbfmDd48zZnDCrPgHyJKWFLSswwtCIQwpChKR8CMcHfBLr0tOdppbJRamh80GC
MkkuZnTV2zSZgXTe1yUsL/jmuC4Q/E2I/ElqvlwJE3ACRWBVSRfb1i8ClAiG91Qf
vI4p08gkYgxyLQLXYZF6MqaF6uJVN2PY2m3LSoXMaAhz5gx+lNgbWlEuEL9rXJIH
f47nHdl+tfqwiShhcjLfgE78hU6qvP3GdXSPko4b2M/5j76RdnFBDg4EpWkWRspT
n8YlqJzAozmaWVumk7rv24pQ8BmtpIuttGLyUFh3EM9YW2K+60JG+/JPCgaMBF5s
91oHFI1vfhdXuHXZGdMkPhy/5sw2qIRZR10AFP87dmTgqghM6h6YIPM0kmCF0dvh
a/dM8DXSktrFOny/TH6FGn5sTG1aWzMZQeW71Bpd+AMdEi3w6CtGTpMIFvn5xAFG
eQeiUgJBwXxO0+BHqJsrvF0t3P+hktE1jGo5TpGe5UT6/6SzpgsWN2lL7UqPWggo
W3qX39jCLDe9XFxeQO4L
=fEBX
-----END PGP SIGNATURE-----

--96dIhm/ZjrNld+BP--

--===============4721546053719360546==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============4721546053719360546==--
