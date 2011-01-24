From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH] SoC: Samsung: Fix outdated cpu_dai_name
	for s3c24xx i2s
Date: Mon, 24 Jan 2011 12:07:45 +0000
Message-ID: <20110124120744.GC29925@opensource.wolfsonmicro.com>
References: <1295735888-25527-1-git-send-email-lars@metafoo.de>
	<1295735888-25527-2-git-send-email-lars@metafoo.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id ADA4924479
	for <alsa-devel@alsa-project.org>; Mon, 24 Jan 2011 13:07:47 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <1295735888-25527-2-git-send-email-lars@metafoo.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Lars-Peter Clausen <lars@metafoo.de>
Cc: "for 2.6.37" <stable@kernel.org>, alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org, Liam Girdwood <lrg@slimlogic.co.uk>
List-Id: alsa-devel@alsa-project.org

On Sat, Jan 22, 2011 at 11:38:08PM +0100, Lars-Peter Clausen wrote:
> During the multi-component patch the s3c24xx i2s driver was renamed from
> "s3c24xx-i2s" to "s3c24xx-iis", while the sound board drivers were not
> updated to reflect this change as well.
> 
> As a result there is no match between the dai_link and the i2s driver and no
> sound card is instantiated.
> 
> This patch fixes the problem by updating the sound board drivers to use
> "s3c24xx-iis" for the cpu_dai_name.

This patch doesn't apply, git am says:

Applying: SoC: Samsung: Fix outdated cpu_dai_name for s3c24xx i2s
error: patch failed: sound/soc/samsung/neo1973_wm8753.c:559
error: sound/soc/samsung/neo1973_wm8753.c: patch does not apply
error: patch failed: sound/soc/samsung/s3c24xx_simtec_hermes.c:85
error: sound/soc/samsung/s3c24xx_simtec_hermes.c: patch does not apply
error: patch failed: sound/soc/samsung/s3c24xx_simtec_tlv320aic23.c:74
error: sound/soc/samsung/s3c24xx_simtec_tlv320aic23.c: patch does not apply
Patch failed at 0001 SoC: Samsung: Fix outdated cpu_dai_name for s3c24xx i2s

Please submit fixes against the current fix branch, currently 2.6.38.
