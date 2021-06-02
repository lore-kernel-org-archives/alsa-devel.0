Return-Path: <SRS0=h1r5=K4=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.4 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0C59EC47083
	for <alsa-devel@archiver.kernel.org>; Wed,  2 Jun 2021 16:19:13 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0EB9461958
	for <alsa-devel@archiver.kernel.org>; Wed,  2 Jun 2021 16:19:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0EB9461958
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 8DCA316AF;
	Wed,  2 Jun 2021 18:18:20 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 8DCA316AF
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1622650750;
	bh=LawA/3q1aMafaKZX9gy63FabVMT0MHZZ5bgEoAQClME=;
	h=From:To:Subject:Date:In-Reply-To:References:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=NVYdpCKTdZvNJiV8jlSay6oEagHkh9xYb0Ix8vu13bccz9i1IWIuzAVE6BhaNfLEu
	 Kh7mBiAJqEfZRrDLuERth7pMa8QdThU7eHAPhX530c/grqS8wiF7BA04ATGEAza61t
	 1xKkKmK+xrJP4eSXtK4LrHf/migAa0a79pxzfR2o=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 015B4F8049E;
	Wed,  2 Jun 2021 18:17:31 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id D9BADF80430; Wed,  2 Jun 2021 18:17:29 +0200 (CEST)
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 1C4E5F80141
 for <alsa-devel@alsa-project.org>; Wed,  2 Jun 2021 18:17:26 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 1C4E5F80141
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org
 header.b="UQdhNlwz"
Received: by mail.kernel.org (Postfix) with ESMTPSA id DFA5D61943;
 Wed,  2 Jun 2021 16:17:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1622650645;
 bh=LawA/3q1aMafaKZX9gy63FabVMT0MHZZ5bgEoAQClME=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=UQdhNlwzJzGisCRJBCfovm/q/MHYn/xrrHbx0dkeqETCFHa/DjLo9ZdoPoiYZluk6
 AM8V8ynsEmuTjrtYSH4hcFbvsg2HxHcMxOF2cRQdAhNRtp7/O+E6qvbdLejbS8in1X
 2DjR4v+fG9T0mPy8vk5WpL9YqAmwXFbQHWH5Hl56+CDLBsptDS8xSL0NOuU9U/JpLf
 wczf6Ob2R7vsXPFiFZ2/TwNUs/WlhxWD2A0VvTwliCeLwqjGbBdx4hvFpUCqL5jcwP
 Puc0AVAgjSwOF/RlLmumUKWiusi+yFpQaJsvSidBHDcQAMAsYuWhJ7Jh20Vqrr+T3r
 lBFGJ8HmUfcDw==
From: Mark Brown <broonie@kernel.org>
To: alsa-devel@alsa-project.org,
	Shaokun Zhang <zhangshaokun@hisilicon.com>
Subject: Re: [PATCH] ASoC: sigmadsp: Remove the repeated declaration
Date: Wed,  2 Jun 2021 17:16:53 +0100
Message-Id: <162265045453.22459.7628494936017417505.b4-ty@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <1622279690-3740-1-git-send-email-zhangshaokun@hisilicon.com>
References: <1622279690-3740-1-git-send-email-zhangshaokun@hisilicon.com>
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

On Sat, 29 May 2021 17:14:50 +0800, Shaokun Zhang wrote:
> Function 'sigmadsp_reset' is declared twice, so remove the repeated
> declaration.

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/1] ASoC: sigmadsp: Remove the repeated declaration
      commit: f34cd5eb2c57c93bdd7659522da9f7f97e863a0d

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
