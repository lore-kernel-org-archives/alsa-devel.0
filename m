From: Liam Girdwood <lrg@ti.com>
Subject: Re: soc-dsp programming model for loopbacks
Date: Thu, 26 Jan 2012 14:42:56 +0000
Message-ID: <1327588976.7134.8.camel@odin>
References: <4f1f2489.c602440a.208e.ffff9d7bSMTPIN_ADDED@mx.google.com>
	<1327511249.11901.37.camel@odin>
	<20120125171112.GR3687@opensource.wolfsonmicro.com>
	<002d01ccdb9c$7099f1e0$51cdd5a0$@bossart@linux.intel.com>
	<20120125201438.GA17032@opensource.wolfsonmicro.com>
	<4F215127.8050509@linux.intel.com>
	<20120126140310.GA28994@opensource.wolfsonmicro.com>
	<1327588068.7134.5.camel@odin>
	<20120126143255.GB28994@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from na3sys009aog105.obsmtp.com (na3sys009aog105.obsmtp.com
	[74.125.149.75])
	by alsa0.perex.cz (Postfix) with ESMTP id 369751038AE
	for <alsa-devel@alsa-project.org>; Thu, 26 Jan 2012 15:43:12 +0100 (CET)
Received: by mail-we0-f173.google.com with SMTP id h12so543517wer.32
	for <alsa-devel@alsa-project.org>; Thu, 26 Jan 2012 06:42:59 -0800 (PST)
In-Reply-To: <20120126143255.GB28994@opensource.wolfsonmicro.com>
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

On Thu, 2012-01-26 at 14:32 +0000, Mark Brown wrote:
> On Thu, Jan 26, 2012 at 02:27:48PM +0000, Liam Girdwood wrote:
> > On Thu, 2012-01-26 at 14:03 +0000, Mark Brown wrote:
> 
> > >     CPU <-> DSP <-> External
> 
> > >    DSP     External
> > >     ^----v----^
> > >         CPU
> 
> > Fwiw, the OMAP ABE architecture mixes both above diagrams. We are using
> > dynamic PCM for managing all the DAI links and will add in support to
> > use the CODEC <-> CODEC stuff for the loopback DAI interfaces (saving
> > the need to open()), hw_oparams() etc).
> 
> In terms of the data path I think it's pretty much always like the
> second path with the DMA controller owned by Linux driving the data
> between the various components?

Wrt OMAP, the DMA and the ABE can drive data to the component drivers.
Both DMA and ABE only drive data at the request of the CPU (via PCM and
DAI ops).

Regards

Liam 
