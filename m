Return-Path: <SRS0=sQP2=IP=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.2 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1D4E6C433E0
	for <alsa-devel@archiver.kernel.org>; Wed, 17 Mar 2021 13:43:02 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1C77D64F67
	for <alsa-devel@archiver.kernel.org>; Wed, 17 Mar 2021 13:43:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1C77D64F67
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id C78301897;
	Wed, 17 Mar 2021 14:42:07 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz C78301897
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1615988578;
	bh=XgvDN9+ZI5AiUc+xPeXnYranTBmsXCf/a6s6tclb1O4=;
	h=From:To:Subject:Date:In-Reply-To:References:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=dNKB4eYYS8VgQXI4Hwqdbsv+pbyAhHNQKMLTbBCc59iUeJxnpKB53WZMCHtEEAaB9
	 Ijjui4dyfK56p0QKVy3LC9l7jKKVCcTmUYgawN2P24aHaAV/p6ONBnp11UgXwQu+uo
	 0nGCJuk5Y0axsp1pms/OWQOuZ71TkojHFlpp9I30=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 33BE3F80148;
	Wed, 17 Mar 2021 14:42:07 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 62920F8021C; Wed, 17 Mar 2021 14:42:04 +0100 (CET)
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 35C40F80148
 for <alsa-devel@alsa-project.org>; Wed, 17 Mar 2021 14:41:51 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 35C40F80148
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org
 header.b="ry/J/KEL"
Received: by mail.kernel.org (Postfix) with ESMTPSA id 08AC364F50;
 Wed, 17 Mar 2021 13:41:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1615988508;
 bh=XgvDN9+ZI5AiUc+xPeXnYranTBmsXCf/a6s6tclb1O4=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=ry/J/KELDZqxjjGdXfoG66TK374xNVt0uqjTCVcsRBI+G/RGWlxaMMmDiAcM/YlgP
 4DSYTP0oWfVNcAFChbYikuLsRfJ6naMVaxDm6naCaHuBIg1Zei+62uvq0cvOZ9pGdL
 PoypXouEOUX7vQ0zZCulTmi5C4jqsTnoJS++kXGzWBpKE0PmVMJWOKaQOk53hF5OGS
 qucohmKbvnj2q6+y2QwQmFWmZ5dF3DRUFGsiqCoqYU5M501yw5J+8qVvi8xN4swkB8
 MV4i0DaAEHnBa3SmuuumI+gv9vxRdvNSAFgtV9UfGerKdalb4BcFxUddirI+hhXAVk
 jdnL16wVulrDw==
From: Mark Brown <broonie@kernel.org>
To: alsa-devel@alsa-project.org, tiwai@suse.com,
 Bhaskar Chowdhury <unixbhaskar@gmail.com>, peter.ujfalusi@gmail.com,
 linux-kernel@vger.kernel.org, lgirdwood@gmail.com, perex@perex.cz
Subject: Re: [PATCH] sound: soc: ti: Fix a typo in the file ams-delta.c
Date: Wed, 17 Mar 2021 13:41:38 +0000
Message-Id: <161598838274.8460.1631004595185849740.b4-ty@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20210317082042.3670745-1-unixbhaskar@gmail.com>
References: <20210317082042.3670745-1-unixbhaskar@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Cc: Mark Brown <broonie@kernel.org>, rdunlap@infradead.org
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

On Wed, 17 Mar 2021 13:50:42 +0530, Bhaskar Chowdhury wrote:
> s/functonality/functionality/

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/1] sound: soc: ti: Fix a typo in the file ams-delta.c
      commit: c00f4f2598d334470b49385f811ca8f5c966a63e

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
