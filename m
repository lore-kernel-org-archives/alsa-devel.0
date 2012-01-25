From: Liam Girdwood <lrg@ti.com>
Subject: Re: soc-dsp programming model for loopbacks
Date: Wed, 25 Jan 2012 17:48:57 +0000
Message-ID: <1327513737.11901.47.camel@odin>
References: <007801ccdae0$381fcf40$a85f6dc0$@bossart@linux.intel.com>
	<20120124220036.GA11635@sirena.org.uk> <1327511545.11901.41.camel@odin>
	<20120125172051.GS3687@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from na3sys009aog103.obsmtp.com (na3sys009aog103.obsmtp.com
	[74.125.149.71])
	by alsa0.perex.cz (Postfix) with ESMTP id 322D0103BCB
	for <alsa-devel@alsa-project.org>; Wed, 25 Jan 2012 18:51:23 +0100 (CET)
Received: by wibhm4 with SMTP id hm4so3153128wib.15
	for <alsa-devel@alsa-project.org>; Wed, 25 Jan 2012 09:51:09 -0800 (PST)
In-Reply-To: <20120125172051.GS3687@opensource.wolfsonmicro.com>
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
Cc: alsa-devel@alsa-project.org, Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
List-Id: alsa-devel@alsa-project.org

On Wed, 2012-01-25 at 17:20 +0000, Mark Brown wrote:
> On Wed, Jan 25, 2012 at 05:12:25PM +0000, Liam Girdwood wrote:
> > On Tue, 2012-01-24 at 22:00 +0000, Mark Brown wrote:
> 
> > > Note that the use of soc-dsp isn't required for on-SoC DSPs - it really
> > > depends on how the hardware looks.  If the DSP external format is very
> > > strongly tied to the format used to DMA to and from main memory (or
> > > other interfaces) then soc-dsp is what you need, if the DSP is able to
> > > rewrite formats more flexibly then it should be more direct to model it
> > > as a CODEC device with whatever number of DAIs and routing between them.
> 
> > It's also needed if your DSP cant control or configure any of your host
> > CPU DAI hardware controllers that it needs to physically use to route
> > audio data.
> 
> Depends how they're allocated - the DSP driver can always do the
> management on behalf of the DSP firmware if the hardware is structured
> in a way that makes that make sense (for example, if the CPU never talks
> to the outside world directly).

Wouldn't that either mean the DSP driver (re)implements some of the CPU
DAI driver operations OR the DSP driver calling the CPU DAI driver ops
directly ? 

Regards

Liam
