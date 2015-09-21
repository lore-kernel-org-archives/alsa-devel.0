From: Vinod Koul <vinod.koul@intel.com>
Subject: Re: [PATCH v2 0/9] Add DSP topology management for SKL
Date: Mon, 21 Sep 2015 09:27:39 +0530
Message-ID: <20150921035739.GH2381@localhost>
References: <1439832404-12424-1-git-send-email-vinod.koul@intel.com>
 <20150903081454.GU13546@localhost>
 <20150911114500.GK12027@sirena.org.uk>
 <20150919165612.GA32072@sirena.org.uk>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============2729509326136622121=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
 by alsa0.perex.cz (Postfix) with ESMTP id ED1B3260537
 for <alsa-devel@alsa-project.org>; Mon, 21 Sep 2015 05:55:10 +0200 (CEST)
In-Reply-To: <20150919165612.GA32072@sirena.org.uk>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@kernel.org>
Cc: liam.r.girdwood@linux.intel.com, patches.audio@intel.com, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org


--===============2729509326136622121==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="3oCie2+XPXTnK5a5"
Content-Disposition: inline


--3oCie2+XPXTnK5a5
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, Sep 19, 2015 at 09:56:12AM -0700, Mark Brown wrote:
> On Fri, Sep 11, 2015 at 12:45:00PM +0100, Mark Brown wrote:
> > On Thu, Sep 03, 2015 at 01:44:54PM +0530, Vinod Koul wrote:
>=20
> > > I was wondering if you have any feedback on this series ?
>=20
> > Please don't send content free pings (as I'm sure I've mentioned
> > before).  I've not looked at this yet because it's another large,
> > invasive patch series which you sent at the very end of the development
> > cycle.
>=20
> So, I've now looked at these, though not fully.  To expand on the above
> a bit: these are big bits of very device specific code that's really
> hard to read and understand and when I do read it I'm seeing similar
> issues again and again both in terms of big picture stuff and the
> trivial details (including the inconsistencies in things like commenting
> style that I'm not specifically pulling up).  I'm really worried that
> I'm often seeing fragments of things that may or may not work well
> together.
>=20
> These Intel devices not only have a lot more code than most devices do,
> they also get a lot more exposure than most devices do to end users so I
> actually have to try to make some effort to understand what's going on
> and can't skimp on review even though I feel like I am.  I'm really
> concerned about where we're heading here and how robustly the results
> are going to work.
>=20
> This all really slows down review, both directly in requiring detailed
> checks of hard to follow the code and as a result of making almost all
> other code review seem much more productive.
>=20
> As well as the low level code quality issues it would really help if
> rather than continually sending large blocks of functionality we were
> starting from something that was a minimally viable but functional
> system and then extending that.  That should be a lot easier to follow.

Thanks Mark for the review,

I wouldn't have pinged but had been more than few weeks so was wondering if
this got missed. I did realise you were travelling and merge window came
up, but still thought Mark's typical turnaound is 1-2 weeks so was expecting
something. I do understand this take time but no harm in checking if it is
beyond usual window one expects.

Now on the code due to inherent nature of HW (we have HDA + DSP + I2S!!!)
and SW scalability, we do need lots of code for basic audio.
Btw  _this_ patch series is the last one to get basic minimal audio out of =
SKL.
After this we will add machine and then features...

We did decide to use DPCM, DAPM and topology here to solve manging the DSP
using these frameworks. yes hard coding a simple mixer and two pipes could
have made code look easy to follow but then we would be redoing those bits
as we scale these to defferent designs.

And to provide what we are trying here I have attached the SKL Topology conf
file to give a picture of topology we are trying to build as a reference.

On code issues, I will fix the style and wrappers issues you raised and
other instances where this might be required.

Also where you feel something is missing please do ask. Sometimes things are
perceived intuitive for us as we are doing this for quire some time but
may not be so for fresh eyes :)

Thanks
--=20
~Vinod

--3oCie2+XPXTnK5a5
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIbBAEBAgAGBQJV/4AzAAoJEHwUBw8lI4NHKrEP9ihy9nIrH6WCx7hoZ4NQoMLL
WJQ43iswKer4GlusxsUDrMq8IJ9GLFHSfMacrNx3yrLH9mLxASHZRRuSgmnl9oXB
SW4HdgZecT5VcBUVGueMAIKwTXV9xWn5G0IIL267RPzlsk+LTUlV+i2D4RvUZk6R
HtcpVrXVypZEkDqbKQRTg+KCN1QoQMQsqQj0JdGYccqjTKRnLPjxfiOKFHAw5+Jq
Hevlyb9j9qw6CuyUuk3ta+Lh4ZGEJg+muiXhw0LT3WPvyoHFqwSbBJ18onzF5r3B
EuAoSuunJddC0Kob2LU7y8aLmm2PDVG9Hrg1Bc80AFSzoeMqQGNOn1dgET7iQJI4
mNUVqSpWe7SsfhCWh+pTFdjPv7U/if69MA94q4VaQsn9bkfBQ9H4X/deaczzF9h4
ZyDhlDDmVMnCsURga+dh23EY+yqXfmn4j864+QU1T+BaMkUlhJF2qLXbg9hAGCms
jOnestrOMVSZ0NGXsbOLYU4hGxwLhlNaWL6aXN7/1FqCBNnQrOcinWQHQr6i/aHU
O+eiDXzrB5reIBbqNl2NKrTebEZF7Dt3VmglJbcxLatom30djoOGQJojOHOBGP4F
E0tPZylDFdmZMT3lMZCQvX3G+XQOg50gIONcT6R2lckiJFqu97KCAy+gFaxog3rR
ATVRC5lFV54YiRxhQA4=
=nM0V
-----END PGP SIGNATURE-----

--3oCie2+XPXTnK5a5--

--===============2729509326136622121==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============2729509326136622121==--
