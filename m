Return-Path: <SRS0=68EG=LI=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.2 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 96F0AC2B9F4
	for <alsa-devel@archiver.kernel.org>; Mon, 14 Jun 2021 19:57:14 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A4D3161209
	for <alsa-devel@archiver.kernel.org>; Mon, 14 Jun 2021 19:57:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A4D3161209
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 26780168B;
	Mon, 14 Jun 2021 21:56:22 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 26780168B
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1623700632;
	bh=YzulUFMFki/iYiWjf8Var0pCv66AUmtnxzcZgz7kSHc=;
	h=From:To:Subject:Date:In-Reply-To:References:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=rnhDM1DywpKuKKHXYU/MPxImo1IIF9iiPqWACLeMdgctwd4NiF7Y70gkt7PMoIsy3
	 dSHLC8UMuTrayu3hxfqOfAqB2/7LKKzGs02bPBrs7A3fRR3M5vcptCvXKA/MvkqY7s
	 R25hlbCyNpdAXcAaxnNqSodFZas8NPUhFQRph4NQ=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 1840FF804D6;
	Mon, 14 Jun 2021 21:54:57 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 001AEF804CA; Mon, 14 Jun 2021 21:54:51 +0200 (CEST)
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 5306BF802E8
 for <alsa-devel@alsa-project.org>; Mon, 14 Jun 2021 21:54:49 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 5306BF802E8
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org
 header.b="A19LLbD3"
Received: by mail.kernel.org (Postfix) with ESMTPSA id 2B6D3611EE;
 Mon, 14 Jun 2021 19:54:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1623700488;
 bh=YzulUFMFki/iYiWjf8Var0pCv66AUmtnxzcZgz7kSHc=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=A19LLbD3NvVDOSHJTkzTIi1NZHF26MsG7BJ6+awHPVUtnnWmTYE8FEhNB/lrxMV4U
 EMKMWqWP5y+6AvTPKbN7fZpGm3t0FVaQbVTv4cfSoV2pFBqTae/6ekMy+o9V4NdNsc
 UzGat7jDYk4+L6kkGNaxU9t+bgGmgHfni2IJZV422GDdo/8p5xQjbpYizvAM4XGT0D
 uwVFUR7JXAynpwxVy4lW0uF4m/F4uupRY/Eqgb+z83qDFR6uIWpnE81SwDG+Yv8kfV
 y4AX9LlZbQQTc0NPMAGiQ+ivRxAAh/VDREch9Uw63KyNNpXkBc7QAB1tETmKKdbSB0
 O9ntoBlQpODpg==
From: Mark Brown <broonie@kernel.org>
To: agross@kernel.org, srinivas.kandagatla@linaro.org, rohitkr@codeaurora.org,
 perex@perex.cz, Srinivasa Rao Mandadapu <srivasam@codeaurora.org>,
 plai@codeaurora.org, linux-kernel@vger.kernel.org, tiwai@suse.com,
 robh+dt@kernel.org, swboyd@chromium.org, linux-arm-msm@vger.kernel.org,
 lgirdwood@gmail.com, devicetree@vger.kernel.org,
 bjorn.andersson@linaro.org, judyhsiao@chromium.org,
 alsa-devel@alsa-project.org, bgoswami@codeaurora.org
Subject: Re: [PATCH v3] ASoC: qcom: Add four speaker support on MI2S secondary
Date: Mon, 14 Jun 2021 20:53:42 +0100
Message-Id: <162369994008.34524.16929754677790147790.b4-ty@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20210609133039.4648-1-srivasam@codeaurora.org>
References: <20210609133039.4648-1-srivasam@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Cc: Mark Brown <broonie@kernel.org>
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

On Wed, 9 Jun 2021 19:00:39 +0530, Srinivasa Rao Mandadapu wrote:
> Add four speaker support on MI2S secondary block
> by using I2S SD1 line on gpio52 pin, and add channel map
> control support in the lpass-cpu audio driver.

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/1] ASoC: qcom: Add four speaker support on MI2S secondary
      commit: c223f41c1a52bfe10f1d3311679b1d1f9813e500

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
