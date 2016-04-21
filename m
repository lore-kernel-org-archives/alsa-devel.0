From: Arnaud Pouliquen <arnaud.pouliquen@st.com>
Subject: Re: [PATCH v3 1/2] video: hdmi: add helper function
	for N and CTS
Date: Thu, 21 Apr 2016 15:52:24 +0200
Message-ID: <5718DB18.4040301@st.com>
References: <1461226077-25273-1-git-send-email-arnaud.pouliquen@st.com>
 <1461226077-25273-2-git-send-email-arnaud.pouliquen@st.com>
 <1461242368.4695.27.camel@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx07-00178001.pphosted.com (mx08-00178001.pphosted.com
 [91.207.212.93])
 by alsa0.perex.cz (Postfix) with ESMTP id 952112612CC
 for <alsa-devel@alsa-project.org>; Thu, 21 Apr 2016 15:52:30 +0200 (CEST)
In-Reply-To: <1461242368.4695.27.camel@pengutronix.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Philipp Zabel <p.zabel@pengutronix.de>
Cc: Jean-Francois Moine <moinejf@free.fr>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, Lars-Peter Clausen <lars@metafoo.de>, Russell King - ARM Linux <linux@arm.linux.org.uk>, David Airlie <airlied@linux.ie>, Liam Girdwood <lgirdwood@gmail.com>, "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>, Takashi Iwai <tiwai@suse.de>, Mark Brown <broonie@kernel.org>, Jyri Sarha <jsarha@ti.com>, Benjamin Gaignard <benjamin.gaignard@linaro.org>
List-Id: alsa-devel@alsa-project.org



On 04/21/2016 02:39 PM, Philipp Zabel wrote:
> Hi Arnaud,
> 
> Am Donnerstag, den 21.04.2016, 10:07 +0200 schrieb Arnaud Pouliquen:
>> Add helper function to compute HDMI CTS and N parameters
>> Implementation is based on HDMI 1.4b specification.
>>
>> Signed-off-by: Arnaud Pouliquen <arnaud.pouliquen@st.com>
>> Acked-by: Benjamin Gaignard <benjamin.gaignard@linaro.org>
>> Acked-by: Vincent ABRIOU <vincent.abriou@st.com>
> 
> Reviewed-by: Philipp Zabel <p.zabel@pengutronix.de>
> 
>> ---
>>  drivers/video/hdmi.c | 202 +++++++++++++++++++++++++++++++++++++++++++++++++++
>>  include/linux/hdmi.h |  22 ++++++
>>  2 files changed, 224 insertions(+)
>>
>> diff --git a/drivers/video/hdmi.c b/drivers/video/hdmi.c
>> index 1626892..6381ce0 100644
>> --- a/drivers/video/hdmi.c
>> +++ b/drivers/video/hdmi.c
>> @@ -1242,3 +1242,205 @@ int hdmi_infoframe_unpack(union hdmi_infoframe *frame, void *buffer)
>>  	return ret;
>>  }
>>  EXPORT_SYMBOL(hdmi_infoframe_unpack);
>> +
>> +/**
>> + * audio clock regeneration (acr) parameters
>> + * N and CTS computation are based on HDMI specification 1.4b
>> + */
>> +enum audio_rate {
>> +	HDMI_AUDIO_N_CTS_32KHZ,
>> +	HDMI_AUDIO_N_CTS_44_1KHZ,
>> +	HDMI_AUDIO_N_CTS_48KHZ,
>> +};
>> +
>> +struct hdmi_audio_acr {
>> +	unsigned int tmds_clk;
>> +	struct hdmi_audio_n_cts n_cts;
>> +};
>> +
>> +static const struct hdmi_audio_acr hdmi_audio_standard_acr[3][12] = {
>> +	{ /*32 kHz*/
> 
> If you used
> 
> 	[HDMI_AUDIO_N_CTS_32KHZ] = {
> 
> instead, that would mirror how the array is indexed via audio_freq_id in
> hdmi_audio_get_coherent_n_cts below.
> 
>> +		{  25174825, {  4576,  28125, 0 } }, /* 25,20/1.001  MHz */
>                                                            ^
> s/,/./
> 
>> +		{  25200000, {  4096,  25200, 0 } }, /* 25.20        MHz */
>> +		{  27000000, {  4096,  27000, 0 } }, /* 27.00        MHz */
>> +		{  27027000, {  4096,  27027, 0 } }, /* 27.00*1.001  MHz */
>> +		{  54000000, {  4096,  54000, 0 } }, /* 54.00        MHz */
>> +		{  54054000, {  4096,  54054, 0 } }, /* 54.00*1.001  MHz */
>> +		{  74175824, { 11648, 210937, 50 } }, /* 74.25/1.001  MHz */
>> +		{  74250000, {  4096,  74250, 0 } }, /* 74.25        MHz */
>> +		{ 148351648, { 11648, 421875, 0 } }, /* 148.50/1.001 MHz */
>> +		{ 148500000, {  4096, 148500, 0 } }, /* 148.50       MHz */
>> +		{ 296703296, {  5824, 421875, 0 } }, /* 297/1.001    MHz */
>                            ^
> Maybe add a comment above that tmds_clk is rounded down?
My apologize, I have forgotten to add 296703297 value to take into
account truncated and rounded values as discussed in V2:
		{ 296703296, {  5824, 421875, 0 } }, /* 297/1.001    MHz (truncated) */
	        { 296703297, { 5824, 421875, 0 } }, /* 297/1.001 MHz (rounded) */

> 
>> +		{ 297000000, {  3072, 222750, 0 } }, /* 297          MHz */
>> +	},
>> +	{ /*44.1 kHz, 88.2 kHz  176.4 kHz*/
>> +		{  25174825, {  7007,  31250, 0 } }, /* 25,20/1.001  MHz */
>> +		{  25200000, {  6272,  28000, 0 } }, /* 25.20        MHz */
>> +		{  27000000, {  6272,  30000, 0 } }, /* 27.00        MHz */
>> +		{  27027000, {  6272,  30030, 0 } }, /* 27.00*1.001  MHz */
>> +		{  54000000, {  6272,  60000, 0 } }, /* 54.00        MHz */
>> +		{  54054000, {  6272,  60060, 0 } }, /* 54.00*1.001  MHz */
>> +		{  74175824, { 17836, 234375, 0 } }, /* 74.25/1.001  MHz */
>> +		{  74250000, {  6272,  82500, 0 } }, /* 74.25        MHz */
>> +		{ 148351648, {  8918, 234375, 0 } }, /* 148.50/1.001 MHz */
>> +		{ 148500000, {  6272, 165000, 0 } }, /* 148.50       MHz */
>> +		{ 296703296, {  4459, 234375, 0 } }, /* 297/1.001    MHz */
>> +		{ 297000000, {  4704, 247500, 0 } }, /* 297          MHz */
>> +	},
>> +	{ /*48 kHz, 96 kHz  192 kHz*/
>> +		{  25174825, {  6864,  28125, 0 } }, /* 25,20/1.001  MHz */
>> +		{  25200000, {  6144,  25200, 0 } }, /* 25.20        MHz */
>> +		{  27000000, {  6144,  27000, 0 } }, /* 27.00        MHz */
>> +		{  27027000, {  6144,  27027, 0 } }, /* 27.00*1.001  MHz */
>> +		{  54000000, {  6144,  54000, 0 } }, /* 54.00        MHz */
>> +		{  54054000, {  6144,  54054, 0 } }, /* 54.00*1.001  MHz */
>> +		{  74175824, { 11648, 140625, 0 } }, /* 74.25/1.001  MHz */
>> +		{  74250000, {  6144,  74250, 0 } }, /* 74.25        MHz */
>> +		{ 148351648, {  5824, 140625, 0 } }, /* 148.50/1.001 MHz */
>> +		{ 148500000, {  6144, 148500, 0 } }, /* 148.50       MHz */
>> +		{ 296703296, {  5824, 281250, 0 } }, /* 297/1.001    MHz */
>> +		{ 297000000, {  5120, 247500, 0 } }, /* 297          MHz */
>> +	}
>> +};
>> +
>> +/**
>> + * hdmi_audio_get_coherent_n_cts() - compute N and CTS parameters for coherent
>> + * clocks. Coherent clock means that audio and TMDS clocks have the same
>> + * source (no drifts between clocks).
>> + *
>> + * @audio_fs: audio frame clock frequency in Hz
>> + * @tmds_clk: HDMI TMDS clock frequency in Hz
>> + * @n_cts: N and CTS parameter returned to user
>> + *
>> + * Values computed are based on table described in HDMI specification 1.4b
>> + *
>> + * Returns 0 on success or a negative error code on failure.
>> + */
>> +int hdmi_audio_get_coherent_n_cts(unsigned int audio_fs,
>> +				  unsigned int tmds_clk,
>> +				  struct hdmi_audio_n_cts *n_cts)
>> +{
>> +	int audio_freq_id, i;
>> +	int rate_coeff = 1;
>> +	u64 val, min;
>> +	const struct hdmi_audio_acr  *acr_table;
>> +	const struct hdmi_audio_n_cts *predef_n_cts = NULL;
>> +
>> +	switch (audio_fs) {
>> +	case 32000:
>> +		audio_freq_id = HDMI_AUDIO_N_CTS_32KHZ;
>> +		n_cts->n = 4096;
>> +		break;
>> +	case 44100:
>> +		audio_freq_id = HDMI_AUDIO_N_CTS_44_1KHZ;
>> +		n_cts->n = 6272;
>> +		break;
>> +	case 48000:
>> +		audio_freq_id = HDMI_AUDIO_N_CTS_48KHZ;
>> +		n_cts->n = 6144;
>> +		break;
>> +	case 88200:
>> +		audio_freq_id = HDMI_AUDIO_N_CTS_44_1KHZ;
>> +		rate_coeff = 2;
>> +		n_cts->n = 6272 * 2;
>> +		break;
>> +	case 96000:
>> +		audio_freq_id = HDMI_AUDIO_N_CTS_48KHZ;
>> +		rate_coeff = 2;
>> +		n_cts->n = 6144 * 2;
>> +		break;
>> +	case 176400:
>> +		audio_freq_id = HDMI_AUDIO_N_CTS_44_1KHZ;
>> +		rate_coeff = 4;
>> +		n_cts->n = 6272 * 4;
>> +		break;
>> +	case 192000:
>> +		audio_freq_id = HDMI_AUDIO_N_CTS_48KHZ;
>> +		rate_coeff = 4;
>> +		n_cts->n = 6144 * 4;
>> +		break;
>> +	default:
>> +		return -EINVAL;
>> +	}
>> +
>> +	acr_table = hdmi_audio_standard_acr[audio_freq_id];
>> +	for (i = 0; i < ARRAY_SIZE(hdmi_audio_standard_acr[0]); i++) {
>> +		if (tmds_clk == acr_table[i].tmds_clk) {
>> +			predef_n_cts = &acr_table[i].n_cts;
>> +			n_cts->n = predef_n_cts->n * rate_coeff;
>> +			n_cts->cts = predef_n_cts->cts;
>> +			n_cts->cts_1_ratio = predef_n_cts->cts_1_ratio;
>> +			return 0;
>> +		}
>> +	}
>> +
>> +	/*
>> +	* predefined frequency not found. Compute CTS using formula:
>          ^
>> +	* CTS = (Ftdms_clk * N) / (128* audio_fs)
>          ^                             ^
>> +	*/
>          ^
> Missing spaces.
> 
>> +	val = (u64)tmds_clk * n_cts->n;
>> +	n_cts->cts = div64_u64(val, 128UL * audio_fs);
>> +
>> +	n_cts->cts_1_ratio = 0;
>> +	min = (u64)n_cts->cts * 128UL * audio_fs;
>> +	if (min < (val)) {
>                    ^   ^
> These parentheses are not needed.
> 
>> +		/*
>> +		* non-accurate value for CTS
>                  ^
>> +		* compute ratio, needed by user to alternate in ACR
>                  ^
>> +		* between CTS and CTS + 1 value.
>                  ^
>> +		*/
>                  ^
> Missing spaces.
> 
>> +		n_cts->cts_1_ratio = 100 - ((u32)(val - min)) * 100 /
>> +					    (128 * audio_fs);
> 
> I don't understand the purpose of the (100-x) above (and how cts_1_ratio
> is supposed to be used).
> 
> When for example val == (min + 0.3 * 128 * audio_fs) then
> cts_1_ratio = 70.
> To achieve an average CTS of (val), shouldn't (min) be used 70% of the
> time and (min+1) be used 30% of the time?
> I would have expected (cts_1_ratio == 30) in that case.

you are right! my reasoning is foolish... Thank for pointing this error!

>>  
>> +/**
>> + * struct hdmi_audio_n_cts - n and cts parameter for ACR packets
>> + * @n: N parameter
>> + * @cts: CTS parameter
>> + * @cts_1_ratio: ratio from 0 to 99 to alternate "CTS" and "CTS + 1" values
>> + *  ratio = 0: CTS parameter is accurate, no need to alternate with "CTS + 1"
>> + *             value
>> + *  ratio = x: Need to alternate with ACR "CTS + 1" value x% of the time to
>> + *             generate accurate audio clock
> 
> Does this mean that at cts_1_ratio == 30, CTS should be used 70% of the
> time, and CTS+1 should be used 30% of the time, or the other way around?
yes CTS should be used 70% of the time, i will add example in comment
> 
>> + */
>> +struct hdmi_audio_n_cts {
>> +	unsigned int n;
>> +	unsigned int cts;
>> +	unsigned int cts_1_ratio;
>> +};
>> +
>> +int hdmi_audio_get_coherent_n_cts(unsigned int audio_fs,
>> +				  unsigned int tmds_clk,
>> +				  struct hdmi_audio_n_cts *n_cts);
>> +
>> +int hdmi_audio_get_non_coherent_n(unsigned int audio_fs);
>> +
>>  #endif /* _DRM_HDMI_H */
> 
> regards
> Philipp
> 
thanks and Regards
Arnaud
