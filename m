From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH] ASoC: Intel: bytcr_rt5640: fallback
 mechanism if MCLK is not enabled
Date: Thu, 15 Dec 2016 10:46:52 +0000
Message-ID: <20161215104652.qtnp7ghhrbfn6lmu@sirena.org.uk>
References: <1481654490-31846-1-git-send-email-pierre-louis.bossart@linux.intel.com>
 <20161214131948.e3gqnbauv7762jrf@sirena.org.uk>
 <a565e81d-1488-df9f-5999-283c6d5d9789@linux.intel.com>
 <s5h60mly6xt.wl-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============4528628321520853186=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 2E03C266832
 for <alsa-devel@alsa-project.org>; Thu, 15 Dec 2016 11:47:01 +0100 (CET)
In-Reply-To: <s5h60mly6xt.wl-tiwai@suse.de>
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
Cc: alsa-devel@alsa-project.org, Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
List-Id: alsa-devel@alsa-project.org


--===============4528628321520853186==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="cdyev7akkicmuqbu"
Content-Disposition: inline


--cdyev7akkicmuqbu
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Dec 15, 2016 at 08:42:22AM +0100, Takashi Iwai wrote:
> Pierre-Louis Bossart wrote:

> > >>  			dev_err(&pdev->dev,
> > >>  				"Failed to get MCLK from pmc_plt_clk_3: %ld\n",
> > >>  				PTR_ERR(priv->mclk));
> > >> -			return PTR_ERR(priv->mclk);
> > >> +
> > >> +			/* Fall back to bitclock only */
> > >> +			byt_rt5640_quirk &= ~BYT_RT5640_MCLK_EN;

> > > This is broken for probe deferral, I'd expect this to be explicitly
> > > checking for a no clock mapped error code (probably -ENOENT) rather than
> > > just ignoring all errors.

> > I don't understand the probe deferral concept here. Are you saying
> > fall back to the bit clock mode if the status is -ENOENT and fail
> > otherwise?

> The clk driver may return -EPROBE_DEFER, and in that case, the intel
> driver should also defer the probe as well.  Or, like -ENOMEM, it
> indicates a serious error, and then better bail out.

> So, we need to figure out which error code should fall back to the
> legacy mode.  (Or vice versa, which error code shouldn't be ignored.)

Exactly.  -ENOENT is what other subsystems return, I've not specifically
checked the clock API.

--cdyev7akkicmuqbu
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCAAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlhSdJsACgkQJNaLcl1U
h9AAxAf/eXuE0Pl9wcOK1Hnbxhlf6n7Mm7GF/BOuXUnOBym/MQDOMvF5RjmDBuO2
/kD8LR4M5Dri20WhBo1s+pGBALLjpKnMFMRtoyWV9Eed2R3O4xtlzP/745+zBMlX
lRAceQ5lbiuXTdLzQ3Zqu7I0v08hd0xV8cjU7gV+GwcINr7YcT+/UO1V/o57CXoA
kUEfjWzmRjt1uwLB9gMGU/TTYj3KpaYfeN5AuQ/DchXYa4y5ohPkztXkFE+f1TdM
fQ3SuGsrbr+F5w5QYIRhe1iCg7RYXcBfxJz1vPmzb2yo46UyQY0/JyjmGoHRD6zA
eOR9uxvabXr2B+vfo1D2XxIEnQR4xA==
=Kdkp
-----END PGP SIGNATURE-----

--cdyev7akkicmuqbu--

--===============4528628321520853186==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============4528628321520853186==--
