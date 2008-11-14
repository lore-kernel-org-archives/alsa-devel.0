From: Wu Fengguang <wfg@linux.intel.com>
Subject: Re: [RFC][PATCH] ELD routines and proc interface
Date: Fri, 14 Nov 2008 15:38:56 +0800
Message-ID: <1226648341.561038.5360@de>
References: <1226542918.126598.6912@de> <s5h4p2crsqv.wl%tiwai@suse.de>
	<1226626476.943818.9357@de> <s5h3ahulqf4.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from orsmga101.jf.intel.com (mga06.intel.com [134.134.136.21])
	by alsa0.perex.cz (Postfix) with ESMTP id 799EA243D1
	for <alsa-devel@alsa-project.org>; Fri, 14 Nov 2008 08:39:05 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <s5h3ahulqf4.wl%tiwai@suse.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

On Fri, Nov 14, 2008 at 08:25:51AM +0100, Takashi Iwai wrote:
> At Fri, 14 Nov 2008 09:34:32 +0800,
> Wu Fengguang wrote:
> > 
> > > > - How do we name the proc file?
> > > >   If there are going to be two HDMI pins per codec, then the current naming
> > > >   scheme (eld#<codec no>) will fail.
> > > 
> > > In theory, yes, but I don't think this would happen.
> > > If this is needed, the currently existing codec#* proc must be fixed,
> > > too.  So, we can use eld#codec as the simplest way.
> > 
> > I mean one HDMI codec equipped with two output converters and two HDMI pins.
> > In this case there could be two HDMI sinks mapped to one single codec.
> > 
> > Or it would be trivial to do the rename in the future anyway?
> 
> Ah, OK, understood.  One easy solution is to name the proc file with
> either pin of audio-out widget NID.
> 
> But I'm not sure whether it's worth.  The proc file naming isn't
> strict, so I'd leave it as is.

OK, I'll leave it as is: there should be no many dependencies on it.

> > > > --- /dev/null
> > > > +++ sound-2.6/sound/pci/hda/hda_eld.c
> > > > +static inline unsigned char grab_bits(const unsigned char *buf,
> > > > +						int byte, int lowbit, int bits)
> > > > +{
> > > > +	BUG_ON(lowbit > 7);
> > > > +	BUG_ON(bits > 8);
> > > > +	BUG_ON(bits <= 0);
> > > 
> > > Can it be rather BUILD_BUG_ON(), BTW?
> > > Or, hmm, doesn't work if it's an inline function?
> > 
> > Yes, converted to BUILD_BUG_ON() and it compiles OK.
> 
> The question is whether this really triggers the build error
> properly.  Could you check it, simply by changing the caller of
> grab_bits() with some invalid values?  Then you should get a compile
> error.

BUILD_BUG_ON() won't emit errors! So use BUG_ON()?

Thank you,
Fengguang
