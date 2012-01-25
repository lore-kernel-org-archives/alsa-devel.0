From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: soc-dsp programming model for loopbacks
Date: Wed, 25 Jan 2012 17:20:52 +0000
Message-ID: <20120125172051.GS3687@opensource.wolfsonmicro.com>
References: <007801ccdae0$381fcf40$a85f6dc0$@bossart@linux.intel.com>
	<20120124220036.GA11635@sirena.org.uk>
	<1327511545.11901.41.camel@odin>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1156513612498246158=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 18161103BBF
	for <alsa-devel@alsa-project.org>; Wed, 25 Jan 2012 18:20:54 +0100 (CET)
In-Reply-To: <1327511545.11901.41.camel@odin>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Liam Girdwood <lrg@ti.com>
Cc: alsa-devel@alsa-project.org, Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
List-Id: alsa-devel@alsa-project.org


--===============1156513612498246158==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="fu8LepSeDvpxVgv6"
Content-Disposition: inline


--fu8LepSeDvpxVgv6
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Jan 25, 2012 at 05:12:25PM +0000, Liam Girdwood wrote:
> On Tue, 2012-01-24 at 22:00 +0000, Mark Brown wrote:

> > Note that the use of soc-dsp isn't required for on-SoC DSPs - it really
> > depends on how the hardware looks.  If the DSP external format is very
> > strongly tied to the format used to DMA to and from main memory (or
> > other interfaces) then soc-dsp is what you need, if the DSP is able to
> > rewrite formats more flexibly then it should be more direct to model it
> > as a CODEC device with whatever number of DAIs and routing between them.

> It's also needed if your DSP cant control or configure any of your host
> CPU DAI hardware controllers that it needs to physically use to route
> audio data.

Depends how they're allocated - the DSP driver can always do the
management on behalf of the DSP firmware if the hardware is structured
in a way that makes that make sense (for example, if the CPU never talks
to the outside world directly).

--fu8LepSeDvpxVgv6
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iQIcBAEBAgAGBQJPIDnsAAoJEBus8iNuMP3doWoP+wfILj7gnmFGNV7mvuQ7BKKL
6sObWWzusl2uQP3liA1SM+L0WTY+formHumgOmkEic8wmAJS3XwH6fZ7R8j/IAym
lB9yVTsMzHTJaLuj2i5FvksCOdSfqLxYfVV1Pt5tJWh975ZzhKQx3//8e3FJSINZ
hjNdJeHW7h9L5ptIhGADgV4lIgcXk17js9soG9LKwj4i4S19c/yvVnBlH8Gu6+8J
E2E4xw42Evpz+O5WpuQHoz8aI0IBrPcLP0aGLf2CEUAvOgxpjn3aweX366LYIV5A
q+D7IND7sqXXaNyw1sS+Bxu/yZcG7tohGIikFZs4qgNnZIsNSiKRutrw9gMzkfUk
PSvK+K6H5lY689n7I61PZEf+wMWfTi+tQ4P/YS1LyMqsnnjuyg34LUU2JNMWGGdm
XIKOfN5xoMXSvj0NJFH7DzH+AVmdHvaxqaejppk0VinABPdaZQt9iDNbN4K8jTCW
SPwDdf9HpA4lA/so0vJsUJ0N4CuC5rvknp5pnv8xEhuPRpIRrP4DTyZrqR4VWM9D
ud21aLgu+yS+g+r9tS77gc+WDj6DcpW0MZza9IEn7O4CONzAM7TEZhpeeGs6AHB3
4B3rZUBFCM3otqnaW+zE33mBcMOmuhWpgk+pScGMlJfLmwn/d+UJRcnJ2NskQ2Hd
4MGiSv6Tk+nnVeTmFJ7W
=+dew
-----END PGP SIGNATURE-----

--fu8LepSeDvpxVgv6--

--===============1156513612498246158==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============1156513612498246158==--
