From: Markus Trippelsdorf <markus@trippelsdorf.de>
Subject: Re: No sound for several minutes after reboot
Date: Mon, 29 Aug 2016 11:40:48 +0200
Message-ID: <20160829094048.GC314@x4>
References: <20160827095018.GA309@x4> <20160827113908.GA312@x4>
 <s5htwe4t2hy.wl-tiwai@suse.de> <20160829083334.GA309@x4>
 <s5hshtot1e2.wl-tiwai@suse.de> <20160829085653.GA306@x4>
 <20160829090548.GA314@x4> <s5hk2f0szne.wl-tiwai@suse.de>
 <20160829092047.GB314@x4> <s5hh9a3udhn.wl-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail.ud10.udmedia.de (ud10.udmedia.de [194.117.254.50])
 by alsa0.perex.cz (Postfix) with ESMTP id A22ED266954
 for <alsa-devel@alsa-project.org>; Mon, 29 Aug 2016 20:05:25 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <s5hh9a3udhn.wl-tiwai@suse.de>
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
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On 2016.08.29 at 11:32 +0200, Takashi Iwai wrote:
> On Mon, 29 Aug 2016 11:20:47 +0200,
> Markus Trippelsdorf wrote:
> > 
> > On 2016.08.29 at 11:16 +0200, Takashi Iwai wrote:
> > > On Mon, 29 Aug 2016 11:05:48 +0200,
> > > Markus Trippelsdorf wrote:
> > > > 
> > > > On 2016.08.29 at 10:56 +0200, Markus Trippelsdorf wrote:
> > > > > 
> > > > > Unfortunately running: hda-verb /dev/snd/hwC0D0 0x14 SET_POWER 0x00
> > > > > has no effect.
> > > > 
> > > > OK.
> > > > Running: hda-verb /dev/snd/hwC0D0 0x15 SET_DIGI_CONVERT_1 0x01
> > > > fixes the issue.
> > > > I have now put this into my startup script.
> > > 
> > > Oh, then you're using SPDIF output or such?  I missed it from the
> > > description.
> > 
> > Yes, as I wrote in first mail:
> > it is a TOSLINK-S/PDIF link to my DAC.
> 
> Yeah, now I found it.  It's hidden well like Wally, as if it's a part
> of the "aplay -l" output...

Hey, never mind.

> > > This should have been set by IEC958 status bits control.  Does the
> > > problem exist only after a fresh reboot?
> > Yes. And only for a few minutes. After that it gets finally switched on.
> 
> Hm, it's interesting who sets this bit at all.  Could you track it via
> tracing verbs as described in Documentation/sound/alsa/HD-Audio.txt.

I'm not particular motivated now that it is working as expected again.
But if I find time I will do the tracing.

-- 
Markus
