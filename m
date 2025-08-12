Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B3F66C87FCB
	for <alsa-devel@archiver.kernel.org>; Tue, 12 Aug 2025 11:06:10 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [45.14.194.44])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id C4A586022D;
	Tue, 12 Aug 2025 13:05:55 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz C4A586022D
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1754996765;
	bh=ie5dSbR0srUd/AiwBm098+waDjbLclE01XffS8zj2kU=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:List-Id:
	 List-Archive:List-Help:List-Owner:List-Post:List-Subscribe:
	 List-Unsubscribe:From;
	b=NqpqdPYSoxytcsv0Gp6bwAbIpqZuQP+Dl6ly++fuyaobC3JfakgtyfQ/Aaz6AUUDq
	 TCwq775sx1ZBSF8ky7d5DwSgXFsUaGdgc4D0AaVUWoC/fiYePaw3u36uGr4NLpsWkR
	 7dT0XIhZgbCpYAuOBRWJll+lEHM361h6kFeEfho4=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 3670AF805BA; Tue, 12 Aug 2025 13:05:29 +0200 (CEST)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id D3C49F805D2;
	Tue, 12 Aug 2025 13:05:28 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id D9D35F8042F; Tue, 12 Aug 2025 13:05:05 +0200 (CEST)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest
 SHA256)
	(No client certificate requested)
	by alsa1.perex.cz (Postfix) with ESMTPS id 419DCF8021D
	for <alsa-devel@alsa-project.org>; Tue, 12 Aug 2025 13:05:01 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 419DCF8021D
Authentication-Results: alsa1.perex.cz;
	dkim=pass (2048-bit key,
 unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20201202 header.b=h0e0OYqz
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sea.source.kernel.org (Postfix) with ESMTP id CB72F4487F;
	Tue, 12 Aug 2025 11:04:58 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 37273C4CEF4;
	Tue, 12 Aug 2025 11:04:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1754996698;
	bh=ie5dSbR0srUd/AiwBm098+waDjbLclE01XffS8zj2kU=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=h0e0OYqzTtLCCBB/yY8rE6D+HUSq4XnLsfZpPcAMaf5/f4Zmo4Gxh8tKil8rIE3K6
	 oKW80xVkRGm3wAhxz5ncXxgi8rxnxsMXVQLhTRA6qohkJOWHsm++ZspxDKO/S03LqV
	 sss/yPcE9wfA9wpTR/lVCXjtnhX0GP25jbnnGg38o1w6QVyCPnY7VimoMlrsVhPWwB
	 6o/COS2BJ9pJR1eRNPnoc3wOkCh+fes6DLJ5zZ9NevgRlVao+16e9wo4tVrVSFEhge
	 ncvAj5v0QuerSrCeCzvjzFPjOzRLli5rARpuE2WTnSYpoeRP8/s3Y2p2UG/nZj/SdH
	 edJtNN1K7gP4g==
From: Mark Brown <broonie@kernel.org>
To: Shenghao Ding <shenghao-ding@ti.com>
Cc: andriy.shevchenko@linux.intel.com, tiwai@suse.de, 13916275206@139.com,
 13564923607@139.com, alsa-devel@alsa-project.org, baojun.xu@ti.com,
 jesse-ji@ti.com
In-Reply-To: <20250803131110.1443-1-shenghao-ding@ti.com>
References: <20250803131110.1443-1-shenghao-ding@ti.com>
Subject: Re: [PATCH v1] ASoC: tas2781: Add keyword "init" in profile
 section
Message-Id: <175499669697.16031.1227920578537715967.b4-ty@kernel.org>
Date: Tue, 12 Aug 2025 12:04:56 +0100
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15-dev-cff91
Message-ID-Hash: RCP35LH4X52P75LPVYHZI4DS4FZPM7Z4
X-Message-ID-Hash: RCP35LH4X52P75LPVYHZI4DS4FZPM7Z4
X-MailFrom: broonie@kernel.org
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency;
 loop; banned-address; member-moderation;
 header-match-alsa-devel.alsa-project.org-0;
 header-match-alsa-devel.alsa-project.org-1; nonmember-moderation;
 administrivia; implicit-dest; max-recipients; max-size; news-moderation;
 no-subject; digests; suspicious-header
X-Mailman-Version: 3.3.9
Precedence: list
List-Id: "Alsa-devel mailing list for ALSA developers -
 http://www.alsa-project.org" <alsa-devel.alsa-project.org>
Archived-At: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/RCP35LH4X52P75LPVYHZI4DS4FZPM7Z4/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

On Sun, 03 Aug 2025 21:11:10 +0800, Shenghao Ding wrote:
> Since version 0x105, the keyword 'init' was introduced into the profile,
> which is used for chip initialization, particularly to store common
> settings for other non-initialization profiles.
> 
> 

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/1] ASoC: tas2781: Add keyword "init" in profile section
      commit: e83dcd139e776ebb86d5e88e13282580407278e4

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

