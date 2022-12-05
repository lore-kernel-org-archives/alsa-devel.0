Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3404CC4332F
	for <alsa-devel@archiver.kernel.org>; Mon,  5 Dec 2022 17:31:28 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 6038C188B;
	Mon,  5 Dec 2022 18:30:36 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 6038C188B
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1670261486;
	bh=0uTGIuEBp5/Yv/xATwCrLsgELl6xETLxJwbbf9T7tjs=;
	h=From:To:In-Reply-To:References:Subject:Date:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=LQg4dXKDcf4LT/7qJC359j8suhwhncwvEmfQMsgPu5IJQ23FIJGKR3psq7ozThpCv
	 0SgRnKuGc8Ig6BgiC6Xlp/l5ZcGCG53v1m31M7CG/ERa707jJ6eocEaIohGElmCxO8
	 Ogfo+JZJatrlKjEqpxuBRVFjHJNoBnMJXoRU9iUQ=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 56F04F8057F;
	Mon,  5 Dec 2022 18:29:37 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 54D54F80580; Mon,  5 Dec 2022 18:29:36 +0100 (CET)
Received: from dfw.source.kernel.org (dfw.source.kernel.org
 [IPv6:2604:1380:4641:c500::1])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 42035F80567
 for <alsa-devel@alsa-project.org>; Mon,  5 Dec 2022 18:29:31 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 42035F80567
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org
 header.b="TBXtT8yf"
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by dfw.source.kernel.org (Postfix) with ESMTPS id 3162361269;
 Mon,  5 Dec 2022 17:29:30 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4E68FC433D6;
 Mon,  5 Dec 2022 17:29:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1670261369;
 bh=0uTGIuEBp5/Yv/xATwCrLsgELl6xETLxJwbbf9T7tjs=;
 h=From:To:In-Reply-To:References:Subject:Date:From;
 b=TBXtT8yf/8wq5ve5atb5btpuDC5rvHUw+4grdwQNyt3cU3/Y/lG+SM1Y5XeIKYLSb
 sSuU29KA8BxnquU4bKwBsc9GXZuw7d55Zh3MPoBZTh28AubCIUiWKLG1eFt0qPJTj7
 sQyibAArQAAbqcyqxVpH5UWsovoWghYSV321ffFoaG9VhcWRKkW1EBMN8Bs5/5iN4n
 fPx0ycweDEhciX76wmsS/Ilz2txrs492Y3SCSGfx/d5KNv0QTf679xRoTIIo0qxvak
 +mbtPgrMlMaF6MFyl0Hg3lVKZoYrrwljlP13iaqywzj/+VNjKNJWVlnuBa9y5cUYD+
 KO23iIH0pZn/g==
From: Mark Brown <broonie@kernel.org>
To: Srinivasa Rao Mandadapu <quic_srivasam@quicinc.com>,
 linux-kernel@vger.kernel.org, judyhsiao@chromium.org, 
 andersson@kernel.org, lgirdwood@gmail.com, bgoswami@quicinc.com,
 robh+dt@kernel.org, linux-arm-msm@vger.kernel.org, 
 perex@perex.cz, alsa-devel@alsa-project.org, devicetree@vger.kernel.org,
 quic_rohkumar@quicinc.com, tiwai@suse.com, 
 swboyd@chromium.org, srinivas.kandagatla@linaro.org, agross@kernel.org,
 quic_plai@quicinc.com
In-Reply-To: <1670219333-32526-1-git-send-email-quic_srivasam@quicinc.com>
References: <1670219333-32526-1-git-send-email-quic_srivasam@quicinc.com>
Subject: Re: [PATCH] ASoC: qcom: lpass-sc7280: Add maybe_unused tag for system
 PM ops
Message-Id: <167026136595.536379.7143811448400492677.b4-ty@kernel.org>
Date: Mon, 05 Dec 2022 17:29:25 +0000
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Mailer: b4 0.10.0-dev-fc921
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

On Mon, 5 Dec 2022 11:18:53 +0530, Srinivasa Rao Mandadapu wrote:
> Add __maybe_unused tag for system PM ops suspend and resume.
> This is required to fix allmodconfig compilation issue.
> 
> Fixes: a3a96e93cc88 ("ASoC: qcom: lpass-sc7280: Add system suspend/resume PM ops")
> 
> 

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/1] ASoC: qcom: lpass-sc7280: Add maybe_unused tag for system PM ops
      commit: ab148b461c5cd767762bfcba5749c770ca836079

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
