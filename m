Return-Path: <SRS0=Cjbi=KG=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.7 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 995C6C433B4
	for <alsa-devel@archiver.kernel.org>; Tue, 11 May 2021 08:34:27 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0342561184
	for <alsa-devel@archiver.kernel.org>; Tue, 11 May 2021 08:34:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0342561184
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id E1EBA1777;
	Tue, 11 May 2021 10:33:34 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz E1EBA1777
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1620722065;
	bh=Gk+CeoyFxhnPqAe46i/l9FnGdGx8TtOSVBjRZoBk/4I=;
	h=From:To:Subject:Date:In-Reply-To:References:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=agIjWfXpU6vb7gsN2S7QthrpCc90g0J42hhbAhGUAwGJUvEzxpn44XmnHZXP633Ks
	 LPL8asIaqSZ+PcR886MC1QXVEwMgmt91UQvFKL61vJqQutGc5cPDU+x8EqP67AoWZG
	 ZkreTOYV1VmzJDqoYOxg4bd2eIuqoSETgdd+yDhw=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id B76C8F80516;
	Tue, 11 May 2021 10:28:40 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 2F7B5F804D1; Tue, 11 May 2021 10:28:16 +0200 (CEST)
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 8EBE4F80163
 for <alsa-devel@alsa-project.org>; Tue, 11 May 2021 10:28:13 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 8EBE4F80163
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org
 header.b="ixOvwSZ3"
Received: by mail.kernel.org (Postfix) with ESMTPSA id BD34661946;
 Tue, 11 May 2021 08:28:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1620721691;
 bh=Gk+CeoyFxhnPqAe46i/l9FnGdGx8TtOSVBjRZoBk/4I=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=ixOvwSZ3oJ/owYJUpffCkc6eJNTdy5I9Pd+rYepv+0icFNmQjK9560v0fvwRMORKy
 PTbvixRF7boG0HmynEMhKGAYYdhoG5A9DiBVCPcH4xzus+VVcrVfh+LvOMkbDVZEPW
 QeXMnnC2a4FNmSEPuGFazxG3qgsuOeIoJiVyZ8woIto7OXxhpAOKM+aYmGpB0LVmKO
 46FeKz7PekHvZ06L8HH2jGpTpurztxLSewBPsJn+ZxiFyFg7W4dlBGsHRe2oeC2vBT
 l9pWXxon1Az7FNEPrgaLGCjN9T4HFaD+Vk3gWy3zmDx5l1fuxY7fv6nEE+2VBY1npm
 cxDY2+5yqm1Vg==
From: Mark Brown <broonie@kernel.org>
To: Zhen Lei <thunder.leizhen@huawei.com>,
 linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
 Liam Girdwood <lgirdwood@gmail.com>,
 linux-mediatek <linux-mediatek@lists.infradead.org>,
 alsa-devel <alsa-devel@alsa-project.org>, Takashi Iwai <tiwai@suse.com>,
 Jaroslav Kysela <perex@perex.cz>, Matthias Brugger <matthias.bgg@gmail.com>
Subject: Re: [PATCH 1/1] ASoC: mediatek: mt8192: Delete a redundant condition
 branch
Date: Tue, 11 May 2021 09:25:59 +0100
Message-Id: <162072058170.33157.6826486921095760961.b4-ty@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20210510083640.3368-1-thunder.leizhen@huawei.com>
References: <20210510083640.3368-1-thunder.leizhen@huawei.com>
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

On Mon, 10 May 2021 16:36:40 +0800, Zhen Lei wrote:
> The statement of the "if (afe_priv->mtkaif_protocol == MTKAIF_PROTOCOL_2)"
> branch is the same as the "else" branch. Delete it to simplify code.
> 
> No functional change.

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/1] ASoC: mediatek: mt8192: Delete a redundant condition branch
      commit: 85c966dc97d1c46a3079ec4c26714c9f8ec66823

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
