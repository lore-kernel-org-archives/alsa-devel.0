From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH] ASoC: amd: fix report accurate hw_ptr during dma
Date: Wed, 8 Nov 2017 19:49:48 +0000
Message-ID: <20171108194948.bq46lwurlzf45tzm@sirena.co.uk>
References: <20171108181841.29332-1-alexander.deucher@amd.com>
 <20171108182214.bwdvt5wwwz7wqf32@sirena.co.uk>
 <CADnq5_PM=C9OjseqvV8M5ohm7Mo18foHGPUkFZSnVNpVruut8Q@mail.gmail.com>
 <20171108184752.wff6qn6ssguaegkq@sirena.co.uk>
 <CABXOdTd6ptUM3E0V6B_hg9unh+na_XHK6AbyfREx5WiYwdckkA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0733822862=="
Return-path: <dri-devel-bounces@lists.freedesktop.org>
In-Reply-To: <CABXOdTd6ptUM3E0V6B_hg9unh+na_XHK6AbyfREx5WiYwdckkA@mail.gmail.com>
List-Unsubscribe: <https://lists.freedesktop.org/mailman/options/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=unsubscribe>
List-Archive: <https://lists.freedesktop.org/archives/dri-devel>
List-Post: <mailto:dri-devel@lists.freedesktop.org>
List-Help: <mailto:dri-devel-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=subscribe>
Errors-To: dri-devel-bounces@lists.freedesktop.org
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>
To: Guenter Roeck <groeck@google.com>
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, Liam Girdwood <lgirdwood@gmail.com>, Maling list - DRI developers <dri-devel@lists.freedesktop.org>, Guenter Roeck <groeck@chromium.org>, amd-gfx list <amd-gfx@lists.freedesktop.org>, Vijendar Mukunda <Vijendar.Mukunda@amd.com>, Alex Deucher <alexander.deucher@amd.com>
List-Id: alsa-devel@alsa-project.org


--===============0733822862==
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="hv3dquwuhp3yl4gr"
Content-Disposition: inline


--hv3dquwuhp3yl4gr
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Nov 08, 2017 at 11:13:50AM -0800, Guenter Roeck wrote:
> On Wed, Nov 8, 2017 at 10:47 AM, Mark Brown <broonie@kernel.org> wrote:

> > Is this different to "ASoC: amd: Report accurate hw_ptr during dma"
> > which was applied at 16:07?

> I suspect we may be getting hit by chromeos-isms again. In Chrome OS, we
> don't use Fixes: tags but "FIXUP: <original description>" in the subject
> (not that I like it, but it is what it is).

So it probably is the same patch that was just resent with a slightly
modified subject line?  That's what it looked like initially.

--hv3dquwuhp3yl4gr
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAloDX9sACgkQJNaLcl1U
h9C1twf/eb++fbK0W3tZug0uaJOXVhxZzeUlECLoiNvR4+SsbGCLLe7o678y7NfE
7rsSJYWNqDzzYS1xzM6iTOom1QB44Hha8r6kkzR/KZjEYQplFFPFfeLOQTqmIolR
GQyKTf3+dcUDwLaFNGA/uLko8fYutE49ga/FeBgH67bok++Oe54buon74pWVyZoh
XuuSbNkpda8ZL97ZTHM4LE75WRVrnAn0FaXIw/WkMYjQEQsl8yQBi5CHUUb5uyWZ
3OJAkJ+OYScTnHqnts9Ldz2eakW6TQvlyiPKCE0eK96diEeDpG8IhYZzOGsCdqIJ
sumdmstGvho96MSXHR9NIoGBledf+w==
=HJX6
-----END PGP SIGNATURE-----

--hv3dquwuhp3yl4gr--

--===============0733822862==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: inline

X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KZHJpLWRldmVs
IG1haWxpbmcgbGlzdApkcmktZGV2ZWxAbGlzdHMuZnJlZWRlc2t0b3Aub3JnCmh0dHBzOi8vbGlz
dHMuZnJlZWRlc2t0b3Aub3JnL21haWxtYW4vbGlzdGluZm8vZHJpLWRldmVsCg==

--===============0733822862==--
