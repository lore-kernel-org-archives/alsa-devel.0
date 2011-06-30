From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: What is correct way to put conditional stuff
	in	ASoC codec driver?
Date: Thu, 30 Jun 2011 17:37:07 +0100
Message-ID: <20110630163706.GA18120@sirena.org.uk>
References: <1309437990.15931.67.camel@matrix>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
	by alsa0.perex.cz (Postfix) with ESMTP id 1FBEA10396C
	for <alsa-devel@alsa-project.org>;
	Thu, 30 Jun 2011 18:37:09 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <1309437990.15931.67.camel@matrix>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Ashish Chavan <ashish.chavan@kpitcummins.com>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On Thu, Jun 30, 2011 at 06:16:30PM +0530, Ashish Chavan wrote:

Please fix your mailer to word wrap at less than 80 columns so your mail
is legible.

> Our final goal is to pull in all missing features from this custom
> driver in to existing mainline driver. I have already created few
> patches for basic functions but I am bit confused at one point. Some
> of the features supported by this codec have inter dependency, e.g.
> ALC can be used only if NOISE SUPRESSION is disabled.  So ideally, all
> controls related to ALC should be either disabled or not added at all,
> if NOISE SUPRESSION to be used. There are few other features having
> similar kind of dependency.

You'd need to implement custom controls for the relevant enables which
check to see what is currently enabled and prevents enables if there
are conflicts.  You should do this dynamically and I'd expect that only
the enables actually need to check anything, adjusting parameters for
things that aren't active is usually no problem.

> I just want to know what is the correct way to handle this in ASoC
> codec driver?  Looking at the existing codec drivers, it seems that
> having conditional defines is not common here. As We just want to
> support static configuration of such features, is it a good idea to
> add sub menu options in driver's Kconfig to enable/disable such
> features and use them within code?

Compile time selection is completely uinacceptable for Linux in general,
please see the coding style and development model stuff in Documentation
for discussion of the motivations for this.
