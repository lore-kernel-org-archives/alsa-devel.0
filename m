From: Liam Girdwood <lrg@ti.com>
Subject: Re: [PATCH] ASoC: dapm: Only lock CODEC for I/O if not
	using regmap
Date: Wed, 07 Mar 2012 11:47:20 +0000
Message-ID: <1331120840.3829.19.camel@odin>
References: <1331078595-6210-1-git-send-email-broonie@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from na3sys009aog116.obsmtp.com (na3sys009aog116.obsmtp.com
	[74.125.149.240])
	by alsa0.perex.cz (Postfix) with ESMTP id E1A1D244BB
	for <alsa-devel@alsa-project.org>; Wed,  7 Mar 2012 12:47:25 +0100 (CET)
Received: by mail-we0-f171.google.com with SMTP id m1so4703791wer.30
	for <alsa-devel@alsa-project.org>; Wed, 07 Mar 2012 03:47:22 -0800 (PST)
In-Reply-To: <1331078595-6210-1-git-send-email-broonie@opensource.wolfsonmicro.com>
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

On Wed, 2012-03-07 at 00:03 +0000, Mark Brown wrote:
> If we do use regmap then regmap will take care of things for us. We
> actually already have this check at a higher level for the current
> users but this makes sure we do the right thing in the future too if
> we need to.
> 
> Signed-off-by: Mark Brown <broonie@opensource.wolfsonmicro.com>

Acked-by: Liam Girdwood <lrg@ti.com>
