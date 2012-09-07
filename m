From: David Henningsson <david.henningsson@canonical.com>
Subject: Re: [PATCH] ALSA: hda - Remove ignore_misc_bit
Date: Fri, 07 Sep 2012 16:28:19 +0200
Message-ID: <504A0483.3050807@canonical.com>
References: <1346995544-6754-1-git-send-email-david.henningsson@canonical.com>
 <s5hligmw3s0.wl%tiwai@suse.de> <5049D9EB.5070301@canonical.com>
 <s5h8vcmvy9s.wl%tiwai@suse.de> <5049E5F6.8010007@canonical.com>
 <s5h1uievwk6.wl%tiwai@suse.de> <5049ECD4.2040501@canonical.com>
 <s5hwr06ugi4.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from youngberry.canonical.com (youngberry.canonical.com
 [91.189.89.112])
 by alsa0.perex.cz (Postfix) with ESMTP id 65B2026171B
 for <alsa-devel@alsa-project.org>; Fri,  7 Sep 2012 16:28:21 +0200 (CEST)
In-Reply-To: <s5hwr06ugi4.wl%tiwai@suse.de>
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
Cc: alsa-devel@alsa-project.org, 939161@bugs.launchpad.net
List-Id: alsa-devel@alsa-project.org

On 09/07/2012 03:09 PM, Takashi Iwai wrote:
> At Fri, 07 Sep 2012 14:47:16 +0200,
> David Henningsson wrote:
>>
>> On 09/07/2012 02:36 PM, Takashi Iwai wrote:
>>> At Fri, 07 Sep 2012 14:17:58 +0200,
>>> David Henningsson wrote:
>>>> Or is the corner case that ALSA don't give the correct jack detection
>>>> value? If so I prefer it to be fixed in ALSA ;-)
>>>
>>> Well, I can think of different cases: BIOS is broken, my hardware is
>>> broken and the driver is broken.  In such a case, an easier test would
>>> be to disable this jack auto-things in PA, rather than fiddling with
>>> the pin config and reconfigure the driver, so I hoped there might be
>>> an intuitive and easy way to do that.
>>
>> Naah, in all those cases it is ALSA's responsibility to give a correct
>> answer up to PA - and as such, also to provide an "intuitive and easy
>> way" to disable jack detection if you feel there is a need. IMO.
>
> Adjusting a user-space things is much safer than adjusting something
> in kernel.  The former doesn't need a root privilege (if it's done
> right).  Thus for debugging purpose, fiddling with PA at first would
> be more comfortable than digging with the driver code and BIOS
> setups.
>
> Of course, a permanent fix is a different story.  I'm talking about
> the debuggability.
>
>> That said, it's not super difficult to comment out a few lines in
>> /usr/share/pulseaudio/alsa-mixer/paths/*.conf, and also, most mixer UIs
>> (e g pavucontrol) still allows you to route audio to an unavailable port.
>
> Yes, but some guidelines would be nice to have somewhere explicitly...
> Also this can be done without being root somehow, right?

Hmm, I'm afraid it's not so easy to turn off PulseAudio's jack detection 
without being root. Maybe it's possible using some .asoundrc magic?

Btw - I've never seen this as a practical problem myself. For debugging 
jack sense problems, I typically triage with
  1) "amixer contents" (PulseAudio or kernel space?)
  2) "sudo hda-jack-sense-test" (hardware or driver?)

Asking people to run a sudo command has never been a problem. (but maybe 
that's a problem in itself - i e that people are not security aware...)


-- 
David Henningsson, Canonical Ltd.
https://launchpad.net/~diwic
