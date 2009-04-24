From: Daniel Mack <daniel@caiaq.de>
Subject: Re: [PATCH 1/3] ASoC: cs4270: fix Master Capture
	Switch polarity
Date: Fri, 24 Apr 2009 18:21:26 +0200
Message-ID: <20090424162126.GB10885@buzzloop.caiaq.de>
References: <1240578026-1987-1-git-send-email-daniel@caiaq.de>
	<49F1DE99.7050104@freescale.com>
	<20090424160807.GI10450@buzzloop.caiaq.de>
	<49F1E514.9040204@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from buzzloop.caiaq.de (buzzloop.caiaq.de [212.112.241.133])
	by alsa0.perex.cz (Postfix) with ESMTP id 68342243CB
	for <alsa-devel@alsa-project.org>;
	Fri, 24 Apr 2009 18:21:29 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <49F1E514.9040204@freescale.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Timur Tabi <timur@freescale.com>
Cc: alsa-devel@alsa-project.org, Mark Brown <broonie@sirena.org.uk>
List-Id: alsa-devel@alsa-project.org

On Fri, Apr 24, 2009 at 11:13:08AM -0500, Timur Tabi wrote:
> > The switch's name is 'Master Capture Switch' which means to me that it
> > is a thing that switches the capture on and off, and hence, it should be
> > set to 'on' for normal operation. If it was meant to mute the input
> > when switched on, the name should be 'Master Caputure Mute Switch' or
> > something, right?
> 
> Beats me.  I'm the one asking questions! 

:)

> But you still haven't told me
> the difference between "------" and "L    R".  Does "------" mean that
> capture should be muted, because it's been switched off?

Sorry, don't know. amixer is my reference and in the high-level software
using that interface, things are implemented similarly. All I can say is
that the control does not expose any information about whether it's high
or low active, so all that needs to be taken care for is that name and
function match.

Daniel
