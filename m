From: Mark Brown <broonie@kernel.org>
Subject: Re: [alsa-devel] [Patch V4 00/10] ASoC: QCOM: Add support for
 ipq806x SOC
Date: Sat, 14 Feb 2015 14:25:10 +0900
Message-ID: <20150214052510.GI9110@finisterre.sirena.org.uk>
References: <1423169626-22166-1-git-send-email-kwestfie@codeaurora.org>
 <20150206223229.GG31311@finisterre.sirena.org.uk>
 <20150209064511.GB19870@kwestfie-linux.qualcomm.com>
 <20150211022634.GO2593@finisterre.sirena.org.uk>
 <20150212010551.GA7330@kwestfie-linux.qualcomm.com>
 <20150212025341.GT2593@finisterre.sirena.org.uk>
 <54DC5441.1070004@codeaurora.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="yzvKDKJiLNESc64M"
Return-path: <linux-arm-msm-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <54DC5441.1070004@codeaurora.org>
Sender: linux-arm-msm-owner@vger.kernel.org
To: Patrick Lai <plai@codeaurora.org>
Cc: Takashi Iwai <tiwai@suse.de>, Liam Girdwood <lgirdwood@gmail.com>, David Brown <davidb@codeaurora.org>, Bryan Huntsman <bryanh@codeaurora.org>, Greg KH <gregkh@linuxfoundation.org>, Banajit Goswami <bgoswami@codeaurora.org>, ALSA Mailing List <alsa-devel@alsa-project.org>, Device Tree Mailing List <devicetree@vger.kernel.org>, MSM Mailing List <linux-arm-msm@vger.kernel.org>, srinivas.kandagatla@linaro.org
List-Id: alsa-devel@alsa-project.org


--yzvKDKJiLNESc64M
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Feb 11, 2015 at 11:20:33PM -0800, Patrick Lai wrote:
> On 2/11/2015 6:53 PM, Mark Brown wrote:
> >On Wed, Feb 11, 2015 at 05:05:52PM -0800, Kenneth Westfield wrote:

> >>Replacing DSP-based drivers with LPASS-based drivers would be something that
> >>should be handled by Kconfig selections.  For the DT, the DSP-related

> >No, it shouldn't be.  We should have the ability to build a single
> >kernel image which will run on many systems, including both your
> >system with a DSP and other systems without.

> Is there expectation that DTB flashed onto the system would define nodes to
> bind with both LPASS-based driver and DSP-based driver? I hope not as we want
> to keep LPASS-based driver & DSP-based driver mutually exclusive.

DTB time selections are a separate thing to Kconfig changes like Kenneth
was proposing.  They're more viable though it'd be a lot better to avoid
needing them, designing out the possibility of doing something is often
a sure fire way of finding a user.

> >The selection of DSP use sounds like something which isn't part of the
> >description of the hardware but rather a runtime policy decision (at
> >least in so far as non-DSP is ever an option).

> Put aside IPQ8064, I would say it is actually more of build time policy
> decision for QC SoCs with DSP. XPU is programmed by trust zone to allow certain
> LPASS registers to be accessed by the chosen processor. If ADSP and app
> processor would have to have access to audio interfaces and DMA, resources
> partition(i.e # of DMAs go to ADSP while rest of DMA go to app processor is
> decided after analyzing expected concurrency use case. For case of 8016, MDSP
> would simply expect it has access to all audio subsystem except digital core of
> CODEC.

But is it possible to configure the TrustZone firmware to leave things
open?  That's the tricky case.

Actually, can we read the configuration TrustZone did?  That might be
the best answer here, the DT can describe the silicon and then we can
check at runtime which bits of it we're actually allowed to talk to.

--yzvKDKJiLNESc64M
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJU3tw2AAoJECTWi3JdVIfQsogH/2vp7AmEy12Fq7Ht7DoBr+FI
4i/z+hhnBL0NQbs2V7c4BkuaWMs0uFWKY2dHgPsbZEv/Q8MksRqI8qqV4/1qEP0+
WoXp18EfAIIm9KTm1YOQnCuiZBNPnaWjmkMIz9/79oHc60DWHyJDLFYuicnL7SM5
IRZjfKjQryyYQFB0S2TePLJG+8TmotWpmJsCG9eHKJt/vWw70CXkMvRICNyMRqCx
h68Zo7XDJDBveLtyNN5ckAZqouHeI4hzaL3Wvc4Bkqn/jqTDyC9j8iagL0g6tXju
fPbRcoDnY/GPNwxNdu6jDiE3yp4ndJcEXBrF9Hz9zVgl4w5m8xB1m8T3s2l7jG4=
=w/4Y
-----END PGP SIGNATURE-----

--yzvKDKJiLNESc64M--
