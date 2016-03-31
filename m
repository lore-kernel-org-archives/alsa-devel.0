From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH 2/3 v2] ASoC: dwc: Add I2S HDMI audio support
Date: Thu, 31 Mar 2016 09:56:42 -0700
Message-ID: <20160331165642.GG2350@sirena.org.uk>
References: <cover.1459174494.git.joabreu@synopsys.com>
 <538be366488bf0d7633d702f2d0bab16707b7a47.1459174494.git.joabreu@synopsys.com>
 <20160329173158.GB2350@sirena.org.uk>
 <56FAC355.1040705@synopsys.com>
 <20160329182222.GC2350@sirena.org.uk>
 <56FCEFD0.8090509@synopsys.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1138398617=="
Return-path: <dri-devel-bounces@lists.freedesktop.org>
In-Reply-To: <56FCEFD0.8090509@synopsys.com>
List-Unsubscribe: <https://lists.freedesktop.org/mailman/options/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=unsubscribe>
List-Archive: <https://lists.freedesktop.org/archives/dri-devel>
List-Post: <mailto:dri-devel@lists.freedesktop.org>
List-Help: <mailto:dri-devel-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=subscribe>
Errors-To: dri-devel-bounces@lists.freedesktop.org
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>
To: Jose Abreu <Jose.Abreu@synopsys.com>
Cc: tixy@linaro.org, mark.rutland@arm.com, alsa-devel@alsa-project.org, lgirdwood@gmail.com, Alexey.Brodkin@synopsys.com, dri-devel@lists.freedesktop.org, tiwai@suse.com, yitian.bu@tangramtek.com, wsa+renesas@sang-engineering.com, laurent.pinchart+renesas@ideasonboard.com, nariman@opensource.wolfsonmicro.com, linux-snps-arc@lists.infradead.org, devicetree@vger.kernel.org, Maruthi.Bayyavarapu@amd.com, pawel.moll@arm.com, ijc+devicetree@hellion.org.uk, Vineet.Gupta1@synopsys.com, buyitian@gmail.com, robh+dt@kernel.org, perex@perex.cz, linux-kernel@vger.kernel.org, CARLOS.PALMINHA@synopsys.com, galak@codeaurora.org, alexander.deucher@amd.com
List-Id: alsa-devel@alsa-project.org


--===============1138398617==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="piopQj3F5GMtthHx"
Content-Disposition: inline


--piopQj3F5GMtthHx
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Mar 31, 2016 at 10:37:20AM +0100, Jose Abreu wrote:
> On 29-03-2016 19:22, Mark Brown wrote:

> > If you want to add a new platform driver you need to add a new platform
> > driver, not shove the code into an existing driver for a seperate IP.

> I can separate the platform driver into a new file but they will have to be
> compiled into the same module as the new additions to the i2s driver depend on
> functions of the platform driver (see i2s_irq_handler()). Or should I divide

No, that's not at all acceptable.  The Designware IP is not specific to
your system, you can't make it depend on your platform driver.  The
kernel needs to work on other people's systems too.  You need to work
through and/or extend the abstractions the framework provides to
separate the drivers for different IPs.

> this into two modules and add a Kconfig option to the platform driver? Besides
> this I first wanted the driver to be compiled into the same module so that it is
> compatible with kernel 3.18 where simple audio card requires that platform
> driver == cpu driver.

That's not OK upstream, we're working on the current kernel not on
random old kernels.  We don't carry compatibility code to enable current
kernel code to be run on years old kernels.

--piopQj3F5GMtthHx
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJW/VbJAAoJECTWi3JdVIfQneAH/j6fiMmUYVuswFhQ5h3V1ezC
VW61HfhEQVmAoYEw3lxArepUlIODE6UFzt8sz+J/kTAGTAromOvN58NkIn0+sQxB
jp6CmzC4ohEC4/5fziwPBHjbzFkQ7mbjiiHDJBonMG4IylBrKRpRrHTWYFM4SUOV
GnCAbAGj/zU39vxsZpAw9Nmar4rkpohHbJUC6C6fRoEDY5iZ+D8EcCSIZLHRlEC5
fZBDh9VVicBk5xykQH2uFBowoBV6jfU8HHRUeeu4/Q7kirk2YAePQFoY/qw1lXfK
7XcGl9ZhhduIJd2bCKZuG5ribrE68mel2QNaT1QtEJPFzpcVGun2BYPYRJBLLEo=
=Wf6v
-----END PGP SIGNATURE-----

--piopQj3F5GMtthHx--

--===============1138398617==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: inline

X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KZHJpLWRldmVs
IG1haWxpbmcgbGlzdApkcmktZGV2ZWxAbGlzdHMuZnJlZWRlc2t0b3Aub3JnCmh0dHBzOi8vbGlz
dHMuZnJlZWRlc2t0b3Aub3JnL21haWxtYW4vbGlzdGluZm8vZHJpLWRldmVsCg==

--===============1138398617==--
