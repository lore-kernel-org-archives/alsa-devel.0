From: Liam Girdwood <lrg@slimlogic.co.uk>
Subject: Re: [PATCH] ASoC: omap: rx51: Use
 gpio_set_value_cansleep for speaker amp control
Date: Mon, 23 Aug 2010 12:06:08 +0100
Message-ID: <1282561568.3053.28.camel@odin>
References: <1282549001-10391-1-git-send-email-jhnikula@gmail.com>
	<20100823095816.GB6061@rakim.wolfsonmicro.main>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-ww0-f51.google.com (mail-ww0-f51.google.com [74.125.82.51])
	by alsa0.perex.cz (Postfix) with ESMTP id 84FBB24501
	for <alsa-devel@alsa-project.org>;
	Mon, 23 Aug 2010 13:06:12 +0200 (CEST)
Received: by wwb17 with SMTP id 17so66369wwb.20
	for <alsa-devel@alsa-project.org>; Mon, 23 Aug 2010 04:06:12 -0700 (PDT)
In-Reply-To: <20100823095816.GB6061@rakim.wolfsonmicro.main>
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

On Mon, 2010-08-23 at 10:58 +0100, Mark Brown wrote:
> On Mon, Aug 23, 2010 at 10:36:41AM +0300, Jarkko Nikula wrote:
> > Speaker amplifier is controlled by TWL4030 GPIO which may sleep. Therefore
> > use gpio_set_value_cansleep to get rid of runtime warning that is introduced
> > after the commit 9c4ba94 and to get a stack trace if ever executing this
> > code in atomic context.
> > 
> > Signed-off-by: Jarkko Nikula <jhnikula@gmail.com>
> 
> Acked-by: Mark Brown <broonie@opensource.wolfsonmicro.com>

All 3 applied.

Thanks

Liam
-- 
Freelance Developer, SlimLogic Ltd
ASoC and Voltage Regulator Maintainer.
http://www.slimlogic.co.uk
