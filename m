Return-Path: <SRS0=Xi7p=LT=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0E55EC2B9F4
	for <alsa-devel@archiver.kernel.org>; Fri, 25 Jun 2021 13:26:33 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9560261962
	for <alsa-devel@archiver.kernel.org>; Fri, 25 Jun 2021 13:26:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9560261962
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 73A85167B;
	Fri, 25 Jun 2021 15:25:39 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 73A85167B
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1624627589;
	bh=tap7YRggbHIdkEpjJ/bP0UQLC1WqPENH/gRQwTG/qbA=;
	h=From:To:Subject:Date:In-Reply-To:References:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=e9r8aUChw9lo76Lws922+K0y+jkE+zkeDHxW0GN7sw+vZlGd+sI/L+BRKc3YisBWZ
	 3uPjDOAY8+5Oicxo/pVKeAGeje7zGNEgQ/5mTGeSoO8yp0saBog0l8KYKjkbrjH6B4
	 85ycV1CY5q/TtDjJ7AbS1PNo+S9j9AG79Hxo8V2I=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 00C73F8016D;
	Fri, 25 Jun 2021 15:25:37 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 56417F801D5; Fri, 25 Jun 2021 15:25:36 +0200 (CEST)
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id F20A4F800E1
 for <alsa-devel@alsa-project.org>; Fri, 25 Jun 2021 15:25:33 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz F20A4F800E1
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org
 header.b="uOpKh/DM"
Received: by mail.kernel.org (Postfix) with ESMTPSA id 62D6661962;
 Fri, 25 Jun 2021 13:25:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1624627529;
 bh=tap7YRggbHIdkEpjJ/bP0UQLC1WqPENH/gRQwTG/qbA=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=uOpKh/DMAdoOJqUA2DY4RJ3byCu44ZOLlBbc6plAGQssiYWKKWs+MsZB2UGZ1rlP3
 0a4pnrOmT91DqFwnmnuY8rDw4EbOYnraCidGM1hdJReLlUVIILFxOXlEaLMJuWnFZv
 eb/0r1pDLOVvaX37ZBNDkveSCMJKNVNEyBxU8xqiAFZBswTyNVGIbVgeU/AZcwuqry
 Uau1OOvd+OQxMFf3TAjvSZAQmI/7w+6sH295NdLKdlKkjxYdfOp+GZYV0kL/pDYXGr
 qrPvH7D6MYO2AODGXiGvfID5zsUSqpvRh9PRePaRfVFjtZPo7oce3HW3cgddTl40Li
 1tb3Ac2AjwgMQ==
From: Mark Brown <broonie@kernel.org>
To: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Subject: Re: [PATCH] ASoC: qcom: lpass-cpu: mark IRQ_CLEAR register as
 volatile and readable
Date: Fri, 25 Jun 2021 14:24:57 +0100
Message-Id: <162462667882.45385.4252603231977049463.b4-ty@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20210624092153.5771-1-srinivas.kandagatla@linaro.org>
References: <20210624092153.5771-1-srinivas.kandagatla@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Cc: alsa-devel@alsa-project.org,
 Srinivasa Rao Mandadapu <srivasam@codeaurora.org>,
 linux-kernel@vger.kernel.org, lgirdwood@gmail.com,
 Mark Brown <broonie@kernel.org>, Marek Szyprowski <m.szyprowski@samsung.com>
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

On Thu, 24 Jun 2021 10:21:53 +0100, Srinivas Kandagatla wrote:
> Currently IRQ_CLEAR register is marked as write-only, however using
> regmap_update_bits on this register will have some side effects.
> so mark IRQ_CLEAR register appropriately as readable and volatile.

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/1] ASoC: qcom: lpass-cpu: mark IRQ_CLEAR register as volatile and readable
      commit: 6a7f5bd6185e1c86256d5e52c3bb7a4d390d6e19

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
