Return-Path: <SRS0=Cjbi=KG=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0F848C43619
	for <alsa-devel@archiver.kernel.org>; Tue, 11 May 2021 08:31:42 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6509D611C2
	for <alsa-devel@archiver.kernel.org>; Tue, 11 May 2021 08:31:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6509D611C2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id B85511786;
	Tue, 11 May 2021 10:30:49 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz B85511786
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1620721899;
	bh=l8Z/OzCfeWsNmqmpOZGd1liyMDpNo7gr8CIy6SCuWuI=;
	h=From:To:Subject:Date:In-Reply-To:References:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=WP8bFPieOEaNNzVUhYDPip7PEWW0OhIu5KhZJyOnDtrpJeWzvOvytFayVeIql+wd4
	 ur5mms1Olp3Wol6d0ru3TUI60J2npBvQv8prSvM1T4iFlor0SvKfg7o1zp4ybW+mxr
	 UstUx/APlEk912j7AiSNh7GpIRW9r2qMOaP/25oo=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id E9943F804D9;
	Tue, 11 May 2021 10:28:25 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id E18A0F804D9; Tue, 11 May 2021 10:27:52 +0200 (CEST)
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id C65D3F804B1
 for <alsa-devel@alsa-project.org>; Tue, 11 May 2021 10:27:49 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz C65D3F804B1
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org
 header.b="GggvETJ4"
Received: by mail.kernel.org (Postfix) with ESMTPSA id 31A296147E;
 Tue, 11 May 2021 08:27:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1620721667;
 bh=l8Z/OzCfeWsNmqmpOZGd1liyMDpNo7gr8CIy6SCuWuI=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=GggvETJ49ghxR3jGggzJ6p0bycd1w39dMmZ8r0464V/YAjOVjLugxBEg0pbx3NErg
 xgXpyHzFVlxdtoUmkYJIUt625ivDU8vxPgj49BZJkhxEHgtvTF+AgAqmWi9UOKTb3S
 SNTXlGD0RK5UeKscWvKKaYLBZZoZQWx6mGp2srF6uqpZdssFeNUN06VfQLHh0g7BKW
 Er2hyoNNPzF6i6L08ICk8J0Xp07+l2OH5x+Kb/SiHES3bj8aeYZAg1sSC0bayHi7bq
 kdjnbYpQzAZy1tml+3e2hmcRhEnNEjOfdIo4L7w9RsvLtvOl5C8clIlXCQC6fIj8jo
 uEPyQwLeLwRLg==
From: Mark Brown <broonie@kernel.org>
To: lgirdwood@gmail.com, srinivas.kandagatla@linaro.org, perex@perex.cz,
 bgoswami@codeaurora.org, trix@redhat.com, tiwai@suse.com
Subject: Re: [PATCH v2] ASoC: codecs: lpass-wsa-macro: handle unexpected input
Date: Tue, 11 May 2021 09:25:51 +0100
Message-Id: <162072058168.33157.3176018576144440940.b4-ty@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20210430142117.3272772-1-trix@redhat.com>
References: <20210430142117.3272772-1-trix@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Cc: alsa-devel@alsa-project.org, Mark Brown <broonie@kernel.org>,
 linux-kernel@vger.kernel.org
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

On Fri, 30 Apr 2021 07:21:17 -0700, trix@redhat.com wrote:
> Static analysis reports this problem
> 
> lpass-wsa-macro.c:1732:6: warning: Array subscript is undefined
>         if (wsa->ec_hq[ec_tx]) {
>             ^~~~~~~~~~~~~~~~~
> 
> The happens because 'ec_tx' is never initialized and there is
> no default in switch statement that sets ec_tx.  Add a default
> case that returns an error before the array is accessed.

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/1] ASoC: codecs: lpass-wsa-macro: handle unexpected input
      commit: 58f01c7fc81baced84f237554d56847e17b5d730

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
