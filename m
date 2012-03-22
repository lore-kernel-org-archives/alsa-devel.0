From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH 05/16] ASoC: core: Add strobe control
Date: Thu, 22 Mar 2012 16:33:52 +0000
Message-ID: <20120322163352.GL3091@opensource.wolfsonmicro.com>
References: <1331651503-16917-2-git-send-email-ola.o.lilja@stericsson.com>
	<1331651503-16917-6-git-send-email-ola.o.lilja@stericsson.com>
	<20120313213356.GE3177@opensource.wolfsonmicro.com>
	<4F6B5136.5040208@stericsson.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============8068904001070929318=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 786761044DF
	for <alsa-devel@alsa-project.org>; Thu, 22 Mar 2012 17:33:54 +0100 (CET)
In-Reply-To: <4F6B5136.5040208@stericsson.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Kristoffer KARLSSON <kristoffer.karlsson@stericsson.com>
Cc: Ola LILJA2 <ola.o.lilja@stericsson.com>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, Liam Girdwood <lrg@ti.com>, Linus Walleij <linus.walleij@linaro.org>
List-Id: alsa-devel@alsa-project.org


--===============8068904001070929318==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="8SdtHY/0P4yzaavF"
Content-Disposition: inline


--8SdtHY/0P4yzaavF
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Mar 22, 2012 at 05:20:06PM +0100, Kristoffer KARLSSON wrote:
> On 2012-03-13 22:33, Mark Brown wrote:
> > On Tue, Mar 13, 2012 at 04:11:32PM +0100, Ola Lilja wrote:

> > Based on this description it's hard to see why this control is patterned
> > after an enum - why would we have an enumerated control to bounce a
> > single register bit on then off?

> I originally chose to pattern this control after an enum since enum controls
> would allow for exposing such intuitive textual information to the client about
> the state of the control for this type of use case.

But if this is a strobe control it has no state, you do a write to
generate a strobe but the strobe lasts for no meaningful time so isn't
observable.

--8SdtHY/0P4yzaavF
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iQIcBAEBAgAGBQJPa1QtAAoJEBus8iNuMP3dMAMP/i5SvRakw456VUeGaSxntsk7
mFgfRDs9B/HOJgdAxA5AHgKGBSFSyueKy9QM7ZcIhG/xwHkFGgQOrAw4vZJrLO/X
jtA8yv8MQ18cTWnvMRryPzYhbGV/8kOIuBV+kPCEAVJ5IdrYAe0DPIrZ5crmhHUv
gpeCQBIPOivmyFnjsAldoVb4HpDkPptG5OJiSvpgkvBPwcOvpxoxq5Wwx+Usi0Oj
xu1tE7yySEafH0eoxS/7THj+FHToiGBPzFFmpskpYIsLf1YDizKbJZtHV1RrmyB3
x5r6bekpvoN5WqxZJjO9H3vbFuF2JVSzQPrxNg+99Dc9eSDnuX4oeiPEnd/cP9nt
Cv1KFu51wCcoYpSSJhTrIouhHHbj48z/g7yIUQHVAEVOT9gSJhghrkESL07g+dhc
wNfiSjwl4YMNkiz5LcRZZPFTiVaPzorYNTdQAoNqChCXJCwpjELEtGzv/2Nuyqf4
PwXJHjQVu9po8lwVQIWFQSkcj3FXkL/1kDhm1oSIR6fC+hR2xntJa9MjSXrBRNSC
grfm/yn4A7CfnlVaA8TdN6Mmu/yrRFgZmabbzazr4Y9HqEqGz2UXzjwdGCxs74xc
1KOZ+I/5Os3IX4QI7w0c8PkJl9QeU08BQWiC1lCExWe9xbpaonP+td8wBe1TmXnm
Ws23Zw2I0eyVbkeBA57R
=l3I/
-----END PGP SIGNATURE-----

--8SdtHY/0P4yzaavF--

--===============8068904001070929318==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============8068904001070929318==--
