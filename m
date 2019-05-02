From: Greg KH <gregkh@linuxfoundation.org>
Subject: Re: [PATCH 01/14] soundwire: fix kconfig help format
Date: Thu, 2 May 2019 18:35:58 +0200
Message-ID: <20190502163558.GA14664@kroah.com>
References: <20190502105930.9889-1-vkoul@kernel.org>
 <20190502105930.9889-2-vkoul@kernel.org>
 <20190502150754.GA17197@kroah.com>
 <20190502151558.GA2499@kroah.com>
 <20190502152146.GS3845@vkoul-mobl.Dlink>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id B7696F89693
 for <alsa-devel@alsa-project.org>; Thu,  2 May 2019 19:12:21 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <20190502152146.GS3845@vkoul-mobl.Dlink>
List-Unsubscribe: <https://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <https://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: "Alsa-devel" <alsa-devel-bounces@alsa-project.org>
To: Vinod Koul <vkoul@kernel.org>
Cc: alsa-devel@alsa-project.org, Shreyas NC <shreyas.nc@intel.com>, Sanyog Kale <sanyog.r.kale@intel.com>, Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
List-Id: alsa-devel@alsa-project.org

On Thu, May 02, 2019 at 08:51:46PM +0530, Vinod Koul wrote:
> On 02-05-19, 17:15, Greg KH wrote:
> > On Thu, May 02, 2019 at 05:07:54PM +0200, Greg KH wrote:
> > > On Thu, May 02, 2019 at 04:29:17PM +0530, Vinod Koul wrote:
> > > > Move to help format instead of --help-- as that is not recommended and
> > > > this makes file consistent with other instance
> > > > 
> > > > Signed-off-by: Vinod Koul <vkoul@kernel.org>
> > > > ---
> > > >  drivers/soundwire/Kconfig | 2 +-
> > > >  1 file changed, 1 insertion(+), 1 deletion(-)
> > > > 
> > > > diff --git a/drivers/soundwire/Kconfig b/drivers/soundwire/Kconfig
> > > > index 84876a74874f..53b55b79c4af 100644
> > > > --- a/drivers/soundwire/Kconfig
> > > > +++ b/drivers/soundwire/Kconfig
> > > > @@ -28,7 +28,7 @@ config SOUNDWIRE_INTEL
> > > >  	select SOUNDWIRE_CADENCE
> > > >  	select SOUNDWIRE_BUS
> > > >  	depends on X86 && ACPI && SND_SOC
> > > > -	---help---
> > > > +	help
> > > >  	  SoundWire Intel Master driver.
> > > >  	  If you have an Intel platform which has a SoundWire Master then
> > > >  	  enable this config option to get the SoundWire support for that
> > > > -- 
> > > > 2.20.1
> > > > 
> > > 
> > > Huh?
> > > 
> > > Pierre-Louis sent this patch before you did.  Why did you just rewrite
> > > the changelog text a bit and then ignore his authorship and
> > > signed-off-by?
> > > 
> > > That's a really really shitty thing to do, I'm going to go take his
> > > version of these patches instead, let me see how they line up...
> > 
> > Ok, my apologies, that was incorrect.  Your patch was against a
> > different file than his.
> 
> Yes and our emails crossed, apology accepted.
> > 
> > Way to go and make this a total mess to try to figure out, let me see
> > what I can do...
> 
> If you can hold off for a bit longer, I have patches in next (pierre's
> full series and couple of then split and ofcourse authorship retain
> (https://git.kernel.org/pub/scm/linux/kernel/git/vkoul/soundwire.git/log/?h=next)
> and mine on top
> (https://git.kernel.org/pub/scm/linux/kernel/git/vkoul/soundwire.git/log/?h=checkpatch_fixes)
> 
> I can send you a signed PR for both and you can merged them. otherwise
> the style changes will conflict and defeat the whole purpose..
> 
> Let me know if that is okay, thanks

Send me the pull request and let's see how bad things are messed up :)

thanks,

greg k-h
