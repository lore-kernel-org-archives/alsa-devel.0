From: "Koul, Vinod" <vinod.koul@intel.com>
Subject: Re: [PATCH] sst: Intel SST audio driver
Date: Sun, 17 Oct 2010 16:16:53 +0530
Message-ID: <438BB0150E931F4B9CE701519A44630104BE763765@bgsmsx502.gar.corp.intel.com>
References: <mailman.1.1287309601.23450.alsa-devel@alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga14.intel.com (mga14.intel.com [143.182.124.37])
	by alsa0.perex.cz (Postfix) with ESMTP id 8E17024498
	for <alsa-devel@alsa-project.org>;
	Sun, 17 Oct 2010 12:47:19 +0200 (CEST)
In-Reply-To: <mailman.1.1287309601.23450.alsa-devel@alsa-project.org>
Content-Language: en-US
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Takashi Iwai <tiwai@suse.de>, Alan Cox <alan@linux.intel.com>
Cc: "Harsha, Priya" <priya.harsha@intel.com>, "greg@kroah.com" <greg@kroah.com>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, "broonie@opensource.wolfsonmicro.com" <broonie@opensource.wolfsonmicro.com>, "lrg@slimlogic.co.uk" <lrg@slimlogic.co.uk>
List-Id: alsa-devel@alsa-project.org

> > > IIRC at least one version had a split where the ALSA integration stuff
> > > was separated out from the underlying DSP interface code - that was
> > > pretty helpful since it helps focus on the ALSA specifics.
> >
> > Yes but that split is no longer there once the clean up patches sit on
> > top because they weren't put together as separate bits. This is exactly
> > the sort of reason I want to get it in staging.
> >
> >
> > > > Agreed, although gstreamer is pretty good at that it would save
> > > > work if it can be partly generic. It's not trivial however because
> > > > the offload
> > >
> > > Plus the fact that not everyone is using gstreamer at the application
> > > level :/
> > >
> > > > interface with suitable firmware loaded does things other than PCM
> > > > and you have very firmware specific interfaces for configuring
> > > > those.
> > >
> > > We ought to be able to come up with something for the core streaming
> > > stuff, though.  Like I say, it's just a nice to have though.
> >
> > I would have thought PCM at least was also going to have some kind of
> > common structure.
> >
> > > I do have some nervousness about the concept of staging for embedded
> > > stuff since I worry that inclusion in staging can send the wrong
> > > message to vendors but that's a completely separate issue to this
> > > driver.
> >
> > Noted. But I'll point you at the SEP driver which did get bogged down
> > for ages for reasons I can't really go into publically, and we
> > therefore pulled out of staging.
> 
> Sorry to be too late to join the review (as I've been too busy and in
> other troubles...)
No problem :)
> 
> SST driver has been once (sort of) posted and reviewed, but stalled
> since then.  But in general I'm not against merging to the sound main
> tree at all.  The only reason that it didn't occur was that the
> activity just stopped somehow.
Takshi, we had fixed the comments given by you and Mark at that time.
Somehow never managed to get bits upstream again.
> 
> Anyway, I'm going to review in the next week or so.  Then maybe we can
> move it to sound/ directory (e.g. creating sound/platform/x86
> directory) before rc1, unless you'd like to keep the stuff rather in
> staging tree.
That would be wonderful :)
Greg was kind enough to stage it in his staging and there is some activity going on there as well.
If you feel this is good enough to go ahead to sound tree, please merge.
We will resolve the comments by you and community as we go forward and also fix the TODOs.

Thanks
Vinod Koul
