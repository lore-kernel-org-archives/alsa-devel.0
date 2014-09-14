From: "Alexander E. Patrakov" <patrakov@gmail.com>
Subject: Re: Master Plan on rewinding
Date: Sun, 14 Sep 2014 18:07:23 +0600
Message-ID: <541584FB.2030208@gmail.com>
References: <540C76E0.9050808@gmail.com>	<54148E72.2050903@gmail.com>
 <CAN8cciYj4fo01XZwJ-NhFQDNv6Ua5mqaAEq1zU7PYxHkJyOQ5A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-la0-f54.google.com (mail-la0-f54.google.com
 [209.85.215.54])
 by alsa0.perex.cz (Postfix) with ESMTP id D7A5E264F3F
 for <alsa-devel@alsa-project.org>; Sun, 14 Sep 2014 14:07:26 +0200 (CEST)
Received: by mail-la0-f54.google.com with SMTP id ge10so3143595lab.41
 for <alsa-devel@alsa-project.org>; Sun, 14 Sep 2014 05:07:26 -0700 (PDT)
In-Reply-To: <CAN8cciYj4fo01XZwJ-NhFQDNv6Ua5mqaAEq1zU7PYxHkJyOQ5A@mail.gmail.com>
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
Cc: Takashi Iwai <tiwai@suse.de>, ALSA Development Mailing List <alsa-devel@alsa-project.org>, Clemens Ladisch <clemens@ladisch.de>, David Henningsson <david.henningsson@canonical.com>, Takashi Sakamoto <o-takashi@sakamocchi.jp>
List-Id: alsa-devel@alsa-project.org

14.09.2014 17:37, Raymond Yau wrote:
>
>  >
>  >
>  >> === On the rewind safeguard ===
>  >
>  >
>  > Result 1: it has been decided that the return value of
> snd_pcm_rewindable() is not changed, and the safeguard is returned by a
> separate function.
>
> It is unlikely to return any value which is safe, it is the
> responsiability of the application to decide how much can be rewind

You are placing a responsibility on an application without giving it any 
means to make an informed decision. E.g. 4 ms is OK on snd-hda-intel, 
but definitely not OK on ymfpci even on infinitely fast CPU (because of 
the fixed 5 ms interrupt interval). The whole question here is: how is 
an application supposed to know that?

>
> If pulseaudio assume 20ms process time is require to process two seconds
> of audio and sleep for 1980ms, it should not assume cpu have infinite power

You are right. The safeguard interval is a sum of the CPU-independent 
but card-specific part (which is what is being talked about) and a 
CPU-specific part (which the application indeed should know).

>
> what is the purpose of the timestamp ?
>
> Can the timestamp use to predict when will next period update occur if
> the timestamp is obtained at previous period update ?

See http://0pointer.de/blog/projects/pulse-glitch-free.html

>
> Why snd_pcm_rewind cannot return error when application  just set stop
> threshold to buffer size and rewind more than the stop threshold ?

I think it does. The problem (due to which we need a safeguard) is that 
the card-specific minimum number of not-really-rewindable samples 
exists. E.g., for ymfpci, that would be 5 ms.

>
> :This would require documentation changes for snd_pcm_rewindable(),
> though, as it officially no longer returns "safe count of frames which
> can be rewinded". I have difficulty designing a better wording what the
> function actually means now.
>
> The word "safe" should be removed

That's insufficient. The returned value is valid only in the ring-buffer 
model for a card that fetches samples absolutely uniformly one at a 
time, i.e. without any batching, updates the pointer at every 
played-back sample, and doesn't have any "don't overwrite what I am 
DMA-ing or I will kill you with IRQs" quirk. I.e., even with the 
infinitely fast CPU, an attempt to rewind as much as that function 
returns (and then overwrite) will yield a glitch (that may or may not be 
detected as xrun even if xrun detection is enabled).

-- 
Alexander E. Patrakov
