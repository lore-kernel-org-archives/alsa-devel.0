From: Paul Davis <paul@linuxaudiosystems.com>
Subject: Re: Hammerfall DSP System Problems
Date: Tue, 10 Jun 2003 14:33:25 -0400
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <E19PnrW-0005mQ-00@sc8-sf-list1.sourceforge.net>
References: <NDBBLGIKBJENLAMOLFHGOECFCHAB.mknecht@controlnet.com>
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-reply-to: Your message of "Tue, 10 Jun 2003 11:06:04 PDT."
             <NDBBLGIKBJENLAMOLFHGOECFCHAB.mknecht@controlnet.com>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Mark Knecht <mknecht@controlnet.com>
Cc: frankgaetano@collegeclub.com, Alsa-Devel <Alsa-Devel@lists.sourceforge.net>
List-Id: alsa-devel@alsa-project.org

>I am having the very same problems with my HDSP 9652. What's even stranger
>is, in my case, that for one evening the card worked, at least as far as
>loading the driver. (No sound, but the driver loaded.) I was able to look at
>/proc/asound/card0 (or whatever the directory/device was at the time...) and
>see sensible stuff. I even took some screen shots and sent email to another
>individual as I was debugging why I had no sound.
>
>Later that evening I powered down. Upon rebooting the next morning it
>failed, and has failed ever since. That was last Thursday evening.

the same thing happened to me a week ago. i have, as usual, not had
time to investigate further.

>I too am using 0.9.4 as provided in the Gentoo emerge, along with a custom
>compiled kernel.
>
>Like you I think the HDSP driver understands my firmware revision. I have
>also downgraded and upgraded my firmware without success.
>
>This whole Alsa/HDSP thing is amazingly weird...

at the moment, i regret that we made the move to user-space loading of
the "firmware" when we did. i think now that it was a mistake to do it
at that time. it has caused a fundamental change in the way the driver
sets up, but it came at a time when we weren't confident that setup
was working for various cases. 




-------------------------------------------------------
This SF.net email is sponsored by:  Etnus, makers of TotalView, The best
thread debugger on the planet. Designed with thread debugging features
you've never dreamed of, try TotalView 6 free at www.etnus.com.
