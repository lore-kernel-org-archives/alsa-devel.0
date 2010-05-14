From: Wu Fengguang <fengguang.wu@intel.com>
Subject: Re: [PATCH 1/5] allow up to 32 PCM devices
Date: Fri, 14 May 2010 16:32:54 +0800
Message-ID: <20100514083254.GA5723@localhost>
References: <20100512013015.752623810@intel.com>
	<20100512015713.762299923@intel.com>
	<alpine.LNX.2.00.1005120925400.6856@eeebox2.perex-int.cz>
	<s5htyqdsg0w.wl%tiwai@suse.de> <20100512083950.GB11001@localhost>
	<s5hbpclsdbu.wl%tiwai@suse.de> <4BEA80F1.7040600@ladisch.de>
	<s5h7hn9s836.wl%tiwai@suse.de> <20100513022126.GA13559@localhost>
	<s5hocgiq4ga.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
	by alsa0.perex.cz (Postfix) with ESMTP id 59646244AA
	for <alsa-devel@alsa-project.org>;
	Fri, 14 May 2010 10:33:07 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <s5hocgiq4ga.wl%tiwai@suse.de>
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
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, Clemens Ladisch <clemens@ladisch.de>
List-Id: alsa-devel@alsa-project.org

On Fri, May 14, 2010 at 04:21:09PM +0800, Takashi Iwai wrote:
> At Thu, 13 May 2010 10:21:26 +0800,
> Wu Fengguang wrote:
> > 
> > On Wed, May 12, 2010 at 06:55:09PM +0800, Takashi Iwai wrote:
> > > At Wed, 12 May 2010 12:20:33 +0200,
> > > Clemens Ladisch wrote:
> > > > 
> > > > Takashi Iwai wrote:
> > > > > Wu Fengguang wrote:
> > > > > > > Jaroslav Kysela wrote:
> > > > > > > > I don't agree to have only 4 slots for soundcards in the static minor 
> > > > > > > > numbering. Maybe the driver should be converted to use subdevices or we 
> > > > > > > > might drop the static minor number allocation at all (it might have only 
> > > > > > > > impact for old distros).
> > > > > > 
> > > > > > Jaroslav, will there be so many sound cards in one system?
> > > > > 
> > > > > In the old time, yes.  Now we have less and less PCI slots.
> > > > > In theory, we may have lots of USB audio devices, though :)
> > > > 
> > > > I implemented CONFIG_SND_DYNAMIC_MINORS because people had been asking
> > > > for more than eight cards.  (And by now I have lots of cards too,
> > > > although my computer probably isn't very typical.)
> > > > 
> > > > Anyway, static numbering is needed only for systems without udev/devfs,
> > > > and there we shouldn't change it for backwards compatibility.  The HDA
> > > > driver already requires kernels >= 2.6, so I don't see a problem with
> > > > requiring CONFIG_SND_DYNAMIC_MINORS to get all HDMI outputs.
> > > 
> > > Right.  We can make it dependent.
> > > 
> > 
> > Like this?
> > 
> >  config SND_HDA_CODEC_INTELHDMI
> >  	bool "Build INTEL HDMI HD-audio codec support"
> > +	select SND_DYNAMIC_MINORS
> >  	default y
> > 
> > That will effectively turn on CONFIG_SND_DYNAMIC_MINORS by default
> > (distribution kernels will have to enable it).
> 
> It's always a question whether we use "depends on" or "select".
> The former is safer while the latter is more intuitive.
> 
> In this particular case, I think "select" would be OK.
> If other guys have no objection, please repost the patch so that I can
> pick it up later.

OK. Wait a minute :)

> > Another backwards compatible solution is to fall back to the two
> > reserved values. This makes me a bit more comfortable :)
> 
> As mentioned in another post, I don't see a big merit by it.
> In short: don't touch a working code :)  The non-dynamic minors are
> only for old stuff, better to keep as is.

OK. I'll drop that idea.

Thanks,
Fengguang
