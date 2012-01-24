From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: soc-dsp programming model for loopbacks
Date: Tue, 24 Jan 2012 22:00:36 +0000
Message-ID: <20120124220036.GA11635@sirena.org.uk>
References: <007801ccdae0$381fcf40$a85f6dc0$@bossart@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
	by alsa0.perex.cz (Postfix) with ESMTP id 13F64103B32
	for <alsa-devel@alsa-project.org>; Tue, 24 Jan 2012 23:00:39 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <007801ccdae0$381fcf40$a85f6dc0$@bossart@linux.intel.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Cc: alsa-devel@alsa-project.org, 'Liam Girdwood' <lrg@ti.com>
List-Id: alsa-devel@alsa-project.org

On Tue, Jan 24, 2012 at 01:36:18PM -0800, Pierre-Louis Bossart wrote:

> Now if the FM radio routing is handled with a digital loopback on the
> application processor audio dsp (omap-abe, Intel SST, etc), then soc-dsp
> will need to be used. And for a simple FM playback, I need to 

Note that the use of soc-dsp isn't required for on-SoC DSPs - it really
depends on how the hardware looks.  If the DSP external format is very
strongly tied to the format used to DMA to and from main memory (or
other interfaces) then soc-dsp is what you need, if the DSP is able to
rewrite formats more flexibly then it should be more direct to model it
as a CODEC device with whatever number of DAIs and routing between them.
