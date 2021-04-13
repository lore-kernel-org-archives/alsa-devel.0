Return-Path: <SRS0=Dyxj=JK=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 636F8C433B4
	for <alsa-devel@archiver.kernel.org>; Tue, 13 Apr 2021 15:10:58 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BBAC7613B6
	for <alsa-devel@archiver.kernel.org>; Tue, 13 Apr 2021 15:10:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BBAC7613B6
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id A88EF1658;
	Tue, 13 Apr 2021 17:10:04 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz A88EF1658
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1618326654;
	bh=n62q5EPfx7TlonQCJXka/eBID5Q419/EP3vdvBqEKPE=;
	h=From:To:Subject:Date:In-Reply-To:References:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=pClrkHCF8wR/KQcKAqlknl6qNpLTs5jRkkTUsd4cd1SOrqceXeiqTEwV11OmH9ksY
	 VkFakibY1469LroZZSFuHTUDMxMUe/qU8pEdHGTdfVdhj+kxjbperKmgwu5g5mkY1C
	 fjqEAE2I3TxbCTehjhV0cU4oUvgRS13TLx9GD+Vo=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 31B5BF8022B;
	Tue, 13 Apr 2021 17:10:04 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 0F8C8F8023A; Tue, 13 Apr 2021 17:09:30 +0200 (CEST)
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 6A29DF8021D
 for <alsa-devel@alsa-project.org>; Tue, 13 Apr 2021 17:09:21 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 6A29DF8021D
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org
 header.b="a/E6qyJw"
Received: by mail.kernel.org (Postfix) with ESMTPSA id 507C2613AB;
 Tue, 13 Apr 2021 15:09:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1618326557;
 bh=n62q5EPfx7TlonQCJXka/eBID5Q419/EP3vdvBqEKPE=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=a/E6qyJwBMk/HjcwnpLd5MB32RbCMYkv/JEHib6DELW+NG8rEg1ZThPOwx80jvw6t
 drmBxMFRdq1ULdWxLagnVgGc/VQbBBBf39kuDAC8qqdIvx0lzxVnoOUSwgo+NwdN5/
 SZ/7xTbo9LRX0DcVHt8/qGH2GxCEk7OeSmfSA+W1r7eer30/jAiqk1KsuSDxH9SJrl
 U9GXIcBEVD8SJ6D8to1ijr1L7uOCYY6jfFh9sAu23cZp4vRwoYVwQNEVNHoML+0br3
 eKJAcBF2bBlilDcxRakYUKC5RCYoC0LGOzfpp3fRNsK8bw1enI9lHi5HdhU4vbLmdB
 ZUC1yomeaVdlA==
From: Mark Brown <broonie@kernel.org>
To: Liam Girdwood <lgirdwood@gmail.com>, Jerome Brunet <jbrunet@baylibre.com>
Subject: Re: [PATCH] ASoC: meson: axg-frddr: fix fifo depth on g12 and sm1
Date: Tue, 13 Apr 2021 16:08:52 +0100
Message-Id: <161832446009.49152.6444814116918123903.b4-ty@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20210412132256.89920-1-jbrunet@baylibre.com>
References: <20210412132256.89920-1-jbrunet@baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Cc: alsa-devel@alsa-project.org, Kevin Hilman <khilman@baylibre.com>,
 Christian Hewitt <christianshewitt@gmail.com>, linux-kernel@vger.kernel.org,
 Mark Brown <broonie@kernel.org>, linux-amlogic@lists.infradead.org
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

On Mon, 12 Apr 2021 15:22:56 +0200, Jerome Brunet wrote:
> Previous fifo depth patch was only tested on axg, not g12 or sm1.
> Of course, while adding hw_params dai callback for the axg, I forgot to do
> the same for g12 and sm1, leaving the depth unset and breaking playback on
> these SoCs.
> 
> Add hw_params callback to the g12 dai_ops to fix the problem.

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/1] ASoC: meson: axg-frddr: fix fifo depth on g12 and sm1
      commit: 858066864a6383d1eecd2fa96a0b8e69935632f8

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
