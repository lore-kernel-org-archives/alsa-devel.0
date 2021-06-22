Return-Path: <SRS0=bL7i=LQ=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B98EBC2B9F4
	for <alsa-devel@archiver.kernel.org>; Tue, 22 Jun 2021 15:15:42 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C14906128E
	for <alsa-devel@archiver.kernel.org>; Tue, 22 Jun 2021 15:15:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C14906128E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 6331E82C;
	Tue, 22 Jun 2021 17:14:49 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 6331E82C
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1624374939;
	bh=3we7Q+7oup/k3bH7oBPacMDKI+UoeT+oMJOH2NAnA1U=;
	h=From:To:Subject:Date:In-Reply-To:References:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=ecYjR4iim/DNUlqFGEovrW+0NLbaMfX9dBzqagOKAXpl3o8VSLzGB+7YDTXU4tdon
	 y2K3t+eFAnw2sOT5d7wzxOGxgagDGUTQJpFWhm6r5cOIJCL63ApJuCRY7UjELFpANb
	 LtAepV4p8jt3pYxIVIrn9+jGwTpX+BVFhxkInAQw=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 01BBCF8025F;
	Tue, 22 Jun 2021 17:14:49 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 2B434F8026A; Tue, 22 Jun 2021 17:14:46 +0200 (CEST)
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id BD684F80161
 for <alsa-devel@alsa-project.org>; Tue, 22 Jun 2021 17:14:43 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz BD684F80161
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org
 header.b="a/rZhZb6"
Received: by mail.kernel.org (Postfix) with ESMTPSA id 5970B61289;
 Tue, 22 Jun 2021 15:14:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1624374881;
 bh=3we7Q+7oup/k3bH7oBPacMDKI+UoeT+oMJOH2NAnA1U=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=a/rZhZb6KlhJka/XnPA9DRrd8wfTm16TgdD2lazvGqxdhP/5iuEPGivLCU7hnVJQj
 jz3a1tH6Co83YUcbYsXlsi9I2s8z1611ere2zxOjjCAws0sm7qSgavZq0o9v8ljybR
 jU17FAJrIdUx7ukqhTx6TI81XLmNoJV6MG32UvdG2znTs+XNhhGZ/KTgCZEKtLDlfV
 YO0l3ifu1/QQ6FfF32jfptbEh71CTgnvqgZoJQnp5gESk0UgOonEpbDKs6pZmULSng
 ILX+HInKPpZrqQje5U/OaSWBrbrqwZaqLwgLpzotPbwXvT7o8nb2mDRhcFiCre091x
 k0oF4ub6SPTgA==
From: Mark Brown <broonie@kernel.org>
To: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Subject: Re: [PATCH 1/2] ASoC: codecs: wcd938x: fix unused variable warning
Date: Tue, 22 Jun 2021 16:14:05 +0100
Message-Id: <162437355277.1773.9681249031887965233.b4-ty@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20210621134502.19537-1-srinivas.kandagatla@linaro.org>
References: <20210621134502.19537-1-srinivas.kandagatla@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Cc: lgirdwood@gmail.com, alsa-devel@alsa-project.org,
 Mark Brown <broonie@kernel.org>, kernel test robot <lkp@intel.com>,
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

On Mon, 21 Jun 2021 14:45:01 +0100, Srinivas Kandagatla wrote:
> This patch fixes below
> 
> 	warning: unused variable wcd938x_dt_match
> 
> by placing device match table under CONFIG_OF

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/2] ASoC: codecs: wcd938x: fix unused variable warning
      commit: 8c4863c261c812a1088b0f8c6b66386d885390e1
[2/2] ASoC: codecs: wcd938x: fix uninitialized symbol warnings
      commit: d245fff1013cb7456ea9ca3f7b858e438c6bbf79

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
