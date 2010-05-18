From: Daniel Mack <daniel@caiaq.de>
Subject: Re: [PATCH 1/1] ALSA: usb-audio: add support for Akai
 MPD16
Date: Tue, 18 May 2010 02:38:28 +0200
Message-ID: <20100518003828.GT30801@buzzloop.caiaq.de>
References: <1274136495-5306-1-git-send-email-wdev@foltman.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Content-Disposition: inline
In-Reply-To: <1274136495-5306-1-git-send-email-wdev@foltman.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: wdev@foltman.com
Cc: alsa-devel@alsa-project.org, patch@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On Mon, May 17, 2010 at 11:48:15PM +0100, wdev@foltman.com wrote:
> The decoding routine is based on own reverse-engineering. It seems to
> recognize all the messages that MPD16 sends during normal operation
> (that is, via standard MIDI messages).
> 
> Configuration (changing pad sensitivity, slider controller and MIDI
> notes) is not supported in this version.
> 
> Signed-off-by: Krzysztof Foltman <wdev@foltman.com>
> 
> diff --git a/sound/usb/midi.c b/sound/usb/midi.c
> index 2c1558c..57d642a 100644
> --- a/sound/usb/midi.c
> +++ b/sound/usb/midi.c
> @@ -645,6 +645,34 @@ static struct usb_protocol_ops snd_usbmidi_cme_ops = {
>  };
>  
>  /*
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
> +	while (pos < (unsigned)buffer_length && (buffer[pos] & 0xF8) == 0x20)
> +	{
> +		int msg_len = buffer[pos] & 0x0f;
> +		snd_usbmidi_input_data(ep, 0, &buffer[pos + 1], msg_len);
> +		pos += 1 + msg_len;
> +	}
> +}

Just a minor coding style flaw here for the curly brackets. See
Documentation/CodingStyle or let scripts/checkpatch.pl annoy you :)

FWIW, I think the block above could also be a for-loop, but that's
certainly a matter of taste.

Thanks,
Daniel
