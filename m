From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Subject: Re: Master Plan on rewinding
Date: Tue, 09 Sep 2014 14:56:09 -0500
Message-ID: <540F5B59.2080203@linux.intel.com>
References: <540C76E0.9050808@gmail.com> <540CE674.9010004@canonical.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
 by alsa0.perex.cz (Postfix) with ESMTP id EE2412652F1
 for <alsa-devel@alsa-project.org>; Tue,  9 Sep 2014 21:55:51 +0200 (CEST)
In-Reply-To: <540CE674.9010004@canonical.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: David Henningsson <david.henningsson@canonical.com>, "Alexander E. Patrakov" <patrakov@gmail.com>, ALSA Development Mailing List <alsa-devel@alsa-project.org>, Takashi Iwai <tiwai@suse.de>, Takashi Sakamoto <o-takashi@sakamocchi.jp>
List-Id: alsa-devel@alsa-project.org


>> 2. PulseAudio blindly assumes that it can rewind up to hwbuf_frames -
>> (snd_pcm_avail() + rewind_safeguard) frames. The rewind safeguard is
>> needed due to reasons that I don't completely understand, but one of
>> them is imprecise reporting of the hardware pointer, and another one is
>> that the hardware transfers several bytes at a time, and the bytes we
>> need to overwrite may be already cached by the hardware.
>
> Pierre added the rewind safeguard due to DMA controller problems. IIRC,
> some DMA controllers go nuts (such as breaking the stream, causing
> interrupt storms, or something else seriously buggy) when trying to
> write to data that the DMA controller is just about to transfer. Pierre
> (now cc:ed) would know more about this than I do, though.
>
> In my world, since this is a very hardware near problem, ALSA rather
> than PulseAudio should take these kinds of problems into account when
> reporting back snd_pcm_rewindable() so PulseAudio does not have to.


Sorry to chime-in late on this, my real job keeps me busy.
I would like to highlight that there is a fundamental conflict between 
requirements here.
- for power consumption optimization, you want to let the hardware 
prefetch audio samples opportunistically and buffer as much as possible 
as close as possible to the serial link. Given the pressure on power 
optimizations these days, no one should expect the hardware buffering to 
reduce - and this buffering could vary depending on the platform power 
modes with the position of the DMA read pointer becoming less predictable.
- for low-latency and user interaction, you want to rewind the write 
pointer as much as possible.

The question is 'how much'. The reason why i introduced this 
'rewind_safeguard' was to factor in a good-enough latency that no one 
would ever complain about and yet large enough to avoid using stale data.
We could ask drivers to provide a conservative estimate of this 
safeguard, but asking for a dynamic query of a safe position or an 
empirical determination based on the min period size is really asking 
for trouble. At a given point, if you really need very low-latency, i.e. 
sub ms, you will need a dedicated configuration that probably doesn't 
rely on rewinds and you probably don't use PulseAudio in the first place.
