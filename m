From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH] ASoC: dapm: Fix x86_64 build warning.
Date: Mon, 23 Apr 2012 13:28:44 +0100
Message-ID: <20120423122844.GN8318@opensource.wolfsonmicro.com>
References: <1335173475-5536-1-git-send-email-lrg@ti.com>
	<20120423121646.GE8318@opensource.wolfsonmicro.com>
	<1335183754.31825.109.camel@vkoul-udesk3>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0980501375952587285=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id EAF9824550
	for <alsa-devel@alsa-project.org>;
	Mon, 23 Apr 2012 14:28:49 +0200 (CEST)
In-Reply-To: <1335183754.31825.109.camel@vkoul-udesk3>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Vinod Koul <vinod.koul@linux.intel.com>
Cc: alsa-devel@alsa-project.org, Liam Girdwood <lrg@ti.com>
List-Id: alsa-devel@alsa-project.org


--===============0980501375952587285==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="8MZM6zh5Bb05FW+3"
Content-Disposition: inline


--8MZM6zh5Bb05FW+3
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Apr 23, 2012 at 05:52:34PM +0530, Vinod Koul wrote:
> On Mon, 2012-04-23 at 13:16 +0100, Mark Brown wrote:
> > On Mon, Apr 23, 2012 at 10:31:15AM +0100, Liam Girdwood wrote:
> > > Fixes the following build warning on x86_64.

> > Applied, thanks.

> Just wondering, do we have a x86-64 system running asoc?

We should do though we don't currently - see the recent discussion about
the ice drivers.  There are some PC sound cards (mostly high end or old
ones, or tuner cards) which have a setup like ASoC where there's a CODEC
on an I2C bus and a "platform" which in this case is a PCI type device.
At a high level they look the same as embedded hardware with several
chips glued together in software.

--8MZM6zh5Bb05FW+3
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIcBAEBAgAGBQJPlUrzAAoJEBus8iNuMP3daFkP/RiOqWAxe5xoLzdhKgIFxOey
VovrdaaKKPaMMKWm3cVOyyp0hTeRevEnOR+F65oYXTdVHhEeJL00/MZoCUCCz/7F
zFixUNFq49W+Qw3PO/MjHqK5jtvLchuSgf9hSyIvGKazU1WfqlDLQNhRaQJsn0Z0
+Dmacbv7pU03bTnOU5OBIXE98/DG6LsiV99ZloDM17b9OynWU6H42PsNBAxDu8/G
XMEyqvaV0XvtBnDgDKIxaYvgai8wrKaAc5zchDIRkFdMfNP2itX9N3J09rhpKVwb
mZx+pbZ6PzsQ8Lf73fMdMD0MR2YqFzUbwdN9zJ2EIc5axE8gsc+o2s6+6Q2RDVG/
Ij25TqTn5dv8MeBy7yP6cBDqhVJJaFXElfFWmZArrTxgxiShfvMVw5tVWwnPeQE4
9smOFZGxL5rFOetuj0xrAvujk+anAIs4erTEg/+URPAsrfuQkoJ5ia+r4fENK0NN
7QD0jChaF3oKpEdtm3qdwMl2GyBMxgey8N0RlnkvW4QJleXBynPzvWH62MhGhCs/
WJDRBVZcVkQpFyYN8YGfmjEWm/6iymV2C2IB8u3zODYWsZzYLsQyS+xvmDW50zjP
Ln0YP7OYiR9iV9IT3ruF3NfkrP7cCgZnMueN+uZuikM+kGpOkXaHR24/HYk+miBP
sma3P7WbrAi9gJcZEF0z
=qwVq
-----END PGP SIGNATURE-----

--8MZM6zh5Bb05FW+3--

--===============0980501375952587285==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============0980501375952587285==--
