From: Chris Wilson <chris@chris-wilson.co.uk>
Subject: Re: [PATCH 3/3] snd/hda: Protect concurrent
	display_power_status with a mutex
Date: Mon, 14 Jan 2019 20:57:15 +0000
Message-ID: <154749943039.28151.14781193854334417809@skylake-alporthouse-com>
References: <20190114173753.472-1-chris@chris-wilson.co.uk>
 <20190114173753.472-3-chris@chris-wilson.co.uk>
 <s5hd0ozi12m.wl-tiwai@suse.de>
 <154748829141.28151.408499449340104231@skylake-alporthouse-com>
 <s5ha7k3i0gt.wl-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from fireflyinternet.com (mail.fireflyinternet.com [109.228.58.192])
 by alsa0.perex.cz (Postfix) with ESMTP id 6A02D2670CD
 for <alsa-devel@alsa-project.org>; Mon, 14 Jan 2019 21:57:23 +0100 (CET)
In-Reply-To: <s5ha7k3i0gt.wl-tiwai@suse.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Takashi Iwai <tiwai@suse.de>
Cc: Jani Nikula <jani.nikula@intel.com>, intel-gfx@lists.freedesktop.org, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Quoting Takashi Iwai (2019-01-14 18:00:02)
> On Mon, 14 Jan 2019 18:51:31 +0100,
> Chris Wilson wrote:
> > 
> > Quoting Takashi Iwai (2019-01-14 17:46:57)
> > > On Mon, 14 Jan 2019 18:37:53 +0100,
> > > Chris Wilson wrote:
> > > > 
> > > > Just in case the audio linkage is swapped between components during the
> > > > runtime pm sequence, we need to protect the rpm tracking with a mutex.
> > > 
> > > It's not clear to me how does this happens.
> > > Could you elaborate a bit more the scenario?
> > 
> > The code is written such that multiple bits within display_power_status
> > can be set and cleared simultaneously. There was no serialisation
> > mentioned in the routine, so I was fearful that the display_power_active
> > here was being accessed concurrently -- and if that was explaining why
> > snd/hda appears to be leaking the runtime pm (or at least is holding on
> > to the wakeref longer than igt expects, > 10s).
> 
> Aha, and does patch actually "fix" the issue...?

Not sure yet; it's a temperamental issue in CI and my chief suspect is that
it's just a misconfiguration of the rpm autosuspend. What may point
towards the scenario above is if i915.ko module unloading has any impact
on it.
 
> It's a simple mutex addition, so no big show, and I'm fine with it,
> but just wonder whether it really helped.

Yeah, it just looked suspicious when reviewing the code, will throw it
at CI a few times to see if it sticks.
-Chris
