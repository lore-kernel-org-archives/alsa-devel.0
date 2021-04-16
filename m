Return-Path: <SRS0=6+tk=JN=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5144FC433ED
	for <alsa-devel@archiver.kernel.org>; Fri, 16 Apr 2021 18:36:00 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A07D7610FB
	for <alsa-devel@archiver.kernel.org>; Fri, 16 Apr 2021 18:35:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A07D7610FB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 3B6F616D6;
	Fri, 16 Apr 2021 20:35:06 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 3B6F616D6
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1618598156;
	bh=s1jF8f/YwSM7iQj2NFyAZcn8VnPfgVcOIVtxUHM8KIE=;
	h=From:To:Subject:Date:In-Reply-To:References:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=S7uycngQmBjnFuN9p+bqjcMu5t3/Q7JSWh6gcHj+oipHGORXc58HTWmUMTzjjvB83
	 BgzbnJdwLbynpgLlpbans5qLyU5SyY1koUoIi0DTIUj6BqweAZid5tBIB6zzqNha5Z
	 L5u61gS8M+Hgiq0j++xEVbWMXMNg17tTpek9mMqk=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id B2171F8025B;
	Fri, 16 Apr 2021 20:35:05 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 0AC1DF80269; Fri, 16 Apr 2021 20:35:04 +0200 (CEST)
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id E0911F800FF
 for <alsa-devel@alsa-project.org>; Fri, 16 Apr 2021 20:34:59 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz E0911F800FF
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org
 header.b="NmNYQkhP"
Received: by mail.kernel.org (Postfix) with ESMTPSA id 85992610FC;
 Fri, 16 Apr 2021 18:34:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1618598097;
 bh=s1jF8f/YwSM7iQj2NFyAZcn8VnPfgVcOIVtxUHM8KIE=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=NmNYQkhPNsJLqMKdkysMraciLH99iKAS+KfOwvNlZj/70c2EfYKqKfvWWrcZC2uMk
 EbfP9OGMvx6orCC33Fetmg3clIj73bW9mL8dpOBb/7vFZ+SFBjcorY7Y8NVgCHlxn3
 5VOfKsBdlkiEvwWYyGrdZZ00Wm/OxODoicGjlcsUO6e/9npXPJPMcsceNXOIXJYok+
 9eeU/q2bDjHcrvhFfEujzsne9S8hldpGift56ALSOsoOreK9/IqJ/vntADd32JPDfS
 XgeKVuYvydQHkU3J5M7iFbNwsus6sDAri0ASM/Ob65ltkCr1G/DfhnNeWkmTdpHwMP
 R6/fqQzJRbMMg==
From: Mark Brown <broonie@kernel.org>
To: Rob Herring <robh@kernel.org>
Subject: Re: [PATCH] Revert "ASoC: mt6359: add ASoC mt6359 ASoC accdet jack
 document"
Date: Fri, 16 Apr 2021 19:34:30 +0100
Message-Id: <161859792866.33058.12744070673579269607.b4-ty@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20210416180118.3662904-1-robh@kernel.org>
References: <20210416180118.3662904-1-robh@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Cc: devicetree@vger.kernel.org, alsa-devel@alsa-project.org,
 Argus Lin <argus.lin@mediatek.com>, Liam Girdwood <lgirdwood@gmail.com>,
 Mark Brown <broonie@kernel.org>, linux-mediatek@lists.infradead.org,
 Matthias Brugger <matthias.bgg@gmail.com>,
 linux-arm-kernel@lists.infradead.org
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

On Fri, 16 Apr 2021 13:01:18 -0500, Rob Herring wrote:
> This reverts commit e61c589587c772c5f672b22683c3e0b38be20702.
> 
> The binding document has lots of schema errors and there's been no
> effort to fix them, so let's remove it.

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/1] Revert "ASoC: mt6359: add ASoC mt6359 ASoC accdet jack document"
      commit: d63f2a88d5cfaad025f26e1107f3807d579654c5

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
