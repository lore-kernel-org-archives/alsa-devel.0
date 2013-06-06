From: Mark Brown <broonie@kernel.org>
Subject: Re: Generic clock divider indices
Date: Thu, 6 Jun 2013 15:53:38 +0100
Message-ID: <20130606145338.GF31367@sirena.org.uk>
References: <51B09224.9050409@gmail.com> <20130606135605.GB9980@sirena.org.uk>
 <51B09830.7020208@gmail.com> <20130606142409.GE31367@sirena.org.uk>
 <51B09D5F.6010803@gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============2258462430218254968=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
 by alsa0.perex.cz (Postfix) with ESMTP id 10A352655AC
 for <alsa-devel@alsa-project.org>; Thu,  6 Jun 2013 16:53:43 +0200 (CEST)
In-Reply-To: <51B09D5F.6010803@gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Daniel Mack <zonque@gmail.com>
Cc: ALSA development <alsa-devel@alsa-project.org>, Liam Girdwood <lgirdwood@gmail.com>
List-Id: alsa-devel@alsa-project.org


--===============2258462430218254968==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="/SXoEQDAiXmUSAYo"
Content-Disposition: inline


--/SXoEQDAiXmUSAYo
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Jun 06, 2013 at 04:31:59PM +0200, Daniel Mack wrote:
> On 06.06.2013 16:24, Mark Brown wrote:

> > Usually you just set the bit clock to be whatever the minimim clock
> > needed for the data is - there's helpers in soc-utils.c to get the
> > number - or the next highest sensible rate if there's a division
> > problem.

> Hmm, but in case the codec is slave to all clocks, it must have a way to
> determine what the bit clock rate (or the ratio to MCLK, respectively)
> is. It can't just _set_ it. Which detail am I missing?

If nothing else you're missing what happens if the driver for the device
generating the clock decides to change the rate for some reason.

It'd be rather unusual for something to care what the bit clock rate was
if it wasn't generating it - generally it's just shifting data in with
it so so long as the requisite number of edges appear its fine.  Do you
really have devices for which this is a problem, and are you sure
they're not actually looking for the sample size?

> > Yes, and thus you start to see the problems doing this sort of stuff
> > generically.  There's often also a whole bunch of different ways the
> > clocking can be set up

> But there's always a MCLK, a BCLK and a LRCLK. And thus, there are
> always ratios between them. It might even make sense to let the core
> inform the codec drivers, instead of relying on the machine code.

There generally will be, but knowing what they should be and who should
provide them is a different game - and of course they're frequently
shared between multiple interfaces too, or there may be constraints from
elsewhere.  I'm not sure that specifying the rates without also being
able to specify the sources is generally useful, and things that are
purely digital may not have or need an MCLK at all (CPUs don't tend to
care too much when they're in slave mode for example).

LRCLK is fixed by the sample rate so that just comes down from the
application layer.

I guess what I'm saying is that it'd be nice but it falls over far too
quickly when I start thinking about a general implementation.  I think
long term we want to move all the clocking stuff into the clock API
since otherwise you end up reimplementing that.  Right now we're a bit
stuck because the clock API isn't usefully generic yet, too many
platforms either have a custom one or don't enable the common one.

--/SXoEQDAiXmUSAYo
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.20 (GNU/Linux)

iQIcBAEBAgAGBQJRsKJvAAoJELSic+t+oim99YEP/RuZ4Yyhv0/ACRFb88btqZdy
2WyqGWwq2/LfFtvCDMKcjiRQoetpsBEIKiKwYupj3tAn0WBDMmepjdH1OjGK/2p9
XWMaBcmEeC587mmTg3exn2IItlR+quZNDbadB1ltECQFDDP56847rfWfuZcniZ2P
0RFcX3O6omypGuAmKjauQgIQC+O7lfBiuR8wtbr8KvjaNcfnRxYzVxmT1Zh7gj3C
SWpw+H7f1rs3SIyni5siNU9MiJLsj5roM+Xd+h/tVX4lf1SHALlTNkvnHnNOPNjd
mOG6sk0kiNlmROcu/Uw7vtVqaQjrRtsnOrHYD4sOOY5yDe0mfj8ZLg+W1U9OUibD
xnhHggUrQxlDzA+OowOAWSCrbkFS6fQQYCy2TwISy2G0ko4wQC/2GmJXyOunF6NB
OQvOYvF9nu4vx4/sxGMGMmqnMJzMNJ+5YnnUbKvfyuqFBGO+O2lBLEUyqCT6bBzZ
OS0B3BDCy+HhttikWD5gByiC3I3Ud4Wc+N9rZQA2M8ah+tWQj4u5XdClsmEnj40X
iuZ++TkmoAXKgqk05ixN/C1sBmJB+O4Y2tc42kcZW3FDcVo0VMSRDfJipIQzAP2G
JbdcazhA7vQWoN6XOJwlIxoK/Fx8QCnXcH6zBYLxIV6+/3nDy/HGyb3pHIrhz1nX
86ZjDeYUsgb8sG1EW9eU
=UUOD
-----END PGP SIGNATURE-----

--/SXoEQDAiXmUSAYo--

--===============2258462430218254968==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============2258462430218254968==--
