From: Philipp Zabel <p.zabel@pengutronix.de>
Subject: Re: [RFC v2 1/6] video: hdmi: add helper function for
	N and CTS
Date: Thu, 18 Feb 2016 15:20:50 +0100
Message-ID: <1455805250.3937.19.camel@pengutronix.de>
References: <1453484912-24547-1-git-send-email-arnaud.pouliquen@st.com>
 <1453484912-24547-2-git-send-email-arnaud.pouliquen@st.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from metis.ext.4.pengutronix.de (metis.ext.4.pengutronix.de
 [92.198.50.35]) by alsa0.perex.cz (Postfix) with ESMTP id EFF22260694
 for <alsa-devel@alsa-project.org>; Thu, 18 Feb 2016 15:20:58 +0100 (CET)
In-Reply-To: <1453484912-24547-2-git-send-email-arnaud.pouliquen@st.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Arnaud Pouliquen <arnaud.pouliquen@st.com>
Cc: Jean-Francois Moine <moinejf@free.fr>, alsa-devel@alsa-project.org, Lars-Peter Clausen <lars@metafoo.de>, Russell King - ARM Linux <linux@arm.linux.org.uk>, David Airlie <airlied@linux.ie>, Liam Girdwood <lgirdwood@gmail.com>, Jyri Sarha <jsarha@ti.com>, Takashi Iwai <tiwai@suse.de>, Mark Brown <broonie@kernel.org>, Benjamin Gaignard <benjamin.gaignard@linaro.org>
List-Id: alsa-devel@alsa-project.org

Hi Arnaud,

Am Freitag, den 22.01.2016, 18:48 +0100 schrieb Arnaud Pouliquen:
> From: Moise Gergaud <moise.gergaud@st.com>
> 
> Add helper function to compute HDMI CTS and N parameters.
> Implementation is based on HDMI 1.4b specification.
> 
> Signed-off-by: Arnaud Pouliquen <arnaud.pouliquen@st.com>

Reviewed-by: Philipp Zabel <p.zabel@pengutronix.de>
Tested-by: Philipp Zabel <p.zabel@pengutronix.de>

> ---
>  drivers/video/hdmi.c | 222 +++++++++++++++++++++++++++++++++++++++++++++++++++
>  include/linux/hdmi.h |  22 +++++
>  2 files changed, 244 insertions(+)
> 
> diff --git a/drivers/video/hdmi.c b/drivers/video/hdmi.c
> index 1626892..be8b8ed 100644
> --- a/drivers/video/hdmi.c
> +++ b/drivers/video/hdmi.c
> @@ -1242,3 +1242,225 @@ int hdmi_infoframe_unpack(union hdmi_infoframe *frame, void *buffer)
>  	return ret;
>  }
>  EXPORT_SYMBOL(hdmi_infoframe_unpack);
> +
> +/**
> + * audio clock regeneration (acr) parameters
> + * N and CTS computation are based on HDMI specification 1.4b
> + */
> +enum audio_rate {
> +	HDMI_AUDIO_N_CTS_32KHZ,
> +	HDMI_AUDIO_N_CTS_44_1KHZ,
> +	HDMI_AUDIO_N_CTS_48KHZ,
> +};
> +
> +struct hdmi_audio_acr {
> +	unsigned int tmds_clk;
> +	struct hdmi_audio_n_cts n_cts;
> +};
> +
> +static const struct hdmi_audio_acr hdmi_audio_standard_acr[3][12] = {
> +	{ /*32 kHz*/
> +		{  25174825, {  4576,  28125, 0 } }, /* 25,20/1.001  MHz */
> +		{  25200000, {  4096,  25200, 0 } }, /* 25.20        MHz */
> +		{  27000000, {  4096,  27000, 0 } }, /* 27.00        MHz */
> +		{  27027000, {  4096,  27027, 0 } }, /* 27.00*1.001  MHz */
> +		{  54000000, {  4096,  54000, 0 } }, /* 54.00        MHz */
> +		{  54054000, {  4096,  54054, 0 } }, /* 54.00*1.001  MHz */
> +		{  74175824, { 11648, 210937, 50 } }, /* 74.25/1.001  MHz */
> +		{  74250000, {  4096,  74250, 0 } }, /* 74.25        MHz */
> +		{ 148351648, { 11648, 421875, 0 } }, /* 148.50/1.001 MHz */
> +		{ 148500000, {  4096, 148500, 0 } }, /* 148.50       MHz */
> +		{ 296703296, {  5824, 421875, 0 } }, /* 297/1.001    MHz */

297/1.001 is about 296703296.7. Should this be rounded to 296703297 ?

regards
Philipp
