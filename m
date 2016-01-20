From: Arnaud Pouliquen <arnaud.pouliquen@st.com>
Subject: Re: [RFC 1/6] video: hdmi: add helper function for N
	and CTS
Date: Wed, 20 Jan 2016 14:26:08 +0100
Message-ID: <569F8AF0.9000300@st.com>
References: <1453210836-16218-1-git-send-email-arnaud.pouliquen@st.com>
 <1453210836-16218-2-git-send-email-arnaud.pouliquen@st.com>
 <20160119165430.GN19062@n2100.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx07-00178001.pphosted.com (mx07-00178001.pphosted.com
 [62.209.51.94]) by alsa0.perex.cz (Postfix) with ESMTP id D4443260606
 for <alsa-devel@alsa-project.org>; Wed, 20 Jan 2016 14:26:15 +0100 (CET)
In-Reply-To: <20160119165430.GN19062@n2100.arm.linux.org.uk>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Russell King - ARM Linux <linux@arm.linux.org.uk>
Cc: Jean-Francois Moine <moinejf@free.fr>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, Lars-Peter Clausen <lars@metafoo.de>, Philipp Zabel <p.zabel@pengutronix.de>, David Airlie <airlied@linux.ie>, Liam Girdwood <lgirdwood@gmail.com>, Jyri Sarha <jsarha@ti.com>, Takashi Iwai <tiwai@suse.de>, Mark Brown <broonie@kernel.org>, Benjamin Gaignard <benjamin.gaignard@linaro.org>
List-Id: alsa-devel@alsa-project.org



On 01/19/2016 05:54 PM, Russell King - ARM Linux wrote:
> On Tue, Jan 19, 2016 at 02:40:31PM +0100, Arnaud Pouliquen wrote:
>> From: Moise Gergaud <moise.gergaud@st.com>
>>
>> Add helper function to compute HDMI CTS and N parameters
>> Implementation is based on HDMI 1.4b specification.
> 
> You should note that these CTS/N parameters are for where the audio and
> video clocks are coherent: iow, they are derived from the same source.
> If they can drift (because they're generated from different sources)
> then a hardware implementation which automatically calculates CTS is
> needed.
Yes this is the case on STI platform, CTS is computed by hardware. In
this case hdmi driver only takes into account the N value.
> 
> However, some of the values given in the HDMI specs for CTS are actually
> two values, because a single value does not specify the audio clock even
> with the N values given.  For these, the values returned will not give
> an accurate clock - this should also be noted.
In HDMI specs i only see a double value for 32 kHz with TMDS clock at
74.324  MHz. I can add a  alt_CTS params in hdmi_audio_n_cts that will
be not null if alternate a value is needed. Is this something reasonable
for you?
As also suggest Mark, i need to add all the restriction info in code.

> 
> Next, does "pixel clock" make sense when you have pixel repetition?
> Would calling this "tdms_clock" be more accurate to the specification
> and less mis-leading to users?
> 
>> Signed-off-by: Arnaud Pouliquen <arnaud.pouliquen@st.com>
>> ---
>>  drivers/video/hdmi.c | 146 +++++++++++++++++++++++++++++++++++++++++++++++++++
>>  include/linux/hdmi.h |  11 ++++
>>  2 files changed, 157 insertions(+)
>>
>> diff --git a/drivers/video/hdmi.c b/drivers/video/hdmi.c
>> index 1626892..8af33c1 100644
>> --- a/drivers/video/hdmi.c
>> +++ b/drivers/video/hdmi.c
>> @@ -1242,3 +1242,149 @@ int hdmi_infoframe_unpack(union hdmi_infoframe *frame, void *buffer)
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
>> +	unsigned long pixel_clk;
>> +	struct hdmi_audio_n_cts n_cts;
>> +};
>> +
>> +static const struct hdmi_audio_acr hdmi_audio_standard_acr[3][12] = {
>> +	{ /*32 kHz*/
>> +		{  25175, {  4576,  28125 } }, /* 25,20/1.001  MHz */
>> +		{  25200, {  4096,  25200 } }, /* 25.20        MHz */
>> +		{  27000, {  4096,  27000 } }, /* 27.00        MHz */
>> +		{  27027, {  4096,  27027 } }, /* 27.00*1.001  MHz */
>> +		{  54000, {  4096,  54000 } }, /* 54.00        MHz */
>> +		{  54054, {  4096,  54054 } }, /* 54.00*1.001  MHz */
>> +		{  74176, { 11648, 310938 } }, /* 74.25/1.001  MHz */
>> +		{  74250, {  4096,  74250 } }, /* 74.25        MHz */
>> +		{ 148352, { 11648, 421875 } }, /* 148.50/1.001 MHz */
>> +		{ 148500, {  4096, 148500 } }, /* 148.50       MHz */
>> +		{ 296703, {  5824, 421875 } }, /* 297/1.001    MHz */
>> +		{ 297000, {  3072, 222750 } }, /* 297          MHz */
>> +	},
>> +	{ /*44.1 kHz, 88.2 kHz  176.4 kHz*/
>> +		{  25175, {  7007,  31250 } }, /* 25,20/1.001  MHz */
>> +		{  25200, {  6272,  28000 } }, /* 25.20        MHz */
>> +		{  27000, {  6272,  30000 } }, /* 27.00        MHz */
>> +		{  27027, {  6272,  30030 } }, /* 27.00*1.001  MHz */
>> +		{  54000, {  6272,  60000 } }, /* 54.00        MHz */
>> +		{  54054, {  6272,  60060 } }, /* 54.00*1.001  MHz */
>> +		{  74176, { 17836, 234375 } }, /* 74.25/1.001  MHz */
>> +		{  74250, {  6272,  82500 } }, /* 74.25        MHz */
>> +		{ 148352, {  8918, 234375 } }, /* 148.50/1.001 MHz */
>> +		{ 148500, {  6272, 165000 } }, /* 148.50       MHz */
>> +		{ 296703, {  4459, 234375 } }, /* 297/1.001    MHz */
>> +		{ 297000, {  4704, 247500 } }, /* 297          MHz */
>> +	},
>> +	{ /*48 kHz, 96 kHz  192 kHz*/
>> +		{  25175, {  6864,  28125 } }, /* 25,20/1.001  MHz */
>> +		{  25200, {  6144,  25200 } }, /* 25.20        MHz */
>> +		{  27000, {  6144,  27000 } }, /* 27.00        MHz */
>> +		{  27027, {  6144,  27027 } }, /* 27.00*1.001  MHz */
>> +		{  54000, {  6144,  54000 } }, /* 54.00        MHz */
>> +		{  54054, {  6144,  54054 } }, /* 54.00*1.001  MHz */
>> +		{  74176, { 11648, 140625 } }, /* 74.25/1.001  MHz */
>> +		{  74250, {  6144,  74250 } }, /* 74.25        MHz */
>> +		{ 148352, {  5824, 140625 } }, /* 148.50/1.001 MHz */
>> +		{ 148500, {  6144, 148500 } }, /* 148.50       MHz */
>> +		{ 296703, {  5824, 281250 } }, /* 297/1.001    MHz */
>> +		{ 297000, {  5120, 247500 } }, /* 297          MHz */
>> +	}
>> +};
>> +
>> +/**
>> + * hdmi_compute_n_cts() - compute N and CTS parameters
>> + * @audio_fs: audio frame clock frequency in kHz
> 
> This is wrong.  You're expecting values such as 32000 here.  32000kHz
> would be 32MHz, which is way too high for an audio frame clock.  I
> think you mean Hz.
> 
Oops, yes Hz not kHz
>> + * @pixel_clk: pixel clock frequency in kHz
> 
> This is correct though.
> 
>> + * @n_cts: N and CTS parameter returned to user
>> + *
>> + * Values computed are based on table described in HDMI specification 1.4b
>> + *
>> + * Returns 0 on success or a negative error code on failure.
>> + */
>> +int hdmi_audio_compute_n_cts(unsigned int audio_fs, unsigned long pixel_clk,
>> +			     struct hdmi_audio_n_cts *n_cts)
>> +{
>> +	int audio_freq_id, i;
>> +	int ratio = 1;
>> +	const struct hdmi_audio_acr  *acr_table;
>> +	const struct hdmi_audio_n_cts *predef_n_cts = NULL;
>> +
>> +	switch (audio_fs) {
>> +	case 32000:
>> +		audio_freq_id = HDMI_AUDIO_N_CTS_32KHZ;
>> +		n_cts->n = 4096;
>> +		break;
>> +
>> +	case 44100:
>> +		audio_freq_id = HDMI_AUDIO_N_CTS_44_1KHZ;
>> +		n_cts->n = 6272;
>> +		break;
>> +
>> +	case 48000:
>> +		audio_freq_id = HDMI_AUDIO_N_CTS_48KHZ;
>> +		n_cts->n = 6144;
>> +		break;
>> +
>> +	case 88200:
>> +		audio_freq_id = HDMI_AUDIO_N_CTS_44_1KHZ;
>> +		ratio = 2;
>> +		n_cts->n = 6272 * 2;
>> +		break;
>> +
>> +	case 96000:
>> +		audio_freq_id = HDMI_AUDIO_N_CTS_48KHZ;
>> +		ratio = 2;
>> +		n_cts->n = 6144 * 2;
>> +		break;
>> +
>> +	case 176400:
>> +		audio_freq_id = HDMI_AUDIO_N_CTS_44_1KHZ;
>> +		ratio = 4;
>> +		n_cts->n = 6272 * 4;
>> +		break;
>> +
>> +	case 192000:
>> +		audio_freq_id = HDMI_AUDIO_N_CTS_48KHZ;
>> +		ratio = 4;
>> +		n_cts->n = 6144 * 4;
>> +		break;
>> +
>> +	default:
>> +		return -EINVAL;
>> +	}
>> +
>> +	acr_table = hdmi_audio_standard_acr[audio_freq_id];
>> +	for (i = 0; i < ARRAY_SIZE(hdmi_audio_standard_acr[0]); i++) {
>> +		if (pixel_clk == acr_table[i].pixel_clk) {
>> +			predef_n_cts = &acr_table[i].n_cts;
>> +			break;
>> +		}
>> +	}
>> +
>> +	if (!predef_n_cts) {
>> +		/*
>> +		 * predefined frequency not found. Compute CTS using formula:
>> +		 * CTS = (Ftdms_clk * N) / (128* audio_fs)
>> +		 */
>> +		n_cts->cts =  pixel_clk * n_cts->n / (128 * audio_fs);
> 
> This looks like it could overflow.  192kHz audio clock, 297MHz tdms
> clock -> (297000 * 6144 * 4) = 7299072000.  32 bit unsigned math
> overflows beyond 4294967295.
> 
Yes, need to use intermediate 64 bits variable for calculation
