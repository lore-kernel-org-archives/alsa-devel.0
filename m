From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH 1/2] ASoC: Add support for Conexant CX2072X
	CODEC
Date: Wed, 8 May 2019 19:10:29 +0900
Message-ID: <20190508101029.GM14916@sirena.org.uk>
References: <20190503064729.GF14916@sirena.org.uk>
 <s5hk1f8m2f1.wl-tiwai@suse.de>
 <20190506042625.GK14916@sirena.org.uk>
 <s5hsgtr6h5y.wl-tiwai@suse.de>
 <20190506140506.GQ14916@sirena.org.uk>
 <s5h4l674n9g.wl-tiwai@suse.de>
 <20190508081006.GZ14916@sirena.org.uk>
 <s5hk1f1nyyh.wl-tiwai@suse.de>
 <20190508085953.GF14916@sirena.org.uk>
 <s5h5zqlnw65.wl-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============4662293116726828677=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [IPv6:2a01:7e01::f03c:91ff:fed4:a3b6])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 4997FF807B5
 for <alsa-devel@alsa-project.org>; Wed,  8 May 2019 12:10:44 +0200 (CEST)
In-Reply-To: <s5h5zqlnw65.wl-tiwai@suse.de>
List-Unsubscribe: <https://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <https://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: "Alsa-devel" <alsa-devel-bounces@alsa-project.org>
To: Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel@alsa-project.org, Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
List-Id: alsa-devel@alsa-project.org


--===============4662293116726828677==
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="zMJiK8ZuAkzScPs5"
Content-Disposition: inline


--zMJiK8ZuAkzScPs5
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, May 08, 2019 at 11:16:18AM +0200, Takashi Iwai wrote:
> Mark Brown wrote:

> > > there is no i2c irq assigned but only ACPI gpio, as far as I checked.

> > You can map through an ACPI GPIO to an interrupt without worrying about
> > the fact that it's mapped as a GPIO in ACPI IIRC - if you can't there's
> > lots of other drivers are going to have issues.

> But what gives a benefit?  It needs more plumbing between codec and
> machine driver.  The i2c probe doesn't give the irq, so you'd need and
> extra stuff to enable the irq in a different route if you'd need to
> implement the handler in the codec driver.

Handling the interrupt entirely within the CODEC driver *reduces* the
coupling between the CODEC and machine drivers, making it more possible
to use the standard set_jack() interface and generic machine drivers
with the CODEC drivers.

Actually looking a little I think you may need some ACPI specific
parsing code in the probe function to look up the GPIO but that should
just be like all the other DMI quirking stuff, hidden in the CODEC
driver.  It's really sad how bad a job Intel have done of making
firmware interfaces for their audio hardware.  I had thought people had
managed to hide all that stuff but I'm not seeing the code right now.

> Actually, my latest patchset already eliminates the exported stuff by
> moving to set_jack callback like some other drivers do.  If you have
> an idea for further simplification / fixes, let me know.

> I haven't submitted because of the merge window.  The patch is found
> at topic/soc-cx2072x-5.2 branch, the commit is
>   https://git.kernel.org/pub/scm/linux/kernel/git/tiwai/sound.git/commit/?h=topic/soc-cx2072x-5.2&id=ca7f4eee5ecbefcf347f5a4984c0a17629360186

I'm on a train with intermittent network connectivity right now (and
getting near to my destination too)...

--zMJiK8ZuAkzScPs5
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlzSqxQACgkQJNaLcl1U
h9CjuAf9FDK3Qade9+Ul239n1HqfTBwDsqlu+UCYf1No40b1GEDLJJXase3PmfCq
8Ec4KY0BbKmI92OiOFT6hFzDu8uF6GB7TTgHMfqNec5no6B3LCjNi4BY+ZPkEC5a
rogabKe8iQSkLI9rOPXDaNZo87U9qcBwSGmSlTo4wsidfzN9byeIRYDToWMh8Kzi
u6D+zPfDSUbbNtmgaYCcOkcHoRc8EqEkU/4DuEJxDIxv6Ngz6pbNEC8EHzPzQh+n
2tc9Kw2Ac+z5GATdLUwje5xtvk+ME5HkyPHXZgI7TAFAjWotmzgMnlw6Bu7QaJXB
riOlPzYvZaD1joxiWgVUbekF1bTfBw==
=Xyxy
-----END PGP SIGNATURE-----

--zMJiK8ZuAkzScPs5--

--===============4662293116726828677==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============4662293116726828677==--
