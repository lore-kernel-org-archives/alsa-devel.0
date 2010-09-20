From: Liam Girdwood <lrg@slimlogic.co.uk>
Subject: Re: [PATCHv2 1/4] ASoC: tlv320aic3x: Move regulator
 management from i2c to soc domain
Date: Mon, 20 Sep 2010 18:41:42 +0100
Message-ID: <1285004502.3048.83.camel@odin>
References: <1284968354-12536-1-git-send-email-jhnikula@gmail.com>
	<1284968354-12536-2-git-send-email-jhnikula@gmail.com>
	<20100920092637.GA31167@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-wy0-f179.google.com (mail-wy0-f179.google.com
	[74.125.82.179]) by alsa0.perex.cz (Postfix) with ESMTP id E486C24506
	for <alsa-devel@alsa-project.org>;
	Mon, 20 Sep 2010 19:41:45 +0200 (CEST)
Received: by wyb32 with SMTP id 32so4471277wyb.38
	for <alsa-devel@alsa-project.org>; Mon, 20 Sep 2010 10:41:45 -0700 (PDT)
In-Reply-To: <20100920092637.GA31167@sirena.org.uk>
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

On Mon, 2010-09-20 at 10:26 +0100, Mark Brown wrote:
> On Mon, Sep 20, 2010 at 10:39:11AM +0300, Jarkko Nikula wrote:
> > It will be easier to keep regulator enable/disable calls in sync when dynamic
> > regulator management is added if regulator management is moved from
> > aic3x_i2c_probe/_remove to aic3x_probe/_remove.
> > 
> > Signed-off-by: Jarkko Nikula <jhnikula@gmail.com>
> 
> Acked-by: Mark Brown <broonie@opensource.wolfsonmicro.com>

All Applied.

Thanks

Liam
-- 
Freelance Developer, SlimLogic Ltd
ASoC and Voltage Regulator Maintainer.
http://www.slimlogic.co.uk
