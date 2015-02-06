From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [Patch V4 00/10] ASoC: QCOM: Add support for ipq806x SOC
Date: Sat, 7 Feb 2015 06:32:29 +0800
Message-ID: <20150206223229.GG31311@finisterre.sirena.org.uk>
References: <1423169626-22166-1-git-send-email-kwestfie@codeaurora.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="FwyhczKCDPOVeYh6"
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1423169626-22166-1-git-send-email-kwestfie-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Kenneth Westfield <kwestfie-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>
Cc: Takashi Iwai <tiwai-l3A5Bk7waGM@public.gmane.org>, Liam Girdwood <lgirdwood-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, David Brown <davidb-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>, Bryan Huntsman <bryanh-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>, Greg KH <gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org>, Banajit Goswami <bgoswami-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>, Patrick Lai <plai-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>, ALSA Mailing List <alsa-devel-K7yf7f+aM1XWsZ/bQMPhNw@public.gmane.org>, Device Tree Mailing List <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, MSM Mailing List <linux-arm-msm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: alsa-devel@alsa-project.org


--FwyhczKCDPOVeYh6
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Feb 05, 2015 at 12:53:36PM -0800, Kenneth Westfield wrote:

> This patch series adds support for I2S audio playback on the Qualcomm
> Technologies ipq806x SOC.

> The ipq806x SOC has audio-related hardware blocks in its low-power audio
> subsystem (or LPASS).  One of the relevant blocks in the LPASS is its low-power
> audio interface (or LPAIF).  This contains an MI2S port, which is what these
> drivers are configured to use.  The LPAIF also contains a DMA engine that is
> dedicated to moving audio samples into the transmit FIFO of the MI2S port.  In
> addition, there is also low-power memory (LPM) within the audio subsystem, which
> is used for buffering the audio samples.

This is implementing an AP centric audio system design where the AP
directly programs all the audio hardware.  Given that pretty much all
public Qualcomm systems use a DSP centric model where the AP interacts
only with a DSP which deals with DMA and the physical interfaces it
seems reasonable to suppose that this system also has a DSP which at
some future point people are likely to want to use.

I'd really like to see some discussion as to how this is all supposed to
be handled - how will these direct hardware access drivers and device
trees work when someone does want to use the DSP (without causing
problems), and how will we transition from one to the other.  This is
particularly pressing if there are use cases where people will want to
switch between the two modes at runtime.

What I'm trying to avoid here is being in a situation where we have
existing stable DT bindings which we have to support but which conflict
with the way that people want to use the systems.

--FwyhczKCDPOVeYh6
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJU1UD9AAoJECTWi3JdVIfQOwsH/joETxcnABrs5tfDLiWiAomH
FxzdO40vtat/WLhzus/mPY10v03xQ8c90SYGsANP8hbeqYAmB5WjCX6MzpUCzVW2
s1g/iUNQ84gKEtuOa0HepcHrF5hVWvjKQ/ODjQsLTQoB7jWqGtZCbVrU8BGQNDsL
XlW/vevJWt6dE5wtxAjc9cTwkn4UKaEgg41MFk0fx34z0Al+7ZOunVhrDkVhJeRc
vyoPcYyYWBEbxU5WPPzSraw7CrPDL8FRz03qAFsH96k15PDz6mfOfSP2tLZFiJfG
3qowYRn/rf9Inalz+ImOVCdCQQP43iqNVamyk6aw7wcJCuTjwT4ccSfgwqi078Q=
=4QTN
-----END PGP SIGNATURE-----

--FwyhczKCDPOVeYh6--
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
