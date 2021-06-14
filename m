Return-Path: <SRS0=68EG=LI=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BB227C2B9F4
	for <alsa-devel@archiver.kernel.org>; Mon, 14 Jun 2021 19:56:34 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AC2E0611CE
	for <alsa-devel@archiver.kernel.org>; Mon, 14 Jun 2021 19:56:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AC2E0611CE
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id BFEEE1686;
	Mon, 14 Jun 2021 21:55:41 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz BFEEE1686
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1623700591;
	bh=rHsL5zO3qV53Kq7tZnvcepUF9YN1NPGgwiK41SgDBH0=;
	h=From:To:Subject:Date:In-Reply-To:References:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=cbAWoBUarGi5PdtDs3d/v1e4oOLHiJbn0GtYJ9MHiL0lMH+8YJuKeMEU4sy4vCeVk
	 jy4FTThmK2GcAkSrqMuV1sKnW9bBgfbIm+iKyRULetVTp5d8vscWeVv58+nsKjCvlr
	 X1bHGhoWcpxXKphiMH1aA0dLCU4oS16AuI/1INkM=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 443A8F804C3;
	Mon, 14 Jun 2021 21:54:54 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 08531F804B0; Mon, 14 Jun 2021 21:54:49 +0200 (CEST)
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id DBC77F800F7
 for <alsa-devel@alsa-project.org>; Mon, 14 Jun 2021 21:54:44 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz DBC77F800F7
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org
 header.b="XpPn7BKk"
Received: by mail.kernel.org (Postfix) with ESMTPSA id A3AC861246;
 Mon, 14 Jun 2021 19:54:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1623700483;
 bh=rHsL5zO3qV53Kq7tZnvcepUF9YN1NPGgwiK41SgDBH0=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=XpPn7BKkmczHCNV9PTcTZP5wyFted1Gbw6E+R3Ai6nW+EJ8Oyd2i+PjZE33tXJ8BV
 6uj+e/LvozNWq+7RRKAD+AxUitN4SLXCjfhpvjOObsjVjiOfqSEapxgamJY3CdfAiI
 vIXv7U99SBanQRMf3sPoD8JPPA9JEXTixZWaNHhRksX2NOvicQSs2RxSLt3TLzLjZa
 fKbKK6vklApx+bahGb/QR9ELSXW9eA/PnI5SUhmcHPI1DdP/FC1Mpn09JGJwJJhkxy
 wZVzn4VXRi9Pg1jyj4c5HBgUgFnzNGlukiIqFWLDma7Wr5MZtOeupZplYaDD51zUnk
 U5tXHYpWdjFcA==
From: Mark Brown <broonie@kernel.org>
To: linux-kernel@vger.kernel.org, Yang Yingliang <yangyingliang@huawei.com>,
 alsa-devel@alsa-project.org
Subject: Re: [PATCH -next] ASoC: atmel-classd: Use
 devm_platform_get_and_ioremap_resource()
Date: Mon, 14 Jun 2021 20:53:40 +0100
Message-Id: <162369994009.34524.9266310956959429482.b4-ty@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20210611022115.3583765-1-yangyingliang@huawei.com>
References: <20210611022115.3583765-1-yangyingliang@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Cc: codrin.ciubotariu@microchip.com, Mark Brown <broonie@kernel.org>,
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

On Fri, 11 Jun 2021 10:21:15 +0800, Yang Yingliang wrote:
> Use devm_platform_get_and_ioremap_resource() to simplify
> code.

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/1] ASoC: atmel-classd: Use devm_platform_get_and_ioremap_resource()
      commit: 9494d059971c5120c60bbe4aae5cba00b20ed774

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
