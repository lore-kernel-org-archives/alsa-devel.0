From: Paul Davis <paul@linuxaudiosystems.com>
Subject: Re: Re: [Alsa-user] AD1985 full-duplex(?)
Date: Tue, 28 Sep 2004 10:57:26 -0400
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <200409281457.i8SEvQNX023126@localhost.localdomain>
References: <4159659B.2020702@pg.gda.pl>
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-reply-to: Your message of "Tue, 28 Sep 2004 15:22:35 +0200."
             <4159659B.2020702@pg.gda.pl>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: =?UTF-8?B?QWRhbSBUbGHFgmth?= <atlka@pg.gda.pl>
Cc: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

>current ALSA could not meet my requirements because of 
>swapping/scheduling effects which makes distorted sound in normal non RT 
>apps. Doing just a few more calls doesn't help in this case ;-[.

oh c'mon. thats not ALSA. the *kernel* can't meet your
requirements. ALSA has nothing to do with it. OSS apps and drivers
can't change the way the kernel schedules tasks. the same broken
device drivers will coexist with any kernel-side API that you
propose. you're mistaking where these issues exist.

>> you'd rather move the cost so that its in the
>> kernel or a library rather than be in your code. that's the best i can
>> understand so far.
>Yes - that's the point. Common operations like format changeing, 
>resampling, remixing and additional effects should be done
>in one place not in every app by itself.

  ***   -lasound  ****

>I want to have possibility of doing cat file.wav > /dev/dsp
>and play it with 5.1 or 2 speakers or with headphones with special 

and you want this to work with no clicks or pops? and it will, i'm
guessing, because you think that /dev/dsp is somehow going to
magically know that it should use the maximum size buffer when used
with no parameters?

>stereo  effects applied just by one click or keypress on special mixer 
>app on the fly without restarting anything and fiddling with config 

special mixer app eh? for which audio interface? who wrote it? does it
work with my foobar GH8782 audio chipset?

>files and program execution arguments.
>Current ALSA design is not user friendly and rather not meets these end 
>user requirements. May be it should be only for audio profs?

ALSA is not particularly friendly for audio profs. its not
particularly friendly to *anyone*. but that is a completely different
issue than the design of the API.

--p


-------------------------------------------------------
This SF.Net email is sponsored by: YOU BE THE JUDGE. Be one of 170
Project Admins to receive an Apple iPod Mini FREE for your judgement on
who ports your project to Linux PPC the best. Sponsored by IBM.
Deadline: Sept. 24. Go here: http://sf.net/ppc_contest.php
