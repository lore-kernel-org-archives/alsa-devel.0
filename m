Return-Path: <SRS0=LtCP=G4=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B71BFC433E0
	for <alsa-devel@archiver.kernel.org>; Mon, 25 Jan 2021 14:19:06 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7356A23102
	for <alsa-devel@archiver.kernel.org>; Mon, 25 Jan 2021 14:19:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7356A23102
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 25C801820;
	Mon, 25 Jan 2021 15:18:13 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 25C801820
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1611584343;
	bh=xl+eiBPa0wwvcjW9v6uOgqBn7DHaFe2RCDw42FQzqKQ=;
	h=From:To:In-Reply-To:References:Subject:Date:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=e2RJnGafB+wCB399fK+N+YoUt8T0IPorJkK6Q0rUFgAG+EMxgHDBN7/0nN6xdYFE7
	 tuTK25LDuTBs7xFERrb5Yw630ajDaaRqlUjnYnlbNmNdRju9WjRy2X1Al0xJk7ud6I
	 YNA95FisDeUlH3lqeDHofdAAEpMApsxYBwgFMbEw=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id AB7CFF80218;
	Mon, 25 Jan 2021 15:18:11 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 65B0CF80259; Mon, 25 Jan 2021 15:18:09 +0100 (CET)
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 71F35F8012D
 for <alsa-devel@alsa-project.org>; Mon, 25 Jan 2021 15:18:05 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 71F35F8012D
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org
 header.b="r+dTgJsV"
Received: by mail.kernel.org (Postfix) with ESMTPSA id CBADB2145D;
 Mon, 25 Jan 2021 14:18:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1611584283;
 bh=xl+eiBPa0wwvcjW9v6uOgqBn7DHaFe2RCDw42FQzqKQ=;
 h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
 b=r+dTgJsVoLmFdqgEYwvChSAZCc8QqaD+06FY5e+flfeuTxC6WxilwDWHhws4EUGiE
 wS1NCAn9ywmZf5oTaz1ufBESvBH6ECB549CwTjhP8Hzhq795fd4aSNPr2ZWQiFB36g
 nzNELVSoYq83BwjC5nohIwepxAnE/CWI0JXYBVXDUgJ9igiAqVOpmL1CKquUBY09N+
 ffwiE20CtOK0SG8KzEde4S2K+v2jXE7UTF3fI7jE0gmggPh2XH1E0X/cSrIdPpSPr3
 TQWPiFHadfC12atRBsqMWYBcNrhQz2bGklsB2Va0kxhWfIfEar2InY1loMFYoVtCUv
 pCQ1LQ4pyslKw==
From: Mark Brown <broonie@kernel.org>
To: Stephan Gerhold <stephan@gerhold.net>
In-Reply-To: <20210125104442.135899-1-stephan@gerhold.net>
References: <20210125104442.135899-1-stephan@gerhold.net>
Subject: Re: [PATCH v2] ASoC: qcom: lpass: Fix out-of-bounds DAI ID lookup
Message-Id: <161158424212.32959.4363498629836769179.b4-ty@kernel.org>
Date: Mon, 25 Jan 2021 14:17:22 +0000
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Cc: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
 alsa-devel@alsa-project.org, Banajit Goswami <bgoswami@codeaurora.org>,
 Srinivasa Rao Mandadapu <srivasam@codeaurora.org>,
 Liam Girdwood <lgirdwood@gmail.com>
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

On Mon, 25 Jan 2021 11:44:42 +0100, Stephan Gerhold wrote:
> The "dai_id" given into LPAIF_INTFDMA_REG(...) is already the real
> DAI ID, not an index into v->dai_driver. Looking it up again seems
> entirely redundant.
> 
> For IPQ806x (and SC7180 since commit 09a4f6f5d21c
> ("ASoC: dt-bindings: lpass: Fix and common up lpass dai ids") this is
> now often an out-of-bounds read because the indexes in the "dai_driver"
> array no longer match the actual DAI ID.

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/1] ASoC: qcom: lpass: Fix out-of-bounds DAI ID lookup
      commit: 70041000450d0a071bf9931d634c8e2820340236

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
