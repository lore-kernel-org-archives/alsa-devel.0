From: Paul Davis <pbd@op.net>
Subject: Re: question regarding latest CS4205 laptop soundcard driver
Date: Wed, 27 Feb 2002 10:10:07 -0500
Message-ID: <a5it8t$5et$1@quimby2.netfonds.no>
In-reply-to: Your message of "Tue, 26 Feb 2002 21:26:26 EST."
             <000001c1bf36$280ec3c0$ac1f830a@ico>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://www.geocrawler.com/redir-sf.php3?list=alsa-devel>
To: Ivica Bukvic <ico@fuse.net>
Cc: 'Dan Hollis' <goemon@anime.net>, alsa-devel@alsa-project.org, alsa-user@alsa-project.org
List-Id: alsa-devel@alsa-project.org

>I do not mean to be hammering this issue into the ground, but Linux OS
>as an audio workstation solution has been around for 3 years now, yet
>the only soundcard I am aware of that is capable of doing hardware
>mixing is SBLive!, and even that one is due to fact that Creative had
>their hands in the driver devel.

The trident cards can also do this. I believe that all cards that are
actually capable of doing this and for which the docs have been
provided have ALSA drivers that support it.

However, I agree that the issue of simultaneous access to audio
resources is a critical one. But lets look at how its been dealt with
on other operating systems:

   Windows (pre-WDM): a kernel-side mixer that creates horrible,
                      un-work-aroundable latency and puts a bunch
		      of code that Linus would never accept into
		      the kernel.

   Windows (WDM):     i don't know.

   ASIO:              no device sharing, AFAIK.

   MacOS (without ASIO): like windows pre-WDM, AFAIK.

   Mac OS X:          CoreAudio. Much like JACK, it requires a complete
		      rewrite of all code that interacts with audio
		      hardware. thats why there are very few OS X
		      native audio apps at this time. Unlike Apple,
		      we can't force people to use a particular
		      sound server :(

>I am sure there are more. Yet, no viable solution has been provided
>despite the fact that even Beos had this solved, needless to mention Mac
>and Win os's which do this flawlessly.

They don't do it flawlessly. It works for many simple cases. ASIO,
which until WDM showed up was by far the preferred driver API for
audio, doesn't allow device sharing at all AFAIK. 

Nevertheless, the point remains that under Windows and MacOS, multiple
apps can access audio h/w resources simultaneously regardless of the
hardware involved, certainly if they are not "professional" audio apps.

So what do we have?

>*There is esd, which is outdated and simply crappy.
>*There is artsd, which is better, but not good enough, and again, the
>app must be made to be aware of it in order to utilize it.
>*There is JACK project which has a huge potential but none of its
>effects are again universal, nor backwards-compatible with already
>released software.
>*There is Gstreamer, but I do not honestly know enough about it.

You missed perhaps the most important ones:

* KDE's audio API
* GNOME's audio API
* ALSA "share" devices

KDE and GNOME are both (regrettably) wrapping artsd in their own APIs
that allow device sharing. You could choose to use either of these
systems. They are no good for low latency and/or pro audio, and
probably never can be if they continue to use a server with artsd's
design. 

ALSA "share" devices are, at this time, largely untested by the ALSA
user community. I don't know how well they are working (I don't even
know how to set one up), but if they work as intended, they will
entirely solve this issue in the correct way: apps use the same API as
they would to access a regular PCM device, and the magic just happens.
If you're not willing to sign on to a synchronous execution model like
JACK, then I think you should probably focus on ALSA "share" devices.

The fundamental problem is that the original audio API (OSS) didn't
provide any interposition between the application and the kernel side
driver. That means that mixing either has to be in the kernel, which
nobody will approve of let alone allow, or we have to use a clever but
ugly hack like LD_PRELOAD to create a point at which the data from
these legacy apps can be routed to a better system that can do
mixing. libaoss does this, but it relies on the "share" PCM devices in
order to accomplish what you want. 

>Now that Alsa has become "default" kernel driver, we should definitely
>try to use the opportunity to finally provide this rudimentary, yet
>extremely important aspect of audio system.

don't consider it so rudimentary. you think of it as basic because
Windows and MacOS did it, but they did it at the expense of
low latency use. When Apple finally fixed this (with CoreAudio), they
have forced not only a completely new API but for many people
(non-ASIO developers), a whole new design on their developer community.

>I overheard that the new 2.5.x kernels have multiplexing feature (which
>I am guessing enables sharing of the dev resources -- please correct me
>if I am wrong), if so, will this solve this issue?

has nothing to do with the issue. 

--p

_______________________________________________
Alsa-devel mailing list
Alsa-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/alsa-devel
