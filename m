Return-Path: <SRS0=Cjbi=KG=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2669EC433B4
	for <alsa-devel@archiver.kernel.org>; Tue, 11 May 2021 08:31:19 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5DB04613CF
	for <alsa-devel@archiver.kernel.org>; Tue, 11 May 2021 08:31:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5DB04613CF
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id B8AF11783;
	Tue, 11 May 2021 10:30:25 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz B8AF11783
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1620721875;
	bh=aIbKrZTp+E6EVIDHCNWvzoJpW7zVJeecbnlZyRKFuck=;
	h=From:To:Subject:Date:In-Reply-To:References:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=h3UKDsCQ4AZjj/ZhHoFCwPWX7OqVtiCdUswKt6S4dvSdEcsMFVYgdmTt7ixQezynm
	 3HvWjSFjIjzfQz66/nYhRmZedI3dUtdBF2GZKe3bF0l9R66YBEUN92Em4aApzAdQb6
	 RSKCWDFd+eeahUn1bszwHluC2xtI9Om8LY0NoJZo=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 16BE3F80163;
	Tue, 11 May 2021 10:28:21 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 2721BF804AF; Tue, 11 May 2021 10:27:50 +0200 (CEST)
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 86CD5F804AC
 for <alsa-devel@alsa-project.org>; Tue, 11 May 2021 10:27:46 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 86CD5F804AC
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org
 header.b="Jk/YdMVZ"
Received: by mail.kernel.org (Postfix) with ESMTPSA id 91A6E61107;
 Tue, 11 May 2021 08:27:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1620721664;
 bh=aIbKrZTp+E6EVIDHCNWvzoJpW7zVJeecbnlZyRKFuck=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=Jk/YdMVZ7Q5F4MdPuwZwTMDGhDedzAF3Uo4XIes00YTrJwb0XrjDrHlpKmk84n/aR
 xegkHek9ygsElz5tUP5BuVytq09QhG5kx249XL7QsPoGO6e653eQu/cgyS0jTX/MRh
 /wSPtlVWPG679y8pa8Bv4ES8Suo3UKobYQxGov3Km70EXsQ3rIzshR+IiTQk0g5yjs
 tbQml0CbcfEj7FowDU4KCz2ff31xi+YZAKnXGKWiFmpMTh9Pu0xFrVlGdGj4xktsOV
 wZBim14CTApR5Apquoih+LyUIfTdD8VoFG569CWfG2siHzt40OHYQ+JVxyHsrsHtbE
 ZtrhJNEu0hmvA==
From: Mark Brown <broonie@kernel.org>
To: festevam@gmail.com, alsa-devel@alsa-project.org,
 Shengjiu Wang <shengjiu.wang@nxp.com>, perex@perex.cz,
 nicoleotsuka@gmail.com, timur@kernel.org, Xiubo.Lee@gmail.com,
 tiwai@suse.com
Subject: Re: [PATCH] ASoC: fsl_spdif: add support for enabling raw capture mode
Date: Tue, 11 May 2021 09:25:50 +0100
Message-Id: <162072058167.33157.3402941285699720192.b4-ty@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <1619425444-8666-1-git-send-email-shengjiu.wang@nxp.com>
References: <1619425444-8666-1-git-send-email-shengjiu.wang@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Cc: Mark Brown <broonie@kernel.org>, linuxppc-dev@lists.ozlabs.org,
 linux-kernel@vger.kernel.org
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

On Mon, 26 Apr 2021 16:24:04 +0800, Shengjiu Wang wrote:
> Since i.MX8MM SPDIF interface is able to capture raw data.
> Add support in SPDIF driver for this functionality.

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/1] ASoC: fsl_spdif: add support for enabling raw capture mode
      commit: 604e5178444ea1d8053cf073e2c68fbc73a4e142

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
