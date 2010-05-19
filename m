From: Clemens Ladisch <clemens@ladisch.de>
Subject: Re: [PATCH 1/1] ALSA: usb-audio: add support for Akai
 MPD16
Date: Wed, 19 May 2010 08:59:38 +0200
Message-ID: <4BF38C5A.7040901@ladisch.de>
References: <1274207876-3215-1-git-send-email-wdev@foltman.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from out3.smtp.messagingengine.com (out3.smtp.messagingengine.com
	[66.111.4.27]) by alsa0.perex.cz (Postfix) with ESMTP id 4B2022453E
	for <alsa-devel@alsa-project.org>;
	Wed, 19 May 2010 08:59:44 +0200 (CEST)
In-Reply-To: <1274207876-3215-1-git-send-email-wdev@foltman.com>
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
> + * AKAI MPD16 protocol: one or more chunks consisting of first byte of
> + * (0x20 | msg_len) and then a MIDI message (msg_len bytes long)
> + *
> + * Messages sent:
> + * 21 FE (active sense)
> + * 23 90 xx xx (note on)
> + * 23 Ax xx xx (polyphonic pressure)
> + * 23 Bx xx xx (control change)
> + */
> +static void snd_usbmidi_akai_input(struct snd_usb_midi_in_endpoint *ep,
> +				   uint8_t *buffer, int buffer_length)
> +{
> +	unsigned int pos = 0;
> +	while (pos < (unsigned)buffer_length && (buffer[pos] & 0xF8) == 0x20) {
> +		int msg_len = buffer[pos] & 0x0f;
> +		snd_usbmidi_input_data(ep, 0, &buffer[pos + 1], msg_len);

This might overflow if the buffer ends with a 2x byte.

> +static struct usb_protocol_ops snd_usbmidi_akai_ops = {
> +	.input = snd_usbmidi_akai_input,
> +	.output = snd_usbmidi_standard_output,
> +	.output_packet = snd_usbmidi_output_standard_packet,

Assuming that this device doesn't have any output ports, please add a
comment that this isn't the actual output protocol.

> checkpatch.pl also complains about the use of space after the
> ampersand in quirks-table.h, where it seems to be a common practice.

I'd value consistency over some stupid script, but this issue isn't
important enough to worry over.


Overall, the patch looks fine.


Regards,
Clemens
