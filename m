From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH 2/2] ASoC: ab8500-codec: Set rx dai slots
	from rx_mask
Date: Tue, 21 May 2013 11:39:45 -0500
Message-ID: <20130521163945.GA1196@sirena.org.uk>
References: <1369130649-15179-1-git-send-email-fabio.baltieri@linaro.org>
 <1369130649-15179-3-git-send-email-fabio.baltieri@linaro.org>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============8960218115986766422=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
 by alsa0.perex.cz (Postfix) with ESMTP id 8FB77261A93
 for <alsa-devel@alsa-project.org>; Tue, 21 May 2013 19:27:02 +0200 (CEST)
In-Reply-To: <1369130649-15179-3-git-send-email-fabio.baltieri@linaro.org>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Fabio Baltieri <fabio.baltieri@linaro.org>
Cc: Ola Lilja <ola.o.lilja@stericsson.com>, alsa-devel@alsa-project.org, Linus Walleij <linus.walleij@linaro.org>, Liam Girdwood <lgirdwood@gmail.com>, linux-kernel@vger.kernel.org, Lee Jones <lee.jones@linaro.org>
List-Id: alsa-devel@alsa-project.org


--===============8960218115986766422==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="OgqxwSJOaUobr8KG"
Content-Disposition: inline


--OgqxwSJOaUobr8KG
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, May 21, 2013 at 12:04:09PM +0200, Fabio Baltieri wrote:
> Replace hard coded rx slot numbers from ab8500_codec_set_dai_tdm_slot
> using the ones requested by the machine driver in rx_mask instead.

Applied, thanks.

--OgqxwSJOaUobr8KG
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.20 (GNU/Linux)

iQIcBAEBAgAGBQJRm6NNAAoJELSic+t+oim9X78P/jq/09NFFLm/GpkDECSyymfe
bXWnrF/uHPM/V5mMh6WUVcnlXqwwR3JksbMpxdMrlmE69pQpa+v6iHVYqHacUEFZ
2l9E0Flvt6L9Fi8JTRXQctY7zB5EVJ/kp1xL2hytjreBjqwrXNPvVb0UJrT3ozek
cmeb1iGwfa94FFwEVedQYbZ4WQ1jMoktjJh2i/gExML44Jq74h5BroE7kpeufgc0
uL7BFtGyH/lnFXv+REXp/MUCZz1r4LXkmSao1mtLMh287YsSYc8x1DvDZ12+8c7/
7YYBbL6qncu9qMPFPoSMg4vD+Cw9FZ5YhD6OX9rFPuB8DjlpYUSvZ+/Ba8GlnFGx
xW72dgGoqqHY1SjEzs2LMLLRMBC15p8OU0nCOKjZwHMeJ7ugy+e9CtTLLmukrHQl
zuuhvaMwqYdWuqDUe0Bd9fGrhlsRL4RMTndJN6bGKGG8sKOwIIoUAkfZCvm6BxAm
h22k9ZJMMrFB9VAFltD6GKl2adt05yln+P2U/H69ZqVSciKhToldjTs8tExgNseT
e2p08nWyTWBSj6xBykgoFXm9kjuZbvTrTG950SZKgPV8ar6SPpy49J7zxlIhiyGU
vhElQCupTFAKB0jjtTfil/rMmwD/00fUNYwe6ZnpIdblIm4ffO8K9AWoQ+mnDky1
TMeaL4NtXMOHrJ1D1dIC
=gR24
-----END PGP SIGNATURE-----

--OgqxwSJOaUobr8KG--

--===============8960218115986766422==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============8960218115986766422==--
