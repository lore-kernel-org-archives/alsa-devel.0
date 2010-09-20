From: Liam Girdwood <lrg@slimlogic.co.uk>
Subject: Re: [PATCH] ASoC: tlv320aic3x: Add virtual output pin
 Detection
Date: Mon, 20 Sep 2010 09:53:58 +0100
Message-ID: <1284972838.3403.21.camel@odin>
References: <1284723541-21813-1-git-send-email-jhnikula@gmail.com>
	<20100917130011.GH4322@rakim.wolfsonmicro.main>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-ww0-f51.google.com (mail-ww0-f51.google.com [74.125.82.51])
	by alsa0.perex.cz (Postfix) with ESMTP id 9F112103823
	for <alsa-devel@alsa-project.org>;
	Mon, 20 Sep 2010 10:54:01 +0200 (CEST)
Received: by wwb28 with SMTP id 28so4039101wwb.20
	for <alsa-devel@alsa-project.org>; Mon, 20 Sep 2010 01:54:01 -0700 (PDT)
In-Reply-To: <20100917130011.GH4322@rakim.wolfsonmicro.main>
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
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On Fri, 2010-09-17 at 14:00 +0100, Mark Brown wrote:
> On Fri, Sep 17, 2010 at 02:39:01PM +0300, Jarkko Nikula wrote:
> > Purpose of this virtual Detection pin is to keep codec bias on whenever the
> > GPIO or jack detection features are needed.
> > 
> > Jack detection needs a mic bias so machine drivers can construct a following
> > route for instance for keeping the path and codec bias on:
> 
> > "Input Jack" -> "Mic Bias xV" -> "Detection" -> detection block inside codec.
> 
> > For the GPIO the machine driver can force the pin on with
> > snd_soc_dapm_force_enable_pin.
> 
> > Signed-off-by: Jarkko Nikula <jhnikula@gmail.com>
> 
> Acked-by: Mark Brown <broonie@opensource.wolfsonmicro.com>

Applied.

Thanks

Liam
-- 
Freelance Developer, SlimLogic Ltd
ASoC and Voltage Regulator Maintainer.
http://www.slimlogic.co.uk
