From: Zwane Mwaikambo <zwane@holomorphy.com>
Subject: Re: Oops when removing snd-timer
Date: Mon, 18 Nov 2002 04:53:36 -0500 (EST)
Sender: linux-kernel-owner@vger.kernel.org
Message-ID: <Pine.LNX.4.44.0211180450230.1538-100000@montezuma.mastecende.com>
References: <Pine.LNX.4.44.0211180347320.1538-100000@montezuma.mastecende.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-kernel-owner+linux-kernel=40quimby.gnus.org@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.44.0211180347320.1538-100000@montezuma.mastecende.com>
To: Taral <taral@taral.net>
Cc: alsa-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

On Mon, 18 Nov 2002, Zwane Mwaikambo wrote:

> Looks like you loaded ens137x.c and then that driver got unloaded leaving 
> the callback still valid, then the core timer code decided to walk off a 
> cliff using that pointer.

Not really the case, probably from pcm code.

> 0xc0365322 is in snd_timer_free (sound/core/timer.c:676).
> 671     static int snd_timer_free(snd_timer_t *timer)
> 672     {
> 673             snd_assert(timer != NULL, return -ENXIO);
> 674             if (timer->private_free)
> 675                     timer->private_free(timer);
> 676             snd_magic_kfree(timer);
> 677             return 0;
> 678     }
> 
> The problem seems to be a sort of chicken/egg case? We can't rely on 
> modules being around even with this inter dependency case.

Perhaps driver specific code should be doing as much of their own cleanup 
as possible. I'm still wondering how this managed to unload without that 
getting run, unless its a simple case of forgetting a failure path.

	Zwane
-- 
function.linuxpower.ca
