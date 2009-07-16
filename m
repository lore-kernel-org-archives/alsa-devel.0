From: "John L. Utz III" <jutz@dmx.com>
Subject: Re: Testers wanted: New SB X-Fi driver
Date: Thu, 16 Jul 2009 12:20:12 -0700
Message-ID: <4A5F7D6C.9020606@dmx.com>
References: <4A5DB59B.2010407@freenet.de> <s5hvdltnfrp.wl%tiwai@suse.de>
	<1247769012.20483.0.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail.dmxmusic.com (mail.dmxmusic.com [199.201.237.35])
	by alsa0.perex.cz (Postfix) with ESMTP id 9943724779
	for <alsa-devel@alsa-project.org>;
	Thu, 16 Jul 2009 21:20:29 +0200 (CEST)
In-Reply-To: <1247769012.20483.0.camel@localhost.localdomain>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: "Ted T. Logan" <tedtheologian@gmail.com>
Cc: Takashi Iwai <tiwai@suse.de>, Frashman <frashman@freenet.de>, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Debug the problem, write code that fixes it and then send in a patch.
That's why this is the alsa *developers* mailing list.

Ted T. Logan wrote:
> Takashi, please, what must I do to get your xfi driver to stop clicking?
> 
> On Thu, 2009-07-16 at 11:22 +0200, Takashi Iwai wrote:
> 
>> At Wed, 15 Jul 2009 12:55:23 +0200,
>> Frashman wrote:
>>> Hi Takashi,
>>>
>>> first of all, thank you for developing this driver.
>>> I tested it today. It works, so far.
>>>
>>> But two annoying things. As you mentioned, I got problems, if the 
>>> onboard sound modules are loaded. Then i get no sound out auf my xfi.
>> It's likely the collision of PCI device ID.
>> Some X-Fi models support both HD-audio and emu20kx-native modes.  The
>> modes are switched by some magical sequence.
>>
>> Anyway, please run alsa-info.sh with --no-upload option, and attach
>> the generated file.
>>
>>> If I disable the loading of snd-hda-intel modules while booting, then it 
>>> works.
>>>
>>> The second problem is, that SIDE and SURROUND connectors are 
>>> interchanged. I'm absolutly sure, it works fine under windows and the 
>>> connector colors are also correct.
>>>
>>> If I run speaker-test -c8 the SIDE Speakers sounds come out of my REAR 
>>> (SURROUND) Speakers, while nothing is coming out of my rear speakers, if 
>>> i'm using speaker-test -c6
>> So, the side channels (channel 7 & 8) and the rear channels (3 & 4)
>> are swapped when running with 8 channel mode?
>>
>>
>> Takashi
>> _______________________________________________
>> Alsa-devel mailing list
>> Alsa-devel@alsa-project.org
>> http://mailman.alsa-project.org/mailman/listinfo/alsa-devel
> _______________________________________________
> Alsa-devel mailing list
> Alsa-devel@alsa-project.org
> http://mailman.alsa-project.org/mailman/listinfo/alsa-devel
> 
