Return-Path: <SRS0=XQZd=IK=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9BB1FC433DB
	for <alsa-devel@archiver.kernel.org>; Fri, 12 Mar 2021 23:04:04 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B562F64F49
	for <alsa-devel@archiver.kernel.org>; Fri, 12 Mar 2021 23:04:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B562F64F49
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 4DB3B18B3;
	Sat, 13 Mar 2021 00:03:12 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 4DB3B18B3
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1615590242;
	bh=gKRx09iEEzT9fEiWAZ/WywZpvs/RAYQqI8WAKlElFYQ=;
	h=From:To:Subject:Date:In-Reply-To:References:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=pBGsp1bIS/r/wprXOANKilmFLQkjswdwqkO0zX3hYozLLeEPHXahrA4F6VhKiKCkk
	 60dvhiMjaiD65ndBqK05rY5OaRDCsudlAr02WIvVgvfc0kcO1oYqrK0r4An6UaCZjE
	 vR6uEL5uqUlZfZ60YQX/bu5WvsBUdNhdWgECJThU=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id A7ED5F802E0;
	Sat, 13 Mar 2021 00:02:22 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 5F18FF80272; Sat, 13 Mar 2021 00:02:17 +0100 (CET)
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 5ACA2F8012A
 for <alsa-devel@alsa-project.org>; Sat, 13 Mar 2021 00:02:14 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 5ACA2F8012A
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org
 header.b="lJDsGGeB"
Received: by mail.kernel.org (Postfix) with ESMTPSA id 7519564F6D;
 Fri, 12 Mar 2021 23:02:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1615590133;
 bh=gKRx09iEEzT9fEiWAZ/WywZpvs/RAYQqI8WAKlElFYQ=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=lJDsGGeBUBAgWoOvLFNlj4XVDLcIpp382xSzdXMx5FMir3/xKgpVJIyITYaVIJGx3
 WYEFhRwtUULH3sgpDwNRZHEcG7BkjdCqVKUPq5/6jDnZENyxVBtVtre6G6LHZunFtc
 jqfEfLd1aL1ysYGKcVGn7Z3EGyO0fSgqby1ZB48p0GexNwVPMp/bX2zOgxmURl0/DL
 FA9POWxn9Ju3hwyeCR+q2CTu9iCtr8lcNDDJo9l/tE7Tvu+ieTpiWRNBVI/K//kcpX
 9kjQhkzcU03t/KPxeh8aoHSCpyolxADNGM/+bngRgmYMJVk+aeOkdwMHZBIX6qt+z6
 5CyVu70/F+njA==
From: Mark Brown <broonie@kernel.org>
To: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
 alsa-devel@alsa-project.org
Subject: Re: (subset) [PATCH v3 0/2] ASoC: samsung: remove cppcheck warnings
Date: Fri, 12 Mar 2021 23:00:51 +0000
Message-Id: <161558981189.31753.5372027063951646682.b4-ty@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20210311003516.120003-1-pierre-louis.bossart@linux.intel.com>
References: <20210311003516.120003-1-pierre-louis.bossart@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Cc: tiwai@suse.de, Mark Brown <broonie@kernel.org>,
 Krzysztof Kozlowski <krzk@kernel.org>
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

On Wed, 10 Mar 2021 18:35:14 -0600, Pierre-Louis Bossart wrote:
> v3:
> Added Sylwester tag
> Rebased and squashed fix with initial patch which was merged at some
> point but can't be found in broonie/for-next (not sure what happened?)
> Corrected patch subjects to tm2_wm5110
> Reverted second patch to initial v1, after agreement between Krzysztof
> and Sylwester
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/2] ASoC: samsung: tm2_wm5110: check of of_parse return value
      commit: d58970da324732686529655c21791cef0ee547c4

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
