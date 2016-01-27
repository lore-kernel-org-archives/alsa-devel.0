From: Charles Keepax <ckeepax@opensource.wolfsonmicro.com>
Subject: Re: [PATCH] ALSA: core: Add 384kHz Support
Date: Wed, 27 Jan 2016 17:44:40 +0000
Message-ID: <20160127174440.GP1490@localhost.localdomain>
References: <1453902825-27002-1-git-send-email-brian.austin@cirrus.com>
 <s5hzivr6s0e.wl-tiwai@suse.de>
 <alpine.DEB.2.10.1601270809340.3329@heelroid>
 <s5hwpqv6qef.wl-tiwai@suse.de>
 <alpine.DEB.2.10.1601270859040.3329@heelroid>
 <s5hsi1j6mxe.wl-tiwai@suse.de> <56A8F68C.7040805@metafoo.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx0b-001ae601.pphosted.com (mx0b-001ae601.pphosted.com
 [67.231.152.168])
 by alsa0.perex.cz (Postfix) with ESMTP id DC03B2654B6
 for <alsa-devel@alsa-project.org>; Wed, 27 Jan 2016 18:44:40 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <56A8F68C.7040805@metafoo.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Lars-Peter Clausen <lars@metafoo.de>
Cc: Takashi Iwai <tiwai@suse.de>, Brian Austin <brian.austin@cirrus.com>, paul.handrigan@cirrus.com, alsa-devel@alsa-project.org, charles.keepax@cirrus.com
List-Id: alsa-devel@alsa-project.org

On Wed, Jan 27, 2016 at 05:55:40PM +0100, Lars-Peter Clausen wrote:
> On 01/27/2016 04:51 PM, Takashi Iwai wrote:
> > On Wed, 27 Jan 2016 16:02:35 +0100,
> > Brian Austin wrote:
> >>
> >> On Wed, 27 Jan 2016, Takashi Iwai wrote:
> >>
> >>>> So we stay at SNDRV_PCM_RATE_192000 always for sample rate defines?
> >>>> And everything else is just covered with SNDRV_PCM_RATE_KNOT? 
> >>>
> >>> Depends.  If a new sample rate is (or will be) demanded by many
> >>> drivers, it's worth to add it, of course, as it would simplify the
> >>> code.
> >>>
> >>> That's why I mentioned "why" is most important information; you need
> >>> to convince others about the necessity of this change, after all.
> >>> Then you see that "because I-wanna-it" doesn't sound convincing
> >>> enough, right?
> >>>
> >>>
> >>> Takashi
> >>>
> >> I really, really, really want it :)
> >>
> >> I understand. Going forward, from our perspective, 384 and 
> >> other high sample rates are going to be defaults for devices as the market 
> >> is moving that way. I just wanted to make it easier to use those instead 
> >> of doing all the contraint coding.
> > 
> > Yeah that's the reason I could *guess*, but it wasn't mentioned.
> > 
> >> Now my understanding on the KNOT define 
> >> may be wrong. I can add the other rates to this, but for now just wanted 
> >> to add one we use currently.
> >>
> >> Does that make sense? 
> > 
> > Just resubmit the patch with mo' better advertisement :)
> 
> For symmetry reasons maybe also include the matching 44.1kHz based rate.
> Unless you think that is not going to be a thing.

Everything I have seen using >192k sample rates has been using
the 48k based rate families. My guess would be that the matching
44.1k rate is unlikely to be a thing.

Thanks,
Charles
