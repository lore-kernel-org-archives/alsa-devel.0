From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH v2 0/9] Add DSP topology management for SKL
Date: Sat, 19 Sep 2015 09:56:12 -0700
Message-ID: <20150919165612.GA32072@sirena.org.uk>
References: <1439832404-12424-1-git-send-email-vinod.koul@intel.com>
 <20150903081454.GU13546@localhost>
 <20150911114500.GK12027@sirena.org.uk>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0637115942384453766=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 04CAA2605D6
 for <alsa-devel@alsa-project.org>; Sun, 20 Sep 2015 02:31:52 +0200 (CEST)
In-Reply-To: <20150911114500.GK12027@sirena.org.uk>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Vinod Koul <vinod.koul@intel.com>
Cc: liam.r.girdwood@linux.intel.com, patches.audio@intel.com, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org


--===============0637115942384453766==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="k+w/mQv8wyuph6w0"
Content-Disposition: inline


--k+w/mQv8wyuph6w0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Sep 11, 2015 at 12:45:00PM +0100, Mark Brown wrote:
> On Thu, Sep 03, 2015 at 01:44:54PM +0530, Vinod Koul wrote:

> > I was wondering if you have any feedback on this series ?

> Please don't send content free pings (as I'm sure I've mentioned
> before).  I've not looked at this yet because it's another large,
> invasive patch series which you sent at the very end of the development
> cycle.

So, I've now looked at these, though not fully.  To expand on the above
a bit: these are big bits of very device specific code that's really
hard to read and understand and when I do read it I'm seeing similar
issues again and again both in terms of big picture stuff and the
trivial details (including the inconsistencies in things like commenting
style that I'm not specifically pulling up).  I'm really worried that
I'm often seeing fragments of things that may or may not work well
together.

These Intel devices not only have a lot more code than most devices do,
they also get a lot more exposure than most devices do to end users so I
actually have to try to make some effort to understand what's going on
and can't skimp on review even though I feel like I am.  I'm really
concerned about where we're heading here and how robustly the results
are going to work.

This all really slows down review, both directly in requiring detailed
checks of hard to follow the code and as a result of making almost all
other code review seem much more productive.

As well as the low level code quality issues it would really help if
rather than continually sending large blocks of functionality we were
starting from something that was a minimally viable but functional
system and then extending that.  That should be a lot easier to follow.

--k+w/mQv8wyuph6w0
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJV/ZOrAAoJECTWi3JdVIfQjrEH/1mJH2yKMXLmNprbCk9/87QT
TNCfUFBrQRPerLP34lOZPpFfhmPiBPKju4ob7RorQTTBWZoX4YM8hYBzBkHwVZWF
yut6baFVOkErghN51MQlaH7ACNTl4xvLx78qA5t9Mkw+FSjLjBjTKhLOHQ+ldL8E
9XGodrUo45TPi6xtSrqAZ7/RH2E6yJuiZbRf/PyIh5lRYs+ltIAGaLeN4xxnufWD
pK5a2Z4Axfje9fYJi5GPnvPrwvF+xMj3KGSX4cEGZ7O4HW6q6GDPe4NJDNka8asO
1EwipUP0IhNGp3xlQ1sxLcaOatxiei7LneKKOKK+5up83uO8Ke28tgjdZ4RbhP0=
=u3sw
-----END PGP SIGNATURE-----

--k+w/mQv8wyuph6w0--

--===============0637115942384453766==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============0637115942384453766==--
