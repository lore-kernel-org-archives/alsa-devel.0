From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH v3 01/25] dt-bindings: soc: qcom: Add
	bindings for APR bus
Date: Thu, 1 Mar 2018 20:34:13 +0000
Message-ID: <20180301203413.GN12864@sirena.org.uk>
References: <20180213165837.1620-1-srinivas.kandagatla@linaro.org>
 <20180213165837.1620-2-srinivas.kandagatla@linaro.org>
 <20180213231244.ama4bwsehzuh5sr7@rob-hp-laptop>
 <ae65a9c8-85a3-5494-f4cc-1038fd8c9bd1@linaro.org>
 <20180218230414.dkd6kb6kd35arcyv@rob-hp-laptop>
 <636d4ac2-3bc2-7290-1645-0451c089cb8a@linaro.org>
 <CAL_JsqK3KFBGqpHRaURSrHew1HhObUvFYxuhND-FOQ4tCUaAHg@mail.gmail.com>
 <465a2ca7-9f74-8977-37ea-29fe3944c27c@linaro.org>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============7602579530052523267=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [172.104.155.198])
 by alsa0.perex.cz (Postfix) with ESMTP id AB36F267C0B
 for <alsa-devel@alsa-project.org>; Thu,  1 Mar 2018 21:34:16 +0100 (CET)
In-Reply-To: <465a2ca7-9f74-8977-37ea-29fe3944c27c@linaro.org>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Cc: Mark Rutland <mark.rutland@arm.com>, Rob Herring <robh@kernel.org>, Linux-ALSA <alsa-devel@alsa-project.org>, Banajit Goswami <bgoswami@codeaurora.org>, rohkumar@qti.qualcomm.com, devicetree@vger.kernel.org, linux-arm-msm <linux-arm-msm@vger.kernel.org>, Patrick Lai <plai@codeaurora.org>, Takashi Iwai <tiwai@suse.com>, Liam Girdwood <lgirdwood@gmail.com>, David Brown <david.brown@linaro.org>, "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE" <linux-arm-kernel@lists.infradead.org>, spatakok@qti.qualcomm.com, Andy Gross <andy.gross@linaro.org>, "open list:ARM/QUALCOMM SUPPORT" <linux-soc@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
List-Id: alsa-devel@alsa-project.org


--===============7602579530052523267==
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="3rMDlCEgcaHQQFB+"
Content-Disposition: inline


--3rMDlCEgcaHQQFB+
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Feb 22, 2018 at 10:03:42AM +0000, Srinivas Kandagatla wrote:
> On 22/02/18 00:14, Rob Herring wrote:

> > Am I saying a single DT node for this? Yes, perhaps.
> Yes, I will give that a go.
>=20
> So we will endup having something like this in DT for one frontend and
> backend dailink:

Let's not start encoding DPCM into DT, DPCM is very much an
implemntation detail of the current stack which we're gradually pushing
towards replacing with something better.  What we want to be doing is
just treating components inside the SoC the same as components in a
CODEC, the routing within a SoC being the same as in a CODEC and
similarly for externally connected devices.

> 		fe@1 {
>                 	is-fe;
>                         link-name =3D "MultiMedia1";

In particular having the concept of "front end" in the DT is *very*
implementation specific.  We should just be describing the connections
that exist in the system.

--3rMDlCEgcaHQQFB+
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlqYY8QACgkQJNaLcl1U
h9A2AQf/afU7I+Vlh5qhOLI+4+E9POiqDGkF2eC13xgr1bKvvC1JNlQFVnEpm4QM
xonSvnwf2rv7WLTSP6lClTLAjvXdW4qQ5KvfR6U78HxabliiJyK2aiBVjolPWjse
qvqHHciRTdA3LZmpmGE/rdo3lNAEkiCIHJups7g8spE9Dto6EaMS4Dp05q8OumgD
1DRyte5vIF9m0geqjgexGeTbADs2SwQvdBDdl1PH2Wap/lan8ricHEBVwJlz94LF
A2suvzqCPUUpCdd3vf2CaTo50oQf3Zb4mPD0iKXmpIrx2NFnB6DpqvQsH5EMFkD/
lbxRSeYYJNNSXVbCJYd64Uqez55P3A==
=9CV7
-----END PGP SIGNATURE-----

--3rMDlCEgcaHQQFB+--

--===============7602579530052523267==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============7602579530052523267==--
