From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH 4/7] Asoc: sti: add CPU DAI driver for
	capture
Date: Mon, 27 Apr 2015 21:00:26 +0100
Message-ID: <20150427200026.GH22845@sirena.org.uk>
References: <1429018531-29025-1-git-send-email-arnaud.pouliquen@st.com>
 <1429018531-29025-5-git-send-email-arnaud.pouliquen@st.com>
 <20150424182011.GH22845@sirena.org.uk> <553E4D64.8060803@st.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============6487936898552449283=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 3A49F26051B
 for <alsa-devel@alsa-project.org>; Mon, 27 Apr 2015 22:00:34 +0200 (CEST)
In-Reply-To: <553E4D64.8060803@st.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Arnaud Pouliquen <arnaud.pouliquen@st.com>
Cc: alsa-devel@alsa-project.org, lgirdwood@gmail.com
List-Id: alsa-devel@alsa-project.org


--===============6487936898552449283==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="8eKmONcEVXn5go+y"
Content-Disposition: inline


--8eKmONcEVXn5go+y
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Apr 27, 2015 at 04:53:24PM +0200, Arnaud Pouliquen wrote:
> On 04/24/2015 08:20 PM, Mark Brown wrote:
> >On Tue, Apr 14, 2015 at 03:35:28PM +0200, Arnaud Pouliquen wrote:

> >>+const struct snd_pcm_hardware uni_reader_pcm_hw = {
> >>+	.info = (SNDRV_PCM_INFO_INTERLEAVED |
> >>+		 SNDRV_PCM_INFO_BLOCK_TRANSFER |
> >>+		 SNDRV_PCM_INFO_PAUSE),

> >The commit message says this is a CPU DAI but a snd_pcm_hardware is a
> >DMA controller.

> Do you means that i should just define a structure related to DAI
> constraints
> and fill snd_pcm_hardware in sti_platform.c?

I mean that if I'm reviewing a DAI driver I don't expect to see
definitions for a DMA controller without warning.

> >>+static inline int get_property_hdl(struct device *dev, struct device_node *np,
> >>+				   const char *prop, int idx)

> >This appears to be duplicated from the previous patch, as does a *lot*
> >of the code here.  Can we not share more of the code between playback
> >and capture paths?

> I spitted reader and player code,because it is 2 different IPs with some
> specific features and behavior
> ( clock, master/slave mode, IEC, standby ...).
> From my point of view is is more clear like this, but It is feasible to
> merge both code
> adding conditions on direction in most functions. Please tell me what you
> prefer.
> I case of merge i suppose that the best is to not define uniperif_ops struct
> but externalize functions...

That's reasonable, we just shouldn't be seeing large chunks of obvious
code duplication.

--8eKmONcEVXn5go+y
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJVPpVZAAoJECTWi3JdVIfQZjsH/0zTcpXqJH4DSWZMNXNiNDPI
nRI0MMNE2UCBrlDViwSSz7v/m3ZEFDqz0jOBXluWK39OkQp28/iZ0i2bfzR74ixo
4Fj5AbYgx143+yPC+NR2PWTi8mz9SWW5W1u/xSx5Zx3DDNOOvpDvULSo+THua0Wl
Qcxzhx4goMYut17E2DH3KC5WmxYb8ITad8DFElvGbzVnqc6igRNfzA5Kj9mCRQ13
y8x2I9tLxH/z6x77xMblb8/t9FsIUq4LVXXFCI5Ct6gdl43zLMY7a2nXH0238lQE
LPsp+WepK5TwbOAzSXbmEUK/3BSKiNsI/0vH+lrcsXb4l9988LrQ7JOF/pGUHBc=
=hiAV
-----END PGP SIGNATURE-----

--8eKmONcEVXn5go+y--

--===============6487936898552449283==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============6487936898552449283==--
