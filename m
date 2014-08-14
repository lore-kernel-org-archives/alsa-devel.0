From: Julian Wollrath <jwollrath@web.de>
Subject: Re: Grey noise with HDA Intel PCH
Date: Thu, 14 Aug 2014 16:07:37 +0200
Message-ID: <20140814160737.0e8fc283@saldaea>
References: <20140814114003.7b0019f3@saldaea> <53EC8D5B.5020709@ladisch.de>
 <20140814124616.65991d7e@saldaea> <s5hoavnnu38.wl-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mout.web.de (mout.web.de [212.227.17.11])
 by alsa0.perex.cz (Postfix) with ESMTP id B83B526163C
 for <alsa-devel@alsa-project.org>; Thu, 14 Aug 2014 16:07:45 +0200 (CEST)
In-Reply-To: <s5hoavnnu38.wl-tiwai@suse.de>
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
Cc: alsa-devel@alsa-project.org, Clemens Ladisch <clemens@ladisch.de>
List-Id: alsa-devel@alsa-project.org

> > > > Simple mixer control 'Mic',0
> > > >   Front Left: Playback 0 [0%] [-34.50dB] [on]
> > > >   Front Right: Playback 0 [0%] [-34.50dB] [on]
> > > 
> > > This plays any noise from the mic input.
> > Turning it off makes no difference since capture is turned off
> > anyway:
> 
> This is a loopback mixer element, it has nothing to do with capture
> stream.
> 
> The likely culprit of the static noises is the signal from the analog
> loopback.  In some cases, you can disable the whole loopback via
> "Loopback Mixing" mixer element on the fly.  In some cases, you'd need
> to disable each mixer input (e.g. "Mic Playback Switch").
> In some cases (e.g. on some Sony and Dell laptops), you'd need to
> disable the complete analog loopback at the initialization.
> 
> The last one can be done via the early patching or sysfs
> reconfiguration, pass "mixer_nid = 0" hint.  See HD-Audio.txt for a
> brief instruction.
Sadly, that did not help.


Cheers,
Julian
