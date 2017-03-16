From: Eric Anholt <eric@anholt.net>
Subject: Re: [PATCH v2 2/3] drm/vc4: Add HDMI audio support
Date: Thu, 16 Mar 2017 11:13:12 -0700
Message-ID: <87tw6tyts7.fsf@eliezer.anholt.net>
References: <20170227202803.12855-1-eric@anholt.net>
 <20170227202803.12855-2-eric@anholt.net>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1198938152=="
Return-path: <dri-devel-bounces@lists.freedesktop.org>
In-Reply-To: <20170227202803.12855-2-eric@anholt.net>
List-Unsubscribe: <https://lists.freedesktop.org/mailman/options/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=unsubscribe>
List-Archive: <https://lists.freedesktop.org/archives/dri-devel>
List-Post: <mailto:dri-devel@lists.freedesktop.org>
List-Help: <mailto:dri-devel-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=subscribe>
Errors-To: dri-devel-bounces@lists.freedesktop.org
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>
To: Lee Jones <lee@kernel.org>, Florian Fainelli <f.fainelli@gmail.com>, dri-devel@lists.freedesktop.org, Mark Brown <broonie@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>, Lars-Peter Clausen <lars@metafoo.de>, alsa-devel@alsa-project.org
Cc: Stefan Wahren <stefan.wahren@i2se.com>, Stephen Warren <swarren@wwwdotorg.org>, linux-kernel@vger.kernel.org, bcm-kernel-feedback-list@broadcom.com, linux-rpi-kernel@lists.infradead.org, linux-arm-kernel@lists.infradead.org
List-Id: alsa-devel@alsa-project.org

--===============1198938152==
Content-Type: multipart/signed; boundary="=-=-=";
	micalg=pgp-sha512; protocol="application/pgp-signature"

--=-=-=
Content-Type: text/plain

Eric Anholt <eric@anholt.net> writes:

> The HDMI encoder IP embeds all needed blocks to output audio, with a
> custom DAI called MAI moving audio between the two parts of the HDMI
> core.  This driver now exposes a sound card to let users stream audio
> to their display.
>
> Using the hdmi-codec driver has been considered here, but MAI meant
> having to significantly rework hdmi-codec, and it would have left
> little shared code with the I2S mode anyway.
>
> The encoder requires that the audio be SPDIF-formatted frames only,
> which alsalib will format-convert for us.
>
> This patch is the combined work of Eric Anholt (initial register setup
> with a separate dmaengine driver and using simple-audio-card) and
> Boris Brezillon (moving it all into HDMI, massive debug to get it
> actually working), and which Eric has the permission to release.
>
> v2: Drop "-audio" from sound card name, since that's already implied
>     (suggestion by Boris)

On IRC, Mark Brown disclaimed responsibility for reviewing this code, so
I've merged it to drm-misc-next.

--=-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEE/JuuFDWp9/ZkuCBXtdYpNtH8nugFAljK1bgACgkQtdYpNtH8
nuifNQ//Up4UyRyedX5PgQXFzs3Jq6XSMAze7UdO/WLbbXLjjLpZ6mP0PXjPjaJL
3mHZcY/CkfMF3zyWfyeZe6W8Is8aRp/pVFJZ5479KBtM9+zmxv1r36TLCpHaKU+v
izcsMbzQJby9gYJtNHkkqO92z3Cve/ZusKiMvzPo8ouXCBN9CmBwECFa8LsMLDWr
1fleiiH5E17mNSDQnHJNoRS68Je5yrD6kZ2ritioocfo3q8IirXuYW2r1biB7c/y
1zY5EBQjXik/vm16rYcYV8grkaS6aODhGAIl3ZOK7bF4Lu1D9xBDmIn7SBNBlCgy
JbacGkvKcIgpfeQ/B2hVznJwiewu25KMLR+x9ihDl2GhZa+uDsriScRrwutLLVkZ
aDoWUudLz7DOhIbuJ8A9aF8Cc1ZS3f4dDBueW1ApXIxms8v4s6V23LuuaUI0BTG3
TQA0TeY8LVqkvm39wcu/fimwIM9JNECLdGsMRy+AhQChQ135sxCIutmt9MUEL7Wm
vQdWWtzfuLR3af2/YTBZfUw49y2cUOkNnVPcQeIWmS70nZZcY188QvEe+me4y29n
vcWktfjymb2anTDgyBfhi1/tLFSKnM+xl74EDquzVX0g+o+qbivyhyBWgZTF9zqv
fe8GLJVmSy1uz4T2yWm6d0FTCWmaUnii9inpMfih35OMzeYBMVA=
=1Kxx
-----END PGP SIGNATURE-----
--=-=-=--

--===============1198938152==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: inline

X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KZHJpLWRldmVs
IG1haWxpbmcgbGlzdApkcmktZGV2ZWxAbGlzdHMuZnJlZWRlc2t0b3Aub3JnCmh0dHBzOi8vbGlz
dHMuZnJlZWRlc2t0b3Aub3JnL21haWxtYW4vbGlzdGluZm8vZHJpLWRldmVsCg==

--===============1198938152==--
