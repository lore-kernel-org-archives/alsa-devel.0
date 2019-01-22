From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH v3 07/14] ASoC: SOF: Add DSP firmware
 logger support
Date: Tue, 22 Jan 2019 18:57:11 +0000
Message-ID: <20190122185711.GI7579@sirena.org.uk>
References: <20181211212318.28644-1-pierre-louis.bossart@linux.intel.com>
 <20181211212318.28644-8-pierre-louis.bossart@linux.intel.com>
 <20190109204427.GR10405@sirena.org.uk>
 <85d2a9dc-4800-9db7-3e6a-3671f8eef226@linux.intel.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============7129152087552709105=="
Return-path: <alsa-devel-bounces@alsa-project.org>
In-Reply-To: <85d2a9dc-4800-9db7-3e6a-3671f8eef226@linux.intel.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Cc: alsa-devel@alsa-project.org, andriy.shevchenko@intel.com, tiwai@suse.de, Pan Xiuli <xiuli.pan@linux.intel.com>, Daniel Baluta <daniel.baluta@gmail.com>, liam.r.girdwood@linux.intel.com, vkoul@kernel.org, Alan Cox <alan@linux.intel.com>, sound-open-firmware@alsa-project.org
List-Id: alsa-devel@alsa-project.org


--===============7129152087552709105==
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="cfJ13FhsvNR/yOpm"
Content-Disposition: inline


--cfJ13FhsvNR/yOpm
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Jan 09, 2019 at 03:39:54PM -0600, Pierre-Louis Bossart wrote:
> On 1/9/19 2:44 PM, Mark Brown wrote:
> > On Tue, Dec 11, 2018 at 03:23:11PM -0600, Pierre-Louis Bossart wrote:

> > > +	/* make sure count is <= avail */
> > > +	count = avail > count ? count : avail;

> > min()?

> I tried to use min() but then Sparse started complaining so went back to an
> explicit test+assign.

> I don't have a strong opinion on this, but we've found so many improvements
> with the tools that I tend to favor warning-free code.

Why was sparse complaining - was it spotting something that is an actual
issue here and you've just masked the warning?

--cfJ13FhsvNR/yOpm
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlxHZ4cACgkQJNaLcl1U
h9BDfAf+NKArKIWkz9fo0+De2KFn4VvFEVsidYi93LVZkh6jx4sVMmugZ6wL1JFv
yupZMblATqWBjSQ0lpFwvHgzFzwHqF9B/AzdqpM2MsLQ+hcRmUNlA/UAADQZ//96
FhARXfNgytJgOzGy/7EXnJF3gt7tIpHwfRkN90dr4FoDtM3X1R5ZX/VKL0wqRe12
DFs5GHa1C7+fDtu/d9cmdtMupDTDnSKNlKJRdaq1DVJVwE15k6bsC8/k8UEV+gfV
8GWIjBtQAOb0WBdGCGc6T66ImICW52O6G5IFZExJbNAOB6U+pI1d4Gm5V4jgEcyE
Cm7zOuY9p3nUBVSlr6br41Qwwpx1Jg==
=b0iS
-----END PGP SIGNATURE-----

--cfJ13FhsvNR/yOpm--

--===============7129152087552709105==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============7129152087552709105==--
