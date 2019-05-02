From: Vinod Koul <vkoul@kernel.org>
Subject: Re: [PATCH 01/14] soundwire: fix kconfig help format
Date: Thu, 2 May 2019 20:45:02 +0530
Message-ID: <20190502151502.GR3845@vkoul-mobl.Dlink>
References: <20190502105930.9889-1-vkoul@kernel.org>
 <20190502105930.9889-2-vkoul@kernel.org>
 <20190502150754.GA17197@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id D2A09F8075A
 for <alsa-devel@alsa-project.org>; Thu,  2 May 2019 17:15:14 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <20190502150754.GA17197@kroah.com>
List-Unsubscribe: <https://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <https://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: "Alsa-devel" <alsa-devel-bounces@alsa-project.org>
To: Greg KH <gregkh@linuxfoundation.org>
Cc: alsa-devel@alsa-project.org, Shreyas NC <shreyas.nc@intel.com>, Sanyog Kale <sanyog.r.kale@intel.com>, Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
List-Id: alsa-devel@alsa-project.org

On 02-05-19, 17:07, Greg KH wrote:
> On Thu, May 02, 2019 at 04:29:17PM +0530, Vinod Koul wrote:
> > Move to help format instead of --help-- as that is not recommended and
> > this makes file consistent with other instance
> > 
> > Signed-off-by: Vinod Koul <vkoul@kernel.org>
> > ---
> >  drivers/soundwire/Kconfig | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> > 
> > diff --git a/drivers/soundwire/Kconfig b/drivers/soundwire/Kconfig
> > index 84876a74874f..53b55b79c4af 100644
> > --- a/drivers/soundwire/Kconfig
> > +++ b/drivers/soundwire/Kconfig
> > @@ -28,7 +28,7 @@ config SOUNDWIRE_INTEL
> >  	select SOUNDWIRE_CADENCE
> >  	select SOUNDWIRE_BUS
> >  	depends on X86 && ACPI && SND_SOC
> > -	---help---
> > +	help
> >  	  SoundWire Intel Master driver.
> >  	  If you have an Intel platform which has a SoundWire Master then
> >  	  enable this config option to get the SoundWire support for that
> > -- 
> > 2.20.1
> > 
> 
> Huh?
> 
> Pierre-Louis sent this patch before you did.  Why did you just rewrite
> the changelog text a bit and then ignore his authorship and
> signed-off-by?

This is not *that* instance! The one Pierre changed was for symbol
"SOUNDWIRE" and is already applied [1] this is for SOUNDWIRE_INTEL which
is another instance. If you have looked or cared, even the log mentions
"makes file consistent with other instance" 

This series is on *top* on the "whole" series from Pierre

> That's a really really shitty thing to do, I'm going to go take his
> version of these patches instead, let me see how they line up...

Honestly, this is a terrible accusation, seems everyone is quick to jump
and yell at others. I asking for an apology.

-- 
~Vinod
