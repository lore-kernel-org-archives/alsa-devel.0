From: "Alexander E. Patrakov" <patrakov@gmail.com>
Subject: Re: [RFC PATCH 1/4] ALSA: core: let low-level driver
 or userspace disable rewinds
Date: Tue, 14 Jul 2015 22:39:20 +0500
Message-ID: <55A54948.8060703@gmail.com>
References: <1436350236-17509-1-git-send-email-pierre-louis.bossart@linux.intel.com>
 <1436350236-17509-2-git-send-email-pierre-louis.bossart@linux.intel.com>
 <55A14D23.3070600@gmail.com>
 <CAN8cciZy2b+spcMp7UkK5Jfh9ks=1z+Pzrj4YCYyMEGDPHeY3g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-wi0-f169.google.com (mail-wi0-f169.google.com
 [209.85.212.169])
 by alsa0.perex.cz (Postfix) with ESMTP id 577B12652B4
 for <alsa-devel@alsa-project.org>; Tue, 14 Jul 2015 19:39:23 +0200 (CEST)
Received: by wiga1 with SMTP id a1so106257562wig.0
 for <alsa-devel@alsa-project.org>; Tue, 14 Jul 2015 10:39:23 -0700 (PDT)
In-Reply-To: <CAN8cciZy2b+spcMp7UkK5Jfh9ks=1z+Pzrj4YCYyMEGDPHeY3g@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Raymond Yau <superquad.vortex2@gmail.com>
Cc: Takashi Iwai <tiwai@suse.de>, ALSA Development Mailing List <alsa-devel@alsa-project.org>, Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
List-Id: alsa-devel@alsa-project.org

14.07.2015 08:32, Raymond Yau wrote:
>
>
>     1. What amount of power-saving are we talking about, for Intel
>     chips? (ideally, this should be in the commit message)
>
>
> Refer to HDA043-A
>
> Energy efficient audio buffering and dynamic FIFO limit change

<deleted a long quote>

I expected an answer in the form "XXX mW out of YYY, for such-and-such 
buffer and period sizes".

>     2. Shouldn't SND_PCM_APPEND (the mode used by dmix and friends) be
>     also made incompatible with this flag, because, when mixing, it
>     essentially overwrites incompletely-mixed data, i.e. rewinds without
>     saying the word "rewind"? Shouldn't all other kinds of freewheeling
>     be made incompatible with this flag, because the card, essentially,
>     is never told about the application pointer? Or is this a
>     userspace-only concern?
>
>
> if SND_PCM_APPEND use fmode = O_APPEND when snd_device_open(), this seem
> support sequential write only and no random write

dmix uses mmap and never advances application pointer on the slave 
(which is a hw device). While each instance of dmix can indeed perform 
mmap-based writes sequentially, what the device sees is not sequential. 
E.g., for two periods and two applications, started simultaneously, the 
sequence is like this:

1st app writes 1st period
1st app writes 2nd period
2nd app overwrites 1st period with the mix
2nd app overwrites 2nd periodwith the mix
hw completes playing 1st period
1st app writes 1st period
2nd app overwrites 1st period with the mix
hw completes playing 2nd period
2nd app writes 2nd period
1st app overwrites 2nd period with the mix
hw completes playing 1st period

...and so on, and we have not considered xruns here, which complicate 
the picture even further. The point is: what the hardware sees is not a 
stream of sequential writes, so the no-rewind flag is not appropriate.

And it is never notified about the application pointer, so the flag is 
definitely not appropriate again.

>
> Do it mean pulseaudio cannot rewind dmix as dmix alway append data to hw
> device ?

No, see above.

Regarding dmix rewindability status: dmix is not actually rewindable 
(but pretends to be), and, while (unlike for extplug) I don't see any 
reason why it must be unrewindable, there is no opposition to mark it as 
unrewindable and then call the problem solved.

Regarding PulseAudio: for PATCH 1/4, it is completely irrelevant. 
Pulseaudio wants to be responsive to the events that new streams appear 
and existing ones change software-based volume. Let's suppose that it 
wants to respond in no later than 10 ms (just a made-up number). Then, 
at no point there should be more than 10 ms of buffered audio that 
cannot be replaced. If PulseAudio starts using this new flag, then it 
has to wake up the CPU every 10 ms. I.e. "let the audio DMA engine wake 
up every 0.125 ms, as it does by default, and let the CPU wake up every 
1000 ms unless something important happens (in which case there is a 
rewind)" would be replaced by "let the audio DMA engine wake up once in 
10 ms, and also let the CPU wake up every 10 ms", which is much worse. 
Unfortunately, the patch does not offer a way to say "let the DMA engine 
wake up every 10 ms, and CPU wake up every 1000 ms (and occasionally 
perform rewinds, but leave 10 ms untouched)".

>
>
>     3. I have not seen any justification for the drastic measure of
>     making a DMA-based device completely unrewindable. Maybe a more
>     polite "please make this a batch/blocktransfer card" request, thus
>     disallowing only sub-period rewinds, would still be useful for
>     powersaving, without killing dmix.
>
>
> Can those non-interleaved access pcm device with two periods support
> rewind ?

Yes, but very carefully. E.g., suppose that the period size is 10 ms. 
Then, this sequence of events is valid, does not produce xruns and does 
not cause the card to play stale data:

0 ms: Application fills 2 periods via mmap, notices the timestamp and 
starts the PCM.
10 ms: Hardware plays out the 1st period and wakes up the application. 
Application writes the 1st period via mmap and notices the timestamp.
20 ms: Hardware plays out the 2nd period and wakes up the application. 
Application writes the 2nd period via mmap and notices the timestamp.
23 ms: Application wakes up for an unrelated reason and notices the 
timestamp. It knows that the sound card still has 17 ms to play, and 10 
ms (one period, as usual for batch/blocktransfer cards) are 
unrewindable. So it rewinds 6 ms and writes new data.
30 ms: Hardware plays out the 1st period and wakes up the application. 
Application writes the 1st period via mmap and notices the timestamp.

... and so on.

-- 
Alexander E. Patrakov
