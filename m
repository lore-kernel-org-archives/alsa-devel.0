From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH 08/10] ASoC: s6000: Fix unlocked
 snd_pcm_stop() call
Date: Mon, 15 Jul 2013 17:00:35 +0100
Message-ID: <20130715160035.GP11538@sirena.org.uk>
References: <1373893582-17116-1-git-send-email-tiwai@suse.de>
 <1373893582-17116-9-git-send-email-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============2113343805773135321=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
 by alsa0.perex.cz (Postfix) with ESMTP id 6E7892618ED
 for <alsa-devel@alsa-project.org>; Mon, 15 Jul 2013 18:00:38 +0200 (CEST)
In-Reply-To: <1373893582-17116-9-git-send-email-tiwai@suse.de>
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


--===============2113343805773135321==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="8G1nIWD3RY794FAy"
Content-Disposition: inline


--8G1nIWD3RY794FAy
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Jul 15, 2013 at 03:06:20PM +0200, Takashi Iwai wrote:
> snd_pcm_stop() must be called in the PCM substream lock context.
>=20
> Cc: <stable@vger.kernel.org>
> Signed-off-by: Takashi Iwai <tiwai@suse.de>

Acked-by: Mark Brown <broonie@linaro.org>

--8G1nIWD3RY794FAy
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.20 (GNU/Linux)

iQIcBAEBAgAGBQJR5BygAAoJELSic+t+oim9oVcP/j0oO+H97c8IlN/k43jY7Hho
iCdzl+BQ8KIF3/EQwzABsAnrRb6qm9Y22uEN1uUU5UqHrO2jgMqi07pEcl9plmK1
uqdb1RYwKM5SlaN9E/cBsFbjlgTBJFMBRXpxMdghrCm+SQh4Ycob+mubWlihj0EO
aQnezPeRv7HzXFOCSqk6agb0mBUQQm2EueQHz42DvQZ6gmjyu7OL1SJzpXufDqzL
BzdQfPymF7WDPl5zY60GjeGpTIkV1VrGI3HmhcH37LDXMi2avNGJ473uGnmqDHTa
jYKbMQN44PShmUYNQv9a9PwbV2zLw04jBJfy/Z5UnDP4yOYIsZy5syQZZop/npD4
zmoneqGMRhBWVgxYyY9b9URKSAGJEYTiSPOccJMfw1+QONrxqWiWm5X8ZOBqg4sZ
A2C6K/oWOY70/lvDlg4h0b+f8yMSKoumT1l/P5v6sEYRQ5Qma6wzJA4dvltUrMAJ
zwaaUruN8r08lgbqQSguoumih4EN9P4gWU2IUIZte21saS94If83ztxOnreCl1cD
1nt3tWu59ZnaH4DMNt8yJwj4U4/qmUI+JPnQJir7pzZzlF1DQ4dKc8NPwKutqxww
EoDV7u/Tg/OJrZgQQqxhD1Jm3gTVKTpCQgq9rw7Tj4U//x8xCqq7Nr+XdIjiDxpz
ByZS7w4cb/B5QW+4Ldbb
=We9c
-----END PGP SIGNATURE-----

--8G1nIWD3RY794FAy--

--===============2113343805773135321==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============2113343805773135321==--
