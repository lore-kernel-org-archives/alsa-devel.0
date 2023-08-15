Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C6398C04A94
	for <alsa-devel@archiver.kernel.org>; Tue, 15 Aug 2023 20:43:40 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 611EB91;
	Tue, 15 Aug 2023 22:42:47 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 611EB91
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1692132217;
	bh=N7ipikLuPtGgetkxcY+A3Ut1e/FpcdlgAB/lDl1fW/w=;
	h=From:To:In-Reply-To:References:Subject:Date:List-Id:List-Archive:
	 List-Help:List-Owner:List-Post:List-Subscribe:List-Unsubscribe:
	 From;
	b=biQpQgmzzJRkdxfNJ940SKOHykTfbja8iGVWFNLjDrWfUgRurWfy0g0C4JMzZ0J9Z
	 tL4ZVR2zFScIBA36IaPqJvuLTt7kBKoyU0OErhfKKCeuf80MGjWSYQIi+RGOlDyVIx
	 hdnxI8PePlJurCwUxeEFIIrHRnxxnP6zV2U5pAUw=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 2A93DF80510; Tue, 15 Aug 2023 22:42:16 +0200 (CEST)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id 1ACD9F8016D;
	Tue, 15 Aug 2023 22:42:16 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id E2807F8016D; Tue, 15 Aug 2023 22:42:09 +0200 (CEST)
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest
 SHA256)
	(No client certificate requested)
	by alsa1.perex.cz (Postfix) with ESMTPS id 5D7A4F80074
	for <alsa-devel@alsa-project.org>; Tue, 15 Aug 2023 22:41:52 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 5D7A4F80074
Authentication-Results: alsa1.perex.cz;
	dkim=pass (2048-bit key,
 unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20201202 header.b=RGz9IEfw
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits))
	(No client certificate requested)
	by dfw.source.kernel.org (Postfix) with ESMTPS id AA3456192B;
	Tue, 15 Aug 2023 20:41:50 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 29FFDC433C8;
	Tue, 15 Aug 2023 20:41:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1692132110;
	bh=N7ipikLuPtGgetkxcY+A3Ut1e/FpcdlgAB/lDl1fW/w=;
	h=From:To:In-Reply-To:References:Subject:Date:From;
	b=RGz9IEfwwSDU6RkRCDeWBhsyJ+y2VV6ZRXXHxyIz7K8wWaxdNlc5MB+oifALvzeFx
	 xVp2/GLHXEFshr5NDyFnNwpxhhc1x0I7k+Opw5udpcBO3Cw9s+a5GrJ8p4D1Lp4M0J
	 3RoPY6uyfLC5ThJEynhJt2NUQat69iIK0PyC31cFkaxrPBNi2LpskBL6VFq+HAgmB1
	 lVis78itGCJiqXLjUD8UCCrPk77UTS1P2qaKKk9DM5lHzxvQTKeFw2tsbgstnd86k5
	 LcGYGqEIYoS93FvFWe+XHckNIw2VkSrCd6lMs4RaVMVTtbSRnymapWooXYIrjYRqv0
	 rFTAGSJRqdiVw==
From: Mark Brown <broonie@kernel.org>
To: Liam Girdwood <lgirdwood@gmail.com>, Jaroslav Kysela <perex@perex.cz>,
 Takashi Iwai <tiwai@suse.com>, Heiko Stuebner <heiko@sntech.de>,
 alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
 patches@opensource.cirrus.com, linux-arm-kernel@lists.infradead.org,
 linux-rockchip@lists.infradead.org,
 Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230815143204.379708-1-krzysztof.kozlowski@linaro.org>
References: <20230815143204.379708-1-krzysztof.kozlowski@linaro.org>
Subject: Re: [PATCH RESEND 1/3] ASoC: codecs: tlv320aic32x4: Fix
 Wvoid-pointer-to-enum-cast warning
Message-Id: <169213210789.572973.6949298748225335967.b4-ty@kernel.org>
Date: Tue, 15 Aug 2023 21:41:47 +0100
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.13-dev-034f2
Message-ID-Hash: F3RCZJD67FSPMSK33ODDCYNTCDVYFLQ7
X-Message-ID-Hash: F3RCZJD67FSPMSK33ODDCYNTCDVYFLQ7
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
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/F3RCZJD67FSPMSK33ODDCYNTCDVYFLQ7/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

On Tue, 15 Aug 2023 16:32:02 +0200, Krzysztof Kozlowski wrote:
> 'type' is an enum, thus cast of pointer on 64-bit compile test with W=1
> causes:
> 
>   tlv320aic32x4.c:1352:18: error: cast to smaller integer type 'enum aic32x4_type' from 'void *' [-Werror,-Wvoid-pointer-to-enum-cast]
> 
> 

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/3] ASoC: codecs: tlv320aic32x4: Fix Wvoid-pointer-to-enum-cast warning
      commit: 66de320b0214a60095287ba1afa09e870d8cdbe5
[2/3] ASoC: codecs: wm8904: Fix Wvoid-pointer-to-enum-cast warning
      commit: 5a1803324949f4ebdf6e887b59e0e89afc3ee0bb
[3/3] ASoC: rockchip: Fix Wvoid-pointer-to-enum-cast warning
      commit: 49a4a8d1261230378a8931d0859329057686b6eb

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

