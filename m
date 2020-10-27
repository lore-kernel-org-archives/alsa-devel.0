Return-Path: <SRS0=gpx6=EC=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7AAE5C388F9
	for <alsa-devel@archiver.kernel.org>; Tue, 27 Oct 2020 20:41:24 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 81AF220791
	for <alsa-devel@archiver.kernel.org>; Tue, 27 Oct 2020 20:41:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="Y2rmjoPd";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="JyinfZlG"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 81AF220791
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id C170816AF;
	Tue, 27 Oct 2020 21:40:31 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz C170816AF
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1603831281;
	bh=OioNNIMpmE73+hdu17irdscY8n2O0KgLmga33QfwV9k=;
	h=Date:From:To:In-Reply-To:References:Subject:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=Y2rmjoPdPZ0hbvja03UjEyfS/agqepQaW8rh1ksfO5F8V0rvMIPe2qhCh7HpHw3PY
	 K89533gUZfgdOcmQXPegj0ti+lFnZ6jEiXDhtRhlIYcmrCRcXCs7DrO2FdzpSBaKeh
	 +i2kQyXo2pnzLAY0QnLdw3ztU/uREch35i1eIiq0=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 369B1F80227;
	Tue, 27 Oct 2020 21:39:45 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 296A0F80227; Tue, 27 Oct 2020 21:39:37 +0100 (CET)
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 7BBD2F80217
 for <alsa-devel@alsa-project.org>; Tue, 27 Oct 2020 21:39:34 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 7BBD2F80217
Authentication-Results: alsa1.perex.cz;
 dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org
 header.b="JyinfZlG"
Received: from localhost (fw-tnat.cambridge.arm.com [217.140.96.140])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id 219C420725;
 Tue, 27 Oct 2020 20:39:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1603831172;
 bh=OioNNIMpmE73+hdu17irdscY8n2O0KgLmga33QfwV9k=;
 h=Date:From:To:Cc:In-Reply-To:References:Subject:From;
 b=JyinfZlG2CozbpmBQ6+cM9Yb/0avAmc9+61oDeEOKKDUHeeQzElkfQyIDwpzfIBgC
 2xQlKrFvAS6gksWtKBMBgqCUuCnX6BG27mjIVAQTJmJKI/AIBteAZjoNPclxqFAah9
 Dn6Ms/BwgMpixxJtXW2Yrxd8WFL6jtDdiAFz7ols=
Date: Tue, 27 Oct 2020 20:39:27 +0000
From: Mark Brown <broonie@kernel.org>
To: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
In-Reply-To: <20201027111526.12326-1-srinivas.kandagatla@linaro.org>
References: <20201027111526.12326-1-srinivas.kandagatla@linaro.org>
Subject: Re: [PATCH v2] ASoC: qcom: qdsp6: make use of
 devm_of_platform_populate
Message-Id: <160383115673.25818.13026629187393927150.b4-ty@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Cc: alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
 lgirdwood@gmail.com
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

On Tue, 27 Oct 2020 11:15:26 +0000, Srinivas Kandagatla wrote:
> make use of devm_of_platform_populate to remove some redundant code!

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/1] ASoC: qcom: qdsp6: make use of devm_of_platform_populate
      commit: 023e1b1f1164a5e2da2ad20588cf164de9ef67bb

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
