From: David Henningsson <david.henningsson@canonical.com>
Subject: Re: [PATCH] ALSA: hda - Don't be too specific for
 conflicting boost ctl names
Date: Thu, 19 Dec 2013 12:46:13 +0100
Message-ID: <52B2DC85.4020901@canonical.com>
References: <1387388362-1005-1-git-send-email-tiwai@suse.de>
 <52B28583.3050909@canonical.com> <s5h1u19t7d0.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from youngberry.canonical.com (youngberry.canonical.com
 [91.189.89.112])
 by alsa0.perex.cz (Postfix) with ESMTP id CDAE0265357
 for <alsa-devel@alsa-project.org>; Thu, 19 Dec 2013 12:46:13 +0100 (CET)
In-Reply-To: <s5h1u19t7d0.wl%tiwai@suse.de>
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
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On 12/19/2013 12:20 PM, Takashi Iwai wrote:
> At Thu, 19 Dec 2013 06:34:59 +0100,
> David Henningsson wrote:
>>
>> On 12/18/2013 06:39 PM, Takashi Iwai wrote:
>>> When a boost control influences on multiple input paths, we shouldn't
>>> pick up the name string specific to one input but rather choose a more
>>> generic name.  A problem seen often is that a single mic boost
>>> controls both internal and external mics although the driver picks up
>>> the very first name randomly like "Internal Mic Boost".  This should
>>> have been "Mic Boost", instead.
>>>
>>> This patch tries to correct that behavior: when a boost control is
>>> available, check whether it conflicts with other inputs.  If it does,
>>> use a common string ("Mic", "Line") as long as possible, or take a
>>> generic name "Input".
>>
>> Hrm. I thought today "Mic Boost" is quite common, and meaning the mic
>> boost of the non-internal mic. So I agree there is a problem - and thank
>> you for trying to fix it - but isn't this just changing one problem for
>> another? Now we don't know if a "Mic Boost" control controls the
>> internal mic or not.
> 
> That's true, and the problem isn't new...
> I'm fine to use a different name as a boost control used for multiple
> mics, though.  Spell your wish.

If *all* inputs go through the boost, then just preferring "Capture
Boost" or "Input Boost" over "Mic Boost" would do the trick. I e, just
skip the logic that checks for all inputs being of the same type.

The problem is when a boost controls two inputs but not the third. But
since your code only looks through the input paths that go through the
boost control and not the ones that don't, maybe we can save that
problem for another day...


-- 
David Henningsson, Canonical Ltd.
https://launchpad.net/~diwic
