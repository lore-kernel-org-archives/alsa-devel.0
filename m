Return-Path: <SRS0=rMx/=I6=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BB5D1C433B4
	for <alsa-devel@archiver.kernel.org>; Thu,  1 Apr 2021 10:18:55 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 54A586108B
	for <alsa-devel@archiver.kernel.org>; Thu,  1 Apr 2021 10:18:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 54A586108B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id CC0F41696;
	Thu,  1 Apr 2021 12:18:02 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz CC0F41696
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1617272332;
	bh=EIrQgPFlkTqPA7xToyxwP9zrW21fScMH9YJARgGuBdA=;
	h=From:To:Subject:Date:In-Reply-To:References:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=KLTnpXDSqIo5GDGtuzFSpeG1euozBUDnFkYjPcFEXkHeLMMBesZkqVqUVoldixbFS
	 6u73l6o8nALoMclvftN+EeEmS/NUN2HmfrfwPpDwty74IDtUizRUytxqcgtDAM4J05
	 lvOxPytOlYcDqyrb/zoSECK6RNzRsrhOkrQvKJ6A=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 887E0F802D2;
	Thu,  1 Apr 2021 12:17:13 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 4E7A3F802D2; Thu,  1 Apr 2021 12:17:12 +0200 (CEST)
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 4D6F8F80117
 for <alsa-devel@alsa-project.org>; Thu,  1 Apr 2021 12:17:09 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 4D6F8F80117
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org
 header.b="i1b4LWb5"
Received: by mail.kernel.org (Postfix) with ESMTPSA id CBF2B610CA;
 Thu,  1 Apr 2021 10:17:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1617272227;
 bh=EIrQgPFlkTqPA7xToyxwP9zrW21fScMH9YJARgGuBdA=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=i1b4LWb5h3mxG99vNqWH6h6CoSFG+jtujoAX5FHkpc8zcbZjk95+SJiZy8AtG6UAf
 rb1YgjLA6JBv3BZ/7WU4On9MsvA9raSQxcN399IycTRm5L8UEFYNH4YfgVpbLhC88U
 YgXTweGlccahyPmaHb1FQoq0HpdqJcgua4JG+pEfFf07GS2+xNF5cyVBm0brk0X+Df
 4npDaFC0O+ccya0UYNJuRLjKWbyRu7BexQIIYJPz3ZGxVEuur+pyWf32+RmWaJUvVd
 rZdT6j8gbJyseq+UanJzKqfN+QEFExmxth9kY3vjyXTAmQSbd1XuGXcUFXsSgliXpn
 3cvQKPU5XEA1w==
From: Mark Brown <broonie@kernel.org>
To: Rob Herring <robh@kernel.org>
Subject: Re: [PATCH v2 0/3] ASoC: dt-bindings: Rework audio-graph-port schema
Date: Thu,  1 Apr 2021 11:16:21 +0100
Message-Id: <161726938994.2219.6158932183318290762.b4-ty@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20210331142748.2163272-1-robh@kernel.org>
References: <20210331142748.2163272-1-robh@kernel.org>
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

On Wed, 31 Mar 2021 09:27:45 -0500, Rob Herring wrote:
> This series refactors the audio-graph-port.yaml schema moving the
> 'port' node out of the schema and updating to use graph.yaml schema.
> This allows users to define what each 'port' node is like other graph
> binding users.
> 
> v2:
> - Rebase on ASoC tree
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
