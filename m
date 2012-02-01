From: David Henningsson <david.henningsson@canonical.com>
Subject: Re: [PATCH] ALSA: HDA: Fix jack creation for codecs
 with front and rear Line In
Date: Wed, 01 Feb 2012 09:19:25 +0100
Message-ID: <4F28F58D.4060707@canonical.com>
References: <1327997055-7855-1-git-send-email-david.henningsson@canonical.com>
	<s5hk448neh2.wl%tiwai@suse.de> <4F28088E.5060203@canonical.com>
	<s5h62frop7t.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from youngberry.canonical.com (youngberry.canonical.com
	[91.189.89.112])
	by alsa0.perex.cz (Postfix) with ESMTP id 300601038E7
	for <alsa-devel@alsa-project.org>; Wed,  1 Feb 2012 09:19:28 +0100 (CET)
In-Reply-To: <s5h62frop7t.wl%tiwai@suse.de>
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

On 01/31/2012 04:40 PM, Takashi Iwai wrote:
> At Tue, 31 Jan 2012 16:28:14 +0100,
> David Henningsson wrote:
>>
>> On 01/31/2012 03:17 PM, Takashi Iwai wrote:
>>> At Tue, 31 Jan 2012 09:04:15 +0100,
>>> David Henningsson wrote:
>>>>
>>>> If a codec has both a front and a rear Line In, two controls both
>>>> named "Line Jack" will be created, which causes parsing to fail.
>>>> While a long term solution might be to name the jacks differently,
>>>> this extra check is consistent with what is already being done in many
>>>> auto-parsers, and will also protect against other cases when two
>>>> inputs have the same label.
>>>>
>>>> BugLink: https://bugs.launchpad.net/bugs/923409
>>>> Signed-off-by: David Henningsson<david.henningsson@canonical.com>
>>>
>>> Thanks, applied now.
>>>
>>> BTW, any chance to change apport to gather alsa-info.sh output?

This has now been provided: 
http://www.alsa-project.org/db/?f=f4a8312f34573a24f60011109e18f0c7371129e0

>>> It'd be a great help, so that we can check it via hda-emu.
>>
>> I have asked for this particular bug reporter to supply alsa-info as
>> well, but may I ask you...do you have some kind of regression test
>> script, and if so, are they public? Or could it a part of hda-emu?
>
> The checks I often do are scripts like below.  Run for all files
> and check the difference before and after the patch.
>
>> It would be nice if you could run "make tests" or something from the
>> hda-emu source directory, and it would parse all codecs and report error
>> if parsing fails (or pm fails, etc).
>
> Yeah, any patch is welcome ;)

Thanks for the small test scripts! It's good to be on the same page. 
Hopefully I get around some day to write a "make tests", but not right 
now unfortunately.

I quickly ran test2 and noticed that
  - We have quite a lot of work to do before all errors are fixed!
  - The error I got from hda-emu for the codec above, 'Control element 
Line Jack:0 already exists!' was already present for one of the codecs.

-- 
David Henningsson, Canonical Ltd.
http://launchpad.net/~diwic
