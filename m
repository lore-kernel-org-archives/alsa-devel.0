From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH v3] ASoC: rt5514: add rt5514 SPI driver
Date: Fri, 13 May 2016 13:19:32 +0100
Message-ID: <20160513121932.GN22038@sirena.org.uk>
References: <1462789855-23485-1-git-send-email-oder_chiou@realtek.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============5346746792841978801=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id EF553260526
 for <alsa-devel@alsa-project.org>; Fri, 13 May 2016 14:19:50 +0200 (CEST)
In-Reply-To: <1462789855-23485-1-git-send-email-oder_chiou@realtek.com>
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
Cc: jack.yu@realtek.com, alsa-devel@alsa-project.org, lgirdwood@gmail.com, john.lin@realtek.com, bardliao@realtek.com, flove@realtek.com
List-Id: alsa-devel@alsa-project.org


--===============5346746792841978801==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="NJSRbAqOy4NeGDns"
Content-Disposition: inline


--NJSRbAqOy4NeGDns
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, May 09, 2016 at 06:30:55PM +0800, Oder Chiou wrote:

> +static void rt5514_spi_copy_work(struct work_struct *work)
> +{
> +	struct rt5514_dsp *rt5514_dsp =
> +		container_of(work, struct rt5514_dsp, copy_work.work);
> +	struct snd_pcm_runtime *runtime = rt5514_dsp->substream->runtime;
> +	size_t period_bytes, truncated_bytes = 0;

I can't see anything that cancels this work when the PCM stream to
userspace is stopped or if things power off otherwise?

--NJSRbAqOy4NeGDns
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJXNcZTAAoJECTWi3JdVIfQHwwH/1w4A2lWd50vUagr0YhgbdER
UE/7tZuyknqBDPSNtMHJRZ3beBzUIp/MSYsODgbO8ASILkk0xqsEC63uzGOWIG1u
ldIw26lCbjEmiDxCGoge1U3Ew5qM3EeSsMlnvxOZfyde1z0PGcEsys+vZZZTNu5z
i6I5BGW1rre5alWftX1vtMQRcIEggbdFYU7wdGnmr+aYYXF1kev4COYwZ8SA+VZs
HHVolGfd1IahjRX5g+K9moMPKH7cDKHfTcy6kRzuCS4kz/SY/04R5ATQucXK5PYo
mbsSByx5xYoxIWvY70uyBQ7Tc3oCUGNo+HPRoGYxymLTl+a4FOMjw+k9YyOzKsU=
=DZfK
-----END PGP SIGNATURE-----

--NJSRbAqOy4NeGDns--

--===============5346746792841978801==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============5346746792841978801==--
