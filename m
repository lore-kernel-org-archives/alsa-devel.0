From: Ashish Chavan <ashish.chavan@kpitcummins.com>
Subject: Re: What is correct way to put conditional stuff in
 ASoC codec driver?
Date: Fri, 1 Jul 2011 14:03:25 +0530
Message-ID: <1309509205.15931.89.camel@matrix>
References: <1309437990.15931.67.camel@matrix>
	<20110630163706.GA18120@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from TX2EHSOBE004.bigfish.com (tx2ehsobe002.messaging.microsoft.com
	[65.55.88.12]) by alsa0.perex.cz (Postfix) with ESMTP id 22111103800
	for <alsa-devel@alsa-project.org>;
	Fri,  1 Jul 2011 10:26:52 +0200 (CEST)
In-Reply-To: <20110630163706.GA18120@sirena.org.uk>
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
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

On Thu, 2011-06-30 at 22:07 +0530, Mark Brown wrote:
> On Thu, Jun 30, 2011 at 06:16:30PM +0530, Ashish Chavan wrote:
> 
> Please fix your mailer to word wrap at less than 80 columns so your mail
> is legible.

Oops! I thought I already have it set in my evolution. Thanks for
pointing it out.

> 
> > Our final goal is to pull in all missing features from this custom
> > driver in to existing mainline driver. I have already created few
> > patches for basic functions but I am bit confused at one point. Some
> > of the features supported by this codec have inter dependency, e.g.
> > ALC can be used only if NOISE SUPRESSION is disabled.  So ideally, all
> > controls related to ALC should be either disabled or not added at all,
> > if NOISE SUPRESSION to be used. There are few other features having
> > similar kind of dependency.
> 
> You'd need to implement custom controls for the relevant enables which
> check to see what is currently enabled and prevents enables if there
> are conflicts.  You should do this dynamically and I'd expect that only
> the enables actually need to check anything, adjusting parameters for
> things that aren't active is usually no problem.

I see. That means it's ok to allow setting up values of five band
equalizers even when overall equalizer functionality is disabled.
Can you point me to any existing code that has such custom control(s)
which need to check for similar conditions? I am sure that many existing
codecs would have this kind of inter dependent functions.

> > I just want to know what is the correct way to handle this in ASoC
> > codec driver?  Looking at the existing codec drivers, it seems that
> > having conditional defines is not common here. As We just want to
> > support static configuration of such features, is it a good idea to
> > add sub menu options in driver's Kconfig to enable/disable such
> > features and use them within code?
> 
> Compile time selection is completely uinacceptable for Linux in general,
> please see the coding style and development model stuff in Documentation
> for discussion of the motivations for this.

Yes, guessed this. In fact that's why I posted the query here :-)
