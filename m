Return-Path: <SRS0=4V3b=E2=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6C879C56202
	for <alsa-devel@archiver.kernel.org>; Fri, 20 Nov 2020 21:31:19 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A3109207D3
	for <alsa-devel@archiver.kernel.org>; Fri, 20 Nov 2020 21:31:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="LYZd5sgJ";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="SVreCdHn"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A3109207D3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id F34751723;
	Fri, 20 Nov 2020 22:30:26 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz F34751723
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1605907877;
	bh=TiN/PEcXZyvfTQuP3y4oWjBfPiZHOkcTnSjiVhKAWt8=;
	h=Date:From:To:In-Reply-To:References:Subject:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=LYZd5sgJd8ht1k1X+ccA6/Y7+zhTdsugVwpd5ZQJiT0aYNWKGa8jNr+UUHh7gApLJ
	 4++KGpNtBxVDzR6KX2nfaBXQo5Y+fkSLNb9W8eipasW/vkguKkS5o4j1Eg4IQOdMHH
	 r6HIhzFWlY7QI3HnJTL55ii/nUFSh/IsuTtXfH4o=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id A03FCF800C5;
	Fri, 20 Nov 2020 22:29:38 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id C37FCF804BC; Fri, 20 Nov 2020 22:29:32 +0100 (CET)
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 349B7F80166
 for <alsa-devel@alsa-project.org>; Fri, 20 Nov 2020 22:29:30 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 349B7F80166
Authentication-Results: alsa1.perex.cz;
 dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org
 header.b="SVreCdHn"
Received: from localhost (cpc102334-sgyl38-2-0-cust884.18-2.cable.virginm.net
 [92.233.91.117])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id 2C4722242B;
 Fri, 20 Nov 2020 21:29:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1605907768;
 bh=TiN/PEcXZyvfTQuP3y4oWjBfPiZHOkcTnSjiVhKAWt8=;
 h=Date:From:To:Cc:In-Reply-To:References:Subject:From;
 b=SVreCdHng3F9Tbg5eQKab66RkiVgp6TIka76jQwdm15Ol0XQzAHJ0QZr0KSzc87Lw
 3dturaJzf6DlrxTpXW0vTRpPjapI4fte1VztNZeU1oSh2mupXpVaz32Utm6LnL8jkZ
 O+QDo9KImmvTrCZIoNhz7gp8A3B/aRqmFjvaRDhY=
Date: Fri, 20 Nov 2020 21:29:07 +0000
From: Mark Brown <broonie@kernel.org>
To: Rob Herring <robh@kernel.org>
In-Reply-To: <20201119161848.3379929-1-robh@kernel.org>
References: <20201119161848.3379929-1-robh@kernel.org>
Subject: Re: [PATCH] ASoC: dt-bindings: renesas,
 rsnd: Fix duplicate 'allOf' entries
Message-Id: <160590773741.47461.854428611172817962.b4-ty@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Cc: devicetree@vger.kernel.org, Sameer Pujar <spujar@nvidia.com>,
 alsa-devel@alsa-project.org, Liam Girdwood <lgirdwood@gmail.com>,
 Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
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

On Thu, 19 Nov 2020 10:18:48 -0600, Rob Herring wrote:
> Commit e52f3f291152 ("ASoC: audio-graph-card: Refactor schema") added an
> 'allOf' entry, but one is already present in the schema. Multiple keys
> is not valid and results in an error:
> 
> ruamel.yaml.constructor.DuplicateKeyError: while constructing a mapping
>   in "<unicode string>", line 4, column 1
> found duplicate key "allOf" with value "[]" (original value: "[]")
>   in "<unicode string>", line 262, column 1

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/1] ASoC: dt-bindings: renesas, rsnd: Fix duplicate 'allOf' entries
      commit: 73d2784ecf09d49e319631aea682cb360959355a

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
