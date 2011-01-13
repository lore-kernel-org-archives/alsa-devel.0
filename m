From: Liam Girdwood <lrg@slimlogic.co.uk>
Subject: Re: [PATCH] ASoC: Blackfin: fix DAI/SPORT config
 dependency issues
Date: Thu, 13 Jan 2011 13:57:12 +0000
Message-ID: <1294927032.3453.10.camel@odin>
References: <1294794268-18416-1-git-send-email-vapier@gentoo.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-ww0-f51.google.com (mail-ww0-f51.google.com [74.125.82.51])
	by alsa0.perex.cz (Postfix) with ESMTP id 68697103AF8
	for <alsa-devel@alsa-project.org>; Thu, 13 Jan 2011 14:57:16 +0100 (CET)
Received: by wwe15 with SMTP id 15so1775395wwe.20
	for <alsa-devel@alsa-project.org>; Thu, 13 Jan 2011 05:57:16 -0800 (PST)
In-Reply-To: <1294794268-18416-1-git-send-email-vapier@gentoo.org>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Mike Frysinger <vapier@gentoo.org>
Cc: uclinux-dist-devel@blackfin.uclinux.org, alsa-devel@alsa-project.org, Mark Brown <broonie@opensource.wolfsonmicro.com>, Barry Song <barry.song@analog.com>
List-Id: alsa-devel@alsa-project.org

On Tue, 2011-01-11 at 20:04 -0500, Mike Frysinger wrote:
> From: Barry Song <barry.song@analog.com>
> 
> While I2S/TDM/AC97 DAI is built-in, others are compiled as modules,
> SND_BF5XX_SOC_SPORT will be module, then DAI can't get some symbols.
> Except that, SND_BF5XX_AC97 depends on SND_BF5XX_SOC_AC97 too.
> 
> Signed-off-by: Barry Song <barry.song@analog.com>
> Signed-off-by: Mike Frysinger <vapier@gentoo.org>
Acked-by: Liam Girdwood <lrg@slimlogic.co.uk>
-- 
Freelance Developer, SlimLogic Ltd
ASoC and Voltage Regulator Maintainer.
http://www.slimlogic.co.uk
