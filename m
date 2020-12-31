Return-Path: <SRS0=gM+V=GD=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 89106C433E0
	for <alsa-devel@archiver.kernel.org>; Thu, 31 Dec 2020 13:29:55 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 28753223E8
	for <alsa-devel@archiver.kernel.org>; Thu, 31 Dec 2020 13:29:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 28753223E8
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 6D48E16EE;
	Thu, 31 Dec 2020 14:29:00 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 6D48E16EE
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1609421390;
	bh=K56VJyy27x0kGr4SNtwCRlFlFSdH8USKotViNClcc8s=;
	h=From:To:In-Reply-To:References:Subject:Date:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=kDnmGdS793AnHe95n77X6V/AJT71FXzNr6ucoBRBx/A/K3x9zLIbv6rFym8LgdEuH
	 Mm8XLUKomurUL9lwiXhz2VQuOobKwblxOJsJunbkft7Ss4j8zq9kFFwMUSkwdE7hGH
	 +paItKm37ysHLZ20+JhUOXUh+h3CqglqhxAIrLFU=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id CF8A1F80129;
	Thu, 31 Dec 2020 14:28:59 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 0E961F8022B; Thu, 31 Dec 2020 14:28:57 +0100 (CET)
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 7E36EF80129
 for <alsa-devel@alsa-project.org>; Thu, 31 Dec 2020 14:28:54 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 7E36EF80129
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org
 header.b="P3AvGcGR"
Received: by mail.kernel.org (Postfix) with ESMTPSA id 309CE223E0;
 Thu, 31 Dec 2020 13:28:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1609421332;
 bh=K56VJyy27x0kGr4SNtwCRlFlFSdH8USKotViNClcc8s=;
 h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
 b=P3AvGcGR0QvXm9N/JFSFfPexBrn4t4zGYbbibSrhJ1N3C9Jw7JmHB1JptbONJKUGb
 gFzzWqvc68i/mbItQTs/vqisNp1oaTflQQAl/jZ/Q0Fmlu25EAPuWMx6mdyDynTo7V
 idb9sFcQ+xZlgs/FjYdzaWzKKL/IetF1tLyzQRI9h/5Fei+/yxio/ggjRs2K/8jR5D
 aOFYwp5XX0fW/E7Ub3XL/ddbmIYn6kFQOBfvtfNW5iCKZyBagpjNaWdIbRD2OkrKye
 94i0Nn5Hs6h4FshBOIMkAZpAwFRyQY7wl6VE9uFwmjSOtUroHKpdh3zF/sWe4bNXrs
 eOnGzyNMqZsiA==
From: Mark Brown <broonie@kernel.org>
To: Liam Girdwood <lgirdwood@gmail.com>,
 Matthias Brugger <matthias.bgg@gmail.com>, Arnd Bergmann <arnd@kernel.org>
In-Reply-To: <20201230154345.639122-1-arnd@kernel.org>
References: <20201230154345.639122-1-arnd@kernel.org>
Subject: Re: [PATCH] ASoC: mediatek: add MTK_PMIC_WRAP dependency
Message-Id: <160942130384.56416.5738350943602041009.b4-ty@kernel.org>
Date: Thu, 31 Dec 2020 13:28:23 +0000
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Cc: alsa-devel@alsa-project.org, Arnd Bergmann <arnd@arndb.de>,
 Takashi Iwai <tiwai@suse.com>, Jiaxin Yu <jiaxin.yu@mediatek.com>,
 linux-kernel@vger.kernel.org, Tzung-Bi Shih <tzungbi@google.com>,
 linux-mediatek@lists.infradead.org, linux-arm-kernel@lists.infradead.org
X-BeenThere: alsa-devel@alsa-project.org
X-Mailman-Version: 2.1.15
Precedence: list
List-Id: "Alsa-devel mailing list for ALSA developers -
 http://www.alsa-project.org" <alsa-devel.alsa-project.org>
List-Unsubscribe: <https://mailman.alsa-project.org/mailman/options/alsa-devel>, 
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <https://mailman.alsa-project.org/mailman/listinfo/alsa-devel>, 
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: "Alsa-devel" <alsa-devel-bounces@alsa-project.org>

On Wed, 30 Dec 2020 16:43:34 +0100, Arnd Bergmann wrote:
> Randconfig builds often show harmless warnings like
> 
> WARNING: unmet direct dependencies detected for SND_SOC_MT6359
>   Depends on [n]: SOUND [=y] && !UML && SND [=y] && SND_SOC [=y] && MTK_PMIC_WRAP [=n]
>   Selected by [y]:
>   - SND_SOC_MT8192_MT6359_RT1015_RT5682 [=y] && SOUND [=y] && !UML && SND [=y] && SND_SOC [=y] && I2C [=y] && SND_SOC_MT8192 [=y]
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/1] ASoC: mediatek: add MTK_PMIC_WRAP dependency
      commit: c1cbbea9c4db41eb69a831d8b07da52e05b1d1e8

All being well this means that it will be integrated into the linux-next
tree (usually sometime in the next 24 hours) and sent to Linus during
the next merge window (or sooner if it is a bug fix), however if
problems are discovered then the patch may be dropped or reverted.

You may get further e-mails resulting from automated or manual testing
and review of the tree, please engage with people reporting problems and
send followup patches addressing any issues that are reported if needed.

If any updates are required or you are submitting further changes they
should be sent as incremental updates against current git, existing
patches will not be replaced.

Please add any relevant lists and maintainers to the CCs when replying
to this mail.

Thanks,
Mark
