From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH 4/4] ASoC: firmware core: Add core support
 to create and destroy firmware components.
Date: Tue, 20 Nov 2012 12:27:02 +0900
Message-ID: <20121120032659.GC4483@opensource.wolfsonmicro.com>
References: <1353348765-6238-1-git-send-email-lrg@ti.com>
 <1353348765-6238-4-git-send-email-lrg@ti.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1954441968716999473=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource.wolfsonmicro.com (opensource.wolfsonmicro.com
 [80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 9751A264FF6
 for <alsa-devel@alsa-project.org>; Tue, 20 Nov 2012 04:32:21 +0100 (CET)
In-Reply-To: <1353348765-6238-4-git-send-email-lrg@ti.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Liam Girdwood <lrg@ti.com>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org


--===============1954441968716999473==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="YjUCIDG0UL7zSTfa"
Content-Disposition: inline


--YjUCIDG0UL7zSTfa
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Nov 19, 2012 at 06:12:45PM +0000, Liam Girdwood wrote:
> Add generic support to create ASoC kcontrols, widgets, graphs and coeffic=
ients from

Word wrapping issue with the commit log here...

This is all really good stuff.  I've nitpicked below and there's a few
bigger things but overall it looks good.

The main thing that's standing out for me is the issue I mentioned in my
reply to patch 3 with multiple firmwares per device; we've got a bunch
of CODECs in mainline already with several independant DSPs in them
which would want to be managed independently.  It'd be good to at least
write the APIs to support that so that we don't churn the driver APIs
too much.

One thing I'm missing is signal generator widgets - those seem like
something that's likely to be often software defined.  It'd also be good
to see a bit more documentation for the file format, like an explanation
of what things like coefficients are since we're going to make it an
ABI.

With coefficeints we have been moving towards a model where we just
expose them as binary controls rather than doing the enumeration thing.

> + * File andBlock header data types.

Typo.

> +/*
> + * File and Block Header
> + */
> +struct snd_soc_fw_hdr {
> +	u32 magic;
> +	u32 type;
> +	u32 vendor_type; /* optional vendor specific type info */
> +	u32 version; /* optional vendor specific version details */
> +	u32 size; /* data bytes, excluding this header */
> +	/* file data contents start here */
> +};

As Takashi says we should take care of byte ordering issues with this
stuff.  For the stuff I've done recently I ended up marking all the
structs __packed and using __be32 and similar for the types.

Obviously on-SoC devices will only be used with a single AP so it's not
a big deal there but when this is used on external devices we're going
to run into issues sooner or later.

> +struct snd_soc_fw_ctl_tlv {
> +	u32 numid;	/* control element numeric identification */
> +	u32 length;	/* in bytes aligned to 4 */
> +	/* tlv data starts here */
> +};

This is just raw ALSA TLV data (it's already an ABI after all).

> +/*
> + * Mixer KControl.
> + */

kcontrol.

> +struct snd_soc_fw_mixer_control {
> +	struct snd_soc_fw_control_hdr hdr;
> +	s32 min;
> +	s32 max;
> +	s32 platform_max;

I guess platform_max isn't needed here as it's something the platform
adds to further restrict capabilities of devices.  Though quite how
platforms will do that for firmwares is an interesting question in
itself :)

> +struct snd_soc_fw_enum_control {
> +	struct snd_soc_fw_control_hdr hdr;
> +	u32 reg;
> +	u32 reg2;
> +	u32 shift_l;
> +	u32 shift_r;
> +	u32 max;
> +	u32 mask;
> +	union {	/* both texts and values are the same size */
> +		char texts[SND_SOC_FW_NUM_TEXTS][SND_SOC_FW_TEXT_SIZE];
> +		u32 values[SND_SOC_FW_NUM_TEXTS * SND_SOC_FW_TEXT_SIZE / 4];

I'm having a hard time visualising how this will get filled in - I'd
expect we'd have something more like:

	u32 num_values;
	struct {
		u32 value;
		char text[SND_SOC_FW_TEXT_SIZE];
	};

- I can't visualise how something with only values would work?  But
perhaps I'm just missing something.

> +/*
> + * DAPM Pin Element.
> + */
> +struct snd_soc_fw_dapm_pin_elem {
> +	char name[SND_SOC_FW_TEXT_SIZE];
> +	u32 disconnect:1;
> +	u32 ignore_suspend:1;
> +};

I think we should probably just skip pins for now - software defined
pins are a bit fun in hardware and=20

ignore_suspend is a machine driver thing, and if I were a firmware
author I'd just be skipping disconnected pins entirely rather than
showing people I'd been using firmware resources for things that don't
do anything :)

> +static inline struct snd_soc_dapm_context *soc_fw_dapm_get(struct soc_fw=
 *sfw)
> +{
> +	if (sfw->codec)
> +		return &sfw->codec->dapm;
> +	else if (sfw->platform)
> +		return &sfw->platform->dapm;
> +	else if (sfw->card)
> +		return &sfw->card->dapm;
> +	BUG();

We should probably have those BUG() calls on the sets too.

> +static int soc_fw_widget_load(struct soc_fw *sfw, struct snd_soc_dapm_wi=
dget *w)
> +{
> +	if (sfw->codec && sfw->codec_ops && sfw->codec_ops->widget_load)
> +		return sfw->codec_ops->widget_load(sfw->codec, w);
> +
> +	if (sfw->platform && sfw->platform_ops && sfw->platform_ops->widget_loa=
d)
> +		return sfw->platform_ops->widget_load(sfw->platform, w);
> +
> +	if (sfw->card && sfw->card_ops && sfw->card_ops->widget_load)
> +		return sfw->card_ops->widget_load(sfw->card, w);
> +
> +	dev_info(sfw->dev, "ASoC: no handler specified for ext widget %s\n",
> +		w->name);
> +	return 0;

Shouldn't this be returning an error?  The same is true for a bunch of
other functions.  Or shouild it be a dev_dbg()?

> +static inline void soc_fw_free_tlv(struct soc_fw *sfw,
> +	struct snd_kcontrol_new *kc)
> +{
> +	kfree (kc->tlv.p);

Coding style, kfree().

> +		dev_dbg(sfw->dev, "ASoC: adding mixer kcontrol %s with access"
> +			" 0x%x\n", mc->hdr.name, mc->hdr.access);

Don't split log messages like this, makes it harder to grep - just break
the 80 columns or wrap after sfw->dev.

> +			if (ext) {
> +				dev_err(sfw->dev, "ASoC: no complete mixer IO"
> +					"handler for %s type (g,p,i) %d:%d:%d\n",

This one is going to be especially bad for example.

> +	if (se->dvalues)
> +		kfree(se->dvalues);
> +	else {

Braces on both sides if they're needed on one.

--YjUCIDG0UL7zSTfa
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIcBAEBAgAGBQJQqvh6AAoJELSic+t+oim9HuwP/20qQiuEoIQOSI0P59/NwPmV
JQmADofFIUTHdrbivBQVgZa8Ne6CkWzdSv2Kfh1Gbcvt+yDBCtHy8sEvaoHVNtAU
6nPzk+tiIsv0EPHAz29FmzT63jDvRq7h859EwGPPLZi5GhL4BxR2Zf4GlrzA1Cop
39l64ZhpIW5voQZIvL658qq/bT75xynZBxigHsulirLk6mQNssnLE5JstU/AZsLm
o4qknzp4flKfEQh1Sv0LE2AlZWWtwEzElRUI4DL9HnUIi3ne1YDnwa/zF7x/VFiv
6TBd04AP843q/OXazdT8bspoOR6ZmEquf29IKRmJas5N4wqaOVOce8WbVKMSA5dy
/yyfPxmGK4JYIbOlk+mqNkM+HY4m9KC01E1tm0ERDC7ZlOkzbboaeKoSQBvgJxDr
bBXoAshnApiCHXci1vib20FNxigjPGC02cPP3B1iQAK0Vxxhhq4j+Z/OrkXz4VYs
cocA1GFVE5tvnhVsWPqKYTOvLF/+DajwjgC3kWhhd937UHei6zWtR+SkDFVKIss7
ju5TzKeaH1bIGz4zEHDUYqIdoELZ4Dxq2TX5e7c2Bh9DasAfFoYIXcvdZxnjyEdF
mQiToVo2vkb8h4pEuxS1WmdPdJBFwff/VV0KQr1/XIi1MC+iDpC9ds19LDYv6qmF
z1yYa/diNNTJalo61xr+
=8nPS
-----END PGP SIGNATURE-----

--YjUCIDG0UL7zSTfa--

--===============1954441968716999473==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============1954441968716999473==--
