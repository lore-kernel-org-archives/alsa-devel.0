From: <ico-rDkNP/OoUoU@public.gmane.org>
Subject: Re: Re: [Alsa-devel] Re: snd-hdsp oddities
Date: Fri, 2 Jul 2004 14:27:37 +0000
Sender: linux-audio-dev-bounces-oG0YroN0ZiqENrSoib9kfje48wsgrGvP@public.gmane.org
Message-ID: <20040702142738.OBAU17933.smtp2.fuse.net@smtp.fuse.net>
Reply-To: "The Linux Audio Developers' Mailing List"
	<linux-audio-dev-oG0YroN0ZiqENrSoib9kfje48wsgrGvP@public.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-audio-dev-bounces-oG0YroN0ZiqENrSoib9kfje48wsgrGvP@public.gmane.org>
List-Unsubscribe: <http://music.columbia.edu/mailman/listinfo/linux-audio-dev>,
	<mailto:linux-audio-dev-request-oG0YroN0ZiqENrSoib9kfocZ5a6xMsm1v5P9MsFVvkkBB/WhxxnpHQ@public.gmane.org>
List-Archive: <http://music.columbia.edu/pipermail/linux-audio-dev>
List-Post: <mailto:linux-audio-dev-oG0YroN0ZiqENrSoib9kfje48wsgrGvP@public.gmane.org>
List-Help: <mailto:linux-audio-dev-request-oG0YroN0ZiqENrSoib9kfocZ5a6xMsm1aFUAG64dwko@public.gmane.org>
List-Subscribe: <http://music.columbia.edu/mailman/listinfo/linux-audio-dev>,
	<mailto:linux-audio-dev-request-oG0YroN0ZiqENrSoib9kfocZ5a6xMsm1+iqrErVy8Mf2+df2TVCvIA@public.gmane.org>
Errors-To: linux-audio-dev-bounces-oG0YroN0ZiqENrSoib9kfje48wsgrGvP@public.gmane.org
To: Takashi Iwai <tiwai-l3A5Bk7waGM@public.gmane.org>
Cc: alsa-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org, linux-audio-dev-oG0YroN0ZiqENrSoib9kfje48wsgrGvP@public.gmane.org
List-Id: alsa-devel@alsa-project.org


> 
> From: Takashi Iwai <tiwai-l3A5Bk7waGM@public.gmane.org>
> Date: 2004/07/02 Fri PM 01:15:46 GMT
> To: <ico-rDkNP/OoUoU@public.gmane.org>
> CC: <alsa-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>, 
> 	<linux-audio-dev-oG0YroN0ZiqENrSoib9kfje48wsgrGvP@public.gmane.org>
> Subject: Re: [Alsa-devel] Re: [linux-audio-dev] snd-hdsp oddities
> 
> At Fri, 2 Jul 2004 12:56:06 +0000,
> <ico-rDkNP/OoUoU@public.gmane.org> wrote:
> > 
> > > Shouting "DON'T USE 2.6" isn't a good solution.  Though, we need to
> > > inform to "set LD_ASSUME_KERNEL as a workaround"...
> > 
> > Pardon my ignorance but how does one do this? As a part of the
> > config before compiling kernel or? 
> 
> No, just set the environment variable like
> 	export LD_ASSUME_KERNEL=2.4.19
> (better globally) and start jack.  That's all.
> 
> In this way, glibc chooses LinuxThreads instead of NPTL.
> 
> > Also, any ideas on the odd behavior of the hdspmixer? (see my other post)
> 
> Not checked yet...  Did hdspmixer work on any versions correctly on
> your system?
> 

Well not really since this notebook is only a couple months old so I never had the chance to test anything pre 1.0.2. But anything 1.0.2 and greater behaves the same.

Ico
