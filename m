Return-Path: <SRS0=2FB+=BH=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 24805C433E0
	for <alsa-devel@archiver.kernel.org>; Tue, 28 Jul 2020 16:33:37 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9C08E2074F
	for <alsa-devel@archiver.kernel.org>; Tue, 28 Jul 2020 16:33:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="gA5stzTp";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="jB8O4xAz"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9C08E2074F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 3F8F31708;
	Tue, 28 Jul 2020 18:32:45 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 3F8F31708
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1595954015;
	bh=MvJFQePpTeXsEoGzLMIt/fwYSAXp4PLXCKjGR4c5Jng=;
	h=Date:From:To:In-Reply-To:References:Subject:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=gA5stzTplpdkx414nwy6fT25OWRtzoOodcAC5SQi+ZVtvQg72g45tKc36A5p+V+Gn
	 1Nhdxt12/OO9htDqQc6Hg4sFwm+w2z1HG7jEa2YDjQxnS3FT/cdRYTXSnOnMlmVXIB
	 Pl+tb4j0kz5V6oDEGwN/WS0u5/qZiW7E1H8QMEbs=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id EDE80F802C4;
	Tue, 28 Jul 2020 18:31:12 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id D0224F80254; Tue, 28 Jul 2020 18:31:06 +0200 (CEST)
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 60EE8F80227
 for <alsa-devel@alsa-project.org>; Tue, 28 Jul 2020 18:31:04 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 60EE8F80227
Authentication-Results: alsa1.perex.cz;
 dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org
 header.b="jB8O4xAz"
Received: from localhost (fw-tnat.cambridge.arm.com [217.140.96.140])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id 4840820809;
 Tue, 28 Jul 2020 16:31:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1595953862;
 bh=MvJFQePpTeXsEoGzLMIt/fwYSAXp4PLXCKjGR4c5Jng=;
 h=Date:From:To:Cc:In-Reply-To:References:Subject:From;
 b=jB8O4xAzD+w2GNSBD0aQkZBrgUZsKOmefp3m5KOBgDEXCkmcYKr/TFl38n3Xws8MJ
 mwSmfnSz1XY7K3PTLFSq1MfESrclQHEleVO/ae5kYJnt9tqcwpccUjSeEz1J0rIqe+
 87UqermLiJjx5e6jumo3lkNBGsvyOwfyeRt59He4=
Date: Tue, 28 Jul 2020 17:30:44 +0100
From: Mark Brown <broonie@kernel.org>
To: Charles Keepax <ckeepax@opensource.cirrus.com>
In-Reply-To: <20200728144141.16104-1-ckeepax@opensource.cirrus.com>
References: <20200728144141.16104-1-ckeepax@opensource.cirrus.com>
Subject: Re: [PATCH] ASoC: madera: Add channel numbers to AIFs
Message-Id: <159595383113.15027.1840184537150347857.b4-ty@kernel.org>
Cc: patches@opensource.cirrus.com, alsa-devel@alsa-project.org,
 lgirdwood@gmail.com
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

On Tue, 28 Jul 2020 15:41:41 +0100, Charles Keepax wrote:
> Set the channel number on each AIF widget to allow unused channels not
> to be powered up across AIFs.

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/1] ASoC: madera: Add channel numbers to AIFs
      commit: 3570922c4d6d6c98ae840b8725d69d58b14864fc

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
