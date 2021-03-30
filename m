Return-Path: <SRS0=2x8D=I4=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 36CB4C433C1
	for <alsa-devel@archiver.kernel.org>; Tue, 30 Mar 2021 16:07:10 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6E231619C7
	for <alsa-devel@archiver.kernel.org>; Tue, 30 Mar 2021 16:07:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6E231619C7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 46B681675;
	Tue, 30 Mar 2021 18:06:16 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 46B681675
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1617120426;
	bh=26IHFrffaqAWxvS40u7qOPp8h/qopG6fb7xg9SJkSvo=;
	h=From:To:Subject:Date:In-Reply-To:References:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=ndkQapxBCf6p3hqhWV0Vt1E30rL1uSqZkcGp/DEDuqS9NIti+SlSn9fMrUu+TU6KW
	 Qv2ywhsJujSHj0RnV90tvfU9mQKbHvl5cIfBoLN/IxmSyXCar/neZhdjkmQFqMXMBK
	 6hZoYjoffr7MHMslegWJSLMbpJwK6nxOJTZUlZmw=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id C3C08F8026B;
	Tue, 30 Mar 2021 18:06:15 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 397A8F80240; Tue, 30 Mar 2021 18:06:14 +0200 (CEST)
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 3B497F80141
 for <alsa-devel@alsa-project.org>; Tue, 30 Mar 2021 18:06:10 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 3B497F80141
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org
 header.b="f68in51w"
Received: by mail.kernel.org (Postfix) with ESMTPSA id 10B34619CE;
 Tue, 30 Mar 2021 16:06:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1617120368;
 bh=26IHFrffaqAWxvS40u7qOPp8h/qopG6fb7xg9SJkSvo=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=f68in51wQUPiZZAP7ZJeCYsRAwxqRIx1oy6ZxJhSIU5xcYXNquCEjUqbkDtSknVwg
 vFgWJmG4c+udLX45YaKMegwqplT9AJuYqpxO4KcOi65yMm8fYc9ZtU1smvjgfOt87W
 grVEX54/Lecz2tlJrBXcXHKKDtKvahQithtPxUnGnayTfdGT2wnW/qfRiui0KKUu4R
 ieoewUrOycnKARQKM5XZkfKmG9FTbyLddK6MUMKCCVYgP5xhB9Lrs7Um1hlTz4G3eg
 bL/EBjgXCvdNeAka/2NpVHbznbfGiX68VSZZsvj9RtyMKhYGy8W0MC4vt7eFYnVBYF
 Ax3HGu9eo+icg==
From: Mark Brown <broonie@kernel.org>
To: Liam Girdwood <lgirdwood@gmail.com>,
 Banajit Goswami <bgoswami@codeaurora.org>,
 Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
 Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
 alsa-devel@alsa-project.org, linux-arm-msm@vger.kernel.org
Subject: Re: [PATCH] ASoC: q6afe-clocks: fix reprobing of the driver
Date: Tue, 30 Mar 2021 17:05:49 +0100
Message-Id: <161711993559.12915.3715212253584619506.b4-ty@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20210327092857.3073879-1-dmitry.baryshkov@linaro.org>
References: <20210327092857.3073879-1-dmitry.baryshkov@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Cc: Andy Gross <agross@kernel.org>, Mark Brown <broonie@kernel.org>,
 Takashi Iwai <tiwai@suse.com>, Bjorn Andersson <bjorn.andersson@linaro.org>
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

On Sat, 27 Mar 2021 12:28:57 +0300, Dmitry Baryshkov wrote:
> Q6afe-clocks driver can get reprobed. For example if the APR services
> are restarted after the firmware crash. However currently Q6afe-clocks
> driver will oops because hw.init will get cleared during first _probe
> call. Rewrite the driver to fill the clock data at runtime rather than
> using big static array of clocks.

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/1] ASoC: q6afe-clocks: fix reprobing of the driver
      commit: 96fadf7e8ff49fdb74754801228942b67c3eeebd

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
