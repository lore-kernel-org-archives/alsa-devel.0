Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 691BCE7AD78
	for <alsa-devel@archiver.kernel.org>; Tue,  3 Oct 2023 17:10:43 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 6EFA583B;
	Tue,  3 Oct 2023 19:09:51 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 6EFA583B
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1696353041;
	bh=c2Amx6bwFllppZWhw8zB9Zq4+W/JCoESVGF4gZggaYM=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:List-Id:
	 List-Archive:List-Help:List-Owner:List-Post:List-Subscribe:
	 List-Unsubscribe:From;
	b=Ykw8oescWSwnzKOLoFWdT/f28TLEri7cSTet0hetVfT/3m6GkvON8ctJdh5idX3oY
	 70ZShn7V+9y5yTnPg1bma/BXkhj7bgmqFEnLkRDP9rHZSX/4F83tlwL4GJ3yWTlteg
	 2Ps5CWitrN11EdyY3EqEdGLoJLwV5qFH1VY00eMQ=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id AA503F8057F; Tue,  3 Oct 2023 19:08:55 +0200 (CEST)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id D88E5F80579;
	Tue,  3 Oct 2023 19:08:54 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 3976BF8047D; Tue,  3 Oct 2023 19:08:47 +0200 (CEST)
Received: from sin.source.kernel.org (sin.source.kernel.org
 [IPv6:2604:1380:40e1:4800::1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest
 SHA256)
	(No client certificate requested)
	by alsa1.perex.cz (Postfix) with ESMTPS id DA53EF80310
	for <alsa-devel@alsa-project.org>; Tue,  3 Oct 2023 19:08:41 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz DA53EF80310
Authentication-Results: alsa1.perex.cz;
	dkim=pass (2048-bit key,
 unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20201202 header.b=njLVv3nX
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sin.source.kernel.org (Postfix) with ESMTP id 3D500CE1413;
	Tue,  3 Oct 2023 17:08:38 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DA139C433CB;
	Tue,  3 Oct 2023 17:08:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1696352917;
	bh=c2Amx6bwFllppZWhw8zB9Zq4+W/JCoESVGF4gZggaYM=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=njLVv3nX1o4MOD24uGsN7Q7lYhGER1gt6o5JaKCzoD2RF+azLcdEq3jJe/a0bo+DS
	 GwjuQWcBBMntcj4AqIbunDSINJ+FcHshd9CAUddVntBYT9GD4bVaqE0QRNzm4zSEkz
	 GcCVWVgMmw2V4A9dUm+5u7AnVzRnQ1b+cXiroCAW6Vl5vcdY2ljb/6rWsWhNku1PJK
	 2ETgSSCrmT8zIGz+6dJ9aBpkB7HuIvsncZ+mjS54I5ANomltyMGVdPx1qm800sGRNn
	 QTCHPIgZ73ZMzNqm6iHgBJdTnJmAo/hFK+orPDoJEWigTWDPv38Gh0kP8HGeednneS
	 z19ntSi8Kapug==
From: Mark Brown <broonie@kernel.org>
To: lgirdwood@gmail.com, robh+dt@kernel.org,
 krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
 Bragatheswaran Manickavel <bragathemanick0908@gmail.com>
Cc: alsa-devel@alsa-project.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20230930165050.7793-1-bragathemanick0908@gmail.com>
References: <20230930165050.7793-1-bragathemanick0908@gmail.com>
Subject: Re: [PATCH v2] ASoC: dt-bindings: rt5616: Convert to dtschema
Message-Id: <169635291560.42044.12417015204070109267.b4-ty@kernel.org>
Date: Tue, 03 Oct 2023 18:08:35 +0100
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.13-dev-0438c
Message-ID-Hash: YVKEOWX4LVFKLM5YRDNRQNVMFMFDBFCC
X-Message-ID-Hash: YVKEOWX4LVFKLM5YRDNRQNVMFMFDBFCC
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
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/YVKEOWX4LVFKLM5YRDNRQNVMFMFDBFCC/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

On Sat, 30 Sep 2023 22:20:50 +0530, Bragatheswaran Manickavel wrote:
> Convert the rt5616 audio CODEC bindings to DT schema
> 
> 

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/1] ASoC: dt-bindings: rt5616: Convert to dtschema
      commit: 943bcc742ec4d7da4d26477f2188940ecad76569

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

