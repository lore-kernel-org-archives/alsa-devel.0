From: =?UTF-8?B?QWRhbSBUbGHFgmth?= <atlka@pg.gda.pl>
Subject: Re: Re: [Alsa-user] AD1985 full-duplex(?)
Date: Wed, 29 Sep 2004 08:15:47 +0200
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <415A5313.6070400@pg.gda.pl>
References: <200409281457.i8SEvQNX023126@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <200409281457.i8SEvQNX023126@localhost.localdomain>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Paul Davis <paul@linuxaudiosystems.com>
Cc: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

> oh c'mon. thats not ALSA. the *kernel* can't meet your
> requirements. ALSA has nothing to do with it. OSS apps and drivers
> can't change the way the kernel schedules tasks. the same broken
> device drivers will coexist with any kernel-side API that you
> propose. you're mistaking where these issues exist.
The problem is that we have a new api and same problems as in old OSS 
api case. So we should improve drivers and their functionality - xrun 
detection and some additional features without changeing the api.
As you said it's not the api problem so why change it?
Broken compability, non working closed source apps or non portable 
between different operating systems that is the price of api change.
But do we have better functionality? Only a bit and old problems remain.

>>Yes - that's the point. Common operations like format changeing, 
>>resampling, remixing and additional effects should be done
>>in one place not in every app by itself.
>   ***   -lasound  ****
a program lib functions are working in this program context so without 
special RT program design we will always end up with bad sound effects.

>>I want to have possibility of doing cat file.wav > /dev/dsp
>>and play it with 5.1 or 2 speakers or with headphones with special 
> and you want this to work with no clicks or pops? and it will, i'm
> guessing, because you think that /dev/dsp is somehow going to
> magically know that it should use the maximum size buffer when used
> with no parameters?
It is the driver implementation - I think buffer should be large but 
period as small as possible. Swithing modes will not work without some
sound effects but we could mute the sound for the moment. And if done in 
kernel or RT daemon it should be fast enough. Anyway you are not doing 
that every second or so.

>>stereo  effects applied just by one click or keypress on special mixer 
>>app on the fly without restarting anything and fiddling with config 
> special mixer app eh? for which audio interface? who wrote it? does it
> work with my foobar GH8782 audio chipset?
Probably you should write it or someone who has access to doc and hw 
device. It should be an extension plugin for the RT audio daemon which 
provides additional funtionality.

> ALSA is not particularly friendly for audio profs. its not
> particularly friendly to *anyone*. but that is a completely different
> issue than the design of the API.
True so we don't need a new one.

Regards
-- 
Adam Tla/lka      mailto:atlka@pg.gda.pl    ^v^ ^v^ ^v^
System  & Network Administration Group           ~~~~~~
Computer Center,  Gdansk University of Technology, Poland
PGP public key:   finger atlka@sunrise.pg.gda.pl


-------------------------------------------------------
This SF.net email is sponsored by: IT Product Guide on ITManagersJournal
Use IT products in your business? Tell us what you think of them. Give us
Your Opinions, Get Free ThinkGeek Gift Certificates! Click to find out more
http://productguide.itmanagersjournal.com/guidepromo.tmpl
