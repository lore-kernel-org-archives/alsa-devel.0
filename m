Return-Path: <SRS0=BHSX=HE=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.4 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E5D7AC433DB
	for <alsa-devel@archiver.kernel.org>; Tue,  2 Feb 2021 15:36:38 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 532CF64E9A
	for <alsa-devel@archiver.kernel.org>; Tue,  2 Feb 2021 15:36:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 532CF64E9A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 97FA31730;
	Tue,  2 Feb 2021 16:35:46 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 97FA31730
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1612280196;
	bh=8RZE4kmI/Rwh/V6PZg/jIICmaP1SJ5gy/78kCN3vvbQ=;
	h=From:To:In-Reply-To:References:Subject:Date:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=B1rViFrVNgM/KnquXqAR0RHDLMFcWZBF3Z4AnVuoKMMxDRNyd3LlBCgs/LTdrhTJo
	 AiCh7vj8WhtOW8+4m4jD8DISNSoYEIbxEOoBYkLDreUV+aKbZ4p00aZPd/t2vQkdrl
	 bvZRzlt8invYulfl4a18b5IkvdO09IOcMF0aBtQQ=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 205A2F800E1;
	Tue,  2 Feb 2021 16:35:46 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id D8436F801F7; Tue,  2 Feb 2021 16:35:44 +0100 (CET)
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 36323F80152
 for <alsa-devel@alsa-project.org>; Tue,  2 Feb 2021 16:35:42 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 36323F80152
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org
 header.b="pE6vmN63"
Received: by mail.kernel.org (Postfix) with ESMTPSA id 6488764F68;
 Tue,  2 Feb 2021 15:35:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1612280140;
 bh=8RZE4kmI/Rwh/V6PZg/jIICmaP1SJ5gy/78kCN3vvbQ=;
 h=From:To:In-Reply-To:References:Subject:Date:From;
 b=pE6vmN63LdtZ8mHWuOqqSsGaEPkduFJy0WaHqrzkEx40UPniEJeSbrPfQbZPqKQAp
 LvGsLDikOdWsnI4aZpbqrLmDfBix/H9b8e/5ab5tXeoI9bhSvjwQEz0weCGDTrodFd
 USIVRk7xPuRjdRZjIknuT/DfwH9TKmY4qJxl1Cl+pb6almvclqY9CzR12fMaCMTjE/
 /XUAswbYf+PNZw7zqY5Om9+Pa/sH3ep2xC/B8nz/EHxM4MrVHf8SAnq0T8G4/V7Nnf
 yfXzh1iDJU/BCt3BPZr0hLxhDK+xYbNFe9YZN4RAVOfkG5p+oZxefL6jNNW96kmmUx
 /RvLu+Mq9r62A==
From: Mark Brown <broonie@kernel.org>
To: devicetree@vger.kernel.org, perex@perex.cz, alsa-devel@alsa-project.org,
 agross@kernel.org, Srinivasa Rao Mandadapu <srivasam@codeaurora.org>,
 robh+dt@kernel.org, rohitkr@codeaurora.org, linux-arm-msm@vger.kernel.org,
 lgirdwood@gmail.com, linux-kernel@vger.kernel.org, bjorn.andersson@linaro.org,
 bgoswami@codeaurora.org, swboyd@chromium.org, plai@codeaurora.org,
 srinivas.kandagatla@linaro.org, tiwai@suse.com
In-Reply-To: <20210202062727.22469-1-srivasam@codeaurora.org>
References: <20210202062727.22469-1-srivasam@codeaurora.org>
Subject: Re: [PATCH] ASoC: qcom: Fix typo error in HDMI regmap config callbacks
Message-Id: <161228008450.11888.13128911236969601728.b4-ty@kernel.org>
Date: Tue, 02 Feb 2021 15:34:44 +0000
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
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

On Tue, 2 Feb 2021 11:57:27 +0530, Srinivasa Rao Mandadapu wrote:
> Had a typo in lpass platform driver that resulted in crash
> during suspend/resume with an HDMI dongle connected.
> 
> The regmap read/write/volatile regesters validation callbacks in lpass-cpu
> were using MI2S rdma_channels count instead of hdmi_rdma_channels.
> 
> This typo error causing to read registers from the regmap beyond the length
> of the mapping created by ioremap().
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/1] ASoC: qcom: Fix typo error in HDMI regmap config callbacks
      commit: 6c9123068815ed0bc1e8fa5a5029eef5ee3866c3

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
