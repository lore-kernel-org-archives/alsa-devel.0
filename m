From: Yang Kuankuan <ykk@rock-chips.com>
Subject: Re: [PATCH RFC 02/11] drm: bridge/dw_hdmi: use
	drm_hdmi_avi_infoframe_from_display_mode()
Date: Tue, 31 Mar 2015 05:02:20 -0400
Message-ID: <551A629C.5010306@rock-chips.com>
References: <20150330193911.GM24899@n2100.arm.linux.org.uk>
 <E1YcfXa-0002uU-E3@rmk-PC.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from regular1.263xmail.com (regular1.263xmail.com [211.150.99.135])
 by alsa0.perex.cz (Postfix) with ESMTP id 97013260621
 for <alsa-devel@alsa-project.org>; Tue, 31 Mar 2015 11:01:38 +0200 (CEST)
In-Reply-To: <E1YcfXa-0002uU-E3@rmk-PC.arm.linux.org.uk>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Russell King <rmk+kernel@arm.linux.org.uk>, alsa-devel@alsa-project.org, dri-devel@lists.freedesktop.org, linux-arm-kernel@lists.infradead.org
Cc: Fabio Estevam <fabio.estevam@freescale.com>, David Airlie <airlied@linux.ie>, Mark Brown <broonie@kernel.org>, Philipp Zabel <p.zabel@pengutronix.de>
List-Id: alsa-devel@alsa-project.org

Hi Russell,

On 03/30/2015 03:40 PM, Russell King wrote:
> Use drm_hdmi_avi_infoframe_from_display_mode() to compose the AVI
> frame.

Very interesting, I am also preparing the 
drm_hdmi_avi_infoframe_from_display_mode
patches to upstream, seems it is unnecessary now :)

Besides, as you are going an dw_hdmi cleanups, I want to point another 
bugs that relate
to the HDMI CTS test. There are somethings wrong with General Control 
Pack, as for now
the encoder color depth is 8-bit packing mode, so the color depth only 
support 24 bits per
pixel video, In this case the CD filed in GCP should set to "Color Depth 
Not indicated".
In the end we should keep the *csc_color_depth(HDMI_CSC_SCALE)* &
*color_depth(HDMI_VP_PR_CD)* to zero, code should modify like this GCP 
would test pass:

diff --git a/drivers/gpu/drm/bridge/dw_hdmi.c 
b/drivers/gpu/drm/bridge/dw_hdmi.c
index bf5be679..c5d9b16 100644
--- a/drivers/gpu/drm/bridge/dw_hdmi.c
+++ b/drivers/gpu/drm/bridge/dw_hdmi.c
@@ -695,7 +695,7 @@ static void hdmi_video_packetize(struct dw_hdmi *hdmi)
                 if (!hdmi_data->enc_color_depth) {
                         output_select = 
HDMI_VP_CONF_OUTPUT_SELECTOR_BYPASS;
                 } else if (hdmi_data->enc_color_depth == 8) {
-                       color_depth = 4;
+                       color_depth = 0;
                         output_select = 
HDMI_VP_CONF_OUTPUT_SELECTOR_BYPASS;
                 } else if (hdmi_data->enc_color_depth == 10) {
                         color_depth = 5;

Best regards.
Yakir Yang
> Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>
> ---
>   drivers/gpu/drm/bridge/dw_hdmi.c | 126 +++++++++++++++++++++------------------
>   1 file changed, 67 insertions(+), 59 deletions(-)
>
> diff --git a/drivers/gpu/drm/bridge/dw_hdmi.c b/drivers/gpu/drm/bridge/dw_hdmi.c
> index 49df6c8c4ea8..44c63883db19 100644
> --- a/drivers/gpu/drm/bridge/dw_hdmi.c
> +++ b/drivers/gpu/drm/bridge/dw_hdmi.c
> @@ -919,74 +919,79 @@ static void hdmi_tx_hdcp_config(struct dw_hdmi *hdmi)
>   		  HDMI_A_HDCPCFG1_ENCRYPTIONDISABLE_MASK, HDMI_A_HDCPCFG1);
>   }
>   
> -static void hdmi_config_AVI(struct dw_hdmi *hdmi)
> +static void hdmi_config_AVI(struct dw_hdmi *hdmi, struct drm_display_mode *mode)
>   {
> -	u8 val, pix_fmt, under_scan;
> -	u8 act_ratio, coded_ratio, colorimetry, ext_colorimetry;
> -	bool aspect_16_9;
> +	struct hdmi_avi_infoframe frame;
> +	u8 val;
>   
> -	aspect_16_9 = false; /* FIXME */
> +	/* Initialise info frame from DRM mode */
> +	drm_hdmi_avi_infoframe_from_display_mode(&frame, mode);
>   
> -	/* AVI Data Byte 1 */
>   	if (hdmi->hdmi_data.enc_out_format == YCBCR444)
> -		pix_fmt = HDMI_FC_AVICONF0_PIX_FMT_YCBCR444;
> +		frame.colorspace = HDMI_COLORSPACE_YUV444;
>   	else if (hdmi->hdmi_data.enc_out_format == YCBCR422_8BITS)
> -		pix_fmt = HDMI_FC_AVICONF0_PIX_FMT_YCBCR422;
> +		frame.colorspace = HDMI_COLORSPACE_YUV422;
>   	else
> -		pix_fmt = HDMI_FC_AVICONF0_PIX_FMT_RGB;
> -
> -		under_scan =  HDMI_FC_AVICONF0_SCAN_INFO_NODATA;
> -
> -	/*
> -	 * Active format identification data is present in the AVI InfoFrame.
> -	 * Under scan info, no bar data
> -	 */
> -	val = pix_fmt | under_scan |
> -		HDMI_FC_AVICONF0_ACTIVE_FMT_INFO_PRESENT |
> -		HDMI_FC_AVICONF0_BAR_DATA_NO_DATA;
> -
> -	hdmi_writeb(hdmi, val, HDMI_FC_AVICONF0);
> -
> -	/* AVI Data Byte 2 -Set the Aspect Ratio */
> -	if (aspect_16_9) {
> -		act_ratio = HDMI_FC_AVICONF1_ACTIVE_ASPECT_RATIO_16_9;
> -		coded_ratio = HDMI_FC_AVICONF1_CODED_ASPECT_RATIO_16_9;
> -	} else {
> -		act_ratio = HDMI_FC_AVICONF1_ACTIVE_ASPECT_RATIO_4_3;
> -		coded_ratio = HDMI_FC_AVICONF1_CODED_ASPECT_RATIO_4_3;
> -	}
> +		frame.colorspace = HDMI_COLORSPACE_RGB;
>   
>   	/* Set up colorimetry */
>   	if (hdmi->hdmi_data.enc_out_format == XVYCC444) {
> -		colorimetry = HDMI_FC_AVICONF1_COLORIMETRY_EXTENDED_INFO;
> +		frame.colorimetry = HDMI_COLORIMETRY_EXTENDED;
>   		if (hdmi->hdmi_data.colorimetry == HDMI_COLORIMETRY_ITU_601)
> -			ext_colorimetry =
> -				HDMI_FC_AVICONF2_EXT_COLORIMETRY_XVYCC601;
> +			frame.extended_colorimetry =
> +				HDMI_EXTENDED_COLORIMETRY_XV_YCC_601;
>   		else /*hdmi->hdmi_data.colorimetry == HDMI_COLORIMETRY_ITU_709*/
> -			ext_colorimetry =
> -				HDMI_FC_AVICONF2_EXT_COLORIMETRY_XVYCC709;
> +			frame.extended_colorimetry =
> +				HDMI_EXTENDED_COLORIMETRY_XV_YCC_709;
>   	} else if (hdmi->hdmi_data.enc_out_format != RGB) {
>   		if (hdmi->hdmi_data.colorimetry == HDMI_COLORIMETRY_ITU_601)
> -			colorimetry = HDMI_FC_AVICONF1_COLORIMETRY_SMPTE;
> +			frame.colorimetry = HDMI_COLORIMETRY_ITU_601;
>   		else /*hdmi->hdmi_data.colorimetry == HDMI_COLORIMETRY_ITU_709*/
> -			colorimetry = HDMI_FC_AVICONF1_COLORIMETRY_ITUR;
> -		ext_colorimetry = HDMI_FC_AVICONF2_EXT_COLORIMETRY_XVYCC601;
> +			frame.colorimetry = HDMI_COLORIMETRY_ITU_709;
> +		frame.extended_colorimetry = HDMI_EXTENDED_COLORIMETRY_XV_YCC_601;
>   	} else { /* Carries no data */
> -		colorimetry = HDMI_FC_AVICONF1_COLORIMETRY_NO_DATA;
> -		ext_colorimetry = HDMI_FC_AVICONF2_EXT_COLORIMETRY_XVYCC601;
> +		frame.colorimetry = HDMI_COLORIMETRY_NONE;
> +		frame.extended_colorimetry = HDMI_EXTENDED_COLORIMETRY_XV_YCC_601;
>   	}
>   
> -	val = colorimetry | coded_ratio | act_ratio;
> +	frame.scan_mode = HDMI_SCAN_MODE_NONE;
> +
> +	/*
> +	 * The Designware IP uses a different byte format from standard
> +	 * AVI info frames, though generally the bits are in the correct
> +	 * bytes.
> +	 */
> +
> +	/*
> +	 * AVI data byte 1 differences: Colorspace in bits 4,5 rather than 5,6,
> +	 * active aspect present in bit 6 rather than 4.
> +	 */
> +	val = (frame.colorspace & 3) << 4 | (frame.scan_mode & 0x3);
> +	if (frame.active_aspect & 15)
> +		val |= HDMI_FC_AVICONF0_ACTIVE_FMT_INFO_PRESENT;
> +	if (frame.top_bar || frame.bottom_bar)
> +		val |= HDMI_FC_AVICONF0_BAR_DATA_HORIZ_BAR;
> +	if (frame.left_bar || frame.right_bar)
> +		val |= HDMI_FC_AVICONF0_BAR_DATA_VERT_BAR;
> +	hdmi_writeb(hdmi, val, HDMI_FC_AVICONF0);
> +
> +	/* AVI data byte 2 differences: none */
> +	val = ((frame.colorimetry & 0x3) << 6) |
> +	      ((frame.picture_aspect & 0x3) << 4) |
> +	      (frame.active_aspect & 0xf);
>   	hdmi_writeb(hdmi, val, HDMI_FC_AVICONF1);
>   
> -	/* AVI Data Byte 3 */
> -	val = HDMI_FC_AVICONF2_IT_CONTENT_NO_DATA | ext_colorimetry |
> -		HDMI_FC_AVICONF2_RGB_QUANT_DEFAULT |
> -		HDMI_FC_AVICONF2_SCALING_NONE;
> +	/* AVI data byte 3 differences: none */
> +	val = ((frame.extended_colorimetry & 0x7) << 4) |
> +	      ((frame.quantization_range & 0x3) << 2) |
> +	      (frame.nups & 0x3);
> +	if (frame.itc)
> +		val |= HDMI_FC_AVICONF2_IT_CONTENT_VALID;
>   	hdmi_writeb(hdmi, val, HDMI_FC_AVICONF2);
>   
> -	/* AVI Data Byte 4 */
> -	hdmi_writeb(hdmi, hdmi->vic, HDMI_FC_AVIVID);
> +	/* AVI data byte 4 differences: none */
> +	val = frame.video_code & 0x7f;
> +	hdmi_writeb(hdmi, val, HDMI_FC_AVIVID);
>   
>   	/* AVI Data Byte 5- set up input and output pixel repetition */
>   	val = (((hdmi->hdmi_data.video_mode.mpixelrepetitioninput + 1) <<
> @@ -997,20 +1002,23 @@ static void hdmi_config_AVI(struct dw_hdmi *hdmi)
>   		HDMI_FC_PRCONF_OUTPUT_PR_FACTOR_MASK);
>   	hdmi_writeb(hdmi, val, HDMI_FC_PRCONF);
>   
> -	/* IT Content and quantization range = don't care */
> -	val = HDMI_FC_AVICONF3_IT_CONTENT_TYPE_GRAPHICS |
> -		HDMI_FC_AVICONF3_QUANT_RANGE_LIMITED;
> +	/*
> +	 * AVI data byte 5 differences: content type in 0,1 rather than 4,5,
> +	 * ycc range in bits 2,3 rather than 6,7
> +	 */
> +	val = ((frame.ycc_quantization_range & 0x3) << 2) |
> +	      (frame.content_type & 0x3);
>   	hdmi_writeb(hdmi, val, HDMI_FC_AVICONF3);
>   
>   	/* AVI Data Bytes 6-13 */
> -	hdmi_writeb(hdmi, 0, HDMI_FC_AVIETB0);
> -	hdmi_writeb(hdmi, 0, HDMI_FC_AVIETB1);
> -	hdmi_writeb(hdmi, 0, HDMI_FC_AVISBB0);
> -	hdmi_writeb(hdmi, 0, HDMI_FC_AVISBB1);
> -	hdmi_writeb(hdmi, 0, HDMI_FC_AVIELB0);
> -	hdmi_writeb(hdmi, 0, HDMI_FC_AVIELB1);
> -	hdmi_writeb(hdmi, 0, HDMI_FC_AVISRB0);
> -	hdmi_writeb(hdmi, 0, HDMI_FC_AVISRB1);
> +	hdmi_writeb(hdmi, frame.top_bar & 0xff, HDMI_FC_AVIETB0);
> +	hdmi_writeb(hdmi, (frame.top_bar >> 8) & 0xff, HDMI_FC_AVIETB1);
> +	hdmi_writeb(hdmi, frame.bottom_bar & 0xff, HDMI_FC_AVISBB0);
> +	hdmi_writeb(hdmi, (frame.bottom_bar >> 8) & 0xff, HDMI_FC_AVISBB1);
> +	hdmi_writeb(hdmi, frame.left_bar & 0xff, HDMI_FC_AVIELB0);
> +	hdmi_writeb(hdmi, (frame.left_bar >> 8) & 0xff, HDMI_FC_AVIELB1);
> +	hdmi_writeb(hdmi, frame.right_bar & 0xff, HDMI_FC_AVISRB0);
> +	hdmi_writeb(hdmi, (frame.right_bar >> 8) & 0xff, HDMI_FC_AVISRB1);
>   }
>   
>   static void hdmi_av_composer(struct dw_hdmi *hdmi,
> @@ -1244,7 +1252,7 @@ static int dw_hdmi_setup(struct dw_hdmi *hdmi, struct drm_display_mode *mode)
>   		hdmi_enable_audio_clk(hdmi);
>   
>   		/* HDMI Initialization Step F - Configure AVI InfoFrame */
> -		hdmi_config_AVI(hdmi);
> +		hdmi_config_AVI(hdmi, mode);
>   	}
>   
>   	hdmi_video_packetize(hdmi);
