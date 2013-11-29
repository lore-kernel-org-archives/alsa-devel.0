From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH 2/4] ASoC: Add support for the Analog
	Devices AXI-I2S core
Date: Fri, 29 Nov 2013 14:27:50 +0000
Message-ID: <20131129142750.GB27568@sirena.org.uk>
References: <1385665372-29477-1-git-send-email-lars@metafoo.de>
 <1385665372-29477-2-git-send-email-lars@metafoo.de>
 <20131129115830.GT27568@sirena.org.uk>
 <529890F0.7090100@metafoo.de>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1619311326887632329=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
 by alsa0.perex.cz (Postfix) with ESMTP id E79AD261700
 for <alsa-devel@alsa-project.org>; Fri, 29 Nov 2013 15:27:52 +0100 (CET)
In-Reply-To: <529890F0.7090100@metafoo.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Lars-Peter Clausen <lars@metafoo.de>
Cc: alsa-devel@alsa-project.org, Liam Girdwood <lgirdwood@gmail.com>
List-Id: alsa-devel@alsa-project.org


--===============1619311326887632329==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="6PtN/jU//tuarfdA"
Content-Disposition: inline


--6PtN/jU//tuarfdA
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Nov 29, 2013 at 02:04:48PM +0100, Lars-Peter Clausen wrote:

> We only use it on ZYNQ and Microblaze though. And people have complained in
> the past about symbols that are viable on their platform, but are not
> relevant for their platform. And to use the core on a different FPGA
> platform will most likely require changes to the core, unless the other FPGA
> also has a PL330 DMA interface. So I'd prefer to only make it avaiable on
> ZYNQ and Microblaze right now.

Is it really restricted to PL330 at the hardware level?  I don't recall
anything too fancy in the datasheet there.

> >> +	frame_size = AXI_I2S_BITS_PER_FRAME / 2 - 1;

> > This isn't obvious - usually the frame size is the number of bits per
> > frame.  Looking at the code I guess the hardware is more flexible than
> > the driver allows at the minute?

> that feature at the moment. But I'll add a comment explaining this. And
> maybe rename the variable from framesize to wordsize.

It definitely needs to be changed to word size.

--6PtN/jU//tuarfdA
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJSmKRiAAoJELSic+t+oim9sM8QAJbczwFCdGjwRRCFow0OseU2
OzO+uofnzEJCx2lyBSmwlF5RxrEwtk2N3g0IA/Y4lrCJJfcQyd2VtYUcCYqaaA7h
S1yTk90R6vhkjh6lUOGge1e7cmrBMkJUcMz3n8YBNIWY0YMHfYnaE1dyOa7/3ZRe
y/jD1o1JqYoApQXc6KQHpUhBf+55r6RQmDw+X0/iEQNh+mnl9u5xTsR9EQ1mDICm
/PIP/UfWWfxjUmIpCrWx1FcstMTYRzMkqNZo4Bd6Zm7OuPUtxcK5b60uZFiU4CRz
V6ZM2Fvh5mrTuXmRdpuMdeopLBgIU/mXSEIJkZwWS4oO7+Z0rtclMl4rOi+Kbukf
E/QvoccBIZdlzR4XLAtwZt+sf6+e260hWXyZJCwoMZjL9gw16R9/cpJFeQ6P0rBB
Vsvxj0a848BgbXHdLz7mAUVrc7vUjwGHRd0GWgKv1x/nkQsS6hraoYxKljgZgSU1
jKqq9k3Bs0F6gP1lhJaKmFx3qCSjEjt7bpsXt/O+SC7KlQU+MJN/qBcnkbnQ3MvJ
MwPnJoC2KlECXi2sgfBjeU9A10j+ReJ2gbfpaVLMrVk2o36cid8dC1mq1k6+OHcE
GJyU1D9Sx6ziG2n5GUY1i1YksscpzzescMNa6u/JsRZzJgNdS68Xhokp/9OiMQ4H
QYwYK4o6hn4saTF5I3/a
=GhfH
-----END PGP SIGNATURE-----

--6PtN/jU//tuarfdA--

--===============1619311326887632329==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============1619311326887632329==--
