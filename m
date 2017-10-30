From: Henrik Eriksson <henrik.eriksson@axis.com>
Subject: Re: timestamp update when no hw delta
Date: Mon, 30 Oct 2017 10:03:47 +0100
Message-ID: <20171030090347.GA5483@lnxhenriken2.se.axis.com>
References: <20171010121459.GF24037@lnxhenriken2.se.axis.com>
 <s5h8tfzpwm8.wl-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from bastet.se.axis.com (bastet.se.axis.com [195.60.68.11])
 by alsa0.perex.cz (Postfix) with ESMTP id F3262266CED
 for <alsa-devel@alsa-project.org>; Mon, 30 Oct 2017 10:03:50 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <s5h8tfzpwm8.wl-tiwai@suse.de>
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
Cc: alsa-devel@alsa-project.org, Henrik Eriksson <henriken@axis.com>, Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
List-Id: alsa-devel@alsa-project.org

On Wed,=A0Oct=A025,=A02017=A0at=A008:30:55=A0+0200, Takashi Iwai wrote:
> On Tue, 10 Oct 2017 14:14:59 +0200,
> Henrik Eriksson wrote:
> > =

> > I am looking into commit 3179f62001880e588e229db3006a59ad87b7792a
> > ("ALSA: core: add .get_time_info"), which, if I understand the code
> > correctly, changed the behaviour of timestamps.  Before this change,
> > snd_pcm_update_hw_ptr0() just returned if the no_delta_check showed that
> > the hw_ptr had not changed.  With this change it will update the
> > timestamps before returning.
> > =

> > Was this intended, and if so does anyone have any insights to why?  The
> > original behaviour to not update the timestamps when the hw position has
> > not changed seems more correct to me, but I am new to this code.
> =

> Pierre is the best person to answer this, but AFAIK, the intention is
> to allow more fine-grained timestamp, and it's finer than the sample
> rate.  That is, you want to know the continuous (wallclock) time stamp
> even between two PCM pulses, which allows more exact synchronization
> of the PCM timeline and the system/network timeline.

Thank you.  With some more time to look into this, I am leaning towards
the new behaviour being closer to the definition of tstamp at
https://www.kernel.org/doc/Documentation/sound/designs/timestamping.rst,
which originated in the same patch series as the pcm_lib.c change.
But as far as I can tell it is an actual behaviour change for the
no_delta_check true case.  On devices that do not provide a granular
pcm hw pointer function, like using soc-generic-dmaengine-pcm with a
dmaengine that does not provide a residue count, it is very noticeable
since the pointer function will return 0.  In this case usermode will
also get an avail report of 0, so it cannot use that to count back from
tstamp.

Is there any way in ALSA to get a timestamp of a system clock from the
time the hwptr moved, similar to the behaviour before these changes?

Regards,
/henrik
