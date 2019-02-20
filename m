From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH v4 07/14] ASoC: SOF: Add DSP firmware
	logger support
Date: Wed, 20 Feb 2019 17:44:03 +0000
Message-ID: <20190220174403.GF9878@sirena.org.uk>
References: <20190213220734.10471-1-pierre-louis.bossart@linux.intel.com>
 <20190213220734.10471-8-pierre-louis.bossart@linux.intel.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1100498128781678181=="
Return-path: <alsa-devel-bounces@alsa-project.org>
In-Reply-To: <20190213220734.10471-8-pierre-louis.bossart@linux.intel.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: "Alsa-devel" <alsa-devel-bounces@alsa-project.org>
To: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Cc: alsa-devel@alsa-project.org, andriy.shevchenko@intel.com, tiwai@suse.de, Pan Xiuli <xiuli.pan@linux.intel.com>, Daniel Baluta <daniel.baluta@gmail.com>, liam.r.girdwood@linux.intel.com, vkoul@kernel.org, Alan Cox <alan@linux.intel.com>, sound-open-firmware@alsa-project.org
List-Id: alsa-devel@alsa-project.org


--===============1100498128781678181==
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="O98KdSgI27dgYlM5"
Content-Disposition: inline


--O98KdSgI27dgYlM5
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Feb 13, 2019 at 04:07:27PM -0600, Pierre-Louis Bossart wrote:

> +	/* make sure count is <= avail */
> +	count = avail > count ? count : avail;

count = min(avail, count)?

--O98KdSgI27dgYlM5
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlxtkeIACgkQJNaLcl1U
h9AitAf+LlkMbcXTYJU5PsOrDaIQ0RVFuOVOgnSZlWG9f3Q85EHVSDCx0R5h/KXU
V5T0F/lF7Pfdzq/VNQVzbGSv/yPN8gqMcnCIetvd9m08Z8g2nmwx4f2gHGowDh5e
77Pc53bFq2uGgZ2KSmQp8bmPiSDBM006M8HIAyMotiWEwKHWjwn7DoHXgjauhxU1
CMrjoiALj/g/wQee/CcvWRI9XE4vnhv9XwdXD6TPna1z4yB0sCeKkRq/pe9H14LW
kvRJqkbLgLXmxX+PcVPh4qIWhiKzhumWOmuVU7FTbZAfgD1K/zk04HT+T+g2a3AO
t8Grqeq+vMGYBnjbrVrUsiVk74I8nQ==
=qnoE
-----END PGP SIGNATURE-----

--O98KdSgI27dgYlM5--

--===============1100498128781678181==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============1100498128781678181==--
