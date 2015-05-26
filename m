From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH v2 1/3] ASoC: topology: Add topology UAPI
	header
Date: Tue, 26 May 2015 11:33:02 +0100
Message-ID: <20150526103302.GL21577@sirena.org.uk>
References: <1432574570-7436-1-git-send-email-liam.r.girdwood@linux.intel.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============3644423150173789258=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 92BEF265068
 for <alsa-devel@alsa-project.org>; Tue, 26 May 2015 12:33:09 +0200 (CEST)
In-Reply-To: <1432574570-7436-1-git-send-email-liam.r.girdwood@linux.intel.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Liam Girdwood <liam.r.girdwood@linux.intel.com>
Cc: Takashi Iwai <tiwai@suse.de>, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org


--===============3644423150173789258==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="3jDPHMPer01dpVEx"
Content-Disposition: inline


--3jDPHMPer01dpVEx
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, May 25, 2015 at 06:22:48PM +0100, Liam Girdwood wrote:
>  The ASoC topology UAPI header defines the structures
>  required to define any DSP firmware audio topology and control objects from
>  userspace.

This looks pretty good to me.  I've got a few comments below but they're
mostly either typo level stuff plus a couple of things that are
basically "we should explicitly think about this" but where I'm not 100%
convinced we actually need to change anything.

I'm not convinced we need to export *all* the control types we've got in
the kernel at the minute but on the other hand they don't really do any
harm.

> +/* string sizes */
> +#define SND_SOC_TPLG_NUM_TEXTS		16

Comment probably needs updating.

> +/* Max size of TLV data */
> +#define SND_SOC_TPLG_TLV_SIZE		32

Units (IIRC it might be ints or something in the kernel, I didn't check
though)?

> +/* vendor block IDs - please add new vendor types to end */
> +#define SND_SOC_TPLG_TYPE_VENDOR_FW	1000
> +#define SND_SOC_TPLG_TYPE_VENDOR_CONFIG	1001
> +#define SND_SOC_TPLG_TYPE_VENDOR_COEFF	1002
> +#define SND_SOC_TPLG_TYPEVENDOR_CODEC	1003

Missing _

> +struct snd_soc_tplg_ctl_tlv {
> +	__le32 size;	/* in bytes aligned to 4 */
> +	__le32 numid;	/* control element numeric identification */
> +	__le32 count;	/* number of elem in data array */
> +	__le32 data[SND_SOC_TPLG_TLV_SIZE];
> +} __attribute__((packed));

We *could* make data variable size since there's a size field here.  Not
sure it's worth the effort though.

> +/*
> + * Kcontrol Operations IDs
> + */
> +struct snd_soc_tplg_kcontrol_ops_id {
> +	__le32 get;
> +	__le32 put;
> +	__le32 info;
> +} __attribute__((packed));

Would these ever usefully not match up with each other?

> +struct snd_soc_tplg_stream_caps {
> +	__le32 size;		/* in bytes of this structure */
> +	char name[SNDRV_CTL_ELEM_ID_NAME_MAXLEN];
> +	__le64 formats[SND_SOC_TPLG_MAX_FORMATS];	/* supported formats SNDRV_PCM_FMTBIT_* */
> +	__le32 rates;		/* supported rates SNDRV_PCM_RATE_* */

We should move _FMTBIT and _RATE to UAPI as well since they're becoming
part of the ABI (I think the other defines we reference already are or
are moved as part of this patch).

> +	__le32 rate_min;	/* min rate */
> +	__le32 rate_max;	/* max rate */
> +	__le32 channels_min;	/* min channels */
> +	__le32 channels_max;	/* max channels */
> +	__le32 periods_min;	/* min number of periods */
> +	__le32 periods_max;	/* max number of periods */
> +	__le32 period_size_min;	/* min period size bytes */
> +	__le32 period_size_max;	/* max period size bytes */
> +	__le32 buffer_size_min;	/* min buffer size bytes */
> +	__le32 buffer_size_max;	/* max buffer size bytes */
> +} __attribute__((packed));

So, clearly this is easy to map onto ALSA.  I am wondering if we want to
take the time to tweak things a bit though, especially with channels
where it seems we fairly often have a requirement for an even number of
channels which this doesn't capture.  I was thinking a list of valid
channel counts and a list of valid rates, those should cope with
whatever requirements come up in future.  Don't know if it's really
worth it though, but it should be fairly straightfoward to map and the
above does cause friction with our current interfaces.  Thoughts?

> +/*
> + * Bytes kcontrol
> + *
> + * File block representation for bytes kcontrol :-
> + * +-----------------------------------+----+
> + * | struct snd_soc_tplg_hdr           |  1 |
> + * +-----------------------------------+----+
> + * | struct snd_soc_tplg_bytes_control |  N |
> + * +-----------------------------------+----+
> + */
> +struct snd_soc_tplg_bytes_control {
> +	struct snd_soc_tplg_ctl_hdr hdr;
> +	__le32 size;	/* in bytes of this structure */
> +	__le32 max;
> +	__le32 mask;
> +	__le32 base;
> +	__le32 num_regs;

Should this be in registers or bytes - if it's registers we need to know
how big a register is?

> +/*
> + * DAPM Graph Element
> + *
> + * File block representation for DAPM graph elements :-
> + * +-------------------------------------+----+
> + * | struct snd_soc_tplg_hdr             |  1 |
> + * +-------------------------------------+----+
> + * | struct snd_soc_tplg_dapm_graph_elem |  N |
> + * +-------------------------------------+----+
> + */
> +struct snd_soc_tplg_dapm_graph_elem {
> +	char sink[SNDRV_CTL_ELEM_ID_NAME_MAXLEN];
> +	char control[SNDRV_CTL_ELEM_ID_NAME_MAXLEN];
> +	char source[SNDRV_CTL_ELEM_ID_NAME_MAXLEN];
> +} __attribute__((packed));

Since this format is going to be machine generated and read should we
consider using numbers (mind you, strings are just very big numbers)?
It'd make the files smaller but I'm really unsure it's worth the cost.

Given all the talk about size optimisation right now I can see people
wanting to change that bit of our implementation soon though we will
for the forseeable future always have a translation mechanism for
strings so it's not like it'll bitrot and it's effort right now that
would make things less debuggable at runtime ("What do I need to connect
to 'firmware-534' again?").

> +struct snd_soc_tplg_dapm_widget {

> +	__u32 ignore_suspend;	/* kept enabled over suspend */

I don't think we want this in the binary file, the question of "what is
suspend" gets tricky and it's mainly for machine drivers in the
in-kernel stuff.  Are you actually using it at the minute or is it just
coming from the translation of the current in kernel structs?

--3jDPHMPer01dpVEx
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJVZEvdAAoJECTWi3JdVIfQsoUH/1eZTWBndQrDUWEvLbNDzYiE
2x8RtATSzWC93Wmqjoj6lWP1Rv+87rdmg+1fE6Bu3IGyiFYODZOi3Qga3LrCyumC
v0Xqi3GKry3LtVfWf3UDm4ejAJUlnSPobpZ4PHr69g3rCpqjSToaSPuZkr56J9pQ
HJCVo8DZLS6IMWs3RO6GTjfTk5p4ZTSOvfEmJqxWuqnJaqTwUwKBvg/PXugiRxHZ
ugyXlaQRgaEPtJZqilksCAwlT82wPRZ2tTtcDr4s6j6ZOlcOrtFWrHr0quFRrMw6
FzGAyle+rNp2ON57cxnZQjU8WEveVNArm357a52vO3tmR3cQvg7h+FkF1wp3n+4=
=pTGX
-----END PGP SIGNATURE-----

--3jDPHMPer01dpVEx--

--===============3644423150173789258==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============3644423150173789258==--
