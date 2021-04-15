Return-Path: <SRS0=rm39=JM=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EB23DC433ED
	for <alsa-devel@archiver.kernel.org>; Thu, 15 Apr 2021 18:36:13 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6C5746109D
	for <alsa-devel@archiver.kernel.org>; Thu, 15 Apr 2021 18:36:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6C5746109D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id EA7BA1678;
	Thu, 15 Apr 2021 20:35:21 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz EA7BA1678
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1618511772;
	bh=83uSrJMWjSqSZ9BD3xARZb9r0aBoYp5dH2qyOsRxM/8=;
	h=From:To:Subject:Date:In-Reply-To:References:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=onwO4NIKq7xAaF1O7Ad/1Fsilr2A/gPKlkML9siQjSZeWo8BST90RMFOLG3aIVcEf
	 R79b6CNoR6cxiTeZxaue1tN1OsmS5w4B0S5CssGbGFX5ED4XzcsxrpLsC6O6NPJX4N
	 qh6yy0HZq7sEH900Gv9ayoU0rs9txZYipEdMhyOY=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 1BFAFF8032C;
	Thu, 15 Apr 2021 20:34:32 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 59FB9F8025C; Thu, 15 Apr 2021 20:34:29 +0200 (CEST)
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 88701F8022D
 for <alsa-devel@alsa-project.org>; Thu, 15 Apr 2021 20:34:26 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 88701F8022D
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org
 header.b="rlSLzMBO"
Received: by mail.kernel.org (Postfix) with ESMTPSA id 3DAE760E09;
 Thu, 15 Apr 2021 18:34:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1618511664;
 bh=83uSrJMWjSqSZ9BD3xARZb9r0aBoYp5dH2qyOsRxM/8=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=rlSLzMBOBnvYxX4mVAylQFmVnkViFYyC28sznY6gnE8/gzpu2HCAMC7ohapnfPf+m
 rah2nbmPp48wMcQHQbbN3z6bi+pxO0Wj+rXx1jIln1p0NbGkFuAlhh8l0LmVpzbEik
 dRn8H5+TNLrDx9xCFjh+1F1sYYtIGt93TjKBYG5DV0lTCdPLz7JMED/lbP0hyuT3J0
 JpHiTMHfAJhK8+C6X6cI00LhuuwYWAQjS24VtUACW1DqK6VqIeZPxAeKWuVYNx/BGl
 /+7stLz1Hexbq/8Ep7RywjfuyhtqEQx3ylBzTzY3rPl77Y/kGb7dQBZzPuk8RGK0ou
 RFy8hdLIen88Q==
From: Mark Brown <broonie@kernel.org>
To: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Subject: Re: [PATCH 0/5] ASoC: simple-card/audio-graph: adjust to multi
 CPU/Codec
Date: Thu, 15 Apr 2021 19:33:45 +0100
Message-Id: <161851148785.23061.17374902278973371383.b4-ty@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <87r1jdzsaj.wl-kuninori.morimoto.gx@renesas.com>
References: <87r1jdzsaj.wl-kuninori.morimoto.gx@renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Cc: Linux-ALSA <alsa-devel@alsa-project.org>, Mark Brown <broonie@kernel.org>
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

On 14 Apr 2021 08:19:32 +0900, Kuninori Morimoto wrote:
> These patches adjusts to multi CPU/Codec on simple-card / audio-graph.
> This is part of prepare for new audio-graph-card2.
> 
> Kuninori Morimoto (5):
>   ASoC: simple-card: remove unused variable from simple_parse_of()
>   ASoC: simple-card: use asoc_link_to_xxx() macro
>   ASoC: simple-card: use simple_props_to_xxx() macro
>   ASoC: audio-graph: use asoc_link_to_xxx() macro
>   ASoC: audio-graph: use simple_props_to_xxx() macro
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/5] ASoC: simple-card: remove unused variable from simple_parse_of()
      commit: 8cbea89e2fba2f92937cd15211490b62f14a46ff
[2/5] ASoC: simple-card: use asoc_link_to_xxx() macro
      commit: 5bb5ac71e3f4f85500b96ea03e54bf6e2d8be3f2
[3/5] ASoC: simple-card: use simple_props_to_xxx() macro
      commit: 2c33e20ffd68df097d61fad9b87dc6276354b139
[4/5] ASoC: audio-graph: use asoc_link_to_xxx() macro
      commit: 7ed5920995cea34d66e4af00c7f468cc933251cf
[5/5] ASoC: audio-graph: use simple_props_to_xxx() macro
      commit: ae0727ab77419d550d6f68b698ce37ef2bf315df

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
