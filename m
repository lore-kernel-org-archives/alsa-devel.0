From: Sven Eckelmann <sven@narfation.org>
Subject: Re: [PATCH v2] ALSA: hda/realtek - Enable the ALC292
	dock fixup on the Thinkpad T460s
Date: Mon, 11 Apr 2016 16:43:38 +0200
Message-ID: <1639739.FqnMfNtjzc@bentobox>
References: <1460366498-14101-1-git-send-email-sven@narfation.org>
 <s5hzit02qbm.wl-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============4074051779389065043=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from v3-1039.vlinux.de (narfation.org [79.140.41.39])
 by alsa0.perex.cz (Postfix) with ESMTP id 55B89260870
 for <alsa-devel@alsa-project.org>; Mon, 11 Apr 2016 16:43:42 +0200 (CEST)
In-Reply-To: <s5hzit02qbm.wl-tiwai@suse.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org, Simon Wunderlich <sw@simonwunderlich.de>
List-Id: alsa-devel@alsa-project.org

--===============4074051779389065043==
Content-Type: multipart/signed; boundary="nextPart5021043.UqGMzhdnXG"; micalg="pgp-sha512"; protocol="application/pgp-signature"

--nextPart5021043.UqGMzhdnXG
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"

On Monday 11 April 2016 16:05:49 Takashi Iwai wrote:
> On Mon, 11 Apr 2016 11:21:38 +0200,
> Sven Eckelmann wrote:
> > 
> > The Lenovo Thinkpad T460s requires the alc_fixup_tpt440_dock as well in
> > order to get working sound output on the docking stations headphone jack.
> > 
> > Patch tested on a Thinkpad T460s (20F9CT01WW) using a ThinkPad Ultradock
> > on kernel 4.4.6.
> > 
> > Signed-off-by: Sven Eckelmann <sven@narfation.org>
> > Tested-by: Simon Wunderlich <sw@simonwunderlich.de>
> > ---
> > v2:
> >  - rebased on current master
> > 
> >  sound/pci/hda/patch_realtek.c | 18 +++++++++++++++++-
> >  1 file changed, 17 insertions(+), 1 deletion(-)
> > 
> > diff --git a/sound/pci/hda/patch_realtek.c b/sound/pci/hda/patch_realtek.c
> > index fefe83f..36d371c 100644
> > --- a/sound/pci/hda/patch_realtek.c
> > +++ b/sound/pci/hda/patch_realtek.c
> > @@ -4760,6 +4760,8 @@ enum {
> >  	ALC225_FIXUP_DELL1_MIC_NO_PRESENCE,
> >  	ALC280_FIXUP_HP_HEADSET_MIC,
> >  	ALC221_FIXUP_HP_FRONT_MIC,
> > +	ALC292_FIXUP_TPT460_DOCK,
> > +	ALC292_FIXUP_TPT460,
> >  };
> >  
> >  static const struct hda_fixup alc269_fixups[] = {
> > @@ -5409,6 +5411,18 @@ static const struct hda_fixup alc269_fixups[] = {
> >  			{ }
> >  		},
> >  	},
> > +	[ALC292_FIXUP_TPT460_DOCK] = {
> > +		.type = HDA_FIXUP_FUNC,
> > +		.v.func = alc_fixup_tpt440_dock,
> > +		.chained = true,
> > +		.chain_id = ALC269_FIXUP_THINKPAD_ACPI
> > +	},
> > +	[ALC292_FIXUP_TPT460] = {
> > +		.type = HDA_FIXUP_FUNC,
> > +		.v.func = alc_fixup_disable_aamix,
> > +		.chained = true,
> > +		.chain_id = ALC292_FIXUP_TPT460_DOCK,
> > +	},
> 
> We don't need to add two entries but just one, something like below.
> 
> 	[ALC292_FIXUP_TPT460] = {
> 		.type = HDA_FIXUP_FUNC,
> 		.v.func = alc_fixup_tpt440_dock,
> 		.chained = true,
> 		.chain_id = ALC293_FIXUP_LENOVO_SPK_NOISE,
> 	},

Just wanted to keep it consistent with the TPT440 entries.

Kind regards,
	Sven
--nextPart5021043.UqGMzhdnXG
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAABCgAGBQJXC7gaAAoJEF2HCgfBJntGvFkP/jfrIu7LCUcpfXpqhqLyRd0/
BV8D9uv9+UVQrUBaL5uQwV/B25COWFZ0J9PY37VRJtz4CT6CoqyzlvW6b4QeIbjR
N/vZJ+HrzR00VfbSgGNcK0zpER3MNvrUPQ9BBaYGltxa0f4DDM9ZXOL9dxU7zPIi
OaNfz45szJiDzKTLGCIIOJSXrHxUNKXsH//bZTPzJZUHoIbhM93k+94/GoTamfhi
OrIZTwg8xkDcfxWH9iXqSidn4ZMk/GXV5G+VVFg/6mGHirq5qMNVxoOq81jmv7IZ
YlBz+GwVps9RmgfKy+SELLsnPZWAFMY53UbJYAekkvhpMOykSV7HDexN6CYfMZgB
dHO09Qx9ws1+db8ks9C2dtvMsuBjTYP9oU8QJyVxboNXQt9y/Y96+iTk/b/BRI0l
7OTCAZVdGepO5mkoWFWxYYuAt46eNZcx5pwJOUdHGYIw+QuJzLiwXFBi5j2+RWjg
58O/BKT6QMbNUZI9MlJWIkL04P7E92XW/G+HLdkjFW0jYR9wDOKJuGa6cbYwZytt
30pnCRJBkn/hWk6BkPz0ZA+TfBDYuba71kzJatHWoWuWMS6QGPRQk39xXC1ELjrz
mTYizNOFZIuOyy2mWA9oUoGWzARXVObm7nhKmRskGFGcY2VaojqtrvikaVeWKRpK
uVWiafqHWRzKxPmnlm3I
=4yRK
-----END PGP SIGNATURE-----

--nextPart5021043.UqGMzhdnXG--


--===============4074051779389065043==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============4074051779389065043==--
