From: Andrew Burgess <aab-UIo0uGTcgxdBDgjK7y7TUQ@public.gmane.org>
Subject: Re: Which API to use for simple clients?
Date: Mon, 6 Sep 2004 12:28:14 -0700
Sender: linux-audio-dev-bounces-oG0YroN0ZiqENrSoib9kfje48wsgrGvP@public.gmane.org
Message-ID: <200409061928.i86JSE4m027169@cichlid.com>
Reply-To: "The Linux Audio Developers' Mailing List"
	<linux-audio-dev-oG0YroN0ZiqENrSoib9kfje48wsgrGvP@public.gmane.org>
Return-path: <linux-audio-dev-bounces-oG0YroN0ZiqENrSoib9kfje48wsgrGvP@public.gmane.org>
List-Unsubscribe: <http://music.columbia.edu/mailman/listinfo/linux-audio-dev>,
	<mailto:linux-audio-dev-request-oG0YroN0ZiqENrSoib9kfje48wsgrGvP@public.gmane.org?subject=unsubscribe>
List-Archive: <http://music.columbia.edu/pipermail/linux-audio-dev>
List-Post: <mailto:linux-audio-dev-oG0YroN0ZiqENrSoib9kfje48wsgrGvP@public.gmane.org>
List-Help: <mailto:linux-audio-dev-request-oG0YroN0ZiqENrSoib9kfje48wsgrGvP@public.gmane.org?subject=help>
List-Subscribe: <http://music.columbia.edu/mailman/listinfo/linux-audio-dev>,
	<mailto:linux-audio-dev-request-oG0YroN0ZiqENrSoib9kfje48wsgrGvP@public.gmane.org?subject=subscribe>
Errors-To: linux-audio-dev-bounces-oG0YroN0ZiqENrSoib9kfje48wsgrGvP@public.gmane.org
To: linux-audio-dev-oG0YroN0ZiqENrSoib9kfje48wsgrGvP@public.gmane.org, alsa-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: alsa-devel@alsa-project.org

>I have two Audio related projects that need updating.

>Both have existing /dev/dsp style backends at present, which have been working
>fine. But recently (SuSE 9.0 install?) when run under ALSA emulation of 
>/dev/dsp they both started producing segfaults - "after program had exited",
>(neither valgrind nor gdb can give any info on the fault).

>So I decided it was time to do a native ALSA backend(s).
>I have rsynth backend working, and perl Audio:: one almost working.
>But before going forward I would like to solicit opinions on what 
>is the "right" API to use.

>(please tell me if I missed any):

Portaudio, which gives you macos and windows for free (but of course
you must also port the gui stuff...)

>2. ALSA
>3. JACK 

Do the callbacks once and it's trivial to port to all three of the above
in my experience.
