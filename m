Return-Path: <SRS0=iTaG=EB=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6A6DCC4363A
	for <alsa-devel@archiver.kernel.org>; Mon, 26 Oct 2020 23:48:59 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C5BD72075B
	for <alsa-devel@archiver.kernel.org>; Mon, 26 Oct 2020 23:48:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="hquFIPEe";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="k0yy62xy"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C5BD72075B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 001D216C1;
	Tue, 27 Oct 2020 00:48:06 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 001D216C1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1603756137;
	bh=5T4AL1BqRu1ARMLqlPYicJ4G84AujjuS4vWXEtGsgds=;
	h=Date:From:To:In-Reply-To:References:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=hquFIPEes5H4aVj8IsZB6cMIJKIntEKBLmwuLq1MBo835bWwMLVWCoHngJc35bFIg
	 4DaKz4taVUqrjHnpMwkPVeecWVgc+J/fUTs+MHdqS3oT7X1A7LreyPgnfyrGoWYkB5
	 gcRlJeQKecVocccI2vyrXkd4UOXF5+dLOqAAgft8=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 4081EF804E4;
	Tue, 27 Oct 2020 00:46:01 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 3B939F804C3; Tue, 27 Oct 2020 00:45:59 +0100 (CET)
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 9C170F804C2
 for <alsa-devel@alsa-project.org>; Tue, 27 Oct 2020 00:45:56 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 9C170F804C2
Authentication-Results: alsa1.perex.cz;
 dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org
 header.b="k0yy62xy"
Received: from localhost (fw-tnat.cambridge.arm.com [217.140.96.140])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id 74BDD20874;
 Mon, 26 Oct 2020 23:45:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1603755955;
 bh=5T4AL1BqRu1ARMLqlPYicJ4G84AujjuS4vWXEtGsgds=;
 h=Date:From:To:Cc:In-Reply-To:References:Subject:From;
 b=k0yy62xyK6pARRGeQH/8tZh7EQvK+Pk4WiCSWb1+LFc5QFneQ0G327u4wby7WIl3D
 Yf6pruWjkRFbttJ/itSDa5AXhtf/n//zacPvMvI0H4IggveE4OYc/TlSMWuFcFFV6J
 bIyT+yGjcFDcaBVkg9p6wOPf1CabCQbD6f5jj9Jc=
Date: Mon, 26 Oct 2020 23:45:50 +0000
From: Mark Brown <broonie@kernel.org>
To: linuxppc-dev@lists.ozlabs.org, Liam Girdwood <lgirdwood@gmail.com>,
 Timur Tabi <timur@kernel.org>, Nicolin Chen <nicoleotsuka@gmail.com>,
 Viorel Suman <viorel.suman@nxp.com>, Philipp Zabel <p.zabel@pengutronix.de>,
 Shengjiu Wang <shengjiu.wang@gmail.com>,
 Cosmin-Gabriel Samoila <cosmin.samoila@nxp.com>, linux-kernel@vger.kernel.org,
 Fabio Estevam <festevam@gmail.com>, Rob Herring <robh+dt@kernel.org>,
 Xiubo Li <Xiubo.Lee@gmail.com>,
 Matthias Schiffer <matthias.schiffer@ew.tq-group.com>,
 Jaroslav Kysela <perex@perex.cz>, devicetree@vger.kernel.org,
 Takashi Iwai <tiwai@suse.com>, "Viorel Suman (OSS)" <viorel.suman@oss.nxp.com>,
 alsa-devel@alsa-project.org
In-Reply-To: <20201013121733.83684-1-viorel.suman@oss.nxp.com>
References: <20201013121733.83684-1-viorel.suman@oss.nxp.com>
Subject: Re: [PATCH v4 0/2] DAI driver for new XCVR IP
Message-Id: <160375592347.31132.18055383544502605577.b4-ty@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
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

On Tue, 13 Oct 2020 15:17:31 +0300, Viorel Suman (OSS) wrote:
> DAI driver for new XCVR IP found in i.MX8MP.
> 
> Viorel Suman (2):
>   ASoC: fsl_xcvr: Add XCVR ASoC CPU DAI driver
>   ASoC: dt-bindings: fsl_xcvr: Add document for XCVR
> 
> Changes since v1:
>  - improved 6- and 12-ch layout comment
>  - used regmap polling function, improved
>    clocks handling in runtime_resume
>  - added FW size check in FW load function,
>    improved IRQ handler, removed dummy IRQ handlers
>  - fixed yaml file
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/2] ASoC: fsl_xcvr: Add XCVR ASoC CPU DAI driver
      commit: 28564486866fa889b78264360022c94836fa8072
[2/2] ASoC: dt-bindings: fsl_xcvr: Add document for XCVR
      commit: 0afb88d5a602488f877380ad1ec37cc20c927c68

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
