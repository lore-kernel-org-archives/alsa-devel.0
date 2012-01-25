From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: soc-dsp programming model for loopbacks
Date: Wed, 25 Jan 2012 17:11:12 +0000
Message-ID: <20120125171112.GR3687@opensource.wolfsonmicro.com>
References: <4f1f2489.c602440a.208e.ffff9d7bSMTPIN_ADDED@mx.google.com>
	<1327511249.11901.37.camel@odin>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 8B631103BBB
	for <alsa-devel@alsa-project.org>; Wed, 25 Jan 2012 18:11:14 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <1327511249.11901.37.camel@odin>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Liam Girdwood <lrg@ti.com>
Cc: alsa-devel@alsa-project.org, Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
List-Id: alsa-devel@alsa-project.org

On Wed, Jan 25, 2012 at 05:07:29PM +0000, Liam Girdwood wrote:
> On Tue, 2012-01-24 at 13:36 -0800, Pierre-Louis Bossart wrote:

> We could eventually remove steps 2 and 4 for the FE DAI link, and look
> at hard coding the hw_params() in the mach driver for the loopback link.

That's what the CODEC<->CODEC stuff is all about, hiding the link from
userspace.

> That way the only user space driven actions would be to configure the
> mixers in the CODEC and DSP for the correct route. DAPM would then
> detect the path and Dynamic PCM would use the hard coded configuration
> or bespoke mach driver logic to configure the loopback DAI link based on
> use case. This would have to be done after the basic Dynamic PCM
> infrastructure was upstream though (unless you have a patch atm). 

I've sort of got one, tidying it up and pushing it out keeps on being
very near the top of my list but I've never actually got it looking nice
enough for me to actually want to send it out.
