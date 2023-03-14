Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 43C9EC6FD1C
	for <alsa-devel@archiver.kernel.org>; Tue, 14 Mar 2023 16:26:38 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 520501348;
	Tue, 14 Mar 2023 17:25:46 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 520501348
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1678811196;
	bh=decudFp3VIkjiluy8tE5KkWpYRUux8eT0psi0tJBpWA=;
	h=From:To:In-Reply-To:References:Subject:Date:CC:List-Id:
	 List-Archive:List-Help:List-Owner:List-Post:List-Subscribe:
	 List-Unsubscribe:From;
	b=XfY/Z/6IS6/DB+Vo8zh5l3dzK6iEYsgsX0514j0BHRIeDtr9bji4rXcDK1jiIdpap
	 uhmBFrm6FwI0O1zqEoiQDib22x/ess9RQk0UKWNgSRe88w1MPstQ7tgCPHyWQ9+QFS
	 e2ZjrCn+U6Kbp5IMnaT314uVpFeaX7ELQYIAc038=
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id 07D0FF80423;
	Tue, 14 Mar 2023 17:25:25 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 1EB90F80423; Tue, 14 Mar 2023 17:25:20 +0100 (CET)
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa1.perex.cz (Postfix) with ESMTPS id B234FF800C9
	for <alsa-devel@alsa-project.org>; Tue, 14 Mar 2023 17:25:16 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz B234FF800C9
Authentication-Results: alsa1.perex.cz;
	dkim=pass (2048-bit key,
 unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20201202 header.b=uDrJu8Ys
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.source.kernel.org (Postfix) with ESMTPS id 5E2026182E;
	Tue, 14 Mar 2023 16:25:14 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2D888C433D2;
	Tue, 14 Mar 2023 16:25:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1678811113;
	bh=decudFp3VIkjiluy8tE5KkWpYRUux8eT0psi0tJBpWA=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=uDrJu8YsznmBfKiOwdHq+al+eUquoambKh1YHG2RF+joax7iJ+SbxdFgS3j+XFOAo
	 LisnHysOw/wScgEBoiwVQN4auMDPuYN49GpN3IwtZchk+b5FtrFaY4P5P3jhthABsD
	 4dbtnNQ9JtnuFcAlbCFEKVAzJ7hgXGLlFoRX0NMwMfSYwV1wM6/vC++HbL2bl722pK
	 J0/88nsh9RyHXfG7mmyvsSrdZKuVeu+a9dKCr3B3/AA9OOXaL6D/CyyqeukUUcqJhW
	 ffpmlcrRLFjp7pwpEpqkpUhfmemGOb/WVkYE64Sr5bSfjI0AIwqi7NQv4N3MikPakA
	 Bz10fbnESXvSw==
From: Mark Brown <broonie@kernel.org>
To: tiwai@suse.de, Bard Liao <yung-chuan.liao@linux.intel.com>
In-Reply-To: <20230314090553.498664-1-yung-chuan.liao@linux.intel.com>
References: <20230314090553.498664-1-yung-chuan.liao@linux.intel.com>
Subject: Re: [PATCH 0/2] ASOC: Intel: add quirk for Intel 'Rooks County'
 NUC M15
Message-Id: <167881111191.52016.12428043763542728562.b4-ty@kernel.org>
Date: Tue, 14 Mar 2023 16:25:11 +0000
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.13-dev-bd1bf
Message-ID-Hash: LVQHWZB4RMW3HORY2OW36LYRGBLRJUXK
X-Message-ID-Hash: LVQHWZB4RMW3HORY2OW36LYRGBLRJUXK
X-MailFrom: broonie@kernel.org
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency;
 loop; banned-address; member-moderation;
 header-match-alsa-devel.alsa-project.org-0;
 header-match-alsa-devel.alsa-project.org-1; nonmember-moderation;
 administrivia; implicit-dest; max-recipients; max-size; news-moderation;
 no-subject; digests; suspicious-header
CC: alsa-devel@alsa-project.org, pierre-louis.bossart@linux.intel.com,
 vkoul@kernel.org, bard.liao@intel.com, peter.ujfalusi@linux.intel.com,
 vinod.koul@linaro.org
X-Mailman-Version: 3.3.8
Precedence: list
List-Id: "Alsa-devel mailing list for ALSA developers -
 http://www.alsa-project.org" <alsa-devel.alsa-project.org>
Archived-At: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/LVQHWZB4RMW3HORY2OW36LYRGBLRJUXK/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

On Tue, 14 Mar 2023 17:05:51 +0800, Bard Liao wrote:
> Adding Intel 'Rooks County' NUC M15 support. To support 'Rooks County', we
> also need the "soundwire: dmi-quirks: add remapping for Intel 'Rooks
> County'" patch.
> 
> Eugene Huang (2):
>   ASOC: Intel: sof_sdw: add quirk for Intel 'Rooks County' NUC M15
>   ASoC: Intel: soc-acpi: add table for Intel 'Rooks County' NUC M15
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/2] ASOC: Intel: sof_sdw: add quirk for Intel 'Rooks County' NUC M15
      commit: 3c728b1bc5b99c5275ac5c7788ef814c0e51ef54
[2/2] ASoC: Intel: soc-acpi: add table for Intel 'Rooks County' NUC M15
      commit: 9c691a42b8926c8966561265cdae3ddc7464d3a2

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

