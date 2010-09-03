From: David Henningsson <david.henningsson@canonical.com>
Subject: Re: [PATCH] ALSA: HDA: Fix front mic on Dell	Precision
 M6500
Date: Fri, 03 Sep 2010 05:43:57 +0200
Message-ID: <4C806EFD.8030106@canonical.com>
References: <4C72C5EF.6090600@canonical.com>
	<1282590450.2600.9.camel@laptop>	<4C72CB43.2040800@canonical.com>
	<s5hhbihoeq5.wl%tiwai@suse.de>	<s5hvd6sm40d.wl%tiwai@suse.de>
	<4C7CC4F4.7090907@canonical.com> <s5hpqwzm9kz.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from adelie.canonical.com (adelie.canonical.com [91.189.90.139])
	by alsa0.perex.cz (Postfix) with ESMTP id 442B4244C9
	for <alsa-devel@alsa-project.org>;
	Fri,  3 Sep 2010 05:43:59 +0200 (CEST)
In-Reply-To: <s5hpqwzm9kz.wl%tiwai@suse.de>
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

2010-08-31 11:10, Takashi Iwai skrev:
> At Tue, 31 Aug 2010 11:01:40 +0200,
> David Henningsson wrote:
>>
>> 2010-08-30 18:58, Takashi Iwai skrev:
>>> At Thu, 26 Aug 2010 12:22:42 +0200,
>>> I wrote:
>>>>
>>>> At Mon, 23 Aug 2010 21:25:55 +0200,
>>>> David Henningsson wrote:
>>>>>
>>>>> I admit that the best thing would be to make the driver support all
>>>>> three mics, but at this point, the alsa driver can only support two, one
>>>>> called "mic" and one called "front mic". I believe the best choice is to
>>>>> select the internal mic as "front mic" and the mic jack on the laptop as
>>>>> "mic", thus leaving the docking station mic jack non-functional.
>>>>>
>>>>> The behavior without this patch is to select the mic jack on the laptop
>>>>> as "mic" and the mic on the docking station as "front mic", thus leaving
>>>>> the internal mic non-functional in all cases, and that regardless of you
>>>>> have a docking station or not.
>>>>
>>>> OK, here is a test patch for fixing more intensively.  (I just did
>>>> build-test, totally untested with real machines :)
>>>>
>>>> It basically extends the config parser to allow multiple input pins
>>>> assigned for a single type.  The old input_pins field is kept for
>>>> other drivers, so that it won't give regressions.  It'll be removed
>>>> in future.
>>>
>>> As my tests with hda-emu through all codec data passed well, I
>>> committed the fixes to sound git tree now.
>>> Give the latest alsa-driver snapshot try.
>>
>> Thanks, I'll try to get someone to test it :-)
> 
> Great, thanks.

Got a response saying: "Working, had to select microphone 2."
https://launchpad.net/bugs/519066

-- 
David Henningsson, Canonical Ltd.
http://launchpad.net/~diwic
