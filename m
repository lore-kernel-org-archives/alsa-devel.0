From: Zwane Mwaikambo <zwane@holomorphy.com>
Subject: Re: Oops when removing snd-timer
Date: Mon, 18 Nov 2002 04:07:17 -0500 (EST)
Sender: linux-kernel-owner@vger.kernel.org
Message-ID: <Pine.LNX.4.44.0211180347320.1538-100000@montezuma.mastecende.com>
References: <20021118080208.GA4945@hatchling.taral.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-kernel-owner+linux-kernel=40quimby.gnus.org@vger.kernel.org>
In-Reply-To: <20021118080208.GA4945@hatchling.taral.net>
To: Taral <taral@taral.net>
Cc: alsa-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

On Mon, 18 Nov 2002, Taral wrote:

> I was unloading ALSA (modular) when I got this lovely oops:
> (linux-2.5.47)

Looks like you loaded ens137x.c and then that driver got unloaded leaving 
the callback still valid, then the core timer code decided to walk off a 
cliff using that pointer.

0xc0365322 is in snd_timer_free (sound/core/timer.c:676).
671     static int snd_timer_free(snd_timer_t *timer)
672     {
673             snd_assert(timer != NULL, return -ENXIO);
674             if (timer->private_free)
675                     timer->private_free(timer);
676             snd_magic_kfree(timer);
677             return 0;
678     }

The problem seems to be a sort of chicken/egg case? We can't rely on 
modules being around even with this inter dependency case.

	Zwane
-- 
function.linuxpower.ca
