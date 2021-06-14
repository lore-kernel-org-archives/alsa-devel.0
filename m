Return-Path: <SRS0=68EG=LI=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 143A9C2B9F4
	for <alsa-devel@archiver.kernel.org>; Mon, 14 Jun 2021 19:59:29 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7B5496124B
	for <alsa-devel@archiver.kernel.org>; Mon, 14 Jun 2021 19:59:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7B5496124B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 17D541692;
	Mon, 14 Jun 2021 21:58:37 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 17D541692
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1623700767;
	bh=lmulZGLVIGgfLTHPuc1g/ChqUK2CxHQVWiDek7Fcvx4=;
	h=From:To:Subject:Date:In-Reply-To:References:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=HP5F/EBppZ6lwEIvw+IWSfMgKygVg8BWWdoIIrwfG8f8fAuZKyswdl2M5GOnGGlI5
	 fG6LQ7uy0GIEJNK1/m2gGtMdoGhdGUd8c452IDweekhBp2max5IYvA4cfJ9HE0nZhi
	 yegwN4vy77EgT0ZJ5pijvWJzspY/WXMTDEU+2bgM=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 11C2DF80510;
	Mon, 14 Jun 2021 21:55:14 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 72F59F80511; Mon, 14 Jun 2021 21:55:13 +0200 (CEST)
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 0D140F80506
 for <alsa-devel@alsa-project.org>; Mon, 14 Jun 2021 21:55:11 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 0D140F80506
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org
 header.b="m24IE0P8"
Received: by mail.kernel.org (Postfix) with ESMTPSA id 8522861246;
 Mon, 14 Jun 2021 19:55:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1623700509;
 bh=lmulZGLVIGgfLTHPuc1g/ChqUK2CxHQVWiDek7Fcvx4=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=m24IE0P8yQ6et73WXk2Ee9oJZHR7XXd11fxTb3ApdeMumDT30IQ0/F8b5cdEDNMvE
 LoE6VRiTJqnu+SBRrqF+HGjzBEOPQO54S7Z9PCCKOE4OUOJMJSJkOCeaoMnXNqcT45
 S7k/DDm40bcWxjfRIMzu5kWQUC04tHAMtFsHa4tDZ1MlkyW+NQwHwrdaqBqiIo/3AI
 TxEHOo6cJwsI7I3U1iOaK2gWf4/617RyadFg50IyDLj2vsI1SW05ITB2PmP7dztaOw
 bEz2NEz+g2n6WmXBe9bkMGf8GbmX8tT0BE45IqbExMHWH+E6DREV6YInmpav4Q5BLt
 dLOI8euWndE+g==
From: Mark Brown <broonie@kernel.org>
To: Marek Vasut <marex@denx.de>,
	devicetree@vger.kernel.org
Subject: Re: [PATCH] dt-bindings: ASoC: sgtl5000: Add audio-graph-card port
Date: Mon, 14 Jun 2021 20:53:48 +0100
Message-Id: <162369994009.34524.17249754614402570910.b4-ty@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20210610150135.29905-1-marex@denx.de>
References: <20210610150135.29905-1-marex@denx.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Cc: Rob Herring <robh+dt@kernel.org>, alsa-devel@alsa-project.org,
 Mark Brown <broonie@kernel.org>, Fabio Estevam <festevam@gmail.com>,
 kernel@dh-electronics.com
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

On Thu, 10 Jun 2021 17:01:35 +0200, Marek Vasut wrote:
> The SGTL5000 codec can be connected via audio-graph-card,
> add the missing port: entry into the bindings.

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/1] dt-bindings: ASoC: sgtl5000: Add audio-graph-card port
      commit: f1905ab2a8a2103b7fa74a5f96fb50cce0dee6f5

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
