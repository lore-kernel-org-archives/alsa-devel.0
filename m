From: Liam Girdwood <lrg@ti.com>
Subject: Re: soc-dsp programming model for loopbacks
Date: Thu, 26 Jan 2012 14:27:48 +0000
Message-ID: <1327588068.7134.5.camel@odin>
References: <4f1f2489.c602440a.208e.ffff9d7bSMTPIN_ADDED@mx.google.com>
	<1327511249.11901.37.camel@odin>
	<20120125171112.GR3687@opensource.wolfsonmicro.com>
	<002d01ccdb9c$7099f1e0$51cdd5a0$@bossart@linux.intel.com>
	<20120125201438.GA17032@opensource.wolfsonmicro.com>
	<4F215127.8050509@linux.intel.com>
	<20120126140310.GA28994@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from na3sys009aog102.obsmtp.com (na3sys009aog102.obsmtp.com
	[74.125.149.69])
	by alsa0.perex.cz (Postfix) with ESMTP id C2F6C103830
	for <alsa-devel@alsa-project.org>; Thu, 26 Jan 2012 15:27:52 +0100 (CET)
Received: by mail-ww0-f42.google.com with SMTP id gn7so56048wgb.1
	for <alsa-devel@alsa-project.org>; Thu, 26 Jan 2012 06:27:50 -0800 (PST)
In-Reply-To: <20120126140310.GA28994@opensource.wolfsonmicro.com>
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

On Thu, 2012-01-26 at 14:03 +0000, Mark Brown wrote:
> On Thu, Jan 26, 2012 at 07:12:07AM -0600, Pierre-Louis Bossart wrote:
> 
> > Bear with me here, I am still somewhat confused.
> > - Liam suggested either a hard-coded DAI configuration or machine
> > driver logic to remove the need for virtual front-ends
> > - Mark suggested to consider the DSP as a CODEC with some work to
> > re-implement the host-dsp interface.
> > Is this CODEC<->CODEC solution on top of the Dynamic PCM patches? Or
> > are we talking about two completely different approaches?
> 
> The two are orthogonal to each other but complimenary.  Like I say it
> really depends on how your hardware is wired up - it depends on the
> level of isolation that the DSP provides between the CPU and the outside
> world.
> 
> If the system looks like:
> 
>     CPU <-> DSP <-> External
> 
> you should model the DSP as a separate device.  If on the other hand it
> looks more like this:
> 
> 
>    DSP     External
>     ^----v----^
>         CPU
> 
> then soc-pcm is what you're looking for.

Fwiw, the OMAP ABE architecture mixes both above diagrams. We are using
dynamic PCM for managing all the DAI links and will add in support to
use the CODEC <-> CODEC stuff for the loopback DAI interfaces (saving
the need to open()), hw_oparams() etc).

Regards

Liam
