Return-Path: <SRS0=phwE=HF=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 70D81C433E0
	for <alsa-devel@archiver.kernel.org>; Wed,  3 Feb 2021 21:09:50 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 64F4464F43
	for <alsa-devel@archiver.kernel.org>; Wed,  3 Feb 2021 21:09:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 64F4464F43
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 79EFE1750;
	Wed,  3 Feb 2021 22:08:57 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 79EFE1750
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1612386587;
	bh=X++DCBsFSqm6GeJb1wRNId0elKmC5l4WSOzoH81rAEM=;
	h=From:To:In-Reply-To:References:Subject:Date:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=p5llNlKnms1krM7evRomXGgAmM0cKv3uqdRkxLY9xCmOnLcfGgZwuJ5VZ/LxYNwaf
	 Y0+nWZPUPMa4fu/GLqMepubAtZ3QHy89Jjb2Q9QJivip6Yl1fqPSa0CjtuQyuhzvo9
	 tBbwCC+DCABcNpKTAOrDzxF59pfh3XG7tfD8gjHU=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id E7E5FF801DB;
	Wed,  3 Feb 2021 22:08:07 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 7CB12F8016E; Wed,  3 Feb 2021 22:08:06 +0100 (CET)
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 83605F80155
 for <alsa-devel@alsa-project.org>; Wed,  3 Feb 2021 22:08:03 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 83605F80155
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org
 header.b="QaQAXbGf"
Received: by mail.kernel.org (Postfix) with ESMTPSA id A107764F43;
 Wed,  3 Feb 2021 21:08:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1612386481;
 bh=X++DCBsFSqm6GeJb1wRNId0elKmC5l4WSOzoH81rAEM=;
 h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
 b=QaQAXbGfBGb9PwLBEzZlSrCPhUdHjbS2TMJH8Al8LdQbQ7PFBZNIURyoumzdyzlm6
 pUQzdcNQLP6QA1xSG6xQULbo70o0DUC79qzDY+YIkz08JZV5u7zFjRHxVamzS+r0ri
 hrtObF9Nr2HSwP15JXnUgcJdgM0raFLeVuXCnMNsU/2SQS5PayRx+9JQNLGNGWNi6d
 T4qpVObWgNMM1c5jl5tCa578bfGQGM9bOlDJEgWLz6ngWoW9ivMnblA0yD8HCRbFTh
 s/OcTtCax+bzRSikwcco7k+MqYGhvJSPCux3Jx/yxBXDIB+VmvqPXXLU4yYX8qK94J
 EtR3C83/LHB2A==
From: Mark Brown <broonie@kernel.org>
To: Yang Li <yang.lee@linux.alibaba.com>, perex@perex.cz
In-Reply-To: <1612166481-121376-1-git-send-email-yang.lee@linux.alibaba.com>
References: <1612166481-121376-1-git-send-email-yang.lee@linux.alibaba.com>
Subject: Re: [PATCH] ASoC: Intel: catpt: remove unneeded semicolon
Message-Id: <161238642667.34424.5355030176481154960.b4-ty@kernel.org>
Date: Wed, 03 Feb 2021 21:07:06 +0000
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Cc: pierre-louis.bossart@linux.intel.com, cezary.rojewski@intel.com,
 alsa-devel@alsa-project.org, yang.jie@linux.intel.com,
 linux-kernel@vger.kernel.org, tiwai@suse.com, liam.r.girdwood@linux.intel.com
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

On Mon, 1 Feb 2021 16:01:21 +0800, Yang Li wrote:
> Eliminate the following coccicheck warning:
> ./sound/soc/intel/catpt/pcm.c:355:2-3: Unneeded semicolon

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/1] ASoC: Intel: catpt: remove unneeded semicolon
      commit: e01a03db74a88084fb91a4ff18bb8d47a1e12f62

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
