From: Mark Brown <broonie@kernel.org>
Subject: Re: [RFC] ASoC: sgtl5000: Remove cache support
Date: Wed, 8 May 2013 11:31:50 +0100
Message-ID: <20130508103150.GW7478@sirena.org.uk>
References: <1367610549-25542-1-git-send-email-festevam@gmail.com>
 <20130503223613.GR4945@sirena.org.uk>
 <CAOMZO5B84e0YdcJLa27e4KZv459CGL=msU0fqe4LyFZfM-t1+A@mail.gmail.com>
 <CAOMZO5BG-3SKZF_ZrQ=C51nLvKYSNJEgy-KavzBXJcb=fCk=iA@mail.gmail.com>
 <20130505101515.GT4945@sirena.org.uk>
 <CAKGA1bmKdtAoUP7Yn0CJRVwsCNX5JkEWdWVJj1VJBaJn+9PA=A@mail.gmail.com>
 <20130506220650.GJ7478@sirena.org.uk>
 <CAKGA1b=+j5BpHzWOfkDv+xjLLcauHeD4jDj_Do+6ft6UPhYEtA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============8569436954036066365=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
 by alsa0.perex.cz (Postfix) with ESMTP id 49287261658
 for <alsa-devel@alsa-project.org>; Wed,  8 May 2013 12:32:17 +0200 (CEST)
In-Reply-To: <CAKGA1b=+j5BpHzWOfkDv+xjLLcauHeD4jDj_Do+6ft6UPhYEtA@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Matt Sealey <matt@genesi-usa.com>
Cc: Fabio Estevam <fabio.estevam@freescale.com>, alsa-devel@alsa-project.org, Eric Nelson <eric.nelson@boundarydevices.com>, "troy.kisky" <troy.kisky@boundarydevices.com>, "zengzm.kernel" <zengzm.kernel@gmail.com>, Fabio Estevam <festevam@gmail.com>
List-Id: alsa-devel@alsa-project.org


--===============8569436954036066365==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="AFjAQ8ujNJnIGHaX"
Content-Disposition: inline


--AFjAQ8ujNJnIGHaX
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, May 07, 2013 at 03:06:39PM -0500, Matt Sealey wrote:
> On Mon, May 6, 2013 at 5:06 PM, Mark Brown <broonie@kernel.org> wrote:

> Just for reference the supplies on the Efika MX are VDDD 1.2V, VDDDA
> 1.65V and VDDIO 2.775V respectively. For the sake of a couple 0.1uF
> capacitors you're not really saving much money in the lowest cost
> configuration, and you're doubling to tripling power consumption. If
> 15mW makes a difference to you (especially if you're supplying the
> above from rails connected to other devices and you're concerned about
> current limiting etc.) it makes sense to go for the lower power one.

Well. some applications just don't care about power consumption.

> It is hard to imagine an i.MX board without 1.2V, 1.6V and 3.3V from a
> PMIC to supply the codec so letting VDDD float and using the internal
> LDO seems like an exercise in selling the codec to people who aren't
> using other Freescale parts..

Even if there's physically a supply at the appropriate voltage people
can have concerns about running noisy digital stuff near their analogue,
the on-chip regulators aren't purely about component cost.  Not sure
that this is a consideration here but...

> I think most of the weird problems is the LDO configuration itself -
> Linux assumes that it's not set up, when if VDDD isn't there, it is
> already. Weird sequencing of supplies by boards (either not bringing
> any supplies down or not bringing them down correctly in a reasonable
> order) on warm reboot and enabling it *regardless* at revision 0x11 or
> above which is just turning (on our boards) a 1.2V supply into a
> better filtered 1.2V supply and making the chip run a little hotter.

Is it actually having a postive impact on performance?

> I am curious about the version check more than anything. Either the
> internal LDO is required to filter poor supplies on some boards (which
> ones?) or revisions equal or above 0x11 had some DIFFERENT digital
> supply requirement - I seem to remember the reference manual stating
> 1.2V was a suitable input supply, but the minimum is 1.1V in the
> latest RM. Maybe if you run it at 1.2V there's some problem. It's not
> documented why that decision would be made.. no errata..

That sounds like tolerances doesn't it?  Spec of 1.2V.

> >> So maybe we don't disable the cache, or it gets ported to regmap, but
> >> the order should be enable regulators in a non-cached way then fill
> >> the cache AFTERWARDS - the code at ToT mainline doesn't fix the cache

> > I'm sorry, this makes no sense to me.  If we know the physical defaults
> > for the device and we can get the device into that state then we should
> > have no need to read from the cache.  If we don't know what they are
> > then they shouldn't be listed.

> In the case VDDD isn't supplied when the other two supplies are
> brought up, then the LDO is enabled, so if the register controlling
> the LDO configuration is in the cache.. that might explain a lot...

I still don't understand this at all.  Is the power on value for the
register variable?

> > I think the point that you lost me was your assumption that the
> > regulator enable needs to be done without the cache.  What makes you
> > believe that this is the case?

> Because that's what Freescale did in their code as per their comments
> - if only because they needed to do this kind of setup before the
> cache/defaults were populated. I assume they populate the cache from
> the chip at probe because the defaults change per revision and the
> presence of VDDD or not may change some of the registers in the cache.

We just have no idea why they're doing what they're doing; this is all
guesswork.  I've not seen anything that indicates that anyone who's sent
any code has any understanding of what they're changing.

> It may also be on boards like i.MX6 Sabrelite that the "defaults" are
> not the "defaults" over a warm reboot, since the chip never powers off
> (just "optionally" loses clock depending on whether CLKO is
> reconfigured or not at some point) and probably retains everything you
> ever set.

This is why most drivers do a hardware reset of the device on gaining
control of it, in order to ensure that the hardware is in a known state.
I see  that the driver doesn't do that except through the regulators.  I
see this driver doesn't do that which isn't terribly clever, though it's
not clear that the chip has suitable support.

> We want to do two possible things...

> * At probe, dump some known good defaults into the chip and use those as a cache

> * At probe, read out all the registers assuming they're already known
> good defaults into a cache

Clearly the first option is more sane since otherwise you've no idea if
the chip is configured sensibly.

> The intent being in the first case to make for damn sure the codec is
> in a well known state, and in the second case JUST to reduce i2c
> writes further down the line. Freescale seem to like the second one,

This isn't the sole function of the register cache, it's also used to
implement most of suspend and resume and to allow the device to be
powered off when idle but still present controls.

> Mainline is doing the first set, although it's definitely possible
> those defaults are not the true defaults if they were derived from a
> board like the Sabrelite where a warm reboot might retain all the
> state from previous boots.. the precedence of that list of defaults is
> basically unknown.. and I recall Freescale updating them in the BSP a
> lot.

I'd *really* hope that the defaults come from the chip datasheet.  If
they don't that's extremely disappointing.

> So the problem here might be some quirky board designs, a random
> implementation of an erratum workaround with no documentation, a bunch

My impression based on what I'm seeing here, including things like your
comments about lots of register default changes, is that people working
on the driver haven't had much understanding of what they're doing and
have got confused as a result.  Sounds like a good first step is getting
the register defaults sane...

--AFjAQ8ujNJnIGHaX
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.19 (GNU/Linux)

iQIcBAEBAgAGBQJRiimNAAoJELSic+t+oim9mhAQAJw7TAg0ndNWwjLcMh6ASqJo
7Tooks+ie+COGTmXk1WSjer5xT+WSYI6dNR4GZERK8FJRMNzN5RQtn2SBlqIzFip
JePByV4T3eW73a2AQAf7cNjwtXxxwqE5+PqoSS+0p+2fQ9RHahb+/Sdmu36ICZFf
V1HWA3IahFYjUpsh6wOLH9y84tn2pYzgValbecB0qCEfGf2SvFFohsg01dvPyapn
2GputpjMl68fOvzXTnDtJoTkHtu9flLtdVQnEXzx4+BrLHa1hEOsoxddsYjftrDp
qYzWiiBxsmbGGSKWViR3nnXhXO2cZL9ttg/wnkSy4OGNkUdi2sPLukgethTkeuqX
j5t3n7rj54MUC2+jTqxuacKkzcEfmNWJpCPHxE7mFHVnCxJtjtMcBe6NWfmWoFwz
83YQbZWaAegsvhcDcWyiTzxr0oEnvjxSo8F0WfMmYO7BRoesSczy1uVQcBI6GOjU
FTnpK7aV/ZS0ICwA/p5ROMO7D4b+uzfI+QmKylH0VL7hfUWM6ZvhU5/mNJyYzCUQ
M/odOsoOXEFfcgKFX3N+/GUgAZuFok5B9p+wFA7I+DhbIeqyIUF3XSMZXqW6cmrf
0dCNeCsnr8JAHp4R/HBF6AKeyXJPjOk7q4IrdG7O2KpwB5TUdvpr4pR0udm8YR6d
QLWqJDFLzBhQCAytiWB2
=9a5m
-----END PGP SIGNATURE-----

--AFjAQ8ujNJnIGHaX--

--===============8569436954036066365==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============8569436954036066365==--
