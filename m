Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 23611C7EE23
	for <alsa-devel@archiver.kernel.org>; Thu,  8 Jun 2023 15:20:34 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id BF90F6C1;
	Thu,  8 Jun 2023 17:19:41 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz BF90F6C1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1686237631;
	bh=888/DxeFCwjXrc+J1zDYpuICndnlmtRdgBJJ0xu/IAg=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:List-Id:
	 List-Archive:List-Help:List-Owner:List-Post:List-Subscribe:
	 List-Unsubscribe:From;
	b=E3g3tivKJBcQ+4fgF6Hvyp6UVXj/5AfM0UT+7Yo+AAn9SwfgrViFVQOLjPuh8J4f/
	 XDlGUjQplYjPNW9T8ozOpQceJ/kHUYGjMx5hFr6O5oLQJxlaWSqng2ZBonfXL0flIL
	 UVMQAz5zbua+IPAxYns0Hq8MkDLScrQs6wdsUoHE=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 5EDE6F80548; Thu,  8 Jun 2023 17:19:15 +0200 (CEST)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id B9BADF80290;
	Thu,  8 Jun 2023 17:19:14 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 6783AF80130; Thu,  8 Jun 2023 17:19:10 +0200 (CEST)
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa1.perex.cz (Postfix) with ESMTPS id 4A5C4F80130
	for <alsa-devel@alsa-project.org>; Thu,  8 Jun 2023 17:18:57 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 4A5C4F80130
Authentication-Results: alsa1.perex.cz;
	dkim=pass (2048-bit key,
 unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20201202 header.b=I+DycyAh
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.source.kernel.org (Postfix) with ESMTPS id 0920B60FAB;
	Thu,  8 Jun 2023 15:18:56 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 08915C4339B;
	Thu,  8 Jun 2023 15:18:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1686237535;
	bh=888/DxeFCwjXrc+J1zDYpuICndnlmtRdgBJJ0xu/IAg=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=I+DycyAhSkOd+4Wez5SB1rOYpE7PV3N4tkT7idceTf0k9T4OM4hW1SkcXmjdpvON2
	 nU6tMvndC4VV/pon/gjLXqteWE9kSP+K0QhgTui9XnpTtb7KD9GJ7W9nywMqhIVqtb
	 +dGXLiPuWm4+Rijjwcsuv8oddu0tAAOhCKGju7K8Gf2mRRRxkwZhscJqv9ANBfpK93
	 FaB01lE6Ieqr53h0Lfe5Hg8XUdWSftcGJrBdYuJdY0ovCvlQBAhe3Ek2p80Wm8p/Fc
	 z0s5/yysdeThANACa72wFpv7/etM1fNKbCIs10zlHDA991iReAmHRnQaAnc3H16W/D
	 aj3g2Dc8jUnDA==
From: Mark Brown <broonie@kernel.org>
To: lgirdwood@gmail.com, Jiapeng Chong <jiapeng.chong@linux.alibaba.com>
Cc: perex@perex.cz, tiwai@suse.com, alsa-devel@alsa-project.org,
 linux-kernel@vger.kernel.org, Abaci Robot <abaci@linux.alibaba.com>
In-Reply-To: <20230608075540.61575-1-jiapeng.chong@linux.alibaba.com>
References: <20230608075540.61575-1-jiapeng.chong@linux.alibaba.com>
Subject: Re: [PATCH] ASoC: max98088: clean up some inconsistent indenting
Message-Id: <168623753375.1002486.15353648412458244656.b4-ty@kernel.org>
Date: Thu, 08 Jun 2023 16:18:53 +0100
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.13-dev-bfdf5
Message-ID-Hash: 7TQ3IJZ76JJ2RSVVQQRRMYH5MMIOZTEQ
X-Message-ID-Hash: 7TQ3IJZ76JJ2RSVVQQRRMYH5MMIOZTEQ
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
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/7TQ3IJZ76JJ2RSVVQQRRMYH5MMIOZTEQ/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

On Thu, 08 Jun 2023 15:55:40 +0800, Jiapeng Chong wrote:
> No functional modification involved.
> 
> sound/soc/codecs/max98088.c:316 m98088_eq_band() warn: inconsistent indenting.
> 
> 

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/1] ASoC: max98088: clean up some inconsistent indenting
      commit: 3b3a8d6d34a3ace4d49beb6f69ebb0d3cfaf0479

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

