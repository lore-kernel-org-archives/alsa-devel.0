From: "Eugenia Loli-Queru" <eloli@eugenia.co.uk>
Subject: The ALSA Situation
Date: Tue, 9 Nov 2004 16:24:09 -0800
Message-ID: <016301c4c6bb$a3613fa0$0a00000a@eugenia>
Reply-To: "Eugenia Loli-Queru" <eloli@eugenia.co.uk>
Mime-Version: 1.0
Content-Type: text/plain;
	format=flowed;
	charset="iso-8859-1";
	reply-type=original
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Sender: alsa-devel-admin@lists.sourceforge.net
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: alsa-devel@lists.sourceforge.net
Cc: torvalds@osdl.org
List-Id: alsa-devel@alsa-project.org

Hi,
I have outlined here the mixing problem of Alsa/OSS (read point #4):
http://www.osnews.com/story.php?news_id=8823

I am writing to express my dissapointment over the piss poor desktop 
experience I get out of 2 of my PCs because of this problem (and I know that 
there are actually... millions like me as these ac97 onboard cards are 
everywhere these days). When the alsa driver knows that there is no hardware 
mixing, a software one should be created automatically, and it should be 
100% transparent to all alsa/oss applications or other kde/gnome mixers. It 
should behave like hardware mixing was there all along.

You see, I have already created the dmix plugin utter crap, and LD_PRELOADed 
the aoss wrapper and have the .asoundrc file in place (and esd, arts, 
gstreamer, mplayer and xmms configured to use the new "default" alsa 
device). But even after all this work to figure out how to do all that (it 
literally took me 2 days of googling and trying to figure out the black 
magic of alsa scripting) there are too many other sound apps that simply 
don't obey the dmix plugin. There are apps that they won't even launch until 
I press "stop" on xmms! Sometimes I even forget that I have launched them, 
and then I stop xmms, and then sudenly, hours later, the app that was 
blocked before, it would popup in my face! You call this good usability?

Yes, you can claim that some "apps are broken and they don't use the alsa 
api properly". But I say this to you: if a framework allows for such kinds 
of problems, then the framework itself is broken, not the apps. Mixing is 
something that the apps should be getting automatically from ALSA, the 
developers should not add code to their apps to allow for stuff like 
"changing the default alsa device". There should NOT be, EVER, an error like 
"the sound card is used by another app". If this happens, it's a failure of 
the media framework, NOT the failure of the app (I have never,ever,ever,ever 
seen such an error on OSX or BeOS). Besides, when I email these devs to add 
support for alternative alsa devices, they reply "get another sound card". 
And how the heck am I going to get a new sound card for my laptop, I don't 
know (the problem is mostly with laptops, as these use these AC97 intel/via 
cards).

I believe that this is an important point for all Alsa developers to read, 
because I am not alone. Read the comments on that story I link, and you will 
see that many other people FULLY agree with me that playing one sound at a 
time when the sound card doesn't have a hardware mixer, is POOR Linux 
experience. It just kills the impression of the operating system.

I am sorry, but from my POV, this mixer situation should be a SHOWSTOPPER 
for alsa getting released out in the wild. I wouldn't imaging Be, Apple or 
Microsoft releasing an OS or update where some of their sound drivers didn't 
have mixing support. It is laughable in 2004 not having proper *transparent* 
mixing for both Alsa/OSS-emulation via the sound framework on a popular 
operating system, like Linux is. You replaced OSS for some arguably good 
reasons, but your solution is equally crappy from where I stand: default 
muting (!), no proper mixing, ultra-weird scripting that noone really 
understands, impossible to find out how to enable 5.1 surround (even if the 
driver is capable of it) etc...

Alsa should have been a completely transparent thing as far the user is 
concerned. Alsa is a framework, and so only developers should be messing 
with it, not users. If the user needs to unmute the PCM, or write alsa 
scripts to get some *basic* functionality, then the Alsa project has already 
failed. Have you ever heard of Windows users talk about "GDI"? No. Why? 
Because they don't have to. It just works. Same thing on Linux, Alsa or X11 
are things that users should not even know what they are. These should just 
work. Let the users worry about bugs or problems in the higher level skirts 
of a Linux distro, not the frameworks.

I am sorry if I sound a bit  angry over this, but I spent days trying to get 
more than one app to use the sound card at the same time (plus dmix would 
still not work properly with all apps), and I know that there are many-many 
others like me, and I am so extremely surprised that the Alsa project hasn't 
found a better solution for the problem after 4-5 years of development.

Rgds,
Eugenia



-------------------------------------------------------
This SF.Net email is sponsored by:
Sybase ASE Linux Express Edition - download now for FREE
LinuxWorld Reader's Choice Award Winner for best database on Linux.
http://ads.osdn.com/?ad_id=5588&alloc_id=12065&op=click
