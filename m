Return-Path: <SRS0=kZkJ=FP=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2E326C4361B
	for <alsa-devel@archiver.kernel.org>; Fri, 11 Dec 2020 17:52:42 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8C76E23EF3
	for <alsa-devel@archiver.kernel.org>; Fri, 11 Dec 2020 17:52:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8C76E23EF3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 277811740;
	Fri, 11 Dec 2020 18:51:50 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 277811740
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1607709160;
	bh=yPL5e6OBDUX4abp+aurcofifMg+d5TgRFGoEiUuCnkA=;
	h=From:To:In-Reply-To:References:Subject:Date:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=LGgUmeWq54u53XYTUTxgNKzKfR11ICZImjr4JeQP2NFKYcj4MTgxIak6S+GaPFCBP
	 Vsd/GZnl73NXqz8sB2+Cs+3zSn/rSn+sj5aiIqueX9C1osc9+TdD37pk43WxfLWtD6
	 E42MYaJIXVFIkfFIWgcxKWq1mOl1EOhppH2RhJUg=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 33E59F804E1;
	Fri, 11 Dec 2020 18:50:11 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id BF65EF804E3; Fri, 11 Dec 2020 18:50:10 +0100 (CET)
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 89DCCF804DF
 for <alsa-devel@alsa-project.org>; Fri, 11 Dec 2020 18:50:08 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 89DCCF804DF
From: Mark Brown <broonie@kernel.org>
Authentication-Results: mail.kernel.org;
 dkim=permerror (bad message/signature format)
To: Tzung-Bi Shih <tzungbi@google.com>
In-Reply-To: <20201211051224.2307349-1-tzungbi@google.com>
References: <20201211051224.2307349-1-tzungbi@google.com>
Subject: Re: [PATCH v3 0/2] ASoC: rt1015p: delay 300ms for waiting calibration
Message-Id: <160770898112.26354.6573689046730156511.b4-ty@kernel.org>
Date: Fri, 11 Dec 2020 17:49:41 +0000
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Cc: alsa-devel@alsa-project.org
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

On Fri, 11 Dec 2020 13:12:22 +0800, Tzung-Bi Shih wrote:
> The 1st patch moves SDB control from DAI ops trigger to DAPM event
> (per review comments in v1).
> 
> The 2nd patch adds the 300ms delay for waiting calibration.
> 
> Changes from v2:
> - Use gpiod_set_value_cansleep() instead of gpiod_set_value().
> (https://patchwork.kernel.org/project/alsa-devel/patch/20201210033617.79300-2-tzungbi@google.com/)
> - Assuming the calibration state gets lost after system suspend.
> (https://patchwork.kernel.org/project/alsa-devel/patch/20201210033617.79300-3-tzungbi@google.com/)
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/2] ASoC: rt1015p: move SDB control from trigger to DAPM
      commit: 4ab9301710760b99b4229d608eb5599040b2e07e
[2/2] ASoC: rt1015p: delay 300ms after SDB pulling high for calibration
      commit: f102d0d173982be3fc096d0293c1c0245e988ba6

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
