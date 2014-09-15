From: "Alexander E. Patrakov" <patrakov@gmail.com>
Subject: Re: Master Plan on rewinding
Date: Mon, 15 Sep 2014 15:58:42 +0600
Message-ID: <5416B852.6080406@gmail.com>
References: <540C76E0.9050808@gmail.com>	<54148E72.2050903@gmail.com>	<CAN8cciYj4fo01XZwJ-NhFQDNv6Ua5mqaAEq1zU7PYxHkJyOQ5A@mail.gmail.com>	<541584FB.2030208@gmail.com>
 <s5hiokpw89h.wl-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-la0-f44.google.com (mail-la0-f44.google.com
 [209.85.215.44])
 by alsa0.perex.cz (Postfix) with ESMTP id 1F2AD261785
 for <alsa-devel@alsa-project.org>; Mon, 15 Sep 2014 11:57:02 +0200 (CEST)
Received: by mail-la0-f44.google.com with SMTP id mc6so4281602lab.17
 for <alsa-devel@alsa-project.org>; Mon, 15 Sep 2014 02:57:01 -0700 (PDT)
In-Reply-To: <s5hiokpw89h.wl-tiwai@suse.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Takashi Iwai <tiwai@suse.de>
Cc: Raymond Yau <superquad.vortex2@gmail.com>, ALSA Development Mailing List <alsa-devel@alsa-project.org>, Clemens Ladisch <clemens@ladisch.de>, David Henningsson <david.henningsson@canonical.com>, Takashi Sakamoto <o-takashi@sakamocchi.jp>
List-Id: alsa-devel@alsa-project.org

15.09.2014 15:19, Takashi Iwai wrote:
> At Sun, 14 Sep 2014 18:07:23 +0600,
> Alexander E. Patrakov wrote:
>>
>> 14.09.2014 17:37, Raymond Yau wrote:
>>>
>>>   >
>>>   >
>>>   >> === On the rewind safeguard ===
>>>   >
>>>   >
>>>   > Result 1: it has been decided that the return value of
>>> snd_pcm_rewindable() is not changed, and the safeguard is returned by a
>>> separate function.
>>>
>>> It is unlikely to return any value which is safe, it is the
>>> responsiability of the application to decide how much can be rewind
>>
>> You are placing a responsibility on an application without giving it any
>> means to make an informed decision. E.g. 4 ms is OK on snd-hda-intel,
>> but definitely not OK on ymfpci even on infinitely fast CPU (because of
>> the fixed 5 ms interrupt interval). The whole question here is: how is
>> an application supposed to know that?
>
> Well, maybe the word "safeguard" is somewhat confusing to be used as
> a driver API.  There is no "safety" at all there.  There is only
> "theoretically minimal" (and it often lies even if the hardware chip
> says so).  How much value to be taken as "safeguard" is rather a
> choice by each application or sound backend.

I agree with this "bad wording" remark. Let's talk about the 
"theoretically minimal non-rewindable amount of samples" from now on.

> Right now, the only information we give from the sound driver is
> INFO_BATCH flag.  And I agree with a bit more detailed information to
> be exposed from the driver -- but only if possible.  This must be an
> optional information and not mandatory.

Here I mostly agree.

Indeed, this INFO_BATCH flag exists. However, its documentation is so 
vague that IMHO a documentation patch is needed to legitimize its use as 
a "you must not leave less than one period when rewinding" indicator. 
Also, the documentation says about snd_pcm_hw_params_is_batch(): "This 
function should only be called when the configuration space contains a 
single configuration" - I believe that it is an error (and PulseAudio 
calls it without obeying this restriction), because this function is 
helpful exactly for choosing hardware parameters such as period size. 
May I write "if the configuration space contains more than one 
configuration, the result indicates whether a configuration exists where 
such double-buffering is done"? Also the documentation talks about 
"hardware", should I extend it to the whole plugin chain?

As for the desire to export other information if available, it is 
certainly good.

What remains not fully understood for me is the claim that the 
information already exposed by every driver (in the form of the minimal 
period size) is not useful. I understand that two people are against 
this idea, so it must be bad. But I must understand why. Is it because 
the minimum period size reported by some drivers (which ones are 
suspected, if any?) may be a lie?

Clemens Ladisch mentioned USB as a counterexample, but it is a batch 
device for which the current period size is more relevant than the 
minimal one. Pierre-Louis Bossart just said that it is "really asking 
for trouble" without much explanation.

Can anyone name a sound controller that is not of a batch variety, where 
the theoretically minimal non-rewindable amount of samples is, at some 
settings, higher than the reported minimum period size at the same 
number of channels, sample rate and sample format?

[and yes, I understand that I can always cheat and say: let's change the 
definition of INFO_BATCH so that it includes such cases]

-- 
Alexander E. Patrakov
