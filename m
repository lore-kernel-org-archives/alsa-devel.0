From: Mark Brown <broonie@kernel.org>
Subject: Re: [Patch V4 00/10] ASoC: QCOM: Add support for ipq806x SOC
Date: Wed, 11 Feb 2015 10:26:34 +0800
Message-ID: <20150211022634.GO2593@finisterre.sirena.org.uk>
References: <1423169626-22166-1-git-send-email-kwestfie@codeaurora.org>
 <20150206223229.GG31311@finisterre.sirena.org.uk>
 <20150209064511.GB19870@kwestfie-linux.qualcomm.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="Vy1A5eXR7jld12ZH"
Return-path: <linux-arm-msm-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20150209064511.GB19870@kwestfie-linux.qualcomm.com>
Sender: linux-arm-msm-owner@vger.kernel.org
To: Takashi Iwai <tiwai@suse.de>, Liam Girdwood <lgirdwood@gmail.com>, David Brown <davidb@codeaurora.org>, Bryan Huntsman <bryanh@codeaurora.org>, Greg KH <gregkh@linuxfoundation.org>, Banajit Goswami <bgoswami@codeaurora.org>, Patrick Lai <plai@codeaurora.org>, ALSA Mailing List <alsa-devel@alsa-project.org>, Device Tree Mailing List <devicetree@vger.kernel.org>, MSM Mailing List <linux-arm-msm@vger.kernel.org>, srinivas.kandagatla@linaro.org
List-Id: alsa-devel@alsa-project.org


--Vy1A5eXR7jld12ZH
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Sun, Feb 08, 2015 at 10:45:11PM -0800, Kenneth Westfield wrote:
> On Sat, Feb 07, 2015 at 06:32:29AM +0800, Mark Brown wrote:

> > I'd really like to see some discussion as to how this is all supposed to
> > be handled - how will these direct hardware access drivers and device
> > trees work when someone does want to use the DSP (without causing
> > problems), and how will we transition from one to the other.  This is
> > particularly pressing if there are use cases where people will want to
> > switch between the two modes at runtime.

> > What I'm trying to avoid here is being in a situation where we have
> > existing stable DT bindings which we have to support but which conflict
> > with the way that people want to use the systems.

> The ipq806x SOC has no LPASS DSP.  On SOCs with a DSP, these drivers
> would not be enabled.

OK, but I'm guessing that they're using the same IP that is in other
SoCs which do have the DSP so even if you don't care for this device it
might still be an issue.

> These drivers are prefixed with "lpass" to differentiate themselves from
> other drivers that would interact with a DSP, rather than the LPASS
> hardware directly.

Right, it may be that all that's needed here is some indication as to
how to describe a system which *does* have a DSP.  Perhaps require that
the devices be children of the DSP, that way if people want to access
the hardware directly they can load a dummy driver for the DSP that just
passes things through if they don't want to use the DSP?

--Vy1A5eXR7jld12ZH
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJU2r3aAAoJECTWi3JdVIfQpOgH/jqkVdA7kHsm+/ouUVCuwrHN
TkkSmRlZTE3cC1wuu7hCZKuwThRXnrp0zqhCOMIC/CZ5nga0b/GlQe8AaSjQUXax
YFTHdpkyxgYOy1oREDe6DYTp22V0LbjM5FM7t9A1KH4SLIcNrQUeUWqbyhJiVQ5X
MvsIJG6IEyB8tE+HaZ5+MoCLFwVq2NlFLA6/p1eVa4gjUgOA/9YWCA/B4YYEn5Xh
AeI5uaKfceCpDkd7qmWalocT3p/evWILTML8Zbbok3GcYDErk8U2pmAZupTQoKE6
0dCRDocVVrKP/EA4IkwXgmxgBsETa5NotK90XnESdG7qBhMXjQn2NSfu0VShbZM=
=gRiY
-----END PGP SIGNATURE-----

--Vy1A5eXR7jld12ZH--
