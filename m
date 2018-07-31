From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH v5 8/8] ASoC: Intel: Skylake: add option to
 control HDAudio + DSP usage
Date: Tue, 31 Jul 2018 17:20:00 +0100
Message-ID: <20180731162000.GJ5719@sirena.org.uk>
References: <20180727230554.31027-1-pierre-louis.bossart@linux.intel.com>
 <20180727230554.31027-9-pierre-louis.bossart@linux.intel.com>
 <s5hbmanr895.wl-tiwai@suse.de>
 <5f73f810-6fe5-bad9-81fb-fd587ef39e8c@linux.intel.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============4949542298590017285=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [172.104.155.198])
 by alsa0.perex.cz (Postfix) with ESMTP id 6C806267763
 for <alsa-devel@alsa-project.org>; Tue, 31 Jul 2018 18:20:02 +0200 (CEST)
In-Reply-To: <5f73f810-6fe5-bad9-81fb-fd587ef39e8c@linux.intel.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Cc: Takashi Iwai <tiwai@suse.de>, liam.r.girdwood@linux.intel.com, alsa-devel@alsa-project.org, vkoul@kernel.org
List-Id: alsa-devel@alsa-project.org


--===============4949542298590017285==
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="lYetfuAxy9ic4HK3"
Content-Disposition: inline


--lYetfuAxy9ic4HK3
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Jul 31, 2018 at 09:06:54AM -0700, Pierre-Louis Bossart wrote:
> On 7/31/18 3:48 AM, Takashi Iwai wrote:
> > Pierre-Louis Bossart wrote:

> > > +config SND_SOC_INTEL_SKYLAKE_FORCE_HDA_DSP
> > > +	bool "Force HDAudio Codec + DSP support"
> > > +	depends on SND_SOC_INTEL_SKYLAKE_HDA_DSP
> > > +	help
> > > +	  If you have a Intel Skylake+ platform with the DSP enabled in
> > > +	  the BIOS and an HDAudio codec, then enable this option by saying Y
> > > +	  This option will ignore information from the BIOS and force the use
> > > +	  of the HDaudio codec, if present.
> > > +	  This is a debug option not recommended for distros.

> > ... and this one is better to be a module option.
> > Distros tend to enable all possible options, and this may be set
> > unnecessarily.  If any, this kconfig should be only toggling the
> > default option value.

> Sorry, I don't get this one. this wouldn't change anything between built-in
> or module, it's just a yes/no answer to ignore ACPI stuff. the default is
> also no and there is a clear statement not to include it except for debug.
> We have a similar option for SOF to bypass all ACPI information and go
> straight to 'nocodec' mode.

Debug options like these are really a lot more useful as something
runtime selectable with something like a module parameter as Takashi
suggests - an innatentive distro maintainer could easily enable it by
mistake when going through a bunch of new options in a new kernel
release and if someone needs it for debugging purposes in a distro
context it's a real pain to have to rebuild the kernel.

It's also a bit confusing as the config text says:

> > > +	  If you have a Intel Skylake+ platform with the DSP enabled in
> > > +	  the BIOS and an HDAudio codec, then enable this option by saying Y

which sounds like people should turn it on, the bit about it being a
debug option is quite deep in the text.

--lYetfuAxy9ic4HK3
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAltgjC8ACgkQJNaLcl1U
h9C6hwf/ZR9CAKMqVnNHWMPq9HJP+qLZ5JaEb+fgOIaA3Yz/5MGPJ2yrbEw66dvO
OozDOb3hcidhk72Kdu++/Kj8yqW9TGj3WXF3crZcGjWQ6LRm9vvgzCnRAjghpr53
uzBUKix6QJdh4eWuXenqzJgiwomIcJjJ8FHoZnvSVal8Q/mRF8w5DjtQy2xkRs3W
uVwyWiYAEx5ITiLdvt32u/1mBowHxkGK98T/h2iBh47cZ58pQxKC3LYEBejnzC/v
3ilPxzIDVbi+xtQg5kwgNdUiHSSrOdLwIlFXN3yUi+QHDVhiENWLCJ6+rEA1LvXg
C/mDV3A30zOKYY1Ghzpb5G7RRFaHkA==
=tkxv
-----END PGP SIGNATURE-----

--lYetfuAxy9ic4HK3--

--===============4949542298590017285==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============4949542298590017285==--
