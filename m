From: Jonathan Cameron <jic23-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH v3 07/11] IIO: consumer: allow to set buffer sizes
Date: Sun, 19 Mar 2017 22:44:02 +0000
Message-ID: <951c19fa-d3b8-f4cd-cac1-64e3b8d1cf01@kernel.org>
References: <1489759704-30217-1-git-send-email-arnaud.pouliquen@st.com>
 <1489759704-30217-8-git-send-email-arnaud.pouliquen@st.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1489759704-30217-8-git-send-email-arnaud.pouliquen-qxv4g6HH51o@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Arnaud Pouliquen <arnaud.pouliquen-qxv4g6HH51o@public.gmane.org>, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, Hartmut Knaack <knaack.h-Mmb7MZpHnFY@public.gmane.org>, Lars-Peter Clausen <lars-Qo5EllUWu/uELgA04lAiVw@public.gmane.org>, Peter Meerwald-Stadler <pmeerw-jW+XmwGofnusTnJN9+BGXg@public.gmane.org>, Jaroslav Kysela <perex-/Fr2/VpizcU@public.gmane.org>, Takashi Iwai <tiwai-IBi9RG/b67k@public.gmane.org>, Liam Girdwood <lgirdwood-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Cc: devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-iio-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, alsa-devel-K7yf7f+aM1XWsZ/bQMPhNw@public.gmane.org, kernel-F5mvAk5X5gdBDgjK7y7TUQ@public.gmane.org, Maxime Coquelin <mcoquelin.stm32-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Alexandre Torgue <alexandre.torgue-qxv4g6HH51o@public.gmane.org>, olivier moysan <olivier.moysan-qxv4g6HH51o@public.gmane.org>
List-Id: alsa-devel@alsa-project.org

On 17/03/17 14:08, Arnaud Pouliquen wrote:
> Add iio consumer API to set buffer size and watermark according
> to sysfs API.
> 
> Signed-off-by: Arnaud Pouliquen <arnaud.pouliquen-qxv4g6HH51o@public.gmane.org>
Hmm. Not keen on the length one.  Setting a requested watermark
is fair enough.  There is no actually buffer in these cases though
so setting it's length is downright odd..

Guess this is part of the hacks we need to clean up by doing
the dma buffer consumer stuff right...

Jonathan
> ---
>  drivers/iio/buffer/industrialio-buffer-cb.c | 12 ++++++++++++
>  include/linux/iio/consumer.h                | 13 +++++++++++++
>  2 files changed, 25 insertions(+)
> 
> diff --git a/drivers/iio/buffer/industrialio-buffer-cb.c b/drivers/iio/buffer/industrialio-buffer-cb.c
> index b8f550e..43c066a 100644
> --- a/drivers/iio/buffer/industrialio-buffer-cb.c
> +++ b/drivers/iio/buffer/industrialio-buffer-cb.c
> @@ -103,6 +103,18 @@ struct iio_cb_buffer *iio_channel_get_all_cb(struct device *dev,
>  }
>  EXPORT_SYMBOL_GPL(iio_channel_get_all_cb);
>  
> +int iio_channel_cb_set_buffer_params(struct iio_cb_buffer *cb_buff,
> +				      size_t length, size_t watermark)
> +{
> +	if (!length || length < watermark)
> +		return -EINVAL;
> +	cb_buff->buffer.watermark = watermark;
> +	cb_buff->buffer.length = length;
> +
> +	return 0;
> +}
> +EXPORT_SYMBOL_GPL(iio_channel_start_all_cb);
> +
>  int iio_channel_start_all_cb(struct iio_cb_buffer *cb_buff)
>  {
>  	return iio_update_buffers(cb_buff->indio_dev, &cb_buff->buffer,
> diff --git a/include/linux/iio/consumer.h b/include/linux/iio/consumer.h
> index cb44771..0f6e94d 100644
> --- a/include/linux/iio/consumer.h
> +++ b/include/linux/iio/consumer.h
> @@ -134,6 +134,19 @@ struct iio_cb_buffer *iio_channel_get_all_cb(struct device *dev,
>  						       void *private),
>  					     void *private);
>  /**
> + * iio_channel_cb_set_buffer_size() - set the buffer length.
> + * @cb_buffer:		The callback buffer from whom we want the channel
> + *			information.
> + * @length: buffer length in bytes
> + * @watermark: buffer watermark in bytes
> + *
> + * This function allows to configure the buffer length. The watermark if
> + * forced to half of the buffer.
> + */
> +int iio_channel_cb_set_buffer_params(struct iio_cb_buffer *cb_buffer,
> +				     size_t length, size_t watermark);
> +
> +/**
>   * iio_channel_release_all_cb() - release and unregister the callback.
>   * @cb_buffer:		The callback buffer that was allocated.
>   */
> 

--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
