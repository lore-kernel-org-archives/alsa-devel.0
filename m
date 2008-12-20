From: "Sean McNamara" <smcnam@gmail.com>
Subject: Re: somebody ever see ALSA applied in robotics ?
Date: Sat, 20 Dec 2008 14:44:31 -0500
Message-ID: <74eb1fe20812201144h648b45f7v5c9ab148827df180@mail.gmail.com>
References: <494C091F.1070405@gmail.com>
	<53baa24a0812191323u57af2b81k9c22ea355cc75a4d@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from wa-out-1112.google.com (wa-out-1112.google.com [209.85.146.181])
	by alsa0.perex.cz (Postfix) with ESMTP id 625A71037EC
	for <alsa-devel@alsa-project.org>; Sat, 20 Dec 2008 20:44:33 +0100 (CET)
Received: by wa-out-1112.google.com with SMTP id l35so773921waf.16
	for <alsa-devel@alsa-project.org>; Sat, 20 Dec 2008 11:44:32 -0800 (PST)
In-Reply-To: <53baa24a0812191323u57af2b81k9c22ea355cc75a4d@mail.gmail.com>
Content-Disposition: inline
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org, raalst@gmail.com
List-Id: alsa-devel@alsa-project.org

On Fri, Dec 19, 2008 at 4:23 PM, Alex Austin <circuitsoft.alex@gmail.com> wrote:
> You may be better off working with JACKd than straight-up ALSA.
> Also, you may want to look into PureData for your app. I've never used it
> though. Can anyone else chime in on this?

PureData might be a useful data analysis programming language for the
task, sure. One of its backends is ALSA. Last I heard, PureData uses
unsafe parts of the ALSA API, which means that it's incompatible with
things like the ALSA<->Pulse plugin, or dmix -- you'd have to use hw
or plughw. But from the sounds of it, this project may not need any
sort of desktop audio solution on top of ALSA ;)

>
> - Alex Austin
> (651) 238-9273
>
> "...and then I visited Wikipedia ...and the next 8 hours are a blur."
>
>
> On Fri, Dec 19, 2008 at 3:50 PM, Ronald <raalst@gmail.com> wrote:
>
>> Hi, all,
>>
>> I'm trying to develop a system which can determine the direction(s)
>> sound comes from.
>> In the end, it will be put in an R/c submarine, on a gumstix linux board
>> (see  http://www.subcommittee.com for my hobby)
>>
>> But for now, I develop in air, with ubuntu.
>> all I want is to record using both the mic channel and the  line in
>> (where another 2 mics are attached with a small preamp),
>> and I want to record while emitting a chirp, analyzing echo's.
>> the concept has been shown to work. see for instance
>> http://eddiem.com/projects/chirp/chirp.htm
>>
>> I am assuming that since all this goes via the same sound card, the same
>> crystal is used, and samples from mic and line in are
>> essentially synchronized (I only need it to be sync-ish for < 0,1 sec..)

Yeah, it should definitely be within 0.1 sec synchronization, at least
at first. But I can also imagine a sound card that has a different
timing source for each of its input lines because they are different
ADCs; in that case, you may notice synchronization drift. To be safe,
do some empirical tests on your reference hardware before you assume
that things are synchronized.

If you code directly to ALSA-lib, you can develop your own time
scheduling checks (such as hrtimers) to make sure you're getting
samples when you expect them... some of the concepts of PulseAudio's
design may help you ensure precision if you are using a non-realtime
system. At the very least, it would be nice to know that if you
expected an interrupt 0.15 seconds ago and it hasn't arrived, probably
the kernel is doing something busy and you'll have to compensate for
the lag.

In lieu of realtime, you can reduce the chance of kernel subsystems
blocking ALSA for too long by building a fully preemptible kernel.
Slow syscalls like readdir(), system() and fork() will hopefully get
kicked out for high-priority events like interrupts from the sound
card.

>>
>> Now I have read a lot of ALSA tutorials and such like, but I'm lost.
>> a lot is about humans consuming nice harmonics, sharing and mixing,
>> which is not applicable to my case.
>> I have the nagging feeling OSS is a better fit for my case, but OSS is
>> apparently on a 60 day licence now.

ALSA has many different applications; you seem to be reading wiki
stuff for end users trying to get software mixing to work :) That
doesn't mean OSS is suited for you at all, though. Last I checked,
OSS4 kernel panics when loading the hardware-specific module for my
Intel HDA codec. You should use ALSA because it has the best chance of
supporting the hardware on your little deployment board (Gumstix) -- I
can't speak to OSS's hardware support on a Gumstix.

Oh, and OSS4 is GPL'ed. The license is only for the commercial
version, whatever benefits that may buy you. And of course OSS/Free in
the Linux kernel is very obsolete; don't use it.

>>
>> And, I am a newbie coder. no surprise there ;-)
>>
>> So, these are my questions :
>>
>> - Do I need to combine mic and line-in into one device using the
>> config file ? do I get a 3 channel device then ? does a plug-in add
>> latency ?

Combining them at the subdevice level may make things simpler. Many
simple ALSA apps assume that you want to capture only from the first
subdevice of the first device, which isn't always what you want. You
don't *need* to combine them at the plug layer, but you certainly can.
You would get a "soft" driver in the plug layer with the sum of the
number of channels of each constituent device, and that soft device
would only have one subdevice with all those channels exposed. If you
combine them using the "multi" plugin (documented here
http://www.alsa-project.org/alsa-doc/alsa-lib/pcm_plugins.html ) then
you need to pick a "master slave" -- whatever timing source is
connected to that slave will be used to synchronize all of the slaves
together. Another consequence is that starting to capture from a multi
device will block until all of the subdevices are ready.

BTW, terminology for your sanity. When I refer to the ALSA device
string "hw:0,1,2", we have four components here:

Driver (or module, or PCM): hw
Card: 0
Device: 1
Subdevice: 2

You can open as many subdevices as you like, simultaneously, for
capture. So if you're coding up your own ALSA stuff, you can just call
snd_pcm_open on each available subdevice, after you determine which
ones are available.

The "hw" driver is the most direct access to the hardware -- it
doesn't go through the plug layer for resampling or sample rate
conversion. This is good if you want to minimize latency; usually any
layers on top of hw like to add buffering to compensate for the fact
that, not surprisingly, sample rate conversion and resampling takes
clock cycles, and a clock cycle takes time. And I believe that answers
your remaining questions.

>>
>> - can I sync the transmission of a short chirp with the start of the
>> recording on these 3 channels ? is starting them close after each other
>> in the program OK, or is there possibly large latency caused *after* I
>> call the API ? the "real" sync'ing will be the (first) recording of the
>> chirp once it leaves the speaker, so it isn't critical, but I would like
>> to know because it might save a few bytes useless samples.

If the three channels are using the same clock source, then every
sample coming in will be uniformly from the same time slice across all
the channels. If you start one and your process gets scheduled out for
a bit, it's possible that the first subdevice to be started will have
more audio data to deliver than the rest of them. But since they're
all capturing data according to the same clock source, they will
remain in sync -- you'll just have one or more samples at the
beginning of your stream which contain data from some of the channels,
but not all of them. I am not sure if using the plug layer to combine
multiple subdevices will cause these useless samples to be
automatically discarded...

The question here is what do you consider "OK". If the possibility of
any dropouts needs to be eliminated, you need a realtime system. If
you are only interested in capturing samples when all of the
subdevices are actively capturing, you should call snd_pcm_wait on all
of the subdevices, and only proceed after that -- the chances of
significant delay after that are minimal.

Now on to some latency minimization tips:

There are various patches floating around out there which enable
different degrees of realtime-ness on Linux. Unless you use a tightly
controlled realtime system, there is no theoretical upper bound on the
amount of latency that can be experienced as a result of any
operation. ALSA normally doesn't have such latency internal to the
API, but system load can make any given API take considerable time
because the process might get scheduled out. Here is a dated article
that contains some great information, regardless of its age...
http://www.alsa-project.org/main/index.php/Low_latency_howto

If you really, really dislike dropouts for your purposes, i.e.
software or robotic hardware will fail if you get a dropout, then your
ideal situation is this:

1. You have a realtime system.
2. You empirically figure out the minimum buffer size possible by
loading up your entire software stack and doing torture tests with
everything doing as much work as it can at the same time. If you don't
get a dropout and your software is in a "worst case" scenario, your
buffer is either too big or just right. Reduce the buffer size little
by little until you hit the perfect buffer size.

With the perfect buffer size, you have as little latency as possible,
with a buffer that's only a hair (for good measure ;)) larger than it
must be for the worst case.

>>
>> - Does anybody out there have any links, code snippets or general
>> published info on how to apply ALSA to the robotics field ?
>>
>> Ps I have read the el-cheapo hack with multiple soundcards, and while a
>> very good idea, I cannot use it in the boat later on..
>>
>> thanks for any input you might have.
>>
>> Regards,
>> Ronald van Aalst

Any inaccuracies in the claims I've made here are just my lack of
understanding of ALSA. I'm not extremely experienced with it myself,
but I've spent some time figuring out its internal workings to some
extent. If you want the real answer, you should probably try and flag
down one of the major contributors.

HTH,

Sean


>>
>>
>> _______________________________________________
>> Alsa-devel mailing list
>> Alsa-devel@alsa-project.org
>> http://mailman.alsa-project.org/mailman/listinfo/alsa-devel
>>
> _______________________________________________
> Alsa-devel mailing list
> Alsa-devel@alsa-project.org
> http://mailman.alsa-project.org/mailman/listinfo/alsa-devel
>
