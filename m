From: Mark Brown <broonie@kernel.org>
Subject: Re: [Patch V3 03/10] ASoC: qcom: Document LPASS CPU bindings
Date: Fri, 26 Dec 2014 16:43:03 +0000
Message-ID: <20141226164303.GE17800@sirena.org.uk>
References: <1419439330-2303-1-git-send-email-kwestfie@codeaurora.org>
 <1419439330-2303-4-git-send-email-kwestfie@codeaurora.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="EKglq5eeiLEg3Uj1"
Return-path: <linux-arm-msm-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1419439330-2303-4-git-send-email-kwestfie@codeaurora.org>
Sender: linux-arm-msm-owner@vger.kernel.org
To: Kenneth Westfield <kwestfie@codeaurora.org>
Cc: Takashi Iwai <tiwai@suse.de>, Liam Girdwood <lgirdwood@gmail.com>, David Brown <davidb@codeaurora.org>, Bryan Huntsman <bryanh@codeaurora.org>, Greg KH <gregkh@linuxfoundation.org>, Banajit Goswami <bgoswami@codeaurora.org>, Patrick Lai <plai@codeaurora.org>, ALSA Mailing List <alsa-devel@alsa-project.org>, MSM Mailing List <linux-arm-msm@vger.kernel.org>, Device Tree Mailing List <devicetree@vger.kernel.org>
List-Id: alsa-devel@alsa-project.org


--EKglq5eeiLEg3Uj1
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Dec 24, 2014 at 08:42:03AM -0800, Kenneth Westfield wrote:

> +- ahbix-frequency	: Specifies AHBIX bus clock frequency

This is a really weird thing to see in a DT, what's going on here?

> +- pinctrl-names	: A list of names indicating the state of the MI2S pins
> +				* default
> +				* idle
> +- pinctrl-0		: The default state of the MI2S pins
> +- pinctrl-1		: The idle state of the MI2S pins

This doesn't make much sense.  We've got a name lookup array for the pin
states but the actual pin states are in distinct numbered properties
which can't be reordered.  What's going on here?

--EKglq5eeiLEg3Uj1
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBAgAGBQJUnZAXAAoJECTWi3JdVIfQOAcH/Rct0XQ2Wkj/EyAvCj22h+gM
P6oe7Y6HP7uL4+R4ud4ExsJp4cUE4zMwjoyzDiZmPJPyJ70eFCh2RfdxJrqIgIhC
hU8w81ojfJpJkf/Z0D2fUtknDi+97fQ98jLrxtVMWNBAxwHvwQMLxZpMA7cQm9oh
XmLLnFhk7nbZDQhvfrF4u5GtL1HJt8mA3NHKYgHzlgkZCqHRVQlLZx2BLO/aIISk
2YUJxU/NCFXmPgNpdJACsAOX+5glfqSoLYvbJmf2vDZBNMPiIUBTeOARtiY6l/wZ
DW03He1cNq0RQis6oeOrbWmQioLSXw8P0igGuZzfCfY+PNe+xPzDIc1fks3O/KY=
=KrIR
-----END PGP SIGNATURE-----

--EKglq5eeiLEg3Uj1--
