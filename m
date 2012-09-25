From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH] ASoC: core: Configure pin muxing via
 pinctrl when registering a DAI
Date: Tue, 25 Sep 2012 12:22:31 +0100
Message-ID: <20120925112231.GD4428@opensource.wolfsonmicro.com>
References: <1348214066-28384-1-git-send-email-peter.ujfalusi@ti.com>
 <20120921111352.GA21524@opensource.wolfsonmicro.com>
 <505C68AA.7080907@ti.com> <505C9496.1050307@wwwdotorg.org>
 <20120922152840.GM4495@opensource.wolfsonmicro.com>
 <505E80AD.9050000@wwwdotorg.org>
 <CACRpkdbewb0SVYJoT9O4PAajFWny+YOcmf2CLUKL1NzxGWoa5A@mail.gmail.com>
 <20120924101757.GC21375@opensource.wolfsonmicro.com>
 <50607F22.4070903@wwwdotorg.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource.wolfsonmicro.com (opensource.wolfsonmicro.com
 [80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id BB66E2616BA
 for <alsa-devel@alsa-project.org>; Tue, 25 Sep 2012 13:22:32 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <50607F22.4070903@wwwdotorg.org>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Stephen Warren <swarren@wwwdotorg.org>
Cc: Peter Ujfalusi <peter.ujfalusi@ti.com>, Linus Walleij <linus.walleij@linaro.org>, alsa-devel@alsa-project.org, Liam Girdwood <lrg@ti.com>
List-Id: alsa-devel@alsa-project.org

On Mon, Sep 24, 2012 at 09:41:22AM -0600, Stephen Warren wrote:

> But I still find it unlikely that this situation will occur; surely
> there's some specific reason directly related to the device itself, or
> the protocol it implements, that defines whether it needs dynamic
> pinctrl, and hence no matter what SoC that device is inserted into, it
> will either need or not-need dynamic pinctrl. Are there any extant
> examples to refute this?

Linus' example of adjusting the pinctrl state to relax power usage is an
obvious one, and one that should be implementable on almost any system.
It's really a function of the SoC integration rather than of the device
itself (the IP isn't accomplishing anything for itself, it's allowing
the SoC to save some power when it doesn't need to do anything with the
hardware.  Essentially any IP could implement this, but the gains from
doing it are likely to vary with SoC.
