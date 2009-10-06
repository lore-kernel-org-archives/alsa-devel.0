From: Harald Welte <laforge@gnumonks.org>
Subject: Re: [PATCH 14/31] HDA patch_via.c: Add Jack detect
 feature for VT1708.
Date: Tue, 6 Oct 2009 14:17:40 +0200
Message-ID: <20091006121740.GI17195@prithivi.gnumonks.org>
References: <16685ee0910050727q4288fc76hdde23b431232d073@mail.gmail.com>
	<s5h7hv96fis.wl%tiwai@suse.de>
	<16685ee0910052206ge80ec18yb0546282c4a9945f@mail.gmail.com>
	<s5hhbudrrgb.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from ganesha.gnumonks.org (ganesha.gnumonks.org [213.95.27.120])
	by alsa0.perex.cz (Postfix) with ESMTP id 080612443F
	for <alsa-devel@alsa-project.org>;
	Tue,  6 Oct 2009 14:25:02 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <s5hhbudrrgb.wl%tiwai@suse.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Li Bo <liboat@gmail.com>
Cc: Takashi Iwai <tiwai@suse.de>, alsa-devel@alsa-project.org, lydiawang@viatech.com.cn, LoganLi@viatech.com.cn
List-Id: alsa-devel@alsa-project.org

Hi all,

On Tue, Oct 06, 2009 at 08:01:40AM +0200, Takashi Iwai wrote:

> > As you describe, we implement it with self-reschedule workqueue, acting
> > like a timer.
> > Is there some advice to implement timer-like task, I tested  with timer and
> > it will crash the driver.
> 
> Right, you can't call it in a softirq.
> 
> A few problems, however:
> - present variable should be in struct via_spec, instead of a static
>   variable in update_hp_jack_state().

I agree
> - This mechanism is unconditionally invoked on VT1708 although, in
>   theory, you can have a hardware that doesn't need HP jack detection

Yes, Logan/Li/Lydia: If we generate this kind of workaround with a timer,
it should only be used on those particular chips that absolutely need it.

> - Waking up each 100ms for the *whole* time is really bad regarding
>   the power-saving; can't it be optimized?

I would personally actually suggest to simply not support headphone plug events
in case you are using such a [buggy?] chipset that does not support them.

I mean, what do you gain from that event? It's not something super-important.

waking up unconditionally every 100ms is really a too high burden on the
battery life.

Another option might be to make it a module load time parameter, so people
can choose if they actually want to pay the high power/batyery price for this
small feature.

-- 
- Harald Welte <laforge@gnumonks.org>           http://laforge.gnumonks.org/
============================================================================
"Privacy in residential applications is a desirable marketing option."
                                                  (ETSI EN 300 175-7 Ch. A6)
