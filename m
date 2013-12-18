From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH] ASoC: imx-spdif: Use module_init() to
 handle platform_device_register()
Date: Wed, 18 Dec 2013 13:04:15 +0000
Message-ID: <20131218130415.GO28455@sirena.org.uk>
References: <1387190169-7936-1-git-send-email-Guangyu.Chen@freescale.com>
 <20131216194717.GO3185@sirena.org.uk>
 <20131216211958.GS4360@n2100.arm.linux.org.uk>
 <20131216221710.GH3185@sirena.org.uk>
 <20131217103049.GA3043@MrMyself>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============3859090501278261978=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
 by alsa0.perex.cz (Postfix) with ESMTP id CE4CA261684
 for <alsa-devel@alsa-project.org>; Wed, 18 Dec 2013 14:04:20 +0100 (CET)
In-Reply-To: <20131217103049.GA3043@MrMyself>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Nicolin Chen <Guangyu.Chen@freescale.com>
Cc: tiwai@suse.de, alsa-devel@alsa-project.org, Russell King - ARM Linux <linux@arm.linux.org.uk>, lgirdwood@gmail.com
List-Id: alsa-devel@alsa-project.org


--===============3859090501278261978==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="flDc4cbvG5Y7qIjC"
Content-Disposition: inline


--flDc4cbvG5Y7qIjC
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Dec 17, 2013 at 06:31:05PM +0800, Nicolin Chen wrote:
> On Mon, Dec 16, 2013 at 10:17:10PM +0000, Mark Brown wrote:
> > I don't see registering the DAIs directly as adding complexity here;
> > it's essentially what the current code is trying to do and doesn't
> > change the normal device registration flow at all.  I do agree that the

> root@freescale ~$ rmmod snd-soc-imx-spdif
> rmmod: can't unload 'snd_soc_imx_spdif': Resource temporarily unavailable
> [...]
> It looks like registering the CODEC DAI to the pdev->dev of machine driver
> wasn't a good idea since it would lock itself up.

OK, that's the module loading bodge kicking in.  We could always remove
that since it's not that effective anyway I suppose but it's going to
make things a bit more error prone.

> Although I'll continue finding another way to register it tomorrow, I think
> it's better to make a simple report for this solution.

> And if you have any idea, please guide me.

There's still the options of either registering the dummy devices in the
core (rather than in a specific module where two modules could conflict
with each other) or registering a subdevice for the card that I
mentioned the other day.  Of those two registering in the core seems
better - it's basically the same as your current idea but means that two
card drivers that need this won't conflict with each other.

--flDc4cbvG5Y7qIjC
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJSsZ1LAAoJELSic+t+oim9/iUP/iuw0lPCirFDZNiA/ZJXC6KY
pq2GJDt+FQZErWoPTLqhkexNmSPVkwIWJqjc01y01elqHcEv2DeRugLEfMCRCVPi
NNW7fFZnJK99mxAINlS0vKgGk5kABxN7/Hy0XI5QgazNO7MJWiuw1tGKKWJyX9Hy
I/2bFUpzQ6gVxDfizdyt7ts+Uoc/Z6m+r2BCxtCioUOdjJQwJVCDxJPbSaWvsVRs
q1lwE4xYKzj7BMuGSGVsUNheXBwU2CEk/fYTQrWibUoEA/vblG4JBhIle7HfZXl/
5mJwCiUr4sMxjeXAxQk+oDwqvRK0h6DBL3iVB7gGhX4B9xEkZeugiieWqnbMrMmG
HOa0r5B1/GB+u+chkvS8hM+qHYDCVfK3amcBY13JfSxwpm1Qmk/s3JCO8gFknqbJ
czhbJIIwOC9XWF4RsTecWDkB5MChjVsU7I9rNv08ZiswpWChHF2FYbjn3a62ep6Y
N46WBem0ISPebuE6V4CFsgLu/k/acWSOHsVaB1zGQA1Blnzyvg+mFQORfd60i2/6
IfWnAVRtlMVatc+uzu4wXQazdpPvzaEDFcYxjU/v2wafRsd6Xabr20RQXXUrmRA0
mIHZAIiLMFXPu5LlUdI1IIwqkBsvDLhBJaiVkVG4qpN0cpej0GDohmg6RErTOXy4
IsWzpmRY6K1JcLIKclaK
=zf5l
-----END PGP SIGNATURE-----

--flDc4cbvG5Y7qIjC--

--===============3859090501278261978==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============3859090501278261978==--
