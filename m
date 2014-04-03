From: Clemens Ladisch <clemens@ladisch.de>
Subject: Re: [PATCH 18/44] fireworks: Add connection and stream
 management
Date: Thu, 03 Apr 2014 22:56:40 +0200
Message-ID: <533DCB08.3040404@ladisch.de>
References: <1395400229-22957-1-git-send-email-o-takashi@sakamocchi.jp>
 <1395400229-22957-19-git-send-email-o-takashi@sakamocchi.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from dehamd003.servertools24.de (dehamd003.servertools24.de
 [31.47.254.18]) by alsa0.perex.cz (Postfix) with ESMTP id 290D22656D8
 for <alsa-devel@alsa-project.org>; Thu,  3 Apr 2014 22:56:45 +0200 (CEST)
In-Reply-To: <1395400229-22957-19-git-send-email-o-takashi@sakamocchi.jp>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Takashi Sakamoto <o-takashi@sakamocchi.jp>
Cc: tiwai@suse.de, alsa-devel@alsa-project.org, linux1394-devel@lists.sourceforge.net, ffado-devel@lists.sf.net
List-Id: alsa-devel@alsa-project.org

Takashi Sakamoto wrote:
> Fireworks manages connections by CMP and can transmit/receive AMDTP streams
> with a few quirks. This commit adds functionality to start/stop the streams.
>
> +++ b/sound/firewire/fireworks/fireworks.c
> +static int
> +init_stream(struct snd_efw *efw, struct amdtp_stream *stream)
> +{
> +	...
> +	err = amdtp_stream_init(stream, efw->unit, s_dir, CIP_BLOCKING);

amdtp_stream_destroy() must be called.

> +static int
> +start_stream(struct snd_efw *efw, struct amdtp_stream *stream,
> +	     unsigned int sampling_rate)
> +{
> +	...
> +	err = amdtp_stream_start(stream,
> +				 conn->resources.channel,
> +				 conn->speed);
> +	if (err < 0)
> +		stop_stream(efw, stream);
> +
> +	/* wait first callback */
> +	if (!amdtp_stream_wait_callback(stream, CALLBACK_TIMEOUT)) {
> +		stop_stream(efw, stream);
> +		err = -ETIMEDOUT;
> +	}
> +end:
> +	return err;
> +}

If amdtp_stream_start() fails, this function will try to wait for
the stream anyway.

> +int snd_efw_stream_init_duplex(struct snd_efw *efw)
> +{
> +	int err;
> +
> +	err = init_stream(efw, &efw->tx_stream);
> +	if (err < 0)
> +		goto end;
> +
> +	err = init_stream(efw, &efw->rx_stream);
> +	if (err < 0)
> +		goto end;

If the second init_stream() fails, this function will return with only one
of the streams initialized.

> +
> +	/* set IEC61883 compliant mode */
> +	err = snd_efw_command_set_tx_mode(efw, SND_EFW_TRANSPORT_MODE_IEC61883);
> +end:
> +	return err;

And if this fails, this function will return an error, but the two streams
will still be initialized.

In the error cases, any so-far initialized stream must be destroyed.

> +int snd_efw_stream_stop_duplex(struct snd_efw *efw)
> +{
> +	struct amdtp_stream *master, *slave;
> +	enum cip_flags sync_mode;
> +	unsigned int slave_substreams;
> +	int err;
> +
> +	mutex_lock(&efw->mutex);
> +
> +	err = get_roles(efw, &sync_mode, &master, &slave);
> +	if (err < 0)
> +		goto end;

snd_efw_stream_stop_duplex() must always succeed so that the
resources can be freed properly.  Therefore, it should not
try to ask the device for anything (the device might be
resetting or be unplugged).

Either cache the master/slave pointers when starting the stream,
or rewrite get_roles() so that it does not access the device.


Regards,
Clemens
