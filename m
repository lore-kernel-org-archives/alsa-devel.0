From: Clemens Ladisch <clemens@ladisch.de>
Subject: Re: [PATCH 2/3] fireface: add transaction support
Date: Tue, 8 Dec 2015 11:22:06 +0100
Message-ID: <5666AF4E.9000100@ladisch.de>
References: <1449408224-13955-1-git-send-email-o-takashi@sakamocchi.jp>
 <1449408224-13955-3-git-send-email-o-takashi@sakamocchi.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from dehamd003.servertools24.de (dehamd003.servertools24.de
 [31.47.254.18]) by alsa0.perex.cz (Postfix) with ESMTP id A71B626602C
 for <alsa-devel@alsa-project.org>; Tue,  8 Dec 2015 11:22:08 +0100 (CET)
In-Reply-To: <1449408224-13955-3-git-send-email-o-takashi@sakamocchi.jp>
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
> +static void transmit_midi_msg(struct snd_ff *ff, unsigned int port)
> ...
> +	/* Retrieve one MIDI byte to calculate length of the message. */
> +	len = snd_rawmidi_transmit_peek(substream, buf,
> +					SND_FF_MAXIMIM_MIDI_QUADS);

SND_FF_MAXIMIM_MIDI_QUADS does not have the value 1.

> +		/* Calculate consume bytes. */
> +		consume = calculate_message_bytes(status);
> +		if (consume <= 0)
> +			return;

As far as I can see, sending one of the "undefined" bytes can stop the
stream permanently.  Invalid bytes need to be acked to ignore/remove
them.


Regards,
Clemens
