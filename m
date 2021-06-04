Return-Path: <SRS0=evnw=K6=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6A2BDC47424
	for <alsa-devel@archiver.kernel.org>; Fri,  4 Jun 2021 16:35:22 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 89C9261153
	for <alsa-devel@archiver.kernel.org>; Fri,  4 Jun 2021 16:35:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 89C9261153
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 8F351174C;
	Fri,  4 Jun 2021 18:34:29 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 8F351174C
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1622824519;
	bh=4qXiY0ciKLP8LPX9zwj+/O79WshKW6bFYbB9k+rr5Gk=;
	h=From:To:Subject:Date:In-Reply-To:References:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=RLEsKyyfhRcqBQmcHkMw7Uf1vGJVlmmlsKCdbhfGzWvgVah62ShwXOzMsdzKRVxHe
	 Jmy8auaYFTOGTSjft+ouCNUmn3dt4yXd/KoH1D6YdSFZKXMzKTHUvxuK+qRjWuwIZU
	 ImvlpVial2nSlq7KRxVUbPBpmQDaghrOiUsd931o=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 47EB3F804C2;
	Fri,  4 Jun 2021 18:33:03 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 2525AF802A9; Fri,  4 Jun 2021 18:33:01 +0200 (CEST)
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 55CE8F80430
 for <alsa-devel@alsa-project.org>; Fri,  4 Jun 2021 18:32:58 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 55CE8F80430
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org
 header.b="HwtV6jPR"
Received: by mail.kernel.org (Postfix) with ESMTPSA id 2802D6140C;
 Fri,  4 Jun 2021 16:32:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1622824377;
 bh=4qXiY0ciKLP8LPX9zwj+/O79WshKW6bFYbB9k+rr5Gk=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=HwtV6jPRg1YTWDq0sK7oOGwUqxTv8oLwHuJlg5wQrm6crM7l3QpmBhdzNszQzh2K1
 plxPgahDzBrwghBY4SkFclKkT5Kq+InJzrj5ytX7GYP3GD489FA73u9Z4QO32/ZTv+
 K5pgKN8zeR+HDvy8k6BnvFOdxoa4+axXETKSlHPFDLYAEEYiEgPgW6LaQYwyF627Zb
 YGtV/l7XVKjctgPDhu2Uvav96JjSZPK2u1TgLB2Uc6OWseKeo7RylZVQKSH7UAH7y8
 y3BNLWoc5YcPLeGwkvUE6GXnbcUih2dvotNcoHUKUy0mp1s2q2iv/j8c0RC0E17aVY
 tv/mhxIp9hp8A==
From: Mark Brown <broonie@kernel.org>
To: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Subject: Re: [PATCH v3 0/4] ASoC: codecs: wcd934x: add Headset and button
 detection support
Date: Fri,  4 Jun 2021 17:32:30 +0100
Message-Id: <162282419357.38836.12886872942740552175.b4-ty@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20210604115230.23259-1-srinivas.kandagatla@linaro.org>
References: <20210604115230.23259-1-srinivas.kandagatla@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Cc: robh@kernel.org, alsa-devel@alsa-project.org, devicetree@vger.kernel.org,
 lgirdwood@gmail.com, linux-kernel@vger.kernel.org,
 Mark Brown <broonie@kernel.org>
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

On Fri, 4 Jun 2021 12:52:26 +0100, Srinivas Kandagatla wrote:
> This patchset adds support to MBHC(Multi Button Headset Control) block found in
> Qualcomm WCD codecs. MBHC support headset type detection, both Mechanical and
> electrical insert/removal detection along with 8 buttons detection,
> Over current interrupts on HPHL/R, Impedance Measurements on HPHL/R.
> 
> Eventhough MBHC block supports things like OverCurrent detection, Currently its
> reported as a kernel debug message. Should this be reported as an uevent to
> userspace? like the way USB reports?
> Any suggestions?
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/4] ASoC: dt-bindings: wcd934x: add bindings for Headset Button detection
      commit: c6d25d5786090edc7299b32160644bb2e468c25d
[2/4] ASoC: codecs: wcd: add multi button Headset detection support
      commit: 0e5c9e7ff899808afa4e2b08c2e6ccc469bed681
[3/4] ASoC: codecs: wcd934x: add mbhc support
      commit: 9fb9b1690f0ba6b2c9ced91facc1fc44f5a0d5c1
[4/4] ASoC: qcom: sdm845: add jack support for WCD934x
      commit: c15d4b72098ca3055d98ce0d66127fe37a6a6361

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
