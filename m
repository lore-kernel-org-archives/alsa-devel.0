From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH 0/2] ASoC: dmaengine_pcm: support generic
 DMA binding users
Date: Fri, 22 Mar 2013 12:28:59 +0100
Message-ID: <20130322112859.GL22890@opensource.wolfsonmicro.com>
References: <1363318601-31505-1-git-send-email-shawn.guo@linaro.org>
 <20130321023858.GD6281@S2101-09.ap.freescale.net>
 <514B21F3.90803@metafoo.de>
 <20130321152206.GA14768@opensource.wolfsonmicro.com>
 <20130322111704.GZ4977@n2100.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============7218264624936324504=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource.wolfsonmicro.com (opensource.wolfsonmicro.com
 [80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 84079265175
 for <alsa-devel@alsa-project.org>; Fri, 22 Mar 2013 12:29:01 +0100 (CET)
In-Reply-To: <20130322111704.GZ4977@n2100.arm.linux.org.uk>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Russell King - ARM Linux <linux@arm.linux.org.uk>
Cc: alsa-devel@alsa-project.org, Lars-Peter Clausen <lars@metafoo.de>, Vinod Koul <vinod.koul@intel.com>, Sebastien Guiriec <s-guiriec@ti.com>, Markus Pargmann <mpa@pengutronix.de>, Shawn Guo <shawn.guo@linaro.org>, linux-arm-kernel@lists.infradead.org
List-Id: alsa-devel@alsa-project.org


--===============7218264624936324504==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="jtcAeju3WzRmRF+o"
Content-Disposition: inline


--jtcAeju3WzRmRF+o
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Mar 22, 2013 at 11:17:04AM +0000, Russell King - ARM Linux wrote:
> On Thu, Mar 21, 2013 at 04:22:06PM +0100, Mark Brown wrote:

> > FWIW it might be worth looking at the one rmk wrote but has never wanted
> > to submit for whatever reason.

> Err no, stop twisting the facts.  I know nothing is ever your fault.  You
> rejected it because it was providing support for non-cyclic supporting
> DMA engine drivers.

That might well have been one of the reasons now you mention it, I was
just remembering that the code has never been posted to the list, I've
only ever viewed it in your git trees.  IIRC it was only mentioned on
the list after the currently merged library was posted and you weren't
keen on submitting at that point due as you weren't happy with the
platform code using due to that code having to jump through hoops to
support some unusual hardware design decisions.

> I've since added support to it for cyclic DMA engines, but I've retained
> the non-cyclic support in it because I don't see why I should remove it
> when it works for me, especially given the difficulties with getting

We need support for both cyclic and non-cyclic devices, one doesn't
preclude the other and both kinds of hardware exist.  Cyclic is much
more common and generally more desirable but that doesn't mean that
hardware designers always provide it.

> anything in sound/soc changed once its been merged.

I'm sorry, what difficulties are those?

> Plus, as I've already said to you, I no longer develop and test it because
> the platform I was using is now doing service as my firewall, and you'll
> forgive me for not wanting to take the whole of *.arm.linux.org.uk
> offline to mess around with ASoC stuff.  But that's not to say I don't
> care about the issue.

Indeed, I understand why you've stopped now.

--jtcAeju3WzRmRF+o
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIcBAEBAgAGBQJRTEByAAoJELSic+t+oim9sH8QAIhD8PXvEvtOJH+8P3zW/S8/
WW16Hw9Ds2IwExhavzd49AZvISMkk30vqhp318gYZnb6hv5gxDvHh4l4jweWpJje
9dJj4ZsFuNjbHCQ6I3fJZ9g+vsOjfQ9fuErq5jzyNRIzmUhtbJrqyAEHRjWVW8Dl
0kUsgtZMnwqeAhqKlM1esJdoVfKkewwZF6fE9+K8r4OPAtz43Li2qlEXPovJJTOt
kUK6xuMLFg0tR/RBScqoAaRnZUzkTvqG8/Ef0BuS/AMJ1Qr4rkPKyaK9MIxYJC3l
mwJulvCLTghCy18LwSixaiG5ysxU2vZxkDvfCcoGCJYpYuWWLVSk7WdKFNy6Vu5x
eE3gQMNZhXnWfrcDmQjLILX2QW8nm2IEFye4cHCmnNSfen2g9uH8SEKmmRibLIk7
RbkI8OEX+3MWn5UtZ1ksGdsSlYbFyT4jjzTQ0KssaBWGUeqtPDHMyuua+hJLLSNw
30LvMdQbw59X8knWoH+vO0JRKvwRxiurKC38CaJhPqzn4XcUglo+WqtFQCeVNqW1
obM7wLfn/GzQ9Wi5LifsQw1XbqbpuyKO9Ao6YfRskeFM0m264ttriwqz7MYLdmj4
OippDPikflUaZUpK2pHgcBlOnz54a+DW76iwiYAFS+b/P20yxb3ausIt2m5w5/fB
71j56TsfvB7YQFuQf707
=Znpc
-----END PGP SIGNATURE-----

--jtcAeju3WzRmRF+o--

--===============7218264624936324504==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============7218264624936324504==--
