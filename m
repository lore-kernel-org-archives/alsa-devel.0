Return-Path: <SRS0=KNeL=FW=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 77BD2C4361B
	for <alsa-devel@archiver.kernel.org>; Fri, 18 Dec 2020 12:19:07 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4C45D2395C
	for <alsa-devel@archiver.kernel.org>; Fri, 18 Dec 2020 12:19:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4C45D2395C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 78E851769;
	Fri, 18 Dec 2020 13:18:14 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 78E851769
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1608293944;
	bh=ZSV3eWWJGKKj6sLb/XSTSMSm+F9uNhVueYm4dkmlXKI=;
	h=From:To:In-Reply-To:References:Subject:Date:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=KB8ZbluG+6e2JFBa3f9JkFfj/+Knyx5B+T58pIyCIxzCBgihfZ5EUCy/RDmHxrMYE
	 MJBXOaMQAmZQ4914at9/DBGZqaqp+upG6/dYzrhsqPLX/IZP09DNQTJL6SHM1CMhaA
	 Swa177z0SfNwZbxJL58erARnqdM2PZMnB4uBAoYE=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 05607F804C2;
	Fri, 18 Dec 2020 13:16:50 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id DC48DF804CA; Fri, 18 Dec 2020 13:16:48 +0100 (CET)
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 7EDA5F804C2
 for <alsa-devel@alsa-project.org>; Fri, 18 Dec 2020 13:16:46 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 7EDA5F804C2
From: Mark Brown <broonie@kernel.org>
Authentication-Results: mail.kernel.org;
 dkim=permerror (bad message/signature format)
To: alsa-devel@alsa-project.org, tiwai@suse.com,
 Srinivasa Rao Mandadapu <srivasam@codeaurora.org>, plai@codeaurora.org,
 devicetree@vger.kernel.org, rohitkr@codeaurora.org, lgirdwood@gmail.com,
 linux-kernel@vger.kernel.org, bjorn.andersson@linaro.org,
 srinivas.kandagatla@linaro.org, agross@kernel.org, robh+dt@kernel.org,
 linux-arm-msm@vger.kernel.org, bgoswami@codeaurora.org, perex@perex.cz
In-Reply-To: <1606929748-16828-1-git-send-email-srivasam@codeaurora.org>
References: <1606929748-16828-1-git-send-email-srivasam@codeaurora.org>
Subject: Re: [PATCH v5 0/2] Platform driver update to support playback recover
 after resume
Message-Id: <160829377016.10885.14131365889928811294.b4-ty@kernel.org>
Date: Fri, 18 Dec 2020 12:16:10 +0000
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

On Wed, 2 Dec 2020 22:52:26 +0530, Srinivasa Rao Mandadapu wrote:
> This patch set is to add support for playback recover after hard suspend and resume.
> It includes:
> 1. Reverting part of previous commit, which is for handling registers invalid state
> after hard suspend.
> 2. Adding pm ops in component driver and do regcache sync.
> Changes Since v1 and v2:
>   -- Subject lines changed
> Changes Since v3:
>   -- Patch is splitted into 2 patches
> Changes Since v4:
>   -- Subject lines changed
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/2] ASoC: qcom: Fix incorrect volatile registers
      commit: 315fbe4cef98ee5fb6085bc54c7f25eb06466c70
[2/2] ASoC: qcom: Add support for playback recover after resume
      commit: 8d1bfc04c97407767559f6389a0f0fb060cbe25e

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
