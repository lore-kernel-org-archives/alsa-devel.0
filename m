Return-Path: <SRS0=eqSS=OD=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.4 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D366AC433FE
	for <alsa-devel@archiver.kernel.org>; Mon, 13 Sep 2021 10:56:15 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6B95D61004
	for <alsa-devel@archiver.kernel.org>; Mon, 13 Sep 2021 10:56:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 6B95D61004
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id C4D431662;
	Mon, 13 Sep 2021 12:55:22 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz C4D431662
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1631530572;
	bh=CBaronYiroxiOitWnu3/lsS9n0AaVmXWm4fRuQVuEZQ=;
	h=From:To:Subject:Date:In-Reply-To:References:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=E3Pl58nQldN6CbPoLm3wKRyF1Nmh1K8VxQpVJZBh/WFsstys3GR/OUb8Vg9NCBiDG
	 CaaHyC7I2vJfvua2fu7vb9CzVGWllvUDYAkw+Sc1HCZeozFQt5lLbrBHrV/lAUwrds
	 sSeH460hc/YeVfC2AHWasyM4b83wbuo/Tq9wjl2U=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 050F3F8049E;
	Mon, 13 Sep 2021 12:54:42 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 0420FF804AB; Mon, 13 Sep 2021 12:54:40 +0200 (CEST)
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 70DECF80132
 for <alsa-devel@alsa-project.org>; Mon, 13 Sep 2021 12:54:36 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 70DECF80132
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org
 header.b="LqpGszfc"
Received: by mail.kernel.org (Postfix) with ESMTPSA id B0C3461004;
 Mon, 13 Sep 2021 10:54:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1631530474;
 bh=CBaronYiroxiOitWnu3/lsS9n0AaVmXWm4fRuQVuEZQ=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=LqpGszfcgQvhMbh8xPL1iFBRDyfWeUBd3GxrMGbBTN1L/Pp6ZwJRMTQG1Tps2d0Mo
 phCkfV+v+XsTHGXMjYEKzoNCNwK1KmO54oT9IbNuz7hIhx55BRMc6QIT/gfCIzzNqL
 0kMRP7Z69c0dRXJtXbcHIYDgjlymVl3hC53N3dGq/rjOGgGchxr8nc2mxquqrNpQFo
 CQ7xY32MD13Z8/zjNagnHhPtMnEoeOAkycZtqs7YPJ0xAescQA2gHSjQWeTysaseWt
 bD5yU7RmLC0yOKPLTpRJ7hQMG2uXq/+0EMvFd3xCcMFSqn95yPgOp2eb5bYxjzU6hx
 Tj4M9W4780mVQ==
From: Mark Brown <broonie@kernel.org>
To: agross@kernel.org, perex@perex.cz, linux-kernel@vger.kernel.org,
 srinivas.kandagatla@linaro.org, alsa-devel@alsa-project.org,
 bgoswami@codeaurora.org, bjorn.andersson@linaro.org,
 rohitkr@codeaurora.org, devicetree@vger.kernel.org, robh+dt@kernel.org,
 lgirdwood@gmail.com, plai@codeaurora.org, tiwai@suse.com,
 linux-arm-msm@vger.kernel.org, swboyd@chromium.org,
 Srinivasa Rao Mandadapu <srivasam@codeaurora.org>, judyhsiao@chromium.org
Subject: Re: [PATCH v2] ASoC: dt-bindings: lpass: add binding headers for
 digital codecs
Date: Mon, 13 Sep 2021 11:53:14 +0100
Message-Id: <163152996586.45703.5277154686084016527.b4-ty@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <1631109831-1360-1-git-send-email-srivasam@codeaurora.org>
References: <1631109831-1360-1-git-send-email-srivasam@codeaurora.org>
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

On Wed, 8 Sep 2021 19:33:51 +0530, Srinivasa Rao Mandadapu wrote:
> Add header defining for lpass internal digital codecs rx,tx and va
> dai node id's.
> 
> 

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/1] ASoC: dt-bindings: lpass: add binding headers for digital codecs
      commit: bfad37c53ae6168d03ab06868ea44e77995c43d5

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
