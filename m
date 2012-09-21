From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH] ASoC: core: Configure pin muxing via
 pinctrl when registering a DAI
Date: Fri, 21 Sep 2012 07:13:53 -0400
Message-ID: <20120921111352.GA21524@opensource.wolfsonmicro.com>
References: <1348214066-28384-1-git-send-email-peter.ujfalusi@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource.wolfsonmicro.com (opensource.wolfsonmicro.com
 [80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 771192615D0
 for <alsa-devel@alsa-project.org>; Fri, 21 Sep 2012 13:21:42 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <1348214066-28384-1-git-send-email-peter.ujfalusi@ti.com>
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

On Fri, Sep 21, 2012 at 10:54:26AM +0300, Peter Ujfalusi wrote:
> pinctrl framework now becoming widely available for SoCs to configure pin
> multiplexing.
> Instead of adding the same code to all dai drivers the core can take care
> of this transparently.
> Do not make too much noise if pinctrl is not provided via DT for the dai
> but just use dev_info().

Please fix your word wrapping, I've mentioned this to you before...

> +/*
> + * Simple function to be used in snd_soc_dai_register_dai/s to set the default
> + * pinmuxing for the dai.

I would be more inclined to do this on card init time, doing it at
registration seems wrong as systems typically have interfaces that
aren't used and share pins with other functions.  By the time we are
setting up a card we've got a good idea we actually want to use the IP
but at probe time that's not the case.

It also seems bad that we're ignoring errors, does the pinctl API not
stub itself out well enough.
