From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
Subject: Re: [bug report] ALSA: oxfw: configure packet format
 in pcm.hw_params callback
Date: Sat, 22 Jun 2019 10:35:23 +0900
Message-ID: <20190622013522.GA14635@workstation>
References: <20190619101639.GA29913@mwanda>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from out1-smtp.messagingengine.com (out1-smtp.messagingengine.com
 [66.111.4.25])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 53D08F8071F
 for <alsa-devel@alsa-project.org>; Sat, 22 Jun 2019 03:35:28 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <20190619101639.GA29913@mwanda>
List-Unsubscribe: <https://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <https://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: "Alsa-devel" <alsa-devel-bounces@alsa-project.org>
To: Dan Carpenter <dan.carpenter@oracle.com>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Hi,

On Wed, Jun 19, 2019 at 01:16:39PM +0300, Dan Carpenter wrote:
> Hello Takashi Sakamoto,
> 
> The patch 4f380d007052: "ALSA: oxfw: configure packet format in
> pcm.hw_params callback" from Jun 12, 2019, leads to the following
> static checker warning:
> 
> 	sound/firewire/oxfw/oxfw-stream.c:357 snd_oxfw_stream_start_duplex()
> 	warn: 'oxfw->rx_stream.buffer.packets' double freed
> 
> sound/firewire/oxfw/oxfw-stream.c
>    317  int snd_oxfw_stream_start_duplex(struct snd_oxfw *oxfw)
>    318  {
>    319          int err;
>    320  
>    321          if (oxfw->substreams_count == 0)
>    322                  return -EIO;
>    323  
>    324          if (amdtp_streaming_error(&oxfw->rx_stream) ||
>    325              amdtp_streaming_error(&oxfw->tx_stream)) {
>    326                  amdtp_stream_stop(&oxfw->rx_stream);
>                         ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
> 
>    327                  cmp_connection_break(&oxfw->in_conn);
>    328  
>    329                  if (oxfw->has_output) {
>    330                          amdtp_stream_stop(&oxfw->tx_stream);
>                                 ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
> 
>    331                          cmp_connection_break(&oxfw->out_conn);
>    332                  }
>    333          }
>    334  
>    335          if (!amdtp_stream_running(&oxfw->rx_stream)) {
>    336                  err = start_stream(oxfw, &oxfw->rx_stream);
>    337                  if (err < 0) {
>    338                          dev_err(&oxfw->unit->device,
>    339                                  "fail to start rx stream: %d\n", err);
>    340                          goto error;
>    341                  }
>    342          }
>    343  
>    344          if (oxfw->has_output) {
>    345                  if (!amdtp_stream_running(&oxfw->tx_stream)) {
>    346                          err = start_stream(oxfw, &oxfw->tx_stream);
>    347                          if (err < 0) {
>    348                                  dev_err(&oxfw->unit->device,
>    349                                          "fail to start tx stream: %d\n", err);
>    350                                  goto error;
>    351                          }
>    352                  }
>    353          }
>    354  
>    355          return 0;
>    356  error:
>    357          amdtp_stream_stop(&oxfw->rx_stream);
>                 ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
> 
> Smatch is basically complaining that we call amdtp_stream_stop() and
> it's not clear that we necessarily reset things.  I don't know this code
> very well so I have maybe missed something.
> 
>    358          cmp_connection_break(&oxfw->in_conn);
>    359          if (oxfw->has_output) {
>    360                  amdtp_stream_stop(&oxfw->tx_stream);
>                         ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
> 
>    361                  cmp_connection_break(&oxfw->out_conn);
>    362          }
>    363          return err;
>    364  }
> 
> regards,
> dan carpenter

Thanks for you report, however the double-free doesn't occur because the
data of 'struct amdtp_stream' is protected by mutex and 'context' member
is a flag to call kernel APIs for 'struct iso_packets_buffer'. The kernel
API, amdtp_stream_stop()' can be called several times with no corruption.

```
(sound/firewire/amdtp-stream.c)
void amdtp_stream_stop(struct amdtp_stream *s)
{
    mutex_lock(&s->mutex);

    if (!amdtp_stream_running(s)) {
    	mutex_unlock(&s->mutex);
    	return;
    }
    ...
    fw_iso_context_destroy(s->context);
    s->context = ERR_PTR(-1);
    iso_packets_buffer_destroy(&s->buffer, s->unit);
    ...
    mutex_unlock(&s->mutex);
}
EXPORT_SYMBOL(amdtp_stream_stop);
```

``
(sound/firewire/amdtp-stream.h)
static inline bool amdtp_stream_running(struct amdtp_stream *s)
{
	return !IS_ERR(s->context);
}
``


Regards

Takashi Sakamoto
