From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
Subject: Re: [PATCH 06/25] ALSA: firewire-lib: add throttle for
 MIDI data rate
Date: Fri, 14 Aug 2015 06:34:46 +0900
Message-ID: <55CD0D76.9040107@sakamocchi.jp>
References: <1439425221-30826-1-git-send-email-o-takashi@sakamocchi.jp>
 <1439425221-30826-7-git-send-email-o-takashi@sakamocchi.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp301.phy.lolipop.jp (smtp301.phy.lolipop.jp [210.157.22.84])
 by alsa0.perex.cz (Postfix) with ESMTP id C3E43264F28
 for <alsa-devel@alsa-project.org>; Thu, 13 Aug 2015 23:34:53 +0200 (CEST)
In-Reply-To: <1439425221-30826-7-git-send-email-o-takashi@sakamocchi.jp>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: clemens@ladisch.de, tiwai@suse.de
Cc: alsa-devel@alsa-project.org, ffado-devel@lists.sf.net
List-Id: alsa-devel@alsa-project.org

On Aug 13 2015 09:20, Takashi Sakamoto wrote:
> Typically, the target devices have internal buffer to adjust output of
> received MIDI messages for MIDI serial bus, while the capacity of the
> buffer is limited. IEEE 1394 transactions can transfer more MIDI messages
> than MIDI serial bus can. This can cause buffer over flow in device side.
> 
> This commit adds throttle to limit MIDI data rate by counting intervals
> by jiffies between two MIDI messages. Usual MIDI messages consists of two
> or three bytes. This requires 1.302 to 1.953 mili-seconds interval between
> these messages. Using jiffies for this purpose is not perfect idea.
> Further work is needed for better implementation.
> 
> Signed-off-by: Takashi Sakamoto <o-takashi@sakamocchi.jp>
> ---
>  sound/firewire/lib.c | 18 +++++++++++++++++-
>  sound/firewire/lib.h |  1 +
>  2 files changed, 18 insertions(+), 1 deletion(-)
> 
> diff --git a/sound/firewire/lib.c b/sound/firewire/lib.c
> index e309b9b..452728c 100644
> --- a/sound/firewire/lib.c
> +++ b/sound/firewire/lib.c
> @@ -76,6 +76,9 @@ static void async_midi_port_callback(struct fw_card *card, int rcode,
>  
>  	if (rcode == RCODE_COMPLETE && substream != NULL)
>  		snd_rawmidi_transmit_ack(substream, port->consume_bytes);
> +	else if (!rcode_is_permanent_error(rcode))
> +		/* To start next transaction immediately for recovery. */
> +		port->next_tick = 0;
>  
>  	port->idling = true;
>  
> @@ -99,6 +102,12 @@ static void midi_port_tasklet(unsigned long data)
>  	if (substream == NULL || snd_rawmidi_transmit_empty(substream))
>  		return;
>  
> +	/* Do it in next chance. */
> +	if (time_is_after_jiffies(port->next_tick)) {
> +		tasklet_schedule(&port->tasklet);
> +		return;
> +	}
> +
>  	/*
>  	 * Fill the buffer. The callee must use snd_rawmidi_transmit_peek().
>  	 * Later, snd_rawmidi_transmit_ack() may be called.
> @@ -107,8 +116,10 @@ static void midi_port_tasklet(unsigned long data)
>  	port->consume_bytes = port->packetize(substream, port->buf);
>  	if (port->consume_bytes <= 0) {
>  		/* Do it in next chance, immediately. */
> -		if (port->consume_bytes == 0)
> +		if (port->consume_bytes == 0) {
> +			port->next_tick = 0;
>  			tasklet_schedule(&port->tasklet);
> +		}
>  		return;
>  	}
>  
> @@ -118,6 +129,10 @@ static void midi_port_tasklet(unsigned long data)
>  	else
>  		type = TCODE_WRITE_BLOCK_REQUEST;
>  
> +	/* Set interval to next transaction. */
> +	port->next_tick =
> +		jiffies_64 + msecs_to_jiffies(port->consume_bytes * 8 / 31250);
> +

I realize that the given argument should be multiplexed by 1000 to
represent mili-seconds.

>  	/* Start this transaction. */
>  	port->idling = false;
>  	generation = port->parent->generation;
> @@ -153,6 +168,7 @@ int snd_fw_async_midi_port_init(struct snd_fw_async_midi_port *port,
>  	port->addr = addr;
>  	port->packetize = packetize;
>  	port->idling = true;
> +	port->next_tick = 0;
>  
>  	tasklet_init(&port->tasklet, midi_port_tasklet, (unsigned long)port);
>  
> diff --git a/sound/firewire/lib.h b/sound/firewire/lib.h
> index 9d76f5c..e4b00e2 100644
> --- a/sound/firewire/lib.h
> +++ b/sound/firewire/lib.h
> @@ -26,6 +26,7 @@ struct snd_fw_async_midi_port {
>  	struct fw_device *parent;
>  	struct tasklet_struct tasklet;
>  	bool idling;
> +	unsigned long next_tick;
>  
>  	__u64 addr;
>  	struct fw_transaction transaction;
> 
