From: "Ivica Bukvic" <ico@fuse.net>
Subject: RE: What is the current status of the alsa sound server (signal polling)?
Date: Fri, 19 Apr 2002 18:14:30 -0400
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <000001c1e7ef$94026730$ac1f830a@ico>
References: <20020419165659.NXSI388.mta01.fuse.net@newmx1.fast.net>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from mta03.fuse.net (mx3.fuse.net [216.68.1.123])
	by alsa.alsa-project.org (8.9.3/8.9.3/SuSE Linux 8.9.3-0.1) with ESMTP id AAA13303
	for <alsa-devel@alsa-project.org>; Sat, 20 Apr 2002 00:07:42 +0200
In-Reply-To: <20020419165659.NXSI388.mta01.fuse.net@newmx1.fast.net>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://www.geocrawler.com/redir-sf.php3?list=alsa-devel>
To: 'Paul Davis' <pbd@op.net>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

I might have used the wrong term then. I was referring to a bit of both,
I guess. Although I am not sure what is the official meaning of these
terms, from my user-end standpoint my guess is that it is rather subtle:

Polling in my mind means that there is a software (daemon-like) entity
that allows any app to access audio resource by sharing audio inputs
and/or polling all audio output into one down-mixed stream that is being
fed to the soundcard (which is not capable of being multi-open).

Multi-open is done in hardware so that every call to /dev/dsp resource
is simply allowed by the driver.

This is probably a rather lax and non-technical description, but since
this is something I am still looking to resolve for my own music-making
purposes (due to fact I want to run concurrently several different
sound-making apps for my real-time performances) I am just wondering if
someone has found a viable solution.

So far, I figured out that using

artsdsp <appname> <flags> <soundfile>

can provide me with such feature (with obvious latency issues, but even
that is better than no ability whatsoever to have two apps output sound
at the same time). Esdplay is IMHO rather awful, so I don't want to even
mention that one. But even with the artsdsp, I am unable to share the
audio input (i.e. mic) since such attempt results in a complete audio
corruption. So, what is there else to use with the current apps (both
OSS and ALSA) in order to have the ability to share audio-in and
audio-out between different apps that I can use now (I know that jack
will eventually become that, but it is not there as of yet)?

A while ago you've replied to my post saying that there is a way of
establishing "share" pcm device in asoundrc and that it should be able
to provide audio sharing, so I was wondering if anyone was lucky enough
to get it to work and if not, whether I misunderstood your original
post...

Thanks for your help!

Ico




> -----Original Message-----
> From: Paul Davis [mailto:pbd@op.net]
> Sent: Friday, April 19, 2002 12:59 PM
> To: Ivica Bukvic
> Cc: joy ping; alsa-devel@alsa-project.org
> Subject: Re: [Alsa-devel] What is the current status of the alsa sound
> server (signal polling)?
> 
> >you (or anyone else regarding asoundrc file), as well as additional
info
> >regrading polling abilities with the soundcards that have lousy
drivers
> >due to lack of documentation and/or questionable hardware and are
> >therefore unable to provide me with the hardware mixing.
> 
> the term "polling" in not very useful here. all ALSA supported
> hardware can be "polled" in the sense that a program can stop and wait
> for it to be ready to read or write from. no hardware support over and
> above the minimum necessary for basic audio i/o is necessary for this.
> 
> i think you're describing something that is generally known as
> "multi-open", in which the hardware supports multiple independent (but
> generally synchronous) streams of audio data to be possible, and each
> process that opens the device gets a new stream. the streams are mixed
> in hardware before being delivered to the physical outputs.
> 
> i am not sure how "polling" (of any kind) relates to this. care to
> explain?
> 
> --p
