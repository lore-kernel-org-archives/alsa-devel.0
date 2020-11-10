Return-Path: <SRS0=3oRA=EQ=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EC6F9C388F7
	for <alsa-devel@archiver.kernel.org>; Tue, 10 Nov 2020 21:40:22 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B976620809
	for <alsa-devel@archiver.kernel.org>; Tue, 10 Nov 2020 21:40:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="Da4mG98h";
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="To+hjNxU"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B976620809
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 30D1A173C;
	Tue, 10 Nov 2020 22:39:30 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 30D1A173C
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1605044420;
	bh=1wv/W+FAA2wLDi6r6O9opaiMCeNvIC1rPgcrn0Rooxs=;
	h=Date:From:To:In-Reply-To:References:Subject:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=Da4mG98htakOJoXt/zc3pPdi1CyfHtDksTwzbxPdxfvZtssOm2D48UkN+IKApxWk9
	 asoXEzT2cUR+wewGeCnjbbo3yS9LVriTOVVMEi7pqCMqIK7vG+mJKnyM2nyYRpLk+o
	 7iZ1fI6/uh6hldOo9Trs9tWOvPffNYFncXXa1caA=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id CA09FF804C3;
	Tue, 10 Nov 2020 22:38:34 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 98ED8F804CA; Tue, 10 Nov 2020 22:38:33 +0100 (CET)
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 1C8E2F804C2
 for <alsa-devel@alsa-project.org>; Tue, 10 Nov 2020 22:38:31 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 1C8E2F804C2
Authentication-Results: alsa1.perex.cz;
 dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org
 header.b="To+hjNxU"
Received: from localhost (fw-tnat.cambridge.arm.com [217.140.96.140])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id 9CBBB207D3;
 Tue, 10 Nov 2020 21:38:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1605044309;
 bh=1wv/W+FAA2wLDi6r6O9opaiMCeNvIC1rPgcrn0Rooxs=;
 h=Date:From:To:Cc:In-Reply-To:References:Subject:From;
 b=To+hjNxUK2OWbg0OfzQHC3Q4eCQLWyaXcTYcslaAt6K6bqa7nEVjItClnhIdqOAVJ
 y5p0CBYi8rvAnkxFj+S7OW+XEmMZ+o3a+zzJ5CPzo0WEl7lCPymSFDkxARdAzaEvJF
 5V73vnqwQnMV0raNC+VO6a80HFbJSjQ56Hy/EpvU=
Date: Tue, 10 Nov 2020 21:38:15 +0000
From: Mark Brown <broonie@kernel.org>
To: Xiubo Li <Xiubo.Lee@gmail.com>, Timur Tabi <timur@kernel.org>,
 Nicolin Chen <nicoleotsuka@gmail.com>, Fabio Estevam <festevam@gmail.com>,
 Shengjiu Wang <shengjiu.wang@gmail.com>, alsa-devel@alsa-project.org,
 linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
 Jaroslav Kysela <perex@perex.cz>, Liam Girdwood <lgirdwood@gmail.com>,
 "Viorel Suman (OSS)" <viorel.suman@oss.nxp.com>, Takashi Iwai <tiwai@suse.com>
In-Reply-To: <20201102161810.902464-1-viorel.suman@oss.nxp.com>
References: <20201102161810.902464-1-viorel.suman@oss.nxp.com>
Subject: Re: [PATCH] ASoC: fsl_xcvr: fix break condition
Message-Id: <160504428419.41991.13993731328162565714.b4-ty@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Cc: Viorel Suman <viorel.suman@nxp.com>
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

On Mon, 2 Nov 2020 18:18:10 +0200, Viorel Suman (OSS) wrote:
> The break condition copied by mistake as same
> as loop condition in the previous version, but must
> be the opposite. So fix it.

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/1] ASoC: fsl_xcvr: fix break condition
      commit: 048751de568816de52dedf0fa967cceada7885f1

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
