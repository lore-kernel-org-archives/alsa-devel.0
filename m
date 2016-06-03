From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH v3] ASoC: rt5514: add rt5514 SPI driver
Date: Fri, 3 Jun 2016 12:01:05 +0100
Message-ID: <20160603110105.GA2282@sirena.org.uk>
References: <1462789855-23485-1-git-send-email-oder_chiou@realtek.com>
 <20160513121932.GN22038@sirena.org.uk>
 <7EB0DE829A537248AF2ED30C97D12694FDDF5C@RTITMBSV03.realtek.com.tw>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============2516003980977649656=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 1D96C26523B
 for <alsa-devel@alsa-project.org>; Fri,  3 Jun 2016 13:01:17 +0200 (CEST)
In-Reply-To: <7EB0DE829A537248AF2ED30C97D12694FDDF5C@RTITMBSV03.realtek.com.tw>
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
Cc: Jack Yu <jack.yu@realtek.com>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, "lgirdwood@gmail.com" <lgirdwood@gmail.com>, John Lin <john.lin@realtek.com>, Bard Liao <bardliao@realtek.com>, Flove <flove@realtek.com>
List-Id: alsa-devel@alsa-project.org


--===============2516003980977649656==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="NgLNC/STdjXvE6Rt"
Content-Disposition: inline


--NgLNC/STdjXvE6Rt
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, May 17, 2016 at 02:33:16AM +0000, Oder Chiou wrote:
> > > +static void rt5514_spi_copy_work(struct work_struct *work)
> > > +{
> > > +	struct rt5514_dsp *rt5514_dsp =
> > > +		container_of(work, struct rt5514_dsp, copy_work.work);
> > > +	struct snd_pcm_runtime *runtime = rt5514_dsp->substream->runtime;
> > > +	size_t period_bytes, truncated_bytes = 0;

> > I can't see anything that cancels this work when the PCM stream to
> > userspace is stopped or if things power off otherwise?

> In the beginning of the function "rt5514_spi_copy_work", there is a if
> condition to check the variable "rt5514_dsp->substream", and the function
> "rt5514_spi_hw_free" will set the variable "rt5514_dsp->substream" to NULL.
> It also will make the delayed work stop and won't schedule again.

No, that won't stop the currently running work which means that on
driver removal we could for example try to free the driver data while
the work is still running.  The driver needs to explicitly ensure that
there is no work running when it shouldn't be, not just stop any new
work being added.

--NgLNC/STdjXvE6Rt
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJXUWNwAAoJECTWi3JdVIfQwYkH/2Ss1h+zykoiLSUYW1V/TIxt
E7aDsS1ytJDueDTj3NJaRfNatD3lPqu6Rr1t8u5kA/R83wdxA26KkPf55DFMLnRB
Gcj5zZLIDWiiQh8BkbsmMOgYwXLefVIskt4uaFtqIYa3opodKI3c/g8KaeePGvrm
WwPQL4eizq9kSUDKPbEs7WuBfPav7VdGqp+hi7bsinTnpS3qoQ1vGqH05Fzy/sDb
+nqbKIgAV6sp9CFWrxTcHPnw/Yup/y6YBjH9bd9oSbrRYEEo6buj+GsucJhbUoQ5
7uRlhmf/AQdzhifl/EUskuI64WT0NImxGodSMPTPelXVPP5DkmbGVzA4RfPildU=
=kxYg
-----END PGP SIGNATURE-----

--NgLNC/STdjXvE6Rt--

--===============2516003980977649656==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============2516003980977649656==--
