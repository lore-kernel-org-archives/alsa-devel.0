From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH] ASoC: core: Configure pin muxing via
 pinctrl when registering a DAI
Date: Sat, 22 Sep 2012 11:23:09 -0400
Message-ID: <20120922152309.GL4495@opensource.wolfsonmicro.com>
References: <1348214066-28384-1-git-send-email-peter.ujfalusi@ti.com>
 <20120921111352.GA21524@opensource.wolfsonmicro.com>
 <505C68AA.7080907@ti.com> <505C7FCF.1050509@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource.wolfsonmicro.com (opensource.wolfsonmicro.com
 [80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id A3C25261651
 for <alsa-devel@alsa-project.org>; Sat, 22 Sep 2012 17:23:11 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <505C7FCF.1050509@ti.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Peter Ujfalusi <peter.ujfalusi@ti.com>
Cc: alsa-devel@alsa-project.org, Liam Girdwood <lrg@ti.com>
List-Id: alsa-devel@alsa-project.org

On Fri, Sep 21, 2012 at 05:55:11PM +0300, Peter Ujfalusi wrote:

You're doing the odd word wrapping here too and it's not a commit
message...

> If we are going to do the pinctrl mux configuration in core we should also
> consider the machine driver as well.
> But they tend to request the needed GPIOs in their probe before registering
> the card.
> Same can be true for codec drivers where they might need the mux configured
> before they request the GPIOs  they need.

I would really expect that the GPIO drivers would do the pinmuxing in
the same way that other drivers do.
