Return-Path: <SRS0=kZkJ=FP=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C9CAFC4361B
	for <alsa-devel@archiver.kernel.org>; Fri, 11 Dec 2020 17:52:33 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F05E723EF4
	for <alsa-devel@archiver.kernel.org>; Fri, 11 Dec 2020 17:52:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F05E723EF4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 36D341750;
	Fri, 11 Dec 2020 18:51:41 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 36D341750
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1607709151;
	bh=TplYl+8hoGtr6lfTXRkTQFwOaFIrExSSRdo8x/MBfU4=;
	h=From:To:In-Reply-To:References:Subject:Date:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=mExi92ebiFEs52F0cg7WDR0+CE+f/9/MMLh/HT17KdmX52jq7BDn4GJvFEKUwlAZU
	 f21W3tpiAqVeo+xF8JGDwtxoZgJW42yc1Z9OlaQiqazJKTtYjtC9YMYcZ62DW6Yo7u
	 r2quKlrM9TjbnM9HZzz3CVZsd9txk56m9ak3s57s=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 71C7DF804D8;
	Fri, 11 Dec 2020 18:50:08 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 58A7DF804C3; Fri, 11 Dec 2020 18:50:06 +0100 (CET)
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id DE1BFF8021D
 for <alsa-devel@alsa-project.org>; Fri, 11 Dec 2020 18:50:03 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz DE1BFF8021D
From: Mark Brown <broonie@kernel.org>
Authentication-Results: mail.kernel.org;
 dkim=permerror (bad message/signature format)
To: Dan Carpenter <dan.carpenter@oracle.com>,
 Liam Girdwood <lgirdwood@gmail.com>, Tzung-Bi Shih <tzungbi@google.com>
In-Reply-To: <X9NFg3KVm16Gx6Io@mwanda>
References: <X9NFg3KVm16Gx6Io@mwanda>
Subject: Re: [PATCH] ASoC: mediatek: mt8183: delete some unreachable code
Message-Id: <160770898112.26354.4365158422154864954.b4-ty@kernel.org>
Date: Fri, 11 Dec 2020 17:49:41 +0000
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Cc: Matthias Brugger <matthias.bgg@gmail.com>,
 linux-mediatek@lists.infradead.org, alsa-devel@alsa-project.org,
 kernel-janitors@vger.kernel.org, Takashi Iwai <tiwai@suse.com>
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

On Fri, 11 Dec 2020 13:10:11 +0300, Dan Carpenter wrote:
> This has a goto followed by an unreachable return statement.  The goto
> is correct because it cleans up so the current runtime behavior is fine.
> Let's delete the unreachable return statement.

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/1] ASoC: mediatek: mt8183: delete some unreachable code
      commit: 1688dbe7a730e1c1ed05b9dde497288494d75ad4

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
