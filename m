From: "Peter Dolding" <oiaohm@gmail.com>
Subject: Re: alsa-lib has anyone ever looked at taking it cross
	platform?
Date: Fri, 25 Jul 2008 20:51:13 +1000
Message-ID: <e7d8f83e0807250351j42894f2dm7f19483f8d66afaa@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from rv-out-0708.google.com (rv-out-0708.google.com [209.85.198.246])
	by alsa0.perex.cz (Postfix) with ESMTP id D6CF624559
	for <alsa-devel@alsa-project.org>;
	Fri, 25 Jul 2008 12:51:14 +0200 (CEST)
Received: by rv-out-0708.google.com with SMTP id f25so2447823rvb.32
	for <alsa-devel@alsa-project.org>; Fri, 25 Jul 2008 03:51:13 -0700 (PDT)
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
To: gmane@colin.guthr.ie
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

> Peter Dolding wrote:
>> This would kinda make logical sence.
>>
>> Alsa-lib plugin system in theory should be able to take any kind sound
>> output under it.   Simplify development of all applications on top of
>> it.  If alsa was cross platform why would you use something else as a
>> middle body wrapper when you port.
>>
>> Windows and Mac support could be done as plugins.
>>
>> Or is there something that is in the alsa-lib that is a problem?
>>
>> Its all about reducing distance between application and hardware and
>> reduce amount of coding.
>
> I'd rather see pulseaudio go fully cross platform. It's got some older
> windows ports but if pulse were to get a push in the right direction for
> windows and OSX then this lets alsa get on with the job of interfacing
> with the audio on linux (that's what the L stands for after all), and
> let higher level applications work with a more appropriate system with
> more appropriate interfaces for practical use.

Ok sorry to say the idea of let sound server do it is the same as
saying we will put up for every with xlib being single threaded and
have the toolkits above it deal with it.  Instead of taking on the
problem. xcb is taking on the problem in the X11 stack of libs.
Except its many times worse.

Pulseaudio and all other Sound Servers since its a extra service adds
a extra point of complete sound failure to the Linux sound stack or
what ever stack they happen to be operating on top of.   It more of a
hack around the limitations of the alsa framework.  ALSA was really
designed to avoid the need of such extras.  The existence of
Pulseaudio is really sign of failure.  Reason Sound Servers existed at
first due to the failures of OSS to provide a multi application sound
support.  ALSA was really designed to do away for the need of sound
servers completely.  Now alsa is failing to provide per application
sound control and a sound server is back for another pass.

Now why are not alsa interfaces practical to use.   It is ment to be
"Advanced Linux Sound Architecture"  The complete Architecture.   Not
something you have to tack bits onto because its not functional or
hard to use.  Have we got to the point like xlib where the complete
alsa-lib has to be reworked for usability.

Now if you want to keep on thinking along that line has ALSA got to
the point it should be dumped like OSS has been dumped because of its
limitations?

alsa-lib to freebsd or somewhere with oss most likely could be done
really quickly since we already have a oss output option.

Its also like saying the Linux Standard Base is only used by Linux.
Its not its also used by a few non Linux's.   Driver section of ALSA
most likely will always be Linux only.   But the wrapper layer that
hides the hardware from the software really does not have to stay
Linux only.  Alsa is going up to be part of the Linux Standard Base
its about time we all start looking at how it can be made most useful.
 Provide all the features it should and work for stability.

Has anyone one attempted it or not.  I guess not.

Peter Dolding
