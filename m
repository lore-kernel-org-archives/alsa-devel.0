Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 21F70D3399B
	for <alsa-devel@archiver.kernel.org>; Mon, 28 Oct 2024 16:34:17 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id CF9C2EB1;
	Mon, 28 Oct 2024 17:34:05 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz CF9C2EB1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1730133255;
	bh=/GA1touZQkGDDK0wLtrA8ojFx9dCS+V30atvsmCrNIM=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:List-Id:
	 List-Archive:List-Help:List-Owner:List-Post:List-Subscribe:
	 List-Unsubscribe:From;
	b=CeiDF+V5VOtInPRzm2OPugYBTDp8ng76ITJsslhwTL0QfJZIuSvCf185fwZ+jZ7Kr
	 UFTdWveQh5zSCxTTCqSH/aZMb9fpeDmiVadBrM0PiqtwwuAirQEL8+9Qf808JeQMqq
	 GMqCD3IlxkMI+2Vjm3X8CyI05ZxkgIqCHQ9dnQkI=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id B685BF805B5; Mon, 28 Oct 2024 17:33:40 +0100 (CET)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id 94C5EF8057A;
	Mon, 28 Oct 2024 17:33:39 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id C08B5F80269; Mon, 28 Oct 2024 17:33:33 +0100 (CET)
Received: from nyc.source.kernel.org (nyc.source.kernel.org
 [IPv6:2604:1380:45d1:ec00::3])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest
 SHA256)
	(No client certificate requested)
	by alsa1.perex.cz (Postfix) with ESMTPS id C1AB3F8014C
	for <alsa-devel@alsa-project.org>; Mon, 28 Oct 2024 17:33:31 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz C1AB3F8014C
Authentication-Results: alsa1.perex.cz;
	dkim=pass (2048-bit key,
 unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20201202 header.b=DxzhTR59
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by nyc.source.kernel.org (Postfix) with ESMTP id 4DBCCA42977;
	Mon, 28 Oct 2024 16:31:33 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4AF99C4CEC3;
	Mon, 28 Oct 2024 16:33:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730133208;
	bh=/GA1touZQkGDDK0wLtrA8ojFx9dCS+V30atvsmCrNIM=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=DxzhTR59n3ydk4pFTk8WbE0/6/LZ5tcZmNqJPdpgwZ0tD/Kw3SlOp5IWnTAphfkTA
	 JEmXL5B6lP0YTCFBIvpIG8W7ynRn6rATTKhPyN9xBQx1v3iN4H6igm7fCB2Dj5eMQN
	 BYLzhAaiWQqfMZksTxOTlc+0cDu1EOf9pwwk88yJlJxxBkvDzGh8wh+ZQa/bLUlKpE
	 1rOrZpjl+ArZbD08JYKDMZPqDyNGKsQge70Ob5gKICQ6g47LMPC3rrUmsV5+KzxjU2
	 OOBwdjGvOKuRIMCC2d4TqEpNLRUccY/JeU44Dn/+57i7xTNFX8DSrfEiUPrnGnLBky
	 OpWlC+39SBGeA==
From: Mark Brown <broonie@kernel.org>
To: alsa-devel@alsa-project.org, Zhang Yi <zhangyi@everest-semi.com>
Cc: tiwai@suse.com, amadeuszx.slawinski@linux.intel.com,
 yangxiaohua@everest-semi.com, zhuning@everest-semi.com
In-Reply-To: <20241028060529.3359-1-zhangyi@everest-semi.com>
References: <20241028060529.3359-1-zhangyi@everest-semi.com>
Subject: Re: [PATCH] ASoC: codecs: ES8326: Modify the configuration of and
 micbias
Message-Id: <173013320685.78752.14724693204140069588.b4-ty@kernel.org>
Date: Mon, 28 Oct 2024 16:33:26 +0000
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15-dev-9b746
Message-ID-Hash: EUIDP4KJ7RGQOBXS7CB3ZQ4JDRTEUYHS
X-Message-ID-Hash: EUIDP4KJ7RGQOBXS7CB3ZQ4JDRTEUYHS
X-MailFrom: broonie@kernel.org
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency;
 loop; banned-address; member-moderation;
 header-match-alsa-devel.alsa-project.org-0;
 header-match-alsa-devel.alsa-project.org-1; nonmember-moderation;
 administrivia; implicit-dest; max-recipients; max-size; news-moderation;
 no-subject; digests; suspicious-header
X-Mailman-Version: 3.3.9
Precedence: list
List-Id: "Alsa-devel mailing list for ALSA developers -
 http://www.alsa-project.org" <alsa-devel.alsa-project.org>
Archived-At: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/EUIDP4KJ7RGQOBXS7CB3ZQ4JDRTEUYHS/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

On Mon, 28 Oct 2024 14:05:29 +0800, Zhang Yi wrote:
> Because we designed a new version of ES8326, the configuration of
> micbias needed to be modified.We tested the new driver,
> on both the new version and the old one. It works well.
> 
> 

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/1] ASoC: codecs: ES8326: Modify the configuration of and micbias
      commit: bc48c55557edea46939ffef8ab9fa807b5951948

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

