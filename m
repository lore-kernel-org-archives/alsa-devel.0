From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH] ASoC: amd: fix report accurate hw_ptr during dma
Date: Wed, 8 Nov 2017 20:47:13 +0000
Message-ID: <20171108204713.qdhitul5mqrpwd2s@sirena.co.uk>
References: <20171108181841.29332-1-alexander.deucher@amd.com>
 <20171108182214.bwdvt5wwwz7wqf32@sirena.co.uk>
 <CADnq5_PM=C9OjseqvV8M5ohm7Mo18foHGPUkFZSnVNpVruut8Q@mail.gmail.com>
 <20171108184752.wff6qn6ssguaegkq@sirena.co.uk>
 <BN6PR12MB1652F8671D062FDE91D42951F7560@BN6PR12MB1652.namprd12.prod.outlook.com>
 <CABXOdTf=nEu_KAnAvT0p9tn96xiGGSqYzW1o0XUBDf9EHb+CoA@mail.gmail.com>
 <CADnq5_M8y44hapOkPoapGP-WRP=a-6zc3s-A_3Fv85ssPRFFEQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1410243974=="
Return-path: <dri-devel-bounces@lists.freedesktop.org>
In-Reply-To: <CADnq5_M8y44hapOkPoapGP-WRP=a-6zc3s-A_3Fv85ssPRFFEQ@mail.gmail.com>
List-Unsubscribe: <https://lists.freedesktop.org/mailman/options/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=unsubscribe>
List-Archive: <https://lists.freedesktop.org/archives/dri-devel>
List-Post: <mailto:dri-devel@lists.freedesktop.org>
List-Help: <mailto:dri-devel-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=subscribe>
Errors-To: dri-devel-bounces@lists.freedesktop.org
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>
To: Alex Deucher <alexdeucher@gmail.com>
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, Guenter Roeck <groeck@google.com>, Liam Girdwood <lgirdwood@gmail.com>, Maling list - DRI developers <dri-devel@lists.freedesktop.org>, Guenter Roeck <groeck@chromium.org>, amd-gfx list <amd-gfx@lists.freedesktop.org>, "Mukunda,
 Vijendar" <Vijendar.Mukunda@amd.com>, "Deucher,
 Alexander" <Alexander.Deucher@amd.com>
List-Id: alsa-devel@alsa-project.org


--===============1410243974==
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="ky7vv6dlbhpnafiu"
Content-Disposition: inline


--ky7vv6dlbhpnafiu
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Nov 08, 2017 at 02:35:05PM -0500, Alex Deucher wrote:
> On Wed, Nov 8, 2017 at 2:30 PM, Guenter Roeck <groeck@google.com> wrote:
> > On Wed, Nov 8, 2017 at 11:18 AM, Deucher, Alexander

> >> > Is this different to "ASoC: amd: Report accurate hw_ptr during dma"
> >> > which was applied at 16:07?

> >> Yes, this is a fix for that patch.  It fixes a 64 bit division that wasn't
> >> properly handled.

Ugh.  Two problems here.  One is obviously that there's a patch that was
sent out only a couple of days ago with a whole bunch of tags about
internal testing and review and now you've found issues with it.  That's
worrying.

The other is that you really, really need to get more on top of upstream
process.  There have been constant problems with this driver and they
feel like they're getting worse not better, with the original send of
this the noise in the subject lines and body of the e-mail means that
what you're sending looks like a case of git send-email CCing people in
accidentally rather than a deliberate upstream submission.

The constant problems mean that even as I open the e-mail I'm expecting
to have to push back on something which isn't great and affects the way
I review things.

> > In that case, the subject should reflect the problem fixed, the description
> > should describe the problem, and there should be a Fixes: tag pointing to
> > the problematic patch.

> I updated the patch subject and added a fixes tag when I resent it
> after removing the chrome tags.  The subject could have been bit
> better, but I wasn't sure how far to take it since it wasn't my patch
> originally.

If you're concerned about rewriting commit logs just add a note saying
that you did so in the commit log.  Please resend normally.

--ky7vv6dlbhpnafiu
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAloDbVAACgkQJNaLcl1U
h9Doegf8CB+uCHQVAaJUfPxJ/vJii0SbdKil6jFZdkc8FaJkxqTvBbqtCYBG1oBb
+DNBEQ7oN+k6LoZbicAbYEMCYUX4sAol8DoUYy4rCKspnvuOWK52cIEC42PzTfE0
FfBMHHiptxefRG9YG3lIK3zPvif4HmRPgjw2ri1KNSulz2+0TYf3jGMR3kH32Xsl
XYJyymFeEiqUyWxEVW5qEt36ElIPrntj18eZERG0s3Uj8BKAbXH4w7glNTIdD9Lg
ccbsxwlxTkl3DXvXJWE3H1ECc/bekuu3hgFJXLCDWERhaBGY0WgntXZr+Cag2eM5
WMSR9M2HA1MZUv5bEGoBrZyd18l3GA==
=5g8S
-----END PGP SIGNATURE-----

--ky7vv6dlbhpnafiu--

--===============1410243974==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: inline

X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KZHJpLWRldmVs
IG1haWxpbmcgbGlzdApkcmktZGV2ZWxAbGlzdHMuZnJlZWRlc2t0b3Aub3JnCmh0dHBzOi8vbGlz
dHMuZnJlZWRlc2t0b3Aub3JnL21haWxtYW4vbGlzdGluZm8vZHJpLWRldmVsCg==

--===============1410243974==--
