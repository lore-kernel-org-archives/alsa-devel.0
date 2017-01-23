From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH v4 1/3] DRM: add help to get ELD speaker allocation
Date: Mon, 23 Jan 2017 11:41:28 +0000
Message-ID: <20170123114128.hafyzv2sfa5tueu2@sirena.org.uk>
References: <1483458772-13658-1-git-send-email-arnaud.pouliquen@st.com>
 <1483458772-13658-2-git-send-email-arnaud.pouliquen@st.com>
 <20170117191902.zugqcnb4osxmcgaj@sirena.org.uk>
 <87bmv5wheq.fsf@eliezer.anholt.net>
 <20170119102901.h35ynrcztf5z7vb3@sirena.org.uk>
 <20170123074911.aofyd3mdy6bwyu4m@phenom.ffwll.local>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1917989558=="
Return-path: <dri-devel-bounces@lists.freedesktop.org>
In-Reply-To: <20170123074911.aofyd3mdy6bwyu4m@phenom.ffwll.local>
List-Unsubscribe: <https://lists.freedesktop.org/mailman/options/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=unsubscribe>
List-Archive: <https://lists.freedesktop.org/archives/dri-devel>
List-Post: <mailto:dri-devel@lists.freedesktop.org>
List-Help: <mailto:dri-devel-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=subscribe>
Errors-To: dri-devel-bounces@lists.freedesktop.org
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>
To: Daniel Vetter <daniel@ffwll.ch>
Cc: alsa-devel@alsa-project.org, Jani Nikula <jani.nikula@intel.com>, Arnaud Pouliquen <arnaud.pouliquen@st.com>, lgirdwood@gmail.com, dri-devel@lists.freedesktop.org, Jyri Sarha <jsarha@ti.com>
List-Id: alsa-devel@alsa-project.org


--===============1917989558==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="c5t765rebzop3syn"
Content-Disposition: inline


--c5t765rebzop3syn
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Jan 23, 2017 at 08:49:11AM +0100, Daniel Vetter wrote:
> On Thu, Jan 19, 2017 at 10:29:01AM +0000, Mark Brown wrote:

> > I see.  For most subsystems you need to actually copy a human to make
> > sure that things are seen - just the list isn't enough.  In terms of it
> > being reviewed one of the problems with DRM not listing the reviwers in
> > the MAINTAINERS file or anything is that it's very hard for anyone to
> > tell if something is considered a good enough review or if it's just a
> > review from someone who happens to contribute to DRM sometimes.

> Jani is now officially listed as drm-misc maintainer in MAINTAINERS. We
> also have official entries for other major areas (like bridge drivers or
> similar). Where do you see a gap?

> Note that before KS this was indeed not there, because of the committer
> model hanging in the air a bit ...

This bit also wasn't there when the series started grinding on IIRC.  It
does look clear enough now though, thanks.

--c5t765rebzop3syn
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCAAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAliF6+cACgkQJNaLcl1U
h9Cm0Qf9EHqVguYnL6SojVGOw2nEdDAFDpbx0j0nTM4HL7XMXW3qanV61F3phqMs
7He4D6OyDRVjFYB+CkFpFNyJiSN5lR8PU7u/dd16er3NOJOyBwgKUc9RqaX0oGXF
yjevtLyKcx1OuhSXcf1V6M4J1u5vig5+g2+zuZkN88mEH2fg7H/9z0QvxSK6hxpp
HvpCs36GZWo4ZPaEgJB110C9pQqTDwABY3/wKVLS3TDnaFAlvX7x9/P1LRpeBVX3
2BFpJmJaJRXQefyojeuaUZd6o+HT6KdjzjFSmtCbwYCXsv8nwb3OEgN7f/Q2E86j
1vGKCxFVL5XuOTE8sPcMUiHCBalawA==
=zAxn
-----END PGP SIGNATURE-----

--c5t765rebzop3syn--

--===============1917989558==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: inline

X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KZHJpLWRldmVs
IG1haWxpbmcgbGlzdApkcmktZGV2ZWxAbGlzdHMuZnJlZWRlc2t0b3Aub3JnCmh0dHBzOi8vbGlz
dHMuZnJlZWRlc2t0b3Aub3JnL21haWxtYW4vbGlzdGluZm8vZHJpLWRldmVsCg==

--===============1917989558==--
