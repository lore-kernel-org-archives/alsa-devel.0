From: Liam Girdwood <lrg@ti.com>
Subject: Re: [PATCH 1/5] ASoC: dpcm: Add Dynamic PCM core
	operations.
Date: Thu, 26 Apr 2012 18:04:04 +0100
Message-ID: <1335459844.4950.3.camel@odin>
References: <1335352373-5237-1-git-send-email-lrg@ti.com>
	<20120426165459.GN3207@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from na3sys009aog126.obsmtp.com (na3sys009aog126.obsmtp.com
	[74.125.149.155])
	by alsa0.perex.cz (Postfix) with ESMTP id 254D010BBA6
	for <alsa-devel@alsa-project.org>;
	Thu, 26 Apr 2012 19:04:07 +0200 (CEST)
Received: by wibhj6 with SMTP id hj6so4755641wib.7
	for <alsa-devel@alsa-project.org>; Thu, 26 Apr 2012 10:04:05 -0700 (PDT)
In-Reply-To: <20120426165459.GN3207@opensource.wolfsonmicro.com>
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
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On Thu, 2012-04-26 at 17:54 +0100, Mark Brown wrote:
> On Wed, Apr 25, 2012 at 12:12:49PM +0100, Liam Girdwood wrote:
> > The Dynamic PCM core allows digital audio data to be dynamically
> > routed between different ALSA PCMs and DAI links on SoC CPUs with
> > on chip DSP devices. e.g. audio data could be played on pcm:0,0 and
> > routed to any (or all) SoC DAI links.
> 
> I've applied all these now - after recovering from the shock of seeing
> them! :)
> 

Ah yes, it did take along time ! I'm doing less support now so any other
new stuff should be faster now :)

> I think we need to have a look at/think about the no_pcm flag, partly
> just in relation to the CODEC<->CODEC code as that's also figuring out
> that there's no PCM but it does it just by checking that there's no DMA
> driver specified.  But I'm not sure what the best thing to do is here
> without seeing a machine driver or two.

Ok, yes - lets look at that. We should have machine updates ready to
upstream soon with ABE.

Liam 
