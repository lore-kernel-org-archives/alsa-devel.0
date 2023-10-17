Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 38215CDB482
	for <alsa-devel@archiver.kernel.org>; Tue, 17 Oct 2023 17:12:41 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id E39451FE;
	Tue, 17 Oct 2023 19:11:48 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz E39451FE
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1697562759;
	bh=I75tXN/hSuP3k5KEmspEJCqjhfY968ybw0OVuKwVQ30=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:List-Id:
	 List-Archive:List-Help:List-Owner:List-Post:List-Subscribe:
	 List-Unsubscribe:From;
	b=HVFDCWb0cgzpQX+gEbuWP2No5A0pRjTrk7Cu+LVQTPCgt9SYx/hjHob6k0Cp4sUhv
	 adP7SCNDetP931EnzsAR6rZkgbb9Ot4BhdGGxf6Bsu9ELvVoNwqJ9tGnkn4FUoAlk9
	 4gjtktouuOW+USFFoxc3shSimbLbBVZKlIHRjAzo=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 09394F8025F; Tue, 17 Oct 2023 19:11:17 +0200 (CEST)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id 9A66BF8025F;
	Tue, 17 Oct 2023 19:11:17 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 16A01F8024E; Tue, 17 Oct 2023 19:11:14 +0200 (CEST)
Received: from sin.source.kernel.org (sin.source.kernel.org
 [IPv6:2604:1380:40e1:4800::1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits))
	(No client certificate requested)
	by alsa1.perex.cz (Postfix) with ESMTPS id 6D7FCF8019B
	for <alsa-devel@alsa-project.org>; Tue, 17 Oct 2023 19:11:09 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 6D7FCF8019B
Authentication-Results: alsa1.perex.cz;
	dkim=pass (2048-bit key,
 unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20201202 header.b=bZW70CBX
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sin.source.kernel.org (Postfix) with ESMTP id B6637CE2004;
	Tue, 17 Oct 2023 17:11:04 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 60623C433C8;
	Tue, 17 Oct 2023 17:11:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1697562664;
	bh=I75tXN/hSuP3k5KEmspEJCqjhfY968ybw0OVuKwVQ30=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=bZW70CBXMrChmnwcUc5VtmQ14TyQRx1pt8zBpz2tp7UPSkBmD9e+jyBcsHDWLEgG0
	 2XK76MzByQ/uIJGZlSYGS5K+DXrc561Yz5Gz02nU4C2Q+qMG9tcQUb1BfsQtY0Ok/p
	 ZN9ZCqUPsAIcW7W3RAWi1yR+H5PFWqo845I4j+LoO9+9VgurR3mGY5akjZdgpqH2TW
	 AWGRb5OUTt3ytwnYRzS7IhTWW2mN7JYmDuAxu9r+j5LTXwQ2CuiJvmFE3Z/gbWWDzf
	 qcnPH85zp8s2Jm2bpWVxAn/CHMck+0HHgku862supfQSkrh1cG8m/rf6v607oCKqTu
	 fAd2jLqmOYN4g==
From: Mark Brown <broonie@kernel.org>
To: David Rau <David.Rau.opensource@dm.renesas.com>
Cc: support.opensource@diasemi.com, lgirdwood@gmail.com, perex@perex.cz,
 tiwai@suse.com, alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
In-Reply-To: <20231017021258.5929-1-David.Rau.opensource@dm.renesas.com>
References: <20231017021258.5929-1-David.Rau.opensource@dm.renesas.com>
Subject: Re: [PATCH] ASoC: da7219: Correct the process of setting up Gnd
 switch in AAD
Message-Id: <169756266208.1643819.1484143250686725896.b4-ty@kernel.org>
Date: Tue, 17 Oct 2023 18:11:02 +0100
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.13-dev-0438c
Message-ID-Hash: QKGOBL4KRPQGJDSBQRKAGFDK6ZLZ6G2Z
X-Message-ID-Hash: QKGOBL4KRPQGJDSBQRKAGFDK6ZLZ6G2Z
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
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/QKGOBL4KRPQGJDSBQRKAGFDK6ZLZ6G2Z/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

On Tue, 17 Oct 2023 10:12:58 +0800, David Rau wrote:
> Enable Gnd switch to improve stability when Jack insert event
> occurs, and then disable Gnd switch after Jack type detection
> is finished.
> 
> 

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/1] ASoC: da7219: Correct the process of setting up Gnd switch in AAD
      commit: e8ecffd9962fe051d53a0761921b26d653b3df6b

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

