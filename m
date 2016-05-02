From: Vinod Koul <vinod.koul@intel.com>
Subject: Re: [PATCH 1/2] ALSA: hdac: add link pm and ref
	counting
Date: Mon, 2 May 2016 14:32:00 +0530
Message-ID: <20160502090200.GA2274@localhost>
References: <1461852059-20518-1-git-send-email-vinod.koul@intel.com>
 <1461852059-20518-2-git-send-email-vinod.koul@intel.com>
 <s5hfuu4ss28.wl-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
 by alsa0.perex.cz (Postfix) with ESMTP id 7691F26040E
 for <alsa-devel@alsa-project.org>; Mon,  2 May 2016 10:56:19 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <s5hfuu4ss28.wl-tiwai@suse.de>
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
Cc: liam.r.girdwood@linux.intel.com, patches.audio@intel.com, alsa-devel@alsa-project.org, broonie@kernel.org, Jeeja KP <jeeja.kp@intel.com>
List-Id: alsa-devel@alsa-project.org

On Fri, Apr 29, 2016 at 11:05:51AM +0200, Takashi Iwai wrote:
> > +int snd_hdac_ext_bus_link_get(struct hdac_ext_bus *ebus,
> > +				struct hdac_ext_link *link)
> > +{
> > +	int ret = 0;
> > +
> > +	spin_lock(&ebus->lock);
> > +
> > +	/*
> > +	 * if we move from 0 to 1, count will be 1 so power up this link
> > +	 * as well, also check the dma status and trigger that
> > +	 */
> > +	if (++link->ref_count == 1) {
> > +		if (!ebus->cmd_io) {
> > +			snd_hdac_bus_init_cmd_io(&ebus->bus);
> 
> Calling this function inside a spinlock is wrong.
> It should be mutex instead.

Yes I looked at it's usage, we should do a mutex here, will send an update

-- 
~Vinod
