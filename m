Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 66711C4332F
	for <alsa-devel@archiver.kernel.org>; Tue, 14 Nov 2023 11:40:23 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id C529D208;
	Tue, 14 Nov 2023 12:39:31 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz C529D208
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1699962021;
	bh=g0oPD+JQhmkHM+G7fpv+l4lvJk0wjdQNT6IcGr/ZgGg=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:List-Id:
	 List-Archive:List-Help:List-Owner:List-Post:List-Subscribe:
	 List-Unsubscribe:From;
	b=BuEEai9xPkqUL8+mQ6KuDvl2iklnmFzSr4QkcZOEaPjmYjuBLu8366nGL89IzrGw9
	 L3VqC8zWu/6fzzbEShCLm8yDQUNVUsp0aGt++s0c6xN/LsQEo34GnbgtdKLSP2V+rc
	 dkxmJp71rAutrVM07xYqbei7V2rMIi9MIBx4gUSY=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 2C981F80249; Tue, 14 Nov 2023 12:39:22 +0100 (CET)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id 6CBCBF80166;
	Tue, 14 Nov 2023 12:39:22 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id EACB5F802E8; Tue, 14 Nov 2023 12:39:16 +0100 (CET)
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest
 SHA256)
	(No client certificate requested)
	by alsa1.perex.cz (Postfix) with ESMTPS id 2AB53F80093
	for <alsa-devel@alsa-project.org>; Tue, 14 Nov 2023 12:39:10 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 2AB53F80093
Authentication-Results: alsa1.perex.cz;
	dkim=pass (2048-bit key,
 unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20201202 header.b=YHKtrbLV
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by dfw.source.kernel.org (Postfix) with ESMTP id C5F946120E;
	Tue, 14 Nov 2023 11:39:08 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8D299C433C8;
	Tue, 14 Nov 2023 11:39:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1699961948;
	bh=g0oPD+JQhmkHM+G7fpv+l4lvJk0wjdQNT6IcGr/ZgGg=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=YHKtrbLVIpDXUXSV3R+tDV46W16XW2BgCiD0jYbfywIyW/6uoaauuOPzpnHrftzap
	 Q7EbVNDADGZXJKwDuvZz6ttJ77dc0lUYWbkoPYblC+7k/Dsz9yyjFwWjB9KgOYsjBc
	 RlhFA1vIctsCNz3CF1Ns2pA+sOzXgQhP9rtbIqqX774KnImNRzolrD56ZCEDlpXmGZ
	 QHUrRRkVoEDcA8LzBeNvSzsw1FKB+8AQDpFVKCqASo6V0+6CRH66x6Tisza9aL7Ewd
	 bSh9nge0t5Jd1/qyRjLrJXrkY7DbXTDDKA/1RuG2uuP+IINbqoWHuUFeaA+m0kkCkV
	 uFK+ui4AqW8FA==
From: Mark Brown <broonie@kernel.org>
To: Charles Keepax <ckeepax@opensource.cirrus.com>
Cc: lgirdwood@gmail.com, alsa-devel@alsa-project.org,
 patches@opensource.cirrus.com
In-Reply-To: <20231113151429.1554139-1-ckeepax@opensource.cirrus.com>
References: <20231113151429.1554139-1-ckeepax@opensource.cirrus.com>
Subject: Re: [PATCH] ASoC: cs42l43: Add missing static from runtime PM ops
Message-Id: <169996194722.29934.15208349732373878385.b4-ty@kernel.org>
Date: Tue, 14 Nov 2023 11:39:07 +0000
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.13-dev-0438c
Message-ID-Hash: 2FZ2SGKUEIZUIHB7U6JP4BM7YKJ3YQCI
X-Message-ID-Hash: 2FZ2SGKUEIZUIHB7U6JP4BM7YKJ3YQCI
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
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/2FZ2SGKUEIZUIHB7U6JP4BM7YKJ3YQCI/>
List-Archive: <>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

On Mon, 13 Nov 2023 15:14:29 +0000, Charles Keepax wrote:
> 


Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/1] ASoC: cs42l43: Add missing static from runtime PM ops
      commit: a1321811985bed1b110d224a6c7ce1b967ee7607

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

