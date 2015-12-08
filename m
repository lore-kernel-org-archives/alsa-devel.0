From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
Subject: Re: [PATCH 2/3] fireface: add transaction support
Date: Tue, 8 Dec 2015 20:25:14 +0900
Message-ID: <5666BE1A.80304@sakamocchi.jp>
References: <1449408224-13955-1-git-send-email-o-takashi@sakamocchi.jp>
 <1449408224-13955-3-git-send-email-o-takashi@sakamocchi.jp>
 <5666AF4E.9000100@ladisch.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp310.phy.lolipop.jp (smtp310.phy.lolipop.jp [210.157.22.78])
 by alsa0.perex.cz (Postfix) with ESMTP id 9F821266042
 for <alsa-devel@alsa-project.org>; Tue,  8 Dec 2015 12:25:19 +0100 (CET)
In-Reply-To: <5666AF4E.9000100@ladisch.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Clemens Ladisch <clemens@ladisch.de>
Cc: tiwai@suse.de, alsa-devel@alsa-project.org, ffado-devel@lists.sf.net
List-Id: alsa-devel@alsa-project.org

On Dec 08 2015 19:22, Clemens Ladisch wrote:
> Takashi Sakamoto wrote:
>> +static void transmit_midi_msg(struct snd_ff *ff, unsigned int port)
>> ...
>> +	/* Retrieve one MIDI byte to calculate length of the message. */
>> +	len = snd_rawmidi_transmit_peek(substream, buf,
>> +					SND_FF_MAXIMIM_MIDI_QUADS);
> 
> SND_FF_MAXIMIM_MIDI_QUADS does not have the value 1.

Oops. It's my mistake to left the message as what it had been.
Originally, I programmed to retrieve one byte. Later, I investigated the
maximum message size and changed the code.

>> +		/* Calculate consume bytes. */
>> +		consume = calculate_message_bytes(status);
>> +		if (consume <= 0)
>> +			return;
> 
> As far as I can see, sending one of the "undefined" bytes can stop the
> stream permanently.  Invalid bytes need to be acked to ignore/remove
> them.

Exactly. We should find better way to handle such messages. Do you have
any good ideas?


Thanks

Takashi Sakamoto
