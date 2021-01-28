Return-Path: <SRS0=P7Dr=G7=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9ACC5C433E0
	for <alsa-devel@archiver.kernel.org>; Thu, 28 Jan 2021 20:57:46 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E137264DD6
	for <alsa-devel@archiver.kernel.org>; Thu, 28 Jan 2021 20:57:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E137264DD6
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 6E0D916D0;
	Thu, 28 Jan 2021 21:56:54 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 6E0D916D0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1611867464;
	bh=jkweb2pifxzJp7sxiZtI+a9pMzcdV4TWy+OrK9mpB+s=;
	h=From:To:In-Reply-To:References:Subject:Date:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=G5rJTzLkmrmjmwmZYdt1GyD+BYXy28ASys75p2lkcs2sBJs1ziv/LwqcW9ZBlaq/i
	 ew4di7SHL6V24yomeYNm40HS7rwQeRwES6580HrbiJ3JNDY+J2KoWgITpz2xD35021
	 N9KLHLVqZv6RIAA5wtrH/Bcb9TI7Kgw5bmU52fac=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 2EDDCF804E3;
	Thu, 28 Jan 2021 21:55:43 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 88F64F804E4; Thu, 28 Jan 2021 21:55:41 +0100 (CET)
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 2AEACF804D8
 for <alsa-devel@alsa-project.org>; Thu, 28 Jan 2021 21:55:39 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 2AEACF804D8
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org
 header.b="RAISmF8u"
Received: by mail.kernel.org (Postfix) with ESMTPSA id F3AED64DE6;
 Thu, 28 Jan 2021 20:55:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1611867337;
 bh=jkweb2pifxzJp7sxiZtI+a9pMzcdV4TWy+OrK9mpB+s=;
 h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
 b=RAISmF8uxQBlSMPz2frkN9fJy7JnEbtczh7+3ZYhkUcl/K3/3/GBeXJYr+OqGL+DN
 G9VyoTdG9Bxo6JZgwKzAqpWn27MDhNPAXwYfLQo/FQ0ITticnmZrVZQ9ge2pr59GcG
 +HPMP2RhkFxgtdJGZ5pqcNreN3hZKqJpgHeVmDuqzwVDYdB54885yLGLNxWVmCBj2K
 zs4zn5n3eCxLcAUL8G1yNhqdygahBy9vwd35U3GqWUC/9dZQyHcyONdk0lnGi0ZphY
 eeQzmX0GWSJF7eqNEo2ATclqw2GmV7ipCqXTdV/mKDyR7MHZ7qtwuYZ75tL79D/UKS
 TR1Adicld3lSA==
From: Mark Brown <broonie@kernel.org>
To: Kai Vehmanen <kai.vehmanen@linux.intel.com>, alsa-devel@alsa-project.org
In-Reply-To: <20210128105751.1049837-1-kai.vehmanen@linux.intel.com>
References: <20210128105751.1049837-1-kai.vehmanen@linux.intel.com>
Subject: Re: [PATCH] ASoC: Intel: remove duplicate MODULE_LICENSE/DESCRIPTION
 tags
Message-Id: <161186727762.43763.10625910430337104529.b4-ty@kernel.org>
Date: Thu, 28 Jan 2021 20:54:37 +0000
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Cc: pierre-louis.bossart@linux.intel.com, cezary.rojewski@intel.com,
 yang.jie@linux.intel.com, Rander Wang <rander.wang@linux.intel.com>,
 lgirdwood@gmail.com
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

On Thu, 28 Jan 2021 12:57:51 +0200, Kai Vehmanen wrote:
> The snd-soc-acpi-intel-match has duplicate module tags for all
> platforms separately. Remove all but one and save some storage
> space and cleanup modinfo output.

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/1] ASoC: Intel: remove duplicate MODULE_LICENSE/DESCRIPTION tags
      commit: 1fc96dc29c3ba342915c3a935c9d177f8f420d03

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
