From: Hans Verkuil <hverkuil@xs4all.nl>
Subject: Re: [PATCH v5 4/6] media: i2c: Add TDA1997x HDMI
	receiver driver
Date: Tue, 19 Dec 2017 18:27:12 +0100
Message-ID: <d493768e-e41e-8518-8657-5be8c84ce829@xs4all.nl>
References: <1513447230-30948-1-git-send-email-tharvey@gateworks.com>
 <1513447230-30948-5-git-send-email-tharvey@gateworks.com>
 <3ae0ee4d-e754-1e97-33ed-d1fedf442dfb@xs4all.nl>
 <CAJ+vNU34fBjBos4g9vxv7UkcJOm1YJux7NM2=iUKBjOrxZeMBA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from lb1-smtp-cloud7.xs4all.net (lb1-smtp-cloud7.xs4all.net
 [194.109.24.24])
 by alsa0.perex.cz (Postfix) with ESMTP id E74F42676B3
 for <alsa-devel@alsa-project.org>; Tue, 19 Dec 2017 18:27:14 +0100 (CET)
In-Reply-To: <CAJ+vNU34fBjBos4g9vxv7UkcJOm1YJux7NM2=iUKBjOrxZeMBA@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Tim Harvey <tharvey@gateworks.com>
Cc: "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, alsa-devel@alsa-project.org, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Hans Verkuil <hansverk@cisco.com>, Mauro Carvalho Chehab <mchehab@s-opensource.com>, Philipp Zabel <p.zabel@pengutronix.de>, Steve Longerbeam <slongerbeam@gmail.com>, Shawn Guo <shawnguo@kernel.org>, linux-media <linux-media@vger.kernel.org>
List-Id: alsa-devel@alsa-project.org

On 19/12/17 18:01, Tim Harvey wrote:
> On Tue, Dec 19, 2017 at 3:12 AM, Hans Verkuil <hverkuil@xs4all.nl> wrote:
>> On 16/12/17 19:00, Tim Harvey wrote:
>>> +
>>> +static int tda1997x_fill_format(struct tda1997x_state *state,
>>> +                             struct v4l2_mbus_framefmt *format)
>>> +{
>>> +     const struct v4l2_bt_timings *bt;
>>> +     struct v4l2_hdmi_colorimetry c;
>>> +
>>> +     v4l_dbg(1, debug, state->client, "%s\n", __func__);
>>> +
>>> +     if (!state->detected_timings)
>>> +             return -EINVAL;
>>> +     bt = &state->detected_timings->bt;
>>> +     memset(format, 0, sizeof(*format));
>>> +     c = v4l2_hdmi_rx_colorimetry(&state->avi_infoframe, NULL, bt->height);
>>> +     format->width = bt->width;
>>> +     format->height = bt->height;
>>> +     format->field = (bt->interlaced) ?
>>> +             V4L2_FIELD_ALTERNATE : V4L2_FIELD_NONE;
>>> +     format->colorspace = c.colorspace;
>>> +     format->ycbcr_enc = c.ycbcr_enc;
>>> +     format->quantization = c.quantization;
>>> +     format->xfer_func = c.xfer_func;
>>
>> This is wrong. v4l2_hdmi_rx_colorimetry returns what arrives on the HDMI link,
>> that's not the same as is output towards the SoC. You need to take limited/full
>> range conversions and 601/709 conversions into account since that's what ends
>> up in memory.
>>
>> Also note: you are still parsing the colorimetry information from avi_infoframe
>> in the infoframe parse function. There is no need to do that, just call
>> v4l2_hdmi_rx_colorimetry and let that function parse and interpret all this.
>>
>> Otherwise we still have two places that try to interpret that information.
> 
> Hans,
> 
> Ok so v4l2_hdmi_rx_colorimetry() handles parsing the source avi
> infoframe and deals with enforcing the detailed rules and returns
> 'v4l2' enums:
> 
> tda1997x_parse_infoframe(...)
> ...
>         case HDMI_INFOFRAME_TYPE_AVI:
>                 state->avi_infoframe = frame.avi; /* hold on to avi
> infoframe for later use in logging etc */
>                 /* parse avi infoframe colorimetry data for v4l2
> colorspace/ycbcr_encoding/quantization/xfer_func */
>                 state->hdmi_colorimetry = v4l2_hdmi_rx_colorimetry(&frame.avi,
>                                                 NULL,
>                                                 state->timings.bt.height);
> 
> Also here I still need to override the quant range passed from the
> source avi infoframe per the user control (if not auto) and set per
> vic if default:
> 
>                 /* Quantization Range */
>                 switch (state->rgb_quantization_range) {
>                 case V4L2_DV_RGB_RANGE_AUTO:
>                         state->range = frame.avi.quantization_range;
>                         break;
>                 case V4L2_DV_RGB_RANGE_LIMITED:
>                         state->range = HDMI_QUANTIZATION_RANGE_LIMITED;
>                         break;
>                 case V4L2_DV_RGB_RANGE_FULL:
>                         state->range = HDMI_QUANTIZATION_RANGE_FULL;
>                         break;
>                 }
>                 if (state->range == HDMI_QUANTIZATION_RANGE_DEFAULT) {
>                         if (frame.avi.video_code <= 1)
>                                 state->range = HDMI_QUANTIZATION_RANGE_FULL;
>                         else
>                                 state->range = HDMI_QUANTIZATION_RANGE_LIMITED;
>                 }

No, the vic check is already done in v4l2_hdmi_rx_colorimetry.

Call v4l2_hdmi_rx_colorimetry first, then:

	/* If ycbcr_enc is V4L2_YCBCR_ENC_DEFAULT, then we receive RGB */
	if (c.ycbcr_enc == V4L2_YCBCR_ENC_DEFAULT)
		switch (state->rgb_quantization_range) {
                	case V4L2_DV_RGB_RANGE_LIMITED:
                        	c.quantization = V4L2_QUANTIZATION_FULL_RANGE;
				break;
			case V4L2_DV_RGB_RANGE_FULL:
                        	c.quantization = V4L2_QUANTIZATION_LIM_RANGE;
				break;
		}

(c is of type struct v4l2_hdmi_colorimetry)

> 
> 
> Then tda1997x_fill_format() then needs to fill in details of what's on
> the bus so I should be filling in only width/height/field/colorspace
> and use colorspace based on my csc conversion chosen output
> (V4L2_COLORSPACE_SRGB|V4L2_COLORSPACE_SMPTE170M|V4L2_COLORSPACE_REC709)
> and I don't need to set ycbcr_enc/quantization/xfer_func.

You don't touch the colorspace and xfer_func fields. The simple matrix
csc can only change quantization range and/or ycbcr encoding.

It doesn't change the underlying colorspace ('chromaticities') or the
used transfer function.

In practice if the output is RGB then ycbcr_enc should be set to
V4L2_YCBCR_ENC_DEFAULT and quantization to FULL_RANGE. For YUV output you
set ycbcr_enc to V4L2_YCBCR_ENC_601 or 709 and quantization to LIM_RANGE.

Regards,

	Hans

> 
> does this sound right?
> 
> Thanks,
> 
> Tim
> 
