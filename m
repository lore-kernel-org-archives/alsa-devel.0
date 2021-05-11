Return-Path: <SRS0=Cjbi=KG=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 72CAFC433ED
	for <alsa-devel@archiver.kernel.org>; Tue, 11 May 2021 08:30:33 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C033061107
	for <alsa-devel@archiver.kernel.org>; Tue, 11 May 2021 08:30:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C033061107
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 370F11726;
	Tue, 11 May 2021 10:29:40 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 370F11726
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1620721830;
	bh=Zg/C2BzPmYubKX+vJ/fPZqWYGhekjqvsMIAJOQaFDkE=;
	h=From:To:Subject:Date:In-Reply-To:References:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=Phmonp1GuY0WrxcbrDMXaTv46di89eZwgxxi7QhYeUwTq1vU1hH/CIUKfrNx6CZ6A
	 JvdtR+gtHUko0+6RuI/XGb63ORjL55PoV9OJMxMNSMlKEo9ZQbZ1NyF3yGW1vqpVNF
	 bH659En+znevHAz0uD4eoAPG5YljA9OoYPD6696k=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id C5572F804AE;
	Tue, 11 May 2021 10:27:50 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 50AF5F804AF; Tue, 11 May 2021 10:27:48 +0200 (CEST)
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id B5550F80482
 for <alsa-devel@alsa-project.org>; Tue, 11 May 2021 10:27:40 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz B5550F80482
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org
 header.b="S/TWD4KJ"
Received: by mail.kernel.org (Postfix) with ESMTPSA id 8A5BD613C3;
 Tue, 11 May 2021 08:27:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1620721658;
 bh=Zg/C2BzPmYubKX+vJ/fPZqWYGhekjqvsMIAJOQaFDkE=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=S/TWD4KJ3xQUwr7fKcfNY+QO+QS20RueoZQZs/jp0C1S97el0jZ8NFFgiTcy7DyT7
 nHuGwj0S5enWZmPJLvrJaI2Xavd91LgnPp+sNLBtUgjsAO9N4NGU+vd7YZBl9Wf3Sx
 ZBRAs+Sd8VL5z/H86CKvjvZAT7abqYbuLSJo3jPLTcVKid+Cfl6gKwJQrEjBCHrEqw
 WZ+kX8vO9+1Wqeh6BoxaxtvzJnDNTCqUmTZCQe7z38sGhIpiJDW9tIvHuAx3l4FbCj
 bX05L6Y7IiSVx8PlH0xthgZbve1IgE28APfJS+dT9VRR7E/p+wyVZIVNVwrD4eVLPw
 jVYZhavbOjatw==
From: Mark Brown <broonie@kernel.org>
To: lgirdwood@gmail.com,
	derek.fang@realtek.com
Subject: Re: [PATCH] ASoC: rt1019: Add non_legacy_dai_naming config
Date: Tue, 11 May 2021 09:25:48 +0100
Message-Id: <162072058168.33157.5718955718774506859.b4-ty@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20210503031732.22035-1-derek.fang@realtek.com>
References: <20210503031732.22035-1-derek.fang@realtek.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Cc: oder_chiou@realtek.com, jack.yu@realtek.com, alsa-devel@alsa-project.org,
 lars@metafoo.de, Mark Brown <broonie@kernel.org>, shumingf@realtek.com,
 flove@realtek.com
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

On Mon, 3 May 2021 11:17:32 +0800, derek.fang@realtek.com wrote:
> Register the codec dai name as 'rt1019-aif' by adding
> non_legacy_dai_naming configuration.

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/1] ASoC: rt1019: Add non_legacy_dai_naming config
      commit: b63ecaea97aac3020be0e5736253e88cefbc950b

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
