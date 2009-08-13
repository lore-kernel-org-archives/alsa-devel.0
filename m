From: Ben Dooks <ben-alsa@fluff.org>
Subject: Re: Audio support for TLV320AIC23 on Simtec S3C24XX
	products
Date: Thu, 13 Aug 2009 14:50:39 +0100
Message-ID: <20090813135039.GE26088@trinity.fluff.org>
References: <20090806230149.440747780@fluff.org.uk>
	<20090807101052.GB639@sirena.org.uk>
	<4A84140E.1010008@simtec.co.uk>
	<20090813134022.GD21652@rakim.wolfsonmicro.main>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from trinity.fluff.org (trinity.fluff.org [89.16.178.74])
	by alsa0.perex.cz (Postfix) with ESMTP id 2C7ED10387B
	for <alsa-devel@alsa-project.org>;
	Thu, 13 Aug 2009 15:50:46 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <20090813134022.GD21652@rakim.wolfsonmicro.main>
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
Cc: Ben Dooks <ben@simtec.co.uk>, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On Thu, Aug 13, 2009 at 02:40:22PM +0100, Mark Brown wrote:
> On Thu, Aug 13, 2009 at 02:24:30PM +0100, Ben Dooks wrote:
> > Mark Brown wrote:
> 
> > >Also, as I've mentioned to you on a number of previous occasions please
> > >do try to remember to CC subsystem maintainers when submitting patches.
> 
> > I thought you where the ASoC maintainer? Who else should I be CC'ing?
> 
> You'd only sent the patches to the list, there wasn't a CC to me.

sorry, you are right about that.
 
> > >So I'm guessing that this is muting through powering off?  In that case
> > >(and probably in general) this would be better implemented as a DAPM
> > >widget with a SND_SOC_DAPM_PIN_SWITCH() control set up to provide the
> > >mute functionality.  Doing this will allow the speaker to be powered off
> > >when no audio is being played, saving power and helping avoid any pops
> > >or clicks being amplified by it.
> 
> > I tried it that way first, unfortunately the AMP itself makes a POP
> > when powering up and down, the headphone output of the TLV320AIC23
> > doesn't seem to have a problem with pops.
> 
> But it doesn't pop when people use the mute control?  OK, anyway.
> _______________________________________________
> Alsa-devel mailing list
> Alsa-devel@alsa-project.org
> http://mailman.alsa-project.org/mailman/listinfo/alsa-devel

-- 
-- 
Ben

Q:      What's a light-year?
A:      One-third less calories than a regular year.
