From: Paul Davis <paul-dDzkXPnfpdxaomM2pvQuqZqQE7yCjDx5@public.gmane.org>
Subject: Re: snd-hdsp oddities
Date: Thu, 01 Jul 2004 22:16:39 -0400
Sender: linux-audio-dev-bounces-oG0YroN0ZiqENrSoib9kfje48wsgrGvP@public.gmane.org
Message-ID: <200407020216.i622GdaC002355@localhost.localdomain>
References: <20040702002208.KXUI17933.smtp2.fuse.net@smtp.fuse.net>
Reply-To: "The Linux Audio Developers' Mailing List"
	<linux-audio-dev-oG0YroN0ZiqENrSoib9kfje48wsgrGvP@public.gmane.org>
Return-path: <linux-audio-dev-bounces-oG0YroN0ZiqENrSoib9kfje48wsgrGvP@public.gmane.org>
In-reply-to: Your message of "Fri, 02 Jul 2004 00:22:08 -0000."
	<20040702002208.KXUI17933.smtp2.fuse.net-TAIDijpykVYqcZcGjlUOXw@public.gmane.org>
List-Unsubscribe: <http://music.columbia.edu/mailman/listinfo/linux-audio-dev>,
	<mailto:linux-audio-dev-request-oG0YroN0ZiqENrSoib9kfocZ5a6xMsm1v5P9MsFVvkkBB/WhxxnpHQ@public.gmane.org>
List-Archive: <http://music.columbia.edu/pipermail/linux-audio-dev>
List-Post: <mailto:linux-audio-dev-oG0YroN0ZiqENrSoib9kfje48wsgrGvP@public.gmane.org>
List-Help: <mailto:linux-audio-dev-request-oG0YroN0ZiqENrSoib9kfocZ5a6xMsm1aFUAG64dwko@public.gmane.org>
List-Subscribe: <http://music.columbia.edu/mailman/listinfo/linux-audio-dev>,
	<mailto:linux-audio-dev-request-oG0YroN0ZiqENrSoib9kfocZ5a6xMsm1+iqrErVy8Mf2+df2TVCvIA@public.gmane.org>
Errors-To: linux-audio-dev-bounces-oG0YroN0ZiqENrSoib9kfje48wsgrGvP@public.gmane.org
To: The Linux Audio Developers' Mailing List <linux-audio-dev-oG0YroN0ZiqENrSoib9kfje48wsgrGvP@public.gmane.org>
Cc: ico-rDkNP/OoUoU@public.gmane.org, alsa-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: alsa-devel@alsa-project.org

>I am using the latest 2.6.7 kernel (tried also 2.6.5) but with hdsp I cannot s
>elect anything lower than 1024x2 buffer settings in jackd without having massi
>ve xruns.

Give up on 2.6 for now. If you can't give up on it, then at least run
all (audio) apps with the environment variable LD_ASSUME_KERNEL set to
2.4.19. 

When the dust settles from the kernel and NPTL, 2.6 will be more
viable. Right now, even though it works for some people, its not a
generally viable platform for realtime audio.

--p
