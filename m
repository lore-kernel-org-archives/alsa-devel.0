From: Lu Guanqun <guanqun.lu@intel.com>
Subject: Re: [PATCH] ASoC: sst_platform: Fix lock acquring
Date: Sat, 9 Apr 2011 18:22:06 +0800
Message-ID: <20110409102206.GA29911@qtel.sh.intel.com>
References: <20110408073848.30438.39586.stgit@localhost>
	<20110408074042.GS29324@qtel.sh.intel.com>
	<438BB0150E931F4B9CE701519A446301085184E6C2@bgsmsx502.gar.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
	by alsa0.perex.cz (Postfix) with ESMTP id 6D9EA103816
	for <alsa-devel@alsa-project.org>;
	Sat,  9 Apr 2011 12:22:57 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <438BB0150E931F4B9CE701519A446301085184E6C2@bgsmsx502.gar.corp.intel.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: "Koul, Vinod" <vinod.koul@intel.com>
Cc: Takashi Iwai <tiwai@suse.de>, ALSA <alsa-devel@alsa-project.org>, "Harsha,
	Priya" <priya.harsha@intel.com>, Mark Brown <broonie@opensource.wolfsonmicro.com>, Liam Girdwood <lrg@slimlogic.co.uk>
List-Id: alsa-devel@alsa-project.org

On Sat, Apr 09, 2011 at 12:51:07PM +0800, Koul, Vinod wrote:
> On Fri, Apr 08, 2011 at 01:11:48PM +0530, Lu Guanqun wrote:
> > On Fri, Apr 08, 2011 at 03:38:48PM +0800, Lu Guanqun wrote:
> > > Fix the possible dead lock shown below:
> > >
> > > spin_lock
> > > sst_get_stream_status
> > > sst_period_elapsed
> > > intel_sst_interrupt
> > > handle_IRQ_event
> > > handle_fasteoi_irq
> > > do_IRQ
> > > common_interrupt
> > > spin_lock
> > > sst_set_stream_status
> > > sst_platform_pcm_trigger
> > >
> > > Signed-off-by: Lu Guanqun <guanqun.lu@intel.com>
> Sorry, I am little unsure about this yet.
> Can you send more details of the deadlock you see.
> Which scenario it is hit, would help to send the debug trace :)

Hi Vinod,

I don't get the actual debug trace, so I have to manually reveal the
possible deadlock...

As sst_set_stream_status could be called both in interrupt context and
process context, a simple spin_lock can't protect the mutal exclusion
properly. I'm afraid spin_lock_irqsave is better for this use case here.

How do you think?

> 
> ~Vinod
> 

-- 
guanqun
