From: Tim Blechmann <TimBlechmann-hi6Y0CQ0nG0@public.gmane.org>
Subject: Re: Stuttering via HDSP, Cardbus, Multiface?
Date: Fri, 26 Mar 2004 12:59:28 +0100
Sender: linux-audio-user-bounces-oG0YroN0ZiqENrSoib9kfje48wsgrGvP@public.gmane.org
Message-ID: <20040326125928.0264ae92@laptop>
References: <40635773.2050805@tdpmusic.com>
Reply-To: A list for linux audio users <linux-audio-user-oG0YroN0ZiqENrSoib9kfje48wsgrGvP@public.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-audio-user-bounces-oG0YroN0ZiqENrSoib9kfje48wsgrGvP@public.gmane.org>
In-Reply-To: <40635773.2050805-w4Hjm/x1s2xWk0Htik3J/w@public.gmane.org>
List-Unsubscribe: <http://music.columbia.edu/mailman/listinfo/linux-audio-user>,
	<mailto:linux-audio-user-request-oG0YroN0ZiqENrSoib9kfocZ5a6xMsm1v5P9MsFVvkkBB/WhxxnpHQ@public.gmane.org>
List-Archive: <http://music.columbia.edu/pipermail/linux-audio-user>
List-Post: <mailto:linux-audio-user-oG0YroN0ZiqENrSoib9kfje48wsgrGvP@public.gmane.org>
List-Help: <mailto:linux-audio-user-request-oG0YroN0ZiqENrSoib9kfocZ5a6xMsm1aFUAG64dwko@public.gmane.org>
List-Subscribe: <http://music.columbia.edu/mailman/listinfo/linux-audio-user>,
	<mailto:linux-audio-user-request-oG0YroN0ZiqENrSoib9kfocZ5a6xMsm1+iqrErVy8Mf2+df2TVCvIA@public.gmane.org>
Errors-To: linux-audio-user-bounces-oG0YroN0ZiqENrSoib9kfje48wsgrGvP@public.gmane.org
To: A list for linux audio users <linux-audio-user-oG0YroN0ZiqENrSoib9kfje48wsgrGvP@public.gmane.org>, alsa-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: alsa-devel@alsa-project.org

> My guess is that the problem is the pcmcia bus is somehow 2000 times 
> slower than it should be..  csound seems to confirm this hypothesis
> from the command line when attempting realtime synthesis:
i seem to know this problem ...

first of all, which cardbus bridge do you have? (lspci -v)

here are some questions:
-what's jack's output, if you run it as su with the realtime flag? 

-if you use an input signal and any program, that accesses the sound
 device, can you try to check some hdspmixer settings? on my system a
 part of the audio data that's send to the computer is sent to the
 corresponding output instead...

> However, once I switch over to the hdsp in the modules.conf file, 
> everything runs but extremely slow...  Audacity will take a minute to 
> launch and then will play back a 2 minute file over 5 minutes, the
> sound out of the multiface is stuttering and distorted.  (Very
> beautiful in a twisted sort of way!)
i experienced this with aplay ... i recorded it with another computer
and it seems that 32 samples of the soundfile are followed by 32 samples
of silence ... does the _pitch_ of the distortion change, if you change
the samplerate with hdspconf?

> My machine has is 2.8 Pentium 4, plenty of horsepower, and two pcmcia 
> slots (only one works with hdsploader for some reason).
wait ... i can only use one cardbus slot, too ... can you check the
irqs of your slots? (mine are 5 and 11)


we still don't know exactly, where this problem comes from ... thomas
charbonnel (maintainer of the alsa driver) suggested that it's probably
a cardbus driver problem (is it working with windows on your machine?)
...

iirc you are the third person, having these kinds of problems: 
my laptop is a p4 2.5, with an o2micro 6933 cardbus bridge
ico's laptop uses an amd64 and an ENE cardbus bridge
... both are chipsets that might cause problems with the hdsp, but on
both ico's and my machine, the hdsp works fine with windows xp...

i hope we will be able to solve this problem, soon, i'd suggest to move
this discussion to the alsa devel list, since it's probably not a
problem of the configuration, but of the hardware...

btw, is it possible for you to come to the lad conference in karlsruhe,
next month? since ico, me and probably thomas will meet there, and
hopefully can track down the problem, it would be easier, to have 3
machines with this problems there than only two...

cheers ... and i hope you have more luck than i had...

 Tim                          mailto:TimBlechmann-Mmb7MZpHnFY@public.gmane.org
                              ICQ: 96771783
--
The only people for me are the mad ones, the ones who are mad to live,
mad to talk, mad to be saved, desirous of everything at the same time,
the ones who never yawn or say a commonplace thing, but burn, burn,
burn, like fabulous yellow roman candles exploding like spiders across
the stars and in the middle you see the blue centerlight pop and
everybody goes "Awww!"
                                                          Jack Kerouac
