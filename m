From: Florian Schmidt <mista.tapas-hi6Y0CQ0nG0@public.gmane.org>
Subject: Re: [Alsa-devel] Re: snd-hdsp oddities
Date: Fri, 2 Jul 2004 15:55:20 +0200
Sender: linux-audio-dev-bounces-oG0YroN0ZiqENrSoib9kfje48wsgrGvP@public.gmane.org
Message-ID: <20040702155520.3dfef92f@mango.fruits.de>
References: <20040702125607.KKVA3746.smtp1.fuse.net@smtp.fuse.net>
	<s5hwu1m8s8t.wl@alsa2.suse.de>
Reply-To: "The Linux Audio Developers' Mailing List"
	<linux-audio-dev-oG0YroN0ZiqENrSoib9kfje48wsgrGvP@public.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-audio-dev-bounces-oG0YroN0ZiqENrSoib9kfje48wsgrGvP@public.gmane.org>
In-Reply-To: <s5hwu1m8s8t.wl-UC7Roit8zEholqkO4TVVkw@public.gmane.org>
List-Unsubscribe: <http://music.columbia.edu/mailman/listinfo/linux-audio-dev>,
	<mailto:linux-audio-dev-request-oG0YroN0ZiqENrSoib9kfocZ5a6xMsm1v5P9MsFVvkkBB/WhxxnpHQ@public.gmane.org>
List-Archive: <http://music.columbia.edu/pipermail/linux-audio-dev>
List-Post: <mailto:linux-audio-dev-oG0YroN0ZiqENrSoib9kfje48wsgrGvP@public.gmane.org>
List-Help: <mailto:linux-audio-dev-request-oG0YroN0ZiqENrSoib9kfocZ5a6xMsm1aFUAG64dwko@public.gmane.org>
List-Subscribe: <http://music.columbia.edu/mailman/listinfo/linux-audio-dev>,
	<mailto:linux-audio-dev-request-oG0YroN0ZiqENrSoib9kfocZ5a6xMsm1+iqrErVy8Mf2+df2TVCvIA@public.gmane.org>
Errors-To: linux-audio-dev-bounces-oG0YroN0ZiqENrSoib9kfje48wsgrGvP@public.gmane.org
To: The Linux Audio Developers' Mailing List <linux-audio-dev-oG0YroN0ZiqENrSoib9kfje48wsgrGvP@public.gmane.org>
Cc: tiwai-l3A5Bk7waGM@public.gmane.org, ico-rDkNP/OoUoU@public.gmane.org, alsa-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: alsa-devel@alsa-project.org

On Fri, 02 Jul 2004 15:15:46 +0200
Takashi Iwai <tiwai-l3A5Bk7waGM@public.gmane.org> wrote:

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

yes, every jack client needs to be started with this env var set [additionally to the jack server], too.. otherwise it's not sufficient..

flo

P.S.: so add

export LD_ASSUME_KERNEL=2.4.19

to your ~/.bashrc

or even to your ~/.profile


-- 
Palimm Palimm!
http://affenbande.org/~tapas/wiki
