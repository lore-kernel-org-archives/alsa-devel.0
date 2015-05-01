From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH 1/3] ALSA: hda: add hdac_adsp_enable module
 flag
Date: Fri, 1 May 2015 12:13:42 +0100
Message-ID: <20150501111342.GW22845@sirena.org.uk>
References: <1430405556-19166-1-git-send-email-vinod.koul@intel.com>
 <5542520B.8080606@linux.intel.com>
 <20150430192726.GD22845@sirena.org.uk>
 <s5hmw1pjqhm.wl-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0364470483541651204=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id B57C326148F
 for <alsa-devel@alsa-project.org>; Fri,  1 May 2015 13:13:49 +0200 (CEST)
In-Reply-To: <s5hmw1pjqhm.wl-tiwai@suse.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Takashi Iwai <tiwai@suse.de>
Cc: Vinod Koul <vinod.koul@intel.com>, liam.r.girdwood@linux.intel.com, alsa-devel@alsa-project.org, Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>, patches.audio@intel.com
List-Id: alsa-devel@alsa-project.org


--===============0364470483541651204==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="toYHFsT/q0JsofY9"
Content-Disposition: inline


--toYHFsT/q0JsofY9
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Apr 30, 2015 at 10:44:21PM +0200, Takashi Iwai wrote:
> Mark Brown wrote:
> > On Thu, Apr 30, 2015 at 11:02:19AM -0500, Pierre-Louis Bossart wrote:
j
> > > This choice is contingent on the BIOS options, you can't enable the DSP if
> > > the BIOS said no DSP...

> > Presumably this flag should be coming from the BIOS by default and this
> > providing a disable only setting for test/development?

> It's hard to know exactly how many models will be with DSP and how
> many without...  The problem we're dealing with is that we'll have two
> individual drivers supporting the very same PCI ID.  And, there is no
> good mechanism to prioritize the driver load on Linux, so far.

Well, I'm a bit confused why we're loading separate drivers at all here.
Shouldn't we be loading one driver and then figuring out what to do with
the hardware based on something like DMI matching (you'd hope that there
would be some config readback from the firmware but recent performance
suggests not)?

> So, this is the consequence after lengthy discussions: it's fairly
> simple but effective enough.  Distros may build both drivers, but
> which driver to use can be decided by this option.  The default value
> of this switch should be set via a Kconfig, but it can be overridden
> dynamically via either a static module option or boot option.

I don't understand how it's going to work well for users, especially
distros where you're building something to be installed on a wide range
of hardware, and it doesn't seem idiomatic.

--toYHFsT/q0JsofY9
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJVQ1/mAAoJECTWi3JdVIfQRPoH/0vdre4RDjm0gCWuLuXgKigv
DDm3naWF26sLM35YQl6wGbWOiaTNVR3TqqRenxbjnQ+YqTv9CG99MJCyoYR7gFQy
P+IQwA9oybQ69qN+KDHnWQHzHRQSAO71A0iJVRI85jBO1Ijuv3n0DCkpWG8G8GxM
v2E8z7tBl51Xn9Te8r9ORzw7tflZaOjUqm2SHL/zzM0qXhf7W8E2aSMpW+Sty8Y1
sqYi0n9HJoklz1wKSia6WBQk2ehfcDzo87qj1CorRUm9B5L7BUrGEMdixYuupxHV
k/5mogHCKHPZIrueglURX1aYjEQWlB8+pReu4QjEUeDN39JnNhHDC3u3uMpvr8k=
=SD/7
-----END PGP SIGNATURE-----

--toYHFsT/q0JsofY9--

--===============0364470483541651204==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============0364470483541651204==--
