From: David Henningsson <david.henningsson@canonical.com>
Subject: Re: Master Plan on rewinding
Date: Mon, 08 Sep 2014 01:12:52 +0200
Message-ID: <540CE674.9010004@canonical.com>
References: <540C76E0.9050808@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from youngberry.canonical.com (youngberry.canonical.com
 [91.189.89.112])
 by alsa0.perex.cz (Postfix) with ESMTP id 72C8A2610AA
 for <alsa-devel@alsa-project.org>; Mon,  8 Sep 2014 01:12:45 +0200 (CEST)
In-Reply-To: <540C76E0.9050808@gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: "Alexander E. Patrakov" <patrakov@gmail.com>, ALSA Development Mailing List <alsa-devel@alsa-project.org>, Takashi Iwai <tiwai@suse.de>, Takashi Sakamoto <o-takashi@sakamocchi.jp>
Cc: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
List-Id: alsa-devel@alsa-project.org



On 2014-09-07 17:16, Alexander E. Patrakov wrote:
> Hello.
>
> (TL;DR: nothing really new except the strawman proposal about threads
> and the note about interaction of variable sample rate with rewindability)
>
> As Takashi Iwai told me that the audio miniconference is for discussion
> only, and not for presentation of anything, I guess that I need to
> present the plans and options now. That's why this e-mail. The goal
> here, besides merely presenting the plan, is to identify points that
> everyone agrees upon, so that they are not discussed pointlessly at the
> miniconference. Also, this e-mail serves as a justification for the
> pending seemingly-destructive work.
>
> First, the status quo. If anyone disagrees with the facts below, please
> complain loudly, before I make any conclusions!
>
> 1. PulseAudio does not call snd_pcm_rewindable(), because for some ALSA
> plugins it crashed. This crash is completely fixed in alsa-lib 1.0.28,
> but in some cases snd_pcm_rewindable() still returns wrong results.

I don't know if we ever tried snd_pcm_rewindable() in PulseAudio.

> 2. PulseAudio blindly assumes that it can rewind up to hwbuf_frames -
> (snd_pcm_avail() + rewind_safeguard) frames. The rewind safeguard is
> needed due to reasons that I don't completely understand, but one of
> them is imprecise reporting of the hardware pointer, and another one is
> that the hardware transfers several bytes at a time, and the bytes we
> need to overwrite may be already cached by the hardware.

Pierre added the rewind safeguard due to DMA controller problems. IIRC, 
some DMA controllers go nuts (such as breaking the stream, causing 
interrupt storms, or something else seriously buggy) when trying to 
write to data that the DMA controller is just about to transfer. Pierre 
(now cc:ed) would know more about this than I do, though.

In my world, since this is a very hardware near problem, ALSA rather 
than PulseAudio should take these kinds of problems into account when 
reporting back snd_pcm_rewindable() so PulseAudio does not have to.

-- 
David Henningsson, Canonical Ltd.
https://launchpad.net/~diwic
