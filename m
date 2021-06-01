Return-Path: <SRS0=jKKe=K3=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 57F05C4708F
	for <alsa-devel@archiver.kernel.org>; Tue,  1 Jun 2021 17:41:22 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CCB84613CE
	for <alsa-devel@archiver.kernel.org>; Tue,  1 Jun 2021 17:41:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CCB84613CE
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 6DBA116EE;
	Tue,  1 Jun 2021 19:40:30 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 6DBA116EE
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1622569280;
	bh=IsxflLVMC38tXNU/Y3HRiS6pww0zqonXV9n+CXcp8uw=;
	h=From:To:Subject:Date:In-Reply-To:References:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=G2RflBUyUA551KSVoECvI8iZOhtkjLg+wr/kht/OxVecUuoq77BfjUYIKe2dMLcDk
	 9bxmEVL9m8TsGjZEYoUd/GDGuFH7OrxrjfXW6sRQtMxWvmi2szTt7E5i1kOJOx39Eq
	 mCvnScsimfjENJC5DTK+o5NoMyRphKZlWODgLJh4=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id AD637F804C1;
	Tue,  1 Jun 2021 19:39:05 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 5CEECF804C1; Tue,  1 Jun 2021 19:39:01 +0200 (CEST)
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id AD4E1F804B0
 for <alsa-devel@alsa-project.org>; Tue,  1 Jun 2021 19:38:58 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz AD4E1F804B0
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org
 header.b="MQ1ueF5R"
Received: by mail.kernel.org (Postfix) with ESMTPSA id 39DB1613D0;
 Tue,  1 Jun 2021 17:38:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1622569136;
 bh=IsxflLVMC38tXNU/Y3HRiS6pww0zqonXV9n+CXcp8uw=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=MQ1ueF5RepFXCRrtQ0GBwq+pfMMlbJhFBX0UYp4RmSRREStCPf9VtqCYUmUqQfT5v
 7hMK5AFuz+q8WDw6qNThiqaherJ42XW0kbGWCyLlD/r+aHLrVrZoHVV828Innjtdhu
 tNQ9uilInQUxv2ppVecsLIWYdpLjEv2hhek+1hf8nMn7hOKupDBP/sYthGPY6I8F2A
 Rq0+ViE4bOvSZIgKahoa2aeKpM6YuvRfx8WiC+37jKTF6OD7V65LE4e3IZGWukReDk
 BUwYWRvvYfT3vlGrgprLcP4pxUxG5dD6KL2OpCbXYqXxVgf+Heiwdj+ZfN2afAiTQB
 KDrga4utMLqPg==
From: Mark Brown <broonie@kernel.org>
To: alsa-devel@alsa-project.org,
	Kai Vehmanen <kai.vehmanen@linux.intel.com>
Subject: Re: [PATCH] ASoC: SOF: reset enabled_cores state at suspend
Date: Tue,  1 Jun 2021 18:38:11 +0100
Message-Id: <162256892744.19919.7873592949904416032.b4-ty@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20210528144330.2551-1-kai.vehmanen@linux.intel.com>
References: <20210528144330.2551-1-kai.vehmanen@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Cc: yung-chuan.liao@linux.intel.com, pierre-louis.bossart@linux.intel.com,
 lgirdwood@gmail.com, Mark Brown <broonie@kernel.org>,
 ranjani.sridharan@linux.intel.com, daniel.baluta@nxp.com
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

On Fri, 28 May 2021 17:43:30 +0300, Kai Vehmanen wrote:
> The recent changes to use common code to power up/down DSP cores also
> removed the reset of the core state at suspend. It turns out this is
> still needed. When the firmware state is reset to
> SOF_FW_BOOT_NOT_STARTED, also enabled_cores should be reset, and
> existing DSP drivers depend on this.

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/1] ASoC: SOF: reset enabled_cores state at suspend
      commit: b640e8a4bd24e17ce24a064d704aba14831651a8

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
