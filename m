From: Paul Davis <paul@linuxaudiosystems.com>
Subject: Re: patch for hammerfall driver
Date: Mon, 03 Feb 2003 09:49:59 -0500
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <E18fhrT-0007US-00@sc8-sf-list1.sourceforge.net>
References: <s5hznpdh6zv.wl@alsa2.suse.de>
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-reply-to: Your message of "Mon, 03 Feb 2003 13:40:52 +0100."
             <s5hznpdh6zv.wl@alsa2.suse.de>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Takashi Iwai <tiwai@suse.de>
Cc: "John S. Denker" <jsd@monmouth.com>, alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

>> To be explicit:  whenever you see a bug, don't just
>> ask how to fix this instance of the bug;  ask what
>> it would take to make sure no bug of this ilk ever
>> occurs again.
>> 
>> In this case:
>>   a) It would help to have some comments in the code
>> saying where the constants are coming from, so that
>> misconceptions can be more easily spotted.
>>   b) It would help to use correctly computed constants
>> such as

actually, neither would have really helped very much here. i don't
know who set the values to those that were here before. the values
were clearly wrong on any reading of the code, and i've thought about
them on previous readings. the values that were there before were not
"buggy" - they were completely wrong.

the problem here was social rather than technical: i never had a
reason or the time to do anything to answer my questions about the
values that were there.

the last few days have seen me trying to debug some rather deep
problems with a specific hdsp configuration, and i wanted to run JACK
with 8192 frame periods. i couldn't do it, and ended up having to go
back and deal with those numbers so that i could. 

>>   c) When applying the sizeof() operator, don't
>> apply it to general-purpose types such as int, but
>> rather apply it to an object that is provably
>> of the type you care about, in this case something

agreed. i had meant to remove the sizeof() from the patch before i
posted it. 

--p


-------------------------------------------------------
This SF.NET email is sponsored by:
SourceForge Enterprise Edition + IBM + LinuxWorld = Something 2 See!
http://www.vasoftware.com
