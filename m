Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B635CC41513
	for <alsa-devel@archiver.kernel.org>; Wed,  9 Aug 2023 17:28:32 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 7F9CE829;
	Wed,  9 Aug 2023 19:27:40 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 7F9CE829
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1691602110;
	bh=D6pmW9Ns/eJi6uSbZ7+8RHhnJ+rN9E4ihqgcnzXpIVM=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:List-Id:
	 List-Archive:List-Help:List-Owner:List-Post:List-Subscribe:
	 List-Unsubscribe:From;
	b=s62cqEyTn3k0kgrovLNWTCKbrh0IVzbhb8kL04ugqq1fbxMVaMLsLtEvggd1asGjk
	 4k1EiZgF3VwJnUTlEO/s2mbnpKtssNdBknr/mC8ypver/3EStWrvCJp3nDZNtYr3Ct
	 KpIog34cguqzoaEbX8xMcek+jg5NUjq0AZCxcToM=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 0F581F8016E; Wed,  9 Aug 2023 19:27:05 +0200 (CEST)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id 848A8F800FB;
	Wed,  9 Aug 2023 19:27:05 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 99C21F801EB; Wed,  9 Aug 2023 19:27:02 +0200 (CEST)
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest
 SHA256)
	(No client certificate requested)
	by alsa1.perex.cz (Postfix) with ESMTPS id 7EB86F80116
	for <alsa-devel@alsa-project.org>; Wed,  9 Aug 2023 19:26:58 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 7EB86F80116
Authentication-Results: alsa1.perex.cz;
	dkim=pass (2048-bit key,
 unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20201202 header.b=evhSPpDQ
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits))
	(No client certificate requested)
	by dfw.source.kernel.org (Postfix) with ESMTPS id 0BB2D632C8;
	Wed,  9 Aug 2023 17:26:57 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E5881C433C9;
	Wed,  9 Aug 2023 17:26:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1691602016;
	bh=D6pmW9Ns/eJi6uSbZ7+8RHhnJ+rN9E4ihqgcnzXpIVM=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=evhSPpDQ5NdXcAtjBsbfCS4qxDY04ui9PEGzYDNEcsI7PbAbLiKvqX/pp7IHdZWJP
	 uo834K7P9tq2qt2NSdzyAp9QiU3jE3FKmQAIIE87CDTkFFRxeVZp2ib8an8GRmR9pj
	 r5GG/BFCV4PyGA0Pmtnu6S4o9wYYxUiOsM8jtUXZAHiDK0NbjDKhjWCVCOzxFlMZYG
	 0blTW/ZzrCKHzdq1T4RpnhHTMI8+G+bgDsqnhl7CRTJ3b15QXH/JL1FaVt6KK8nYO1
	 6kexgZyDUiyzwRBy64DUVEIUxLMJxAx1gEITfYlWrH0kOTN1QS08cWLESI4nlEk0lK
	 LO2PTlP1DMtMQ==
From: Mark Brown <broonie@kernel.org>
To: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Cc: Linux-ALSA <alsa-devel@alsa-project.org>
In-Reply-To: <87bkfh9g68.wl-kuninori.morimoto.gx@renesas.com>
References: <87bkfh9g68.wl-kuninori.morimoto.gx@renesas.com>
Subject: Re: [PATCH] ASoC: rsnd: call of_node_put() when break
Message-Id: <169160201565.157618.6198853408704969332.b4-ty@kernel.org>
Date: Wed, 09 Aug 2023 18:26:55 +0100
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.13-dev-034f2
Message-ID-Hash: HLPH765ANLJPT2HQUGBNXOAQOQCJEC66
X-Message-ID-Hash: HLPH765ANLJPT2HQUGBNXOAQOQCJEC66
X-MailFrom: broonie@kernel.org
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency;
 loop; banned-address; member-moderation;
 header-match-alsa-devel.alsa-project.org-0;
 header-match-alsa-devel.alsa-project.org-1; nonmember-moderation;
 administrivia; implicit-dest; max-recipients; max-size; news-moderation;
 no-subject; digests; suspicious-header
X-Mailman-Version: 3.3.8
Precedence: list
List-Id: "Alsa-devel mailing list for ALSA developers -
 http://www.alsa-project.org" <alsa-devel.alsa-project.org>
Archived-At: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/HLPH765ANLJPT2HQUGBNXOAQOQCJEC66/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

On Wed, 09 Aug 2023 01:07:45 +0000, Kuninori Morimoto wrote:
> We need to call of_node_put() when break from
> for_each_child_of_node(). This patch add missing
> of_node_put().
> 
> 

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/1] ASoC: rsnd: call of_node_put() when break
      commit: 1a5ca2aad7b907f9d7101eaba7dfa068b2da3bdd

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

