From: Mark Brown <broonie@kernel.org>
Subject: Re: Ordering in soc_pcm_hw_params()
Date: Wed, 13 Aug 2014 17:35:25 +0100
Message-ID: <20140813163525.GY17528@sirena.org.uk>
References: <CAKON4OzQF8sDigvcDFsJaJRVX9o4X1FiC2FEU8D6n=oaQkX+Uw@mail.gmail.com>
 <53E9D383.5060103@metafoo.de>
 <CAKON4Ow3HFL0Sv2AV7+-XS0PBHnP9WW_8FBgrV=cKp14LER9XA@mail.gmail.com>
 <CAKON4OzrJSAD0RUL5TO6n8mxG0q9rRau0MWaAXvXVo+bSB8Ygg@mail.gmail.com>
 <20140812115755.GO17528@sirena.org.uk>
 <CAKON4OyOL2asou5NvL0crcAy=wYdguBYpc7w+x0xcUUf93FxUw@mail.gmail.com>
 <20140812182029.GX17528@sirena.org.uk>
 <CAKON4Oyi8x_P5kLQrW3EVsr0aw8-9VnfJXWEhKgJCDsQi9L6UA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============6055295172090563181=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 916AD261A2F
 for <alsa-devel@alsa-project.org>; Wed, 13 Aug 2014 18:35:42 +0200 (CEST)
In-Reply-To: <CAKON4Oyi8x_P5kLQrW3EVsr0aw8-9VnfJXWEhKgJCDsQi9L6UA@mail.gmail.com>
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


--===============6055295172090563181==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="cNcQrxOlmhKdttKB"
Content-Disposition: inline


--cNcQrxOlmhKdttKB
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Aug 13, 2014 at 08:25:22AM -0400, jonsmirl@gmail.com wrote:
> On Tue, Aug 12, 2014 at 2:20 PM, Mark Brown <broonie@kernel.org> wrote:

> >> 2) Should sysclk for the cpu-dai and codec-dai be set independently?
> >> In simple-card they can be set to conflicting values on the two nodes
> >> in the DTS. Should sysclk be a single property for the machine?

> > No, clocks might be at different rates for different devices.  One
> > device might divide down the clock to the other.

> What do you think about adding fields for min/max allowed sysclk to
> snd_soc_dai_driver? In my case the SOC can run the sysclk at 100Mhz,
> but the attached codec can only handle 27Mhz.

If we're going to do constraints they should be done properly so need to
be able to represent specific numbers too.  It's probably a clock API
problem, independently implementing it seems redundant.  Doing simple
things in simple-card for the common cases makes sense while the clock
API isn't something we can rely on but equally we don't want to be doing
huge amounts, and of course simple-card is just a subset of what people
are doing.

--cNcQrxOlmhKdttKB
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBAgAGBQJT65PKAAoJELSic+t+oim9ZM8P/A+RXmwqs9tkon1ujX0LBnxf
tLpFzYLYvq9LWJOWKX/+Xa+YEGZUQeYi6+OBagc6TH2O/db7hQi7NlD6LrSIpYIP
PTER4kRbbZHzWCEC4A3eFZqdI0EtMcEc69cs42v8Ha3COeFHb8yzVhfut1BDyndq
bRmB/MsEEKfBK5xKL3+miF49+9ElYfO2Vp3q8NtIFaT6iLCAiXoXDa4bRcWda7pM
M7srjK+nNKczlcXiIydXuWHy7W0tZ3YMkzRUKznWRc5suMahuvPZgsqKX/pBpK6t
HO6BJTfP5dK0syPSYckWhgBkUO0cgOwpoxdiguq4Vw4j6UtgTMjID4i9mcES31KD
stebg4ity1rmOsE0V0LO2LY0qL7lrdDcrs9KLG0GRAlBQGq2lTaWYW+RnYYUaY8q
jnLuJm+YN92brvyiqUjY1I+Y3Wx/unGfJc7egl4SyG9Kc0LPffp0ax02LFLnHd8b
qAKKJS+1oMohZ3FYK8NKFuV2y0Be3KXByecO39CvSTRveblKRLGmKw7qcahif2P3
HJU6FwFxKyuSmm2yINP6zjT8+nnVRJ/1bjpYzZd6d+E/eoQFn4lkAy4K/zTfMpnw
GqBBVs+ts6LA3LUU5jxapbDYlKwY4mJrxpNSDaiXOo5bqn66EN2Fi7yOVmb49kQ7
VPRi9S/EKd1EjBxog2Hz
=XSuP
-----END PGP SIGNATURE-----

--cNcQrxOlmhKdttKB--

--===============6055295172090563181==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============6055295172090563181==--
