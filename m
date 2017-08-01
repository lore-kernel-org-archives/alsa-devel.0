From: Mark Brown <broonie@kernel.org>
Subject: Re: [alsa-devel] [PATCH v2 2/2] drm/bridge: adv7511: restrict audio
 sample sizes
Date: Tue, 1 Aug 2017 14:15:24 +0100
Message-ID: <20170801131524.zv6nfyzmzal622fl@sirena.org.uk>
References: <20170731224944.9986-1-srinivas.kandagatla@linaro.org>
 <20170731224944.9986-3-srinivas.kandagatla@linaro.org>
 <7d700845-da72-5c40-31f9-c3faa7ca93a2@st.com>
 <ce018632-0b7a-7e34-6a3d-c191155a17ae@linaro.org>
 <20170801122840.6demhukafhtpeaby@sirena.org.uk>
 <e5506e72-9788-c65d-6467-6590174f825a@linaro.org>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0275480058=="
Return-path: <dri-devel-bounces@lists.freedesktop.org>
In-Reply-To: <e5506e72-9788-c65d-6467-6590174f825a@linaro.org>
List-Unsubscribe: <https://lists.freedesktop.org/mailman/options/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=unsubscribe>
List-Archive: <https://lists.freedesktop.org/archives/dri-devel>
List-Post: <mailto:dri-devel@lists.freedesktop.org>
List-Help: <mailto:dri-devel-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=subscribe>
Errors-To: dri-devel-bounces@lists.freedesktop.org
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>
To: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Cc: alsa-devel@alsa-project.org, Liam Girdwood <lgirdwood@gmail.com>, Takashi Iwai <tiwai@suse.com>, Arnaud Pouliquen <arnaud.pouliquen@st.com>, Jyri Sarha <jsarha@ti.com>, linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org
List-Id: alsa-devel@alsa-project.org


--===============0275480058==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="mowmg6wnhl5skm5u"
Content-Disposition: inline


--mowmg6wnhl5skm5u
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Aug 01, 2017 at 01:52:35PM +0100, Srinivas Kandagatla wrote:
> On 01/08/17 13:28, Mark Brown wrote:

> > > And it's a false indication that we are supporting 32bit samples.
> > > Which am not very happy with.

> > This is what the sample_bits field in the DAI structure is for.ya.

> But still reporting that driver supports 32 bit samples when it does not
> really support all 32 bits, is kinda misleading to user.
> Isn't it?

No.  Please read what I wrote and look at what setting sample_bits does.

--mowmg6wnhl5skm5u
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCAAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlmAfusACgkQJNaLcl1U
h9DrbAf/WNzRY28s68n77qwy6ZY3i5YFS9P7GtMjnk2ZbPJLeBUrrOPeJckyiGuJ
8MkQbR4Pk/FUMjdraBaqEBKL8PH++lZQkt4RlaDAmEpx3cWwoULZo+TJgtEqYgYq
pbw7khSTlF45VUMPe8bciq8w0m0k3W9GFqM3QOpk8crbe3LbFuOlR2KGPBExLKFD
GB2NPrXk7TjUg385E/uC3a1p87LvUBn7IYWR9WWkNhYfRLewzf1ckbnoK8Ia0LDr
qvT6j6cdxOuVuwbleyC6jA0kGcUzZHxUqS89ZzQRH8f1nchL7SUB1G36BA0E1mZF
d9RqpXGzw+UmvmUZttT9Mls1/PqFcg==
=4VO9
-----END PGP SIGNATURE-----

--mowmg6wnhl5skm5u--

--===============0275480058==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: inline

X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KZHJpLWRldmVs
IG1haWxpbmcgbGlzdApkcmktZGV2ZWxAbGlzdHMuZnJlZWRlc2t0b3Aub3JnCmh0dHBzOi8vbGlz
dHMuZnJlZWRlc2t0b3Aub3JnL21haWxtYW4vbGlzdGluZm8vZHJpLWRldmVsCg==

--===============0275480058==--
