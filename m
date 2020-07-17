Return-Path: <SRS0=vkql=A4=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 65581C433E7
	for <alsa-devel@archiver.kernel.org>; Fri, 17 Jul 2020 15:43:37 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DA94B2076A
	for <alsa-devel@archiver.kernel.org>; Fri, 17 Jul 2020 15:43:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="CZNuvUF3";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="NhDHkDLx"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DA94B2076A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 71FE0843;
	Fri, 17 Jul 2020 17:42:45 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 71FE0843
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1595000615;
	bh=2c6nRX3jNeNABxpORJGm06RLtRwncH2kZnG/Bd4ptDM=;
	h=Date:From:To:In-Reply-To:References:Subject:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=CZNuvUF3TD3ZXH0lpoQSQt7w+9WcJkxZ+2eM/hFYP1pjGKmuz6C8PPtWLjr554on2
	 L62WkaJW84nCDS5q6hSVIDwqglOEqH6qXAb1xl706N/m6FALlAqoeqFCjmZuIW9a+Z
	 mg4/Swo/WujC+xsZJ6je8U09FpUK7ZTA8dpwtm3o=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 06017F802E2;
	Fri, 17 Jul 2020 17:40:18 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id CCF06F802DF; Fri, 17 Jul 2020 17:40:15 +0200 (CEST)
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 74A04F802DC
 for <alsa-devel@alsa-project.org>; Fri, 17 Jul 2020 17:40:13 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 74A04F802DC
Authentication-Results: alsa1.perex.cz;
 dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org
 header.b="NhDHkDLx"
Received: from localhost (fw-tnat.cambridge.arm.com [217.140.96.140])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id 060B720775;
 Fri, 17 Jul 2020 15:40:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1595000411;
 bh=2c6nRX3jNeNABxpORJGm06RLtRwncH2kZnG/Bd4ptDM=;
 h=Date:From:To:Cc:In-Reply-To:References:Subject:From;
 b=NhDHkDLxxoZqg+kEY6+mpBp4L5RLTz72NIdcOAxmxwyXoLbMEKXcB0KvxJj9EH4zJ
 jfsqh/NAvbUC+SuRRZXF5l18HSK5CXwUPCeMNHuE+XGkUnxt1pw9fDhNJj4I92ugoE
 GJ/Uscjqk4mk3cofGaYv1xrBqeIv+IyDbCnZmEIY=
Date: Fri, 17 Jul 2020 16:40:00 +0100
From: Mark Brown <broonie@kernel.org>
To: tiwai@suse.com, lgirdwood@gmail.com, plai@codeaurora.org,
 bgoswami@codeaurora.org, Tang Bin <tangbin@cmss.chinamobile.com>,
 perex@perex.cz
In-Reply-To: <20200714112923.14944-1-tangbin@cmss.chinamobile.com>
References: <20200714112923.14944-1-tangbin@cmss.chinamobile.com>
Subject: Re: [PATCH] ASoC: qcom: qdsp6: Use the defined variable to clean code
Message-Id: <159500037997.27597.12601442767423961502.b4-ty@kernel.org>
Cc: alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
 Zhang Shengju <zhangshengju@cmss.chinamobile.com>
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

On Tue, 14 Jul 2020 19:29:23 +0800, Tang Bin wrote:
> Use the defined variable "dev" to make the code cleaner.

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/1] ASoC: qcom: qdsp6: Use the defined variable to clean code
      commit: 4c5b809377b3c66fb3c7a3e5b03c78f6ae16fd83

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
