From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH] ASoC: core: Invoke pcm_new() for all
 DAI-link
Date: Wed, 7 Nov 2018 16:14:37 +0000
Message-ID: <20181107161437.GC6809@sirena.org.uk>
References: <1541075929-29323-1-git-send-email-rohitkr@codeaurora.org>
 <s5htvl0exil.wl-tiwai@suse.de>
 <48c78f67-8178-2d07-e35d-2e4eca51ccbc@codeaurora.org>
 <791d4587-4db3-3ffa-331a-f79d0993ca8c@st.com>
 <3616f01f-6a00-6eb1-0bdd-f161b7ce15e6@codeaurora.org>
 <4f22e4e5-84f0-1560-1ba7-5e77d44fd312@st.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============6850536743011095917=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [172.104.155.198])
 by alsa0.perex.cz (Postfix) with ESMTP id 82E3A267839
 for <alsa-devel@alsa-project.org>; Wed,  7 Nov 2018 17:14:44 +0100 (CET)
In-Reply-To: <4f22e4e5-84f0-1560-1ba7-5e77d44fd312@st.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Arnaud Pouliquen <arnaud.pouliquen@st.com>
Cc: rohkumar@qti.qualcomm.com, alsa-devel@alsa-project.org, bgoswami@codeaurora.org, olivier.moysan@st.com, Takashi Iwai <tiwai@suse.de>, plai@codeaurora.org, tiwai@suse.com, lgirdwood@gmail.com, linux-kernel@vger.kernel.org, Rohit Kumar <rohitkr@codeaurora.org>, srinivas.kandagatla@linaro.org
List-Id: alsa-devel@alsa-project.org


--===============6850536743011095917==
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="hOcCNbCCxyk/YU74"
Content-Disposition: inline


--hOcCNbCCxyk/YU74
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Nov 06, 2018 at 04:41:23PM +0100, Arnaud Pouliquen wrote:

> I would say force device to 0 if no_pcm (need probably to create the
> control in hdmi_of_xlate_dai_id instead of hdmi_codec_pcm_new).
> But keep in mind that solution has to work in case of multi HDMI codec
> instances, perhaps using prefix...
> Anyway, i'm not a DPCM expert so perhaps more elegant solutions exist.

Liam, any thoughts on how to handle this?  I've still not really worked
with DPCM systems!

--hOcCNbCCxyk/YU74
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlvjD20ACgkQJNaLcl1U
h9A8Dgf/UWITAfBn1fgkapuJtrcu/6lI5ZQuwpTlRaME25VLqX7uo5ph0ZW5U9VU
xm4bALOyi2F4zxT4uEaFDYN9AVVDYjAC19yD10ZEKVmb940q1XSL1g5elBySoLGB
qDjQGVDMa8fOuObXJ5198IbnthqOj/PcazG7zywWSWu8T9g4r9W6FQYjhaLbbQiP
NhTI75xlFgsDlpD+0APD73Cy69wRiunMrINfXJ3AYf02mG8JJCn+dsm9mExV+tPr
kwpCjCoMwNDxbE3GF5qBt90INMFOQ7O33a6hURWULb9AE2FW2Z7KDIp7+mmrBcFt
FW3ulHM249aDqVgWh6KFqwgV0iRj7A==
=RPSz
-----END PGP SIGNATURE-----

--hOcCNbCCxyk/YU74--

--===============6850536743011095917==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============6850536743011095917==--
