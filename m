From: Liam Girdwood <lrg@ti.com>
Subject: Re: [PATCH] ASoC: dapm: Check for bias level when
	powering down
Date: Thu, 23 Feb 2012 08:30:15 +0000
Message-ID: <1329985815.3740.0.camel@odin>
References: <1329926079-22981-1-git-send-email-broonie@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from na3sys009aog125.obsmtp.com (na3sys009aog125.obsmtp.com
	[74.125.149.153])
	by alsa0.perex.cz (Postfix) with ESMTP id 6B4512414B
	for <alsa-devel@alsa-project.org>; Thu, 23 Feb 2012 09:30:30 +0100 (CET)
Received: by mail-ww0-f53.google.com with SMTP id dr12so793063wgb.10
	for <alsa-devel@alsa-project.org>; Thu, 23 Feb 2012 00:30:17 -0800 (PST)
In-Reply-To: <1329926079-22981-1-git-send-email-broonie@opensource.wolfsonmicro.com>
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
Cc: alsa-devel@alsa-project.org, patches@opensource.wolfsonmicro.com
List-Id: alsa-devel@alsa-project.org

On Wed, 2012-02-22 at 15:54 +0000, Mark Brown wrote:
> Recent enhancements in the bias management means that we might not be
> in standby when the CODEC is idle and can have active widgets without
> being in full power mode but the shutdown functionality assumes these
> things. Add checks for the bias level at each stage so that we don't
> do transitions other than the ON->PREPARE->STANDBY->OFF ones that the
> drivers are expecting.
> 
> Signed-off-by: Mark Brown <broonie@opensource.wolfsonmicro.com>
> ---
Acked-by: Liam Girdwood <lrg@ti.com>
