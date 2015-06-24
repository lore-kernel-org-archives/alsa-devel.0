From: David Henningsson <david.henningsson@canonical.com>
Subject: Re: [PATCH] ALSA: hda - Fix Dock Headphone on Thinkpad X250 seen
 as a Line Out
Date: Wed, 24 Jun 2015 13:06:05 +0200
Message-ID: <558A8F1D.1000606@canonical.com>
References: <1435135593-6176-1-git-send-email-david.henningsson@canonical.com> <s5hsi9hwker.wl-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <stable-owner@vger.kernel.org>
In-Reply-To: <s5hsi9hwker.wl-tiwai@suse.de>
Sender: stable-owner@vger.kernel.org
To: Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel@alsa-project.org, stable@vger.kernel.org
List-Id: alsa-devel@alsa-project.org



On 2015-06-24 11:00, Takashi Iwai wrote:
> At Wed, 24 Jun 2015 10:46:33 +0200,
> David Henningsson wrote:
>>
>> Thinkpad X250, when attached to a dock, has two headphone outs but
>> no line out. Make sure we don't try to turn this into one headphone
>> and one line out (since that disables the headphone amp on the dock).
>>
>> Alsa-info at http://www.alsa-project.org/db/?f=36f8764e1d782397928feec715d0ef90dfddd4c1
>>
>> Cc: stable@vger.kernel.org
>> Signed-off-by: David Henningsson <david.henningsson@canonical.com>
>
> This is one of fixes I had in mind (and asked for testing in bugzilla
> kernel.org report).

Sorry, I'm missing context. What report?

> One drawback by this is that the auto-mute
> *between* the headphones won't work like before.  If one has expected
> it, then this can be seen as a regression.

Fair enough, we can drop stable from the patch since this could be seen 
as behavioural change rather than bug fix.

> Another fix was to change this as a proper line-out.  This will keep
> the current auto-mute behavior.
>
> OTOH, dealing both jacks equally is also not bad, per se.

The tricky thing about routing is that everyone wants it different, so 
pleasing everyone seems to be an impossible equation :-/

I would choose the default behaviour (headphone or line out) based on 
the icon on the jack. I should double-check that with someone who has 
the hardware. And then, if someone wants another behaviour then 
hdajackretask can be used. Or we can add a jack mode kcontrol for that 
jack, if you prefer, although I'd have to check how PulseAudio handles 
that (not that well, is my gut feeling).


-- 
David Henningsson, Canonical Ltd.
https://launchpad.net/~diwic
