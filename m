From: Liam Girdwood <lrg@slimlogic.co.uk>
Subject: Re: [PATCHv2 3/3] ASoC: tlv320aic3x: Complete the
 soc-cache conversion
Date: Wed, 15 Sep 2010 13:57:37 +0100
Message-ID: <1284555457.10618.84.camel@vega>
References: <20100914125510.GA21715@rakim.wolfsonmicro.main>
	<1284472787-9881-1-git-send-email-jhnikula@gmail.com>
	<20100914150855.GA25070@rakim.wolfsonmicro.main>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-vw0-f51.google.com (mail-vw0-f51.google.com
	[209.85.212.51])
	by alsa0.perex.cz (Postfix) with ESMTP id 9FD7B1037E3
	for <alsa-devel@alsa-project.org>;
	Wed, 15 Sep 2010 14:57:46 +0200 (CEST)
Received: by vws20 with SMTP id 20so120841vws.38
	for <alsa-devel@alsa-project.org>; Wed, 15 Sep 2010 05:57:45 -0700 (PDT)
In-Reply-To: <20100914150855.GA25070@rakim.wolfsonmicro.main>
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

On Tue, 2010-09-14 at 16:08 +0100, Mark Brown wrote:
> On Tue, Sep 14, 2010 at 04:59:47PM +0300, Jarkko Nikula wrote:
> > Complete the phasing out of aic3x_read_reg_cache, aic3x_write_reg_cache,
> > aic3x_read and aic3x_write calls.
> > 
> > This patch uses in aic3x_read the codec->hw_read that points to a function
> > implemented by soc-cache. Only use for aic3x_read is if wanting to read
> > volatile bits from those registers that has both read-only and read/write
> > bits. All other cases should use snd_soc_read.
> > 
> > Signed-off-by: Jarkko Nikula <jhnikula@gmail.com>
> 
> Acked-by: Mark Brown <broonie@opensource.wolfsonmicro.com>

All applied.

Thanks

Liam

-- 
Freelance Developer, SlimLogic Ltd
ASoC and Voltage Regulator Maintainer.
http://www.slimlogic.co.uk
