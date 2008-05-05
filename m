From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: SoC sound support for imx27
Date: Mon, 5 May 2008 13:42:35 +0100
Message-ID: <20080505124233.GE3426@sirena.org.uk>
References: <200804231654.44526.jbe@pengutronix.de>
	<200804241611.21072.jbe@pengutronix.de>
	<1209047409.3286.111.camel@localhost.localdomain>
	<200805051256.38153.jbe@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
	by alsa0.perex.cz (Postfix) with ESMTP id C75EC243CB
	for <alsa-devel@alsa-project.org>;
	Mon,  5 May 2008 14:42:35 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <200805051256.38153.jbe@pengutronix.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Juergen Beisert <jbe@pengutronix.de>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On Mon, May 05, 2008 at 12:56:37PM +0200, Juergen Beisert wrote:

> Hmm, I did a deeper look into this code. Why - for example - does the file 
> mx31ads-wm8753.c does the job of the BSP file? Why it registers devices? For 
> my board I want to register platform_devices only in 
> arc/arm/mach-mx2/pcm038.c. Nowhere else. If there is some glue required to 
> bring components together, IMHO also arc/arm/mach-mx2/pcm038.c is the correct 
> place to do so. Why you did it in sound/ ? If you do it in sound/ , you 
> always need two locations to maintain. On in the arch/, one in sound/ .

The model which the existing ASoC platform code is using is that the
sound subsystem of the device is frequently involved enough to justify
thinking of it as a discrete "sound card", even if physically it is part
of the same board.  This is partly inherited from ASoC v1 where the way
things are registered is less than ideal (it doesn't use the device
model) and partly due to the fact that some machine definitions can get
fairly large, especially with more complex board designs.

That said, you don't need to do things this way, especially with ASoC v2
where even if you do separate out the machine driver you can still
register everything in your architecture code including a platform
device for the machine driver.
