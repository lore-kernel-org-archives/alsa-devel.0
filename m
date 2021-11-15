Return-Path: <SRS0=FucB=QC=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AF816C433EF
	for <alsa-devel@archiver.kernel.org>; Mon, 15 Nov 2021 23:39:52 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EBE5B61B5F
	for <alsa-devel@archiver.kernel.org>; Mon, 15 Nov 2021 23:39:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org EBE5B61B5F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 5255D169E;
	Tue, 16 Nov 2021 00:39:00 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 5255D169E
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1637019590;
	bh=sepJeKAqWD8OEq16yv5uQxj8oK3WHPvL+LfRcZh0niI=;
	h=From:To:In-Reply-To:References:Subject:Date:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=DVJfJK+KjDQG0I0jxpSKdBpzR2dZXHyb/yb/LL/06rAbkmT0zMzuA5RXYeXgrrX7v
	 fbtxEPx5xNXClRAeGw25uNa1X8nrRBa483YTXnGOf6g/TMBxSya5m5eCYmwqHWDmF6
	 GiZLl/0mlDboqHFehIXUKXQxVFSkk4q6Qj/5btTs=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id CEC0BF80535;
	Tue, 16 Nov 2021 00:35:29 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 425A3F804FF; Tue, 16 Nov 2021 00:35:23 +0100 (CET)
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 3C837F804FE
 for <alsa-devel@alsa-project.org>; Tue, 16 Nov 2021 00:35:20 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 3C837F804FE
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org
 header.b="dChFpCCk"
Received: by mail.kernel.org (Postfix) with ESMTPSA id B65786325B;
 Mon, 15 Nov 2021 23:35:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1637019319;
 bh=sepJeKAqWD8OEq16yv5uQxj8oK3WHPvL+LfRcZh0niI=;
 h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
 b=dChFpCCkDxohYHTlOa+kJKHYpjYgV2kJNoJjZS9AIeP6IzOBQXUTvKC+IdcKRsmWJ
 fUqaXJZfT4aAdPolbpqvut7vCnP2VpqZV5vkQlBSJFAWC6xoDegTyMcWPB2XjqM1yt
 hJh0cFuIrTpkTCCuvcBGkNhc4mMcroWm3L4hcCSOve1py6hjutrLJLsI5y9VXnDu9g
 nAQdZrJShGkQ2MblqrPDP1962r6dGehUcxW9Q7c6l3CzYCbna/FoBR5ReoZVDb7YTZ
 9RrECdd6AYXgVLbsGmx3M+Y8Iegx+IP0/VkgKzMb8GxJ+RgzleQdKlBvihI8Rtq1uB
 yviu9M6AEoNHw==
From: Mark Brown <broonie@kernel.org>
To: swboyd@chromium.org, devicetree@vger.kernel.org, bjorn.andersson@linaro.org,
 linux-arm-msm@vger.kernel.org, rohitkr@codeaurora.org, robh+dt@kernel.org,
 alsa-devel@alsa-project.org, plai@codeaurora.org, linux-kernel@vger.kernel.org,
 perex@perex.cz, judyhsiao@chromium.org, lgirdwood@gmail.com,
 Srinivasa Rao Mandadapu <srivasam@codeaurora.org>, tiwai@suse.com,
 bgoswami@codeaurora.org, agross@kernel.org, srinivas.kandagatla@linaro.org
In-Reply-To: <1636960288-27537-1-git-send-email-srivasam@codeaurora.org>
References: <1636960288-27537-1-git-send-email-srivasam@codeaurora.org>
Subject: Re: [PATCH v2] ASoC: codecs: MBHC: Add support for special headset
Message-Id: <163701931648.675370.4567378408146703552.b4-ty@kernel.org>
Date: Mon, 15 Nov 2021 23:35:16 +0000
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Cc: Venkata Prasad Potturu <potturu@codeaurora.org>
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

On Mon, 15 Nov 2021 12:41:28 +0530, Srinivasa Rao Mandadapu wrote:
> Update MBHC driver to support special headset such as apple
> and huwawei headsets.
> 
> Changes Since V1:
>     -- Fix typo errors.
> 
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/1] ASoC: codecs: MBHC: Add support for special headset
      commit: 3c8a3ad4019126f06016ab0128dde11817502f52

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
