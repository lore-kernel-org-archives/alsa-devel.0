From: Mark Brown <broonie@kernel.org>
Subject: Re: [Patch v2 02/11] ASoC: qcom: Add device tree binding docs
Date: Thu, 11 Dec 2014 13:15:52 +0000
Message-ID: <20141211131552.GX11764@sirena.org.uk>
References: <fdc53daed0c7c41168a14de6b2983895.squirrel@www.codeaurora.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="FclElvQKoGCylS3A"
Return-path: <linux-arm-msm-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <fdc53daed0c7c41168a14de6b2983895.squirrel@www.codeaurora.org>
Sender: linux-arm-msm-owner@vger.kernel.org
To: Kenneth Westfield <kwestfie@codeaurora.org>
Cc: Takashi Iwai <tiwai@suse.de>, Liam Girdwood <lgirdwood@gmail.com>, David Brown <davidb@codeaurora.org>, Bryan Huntsman <bryanh@codeaurora.org>, Rob Herring <rob.herring@calxeda.com>, Greg KH <gregkh@linuxfoundation.org>, Patrick Lai <plai@codeaurora.org>, Banajit Goswami <bgoswami@codeaurora.org>, ALSA Mailing List <alsa-devel@alsa-project.org>, Device Tree Mailing List <devicetree@vger.kernel.org>, MSM Mailing List <linux-arm-msm@vger.kernel.org>
List-Id: alsa-devel@alsa-project.org


--FclElvQKoGCylS3A
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Dec 11, 2014 at 12:23:55AM -0800, Kenneth Westfield wrote:
> On Tue, December 9, 2014 7:37 am, Mark Brown wrote:

> > Please don't send multiple separate changes in a single patch.  One change per patch.

Please fix your mail client to both word wrap within paragraphs and
avoid corrupting the mails you're replying to.  As things stand your
messages are excessively hard to read.

> In an effort to reduce the number of patches, would it be possible to package the DT doc with its
> respective driver in one patch?  Or does the DT doc need to be in a patch by itself?  I've seen
> examples of both.

You're supposed to send the documentation in a separate patch.

> Also, I will combine the partial addition of each driver to its respective Kconfig/Makefile
> entries.  For this, I believe I need to start with an empty Kconfig/Makefile in the first patch?

No, you never need to create an empty file like that - what would the
value be?  If you are going to add the Makefile components independently
within the Qualcomm directory please remember to pay attention to
bisection.

--FclElvQKoGCylS3A
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBAgAGBQJUiZkIAAoJECTWi3JdVIfQ4ZUH/1Saw3oA9xI2unuyO3s0NxGr
mMZ+8JuWMZBuC4//KBuHdi/67SlCrH7TZIh4GbiUpAfrtXi/3hsLYKjX8eKxKh7h
ys9KxY+y3I+3L5AYnxCJgNAdN1Kh9rhj2am8BLPUxn3D5czm1uk2xfw7wQAGMOYf
wrca6rC/SXoQs8PLmTbELvtKWizerS9n71tLLECO2uqouSPWJGco5qkCaFYmrw19
vv13zDkLtptYwWo74qR6TQ/nsXBzaw9m96plHJ2rn0Fm7OTEsRLqY5sSxujAjqQC
UpgIFMQsM+ax528dbOkErJFYxOYbUKUefcX8cLB6rY878YsPN6zbMMIyCsJtd3k=
=fbtW
-----END PGP SIGNATURE-----

--FclElvQKoGCylS3A--
