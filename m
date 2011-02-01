From: Liam Girdwood <lrg@slimlogic.co.uk>
Subject: Re: [Resend] [PATCH] ASoC: Amstrad Delta: fix const
 related build error
Date: Tue, 01 Feb 2011 14:02:24 +0000
Message-ID: <1296568944.3327.15.camel@odin>
References: <201102011038.29330.jkrzyszt@tis.icnet.pl>
	<201102011111.56190.jkrzyszt@tis.icnet.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-ww0-f51.google.com (mail-ww0-f51.google.com [74.125.82.51])
	by alsa0.perex.cz (Postfix) with ESMTP id 2087024524
	for <alsa-devel@alsa-project.org>; Tue,  1 Feb 2011 15:02:28 +0100 (CET)
Received: by wwe15 with SMTP id 15so6794671wwe.20
	for <alsa-devel@alsa-project.org>; Tue, 01 Feb 2011 06:02:27 -0800 (PST)
In-Reply-To: <201102011111.56190.jkrzyszt@tis.icnet.pl>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Janusz Krzysztofik <jkrzyszt@tis.icnet.pl>
Cc: alsa-devel@alsa-project.org, Mark Brown <broonie@opensource.wolfsonmicro.com>
List-Id: alsa-devel@alsa-project.org

On Tue, 2011-02-01 at 11:11 +0100, Janusz Krzysztofik wrote:
> The Amstrad Delta ASoC driver used to override the digital_mute() 
> callback, expected to be not provided by the on-board CX20442 CODEC 
> driver, with its own implementation. While this is still posssible when 
> substituting the whole empty snd_soc_dai_driver.ops member (the CX20442 
> case), replacing snd_soc_dai_ops.digital_mute only is no longer correct 
> after the snd_soc_dai_driver.ops member has been constified, and results 
> in build error.
> 
> Drop this actually not used code path in hope the CX20442 driver never 
> provides its own snd_soc_dai_ops structure.
> 
> Created and tested against linux-2.6.38-rc2
> 
> Signed-off-by: Janusz Krzysztofik <jkrzyszt@tis.icnet.pl>
> ---
> Resending because of line wrap, sorry.
> Please consider queuing this patch for the current rc cycle.
> 

Acked-by: Liam Girdwood <lrg@slimlogic.co.uk>
-- 
Freelance Developer, SlimLogic Ltd
ASoC and Voltage Regulator Maintainer.
http://www.slimlogic.co.uk
