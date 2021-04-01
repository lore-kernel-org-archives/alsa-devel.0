Return-Path: <SRS0=rMx/=I6=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 06D66C433ED
	for <alsa-devel@archiver.kernel.org>; Thu,  1 Apr 2021 16:18:03 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 56581611BD
	for <alsa-devel@archiver.kernel.org>; Thu,  1 Apr 2021 16:18:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 56581611BD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id C43DF16C5;
	Thu,  1 Apr 2021 18:17:10 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz C43DF16C5
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1617293880;
	bh=zp3Tpu+kUph5azbHKo/cVTxK4hhcTlET7aKDSzeCMns=;
	h=From:To:Subject:Date:In-Reply-To:References:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=XPsOjhrAk7cTcqUjJhSh92dQ5Yphnr3vxfj/0nJ0mdpZK3fR4CCKCplG2bLe7SKRx
	 ICooSM+UQovP3bWqVcZiqQacwI9UiVDCs9hwYOv/sKkAzKMuPVThfkKxOccJbzybk2
	 b3TszuFz5zIAjP9kvhhRdiLtVTuaDMnA3Ur11wUk=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id E5D4EF8027B;
	Thu,  1 Apr 2021 18:16:18 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id CB09EF8013F; Thu,  1 Apr 2021 18:16:16 +0200 (CEST)
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 68E1AF8013F
 for <alsa-devel@alsa-project.org>; Thu,  1 Apr 2021 18:16:08 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 68E1AF8013F
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org
 header.b="lNvRf4e1"
Received: by mail.kernel.org (Postfix) with ESMTPSA id B32FA61378;
 Thu,  1 Apr 2021 16:16:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1617293765;
 bh=zp3Tpu+kUph5azbHKo/cVTxK4hhcTlET7aKDSzeCMns=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=lNvRf4e1Nfc9GKuGcUaN0ir9vETDIpMi2U79MnBc+Q9xG1hMQob7fpW60rM/cjylH
 szalDlN1ciZWkh+Q0ZIo0gqLQ7OxmpIynxKR16ev4hbo/5inHWcwz8upmKy1HuQwZU
 HjHqQ9+9qXmHBfCjTTKgqEOn47JAou1pLETdRxbPJNpUdZQZgETOBtAfPdWJWeeOMq
 kMBrc7EO7Wf/OEiVc/6ekKGT/7wgFOa5N5jAtmF3LXIKrl5NWhnZBNo8nZv6SAU4Vk
 e249Fxae46RERG1LghVZl5E6vGnxmP7qA6zVMtM7tHaZDORrgl9PGffEuuwEwRwpNv
 m3Q8Gd1ZH88gA==
From: Mark Brown <broonie@kernel.org>
To: devicetree <devicetree@vger.kernel.org>,
 alsa-devel <alsa-devel@alsa-project.org>,
 Zhen Lei <thunder.leizhen@huawei.com>,
 linux-kernel <linux-kernel@vger.kernel.org>,
 Liam Girdwood <lgirdwood@gmail.com>, Rob Herring <robh+dt@kernel.org>
Subject: Re: [PATCH 1/1] ASoC: intel,
 keembay-i2s: Fix a dt_binding_check warning
Date: Thu,  1 Apr 2021 17:15:47 +0100
Message-Id: <161729333651.31618.6325079972879808660.b4-ty@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20210329081435.2200-1-thunder.leizhen@huawei.com>
References: <20210329081435.2200-1-thunder.leizhen@huawei.com>
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

On Mon, 29 Mar 2021 16:14:35 +0800, Zhen Lei wrote:
> The property "dmas" contains two items: DMA "TX" and "RX" channel,
> Therefore, its value also needs to be written in two parts.
> 
> Otherwise, below YAML check warning is reported:
> Documentation/devicetree/bindings/sound/intel,keembay-i2s.example.dt.yaml:\
> i2s@20140000: dmas: [[4294967295, 29, 4294967295, 33]] is too short

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/1] ASoC: intel, keembay-i2s: Fix a dt_binding_check warning
      commit: 52cad756b777e82fabe05c728cc62b63b3c61fd3

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
