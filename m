Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7AD97EB64D7
	for <alsa-devel@archiver.kernel.org>; Fri, 16 Jun 2023 16:19:03 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id DE62A83B;
	Fri, 16 Jun 2023 18:18:10 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz DE62A83B
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1686932341;
	bh=QPuB4lxAmkqhETy9vD/l3bdOr37fLrsF+66p19Po4zk=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:List-Id:
	 List-Archive:List-Help:List-Owner:List-Post:List-Subscribe:
	 List-Unsubscribe:From;
	b=Z612zthkgL+1Oi+7RMFjqEj6LXxojyBLcYwMfYpFsynD7ukcntZjcmRKN/5gMfsph
	 bdu3h3f7rFFHYXnQbUUCOT9cOsj6Gy8Jx6h1Hg1JQP3Ns//VXkGfeNlWsbAXhoI1rp
	 TV4IhNyfvr46eiwFym1v+x1seLRx6Oeuu3Zrq6J8=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 1E492F8055C; Fri, 16 Jun 2023 18:17:17 +0200 (CEST)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id 579E0F8055C;
	Fri, 16 Jun 2023 18:17:16 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 025B6F80246; Fri, 16 Jun 2023 18:17:09 +0200 (CEST)
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits))
	(No client certificate requested)
	by alsa1.perex.cz (Postfix) with ESMTPS id 41724F80130
	for <alsa-devel@alsa-project.org>; Fri, 16 Jun 2023 18:17:07 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 41724F80130
Authentication-Results: alsa1.perex.cz;
	dkim=pass (2048-bit key,
 unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20201202 header.b=JIsxuP3y
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits))
	(No client certificate requested)
	by dfw.source.kernel.org (Postfix) with ESMTPS id CB0BA6340E;
	Fri, 16 Jun 2023 16:17:06 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C78ACC433C0;
	Fri, 16 Jun 2023 16:17:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1686932226;
	bh=QPuB4lxAmkqhETy9vD/l3bdOr37fLrsF+66p19Po4zk=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=JIsxuP3yetE+SCrWlraYxKCXe/v+vo90m6qBZwx2eiBCM9u42shtLzMX9jMo7FWW5
	 lOUpfVxVeb0kwSoAOym968+3D4w9Bx/N5SKuM6ulOiY5lMsavT31AHhZMEIIZgLi9p
	 KcbcjMq4FBj7G4+tWBvU+vqat9NaED9QKqe7eeq6f26YJNiyKpNl8656NNt62SpjaH
	 dhZb1Lxq5OdbvrhPrJQgJ2kbXwWZw4rMd7bwMREQv77/8OaA7iQe4kVJI4dOygUTCC
	 eLspnP/IaWoogVt6c3YYzm5IwFAUeI/yTPwVo/lijea6nZjQXZJHd2Wmz77WEjMfDX
	 sgmVGwbFoEX4g==
From: Mark Brown <broonie@kernel.org>
To: Liam Girdwood <lgirdwood@gmail.com>, Rob Herring <robh+dt@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 Conor Dooley <conor+dt@kernel.org>,
 Alexander Stein <alexander.stein@ew.tq-group.com>
Cc: alsa-devel@alsa-project.org, devicetree@vger.kernel.org
In-Reply-To: <20230616083549.2331830-1-alexander.stein@ew.tq-group.com>
References: <20230616083549.2331830-1-alexander.stein@ew.tq-group.com>
Subject: Re: [PATCH v2 1/1] ASoC: dt-bindings: tlv320aic32x4: convert to DT
 schema format
Message-Id: <168693222453.298269.4226326426787113161.b4-ty@kernel.org>
Date: Fri, 16 Jun 2023 17:17:04 +0100
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.13-dev-c6835
Message-ID-Hash: VRU6TCFTKSKEA3PZ2L3H5EIUSPSSG24S
X-Message-ID-Hash: VRU6TCFTKSKEA3PZ2L3H5EIUSPSSG24S
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
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/VRU6TCFTKSKEA3PZ2L3H5EIUSPSSG24S/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

On Fri, 16 Jun 2023 10:35:49 +0200, Alexander Stein wrote:
> Convert the binding to DT schema format.
> Since commit 514b044cba667 ("ASoC: tlv320aic32x4: Model PLL in CCF")
> clocks & clock-names = "mclk" is mandatory, it has been added to required
> properties as well. '#sound-dai-cells' is added for reference from
> simple-audio-card.
> 
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/1] ASoC: dt-bindings: tlv320aic32x4: convert to DT schema format
      commit: 289650d61c600ac4f631028c761f38042ba599c8

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

