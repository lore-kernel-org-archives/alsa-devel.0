From: Clemens Ladisch <clemens@ladisch.de>
Subject: Re: [PATCH 08/39] firewire-lib: Add support for duplex
 streams synchronization in blocking mode
Date: Sun, 09 Mar 2014 21:55:06 +0100
Message-ID: <531CD52A.1040902@ladisch.de>
References: <5316963F.1000206@sakamocchi.jp>
 <1394016507-15761-1-git-send-email-o-takashi@sakamocchi.jp>
 <1394016507-15761-9-git-send-email-o-takashi@sakamocchi.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from dehamd003.servertools24.de (dehamd003.servertools24.de
 [31.47.254.18]) by alsa0.perex.cz (Postfix) with ESMTP id 0B8942655CD
 for <alsa-devel@alsa-project.org>; Sun,  9 Mar 2014 21:55:45 +0100 (CET)
In-Reply-To: <1394016507-15761-9-git-send-email-o-takashi@sakamocchi.jp>
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
Cc: tiwai@suse.de, alsa-devel@alsa-project.org, ffado-devel@lists.sf.net
List-Id: alsa-devel@alsa-project.org

Takashi Sakamoto wrote:
> Generally, the devices can synchronize to handle 'presentation timestamp'
> in CIP packets. This commit adds functionality to pick up this timestamp from
> in-packets transmitted by the device, then use it for out packets.
>
> In current implementation, this module generated the timestamp by itself. This
> is 'SYT Match' mode. Then this drive acts as synchronization master. This
> commit allows this module to act as synchronization slave.
>
> This commit restricts this mechanism is only available in blocking mode because
> handling the timestamp in non-blocking mode is more complicated than in
> blocking mode.

> +++ b/sound/firewire/amdtp.c
> @@ -72,6 +73,10 @@ int amdtp_stream_init(struct amdtp_stream *s, struct fw_unit *unit,
> +	s->sync_slave = ERR_PTR(-1);

This pointer does not report any actual error code either.

> @@ -626,7 +631,7 @@ static void handle_out_packet(struct amdtp_stream *s, unsigned int syt)
>  {
> -	struct snd_pcm_substream *pcm;
> +	struct snd_pcm_substream *pcm = NULL;

Why this change in this patch?

> @@ -768,6 +773,15 @@ static void in_stream_callback(struct fw_iso_context *context, u32 cycle,
> +		/* Process sync slave stream */
> +		if ((s->flags & CIP_BLOCKING) &&
> +		    (s->flags & CIP_SYNC_TO_DEVICE) &&
> +		    s->sync_slave->callbacked) {

It might be easier to check just s->sync_slave instead of multiple flags.


> +	/* when sync to device, flush the packets for slave stream */
> +	if ((s->flags & CIP_BLOCKING) &&
> +	    (s->flags & CIP_SYNC_TO_DEVICE) && s->sync_slave->callbacked)

Same here.

> +/* this is executed one time */
> +static void amdtp_stream_callback(struct fw_iso_context *context, u32 cycle,

This name is rather generic; this is not "the" callback, but the
"initial" or "first" callback.

> ...
> +	return;
> +}

This is not necessary here.

> +static inline void amdtp_stream_set_sync(enum cip_flags sync_mode,
> +					 struct amdtp_stream *master,
> +					 struct amdtp_stream *slave)
> +{
> +	/* clear sync flag */
> +	master->flags &= ~CIP_SYNC_TO_DEVICE;
> +	slave->flags &= ~CIP_SYNC_TO_DEVICE;

This needs to be done only if sync_mode != CIP_SYNC_TO_DEVICE.


Regards,
Clemens
