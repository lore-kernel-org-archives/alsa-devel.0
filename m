From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH] ASoC: rt5663: Add the function of
	impedance sensing
Date: Wed, 13 Sep 2017 09:45:50 -0700
Message-ID: <20170913164550.4xknya7m6tlkcidk@sirena.org.uk>
References: <1505112768-27727-1-git-send-email-oder_chiou@realtek.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0759504314062249059=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [172.104.155.198])
 by alsa0.perex.cz (Postfix) with ESMTP id 1DE22266986
 for <alsa-devel@alsa-project.org>; Wed, 13 Sep 2017 19:07:20 +0200 (CEST)
In-Reply-To: <1505112768-27727-1-git-send-email-oder_chiou@realtek.com>
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
Cc: jack.yu@realtek.com, alsa-devel@alsa-project.org, hychao@google.com, lgirdwood@gmail.com, shumingf@realtek.com, bardliao@realtek.com, flove@realtek.com
List-Id: alsa-devel@alsa-project.org


--===============0759504314062249059==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="exfqevgbwfp23t6u"
Content-Disposition: inline


--exfqevgbwfp23t6u
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Sep 11, 2017 at 02:52:48PM +0800, Oder Chiou wrote:

> +- "realtek,impedance_sensing_num"
> +  The range number of impedance sensing.
> +- "realtek,impedance_sensing_table"
> +  The parameters table of impedance sensing.

I really can't tell what format these are supposed to be in from this
documentation.  If the realtek,impedance_sensing_num is some number
defined in the datasheet it's OK to just reference the datasheet, for
the table you probably need a bit of detail on the format of the table
and it's contents.

--exfqevgbwfp23t6u
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCAAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlm5YL0ACgkQJNaLcl1U
h9CDSQf/Up2Qccmjf3gX088wdl6cxfhRr2CyKysx44PVwiqpi6WQyeG4lj/zwSeu
JJKn9dlDE4yVI0X+DYjQY5kjwSHg7wXiFauUv/CBmJvg7o4M3zSP4cSB6EAp29Dc
/VAyBzRPV9PyY9RhjsnmTBKGXboOoHxccZOHp9mN5sGeBy5/vipqjospDtmctjeZ
/SqJmGBOsnPBi0RDxy5qoTxGEmJ8fYFz9N4AaoWLGAbRU+xuQZ3w0nB8RfBzIC2c
mZAShkI7JGEZYWlT9GHNevxF4ICI1KLamQcwrdrhl4+HP6Y4NtbSA8j+fXDYhKan
aQX4SItO60GI2a5yRM4lDPi6XJTMuQ==
=cCfL
-----END PGP SIGNATURE-----

--exfqevgbwfp23t6u--

--===============0759504314062249059==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============0759504314062249059==--
