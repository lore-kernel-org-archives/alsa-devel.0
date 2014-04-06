From: Clemens Ladisch <clemens@ladisch.de>
Subject: Re: [PATCH 24/44] fireworks: Add MIDI interface
Date: Sun, 06 Apr 2014 16:52:38 +0200
Message-ID: <53416A36.6060603@ladisch.de>
References: <1395400229-22957-1-git-send-email-o-takashi@sakamocchi.jp>
 <1395400229-22957-25-git-send-email-o-takashi@sakamocchi.jp>
 <533DD083.10506@ladisch.de> <53414287.4050801@sakamocchi.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from dehamd003.servertools24.de (dehamd003.servertools24.de
 [31.47.254.18]) by alsa0.perex.cz (Postfix) with ESMTP id D7C7A2602AD
 for <alsa-devel@alsa-project.org>; Sun,  6 Apr 2014 16:52:47 +0200 (CEST)
In-Reply-To: <53414287.4050801@sakamocchi.jp>
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
Cc: tiwai@suse.de, alsa-devel@alsa-project.org, linux1394-devel@lists.sourceforge.net, ffado-devel@lists.sf.net
List-Id: alsa-devel@alsa-project.org

Takashi Sakamoto wrote:
> (Apr 4 2014 06:20), Clemens Ladisch wrote:
>>> +++ b/sound/firewire/fireworks/fireworks_midi.c
>>> +static int midi_capture_open(struct snd_rawmidi_substream *substream)
>>> +{
>>> +    struct snd_efw *efw = substream->rmidi->private_data;
>>> +
>>> +    efw->capture_substreams++;
>>
>> The MIDI .open callback is not synchronized with the PCM callbacks;
>> this might race and must be protected with a mutex.
>
> Exactly. And I've realized it.
>
> The race appears between some processes to handle substream counter at
> the same time. The counter is changed by below operations:
>  PCM  .hw_param/.hw_free
>  MIDI .open/.close
>
> Well, for this issue, I think it better to use atomic_t for substream
> counter than mutex. The way to use mutex is propper for MIDI .open/
> .close because these functions also execure stream_start_duplex() /
> stream_stop_duplex() (then I must move mutex_lock/mutex_unlock from
> stream.c). But PCM .hw_param/.hw_free just increment / decrement
> substream counter. I think it consts expensive than such simple
> operation.

The fast path of mutex_(un)lock already is quite heavily optimized.
Optimizations should not be added unless they are actually needed; in
this case, the difference would not be noticeable, especially because
none of these functions are called frequently.  (But if the code using
atomic_t ends up being simpler, there's no reason not to use it.)


Regards,
Clemens
