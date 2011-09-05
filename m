From: Vinod Koul <vinod.koul@linux.intel.com>
Subject: Re: [RFC 4/5] compress: add the core file
Date: Tue, 06 Sep 2011 02:51:02 +0530
Message-ID: <1315257662.26251.285.camel@vkoul-udesk3>
References: <1314943585-11670-1-git-send-email-vinod.koul@linux.intel.com>
	<1314943585-11670-5-git-send-email-vinod.koul@linux.intel.com>
	<20110902143615.GC10175@sirena.org.uk>
	<1315019185.26251.56.camel@vkoul-udesk3>
	<20110905174310.GH3889@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
	by alsa0.perex.cz (Postfix) with ESMTP id E7944244CE
	for <alsa-devel@alsa-project.org>;
	Mon,  5 Sep 2011 23:23:14 +0200 (CEST)
In-Reply-To: <20110905174310.GH3889@opensource.wolfsonmicro.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@opensource.wolfsonmicro.com>
Cc: tiwai@suse.de, alsa-devel@alsa-project.org, lrg@ti.com, Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
List-Id: alsa-devel@alsa-project.org

On Mon, 2011-09-05 at 10:43 -0700, Mark Brown wrote:
> On Sat, Sep 03, 2011 at 08:36:25AM +0530, Vinod Koul wrote:
> > On Fri, 2011-09-02 at 15:36 +0100, Mark Brown wrote:
> > > On Fri, Sep 02, 2011 at 11:36:24AM +0530, Vinod Koul wrote:
> 
> > > > + *   TBD how the cpu dai will be viewed and started.
> > > > + *	ASoC should always be optional part
> > > > + *	(we should be able to use this framework in non asoc systems
> 
> > > Just write an ALSA core API, ASoC is an ALSA driver so it can just use
> > > the same interfaces as everything else gets.
> 
> > Actually no. That way devices would get regsitered as /dev/snd_pcmCxDxy
> > which wont be corect.
> 
> I'm sorry, I can't understand why this would be the case?  ALSA already
> has devices with several different names (control, hw, and pcm).
Okay, I checked and looking at code, I think i should call
snd_register_device_for_dev with a new device type, like
SNDRV_DEVICE_TYPE_COMPRESSED.
> 
> > > > +	runtime->state = SNDRV_PCM_STATE_OPEN;
> > > > +	init_waitqueue_head(&runtime->sleep);
> > > > +	data->stream.runtime = runtime;
> > > > +	f->private_data = (void *)data;
> 
> > > Should we hoist these before we call open(), especially the init of
> > > runtime?  It seems likely to be more robusy.
> 
> > Since open is just supposed to let the device know that stream is being
> > created with a particular direction. Event if I move this up, doesn't
> > serve a purpose as driver should touch these a t open.
> > But I agree this helps to make more robust 
> 
> The most obvious ones were the runtime pointer and the state, I can
> easily see some configuration being done on init that might also be done
> at later and so want to check the state.
Okay will change this

> > Well I kept them placeholder to remind me what else needs
> > implementation, I think I will keep them for a while as we need to
> > implement mmap and recording support as well. Recording is actually
> > trivial after playback.
> 
> It's generally preferred to omit this sort of stuff from actual
> upstream submissions.
No issues, will remove all dead code.

> > > +EXPORT_SYMBOL_GPL(snd_compr_period_elapsed);
> 
> > > I can see why you picked period_elapsed() (for consistency) but it feels
> > > wrong to have a time based name for something which is going to end up
> > > being data size based.
> 
> > Yes the notion of period here cannot be time it is in bytes.
> 
> Right, but the trouble is that "period" generally means a unit of time
> so it doesn't read right.
Hmmm, I might then go for _fragment_elapsed or something :)


-- 
~Vinod
