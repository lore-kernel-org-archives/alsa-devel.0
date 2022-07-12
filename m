Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B76E6C43334
	for <alsa-devel@archiver.kernel.org>; Tue, 12 Jul 2022 15:12:33 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 019AF16E3;
	Tue, 12 Jul 2022 17:11:42 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 019AF16E3
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1657638752;
	bh=VLQ/wAybFPAaFC9wplm5wvcA7gn9k2Mw5C/q0A8VLYU=;
	h=From:To:In-Reply-To:References:Subject:Date:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=X4sON2Ae29S/In/4Xx+KaJVuao52sXaUGRB01joSmxLE9BpnjyJUN3G7kgkxg9dZD
	 8epDn+nPdPShTDuPiwTMMBtfYBS2bIETWbuu3FRefYokWE42ofEmKnXRunkgD/qfiF
	 OBTxpCDLGHDMhp0kZhZCng1mOTKm0hhm15Yg9e6U=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 8F670F80542;
	Tue, 12 Jul 2022 17:10:56 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id BA5E0F804FF; Tue, 12 Jul 2022 17:10:55 +0200 (CEST)
Received: from dfw.source.kernel.org (dfw.source.kernel.org
 [IPv6:2604:1380:4641:c500::1])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 1E14BF800BD
 for <alsa-devel@alsa-project.org>; Tue, 12 Jul 2022 17:10:48 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 1E14BF800BD
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org
 header.b="nflFEqF6"
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by dfw.source.kernel.org (Postfix) with ESMTPS id 92765615D1;
 Tue, 12 Jul 2022 15:10:46 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 96C3AC341CA;
 Tue, 12 Jul 2022 15:10:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1657638646;
 bh=VLQ/wAybFPAaFC9wplm5wvcA7gn9k2Mw5C/q0A8VLYU=;
 h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
 b=nflFEqF6ZDusCFBy1lwhDP9xO0ZivY5CjZFfWLZ5F3dXYNG9lVQCugaNEyj4t4OkY
 RGJEyG33OC1o5+X/lFjtiGnwCrBs4/Lz7eXMtFnxcA9jYQiJNKI0CmSSsRI3qPLkyI
 /Gr65TMPv5yPcQuvUSNOj2TQ2PHZKhFiXRowqsAb2sLne8VK1iBBUjO12VO1DHk/YM
 3URXXcSLikq1IbQ1Rn2JWdBP7RST/c2+sWFVI3wauUnWtZ/gHINhNJXU2MyESd+QZ7
 uruBODuCIFIMlWvro+QKvFtIfolkgVD58uAGmLcx1lGqc6IIHmDK5PILSXLJt4d4Nn
 cxRI4pYBmpVAw==
From: Mark Brown <broonie@kernel.org>
To: pierre-louis.bossart@linux.intel.com, lgirdwood@gmail.com,
 peter.ujfalusi@linux.intel.com
In-Reply-To: <20220712123902.14696-1-peter.ujfalusi@linux.intel.com>
References: <20220712123902.14696-1-peter.ujfalusi@linux.intel.com>
Subject: Re: [PATCH] ASoC: SOF: topology: remove unused variable
Message-Id: <165763864434.336976.1403203290735408320.b4-ty@kernel.org>
Date: Tue, 12 Jul 2022 16:10:44 +0100
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Cc: alsa-devel@alsa-project.org, yung-chuan.liao@linux.intel.com,
 ranjani.sridharan@linux.intel.com, kai.vehmanen@linux.intel.com
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

On Tue, 12 Jul 2022 15:39:02 +0300, Peter Ujfalusi wrote:
> From: Ranjani Sridharan <ranjani.sridharan@linux.intel.com>
> 
> 'ret' is never used. Remove it and return 0 instead.
> 
> 

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/1] ASoC: SOF: topology: remove unused variable
      commit: 98418a08a20d3a72e14d88ccb3a48d0bf961ab6a

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
