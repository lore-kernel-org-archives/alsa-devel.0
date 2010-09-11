From: Liam Girdwood <lrg@slimlogic.co.uk>
Subject: Re: [PATCH 1/4] ASoC: tlv320aic3x: Optimize PLL
 programming in aic3x_set_bias_level
Date: Sat, 11 Sep 2010 09:04:56 +0100
Message-ID: <1284192296.3409.2.camel@odin>
References: <1284117812-8618-1-git-send-email-jhnikula@gmail.com>
	<20100910113650.GE7259@rakim.wolfsonmicro.main>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-wy0-f179.google.com (mail-wy0-f179.google.com
	[74.125.82.179]) by alsa0.perex.cz (Postfix) with ESMTP id 83E5F244DE
	for <alsa-devel@alsa-project.org>;
	Sat, 11 Sep 2010 10:05:00 +0200 (CEST)
Received: by mail-wy0-f179.google.com with SMTP id 32so3691386wyb.38
	for <alsa-devel@alsa-project.org>; Sat, 11 Sep 2010 01:05:00 -0700 (PDT)
In-Reply-To: <20100910113650.GE7259@rakim.wolfsonmicro.main>
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

On Fri, 2010-09-10 at 12:36 +0100, Mark Brown wrote:
> On Fri, Sep 10, 2010 at 02:23:29PM +0300, Jarkko Nikula wrote:
> > There is only need to enable/disable once the PLL when the bias is going
> > between on, prepare, standby and off states.
> 
> Acked-by: Mark Brown <broonie@opensource.wolfsonmicro.com>

Applied.

Thanks

Liam
-- 
Freelance Developer, SlimLogic Ltd
ASoC and Voltage Regulator Maintainer.
http://www.slimlogic.co.uk
