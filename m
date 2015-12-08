From: Clemens Ladisch <clemens@ladisch.de>
Subject: Re: [PATCH 2/3] fireface: add transaction support
Date: Tue, 8 Dec 2015 13:36:16 +0100
Message-ID: <5666CEC0.103@ladisch.de>
References: <1449408224-13955-1-git-send-email-o-takashi@sakamocchi.jp>
 <1449408224-13955-3-git-send-email-o-takashi@sakamocchi.jp>
 <5666AF4E.9000100@ladisch.de> <5666BE1A.80304@sakamocchi.jp>
 <5666BF03.7060102@ladisch.de> <5666CB21.8040406@sakamocchi.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from dehamd003.servertools24.de (dehamd003.servertools24.de
 [31.47.254.18]) by alsa0.perex.cz (Postfix) with ESMTP id 71E8B26607D
 for <alsa-devel@alsa-project.org>; Tue,  8 Dec 2015 13:36:18 +0100 (CET)
In-Reply-To: <5666CB21.8040406@sakamocchi.jp>
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
> On Dec 08 2015 20:29, Clemens Ladisch wrote:
>> Takashi Sakamoto wrote:
>>> On Dec 08 2015 19:22, Clemens Ladisch wrote:
>>>> Takashi Sakamoto wrote:
>>>>> +		/* Calculate consume bytes. */
>>>>> +		consume = calculate_message_bytes(status);
>>>>> +		if (consume <= 0)
>>>>> +			return;
>>>>
>>>> As far as I can see, sending one of the "undefined" bytes can stop the
>>>> stream permanently.  Invalid bytes need to be acked to ignore/remove
>>>> them.
>>>
>>> Exactly. We should find better way to handle such messages. Do you have
>>> any good ideas?
>>
>> Call snd_rawmidi_transmit_ack(, 1) and continue.
>
> $ git diff
> diff --git a/sound/firewire/fireface/fireface-transaction.c
> b/sound/firewire/fireface/fireface-transaction.c
> index 07a2b9c..6b8c7a8 100644
> --- a/sound/firewire/fireface/fireface-transaction.c
> +++ b/sound/firewire/fireface/fireface-transaction.c
> @@ -148,8 +148,10 @@ static void transmit_midi_msg(struct snd_ff *ff,
> unsigned int port)
>
>                 /* Calculate consume bytes. */
>                 consume = calculate_message_bytes(status);
> -               if (consume <= 0)
> +               if (consume <= 0) {
> +                       snd_rawmidi_transmit_ack(substream, 1);
>                         return;
> +               }
>
>                 /* On running-status. */
>                 if ((*buf & 0x80) != 0x80) {
>
> Hm. This looks simple and works better, while I suspect that this is
> appropriate to device driver, because this idea drops the message from
> userspace. This is against a principle that device drivers just pass
> data from a side to another side without censoring and modification.
>
> I think it better to transfer the message to the device, even if it's
> invalid in MIDI spec. It's what the userspace wants.

The code takes care to send entire MIDI messages.
Is that actually required by the FF?  (Windows does not have a raw MIDI
interface, so this problem could not happen there.)


Regards,
Clemens
