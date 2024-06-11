Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1B233C27C5E
	for <alsa-devel@archiver.kernel.org>; Tue, 11 Jun 2024 11:28:32 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 5769F857;
	Tue, 11 Jun 2024 13:28:20 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 5769F857
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1718105310;
	bh=cd4O11S0fpkvNr4NAbwVmuRK/tJ0PCOPtUoXM4xVmeI=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:List-Id:
	 List-Archive:List-Help:List-Owner:List-Post:List-Subscribe:
	 List-Unsubscribe:From;
	b=QsxEB9YEgvRx/Fd0gwaL1C+HvX635Q8XQEFCzjwtXQ19bx4wnI6Xwlg7b0CdczTw4
	 WAWVJqI/RrLJB3r4ERRqXkT94Xcwm0TLmihCzbRhXa+HcZyBl7s1ARE5MftUBHheAV
	 K9fghsSNpczrVRf/tmmMloHiWsQecDjoIIXPCi48=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id E4503F805C0; Tue, 11 Jun 2024 13:27:57 +0200 (CEST)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id 64B1AF805A9;
	Tue, 11 Jun 2024 13:27:57 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id A988EF8057A; Tue, 11 Jun 2024 13:27:52 +0200 (CEST)
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest
 SHA256)
	(No client certificate requested)
	by alsa1.perex.cz (Postfix) with ESMTPS id 5B720F8010C
	for <alsa-devel@alsa-project.org>; Tue, 11 Jun 2024 13:27:48 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 5B720F8010C
Authentication-Results: alsa1.perex.cz;
	dkim=pass (2048-bit key,
 unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20201202 header.b=rXHd5M7D
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by dfw.source.kernel.org (Postfix) with ESMTP id 1F94B60DD4;
	Tue, 11 Jun 2024 11:27:47 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 37CE7C2BD10;
	Tue, 11 Jun 2024 11:27:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718105266;
	bh=cd4O11S0fpkvNr4NAbwVmuRK/tJ0PCOPtUoXM4xVmeI=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=rXHd5M7DgMnZ3U6Oc9RrSco/yGI9l43PdndMsUvMVsxMx5ny+T9RqicpGD3vOULD7
	 RdIy8TTovDcamDDcliDNiePTvbs+fOUWZwQzG8fOs5HoTyACrl+oArndiFyxHVEzU7
	 dTkYH5suIQOVyKKNHws53bAn3g/zUkTx9HLk4V6kHm+T9u79+aoIYXToiLq597CJle
	 K/uqY8fkSNGnGkgcaYWeXpZGxAOjZLUaGM7upW0mas3+gS1h0vNm6j9mPgXtnHYi0q
	 k87nfjpWye0x7Z/k+2Cdw+DwaRgnqwFScUxw8qdqolniwLmZ6cFiqTGmAr9gy5V3qy
	 pMEXLZM5mQf/w==
From: Mark Brown <broonie@kernel.org>
To: pierre-louis.bossart@linux.intel.com,
 Thomas GENTY <tomlohave@gmail.com>
Cc: cezary.rojewski@intel.com, liam.r.girdwood@linux.intel.com,
 peter.ujfalusi@linux.intel.com, yung-chuan.liao@linux.intel.com,
 alsa-devel@alsa-project.org, Hans de Goede <hdegoede@redhat.com>
In-Reply-To: <20240608170251.99936-1-tomlohave@gmail.com>
References: <20240608170251.99936-1-tomlohave@gmail.com>
Subject: Re: [PATCH] bytcr_rt5640 : inverse jack detect for Archos 101
 cesium
Message-Id: <171810526493.189859.12616105829980501168.b4-ty@kernel.org>
Date: Tue, 11 Jun 2024 12:27:44 +0100
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14-dev-4c370
Message-ID-Hash: RHFCBHXVUXMMQC76ATPPG25ONJ2AUM5Q
X-Message-ID-Hash: RHFCBHXVUXMMQC76ATPPG25ONJ2AUM5Q
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
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/RHFCBHXVUXMMQC76ATPPG25ONJ2AUM5Q/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

On Sat, 08 Jun 2024 19:02:51 +0200, Thomas GENTY wrote:
> When headphones are plugged in, they appear absent; when they are removed,
> they appear present.
> Add a specific entry in bytcr_rt5640 for this device
> 
> 

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/1] bytcr_rt5640 : inverse jack detect for Archos 101 cesium
      commit: e3209a1827646daaab744aa6a5767b1f57fb5385

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

