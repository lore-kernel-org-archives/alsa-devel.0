From: Clemens Ladisch <clemens@ladisch.de>
Subject: Re: [PATCH 1/1] ALSA: usb-audio: add support for Akai
 MPD16
Date: Thu, 20 May 2010 09:26:56 +0200
Message-ID: <4BF4E440.9030105@ladisch.de>
References: <1274299579-12990-1-git-send-email-wdev@foltman.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from out5.smtp.messagingengine.com (out5.smtp.messagingengine.com
	[66.111.4.29]) by alsa0.perex.cz (Postfix) with ESMTP id 4439F103914
	for <alsa-devel@alsa-project.org>;
	Thu, 20 May 2010 09:26:59 +0200 (CEST)
In-Reply-To: <1274299579-12990-1-git-send-email-wdev@foltman.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Krzysztof Foltman <wdev@foltman.com>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Krzysztof Foltman wrote:
> +		int port = (buffer[pos] >> 4) - 1;
> +		if (... && (port == 0 || port == 1))

Not that it really matters, but if the port variable were unsigned, you
could just check for "port <= 1".

> +static void snd_usbmidi_akai_output(struct snd_usb_midi_out_endpoint *ep,
> +				    struct urb *urb)
> ...
> +	/* only try adding more data when there's space for at least 1 SysEx */
> +	while (urb->transfer_buffer_length + 16 < ep->max_transfer) {
> +		count = snd_rawmidi_transmit(ep->ports[0].substream, &tmp, 1);
> +		if (count < 1) {
> +			ep->ports[0].active = 0;
> +			return;
> +		}

It is possible that ALSA's buffer does not yet contain the entire SysEx
message; in this case, the driver would send off the partial message
without the 0x10 in the first byte.

I think the only solution for that is to use snd_rawmidi_transmit_peek,
and for a SysEx, waiting until the entire message is available before
copying it to the transfer_buffer and calling transmit_ack.

> +	/* Akai MPD16 */
> +	CONTROL_PORT(0x09e8, 0x0062, 0, "%s Control"),
> +	EXTERNAL_PORT(0x09e8, 0x0062, 1, "%s MIDI"),

This MIDI port isn't an external port (which would imply that any random
device could be connected to it).  There is no macro for internal ports;
just use PORT_INFO(... _MIDI_GENERIC | _HARDWARE).


Regards,
Clemens
