From: "Koul, Vinod" <vinod.koul@intel.com>
Subject: Re: [PATCH] ASoC: sst_platform: Fix lock acquring
Date: Sat, 9 Apr 2011 10:21:07 +0530
Message-ID: <438BB0150E931F4B9CE701519A446301085184E6C2@bgsmsx502.gar.corp.intel.com>
References: <20110408073848.30438.39586.stgit@localhost>
	<20110408074042.GS29324@qtel.sh.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
	by alsa0.perex.cz (Postfix) with ESMTP id 769E410387B
	for <alsa-devel@alsa-project.org>;
	Sat,  9 Apr 2011 06:51:14 +0200 (CEST)
In-Reply-To: <20110408074042.GS29324@qtel.sh.intel.com>
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
To: "Lu, Guanqun" <guanqun.lu@intel.com>, ALSA <alsa-devel@alsa-project.org>
Cc: Takashi Iwai <tiwai@suse.de>, "Harsha, Priya" <priya.harsha@intel.com>, Mark Brown <broonie@opensource.wolfsonmicro.com>, Liam Girdwood <lrg@slimlogic.co.uk>
List-Id: alsa-devel@alsa-project.org

On Fri, Apr 08, 2011 at 01:11:48PM +0530, Lu Guanqun wrote:
> On Fri, Apr 08, 2011 at 03:38:48PM +0800, Lu Guanqun wrote:
> > Fix the possible dead lock shown below:
> >
> > spin_lock
> > sst_get_stream_status
> > sst_period_elapsed
> > intel_sst_interrupt
> > handle_IRQ_event
> > handle_fasteoi_irq
> > do_IRQ
> > common_interrupt
> > spin_lock
> > sst_set_stream_status
> > sst_platform_pcm_trigger
> >
> > Signed-off-by: Lu Guanqun <guanqun.lu@intel.com>
Sorry, I am little unsure about this yet.
Can you send more details of the deadlock you see.
Which scenario it is hit, would help to send the debug trace :)

~Vinod
