From: Mark Brown <broonie@kernel.org>
Subject: Re: Ordering in soc_pcm_hw_params()
Date: Wed, 13 Aug 2014 18:24:22 +0100
Message-ID: <20140813172422.GD17528@sirena.org.uk>
References: <CAKON4OzQF8sDigvcDFsJaJRVX9o4X1FiC2FEU8D6n=oaQkX+Uw@mail.gmail.com>
 <53E9D383.5060103@metafoo.de>
 <CAKON4Ow3HFL0Sv2AV7+-XS0PBHnP9WW_8FBgrV=cKp14LER9XA@mail.gmail.com>
 <CAKON4OzrJSAD0RUL5TO6n8mxG0q9rRau0MWaAXvXVo+bSB8Ygg@mail.gmail.com>
 <20140812115755.GO17528@sirena.org.uk>
 <CAKON4OyOL2asou5NvL0crcAy=wYdguBYpc7w+x0xcUUf93FxUw@mail.gmail.com>
 <20140812182029.GX17528@sirena.org.uk>
 <CAKON4Oyi8x_P5kLQrW3EVsr0aw8-9VnfJXWEhKgJCDsQi9L6UA@mail.gmail.com>
 <20140813163525.GY17528@sirena.org.uk>
 <CAKON4OzBKJbAzT6MVMT_jkuVFf6jYF5Pe=fFA2ZbhGSNkHbtgg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============4058948410837171236=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 275292651DC
 for <alsa-devel@alsa-project.org>; Wed, 13 Aug 2014 19:24:30 +0200 (CEST)
In-Reply-To: <CAKON4OzBKJbAzT6MVMT_jkuVFf6jYF5Pe=fFA2ZbhGSNkHbtgg@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: "jonsmirl@gmail.com" <jonsmirl@gmail.com>
Cc: alsa-devel mailing list <alsa-devel@alsa-project.org>, Lars-Peter Clausen <lars@metafoo.de>, Liam Girdwood <lgirdwood@gmail.com>, Nicolin Chen <Guangyu.Chen@freescale.com>
List-Id: alsa-devel@alsa-project.org


--===============4058948410837171236==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="xZz5+hkkzsDfx//M"
Content-Disposition: inline


--xZz5+hkkzsDfx//M
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Aug 13, 2014 at 01:00:02PM -0400, jonsmirl@gmail.com wrote:

> Right now I could make the set_sysclk implementations return -EINVAL
> if the clock is out of range. Then add some logic to simple-card to
> try again with a different FS multipler. Or at least I can print some
> error message to give a clue as to why the song won't play.

Well, error checking would be good.

> What ASoC platforms haven't implemented the clock API? Using the clock

There's still some ARM platforms that don't implement the common clock
API yet (or make it optional), Blackfin, MIPS, some PowerPC, SH and x86
doesn't enable it for most platforms and when I've tried sending patches
the maintainers didn't bother replying.  Life would be a lot easier if
the common clock API were available by default but the infrastructure
for asm-generic leaves something to be desired too.

> API, simple-card would have a phandle to the clock master. Then it
> could set the proposed rate into it. Codec and CPU would have
> clk_notifier implemented so that they could reject the proposed change
> based on their constraints.  Simple could then adjust the FS multiple
> until both devices are happy.

Even for fairly simple cards the solution is often more complex than
this - the master clock might not be directly connected to one or both
of the devices and there may be programmablility for the dividers
between them.  It therefore seems more likely to be useful to set the
rate we actually want rather than some parent rate, that at least gives
the best information to the code trying to do the resolution.

--xZz5+hkkzsDfx//M
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBAgAGBQJT659CAAoJELSic+t+oim9TdwQAIpp7qVDwXb1IulTIBxc6MkT
jofebR/VzX5D2I9H5iT1JTiVzJRvU9k7UQPDCKOSD3pkVolSf8gSaW22XtWAfLCZ
gkht40eq1XsiMPFVstdQSfRvWCZ3FqzH9WB71sBnbv/T1tfVyB5lHp0X2P0ncK1a
xHEY7uAyF5K471wClj9o2PkKQOv1M6adxq3dEXZXIUR5/K71NyhWqM3Wf+YZWs0P
hRpVQmhV9G1fAGoBTusbdWmLwFLLv1IBlnPr549BdjheKLXhTWPImIV6duXBW1gT
chzW7dFGimDeqChn3jHTsfVlz5q/jBnFjknGcxwNIC72RdON0+BqBvT700Vkg8Wf
h8nZmWIKaLrRqQlCTts3SAgsHtQ5uUT9sHy3CJML0pU43ySeI2yKZ5XZjLUgIE+E
UPOmPB2KcH/wZoxa5uIS0HYttW6TmP6f8713PGkYsSaYpDSLPalMiXVbyRPyzBes
M/3HjzDPp/fRFOHi6nsGd3OwIIUfgj5bzCLbDlTLSm+NQwn237xQjf9i9CDAC7Ec
eawy2xd4nitbaZHI6l2ZGqCWWmrBx7qyJPJsmQgMRTAbI9oaCnc0tx32toM01PfE
oC2laAQkO+dQ2PiEcJl2G0dsMLdYTwdQy+vN7QO5fCpfpgb7A3bsDadAxuQv3pqD
9ZzP7hk8b4LJzIq9mLNt
=j2kd
-----END PGP SIGNATURE-----

--xZz5+hkkzsDfx//M--

--===============4058948410837171236==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============4058948410837171236==--
