From: Arnaud Pouliquen <arnaud.pouliquen@st.com>
Subject: Re: [STLinux Kernel] [PATCH v2 4/4] ASoC: hdmi-codec:
 add channel mapping control
Date: Mon, 19 Dec 2016 12:07:03 +0100
Message-ID: <3221c668-0ced-a2d8-9422-5bf063d06c42@st.com>
References: <1481728605-22781-1-git-send-email-arnaud.pouliquen@st.com>
 <1481728605-22781-5-git-send-email-arnaud.pouliquen@st.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx07-00178001.pphosted.com (mx07-00178001.pphosted.com
 [62.209.51.94]) by alsa0.perex.cz (Postfix) with ESMTP id 3B590265A82
 for <alsa-devel@alsa-project.org>; Mon, 19 Dec 2016 12:07:09 +0100 (CET)
In-Reply-To: <1481728605-22781-5-git-send-email-arnaud.pouliquen@st.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org, dri-devel@lists.freedesktop.org
Cc: kernel@stlinux.com, Takashi Iwai <tiwai@suse.de>, lgirdwood@gmail.com, Jyri Sarha <jsarha@ti.com>, Takashi Sakamoto <o-takashi@sakamocchi.jp>, David Airlie <airlied@linux.ie>, broonie@kernel.org, Daniel Vetter <daniel.vetter@intel.com>
List-Id: alsa-devel@alsa-project.org


I detected 2 issues in this version, details below.

V3 is following.
Sorry for the inconvenience...

Regards
Arnaud

On 12/14/2016 04:16 PM, Arnaud Pouliquen wrote:
> +static unsigned long hdmi_codec_spk_mask_from_alloc(int spk_alloc)
> +{
> +	int i;
> +	const unsigned long hdmi_codec_eld_spk_alloc_bits[] = {
> +		[0] = FL | FR, [1] = LFE, [2] = FC, [3] = RL | RR,
> +		[4] = RC, [5] = FLC | FRC, [6] = RLC | RRC,
> +	};
> +	unsigned long spk_mask;
Missing initialization that generates warning during compilation
> +
> +	for (i = 0; i < ARRAY_SIZE(hdmi_codec_eld_spk_alloc_bits); i++) {
> +		if (spk_alloc & (1 << i))
> +			spk_mask |= hdmi_codec_eld_spk_alloc_bits[i];
> +	}
> +
> +	return spk_mask;
> +}
> +
> +/* From speaker bit mask to ALSA API channel position */
> +static int snd_hdac_spk_to_chmap(int spk)
> +{
> +	const struct hdmi_codec_channel_map_table *t = hdmi_codec_map_table;
> +
> +	for (; t->map; t++) {
> +		if (t->spk_mask == spk)
> +			return t->map;
> +	}
> +
> +	return 0;
> +}
> +
> +/**
> + * hdmi_codec_cea_init_channel_alloc:
> + * Compute derived values in hdmi_codec_channel_alloc[].
> + * spk_na_mask is used to store unused channels in mid of the channel
> + * allocations. These particular channels are then considered as active channels
> + * For instance:
> + *    CA_ID 0x02: CA =  (FL, FR, 0, FC) => spk_na_mask = 0x04, channels = 4
> + *    CA_ID 0x04: CA =  (FL, FR, 0, 0, RC) => spk_na_mask = 0x03C, channels = 5
> + */
> +static void hdmi_codec_cea_init_channel_alloc(void)
> +{
> +	int i, j, k, last;
> +	struct hdmi_codec_cea_spk_alloc *p;
> +
> +	/* Test if not already done by another instance */
> +	if (hdmi_codec_channel_alloc[0].channels)
> +		return;
> +
> +	for (i = 0; i < ARRAY_SIZE(hdmi_codec_channel_alloc); i++) {
> +		p = hdmi_codec_channel_alloc + i;
> +		p->spks_mask = 0;
> +		p->spk_na_mask = 0;
> +		last = HDMI_MAX_SPEAKERS;
> +		for (j = 0, k = 7; j < HDMI_MAX_SPEAKERS; j++, k--) {
> +			if (p->speakers[j]) {
> +				p->spks_mask |= p->speakers[j];
> +				if (last == HDMI_MAX_SPEAKERS)
> +					last = j;
> +			} else if (last != HDMI_MAX_SPEAKERS) {
> +				p->spk_na_mask |= 1 << k;
> +			}
> +		}
> +		p->channels = 8 - last;
> +	}
> +}
> +
> +static int hdmi_codec_get_ch_alloc_table_idx(struct hdmi_codec_priv *hcp,
> +					     unsigned char channels)
> +{
> +	int i;
> +	u8 spk_alloc;
> +	unsigned long spk_mask;
> +	struct hdmi_codec_cea_spk_alloc *cap = hdmi_codec_channel_alloc;
> +
> +	spk_alloc = drm_eld_get_spk_alloc(hcp->eld);
> +	spk_mask = hdmi_codec_spk_mask_from_alloc(spk_alloc);
> +
> +	for (i = 0; i < ARRAY_SIZE(hdmi_codec_channel_alloc); i++, cap++) {
> +		if (cap->channels != channels)
> +			continue;
> +		if (!(cap->spks_mask == (spk_mask & cap->spks_mask)))
> +			continue;
> +		return i;
> +	}
> +
If HDMI cable not plugged, ELD is empty. In this case this function
returns an error. For backward compatible, it should not return an error
but a default allocation that should be stereo.

> +	return -EINVAL;
> +}
> +
> +static void hdmi_cea_alloc_to_tlv_spks(struct hdmi_codec_cea_spk_alloc *cap,
> +				       unsigned char *chmap)
> +{
> +	int count = 0;
> +	int c, spk;
> +
> +	/* Detect unused channels in cea caps, tag them as N/A channel in TLV */
> +	for (c = 0; c < HDMI_MAX_SPEAKERS; c++) {
> +		spk = cap->speakers[7 - c];
> +		if (cap->spk_na_mask & BIT(c))
> +			chmap[count++] = SNDRV_CHMAP_NA;
> +		else
> +			chmap[count++] = snd_hdac_spk_to_chmap(spk);
> +	}
> +}
> +
> +static void hdmi_cea_alloc_to_tlv_chmap(struct hdmi_codec_priv *hcp,
> +					struct hdmi_codec_cea_spk_alloc *cap)
> +{
> +	unsigned int chs, count = 0;
> +	struct snd_pcm_chmap *info = hcp->chmap_info;
> +	struct snd_pcm_chmap_elem *chmap = info->chmap;
> +	unsigned long max_chs = info->max_channels;
> +	int num_ca = ARRAY_SIZE(hdmi_codec_channel_alloc);
> +	int spk_alloc, spk_mask;
> +
> +	spk_alloc = drm_eld_get_spk_alloc(hcp->eld);
> +	spk_mask = hdmi_codec_spk_mask_from_alloc(spk_alloc);
> +
> +	for (chs = 2; chs <= max_chs; chs++) {
> +		int i;
> +		struct hdmi_codec_cea_spk_alloc *cap;
> +
> +		cap = hdmi_codec_channel_alloc;
> +		for (i = 0; i < num_ca; i++, cap++) {
> +			if (cap->channels != chs)
> +				continue;
> +
> +			if (!(cap->spks_mask == (spk_mask & cap->spks_mask)))
> +				continue;
> +
> +			chmap[count].channels = cap->channels;
> +			hdmi_cea_alloc_to_tlv_spks(cap, chmap[count].map);
> +			count++;
> +		}
> +	}
> +
> +	/* Force last one to 0 to indicate end of available allocations */
> +	chmap[count].channels = 0;
> +}
> +
