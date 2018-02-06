From: Hans Verkuil <hverkuil-qWit8jRvyhVmR6Xm/wNWPw@public.gmane.org>
Subject: Re: [PATCH v8 5/7] media: i2c: Add TDA1997x HDMI receiver driver
Date: Tue, 6 Feb 2018 21:38:24 +0100
Message-ID: <3630ba30-eb18-0829-7b0c-f0a786232969@xs4all.nl>
References: <1517948874-21681-1-git-send-email-tharvey@gateworks.com>
 <1517948874-21681-6-git-send-email-tharvey@gateworks.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1517948874-21681-6-git-send-email-tharvey-UMMOYl/HMS+akBO8gow8eQ@public.gmane.org>
Content-Language: en-US
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Tim Harvey <tharvey-UMMOYl/HMS+akBO8gow8eQ@public.gmane.org>, linux-media-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, alsa-devel-K7yf7f+aM1XWsZ/bQMPhNw@public.gmane.org
Cc: devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, shawnguo-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, Steve Longerbeam <slongerbeam-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Philipp Zabel <p.zabel-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>, Hans Verkuil <hansverk-FYB4Gu1CFyUAvxtiuMwx3w@public.gmane.org>, Mauro Carvalho Chehab <mchehab-JsYNTwtnfakRB7SZvlqPiA@public.gmane.org>
List-Id: alsa-devel@alsa-project.org

On 02/06/2018 09:27 PM, Tim Harvey wrote:
> Add support for the TDA1997x HDMI receivers.
> 
> Cc: Hans Verkuil <hverkuil-qWit8jRvyhVmR6Xm/wNWPw@public.gmane.org>
> Signed-off-by: Tim Harvey <tharvey-UMMOYl/HMS+akBO8gow8eQ@public.gmane.org>
> ---

<snip>

> +static int tda1997x_get_dv_timings_cap(struct v4l2_subdev *sd,
> +				       struct v4l2_dv_timings_cap *cap)
> +{
> +	if (cap->pad != TDA1997X_PAD_SOURCE)
> +		return -EINVAL;
> +
> +	*cap = tda1997x_dv_timings_cap;
> +	return 0;
> +}
> +
> +static int tda1997x_enum_dv_timings(struct v4l2_subdev *sd,
> +				    struct v4l2_enum_dv_timings *timings)
> +{
> +	if (timings->pad != TDA1997X_PAD_SOURCE)
> +		return -EINVAL;
> +
> +	return v4l2_enum_dv_timings_cap(timings, &tda1997x_dv_timings_cap,
> +					NULL, NULL);
> +}

You shouldn't need this pad test: it's done in the v4l2-subdev.c core code
already. But please double-check :-)

Can you post the output of the v4l2-compliance test? I'm curious to see it.

Can you also try to run v4l2-compliance -m /dev/mediaX? That also tests
whether the right entity types are set (note: testing for that should
also happen in the subdev compliance test, but I haven't done that yet).

Regards,

	Hans
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
