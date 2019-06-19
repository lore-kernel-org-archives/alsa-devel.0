From: Dan Carpenter <dan.carpenter@oracle.com>
Subject: [bug report] ALSA: oxfw: configure packet format in
 pcm.hw_params callback
Date: Wed, 19 Jun 2019 13:16:39 +0300
Message-ID: <20190619101639.GA29913@mwanda>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from aserp2120.oracle.com (aserp2120.oracle.com [141.146.126.78])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 65184F808AF
 for <alsa-devel@alsa-project.org>; Wed, 19 Jun 2019 12:16:57 +0200 (CEST)
Content-Disposition: inline
List-Unsubscribe: <https://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <https://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: "Alsa-devel" <alsa-devel-bounces@alsa-project.org>
To: o-takashi@sakamocchi.jp
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Hello Takashi Sakamoto,

The patch 4f380d007052: "ALSA: oxfw: configure packet format in
pcm.hw_params callback" from Jun 12, 2019, leads to the following
static checker warning:

	sound/firewire/oxfw/oxfw-stream.c:357 snd_oxfw_stream_start_duplex()
	warn: 'oxfw->rx_stream.buffer.packets' double freed

sound/firewire/oxfw/oxfw-stream.c
   317  int snd_oxfw_stream_start_duplex(struct snd_oxfw *oxfw)
   318  {
   319          int err;
   320  
   321          if (oxfw->substreams_count == 0)
   322                  return -EIO;
   323  
   324          if (amdtp_streaming_error(&oxfw->rx_stream) ||
   325              amdtp_streaming_error(&oxfw->tx_stream)) {
   326                  amdtp_stream_stop(&oxfw->rx_stream);
                        ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

   327                  cmp_connection_break(&oxfw->in_conn);
   328  
   329                  if (oxfw->has_output) {
   330                          amdtp_stream_stop(&oxfw->tx_stream);
                                ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

   331                          cmp_connection_break(&oxfw->out_conn);
   332                  }
   333          }
   334  
   335          if (!amdtp_stream_running(&oxfw->rx_stream)) {
   336                  err = start_stream(oxfw, &oxfw->rx_stream);
   337                  if (err < 0) {
   338                          dev_err(&oxfw->unit->device,
   339                                  "fail to start rx stream: %d\n", err);
   340                          goto error;
   341                  }
   342          }
   343  
   344          if (oxfw->has_output) {
   345                  if (!amdtp_stream_running(&oxfw->tx_stream)) {
   346                          err = start_stream(oxfw, &oxfw->tx_stream);
   347                          if (err < 0) {
   348                                  dev_err(&oxfw->unit->device,
   349                                          "fail to start tx stream: %d\n", err);
   350                                  goto error;
   351                          }
   352                  }
   353          }
   354  
   355          return 0;
   356  error:
   357          amdtp_stream_stop(&oxfw->rx_stream);
                ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

Smatch is basically complaining that we call amdtp_stream_stop() and
it's not clear that we necessarily reset things.  I don't know this code
very well so I have maybe missed something.

   358          cmp_connection_break(&oxfw->in_conn);
   359          if (oxfw->has_output) {
   360                  amdtp_stream_stop(&oxfw->tx_stream);
                        ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

   361                  cmp_connection_break(&oxfw->out_conn);
   362          }
   363          return err;
   364  }

regards,
dan carpenter
