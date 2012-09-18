From: David Henningsson <david.henningsson@canonical.com>
Subject: Re: [PATCH] ALSA: hda - Remove ignore_misc_bit
Date: Tue, 18 Sep 2012 10:40:19 +0200
Message-ID: <50583373.2010203@canonical.com>
References: <1346995544-6754-1-git-send-email-david.henningsson@canonical.com>
 <CAN8cciYZBU+LaaQFXrn9kPoFc=MdYahw0ucKNmAhrG=CT0+C5g@mail.gmail.com>
 <s5h392rhbyu.wl%tiwai@suse.de> <5056D395.4090603@canonical.com>
 <s5hpq5j4tyl.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from youngberry.canonical.com (youngberry.canonical.com
 [91.189.89.112])
 by alsa0.perex.cz (Postfix) with ESMTP id 5802826257E
 for <alsa-devel@alsa-project.org>; Tue, 18 Sep 2012 10:40:17 +0200 (CEST)
In-Reply-To: <s5hpq5j4tyl.wl%tiwai@suse.de>
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
Cc: Raymond Yau <superquad.vortex2@gmail.com>, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

[removing CC to bug, since this has gone a bit offtopic]

On 09/18/2012 10:26 AM, Takashi Iwai wrote:
> At Mon, 17 Sep 2012 09:39:01 +0200,
> David Henningsson wrote:
>>
>>> But the jack detection controls don't follow this yet.  Maybe we can
>>> set such a jack control as inactive state when the jack detection is
>>> disabled.
>>>
>>> (And this reminds me that we can cut off "Phantom" name hack by
>>>    following the same rule -- just set the control inactive when it has
>>>    no real detection.  But it still appears in control list.)
>>
>> Looking at the alsa-lib API, this seems doable. It seems possible to
>> figure out using snd_hctl_elem_info and then
>> snd_ctl_elem_info_is_inactive. If it is also runtime changeable (i e
>> depending on some other mixer control), we need a callback to fire on
>> the hctl.
>
> Why are you using snd_hctl?  For looking over jack controls, using
> snd_ctl_* is more straightforward.

Ehm, because I'm one of the confused users who doesn't know why there 
are four different APIs (ctl, hctl, mixer, smixer) in the first place? 
:-) And because I started with looking at the code to amixer. IIRC.

> Also, which callback are you thinking of?  The phantom jack is
> basically just a placeholder, so there should be no activity from
> itself.

You said something about the user telling the system to disable jack 
detection - if so, (s)he will probably do so by changing a (new?) 
kcontrol, which would then change the inactivity status of the jack 
kcontrol, and then we need to pick that change up.


-- 
David Henningsson, Canonical Ltd.
https://launchpad.net/~diwic
