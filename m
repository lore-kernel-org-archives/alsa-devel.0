Return-Path: <SRS0=rMx/=I6=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7BE55C433ED
	for <alsa-devel@archiver.kernel.org>; Thu,  1 Apr 2021 10:22:29 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B868C6108B
	for <alsa-devel@archiver.kernel.org>; Thu,  1 Apr 2021 10:22:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B868C6108B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 18C0116B8;
	Thu,  1 Apr 2021 12:21:37 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 18C0116B8
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1617272547;
	bh=od8Rq9Kf78i1K8wp62RqoniFQY5B9m9Qer/wU2HFhRE=;
	h=From:To:Subject:Date:In-Reply-To:References:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=VX7u6OsLaBV6mVbNTCuzvODOwM/v81NsDJV0FXTJbxEODJnRNWZuyeZygGKfjPAz6
	 vgvO5tFnYaaOI7jr19zRtyLun+NJ36UcmcpnePeWefVwNBXISvxegeVSIeebZu6vIP
	 M/HSZ613/ZYqOQZN4ww+TYbqaSDy8vEWKxpT16No=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id BEFCFF804ED;
	Thu,  1 Apr 2021 12:17:41 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 61452F804E5; Thu,  1 Apr 2021 12:17:37 +0200 (CEST)
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 7ECD6F804E0
 for <alsa-devel@alsa-project.org>; Thu,  1 Apr 2021 12:17:34 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 7ECD6F804E0
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org
 header.b="G2zA2X6s"
Received: by mail.kernel.org (Postfix) with ESMTPSA id 76BC761056;
 Thu,  1 Apr 2021 10:17:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1617272253;
 bh=od8Rq9Kf78i1K8wp62RqoniFQY5B9m9Qer/wU2HFhRE=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=G2zA2X6s3PuWdSwbpQtYM1poOxuprTTUtDIxOUM4i9DGRNpTsmPKSc3hVkfCU9ibP
 aaGR+xg7bNkoonkxd32NsnsO8j3iwJakkcVzoARHWJkqSIO3WTnAS45723NHKRp5b5
 udEwtt0J8WFXitafA7IWUJBB2ieCx1bKh0VjRMDh3u1tO7sEBcNmtcXpRmAdWCAI3Q
 TjO7wATmCNmBCEWTHhBgMt5lxFoY7h0Fsnic9pMFwWoF5ji+prlzLLpJ8JRH3tdd2b
 E1CPJ94GogTLI/umXEce1RhY/ZzU7pde93xC5pRwDMBTMBatQZ96niENjoz4vfrO6s
 l4ma2vgwqi6Mg==
From: Mark Brown <broonie@kernel.org>
To: Rob Herring <robh@kernel.org>
Subject: Re: [PATCH 0/3] ASoC: dt-bindings: Rework audio-graph-port schema
Date: Thu,  1 Apr 2021 11:16:29 +0100
Message-Id: <161726938993.2219.16015630418592937478.b4-ty@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20210323163634.877511-1-robh@kernel.org>
References: <20210323163634.877511-1-robh@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Cc: devicetree@vger.kernel.org, alsa-devel@alsa-project.org,
 Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>,
 Lubomir Rintel <lkundrak@v3.sk>, Sameer Pujar <spujar@nvidia.com>,
 linux-kernel@vger.kernel.org, Liam Girdwood <lgirdwood@gmail.com>,
 Masahiro Yamada <yamada.masahiro@socionext.com>,
 Mark Brown <broonie@kernel.org>, Thierry Reding <thierry.reding@gmail.com>,
 linux-tegra@vger.kernel.org, Jonathan Hunter <jonathanh@nvidia.com>
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

On Tue, 23 Mar 2021 10:36:31 -0600, Rob Herring wrote:
> This series refactors the audio-graph-port.yaml schema moving the
> 'port' node out of the schema and updating to use graph.yaml schema.
> This allows users to define what each 'port' node is like other graph
> binding users.
> 
> Rob
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/3] ASoC: dt-bindings: Move port/ports properties out of audio-graph-port.yaml
      commit: 9c1e0439ada9973ec99cc1e0887eb84fd26444b8
[2/3] ASoC: dt-bindings: Use OF graph schema
      commit: ec1c8302178a946986bb7b52ac7bb9ccdcdf7d92
[3/3] ASoC: dt-bindings: socionext: Use audio-graph-port schema
      commit: f1321c9766b2c9e79de268225e291dead0a8f969

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
