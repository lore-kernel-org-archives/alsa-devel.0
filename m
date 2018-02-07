From: Randy Dunlap <rdunlap@infradead.org>
Subject: Re: [PATCH v8 1/7] v4l2-dv-timings: add
	v4l2_hdmi_colorimetry()
Date: Tue, 6 Feb 2018 17:22:40 -0800
Message-ID: <c1dc5de9-e81d-b9bd-b587-1a94de96f97c@infradead.org>
References: <1517948874-21681-1-git-send-email-tharvey@gateworks.com>
 <1517948874-21681-2-git-send-email-tharvey@gateworks.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from bombadil.infradead.org (bombadil.infradead.org [65.50.211.133])
 by alsa0.perex.cz (Postfix) with ESMTP id D8DFB266F62
 for <alsa-devel@alsa-project.org>; Wed,  7 Feb 2018 02:22:53 +0100 (CET)
In-Reply-To: <1517948874-21681-2-git-send-email-tharvey@gateworks.com>
Content-Language: en-US
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Tim Harvey <tharvey@gateworks.com>, linux-media@vger.kernel.org, alsa-devel@alsa-project.org
Cc: devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, Hans Verkuil <hansverk@cisco.com>, Mauro Carvalho Chehab <mchehab@s-opensource.com>, Hans Verkuil <hans.verkuil@cisco.com>, Philipp Zabel <p.zabel@pengutronix.de>, Steve Longerbeam <slongerbeam@gmail.com>, Hans Verkuil <hverkuil@xs4all.nl>, shawnguo@kernel.org
List-Id: alsa-devel@alsa-project.org

On 02/06/2018 12:27 PM, Tim Harvey wrote:
> From: Hans Verkuil <hverkuil@xs4all.nl>
> 
> Add the v4l2_hdmi_colorimetry() function so we have a single function
> that determines the colorspace, YCbCr encoding, quantization range and
> transfer function from the InfoFrame data.
> 
> Signed-off-by: Hans Verkuil <hans.verkuil@cisco.com>
> Signed-off-by: Tim Harvey <tharvey@gateworks.com>
> ---
>  drivers/media/v4l2-core/v4l2-dv-timings.c | 141 ++++++++++++++++++++++++++++++
>  include/media/v4l2-dv-timings.h           |  21 +++++
>  2 files changed, 162 insertions(+)
> 
> diff --git a/drivers/media/v4l2-core/v4l2-dv-timings.c b/drivers/media/v4l2-core/v4l2-dv-timings.c
> index 930f9c5..0182d3d 100644
> --- a/drivers/media/v4l2-core/v4l2-dv-timings.c
> +++ b/drivers/media/v4l2-core/v4l2-dv-timings.c
> @@ -27,6 +27,7 @@
>  #include <linux/v4l2-dv-timings.h>
>  #include <media/v4l2-dv-timings.h>
>  #include <linux/math64.h>
> +#include <linux/hdmi.h>
>  
>  MODULE_AUTHOR("Hans Verkuil");
>  MODULE_DESCRIPTION("V4L2 DV Timings Helper Functions");
> @@ -814,3 +815,143 @@ struct v4l2_fract v4l2_calc_aspect_ratio(u8 hor_landscape, u8 vert_portrait)
>  	return aspect;
>  }
>  EXPORT_SYMBOL_GPL(v4l2_calc_aspect_ratio);
> +
> +/** v4l2_hdmi_rx_colorimetry - determine HDMI colorimetry information
> + *	based on various InfoFrames.
> + * @avi - the AVI InfoFrame
> + * @hdmi - the HDMI Vendor InfoFrame, may be NULL
> + * @height - the frame height

kernel-doc format for function parameters is like:

 * @avi: the AVI InfoFrame

etc.

> + *
> + * Determines the HDMI colorimetry information, i.e. how the HDMI
> + * pixel color data should be interpreted.
> + *
> + * Note that some of the newer features (DCI-P3, HDR) are not yet
> + * implemented: the hdmi.h header needs to be updated to the HDMI 2.0
> + * and CTA-861-G standards.
> + */
> +struct v4l2_hdmi_colorimetry
> +v4l2_hdmi_rx_colorimetry(const struct hdmi_avi_infoframe *avi,
> +			 const struct hdmi_vendor_infoframe *hdmi,
> +			 unsigned int height)
> +{


thanks,
-- 
~Randy
