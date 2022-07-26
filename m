Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 43381C00140
	for <alsa-devel@archiver.kernel.org>; Tue, 26 Jul 2022 16:14:30 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 9523A851;
	Tue, 26 Jul 2022 18:13:38 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 9523A851
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1658852068;
	bh=lBXBlTt8of9ENP47XpLIyjUVRBGhosFykkx8XUx780Y=;
	h=From:To:In-Reply-To:References:Subject:Date:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=qN1E/u7xtwRcModr62We4GtdDvib1PWFNIB1r6YpKBZ0ivo1amE/my/PmT6v7ReJG
	 VVqip3tYwhy++CXbgw0aEgz5Z+3P2CTg4Ufo3sAHa+WSXbCccHYrrMf2bxXIJYlyjJ
	 yJUdM6iAEcMfDKYAREL11aTq6inbLJmQNhM+gFuY=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 1E67BF80238;
	Tue, 26 Jul 2022 18:13:38 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id F1E85F8025A; Tue, 26 Jul 2022 18:13:35 +0200 (CEST)
Received: from dfw.source.kernel.org (dfw.source.kernel.org
 [IPv6:2604:1380:4641:c500::1])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 9F6C3F800FA
 for <alsa-devel@alsa-project.org>; Tue, 26 Jul 2022 18:13:31 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 9F6C3F800FA
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org
 header.b="M/KOBOQN"
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by dfw.source.kernel.org (Postfix) with ESMTPS id 0142860CEE;
 Tue, 26 Jul 2022 16:13:29 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F154CC433D6;
 Tue, 26 Jul 2022 16:13:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1658852008;
 bh=lBXBlTt8of9ENP47XpLIyjUVRBGhosFykkx8XUx780Y=;
 h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
 b=M/KOBOQNa7Pph72JOjmMgxacAb1zaib0xCLuFXfZXEcxJF9Z7EjoxO03lUe8XYnYo
 rXy5Nq+9HHzedLlKUl4rH3JgkCKO4I+K8v+AQkvjoMpmbqG5GW35YpF8LS5Pzgc0uZ
 kd9kJPx0R0D9VxXZ/iw4g+5BQ8g04YFWVphw9BR/xPdXXBn+DKlTMEC1OrJpCCTZTr
 12cdz2cCDe1sZbp+9OiyY3Pvurdhg1xMn/gIaUdtBTKyRVoQvcX0fK1lMGaIPniXFu
 7eWV0dqLsjPepdV80qeMDukZzvGSFeUgBkV587WHR8sk0yWObM+7SQvXOb/eIbLMO+
 ZFPq51UR1BFQA==
From: Mark Brown <broonie@kernel.org>
To: robh+dt@kernel.org, Raphael-Xu <13691752556@139.com>
In-Reply-To: <20220722105345.175-1-13691752556@139.com>
References: <20220722105345.175-1-13691752556@139.com>
Subject: Re: [PATCH v7] ASoc: dt-bindings: tas2780: remove tas2780 and will
 merge it to tas27xx
Message-Id: <165885200667.210393.7730933722595002390.b4-ty@kernel.org>
Date: Tue, 26 Jul 2022 17:13:26 +0100
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Mailer: b4 0.10.0-dev-c7731
Cc: kevin-lu@ti.com, devicetree@vger.kernel.org, alsa-devel@alsa-project.org,
 shenghao-ding@ti.com, raphael-xu@ti.com
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

On Fri, 22 Jul 2022 18:53:45 +0800, Raphael-Xu wrote:
> remove tas2780
> 
> 

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/1] ASoc: dt-bindings: tas2780: remove tas2780 and will merge it to tas27xx
      commit: 7209344223f77311aee677ea820a93b9ba0bcae0

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
