Return-Path: <SRS0=pl6R=OU=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BDE33C433F5
	for <alsa-devel@archiver.kernel.org>; Thu, 30 Sep 2021 15:03:31 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D3AA0613CE
	for <alsa-devel@archiver.kernel.org>; Thu, 30 Sep 2021 15:03:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org D3AA0613CE
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 3BE2616D3;
	Thu, 30 Sep 2021 17:02:39 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 3BE2616D3
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1633014209;
	bh=VB9orFxsY14fyJtvup9liDeJdnBFjZM5Us2Lmk4xzYI=;
	h=From:To:Subject:Date:In-Reply-To:References:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=dI0vOqC7rPY4H1GiOBAxYGVJiPM/xGWFyUrqQL3iXLMV8qoCypgXJ4Pfn66Zuc4Fe
	 JogWl+FMpMPXkNKK61Fxi1EC6pQgImk4WUpqb7TX6jUEMlfcIKuCIQuoyvhd+LyyGQ
	 CY+AgsBxf0hcpZ0O3dz0KmN4e0aipv7cOEOEM3M8=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id AB82EF8050F;
	Thu, 30 Sep 2021 17:00:28 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 7F66CF804E4; Thu, 30 Sep 2021 17:00:20 +0200 (CEST)
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 5C7ABF80113
 for <alsa-devel@alsa-project.org>; Thu, 30 Sep 2021 17:00:06 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 5C7ABF80113
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org
 header.b="M4+8pW4m"
Received: by mail.kernel.org (Postfix) with ESMTPSA id 8782B6128E;
 Thu, 30 Sep 2021 15:00:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1633014003;
 bh=VB9orFxsY14fyJtvup9liDeJdnBFjZM5Us2Lmk4xzYI=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=M4+8pW4m1jx70gKS7pi6oS+KPNG4A5y62nZfj3Ny1xE032tj8VKISK1Sr9Cn7I3Wy
 VKZ5sDaqCj2sGcSy9xNMb42hh1o7N1LAFn3b9Yjou4eNHz/rvdtu3hVYeTw7CVC93W
 urXhq7vOnG6FpBLTW0eIq1RWVjdDjbN7tsxo+YYzoT4+Wyw8uAApGKD4j3fWCrnUGY
 r4dk498bxjJJASiUbsfsf8kgEwv/aASN2qNGlkyJ7sc+Vx7P7D6Q84AjF1x/B5lXs2
 PyPKC+JEWIqaW1yhkqc8ZmqHQJaM2j/Ump4SxV7ITcMM57T62RkzOZYM4594anuW2Q
 QlcX3PbLgJySg==
From: Mark Brown <broonie@kernel.org>
To: derek.fang@realtek.com,
	lgirdwood@gmail.com
Subject: Re: [PATCH] ASoC: dt-bindings: rt5682s: fix the device-tree schema
 errors
Date: Thu, 30 Sep 2021 15:58:54 +0100
Message-Id: <163301248178.43045.15903836903409128227.b4-ty@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20210929130406.24325-1-derek.fang@realtek.com>
References: <20210929130406.24325-1-derek.fang@realtek.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Cc: oder_chiou@realtek.com, devicetree@vger.kernel.org,
 alsa-devel@alsa-project.org, lars@metafoo.de, jack.yu@realtek.com,
 linux-kernel@vger.kernel.org, robh+dt@kernel.org,
 Mark Brown <broonie@kernel.org>, shumingf@realtek.com, flove@realtek.com
X-BeenThere: alsa-devel@alsa-project.org
X-Mailman-Version: 2.1.15
Precedence: list
List-Id: "Alsa-devel mailing list for ALSA developers -
 http://www.alsa-project.org" <alsa-devel.alsa-project.org>
List-Unsubscribe: <https://mailman.alsa-project.org/mailman/options/alsa-devel>, 
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <https://mailman.alsa-project.org/mailman/listinfo/alsa-devel>, 
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: "Alsa-devel" <alsa-devel-bounces@alsa-project.org>

On Wed, 29 Sep 2021 21:04:06 +0800, derek.fang@realtek.com wrote:
> From: Derek Fang <derek.fang@realtek.com>
> 
> Fix the device-tree schema errors that be reported by using 'make
> dt_binding_check'.
> 
> 

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/1] ASoC: dt-bindings: rt5682s: fix the device-tree schema errors
      commit: 91cf45595021bd6f6279748aa472de7fc7864084

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
