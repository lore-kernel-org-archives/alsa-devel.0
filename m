From: Liam Girdwood <lrg@slimlogic.co.uk>
Subject: Re: ASoC: multi-component updates from RFC
Date: Thu, 22 Jul 2010 14:07:24 +0100
Message-ID: <1279804044.3083.49.camel@odin>
References: <1279715490.3072.51.camel@odin>
	<201007220927.16738.peter.ujfalusi@nokia.com>
	<1279786704.3083.22.camel@odin>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-wy0-f179.google.com (mail-wy0-f179.google.com
	[74.125.82.179]) by alsa0.perex.cz (Postfix) with ESMTP id 7E27624457
	for <alsa-devel@alsa-project.org>;
	Thu, 22 Jul 2010 15:07:28 +0200 (CEST)
Received: by wyb42 with SMTP id 42so540949wyb.38
	for <alsa-devel@alsa-project.org>; Thu, 22 Jul 2010 06:07:28 -0700 (PDT)
In-Reply-To: <1279786704.3083.22.camel@odin>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Peter Ujfalusi <peter.ujfalusi@nokia.com>
Cc: alsa-devel@alsa-project.org, Mark Brown <broonie@opensource.wolfsonmicro.com>
List-Id: alsa-devel@alsa-project.org

On Thu, 2010-07-22 at 09:18 +0100, Liam Girdwood wrote:
> On Thu, 2010-07-22 at 09:27 +0300, Peter Ujfalusi wrote:

> > The name for the drivers/mfd/twl4030-codec.c is chosen, because the TRM refers 
> > to this block as codec (audio + vibra).
> > We could go, and rename however this mfd driver to twl4030-audio (since the TRM 
> > randomly refers to audio block instead of codec).
> > Than we can have twl4030-codec as device name for the soc codec, and twl4030-
> > vibra for the vibra.
> > 
> 
> Agreed, I'll make that change.

Pushed to git. I also fixed a naming bug in the mcbsp DAI devices too.

Liam

-- 
Freelance Developer, SlimLogic Ltd
ASoC and Voltage Regulator Maintainer.
http://www.slimlogic.co.uk
