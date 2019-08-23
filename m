From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH 00/35] ASoC: Intel: Clenaup SST
 initialization
Date: Fri, 23 Aug 2019 11:26:52 +0100
Message-ID: <20190823102652.GM23391@sirena.co.uk>
References: <20190822190425.23001-1-cezary.rojewski@intel.com>
 <a08b2547-3fe5-5c48-9513-c5ade151c01e@linux.intel.com>
 <50932a9f-2f3e-c150-77c7-f021f84ed4d1@intel.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============6552782008493652638=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [IPv6:2a01:7e01::f03c:91ff:fed4:a3b6])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id AD291F80147
 for <alsa-devel@alsa-project.org>; Fri, 23 Aug 2019 12:26:59 +0200 (CEST)
In-Reply-To: <50932a9f-2f3e-c150-77c7-f021f84ed4d1@intel.com>
List-Unsubscribe: <https://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <https://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: "Alsa-devel" <alsa-devel-bounces@alsa-project.org>
To: Cezary Rojewski <cezary.rojewski@intel.com>
Cc: alsa-devel@alsa-project.org, "Kaczmarski,
 Filip" <filip.kaczmarski@intel.com>, lgirdwood@gmail.com, tiwai@suse.com, Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>, "Wasko,
 Michal" <michal.wasko@intel.com>
List-Id: alsa-devel@alsa-project.org


--===============6552782008493652638==
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="X0cz4bGbQuRbxrVl"
Content-Disposition: inline


--X0cz4bGbQuRbxrVl
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Aug 23, 2019 at 10:29:59AM +0200, Cezary Rojewski wrote:
> On 2019-08-22 22:55, Pierre-Louis Bossart wrote:
> > On 8/22/19 2:03 PM, Cezary Rojewski wrote:

> > > Code seen here is part of new Skylake fundament, located at the very
> > > bottom of internal mainline. Said mainline is tested constantly on at
> > > least sigle platform from every cAVS bucket (description below). This
> > > week, BDW has been added to the CI family and was essential in
> > > validating legacy changes. Baytrail platform is still missing. Changes
> > > for BYT directly mirror HSW/ BDW but due to current lack of platform
> > > were untested.
> > > Boards engaged in testing: rt286, rt298, rt274.

> > this is not enough, sorry. these are RVPs and you need to check with
> > commercial devices supported in sound/soc/intel/boards/.

> What machine board has to do with FW and host side? If it has, we better
> notify the owner so he can fix codec's code at once. All boards MUST follow
> recommended protocol whether its HDA or I2S in communicating with /skylake.
> This is hardware IP we taking about. I could as well test all platforms with
> AudioPrecision and say: shipit.

...

> DSP "commercial devices" with 99% of home audio being routed through
> HD-Audio legacy? I do contact representatives of "commercial devices" daily,
> you of all should be aware of fact that in almost all cases they are fed
> neither with upstream code nor upstream binaries.
> For the first time since eons sound/soc/intel/skylake code is tested before
> upstreaming, yet you still defend the mistakes of the past?

System vendors don't really matter here, end users with their
desktops and laptops do.  If a user has a system and they for
whatever reason upgrade their kernel from one upstream version to
another and don't touch any other aspect of their system the
expectation is that they'll still have everything working after
the upgrade.  This means that if there's bugs in how things were
deployed in the past the kernel ought to try to work with those
bugs.

> > > Some upstream FW binaries are not compatible with existing /skylake
> > > driver while changes found here (HARDWARE_CONFIG/ FIRMWARE_CONFIG) make
> > > use of firmware ability to offload hardware-specifics away from driver.
> > > These and more are core part of any cAVS design and are to be
> > > implemented and used by host. This too is missing on Linux upstream.

This sounds like it might be a problem.

> > > SKL FW binary existing on upstream is a descendant of old spt branch,
> > > obsoleted for 4-5 years now. That FW is a stub, quickly replaced by
> > > kbl which is to be used on all 1.5 cAVS platforms.

That's well within the lifespan people will expect from a PC
these days, my personal systems are mostly older than that and
do fine at most things except for big builds.

> If I could, I'd rather prefer the "detect and notify" as it is impossible to
> repair all the mistakes made in /sound/soc/intel/skylake.

Do we have a sense of how many such systems exist?

> However, in practice there isn't any reliable way to verify the actual
> usability of old FW binary against host site as the interface is volatile
> and numbers alone don't mean much.
> Patch with FW binaries would not remove old ones, simply add new versions to
> the directory.

Can you do things the other way around and positively identify
firmwares that meet whatever standards you're interested in here?

--X0cz4bGbQuRbxrVl
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAl1fv2wACgkQJNaLcl1U
h9A9PAf8Df0A349QwYzmhU7p4VYNJzYszku8tmPxdB/ZbMQQgwt70axQWVWZhjz1
GMxwvNbzkOYybQ49OohRrxZC/rseZOUaI0cMb9CoI4tZQlB0H0+nHVgT/Ej9EwKR
wjaMNfttPE2eL8nEKPiiRnxxFVgQyypSNumKz+d6jxpDQ0qriPzGtEadeY+mTTcu
g8hh260JQ+Lnkh4/5N03a9uHVwCgHnrkDS/jvWeE+jeAAYN0Zg6tRd4WCY3TCfoZ
xFSLvnm5soCVmOFtIkcl2cPiB5pREPP9LKj+cCCB7fQl3gYSdybrouQKO30SebfB
hTbBY9buJFlu6LmkPrMNPw7AqIsqhw==
=361s
-----END PGP SIGNATURE-----

--X0cz4bGbQuRbxrVl--

--===============6552782008493652638==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============6552782008493652638==--
