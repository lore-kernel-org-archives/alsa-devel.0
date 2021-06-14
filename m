Return-Path: <SRS0=68EG=LI=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1BFD4C2B9F4
	for <alsa-devel@archiver.kernel.org>; Mon, 14 Jun 2021 20:02:20 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6401261166
	for <alsa-devel@archiver.kernel.org>; Mon, 14 Jun 2021 20:02:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6401261166
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id D757B16BF;
	Mon, 14 Jun 2021 22:01:27 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz D757B16BF
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1623700938;
	bh=7xDxmxG4Ta9fQN68e3Utug451ue+9mXqf6QY/N18kaM=;
	h=From:To:Subject:Date:In-Reply-To:References:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=kt4WbbPp+hFpQzzPxe5qGSHV8OUro55GGvoi6jq9MSQEE8Fp1ZAIDYXKUD/U82cOq
	 o3cs2Z/ZVbFtSDE/q9Dl2Jh/nWkWgVP9pQKlHkVTE6F/u1GbuI7gc2MDpeKTxNfuaF
	 kgUQphK2FrR+jy9ksTw8zHsdPltgeHQ2NLBD/Edo=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 81577F8054A;
	Mon, 14 Jun 2021 21:55:35 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 7A307F80543; Mon, 14 Jun 2021 21:55:33 +0200 (CEST)
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id C9173F80539
 for <alsa-devel@alsa-project.org>; Mon, 14 Jun 2021 21:55:30 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz C9173F80539
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org
 header.b="Zssg79GR"
Received: by mail.kernel.org (Postfix) with ESMTPSA id E8FE461166;
 Mon, 14 Jun 2021 19:55:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1623700529;
 bh=7xDxmxG4Ta9fQN68e3Utug451ue+9mXqf6QY/N18kaM=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=Zssg79GRTB9L/oTyZXEXCGJyMP7orW2fEBsHcqmaA+t+7EIJFCMYekzSSriUsWXtA
 TTXkc/W5Qd0c2l63uxDcKV17znVYQ3zHjReD7nZcVZ4V6l4+7ys1AjHBq7zQ6arLI3
 ctFjT3NRuAUfIABB1hGSZqhiicTfDULDJNkrCDtM7yWC1uVxoYc3kIXdX9IPZUHmXo
 sNOTJq3Kushsff/jyzcceN8HXoJZqwSBe4qmmg3q1PuJkm5DEAeSGvWoMIOTRjJt2L
 cmn/FAo2FYzIbZRIPj18eTX8JqbXLmQHiy4LqCY8khbu2CfRfXQWdLiiLRrNuIB8Zb
 +1ELdi+C5jlWw==
From: Mark Brown <broonie@kernel.org>
To: Yang Li <yang.lee@linux.alibaba.com>,
	lgirdwood@gmail.com
Subject: Re: [PATCH -next] ASoC: codecs: wcd: Remove unneeded semicolon
Date: Mon, 14 Jun 2021 20:53:56 +0100
Message-Id: <162369994007.34524.11243148752521690336.b4-ty@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <1623221171-105359-1-git-send-email-yang.lee@linux.alibaba.com>
References: <1623221171-105359-1-git-send-email-yang.lee@linux.alibaba.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Cc: linux-kernel@vger.kernel.org, alsa-devel@alsa-project.org,
 Mark Brown <broonie@kernel.org>, tiwai@suse.com
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

On Wed, 9 Jun 2021 14:46:11 +0800, Yang Li wrote:
> Eliminate the following coccicheck warning:
> ./sound/soc/codecs/wcd-mbhc-v2.c:990:2-3: Unneeded semicolon.

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/1] ASoC: codecs: wcd: Remove unneeded semicolon
      commit: 03c0cbd946958af9cc10e55bdb047fd37d30735e

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
