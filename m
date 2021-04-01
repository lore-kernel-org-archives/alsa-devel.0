Return-Path: <SRS0=rMx/=I6=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5B3EAC433ED
	for <alsa-devel@archiver.kernel.org>; Thu,  1 Apr 2021 10:19:00 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 44E6E61056
	for <alsa-devel@archiver.kernel.org>; Thu,  1 Apr 2021 10:18:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 44E6E61056
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id B97EB16A5;
	Thu,  1 Apr 2021 12:18:07 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz B97EB16A5
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1617272337;
	bh=0XIMTKPbBSfQ0mStj2Kgtksi0YRnTlzwQGmNyWpKKDw=;
	h=From:To:Subject:Date:In-Reply-To:References:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=PWeH52OIU+QaZ1OFnuTz1VhT9sZK0UI2YxWMpC3s3xHGXyhU9nEfWd14ov7S1AypI
	 cEB13jjB4BTB+vLwzU5yfFFEqK29z29EBvobrJTuKkPjtNvXquiSsDPZ2rij8qFdji
	 rx29ySx3HxTT2jQsBUPu/Sn6DXi9q60ppfFLBPP8=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id C5102F8032C;
	Thu,  1 Apr 2021 12:17:16 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id CBC1BF8032D; Thu,  1 Apr 2021 12:17:15 +0200 (CEST)
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id BB6FCF802E3
 for <alsa-devel@alsa-project.org>; Thu,  1 Apr 2021 12:17:12 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz BB6FCF802E3
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org
 header.b="TwLJ/F9p"
Received: by mail.kernel.org (Postfix) with ESMTPSA id 038996108B;
 Thu,  1 Apr 2021 10:17:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1617272230;
 bh=0XIMTKPbBSfQ0mStj2Kgtksi0YRnTlzwQGmNyWpKKDw=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=TwLJ/F9pVHytgO8o8WFfwwcD6cthVx34SLFCkhEqJEUH8D33dGAJaWfedq4nfCXRi
 elvaA1+DicvJIBSRTIHIfpCT+k0jHlmJ1ewCfaVAASUM0u2x/Q0hoBD44QAfOOw2B8
 /p4E6es6QXuACpuPgXXnfR1DTzUTg4Mk2ouH0xZAgVYrAUKWkKBWlCvXPtsf7IjQFq
 Chf7j0kJjO02uYMHXSrdEcNg6jmpL31l6PTg5/6IufxIKQlsHdfIFGFpi40X3HGZF+
 H1KQMg24oUPVpDlPdFc2KRbmuNiH86Hyt8JlKHS6cPep8tHJ/C9flBUHB0eSDnEvn/
 /uLjTIu7FJItw==
From: Mark Brown <broonie@kernel.org>
To: Liam Girdwood <lgirdwood@gmail.com>,
 Thierry Reding <thierry.reding@gmail.com>
Subject: Re: [PATCH] ASoC: tegra: Set driver name explicitly
Date: Thu,  1 Apr 2021 11:16:22 +0100
Message-Id: <161726938993.2219.5747332081985016926.b4-ty@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20210330180657.1867971-1-thierry.reding@gmail.com>
References: <20210330180657.1867971-1-thierry.reding@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Cc: alsa-devel@alsa-project.org,
 Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>,
 Sameer Pujar <spujar@nvidia.com>, Jon Hunter <jonathanh@nvidia.com>,
 Mark Brown <broonie@kernel.org>, linux-tegra@vger.kernel.org
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

On Tue, 30 Mar 2021 20:06:57 +0200, Thierry Reding wrote:
> The SoC sound core will generate a driver name by normalizing the card
> name. However, most of the time that name does not tell anything about
> the driver and is therefore useless for this purpose.
> 
> Make the driver name more useful by setting it explicitly during card
> initialization.

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/1] ASoC: tegra: Set driver name explicitly
      commit: 868d5c6340d878f44acf73c92923995b896b6454

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
