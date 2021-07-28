Return-Path: <SRS0=/xSo=MU=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 490FAC4338F
	for <alsa-devel@archiver.kernel.org>; Wed, 28 Jul 2021 23:31:13 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 79AA760E9B
	for <alsa-devel@archiver.kernel.org>; Wed, 28 Jul 2021 23:31:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 79AA760E9B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 2940E1F56;
	Thu, 29 Jul 2021 01:30:21 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 2940E1F56
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1627515071;
	bh=+NI/Q1mxn7g59Uo+U5KM4ZKoYVyNYBLPtk1ASgNvUow=;
	h=From:To:Subject:Date:In-Reply-To:References:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=j29RcXOuxTlCQRDcWMcelcpxYQYz/7qxl3hVLnfsFXYiyy/JuBD244s/SqRMJwRn4
	 jFkxjFCph+d0wCOaZ8zixQ1saRSJMSPPCRjZdrulIoDOcL5hzdOqOCqaVsEdCLRV3w
	 S6repfwdmEaaKKzA6XL+DgQMN/+1WZv9G9FUH3eI=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 78155F804E2;
	Thu, 29 Jul 2021 01:29:05 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id F1602F8049E; Thu, 29 Jul 2021 01:28:29 +0200 (CEST)
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 40EDBF80127
 for <alsa-devel@alsa-project.org>; Thu, 29 Jul 2021 01:28:27 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 40EDBF80127
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org
 header.b="sM/HQQxJ"
Received: by mail.kernel.org (Postfix) with ESMTPSA id 4001160FD7;
 Wed, 28 Jul 2021 23:28:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1627514903;
 bh=+NI/Q1mxn7g59Uo+U5KM4ZKoYVyNYBLPtk1ASgNvUow=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=sM/HQQxJ9CWHoyXxLvHXxSkkq9COWnITBIWqG+7dcHfD0q8N0JeH1Iy5ZkRMSa35i
 2oWnQzGbQPiQ/yo8c1hePDRUrG0tgi527dxv+9ygKv7hQLaN4e6Bku/yqvcHcOe/Yj
 5dthiKRs6MBRN4SNv+za0//bCuW+BGF26GFHKUuDpX72rg7nIfYO3mRUAIWFe85mGr
 cJTMlk164/qNidvgQs5nHaZ8FjaHo6K+7Z/ojdg36ctbUSk3XToZH71LKCUWaLXXAJ
 kLhlQr032pvKJsPPhhTBIZsjGYVryr+OqH+z6SOzq6znsSR2qmeLy2ZnZ5QdGyqIOd
 EGIeV+28SjGJw==
From: Mark Brown <broonie@kernel.org>
To: Takashi Iwai <tiwai@suse.com>, Jaroslav Kysela <perex@perex.cz>,
 Liam Girdwood <lgirdwood@gmail.com>,
 Richard Fitzgerald <rf@opensource.cirrus.com>,
 Charles Keepax <ckeepax@opensource.cirrus.com>,
 Lucas Tanure <tanureal@opensource.cirrus.com>
Subject: Re: [PATCH] ASoC: wm_adsp: Let soc_cleanup_component_debugfs remove
 debugfs
Date: Thu, 29 Jul 2021 00:27:57 +0100
Message-Id: <162751391068.10122.6522975229334793917.b4-ty@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20210728104416.636591-1-tanureal@opensource.cirrus.com>
References: <20210728104416.636591-1-tanureal@opensource.cirrus.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Cc: alsa-devel@alsa-project.org, Adam Brickman <Adam.Brickman@cirrus.com>,
 patches@opensource.cirrus.com, Simon Trimmer <simont@opensource.cirrus.com>,
 Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
 linux-kernel@vger.kernel.org, Mark Brown <broonie@kernel.org>,
 James Schulman <james.schulman@cirrus.com>
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

On Wed, 28 Jul 2021 11:44:16 +0100, Lucas Tanure wrote:
> soc_cleanup_component_debugfs will debugfs_remove_recursive
> the component->debugfs_root, so adsp doesn't need to also
> remove the same entry.
> By doing that adsp also creates a race with core component,
> which causes a NULL pointer dereference

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/1] ASoC: wm_adsp: Let soc_cleanup_component_debugfs remove debugfs
      commit: acbf58e530416e167c3b323111f4013d9f2b0a7d

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
