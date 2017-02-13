From: Eric Anholt <eric@anholt.net>
Subject: Re: [PATCH v2] ASoC: bcm2835: Add 8 channel
	(multitrack) capability
Date: Mon, 13 Feb 2017 12:51:12 -0800
Message-ID: <87tw7xzuf3.fsf@eliezer.anholt.net>
References: <1486422576-6958-1-git-send-email-flatmax@flatmax.org>
 <1486942035-24038-1-git-send-email-flatmax@flatmax.org>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============2518597645077477034=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from anholt.net (anholt.net [50.246.234.109])
 by alsa0.perex.cz (Postfix) with ESMTP id A4279266AB2
 for <alsa-devel@alsa-project.org>; Mon, 13 Feb 2017 21:51:17 +0100 (CET)
In-Reply-To: <1486942035-24038-1-git-send-email-flatmax@flatmax.org>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org, broonie@kernel.org, florian.meier@koalo.de, linux-rpi-kernel@lists.infradead.org, linux-arm-kernel@lists.infradead.org, swarren@wwwdotorg.org, lee@kernel.org, phil@raspberrypi.org
Cc: Matt Flax <flatmax@flatmax.org>
List-Id: alsa-devel@alsa-project.org

--===============2518597645077477034==
Content-Type: multipart/signed; boundary="=-=-=";
	micalg=pgp-sha512; protocol="application/pgp-signature"

--=-=-=
Content-Type: text/plain

Matt Flax <flatmax@flatmax.org> writes:

> This patch adds multitrack capability if in DSP mode A and the
> codec is master.
>
> In bcm2835_i2s_startup, snd_pcm_hw_constraint_minmax is used to set
> max channels to 8 if both SND_SOC_DAIFMT_CBM_CFM and
> SND_SOC_DAIFMT_DSP_A are set. Otherwise, max channels is set to 2.
> Min channels is always set to 2. These settings are accomplished
> using the SNDRV_PCM_HW_PARAM_CHANNELS variable.
>
> In bcm2835_i2s_shutdown max channels is set to 2 by default.
>
> In bcm2835_i2s_hw_params, DSP mode A format is now an option.
> Before replicating the format variable (from ch2 to ch1) for
> register loading, requested channels are checked to be either 2 or 8.
> This can be expaneded later to accomodate other channel counts if

"expanded"

> supported by the sound card hardware.

This is looking a lot nicer!  I'm totally deferring to the audio guys
here for deciding if it's the right fix, but for what it's worth, from
the platform side:

Acked-by: Eric Anholt <eric@anholt.net>

--=-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEE/JuuFDWp9/ZkuCBXtdYpNtH8nugFAliiHEAACgkQtdYpNtH8
nuiIXA//dTHNdvFomRnUNlrDZVyZFO3Xnq640ihqmKV7jjzASe3NxcPNEDViL4Bp
vCdX0TZzfO4BKhnFEMiKGXbLXPXOwCLSLbW+q5vrkiaY/Nz+wXqxNyi7dWXnCeqB
8m8hHG4/HMjwkpEphozVnr/pCsviUj/AXJ0V53YzZlbzBSWlvaL6/3WBBq8nOdPc
G7sLkRB3pwPjjZmNxvQ4BU1o+e1kSccCW49xlpfmLcH9pmkXvY3uPTjZGnpVn80o
u82dOoRYRvI9UWL9cUVkaxnsdLz9rDH00pYWJiC0k4NkSDwNZz6ZbEWeZwqVvePp
/JvfKZG994+Jxw5jtAUiI+NTBeBRyT3hzbeZoLaj2QkfDstWBCgW8+TrSAvnh7bB
/cgpRMVY8JA6y5v8NYXBGKj6zTf6gmAs8/XtGCA8Ns1haKzx2h+9OSfptuxkliGl
71fH4LJvb3YjtkS+BzMQk53qJOMoPqVNds2sYutxf1AGwUre9lPC+5TX2ZW/gpAH
G2Mq5ToO5oo8swll7JBs/txxxYtto4P2HeKOHWwzmIfRH+Oz/3nT3IKUxtI3zX9s
SBAF1MqkWSQqQ+fP7JW3/7RkD/vAvPWtD04Q2BtKKrUQASNmvDYZtWGiHulxd/Af
nEWEmb6KLDGaWEY3MVIHrzYSlyVa4h3tF9yyGD97bNV7h6N/sXI=
=RL4I
-----END PGP SIGNATURE-----
--=-=-=--

--===============2518597645077477034==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============2518597645077477034==--
