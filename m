From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH 3/7] ALSA: add shell for Intel HDMI LPE
	audio driver
Date: Thu, 15 Dec 2016 11:44:04 +0000
Message-ID: <20161215114404.i7svjnrg3cb3l2yq@sirena.org.uk>
References: <20161212181043.12512-1-jerome.anand@intel.com>
 <20161212181043.12512-4-jerome.anand@intel.com>
 <s5htwa6el1w.wl-tiwai@suse.de>
 <F6867404AABACB4D8EC371BF802A4B7C14934689@fmsmsx101.amr.corp.intel.com>
 <s5htwa5bg15.wl-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1853754332=="
Return-path: <intel-gfx-bounces@lists.freedesktop.org>
In-Reply-To: <s5htwa5bg15.wl-tiwai@suse.de>
List-Unsubscribe: <https://lists.freedesktop.org/mailman/options/intel-gfx>,
 <mailto:intel-gfx-request@lists.freedesktop.org?subject=unsubscribe>
List-Archive: <https://lists.freedesktop.org/archives/intel-gfx>
List-Post: <mailto:intel-gfx@lists.freedesktop.org>
List-Help: <mailto:intel-gfx-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/intel-gfx>,
 <mailto:intel-gfx-request@lists.freedesktop.org?subject=subscribe>
Errors-To: intel-gfx-bounces@lists.freedesktop.org
Sender: "Intel-gfx" <intel-gfx-bounces@lists.freedesktop.org>
To: Takashi Iwai <tiwai@suse.de>
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, "intel-gfx@lists.freedesktop.org" <intel-gfx@lists.freedesktop.org>, "Ughreja,
 Rakesh A" <rakesh.a.ughreja@intel.com>
List-Id: alsa-devel@alsa-project.org


--===============1853754332==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="z54gkboe3vrpmkbv"
Content-Disposition: inline


--z54gkboe3vrpmkbv
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Dec 15, 2016 at 12:14:30PM +0100, Takashi Iwai wrote:

> The interaction between i915 and audio is simple, yes, it just exposes
> a few things, mmio ptr, irq, etc.  But still I don't understand why
> multiple layers of indirect accesses are needed *inside* lpe audio
> driver itself.  For example, suspend/resume action is cascaded to yet
> another ops.

> I would understand if this "shell" provides a few thin accessors to
> the raw i915 registers.  But another layering over a single driver
> implementation makes little sense in regard of abstraction.  (If there
> were multiple class inherits, it's a different story, of course.)

We saw the same thing with the DSP code as well...

--z54gkboe3vrpmkbv
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCAAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlhSggQACgkQJNaLcl1U
h9BK8gf+LqOvZJmoji4ACYQqPvZT6VfLFB7Zoi4J03PZKk2rOPEcgl4G63zqLXwH
S0rRewI/bA1ZgBtW5Rope+i2EgE/gFiU0rM6hyMJInTNtWwYNvaEWD1q05RIbHT9
NhrXYxe69dfSaJS9ZNlafUKV6UwW+wrQn0dFpgQ0X2CdSj1JqyD1E3+QwkvhBdfh
oN3irKBvTsKN24td/AD7an9gs8yOmK3tpMcsEU0Jl4Cjt6YvVesUOe4G8zg3x0to
9C/tgRvV1Gr6jsGV8twBRog3a6ruV0F0vEQXHp6MRCZgdeXE3y9Pqui5TYliiIoF
x5uw0Q4MiWlxbvRgkKzW84mTukpUtw==
=WPXR
-----END PGP SIGNATURE-----

--z54gkboe3vrpmkbv--

--===============1853754332==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: inline

X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KSW50ZWwtZ2Z4
IG1haWxpbmcgbGlzdApJbnRlbC1nZnhAbGlzdHMuZnJlZWRlc2t0b3Aub3JnCmh0dHBzOi8vbGlz
dHMuZnJlZWRlc2t0b3Aub3JnL21haWxtYW4vbGlzdGluZm8vaW50ZWwtZ2Z4Cg==

--===============1853754332==--
