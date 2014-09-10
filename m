From: "Alexander E. Patrakov" <patrakov@gmail.com>
Subject: Re: Master Plan on rewinding
Date: Wed, 10 Sep 2014 11:38:06 +0600
Message-ID: <540FE3BE.1000504@gmail.com>
References: <540C76E0.9050808@gmail.com> <540CE674.9010004@canonical.com>
 <540F5B59.2080203@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-la0-f48.google.com (mail-la0-f48.google.com
 [209.85.215.48])
 by alsa0.perex.cz (Postfix) with ESMTP id 607FA26172C
 for <alsa-devel@alsa-project.org>; Wed, 10 Sep 2014 07:38:09 +0200 (CEST)
Received: by mail-la0-f48.google.com with SMTP id ty20so8262869lab.21
 for <alsa-devel@alsa-project.org>; Tue, 09 Sep 2014 22:38:09 -0700 (PDT)
In-Reply-To: <540F5B59.2080203@linux.intel.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>, David Henningsson <david.henningsson@canonical.com>, ALSA Development Mailing List <alsa-devel@alsa-project.org>, Takashi Iwai <tiwai@suse.de>, Takashi Sakamoto <o-takashi@sakamocchi.jp>
List-Id: alsa-devel@alsa-project.org

10.09.2014 01:56, Pierre-Louis Bossart wrote:
>
>>> 2. PulseAudio blindly assumes that it can rewind up to hwbuf_frames -
>>> (snd_pcm_avail() + rewind_safeguard) frames. The rewind safeguard is
>>> needed due to reasons that I don't completely understand, but one of
>>> them is imprecise reporting of the hardware pointer, and another one is
>>> that the hardware transfers several bytes at a time, and the bytes we
>>> need to overwrite may be already cached by the hardware.
>>
>> Pierre added the rewind safeguard due to DMA controller problems. IIRC,
>> some DMA controllers go nuts (such as breaking the stream, causing
>> interrupt storms, or something else seriously buggy) when trying to
>> write to data that the DMA controller is just about to transfer. Pierre
>> (now cc:ed) would know more about this than I do, though.
>>
>> In my world, since this is a very hardware near problem, ALSA rather
>> than PulseAudio should take these kinds of problems into account when
>> reporting back snd_pcm_rewindable() so PulseAudio does not have to.
>
>
> Sorry to chime-in late on this, my real job keeps me busy.

Better late than never.

> I would like to highlight that there is a fundamental conflict between
> requirements here.
> - for power consumption optimization, you want to let the hardware
> prefetch audio samples opportunistically and buffer as much as possible
> as close as possible to the serial link. Given the pressure on power
> optimizations these days, no one should expect the hardware buffering to
> reduce - and this buffering could vary depending on the platform power
> modes with the position of the DMA read pointer becoming less predictable.
> - for low-latency and user interaction, you want to rewind the write
> pointer as much as possible.

Spot-on.

> The question is 'how much'. The reason why i introduced this
> 'rewind_safeguard' was to factor in a good-enough latency that no one
> would ever complain about and yet large enough to avoid using stale data.
> We could ask drivers to provide a conservative estimate of this
> safeguard, but asking for a dynamic query of a safe position or an
> empirical determination based on the min period size is really asking
> for trouble. At a given point, if you really need very low-latency, i.e.
> sub ms, you will need a dedicated configuration that probably doesn't
> rely on rewinds and you probably don't use PulseAudio in the first place.

Well, now there are two people criticizing the heuristic. I would like 
to retract it, but I currently can't, because there are no other 
constructive proposals.

The best solution would indeed be if a driver provides a conservative 
estimate of the rewind safeguard, but the problem is that nobody will 
add this to old drivers for no-longer-manufactured hardware. So we 
either need some other heuristic here, or we have to allow rewinding 
further than the nearest period only on cards where drivers explicitly 
say OK by providing a safeguard value. But the later proposal kills 
power-efficient PulseAudio on old kernels that simply don't know how to 
provide this information. Surely you won't like it.

-- 
Alexander E. Patrakov
