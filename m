From: Paul Davis <paul@linuxaudiosystems.com>
Subject: Re: The ALSA Situation
Date: Tue, 09 Nov 2004 21:55:18 -0500
Message-ID: <200411100255.iAA2tIAp030019@localhost.localdomain>
References: <001e01c4c6ce$77672eb0$0a00000a@eugenia>
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-reply-to: Your message of "Tue, 09 Nov 2004 18:38:55 PST."
             <001e01c4c6ce$77672eb0$0a00000a@eugenia>
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

>Why not move to OSS 4.x to the Linux kernel then (which is afaik actively 

Because OSS is a limitation for developers. It has *no* consistent API
for handling devices with many different designs. The debate over the
OSS API and the ALSA API has already been settled. And anyway, only a
minority anybody are writing new apps for either of these APIs. Most
people use abstract/portability layers such as the KDE/Gnome audio
APIs, or JACK or PortAudio.

>developed), when it's out? If alsa is the failure you are describing, with 

i did not say it was a failure - please do not twist my words in that
way. it has been very successful at the driver level, but there is
still a lot more work to be done in terms of user tools. 

>no extra devs working on it, I see absolutely no reason for it to be used as 
>default in the kernel and drive more developers to use it instead of OSS 

the reason is that OSS' design is inadequate for the range of h/w that
is now available. there is no consistent and efficient way to address 
different kinds of h/w, so apps have to be written with a specific h/w
design in mind. i've had this debate endlessly with people over the
last several years. some OSS fans (including 4Front people) continue
to insist that OSS can do the job, but I have never been persuaded
that I could use the OSS API to write an app that would run on both a
Hammerfall DSP and a SoundBlaster or AC97 consumer card with the
appropriate efficiency in both cases.

>(and also develop an alsa 1.0.2 wrapper in order to keep compatibility with 
>alsa apps so far). Sure, OSS is not GPL, but who cares, if it does the job 

who cares? Linus cares, for a start, and he's just one of thousands.

>BTW, in my previous email, I forgot to mention two more huge problems with 
>alsa:
>1. again with the mixing thing, browsers will stall and not load a flash 
>webpage if another app uses the sound device. It's tragic to see firefox not 
>loading www.macromedia.com for example, just because xmms is playing a 
>song...

this is not a different problem from the ones you mentioned. its the
same problem.

>2. This: http://www.osnews.com/img/6443/audio.png Check the clean and 
>logical OSS options and then check the endless alsa ones (my monitor was not 
>wide enough to fit them all). Why things like that are not cleaned up? (it's 
>not gnome's volume control fault btw, I asked the developer, he said it's 

because ALSA started out trying to represent the *full* capabilities
of the hardware mixer, rather than starting from a small common subset
and then later figuring out how to manage wildly new/different
capabilities in new hardware. how would OSS represent a matrix mixer?
how would it represent a device with new types of switches that don't
exist in a "simple" mixer?

it has been realized that user-space is in dire need of a simple mixer
layer, and it has been discussed several times. but once again, even
if the path forward is clear, it needs someone to actually have the
time to do the work.

--p


-------------------------------------------------------
This SF.Net email is sponsored by:
Sybase ASE Linux Express Edition - download now for FREE
LinuxWorld Reader's Choice Award Winner for best database on Linux.
http://ads.osdn.com/?ad_id=5588&alloc_id=12065&op=click
