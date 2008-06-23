From: Rene Herman <rene.herman@keyaccess.nl>
Subject: Re: [PATCH 1/2] wss_lib: move cs4231_lib into wss_lib
Date: Mon, 23 Jun 2008 13:53:04 +0200
Message-ID: <485F8EA0.70803@keyaccess.nl>
References: <20080619230718.044b7905.krzysztof.h1@poczta.fm>	<485EECB5.4070808@keyaccess.nl>
	<s5hbq1s4e6g.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtpq1.groni1.gr.home.nl (smtpq1.groni1.gr.home.nl
	[213.51.130.200])
	by alsa0.perex.cz (Postfix) with ESMTP id 9E3582489C
	for <alsa-devel@alsa-project.org>;
	Mon, 23 Jun 2008 13:52:26 +0200 (CEST)
In-Reply-To: <s5hbq1s4e6g.wl%tiwai@suse.de>
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
Cc: Alsa-devel <alsa-devel@alsa-project.org>, Krzysztof Helt <krzysztof.h1@poczta.fm>
List-Id: alsa-devel@alsa-project.org

On 23-06-08 12:51, Takashi Iwai wrote:

> At Mon, 23 Jun 2008 02:22:13 +0200,
> Rene Herman wrote:
>> On 19-06-08 23:07, Krzysztof Helt wrote:
>>
>>> From: Krzysztof Helt <krzysztof.h1@wp.pl>
>>>
>>> Move the file sound/isa/cs423x/cs4231_lib.c 
>>> into sound/isa/cs423x/wss_lib.c
>>> This is the first step toward merging all libraries
>>> for Windows Sound System compatible chips
>>> into a single library.
>>>
>>> Signed-off-by: Krzysztof Helt <krzysztof.h1@wp.pl>
>> Acked-by: Rene Herman <rene.herman@gmail.com>
>>
>> Only small request:
>>
>>> diff -urNp linux-alsa/sound/isa/wss/Makefile linux-mm/sound/isa/wss/Makefile
>>> --- linux-alsa/sound/isa/wss/Makefile	1970-01-01 01:00:00.000000000 +0100
>>> +++ linux-mm/sound/isa/wss/Makefile	2008-06-15 22:38:44.705642447 +0200
>>> @@ -0,0 +1,10 @@
>>> +#
>>> +# Makefile for ALSA
>>> +# Copyright (c) 2008 by Krzysztof Helt <krzysztof.h1@wp.pl>
>>> +#
>>> +
>>> +snd-wss-lib-objs := wss_lib.o
>>> +
>>> +# Toplevel Module Dependency
>>> +obj-$(CONFIG_SND_WSS_LIB) += snd-wss-lib.o
>>> +
>> Could you maybe "donate" the copyright on this Makefile to Jaroslav Kysela?
>>
>> Basically, this single file is too trivial (and uncreative due to being 
>> rather fully dictated by the build-system as a whole) to be protectable 
>> under copyright in the first place but the ALSA build system as a whole 
>> IS copyrightable and Jaroslav holds the copyright on all others (except 
>> David Miller on the one sparc specific one).
>>
>> It's likely not a practical issue really but I feel it's probably good 
>> to keep this concentrated.
> 
> Well, I don't think it's worth to change the copyright as you
> suggest.  First of all, it's Krzysztof's work.  And, managing the
> different copyright notes isn't any problem in linux kernel tree at
> all, even from the maintenance POV.
> 
> Just my $0.02, though.

Yes, I sort of felt it wasn't really my place to make that comment but I 
keep around several directories privately here and thought about it 
before...

Now if I'm not mistaken I once saw that these ALSA makefile fragments 
are or were actually generated semi-automatically from the alsa-driver 
tree setup (which would also explain the very uniform 2001 copyright by 
Jaroslav) and as such replacing something that not has his own copyright 
header on it by one that does might be a bit awkward. And as said, in a 
legal sense, this is too trivial and uncreative to be copyrightable as a 
single file in the first place, whereas the build-system as a whole 
would be copyrightable (and is, by Jaroslav).

Now, admittedly, I might just need to be ignored as having thought about 
it too senselessly, and well, <shrug> and all, but any Makefile fragment 
I'd submit would have Jaroslav's copyright header on it. Ofcourse not on 
the code!

Rene.
