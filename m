From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH v4 07/14] ASoC: SOF: Add DSP firmware
	logger support
Date: Thu, 21 Feb 2019 15:04:36 +0000
Message-ID: <20190221150436.GE5970@sirena.org.uk>
References: <20190213220734.10471-1-pierre-louis.bossart@linux.intel.com>
 <20190213220734.10471-8-pierre-louis.bossart@linux.intel.com>
 <20190220174403.GF9878@sirena.org.uk>
 <485cf6b0-e685-a376-711c-a3cd5c04833a@linux.intel.com>
 <20190221122957.GF9224@smile.fi.intel.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============7789370714320814845=="
Return-path: <alsa-devel-bounces@alsa-project.org>
In-Reply-To: <20190221122957.GF9224@smile.fi.intel.com>
List-Unsubscribe: <https://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <https://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: "Alsa-devel" <alsa-devel-bounces@alsa-project.org>
To: Andy Shevchenko <andriy.shevchenko@intel.com>
Cc: Daniel Baluta <daniel.baluta@gmail.com>, alsa-devel@alsa-project.org, tiwai@suse.de, Pan Xiuli <xiuli.pan@linux.intel.com>, Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>, liam.r.girdwood@linux.intel.com, vkoul@kernel.org, Alan Cox <alan@linux.intel.com>, sound-open-firmware@alsa-project.org
List-Id: alsa-devel@alsa-project.org


--===============7789370714320814845==
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="+SfteS7bOf3dGlBC"
Content-Disposition: inline


--+SfteS7bOf3dGlBC
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Feb 21, 2019 at 02:29:57PM +0200, Andy Shevchenko wrote:
> On Wed, Feb 20, 2019 at 02:18:01PM -0600, Pierre-Louis Bossart wrote:

> > as discussed in the last review, we didn't use min() since it adds a number
> > of obscure warnings with sparse. I haven't found any time to look into this
> > so for now left the code as is. Sparse is a useful tool for the address
> > checks (topology/DMAs with _le32, __iomem, etc), the fewer warnings we get
> > the better.

> Shouldn't be sparse itself get fixed?

Ideally.  We had this discussion last time :/

--+SfteS7bOf3dGlBC
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlxuvgMACgkQJNaLcl1U
h9AAWwf7BNpLx73q19d52GWBnYXJTR77TxEwafFwih0SBqXHNH9/cM8Syndy3DEb
M+N2UYKOy5ulZ1yQiAvSD3gfKnePYIIk6IBnQu4TvY9uB+X7KNGPtPyi6RcLFpI/
HsNJz6ZSBUftW1zhdwNuMN5FUZTdTJeNO3JXo4Ssvye0V3ieo/5Hn0Y8552GNKRg
Cqyrkl8jz1Ei2q1L5zthuuVKF6vglne/fyYbc3U7kWc6/gd6CFruHYg4dKxN2asm
8fTbqL8kYNf8COgqO+YWt9nxWxL0qlR52djcrQJ2ml4OqdnrrWCkox/dM/HQLy/f
W7XD+saiiIRCtYJjgFPNkHkPaWhg9A==
=5nTb
-----END PGP SIGNATURE-----

--+SfteS7bOf3dGlBC--

--===============7789370714320814845==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============7789370714320814845==--
