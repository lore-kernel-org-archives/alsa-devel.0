Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8989BC433F5
	for <alsa-devel@archiver.kernel.org>; Fri, 29 Apr 2022 13:40:47 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id A443B15E0;
	Fri, 29 Apr 2022 15:39:55 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz A443B15E0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1651239645;
	bh=JvP9fnRkQuEqW2o+SUEjMSyAQxZhbmgFv0N8A+pXzAo=;
	h=From:To:In-Reply-To:References:Subject:Date:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=AZ4PjmaXr07S+v2yApEp0IyWNPjp2TCOknYh1HE4w/3pU02KxV+c5A/EKMcFN/L0e
	 bYgGrc09okgre8C+gkl7XR891sOcDDWtfZIoF5fDANrIOXGdUzOx+xy8Na/KzKFA1G
	 I0YxuD1yqHq1g0JFoAd5wkt0LuvU8emCM+cZBXHY=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id C3B1FF804F2;
	Fri, 29 Apr 2022 15:39:36 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 844B9F802E3; Fri, 29 Apr 2022 15:39:33 +0200 (CEST)
Received: from dfw.source.kernel.org (dfw.source.kernel.org
 [IPv6:2604:1380:4641:c500::1])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 508F8F8007E;
 Fri, 29 Apr 2022 15:39:28 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 508F8F8007E
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org
 header.b="lz6y7TP3"
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by dfw.source.kernel.org (Postfix) with ESMTPS id 5CAAF622E7;
 Fri, 29 Apr 2022 13:39:26 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 02D7DC385AC;
 Fri, 29 Apr 2022 13:39:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1651239565;
 bh=JvP9fnRkQuEqW2o+SUEjMSyAQxZhbmgFv0N8A+pXzAo=;
 h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
 b=lz6y7TP3AyQbpY4PFmMB2WHj9LF8FQwgh7gtT0icuH8/t7xknapu/6Xq1Wjtd6gfi
 J+wFzh39NsceR3sp4JIvaQahBfJ8/wDYxahxdJBu8lDzDyEJC7pciYff7jqENVd2gD
 G4YmOETd10KPUZdQWfGlPs47FD56RiCBP8kXX1SiZp29ybieIuidk76R5RjgNUFYvj
 GvN/qCOd3STSKD4+AsK7QtDB6/VL86DZ5xif5JygaFtfw6wcXJQ3SQWBzpww65M1jm
 T1wutzOD4JmQqqQMERV1I66VLyQI2w6s560AleWS0CHQNKXVMko5ddGlxFKI46l/pm
 GmwIeDldv8GDQ==
From: Mark Brown <broonie@kernel.org>
To: linux-kernel@vger.kernel.org, yangyingliang@huawei.com,
 alsa-devel@alsa-project.org, sound-open-firmware@alsa-project.org
In-Reply-To: <20220426132539.416676-1-yangyingliang@huawei.com>
References: <20220426132539.416676-1-yangyingliang@huawei.com>
Subject: Re: [PATCH -next] ASoC: SOF: sof-pci-dev: fix missing
 pci_release_regions() on error in sof_pci_probe()
Message-Id: <165123956371.69278.7447283193421745642.b4-ty@kernel.org>
Date: Fri, 29 Apr 2022 14:39:23 +0100
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Cc: yung-chuan.liao@linux.intel.com, ranjani.sridharan@linux.intel.com,
 peter.ujfalusi@linux.intel.com, pierre-louis.bossart@linux.intel.com,
 rander.wang@intel.com
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

On Tue, 26 Apr 2022 21:25:39 +0800, Yang Yingliang wrote:
> Fix the missing pci_release_regions() before return
> from sof_pci_probe() in the error handling case.
> 
> 

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/1] ASoC: SOF: sof-pci-dev: fix missing pci_release_regions() on error in sof_pci_probe()
      commit: bdc8cd505b5312c3b26f13f0b6a567d97d55e715

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
