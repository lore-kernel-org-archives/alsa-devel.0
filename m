Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CF5F8C00A8F
	for <alsa-devel@archiver.kernel.org>; Tue, 24 Oct 2023 13:56:48 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id E4FBC86E;
	Tue, 24 Oct 2023 15:55:55 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz E4FBC86E
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1698155806;
	bh=ZwRGvdK1vLRyYCBNB8H0GmRZoD2LA6Gw+YOD+d7uvu0=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:List-Id:
	 List-Archive:List-Help:List-Owner:List-Post:List-Subscribe:
	 List-Unsubscribe:From;
	b=cxeW5+LvkHjNB0qLg95dosiJGLIxIwekiwlKOwDnVta5u7AUX3pdMmufVVOXUIpbW
	 rx+BAYd7RH7XX9Nw7POE1IUJz9Jm8+NdhaK2AyDYZV6ocG4yO2Cn4E8Wo7JaNNnikN
	 1MO9b+t4h3zMhFIFFZqHEmhu3QUZD4lzNql5Umq4=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 54E17F8055A; Tue, 24 Oct 2023 15:55:27 +0200 (CEST)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id B0353F80224;
	Tue, 24 Oct 2023 15:55:26 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 73757F80224; Tue, 24 Oct 2023 15:55:21 +0200 (CEST)
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest
 SHA256)
	(No client certificate requested)
	by alsa1.perex.cz (Postfix) with ESMTPS id 1FDB5F8012B
	for <alsa-devel@alsa-project.org>; Tue, 24 Oct 2023 15:55:14 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 1FDB5F8012B
Authentication-Results: alsa1.perex.cz;
	dkim=pass (2048-bit key,
 unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20201202 header.b=NxD9Ggy+
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by ams.source.kernel.org (Postfix) with ESMTP id A30B8B82487;
	Tue, 24 Oct 2023 13:55:13 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CAB6BC433D9;
	Tue, 24 Oct 2023 13:55:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1698155712;
	bh=ZwRGvdK1vLRyYCBNB8H0GmRZoD2LA6Gw+YOD+d7uvu0=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=NxD9Ggy+9A7RNU1Bjgd9K1z8hWPbQi879G28Ip41uwiWe84uVlCmqllbF9PsZlh0d
	 G2rydM2Pm8bPxq1DGXAswrBQZaiBbtD2nUQOq/dVx5Pe+M5aMmb3ce+hLcuhcpm99n
	 IBA6YnK4LsJEuNRmBOYuEghoNzNXPErkIBxjHaPUOHv1v7qVBy0MthbcJ1+gwhZ8TN
	 h9yAceinSkCQwzwPw8MHnSgTlhdJXuXwl97QknJRHl8UEhqKYWOP4McA0UZK58HDoH
	 g4kDqFM2pCzLdXK7VuOeMRZCRt9fIJak9Q0FPTgpZp7THk5I2meWR09NCmKYrks+Ee
	 5AhaJ8ROchJgQ==
From: Mark Brown <broonie@kernel.org>
To: shengjiu.wang@gmail.com, Zhang Shurong <zhang_shurong@foxmail.com>
Cc: Xiubo.Lee@gmail.com, festevam@gmail.com, nicoleotsuka@gmail.com,
 lgirdwood@gmail.com, perex@perex.cz, tiwai@suse.com,
 alsa-devel@alsa-project.org, linuxppc-dev@lists.ozlabs.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <tencent_C0D62E6D89818179A02A04A0C248F0DDC40A@qq.com>
References: <tencent_C0D62E6D89818179A02A04A0C248F0DDC40A@qq.com>
Subject: Re: [PATCH v2] ASoC: fsl: Fix PM disable depth imbalance in
 fsl_easrc_probe
Message-Id: <169815570943.69390.931793622764684694.b4-ty@kernel.org>
Date: Tue, 24 Oct 2023 14:55:09 +0100
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.13-dev-0438c
Message-ID-Hash: QKFISSQZ5467XFHS4W6LVLV3IVTUZ43R
X-Message-ID-Hash: QKFISSQZ5467XFHS4W6LVLV3IVTUZ43R
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
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/QKFISSQZ5467XFHS4W6LVLV3IVTUZ43R/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

On Thu, 12 Oct 2023 21:03:15 +0800, Zhang Shurong wrote:
> The pm_runtime_enable will increase power disable depth. Thus
> a pairing decrement is needed on the error handling path to
> keep it balanced according to context. We fix it by calling
> pm_runtime_disable when error returns.
> 
> 

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/1] ASoC: fsl: Fix PM disable depth imbalance in fsl_easrc_probe
      commit: 9e630efb5a4af56fdb15aa10405f5cfd3f5f5b83

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

