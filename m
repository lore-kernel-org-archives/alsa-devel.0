Return-Path: <SRS0=XQZd=IK=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8D0ABC433E0
	for <alsa-devel@archiver.kernel.org>; Fri, 12 Mar 2021 20:27:52 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B921564F73
	for <alsa-devel@archiver.kernel.org>; Fri, 12 Mar 2021 20:27:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B921564F73
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 494CE18AC;
	Fri, 12 Mar 2021 21:27:00 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 494CE18AC
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1615580870;
	bh=wY8CiS6661pb+DtBt906zAb39PxZKg1/KC1tbn2ul4A=;
	h=From:To:In-Reply-To:References:Subject:Date:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=SVzAPBH1xEIH26GTMTgU2EOkFpsdJI6Ab94cZhKPiyC85YMYK1ehpAS4oWch53Kr0
	 LLo1YsnjKeBa8jaQscJ3S15Ac0fEmJpVci4TFVo3C6bS1nggvjhpnrMXDTNXrx+HAh
	 pY1aFFdoVMcX+DDFMkH7vlMEkA6tNj9flwq7kYG4=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id BDBF5F804A9;
	Fri, 12 Mar 2021 21:25:33 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 4776EF804AA; Fri, 12 Mar 2021 21:25:32 +0100 (CET)
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id DDAEEF80430
 for <alsa-devel@alsa-project.org>; Fri, 12 Mar 2021 21:25:28 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz DDAEEF80430
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org
 header.b="S5bAV6Y0"
Received: by mail.kernel.org (Postfix) with ESMTPSA id B8B8064F80;
 Fri, 12 Mar 2021 20:25:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1615580727;
 bh=wY8CiS6661pb+DtBt906zAb39PxZKg1/KC1tbn2ul4A=;
 h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
 b=S5bAV6Y06Ik2T5c80wgMJv3NN5GsSANNNGnC7VYWyYEPhKMvTxlLWk17wFvSMXmRQ
 umD7fAYk/pyMxVj94HvIdf0tx4UUFLWaO0skyVf0miMs2oI+zswm+ZOxD+gPja4t3g
 cW4mi+CYVImkgGXFVeGALAowh0voSom+rcwX2Gl6oNnA3Rt1Jn+4fFe8ecv/dMH7eB
 DQPFspeQehWOKWvKxwr0iEnyZb7FcGSUrSURSiF4ingsmKpLgyXIWh3baUEGx9XqHV
 MB1GUPNJK+DyH/NO5jEsXZlhu54IVX9iGKfqHaj8Cfrf1kfA0ZfY1cs4haBUsJrMzm
 fI/kQCHTGmMrA==
From: Mark Brown <broonie@kernel.org>
To: jack.yu@realtek.com, lgirdwood@gmail.com
In-Reply-To: <20210226020517.17124-1-jack.yu@realtek.com>
References: <20210226020517.17124-1-jack.yu@realtek.com>
Subject: Re: [PATCH] ASoC: rt1015p: add acpi device id for rt1015p
Message-Id: <161558062956.11113.8864518227948750711.b4-ty@kernel.org>
Date: Fri, 12 Mar 2021 20:23:49 +0000
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Cc: oder_chiou@realtek.com, alsa-devel@alsa-project.org, lars@metafoo.de,
 kent_chen@realtek.com, kenny_chen@realtek.com, derek.fang@realtek.com,
 shumingf@realtek.com, flove@realtek.com
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

On Fri, 26 Feb 2021 10:05:17 +0800, jack.yu@realtek.com wrote:
> Add acpi device id for rt1015p.

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/1] ASoC: rt1015p: add acpi device id for rt1015p
      commit: 464b489a7885d6a89b0dfa7b7f1f56e2db80700d

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
