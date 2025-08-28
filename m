Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 87D3DCA0EED
	for <alsa-devel@archiver.kernel.org>; Thu, 28 Aug 2025 21:01:46 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [45.14.194.44])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id E6B0D602AB;
	Thu, 28 Aug 2025 23:01:32 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz E6B0D602AB
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1756414902;
	bh=DBqonvOBX3w3IDOnQXMbogNECNQyWjuUr8rsLhJyhRA=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:List-Id:
	 List-Archive:List-Help:List-Owner:List-Post:List-Subscribe:
	 List-Unsubscribe:From;
	b=XuYHX2+ITUPZ5CvMWq132rarAGAL0NvMgKjKsy+X1bzOHQOtsdwdUvLsaqvb+3JRU
	 znTltQ9Cqqz3xaYMrU2V6Pf/omAF6OY5+fDA3K59B3WCasYgdnQtmLjD6ad0mvMxae
	 tSTEYB2ub9JlLjDy195Nw1P1ULkiSOsC6lcj092s=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 5E9B0F805C3; Thu, 28 Aug 2025 23:01:09 +0200 (CEST)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id 0FFA2F805CB;
	Thu, 28 Aug 2025 23:01:09 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 384E0F8028B; Thu, 28 Aug 2025 23:00:54 +0200 (CEST)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest
 SHA256)
	(No client certificate requested)
	by alsa1.perex.cz (Postfix) with ESMTPS id 48EB8F80072
	for <alsa-devel@alsa-project.org>; Thu, 28 Aug 2025 23:00:48 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 48EB8F80072
Authentication-Results: alsa1.perex.cz;
	dkim=pass (2048-bit key,
 unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20201202 header.b=rdA/75WB
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by tor.source.kernel.org (Postfix) with ESMTP id 88D5460139;
	Thu, 28 Aug 2025 21:00:46 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A897CC4CEF7;
	Thu, 28 Aug 2025 21:00:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756414846;
	bh=DBqonvOBX3w3IDOnQXMbogNECNQyWjuUr8rsLhJyhRA=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=rdA/75WBM4hHEo0XpwbWVjyWp3DsPu55VC6rkwIIVbbjuGGGClDjVBUW5ou9/O4Lq
	 a5CVttdnKzhA11++fzqJsG0ScBl7Gd0lpcVyqe8W9Bys+CZ9SnMzfDoc686mWOAu4M
	 w3EV0//N8sJmXjEY4ezmaNKdzJ/NCMZc5n9iFFY9p/2m/I2XgkO+RlYcbQktVyaeob
	 69FbfNxvho1rBLaGdN1PKiHA2eL/yI0anvRATMAW66L0CxvFHJRxq8NzxtN2bAtM7l
	 i75yFqQrC37plZiu2qtdgTeRlEHQC1vj2Dng+MgK26kDfmagA4ZInZqYczOB5wZf+j
	 d42hXS7OiYUUw==
From: Mark Brown <broonie@kernel.org>
To: linux-kernel@vger.kernel.org,
 Ajye Huang <ajye_huang@compal.corp-partner.google.com>
Cc: linux-sound@vger.kernel.org,
 Bard Liao <yung-chuan.liao@linux.intel.com>,
 Peter Ujfalusi <peter.ujfalusi@linux.intel.com>,
 Jaroslav Kysela <perex@perex.cz>,
 Ranjani Sridharan <ranjani.sridharan@linux.intel.com>,
 Takashi Iwai <tiwai@suse.com>, Liam Girdwood <lgirdwood@gmail.com>,
 Daniel Baluta <daniel.baluta@nxp.com>, Mac Chiang <mac.chiang@intel.com>,
 alsa-devel@alsa-project.org,
 Pierre-Louis Bossart <pierre-louis.bossart@linux.dev>
In-Reply-To: 
 <20250826154040.2723998-1-ajye_huang@compal.corp-partner.google.com>
References: 
 <20250826154040.2723998-1-ajye_huang@compal.corp-partner.google.com>
Subject: Re: [PATCH v3] ASoC: SOF: Intel: WCL: Add the sdw_process_wakeen
 op
Message-Id: <175641484343.364214.13960933303240952309.b4-ty@kernel.org>
Date: Thu, 28 Aug 2025 23:00:43 +0200
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15-dev-a9b2a
Message-ID-Hash: L6KJD6UMCZL4CYFWMUIHM3WKBSA2T4UW
X-Message-ID-Hash: L6KJD6UMCZL4CYFWMUIHM3WKBSA2T4UW
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
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/L6KJD6UMCZL4CYFWMUIHM3WKBSA2T4UW/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

On Tue, 26 Aug 2025 23:40:40 +0800, Ajye Huang wrote:
> Add the missing op in the device description to avoid issues with jack
> detection.
> 
> 

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/1] ASoC: SOF: Intel: WCL: Add the sdw_process_wakeen op
      commit: 3e7fd1febc3156d3d98fba229399a13b12d69707

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

