From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH] ASoC: rt5514: Move the auto disable DSP
 function to set_bias_level()
Date: Fri, 7 Jul 2017 13:45:58 +0100
Message-ID: <20170707124558.gtktlctnsl43z3ni@sirena.org.uk>
References: <1499166534-16438-1-git-send-email-oder_chiou@realtek.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============7745795810400452536=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 0C1312671C0
 for <alsa-devel@alsa-project.org>; Fri,  7 Jul 2017 14:46:05 +0200 (CEST)
In-Reply-To: <1499166534-16438-1-git-send-email-oder_chiou@realtek.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Oder Chiou <oder_chiou@realtek.com>
Cc: jack.yu@realtek.com, alsa-devel@alsa-project.org, hychao@google.com, lgirdwood@gmail.com, albertchen@realtek.com, shumingf@realtek.com, bardliao@realtek.com, flove@realtek.com
List-Id: alsa-devel@alsa-project.org


--===============7745795810400452536==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="ilt6dse2scyditym"
Content-Disposition: inline


--ilt6dse2scyditym
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Jul 04, 2017 at 07:08:54PM +0800, Oder Chiou wrote:
> Move the auto disable DSP function from the widget event "DAPM Pre" to
> the set_bias_level() function to avoid the unexpected behavior.

Could you provide a bit more information on what the unexpected
behaviour is and why this is a good fix please?

--ilt6dse2scyditym
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCAAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAllfgoUACgkQJNaLcl1U
h9CI3Qf+NH/w5XZE7TR5C8P6dNkznzfqU8K8F43gGfVwcG2xds4Lv/Khc/l/9YUB
1872xsdUsE1pYU1O95E4GJ9v2F+jnO6sYsLaChoB3ALkpsT7nHCmRUO+3VknHOfK
1eSWCpNQ6kctmJB1vrMeXttRr0KOItRZI466GPI+VDuQp96EOKCFk/BASoKggfTN
+ZxgfEkVBJB62Md0Jq8aTnOT+Tn3qwfEfLAsCybiZo3GrFXmySJet+8ZYU7iElrJ
2IUHmCdNO7reGHAQO3Tz/bG7AUffvXXTMBvvMxxh6ZNpMgUW7Gze8KfpXyY+O0cL
6goxz0SaPhtfBL5wtjUzMkiZXOHRNw==
=gvWm
-----END PGP SIGNATURE-----

--ilt6dse2scyditym--

--===============7745795810400452536==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============7745795810400452536==--
