Return-Path: <SRS0=oBR+=GY=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.2 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B3707C433E0
	for <alsa-devel@archiver.kernel.org>; Thu, 21 Jan 2021 00:12:16 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F1FD223441
	for <alsa-devel@archiver.kernel.org>; Thu, 21 Jan 2021 00:12:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F1FD223441
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 7EF0718D1;
	Thu, 21 Jan 2021 01:11:24 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 7EF0718D1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1611187934;
	bh=3m8CxlAKDFscDileBlbG+QMIPIVZkPB60WPgTTqxxzk=;
	h=From:To:In-Reply-To:References:Subject:Date:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=SR1IsBc6ipwLZffLpscfHsoK/m7RHQ16BeGRCJLuAmTY9yQd2EQ54BKStDUK1CrZw
	 LRk91JHQjOEarRvoSXLZPgWRaeQhMz9/ptjzd3DaxsdXp3iNLo/dSnlXYutAJrga1I
	 C7AREm0a5hfzdvwRDBdZafdsR1eCMUf3CHsVQT2o=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id C69C9F80519;
	Thu, 21 Jan 2021 01:07:38 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id D1CAFF8051D; Thu, 21 Jan 2021 01:07:37 +0100 (CET)
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 56E49F80519
 for <alsa-devel@alsa-project.org>; Thu, 21 Jan 2021 01:07:35 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 56E49F80519
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org
 header.b="GauoqdZZ"
Received: by mail.kernel.org (Postfix) with ESMTPSA id 745AF23730;
 Thu, 21 Jan 2021 00:07:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1611187654;
 bh=3m8CxlAKDFscDileBlbG+QMIPIVZkPB60WPgTTqxxzk=;
 h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
 b=GauoqdZZPss0N0cUS71R+vuizzpOFb5lg1OFLTiLHAgri/HXtL9p8LgJHpQlvPO3F
 Oe5FE+lG6i3BouIvYIqc2cD5o7mbQxMm7efYXEOWbeWyuPmb6jxK7kNnYeQsVQBOAv
 OtbX/+82/v/Wiv0ZkjLrliLbYc6n/bpmGknEVXaYsIciDC5xTVv3t2EK72hkpZL4BL
 pI74tcJgP2Pz2bC9kI8B/AByDf1reg7TB7zQIIWub2To2xGCHbXCKytT8G5KPGuqQl
 IokMvH+Yt37UxKP44AV1Ckk+bVuDXtsL/7uiTcEzOaQI5uKmo7pJycf0pff8IuRdxQ
 QEbDap8FVKauw==
From: Mark Brown <broonie@kernel.org>
To: Jaroslav Kysela <perex@perex.cz>,
 ALSA development <alsa-devel@alsa-project.org>
In-Reply-To: <20210120144211.817937-1-perex@perex.cz>
References: <20210120144211.817937-1-perex@perex.cz>
Subject: Re: [PATCH] ASoC: AMD Renoir - refine DMI entries for some Lenovo
 products
Message-Id: <161118753484.45718.4379815986670636052.b4-ty@kernel.org>
Date: Thu, 21 Jan 2021 00:05:34 +0000
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Cc: Takashi Iwai <tiwai@suse.de>, stable@kernel.org
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

On Wed, 20 Jan 2021 15:42:11 +0100, Jaroslav Kysela wrote:
> Apparently, the DMI board name LNVNB161216 is also used also
> for products with the digital microphones connected to the AMD's
> audio bridge. Refine the DMI table - use product name identifiers
> extracted from https://bugzilla.redhat.com/show_bug.cgi?id=1892115 .
> 
> The report for Lenovo Yoga Slim 7 14ARE05 (82A2) is in buglink.

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/1] ASoC: AMD Renoir - refine DMI entries for some Lenovo products
      commit: 40caffd66ca9ad1baa2d5541232675160bc6c772

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
