Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6B31DC88E72
	for <alsa-devel@archiver.kernel.org>; Thu, 17 Sep 2026 11:48:18 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [45.14.194.44])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 0DC8360206;
	Thu, 17 Sep 2026 13:48:06 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 0DC8360206
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1789645696;
	bh=AI39L+ZGXRClSJlTe0kyuJR2TpQAZ4EaEYHa8Qj/SGo=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:List-Id:
	 List-Archive:List-Help:List-Owner:List-Post:List-Subscribe:
	 List-Unsubscribe:From;
	b=hJ6SiPMpfcU6mJZ3yVMKxuh74wu57dD+o3Isi/E4BbXScK9JS1qCGAXefc97vkXxp
	 r2Nxh6LY4UzNl5wUubfTAHxoeUTS4MM7vM/1y2/Kh3AiJGCs/tq0or50TK9uJqorRI
	 YSfcrxXjqabu0bKxWlK0mRqRbmR4ibzyJZojvxho=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 0D2E6F805FA; Thu, 17 Sep 2026 13:47:41 +0200 (CEST)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id 8C38AF805FA;
	Thu, 17 Sep 2026 13:47:41 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 500DFF80537; Thu, 17 Sep 2026 13:47:35 +0200 (CEST)
Authentication-Results: alsa1.perex.cz; arc=none smtp.remote-ip=172.105.4.254
ARC-Seal: i=1; d=alsa-project.org; s=arc; a=rsa-sha256; cv=none; t=1789645654;
	b=bNLpc56dyvNlkXJTI01JndGW4Qg8RBLrpbf56UzkDiCeNez7CxHUsigjZexTueiahQtR
	 lsP5tmhFJPOnWHe6JPhahl9HboXi8FewOoYkl72MSlMNbxHeNxLOpxy9JX0+nejyAeqOw
	 mQDFGLGb2YJU0LoZY5DlIF39kQfJTRpdtaq1inGQX2WsVbfO6tufR9jyws+QqGu2un4g7
	 wh25sl0kRvGQ17ojJ9xpWtgxi4CUzLEMj5hLJHUmrC/GqtH0ilstcQBL+ctj1vfv9XbMk
	 eDX7VsTgthV+h1jtQBYxp5kX+UjGmNMUGQj+K2rCguBrvEZrREY69HloQTfV3ABkrpw==
ARC-Message-Signature: i=1; d=alsa-project.org; s=arc; a=rsa-sha256;
	c=relaxed/simple; t=1789645654;
	h=DKIM-Signature:From:To:Subject:Message-Id:Date:MIME-Version;
	bh=AI39L+ZGXRClSJlTe0kyuJR2TpQAZ4EaEYHa8Qj/SGo=;
	b=crzW9BaezAsJYX2H//ISEn+9uOjxxil9btGVvoGwyIKd0hX/XJDEgzPcuOc2NsEuPwTQ
	 eknPeHC7ssl7wEcMqhCOcJIkYoECd5mFZBXByK7YzfSZafFXt264VMe/w9QbGduVYz/7V
	 KEKTfh7uSPrlwG6w/yWoIw9xVR9qEAlyB5mLZC+437ylIOw+gvY1cebcKgmKUQamTMBgJ
	 Qs9Jpmb2NVG52xLe5UND7lFxtsSqAKegtlv2unVU0hNI/Tl69MkCJfcW5jTYPruUVp0f3
	 QT/vAE4oqm+JAQqY5yAEWGWaG9ooUbVa2A1yZgwhb7Qz+aqfE8nKCv9oJHAYVYn1wXA==
ARC-Authentication-Results: i=1; alsa1.perex.cz;
 dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20260515 header.b=imIZAN0h;
	arc=none smtp.remote-ip=172.105.4.254
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits))
	(No client certificate requested)
	by alsa1.perex.cz (Postfix) with ESMTPS id 27381F8007E
	for <alsa-devel@alsa-project.org>; Thu, 17 Sep 2026 13:47:32 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 27381F8007E
Authentication-Results: alsa1.perex.cz;
	dkim=pass (2048-bit key,
 unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20260515 header.b=imIZAN0h
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by tor.source.kernel.org (Postfix) with ESMTP id 4C426601EF;
	Thu, 17 Sep 2026 11:47:30 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CD4B31F000FF;
	Thu, 17 Sep 2026 11:47:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789645650;
	bh=pG9cjks4k9C8zXZoyyabDPkmF6b29sL50DaD6ZJ/fQM=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date;
	b=imIZAN0hmzffNgznzHciVaNnIMdo4L1CRg0bzohczdDonRTNvzgN9xj+oBJzyx/6W
	 YaGfVZnNve8wBJpxAkVadK0qyhwPIw5JyuiBj5GfZXGz6UBmxNkaaMDNVAY7p20o8v
	 emWLQInj4/otQcaXpctfPr/d6A4xyro1cH13tmiixbdvsJStXO56sjq+jwRaAe5Dqf
	 UZmptcuhw7oZlNNoNjPOUV3LfWuRC1AgGsNsvhOOLpge3XDv0L20Iw1ZvxEX9/CBG3
	 3OGfz+j2Vt2cKBOPvk6oWWbzd0xCZiVDl8UkEoj6vnAvkzPjdOkbZpdrZPLFQOEwHw
	 0yz6qRHx8dseg==
From: Mark Brown <broonie@kernel.org>
To: Neo Chang <YLCHANG2@nuvoton.com>
Cc: error27@gmail.com, lgirdwood@gmail.com, perex@perex.cz, robh@kernel.org,
 krzk+dt@kernel.org, linux-sound@vger.kernel.org, devicetree@vger.kernel.org,
 alsa-devel@alsa-project.org, neo.chang70@gmail.com, kchsu0@nuvoton.com,
 sjlin0@nuvoton.com
In-Reply-To: <20260914015648.311986-1-YLCHANG2@nuvoton.com>
References: <20260914015648.311986-1-YLCHANG2@nuvoton.com>
Subject: Re: [PATCH v5 0/2] ASoC: codecs: nau8360: Fix DSP routing and
 deadlock issues
Message-Id: <178964562125.162267.11490477756224504460.b4-ty@b4>
Date: Thu, 17 Sep 2026 12:47:01 +0100
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.17-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=1540; i=broonie@kernel.org;
 h=from:subject:message-id; bh=AI39L+ZGXRClSJlTe0kyuJR2TpQAZ4EaEYHa8Qj/SGo=;
 b=owEBbQGS/pANAwAKASTWi3JdVIfQAcsmYgBqq9NNaOWAYvJ6+NpPO/Uc/gSc1YSTJbKKSK3Ry
 V4GarGP+6GJATMEAAEKAB0WIQSt5miqZ1cYtZ/in+ok1otyXVSH0AUCaqvTTQAKCRAk1otyXVSH
 0BplB/0W9f9TY0gsc/gKa5Lv6Fg3LKvUnxe7GYFkEcaFzk7QniihDWsqi5EuiM5tUzqiu7fb02o
 ipmNlt2YnkBifMAJ944mRhwWK9zW+4v9FklbF36zf0jCmtWIey2M5ka/oXrrdbYzk8FNo3rtIK4
 x4Vllzz5QEB61m7p7CbTFc3IpnM+78xqdp/7U9rGOXmbzXFmBAu68cTlyMF3cVygDJ03lNRfb36
 CxsJblUyoFc6IM5s6rTRK8ehrhc0sk/K3hRUcohbUfLg5u+HqujPPR2udldYuSEvTzElU5+NASA
 4RFKd0kLq9xxcBN7hZg37lnyuwwJPadEV+UTyjlIuFlD//2o
X-Developer-Key: i=broonie@kernel.org; a=openpgp;
 fpr=3F2568AAC26998F9E813A1C5C3F436CA30F5D8EB
Message-ID-Hash: FJ2AY3SXWFJMRHTSPWBGWRJIZBMAZRYD
X-Message-ID-Hash: FJ2AY3SXWFJMRHTSPWBGWRJIZBMAZRYD
X-MailFrom: broonie@kernel.org
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; loop;
 banned-address; header-match-alsa-devel.alsa-project.org-0;
 header-match-alsa-devel.alsa-project.org-1; emergency; member-moderation;
 nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size;
 news-moderation; no-subject; digests; suspicious-header
X-Mailman-Version: 3.3.10
Precedence: list
List-Id: "Alsa-devel mailing list for ALSA developers -
 http://www.alsa-project.org" <alsa-devel.alsa-project.org>
Archived-At: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/FJ2AY3SXWFJMRHTSPWBGWRJIZBMAZRYD/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

On Mon, 14 Sep 2026 09:56:46 +0800, Neo Chang wrote:
> ASoC: codecs: nau8360: Fix DSP routing and deadlock issues
> 
> This patch series addresses two issues in the nau8360 codec driver
> regarding the DAC mux control:
> 
> 1. An invalid hardware routing state that occurs when the DSP firmware
>    fails to load but the userspace attempts to switch to the DSP path.
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-7.4

Thanks!

[1/2] ASoC: codecs: nau8360: Block DSP path selection when firmware load fails
      https://git.kernel.org/broonie/sound/c/eeff736ebf5d
[2/2] ASoC: codecs: nau8360: Fix AB-BA deadlock in mux update
      https://git.kernel.org/broonie/sound/c/4862e73eaf08

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

