From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: soc-dsp programming model for loopbacks
Date: Thu, 26 Jan 2012 14:32:55 +0000
Message-ID: <20120126143255.GB28994@opensource.wolfsonmicro.com>
References: <4f1f2489.c602440a.208e.ffff9d7bSMTPIN_ADDED@mx.google.com>
	<1327511249.11901.37.camel@odin>
	<20120125171112.GR3687@opensource.wolfsonmicro.com>
	<002d01ccdb9c$7099f1e0$51cdd5a0$@bossart@linux.intel.com>
	<20120125201438.GA17032@opensource.wolfsonmicro.com>
	<4F215127.8050509@linux.intel.com>
	<20120126140310.GA28994@opensource.wolfsonmicro.com>
	<1327588068.7134.5.camel@odin>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============2286422599757971022=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id DEB66103854
	for <alsa-devel@alsa-project.org>; Thu, 26 Jan 2012 15:32:56 +0100 (CET)
In-Reply-To: <1327588068.7134.5.camel@odin>
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


--===============2286422599757971022==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="IrhDeMKUP4DT/M7F"
Content-Disposition: inline


--IrhDeMKUP4DT/M7F
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Jan 26, 2012 at 02:27:48PM +0000, Liam Girdwood wrote:
> On Thu, 2012-01-26 at 14:03 +0000, Mark Brown wrote:

> >     CPU <-> DSP <-> External

> >    DSP     External
> >     ^----v----^
> >         CPU

> Fwiw, the OMAP ABE architecture mixes both above diagrams. We are using
> dynamic PCM for managing all the DAI links and will add in support to
> use the CODEC <-> CODEC stuff for the loopback DAI interfaces (saving
> the need to open()), hw_oparams() etc).

In terms of the data path I think it's pretty much always like the
second path with the DMA controller owned by Linux driving the data
between the various components?

--IrhDeMKUP4DT/M7F
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iQIcBAEBAgAGBQJPIWPfAAoJEBus8iNuMP3dqOEP/R8E5IIJVUdbSr74qR3aToOV
RiI8Hexq5Kn+eFYZW2jWZc8CgNOOgdjqv3y9cOXOar78NygaeEXEAO8vRPnS1Kh0
taNe6qsl2AxXkodUshkeXsXWMx7XMIedflnyIt92Ds2j23eJJEJZPzPmucDnu8/w
RCVVegiLE46xUkWGpW1bAFq8YhDe9Tj5+VchMkDeS7kPZBoRnN3OGc0FrLUPaDoh
sr0ROrDRC1gY8rVDszrd9ReVLb86I1GKZUEVfHQ04hZnNp7kgF0WHe0yPqqnpwBy
RAb6nOV8YjGi0g3hJSRXfBby1Qykzteb+HMlBA97WbGeexm0eBUBig3FFr7MJjI+
50Uz+WAz8ryLPkBxjEKoAudbHZ8oyWRqsUfMB+OX9ySTknLxP+hXrj62vJ69amAZ
81jh/zx2R9lXWNGuIRJKyKK0gbDTgjq9YP9Q5BBCi/vWzIkjfX2GkQMPM6wzZ7n8
jp9w9YcHT9WMkdC4JiregIa9XxAwrgCkOTHatjA2CH9mdFhHtkvHFZGVqzR6uiMo
H082un/HisjDNfmJm9Jflxvc3OoO6iNt1guymOtp+MQUzFbszdYH/MUDULG6tto3
kGeTr9n+SOu8EU2vKHbkZTS3B9pwY9T8KhS+jd3fDOOtok6+XCqGtAJUmLRv1w4F
Yb7p4AqXZftpuWXinLi2
=Wa6C
-----END PGP SIGNATURE-----

--IrhDeMKUP4DT/M7F--

--===============2286422599757971022==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============2286422599757971022==--
