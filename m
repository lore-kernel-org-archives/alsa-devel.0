From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: soc-dsp programming model for loopbacks
Date: Thu, 26 Jan 2012 14:03:10 +0000
Message-ID: <20120126140310.GA28994@opensource.wolfsonmicro.com>
References: <4f1f2489.c602440a.208e.ffff9d7bSMTPIN_ADDED@mx.google.com>
	<1327511249.11901.37.camel@odin>
	<20120125171112.GR3687@opensource.wolfsonmicro.com>
	<002d01ccdb9c$7099f1e0$51cdd5a0$@bossart@linux.intel.com>
	<20120125201438.GA17032@opensource.wolfsonmicro.com>
	<4F215127.8050509@linux.intel.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============7218796561309253093=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id BDCC7103838
	for <alsa-devel@alsa-project.org>; Thu, 26 Jan 2012 15:03:12 +0100 (CET)
In-Reply-To: <4F215127.8050509@linux.intel.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Cc: alsa-devel@alsa-project.org, 'Liam Girdwood' <lrg@ti.com>
List-Id: alsa-devel@alsa-project.org


--===============7218796561309253093==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="SLDf9lqlvOQaIe6s"
Content-Disposition: inline


--SLDf9lqlvOQaIe6s
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Jan 26, 2012 at 07:12:07AM -0600, Pierre-Louis Bossart wrote:

> Bear with me here, I am still somewhat confused.
> - Liam suggested either a hard-coded DAI configuration or machine
> driver logic to remove the need for virtual front-ends
> - Mark suggested to consider the DSP as a CODEC with some work to
> re-implement the host-dsp interface.
> Is this CODEC<->CODEC solution on top of the Dynamic PCM patches? Or
> are we talking about two completely different approaches?

The two are orthogonal to each other but complimenary.  Like I say it
really depends on how your hardware is wired up - it depends on the
level of isolation that the DSP provides between the CPU and the outside
world.

If the system looks like:

    CPU <-> DSP <-> External

you should model the DSP as a separate device.  If on the other hand it
looks more like this:


   DSP     External
    ^----v----^
        CPU

then soc-pcm is what you're looking for.

--SLDf9lqlvOQaIe6s
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iQIcBAEBAgAGBQJPIV0WAAoJEBus8iNuMP3dGlMP/37vjX9qdZDPuUrQoHSG3l52
X85xxqoaKdecrygLgi22A1LV5W1PH253huX/NnYMZlx9Se0APKxSE1Y/Q2cTfhSa
bzKVHesImfZvsFoCXZOsvWp0sJrJnKODeX4rgCK+UR5tvjGblFXslknKikXF6vnW
8Adh4iFdnUR5gg7lRTfMbDFtLBEv6VrB6sONAS7Bimw6qBFtSMsTc1WezPN8KtJi
SQNvfbKsUcN55h8amN4H3W5CupwDBbOmehU5jVXKq9DU30V20HPeJTcj+7Ouad8h
DV7ebXSHDrAPgMr9Tw3ULgNFpP7cCODeLqFr5SusFtoTDvq5N+JkIyO14exDKokh
qwP2zM9l8SYcScahaN17kXsvKgR/LCG6atdWulDpaAOEWMSplHoFWjNclGkGxDCz
Ka5EUZrIc+SROIRMrXiOqH/4XPiZ9uTqKngjlG6W94hq6bPT73ogLhSPrWY+lNk2
/au5vnH7ZlaTmWnkV8Xnu90kQ27rnPpPe99Qg11N6D8CP7NsWYb9CpiGLNBRflRj
06YCA1zqqh02HLSTH7CdxNY2vjuwTaCXfYaZDM0xHBUDhMwkXyTEjDj7Quli36LY
KTiyFSF8DgLhOXF+YFx6ALXHsLNVjkK7mZz/zUqFyDeD8K9gcXzxlg3uUw/3z0xS
UV7OuHNz7YSYQeKMsCXn
=VYoT
-----END PGP SIGNATURE-----

--SLDf9lqlvOQaIe6s--

--===============7218796561309253093==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============7218796561309253093==--
