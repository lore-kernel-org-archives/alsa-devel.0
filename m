From: Paul Davis <paul@linuxaudiosystems.com>
Subject: Re: The ALSA Situation
Date: Tue, 09 Nov 2004 20:50:46 -0500
Message-ID: <200411100150.iAA1okCE029069@localhost.localdomain>
References: <016301c4c6bb$a3613fa0$0a00000a@eugenia>
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-reply-to: Your message of "Tue, 09 Nov 2004 16:24:09 PST."
             <016301c4c6bb$a3613fa0$0a00000a@eugenia>
Sender: alsa-devel-admin@lists.sourceforge.net
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Eugenia Loli-Queru <eloli@eugenia.co.uk>
Cc: alsa-devel@lists.sourceforge.net, torvalds@osdl.org
List-Id: alsa-devel@alsa-project.org

>I am sorry, but from my POV, this mixer situation should be a SHOWSTOPPER 
>for alsa getting released out in the wild. I wouldn't imaging Be, Apple or 
>Microsoft releasing an OS or update where some of their sound drivers didn't 
>have mixing support. It is laughable in 2004 not having proper *transparent* 

Actually, if you used ASIO drivers on Windows or MacOS-preX, you would
find that many drivers did not support simultaneous access by multiple
applications.

>Alsa should have been a completely transparent thing as far the user is 
>concerned. Alsa is a framework, and so only developers should be messing 
>with it, not users. If the user needs to unmute the PCM, or write alsa 
>scripts to get some *basic* functionality, then the Alsa project has already 
>failed. Have you ever heard of Windows users talk about "GDI"? No. Why? 

Your analogy and complaints have some real merit to them. But I think
you may not be aware of an important difference that affects your
comparisons. Until very recently, and depending on who you talk to,
still to this day, the default Windows audio drivers are useless for
the needs of musicians and pro-audio users. Consequently, there is an
entirely different set of drivers that have existed (ASIO, GDIF and
others) specifically to get around these problems. For some people,
the new WDM drivers are acceptable for both consumer audio and high
end audio apps, but not all.

The situation on MacOS is, in some ways, analogous to the one on
Linux. Apple completely abandoned their old audio API when they moved
to OS X, and forced all developers to move to a radically new API
(CoreAudio) that in many cases required a complete redesign of
applications. This is one of the reasons why many audio apps for MacOS
took 1-2 years to be ported to OSX. CoreAudio is very nice, and was
the inspiration for JACK.

ALSA has attempted to provide a single driver framework for the kinds
of devices used by pro-audio people all the way down to consumer
stereo and 5.1 devices. It has been very successful at the lowest
levels, but it is true that it has failed to provide adequate
user-space and user-level tools, configuration management and
documentation. 

On the bright side, ALSA has not forced a radical level of application
design changes on developers, but has enabled consistency across all
kinds of hardware. Many audio developers have chosen to use JACK,
which *does* impose a major change from OSS, though most of these apps
are music/pro-audio apps, not everyday desktop tools. There is
increasing interest in using JACK in more of desktop role, but there
are some significant technical issues to be solved before that could
happen. JACK allows much more than just soundcard sharing, it allows
apps to route audio to each other.

>others like me, and I am so extremely surprised that the Alsa project hasn't 
>found a better solution for the problem after 4-5 years of development.

What might (and should) suprise you more is that ALSA has, during the
last 4-5 years, never consisted of more than 2 full time
developers. It is very, very difficult with that level of manpower to
accomplish the kinds of things you want to see. People in and around
the project have hoped that the incorporation of ALSA into 2.6 would
lead to a major rise in the number of developers working on ALSA. It
has helped to increase the number of bugfixers, but AFAIK it has had
little impact on the level of development activity for user-level
tools and utilities.

I don't want to try to make excuses for the state of ALSA at the
user-level. I myself, as a developer, am very frustrated by the lack
of a sufficiently abstract mixer API for the work I try to do. But
ALSA isn't going anywhere in the direction you and many others need it
to without some more people *really* getting into the development
team. No matter how much Jaroslav might agree with all that you've
said, there are not enough hours in the day (his or yours) to make
that happen.

--p



-------------------------------------------------------
This SF.Net email is sponsored by:
Sybase ASE Linux Express Edition - download now for FREE
LinuxWorld Reader's Choice Award Winner for best database on Linux.
http://ads.osdn.com/?ad_id=5588&alloc_id=12065&op=click
