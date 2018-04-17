From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH v3 08/13] ASoC: Add SoundWire stream
	programming interface
Date: Tue, 17 Apr 2018 12:11:18 +0100
Message-ID: <20180417111118.GF8973@sirena.org.uk>
References: <1523892221-16169-1-git-send-email-vinod.koul@intel.com>
 <1523892221-16169-9-git-send-email-vinod.koul@intel.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============4253169439521542758=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [172.104.155.198])
 by alsa0.perex.cz (Postfix) with ESMTP id 0E0802673E1
 for <alsa-devel@alsa-project.org>; Tue, 17 Apr 2018 13:11:28 +0200 (CEST)
In-Reply-To: <1523892221-16169-9-git-send-email-vinod.koul@intel.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Vinod Koul <vinod.koul@intel.com>
Cc: ALSA <alsa-devel@alsa-project.org>, tiwai@suse.de, Greg KH <gregkh@linuxfoundation.org>, Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>, liam.r.girdwood@linux.intel.com, patches.audio@intel.com, Shreyas NC <shreyas.nc@intel.com>
List-Id: alsa-devel@alsa-project.org


--===============4253169439521542758==
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="9ADF8FXzFeE7X4jE"
Content-Disposition: inline


--9ADF8FXzFeE7X4jE
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Apr 16, 2018 at 08:53:36PM +0530, Vinod Koul wrote:

> +/**
> + * snd_soc_dai_set_sdw_stream() - Configures a DAI for SDW stream operation
> + * @dai: DAI
> + * @stream: STREAM
> + * @direction: Stream direction(Playback/Capture)
> + * SoundWire subsystem doesn't have a notion of direction and we reuse
> + * the ASoC stream direction to configure source/sink ports.
> + *
> + * Returns 0 on success, a negative error code otherwise.
> + */
> +static inline int snd_soc_dai_set_sdw_stream(struct snd_soc_dai *dai,
> +				void *stream, int direction)
> +{

How do we clear the stream that's been set up?  I'd expect that to be a
useful thing to do from a housekeeping point of view if nothing else.

--9ADF8FXzFeE7X4jE
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlrV1lUACgkQJNaLcl1U
h9BKFAf+OzBaZ5L9Ehy+2Zc6Giz06j/cKI3OXrZVTwaHbv7cYoPZcbzThaI88CDi
rdKWuHi9gn78o3NxscUVsOLGG91prVMBSjYyezEXhvkVU5YCZHV1RyVzR+uM5+33
8UDS0hSS3ZvysLV59IbkPKYyi33TF8fxxBa/8vaH5lP1P0aEFekvLu3eFTrxIJTX
R81lcpTD+hM7cKC18grC3OT+f4475n68mhs1mGRxZaIlqRMjPqtT6s343kclheHq
hVwIEOicvg7IpxxXAfF07kndc2VXP2b1LXbH0U2zg3BEtGOS+90svAlhJTQaXaxG
2OuFbaubOwkwhE5xsjG7VGQl+xP75Q==
=tSH9
-----END PGP SIGNATURE-----

--9ADF8FXzFeE7X4jE--

--===============4253169439521542758==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============4253169439521542758==--
