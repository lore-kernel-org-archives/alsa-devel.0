Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0B4E5CD37B1
	for <alsa-devel@archiver.kernel.org>; Sat, 16 Sep 2023 01:14:47 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 4DF43E7B;
	Sat, 16 Sep 2023 03:13:54 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 4DF43E7B
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1694826884;
	bh=nvgkVq14DgfwbmuVFuVSFi9zupSUMPWrzMEtqJxm+HM=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:List-Id:
	 List-Archive:List-Help:List-Owner:List-Post:List-Subscribe:
	 List-Unsubscribe:From;
	b=mmSxAb7ORT9TDGhVm/IOSpjn6bip9WTqGkmsYea53TbOebG5zD6a/GAEKpKHawe5X
	 SbEU7L6ZwCI0w5V4saaKhHjgVxzPcYEvi4cGWF1M2IXDgn9XuKdg+FuNLP+iWJPlux
	 XwaUHkT03W7emqs21o5UJoKUXyf4eqtsM6ivQW2Q=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 9F59FF805AF; Sat, 16 Sep 2023 03:12:01 +0200 (CEST)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id D988FF805AF;
	Sat, 16 Sep 2023 03:12:00 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 3212EF805A8; Sat, 16 Sep 2023 03:11:50 +0200 (CEST)
Received: from sin.source.kernel.org (sin.source.kernel.org
 [IPv6:2604:1380:40e1:4800::1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest
 SHA256)
	(No client certificate requested)
	by alsa1.perex.cz (Postfix) with ESMTPS id E970FF80568
	for <alsa-devel@alsa-project.org>; Sat, 16 Sep 2023 03:11:45 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz E970FF80568
Authentication-Results: alsa1.perex.cz;
	dkim=pass (2048-bit key,
 unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20201202 header.b=G1sHTeBN
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits))
	(No client certificate requested)
	by sin.source.kernel.org (Postfix) with ESMTPS id D0FA2CE2E4D;
	Sat, 16 Sep 2023 01:11:43 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C254DC433C7;
	Sat, 16 Sep 2023 01:11:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1694826702;
	bh=nvgkVq14DgfwbmuVFuVSFi9zupSUMPWrzMEtqJxm+HM=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=G1sHTeBNAaFSuLXcxc/0haQhQUiHtiZsF0oaFCdu/GL2jRqypLmzjr+VPOyaSWoF8
	 72EqFlNvCPyoSMVfT8APDCwwgj9nsJBuiMS8Uz8pvpM9HStEdlmpVIPz11Q+OP7sD7
	 wwD+9NLyJ7C1udXoS6n+HzcjstKaVaxKto7dHLCRhKsObOuQ/jMXUy6STooAaHxv35
	 TFwNC1LbZKhiOS7WDdMayh+4ESZgV1YCw/3Fy5VO4eXYBYiOh77ixnRNexmwDnwm5t
	 gVLVb6AYp8uacT2Yrv6WkWEQbyje9HV+NLgb900NNF8b59q2TDbMpO/RAYPo51wfT4
	 wc0C9pcnqsSOw==
From: Mark Brown <broonie@kernel.org>
To: tiwai@suse.de, Bard Liao <yung-chuan.liao@linux.intel.com>
Cc: alsa-devel@alsa-project.org, pierre-louis.bossart@linux.intel.com,
 bard.liao@intel.com, peter.ujfalusi@linux.intel.com, arun.t@intel.com
In-Reply-To: <20230915080635.1619942-1-yung-chuan.liao@linux.intel.com>
References: <20230915080635.1619942-1-yung-chuan.liao@linux.intel.com>
Subject: Re: [PATCH 1/1] ASoC: Intel: common: add ACPI matching tables for
 Arrow Lake
Message-Id: <169482670051.606223.17684306734062535167.b4-ty@kernel.org>
Date: Sat, 16 Sep 2023 02:11:40 +0100
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.13-dev-034f2
Message-ID-Hash: OQHXWFMKKVCHMSNH6IKPEYOZ6ZT6QC67
X-Message-ID-Hash: OQHXWFMKKVCHMSNH6IKPEYOZ6ZT6QC67
X-MailFrom: broonie@kernel.org
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency;
 loop; banned-address; member-moderation;
 header-match-alsa-devel.alsa-project.org-0;
 header-match-alsa-devel.alsa-project.org-1; nonmember-moderation;
 administrivia; implicit-dest; max-recipients; max-size; news-moderation;
 no-subject; digests; suspicious-header
X-Mailman-Version: 3.3.8
Precedence: list
List-Id: "Alsa-devel mailing list for ALSA developers -
 http://www.alsa-project.org" <alsa-devel.alsa-project.org>
Archived-At: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/OQHXWFMKKVCHMSNH6IKPEYOZ6ZT6QC67/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

On Fri, 15 Sep 2023 16:06:35 +0800, Bard Liao wrote:
> Initial support for ARL w/ RT711
> 
> 

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/1] ASoC: Intel: common: add ACPI matching tables for Arrow Lake
      commit: 24af0d7c0f9f49a243b77e607e3f4a4737386b59

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

