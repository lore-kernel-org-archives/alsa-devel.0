From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH] Add initial support of Mitac
	mioa701	device SoC.
Date: Wed, 9 Jul 2008 21:30:09 +0100
Message-ID: <20080709203008.GA19229@opensource.wolfsonmicro.com>
References: <87vdzgp0ue.fsf@free.fr>
	<1215549906-14829-1-git-send-email-robert.jarzmik@free.fr>
	<1215601156.4882.256.camel@localhost.localdomain>
	<87skuihmt2.fsf@free.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 9C0F324445
	for <alsa-devel@alsa-project.org>;
	Wed,  9 Jul 2008 22:30:09 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <87skuihmt2.fsf@free.fr>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Robert Jarzmik <robert.jarzmik@free.fr>
Cc: Liam Girdwood <liam.girdwood@wolfsonmicro.com>, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On Wed, Jul 09, 2008 at 09:36:41PM +0200, Robert Jarzmik wrote:

> After a second thought, I don't think I can. The AC97 link is needed to for the
> touchscreen and battery level calculation (ADC1). So I don't think we can
> shutdown the link.

Have you checked that this currently works?  The AC97 bus should be
unregistered when the audio device is unregistered.  I have to confess
that I haven't tested this in v2 but it is the intended behaviour - the
AC97 controller is provided by the ASoC drivers so when it is stopped
the link should be unregistered.
