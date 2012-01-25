From: Liam Girdwood <lrg@ti.com>
Subject: Re: soc-dsp programming model for loopbacks
Date: Wed, 25 Jan 2012 17:12:25 +0000
Message-ID: <1327511545.11901.41.camel@odin>
References: <007801ccdae0$381fcf40$a85f6dc0$@bossart@linux.intel.com>
	<20120124220036.GA11635@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from na3sys009aog112.obsmtp.com (na3sys009aog112.obsmtp.com
	[74.125.149.207])
	by alsa0.perex.cz (Postfix) with ESMTP id 93978103BBD
	for <alsa-devel@alsa-project.org>; Wed, 25 Jan 2012 18:12:29 +0100 (CET)
Received: by mail-wi0-f180.google.com with SMTP id hm6so5427969wib.11
	for <alsa-devel@alsa-project.org>; Wed, 25 Jan 2012 09:12:27 -0800 (PST)
In-Reply-To: <20120124220036.GA11635@sirena.org.uk>
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

On Tue, 2012-01-24 at 22:00 +0000, Mark Brown wrote:
> On Tue, Jan 24, 2012 at 01:36:18PM -0800, Pierre-Louis Bossart wrote:
> 
> > Now if the FM radio routing is handled with a digital loopback on the
> > application processor audio dsp (omap-abe, Intel SST, etc), then soc-dsp
> > will need to be used. And for a simple FM playback, I need to 
> 
> Note that the use of soc-dsp isn't required for on-SoC DSPs - it really
> depends on how the hardware looks.  If the DSP external format is very
> strongly tied to the format used to DMA to and from main memory (or
> other interfaces) then soc-dsp is what you need, if the DSP is able to
> rewrite formats more flexibly then it should be more direct to model it
> as a CODEC device with whatever number of DAIs and routing between them.

It's also needed if your DSP cant control or configure any of your host
CPU DAI hardware controllers that it needs to physically use to route
audio data.

Regards

Liam
