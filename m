From: David Henningsson <david.henningsson@canonical.com>
Subject: Re: [RFC] Fix internal mic for Lenovo Ideapad U300s
Date: Mon, 02 Apr 2012 15:39:30 +0200
Message-ID: <4F79AC12.6010407@canonical.com>
References: <1333054100-8069-1-git-send-email-david.henningsson@canonical.com>
	<s5hwr62qhx6.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from youngberry.canonical.com (youngberry.canonical.com
	[91.189.89.112]) by alsa0.perex.cz (Postfix) with ESMTP id 68541244B6
	for <alsa-devel@alsa-project.org>;
	Mon,  2 Apr 2012 15:39:25 +0200 (CEST)
In-Reply-To: <s5hwr62qhx6.wl%tiwai@suse.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On 03/30/2012 04:31 PM, Takashi Iwai wrote:
> At Thu, 29 Mar 2012 22:48:20 +0200,
> David Henningsson wrote:
>>
>> The internal mic input is phase inverted on one channel.
>> To avoid people in userspace summing the channels together
>> and get zero result, use a separate mixer control for the
>> inverted channel.
>>
>> BugLink: https://bugs.launchpad.net/bugs/903853
>> Signed-off-by: David Henningsson<david.henningsson@canonical.com>
>> ---
>>
>> Inverted Internal Mic, take 2.
>>
>> I refined my idea a little. By calling the left channel "Internal Mic"
>> and the right channel "Inverted Internal Mic", we're giving the user a choice
>> whether to activate it or keeping it muted.
>>
>> For PulseAudio, the quick fix is just to make sure the "Inverted Internal Mic"
>> control is muted. If we in the long run want to actually handle this and swap
>> the phase around, we now also have a reasonable indicator if we should do this,
>> by checking if the "Inverted Internal Mic" control exists.
>>
>> For the ALSA init DB (i e, should the "Inverted Internal Mic" be initially muted?)
>> that is no big deal for me, since this will be overwritten by PulseAudio later
>> anyway.
>>
>> I'm also open for better names than "Inverted Internal Mic" if you have any.
>>
>> As with the previous version, this is a draft version of the patch, and could be
>> done slightly more elegant I guess.
>>
>> What do you say?
>
> Good, this sounds like a reasonable solution.

I'm happy you like it!

> About the name, I'm not sure, too.  I'm no good godfather.
> Maybe other people have a better clue.
>
> Once when the patch is finialized, let me know.

I've been working with it today, and I'm sending a new patch in a 
separate email.

> I think we clean up the fixup functions by moving the alc_fixup_*() as
> common functions.  ALC_FIXUP_SKU can be converted to an ALC_FIXUP_FUNC,
> then there is no Realtek-specific things there.

I'm happy for all consolidating between codec drivers. Perhaps this 
could be a good start for a new hda_auto.c file that separates the 
low-level communication in hda_codec.c, from the auto-parser related 
stuff which could reside in hda_auto.c?

-- 
David Henningsson, Canonical Ltd.
http://launchpad.net/~diwic
