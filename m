From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH 2/2] ASoC: pcm: Always honor DAI min and
 max sample rate constraints
Date: Wed, 27 Nov 2013 16:43:28 +0000
Message-ID: <20131127164328.GJ14725@sirena.org.uk>
References: <1385542698-13362-1-git-send-email-lars@metafoo.de>
 <1385542698-13362-2-git-send-email-lars@metafoo.de>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============2843304581227771130=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
 by alsa0.perex.cz (Postfix) with ESMTP id 27AD6264F23
 for <alsa-devel@alsa-project.org>; Wed, 27 Nov 2013 17:43:31 +0100 (CET)
In-Reply-To: <1385542698-13362-2-git-send-email-lars@metafoo.de>
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
Cc: Takashi Iwai <tiwai@suse.de>, Jean-Francois Moine <moinejf@free.fr>, alsa-devel@alsa-project.org, Liam Girdwood <lgirdwood@gmail.com>
List-Id: alsa-devel@alsa-project.org


--===============2843304581227771130==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="CGHixilj3wKyHuKx"
Content-Disposition: inline


--CGHixilj3wKyHuKx
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Nov 27, 2013 at 09:58:18AM +0100, Lars-Peter Clausen wrote:
> snd_pcm_limit_hw_rates() will initialize the minimum and maximum sample rate for
> the PCM stream based on the rates specified in the rates field. Since we call
> snd_pcm_limit_hw_rates() after soc_pcm_init_runtime_hw() it will essentially

Applied, thanks.

--CGHixilj3wKyHuKx
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJSliEtAAoJELSic+t+oim9XjIP/ih/zkqED1Id6G2PhpaFN2l5
48dlZ2KAVsBc+GaXT2NF5PRz36w/OpLAkJ3Zq7/lW+kEF4zQXMpQE8Vs05V5nPPo
zd956A5OWbj2aPw6b7O/CXuDlMe/BHrpEihoIX6BczRYMivxRHsdUt0IS0kM7IH4
gibnL3Gz3AEHE2+Fd8+C/SRyUpJLFPHcuFPEnzRzOtQhScwLaf0NhyxF85cX8ozK
jFGKafE5s0ZngT29SPNkWIvVixl2xuOe0VTPNv3NTtangA+JLja0Llagn7wPwd1J
eUMCMnQXf+fyfu5K5EoKdZ+zaG8v0cIFKbo7rIWYmTJ7Kcti9mdwsUoKed9XjNRN
nSUi64ON6cTBFQmcIDqtFuiovv+3i5t/xxcPCRaMshu1BhsaoZqC3vgm5ybc+Qa4
oAQlJjLRN1YDWhI7ZTKgWZcjP/lCwyTf2IVUwCiHIa0K3mBpmNQ68F902eS620+N
Ox66sY5ZfXLYsMGkdaUtI1xxFO/6rCfO6tbgKDg8FK56XTgYB0unDHj5oxlzD4K3
mD7FPIMfyG3l2X8eGydt3xyNxutSBWdGfuGiBB1oOmRKnAOwjv+10CC5wNtk4cXf
1uBEaapPEa8tm/TpSKTc1ks6Gdk2Wh9c9N+IZK/j7JBuAweVuTNz2b6G4iAJW8FD
yc6KnVdIwvvqkplkQDVl
=HzaU
-----END PGP SIGNATURE-----

--CGHixilj3wKyHuKx--

--===============2843304581227771130==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============2843304581227771130==--
