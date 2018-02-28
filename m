From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH,
 alsa-lib] ASoC: topology: Fix bclk and fsync inversion in
 set_link_hw_format()
Date: Wed, 28 Feb 2018 15:24:03 +0000
Message-ID: <20180228152403.GB6722@sirena.org.uk>
References: <20180227203317.17274-2-k.marinushkin@gmail.com>
 <20180227203541.17343-1-k.marinushkin@gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============8389097888023342740=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [172.104.155.198])
 by alsa0.perex.cz (Postfix) with ESMTP id 31C47267784
 for <alsa-devel@alsa-project.org>; Wed, 28 Feb 2018 16:24:06 +0100 (CET)
In-Reply-To: <20180227203541.17343-1-k.marinushkin@gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Kirill Marinushkin <k.marinushkin@gmail.com>
Cc: Liam Girdwood <liam.r.girdwood@linux.intel.com>, alsa-devel@alsa-project.org, Pan Xiuli <xiuli.pan@linux.intel.com>, Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
List-Id: alsa-devel@alsa-project.org


--===============8389097888023342740==
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="neYutvxvOLaeuPCA"
Content-Disposition: inline


--neYutvxvOLaeuPCA
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Feb 27, 2018 at 09:35:41PM +0100, Kirill Marinushkin wrote:
> The values of bclk and fsync are inverted WRT the codec. But the existing
> solution already works for Broadwell, see the alsa-lib config:

You should include Jaroslav and Takashi when sending alsa-lib patches.

> +			/* For backwards capability,
> +			 * "master" == "codec is slave"
> +			 */
> +			if (!strcmp(val, "master") ||
> +			    !strcmp(val, "codec_slave"))
> +				hw_cfg->fsync_master = SND_SOC_TPLG_FSYNC_CS;
> +			else if (!strcmp(val, "codec_master"))
> +				hw_cfg->fsync_master = SND_SOC_TPLG_FSYNC_CM;

Should we warn on use of "master" since it's being deprecated here (and
might be confusing for users)?

--neYutvxvOLaeuPCA
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlqWyZIACgkQJNaLcl1U
h9CaGwf/XDGBTqfhYlDiFS8lmLVXeSQJO49DFCQpUp9CjecIU8MrC1KMIZPGE43+
7YaSxQMmko/+C95O7cMmNQ05QSpxFk2539FTW8MUGLCadlfGEjsY19Y5vGN5ZCbj
fg708xA/6WpchdEgo/ixM4vT3hB2l70bPrhXzUmgN0ZYsRrFG9zo7ppItG/AvRos
Vg80R4ROOUqXX4HoBofxiJ+Cq6aGOtpCfuPX74DNGLDVWd9dhqP5j4bcBTD1s5q8
KCErkK2jBbOgZE+Yv6t2oSldQ/OuH4+kkzIz0WLywL3yqwp0i8l+OrQF4m2KhQsg
pJ14juRkQfw1Lv7gkQNPZM74W9mYSA==
=IJUy
-----END PGP SIGNATURE-----

--neYutvxvOLaeuPCA--

--===============8389097888023342740==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============8389097888023342740==--
