From: Dan Nyborg <nyborg@vertice.ca>
Subject: Re: Trivial hdsp.c patch to support rev 50 cards
Date: Thu, 14 Aug 2003 22:06:02 -0400
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <3F3C400A.6000605@vertice.ca>
References: <NDBBLGIKBJENLAMOLFHGEEICCPAB.mknecht@controlnet.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <NDBBLGIKBJENLAMOLFHGEEICCPAB.mknecht@controlnet.com>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Mark Knecht <mknecht@controlnet.com>
Cc: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

hello mark,

sorry i did not reply sooner, i've been bogged down with work as well as 
preparation for a show.

i am in the same state that i was  earlier. paul had suggested that it 
was a mid-level alsa problem... so i found an ancient (ie: small) hard 
drive and now have a reasonably fsckable system to "debug" with. i dove 
into the code and littered it with "printk" statements to try and catch 
something, but i haven't alotted sufficient time to this brutish attempt.

i am thinking that somewhere in the pcm open or capture callbacks, a 
pointer gets lost and some mem write process goes way out of range, 
hosing memory reserved for something else... uh, that's what i think 
atleast. it's bad, as i get no (hee hee hee)oops, whatsoever. however, 
my kernel programming knowledge consists of what i have crammed in over 
the last few weeks, so it is miniscule and confused ;).

by the end of next week, i'll be able to get back at it.

best of luck all around,

dan.

Mark Knecht wrote:

>Dan,
>   I was revisiting the Alsa-Dev archives looking for information and came
>across this email from you. I had suggested you look at mono files. It
>didn't work for you.
>
>   Thomas Charbonnel and I have been working on the HDSP 9652 driver. He
>does coding then I do testing. I am now consistently in pretty much the
>state you described below. However, for me, I don't really have to reboot.
>If I just start a CD playing using alsaplayer, then I will get between 1
>second and maybe 45 seconds of audio, followed by a dead time with no audio,
>but if I wait, I'll again get more audio for a few seconds. On, off on, off.
>
>   I am on Alsa 0.9.6 with a bunch of patches that Thomas has done, but my
>results sound pretty similar to your. (I was not in as good a state earlier
>when we first talked!)
>
>   Have you made any headway solving this on your system?
>
>Thanks,
>Mark
>
>
>hello,
>
>i modified hdsp.c to support my rev. 50 card last week (the trivial way),
>and
>have been experimenting with it for the past three days. everything seems to
>work - midi, spdif lock... - i even downloaded Charbonnel's mixer app, and
>it
>works great! i use a multiface.
>
>however, when i try to play something with alsaplayer or aplay, my system
>freezes after 2 sec to 2 min of playback... sometimes i can get through a
>whole file, sometimes only partial, but an eventual lock-up is inevitable. i
>have not tried sending anything other than stereo, 44100kHz, 16bit files.
>
>has anyone seen such behavior with this driver?
>
>i am assuming it may have something to do with my setup: linux 2.4.20, alsa
>0.9.5 (with trivial patch to hdsp.c), devfs, recent multiface/pci card with
>rev. 50 firmware.
>
>there's atleast one other person with the same hammerfall set who will be
>trying it out in linux later this week...
>
>any comments appreciated,
>
>dan.
>
>
>
>  
>




-------------------------------------------------------
This SF.Net email sponsored by: Free pre-built ASP.NET sites including
Data Reports, E-commerce, Portals, and Forums are available now.
Download today and enter to win an XBOX or Visual Studio .NET.
http://aspnet.click-url.com/go/psa00100003ave/direct;at.aspnet_072303_01/01
