Return-Path: <SRS0=EuHN=OH=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.4 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C9B1BC433EF
	for <alsa-devel@archiver.kernel.org>; Fri, 17 Sep 2021 14:06:25 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EB7A06103B
	for <alsa-devel@archiver.kernel.org>; Fri, 17 Sep 2021 14:06:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org EB7A06103B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 884821769;
	Fri, 17 Sep 2021 16:05:33 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 884821769
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1631887583;
	bh=APz1wpNVHY4WtKghQkEC9694tQNhAk28L5fSi57hg9I=;
	h=From:To:Subject:Date:In-Reply-To:References:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=cq/HKKh5FgvTGdLRmpw1kK3GHSU8XQcgAV2j68Ds9n9JcrpW8U6aLD8Kzkcpvm7NC
	 IsgS6CGLd7aZ/ZtXMpURQsnDohrsr/CnEqrWC6zk8mPnT4nvZ1PoB8aXHMh7+J+rWh
	 WMYztfmkDewuxrIXdTiD/T0+sdVxjMp4/szDin2U=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 2A561F8032C;
	Fri, 17 Sep 2021 16:04:53 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 50747F8032C; Fri, 17 Sep 2021 16:04:48 +0200 (CEST)
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id CE2BFF80227
 for <alsa-devel@alsa-project.org>; Fri, 17 Sep 2021 16:04:43 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz CE2BFF80227
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org
 header.b="GtQclOsn"
Received: by mail.kernel.org (Postfix) with ESMTPSA id 997C761248;
 Fri, 17 Sep 2021 14:04:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1631887481;
 bh=APz1wpNVHY4WtKghQkEC9694tQNhAk28L5fSi57hg9I=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=GtQclOsn9OBt9TvB8f0PlRFvVn3Ret7Zi1O83Eqf8miMkknLzX0Sz+/7xeYrSp6mf
 FH4kKqi87Y1nasD3mtws9qij9LarPvS8dPAKHxoD6giNnp2ltlojGw1LW7ozaOIPqs
 HQF0D1i/VmbeXJP1sCVm45ax/NAHU/vPBXUYqolqyLLzLrQYdq8oj/R0z//9UMs+97
 i/cuOpLiEWkM2hR5kKZd5PL2pdKCjwkUIN45dg5i74xQhIjqAtJB13TyvxmiQbpiNB
 wMYK+JJDOiScphkX3O0SXf6krWBuEYgs3nDtX4YVU2Dgwz6sA+8nouspMohygmjNrL
 dGsus3W1mVDQQ==
From: Mark Brown <broonie@kernel.org>
To: Liam Girdwood <lgirdwood@gmail.com>,
	Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH] ASoC: 88pm860x: Update to modern clocking terminology
Date: Fri, 17 Sep 2021 15:03:45 +0100
Message-Id: <163188719815.50326.10832883066129480676.b4-ty@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20210916140847.50900-1-broonie@kernel.org>
References: <20210916140847.50900-1-broonie@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Cc: alsa-devel@alsa-project.org
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

On Thu, 16 Sep 2021 15:08:47 +0100, Mark Brown wrote:
> As part of moving to remove the old style defines for the bus clocks update
> the 88pm860x driver to use more modern terminology for clocking.
> 
> 

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/1] ASoC: 88pm860x: Update to modern clocking terminology
      commit: 703ac1f2a5e5c3b9e8de41a8ad0b202532c0a453

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
