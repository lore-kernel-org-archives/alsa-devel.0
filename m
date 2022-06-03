Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C7199C43334
	for <alsa-devel@archiver.kernel.org>; Fri,  3 Jun 2022 11:27:40 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id EFA9C1840;
	Fri,  3 Jun 2022 13:26:48 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz EFA9C1840
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1654255659;
	bh=ePO0oMd2hXHYFPqfmas8/MfHkG7JTc+UdxPVMGtLXe4=;
	h=From:To:In-Reply-To:References:Subject:Date:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=cIeX7Iq6sG4UCs4qxnNIf6AIxR96tG3JH49FjwjPbSPUSPAoNwmdBl6/QLQm6OhY5
	 7jM5TWwu1IC877heKlEBp3pwGkgtNIMdZ1v6Ua5c7JHwWpI5tAJAutXwz9iH1ZaZK6
	 +tEtnQ6QuByAAHroOeZnZNrWrCWdxEFwzmRDnntg=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 941D7F800F5;
	Fri,  3 Jun 2022 13:26:48 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 178BCF800F5; Fri,  3 Jun 2022 13:26:47 +0200 (CEST)
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 28B58F800F5
 for <alsa-devel@alsa-project.org>; Fri,  3 Jun 2022 13:26:40 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 28B58F800F5
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org
 header.b="pnONbZ2p"
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by ams.source.kernel.org (Postfix) with ESMTPS id 7870AB822A7;
 Fri,  3 Jun 2022 11:26:40 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 67C8AC385B8;
 Fri,  3 Jun 2022 11:26:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1654255599;
 bh=ePO0oMd2hXHYFPqfmas8/MfHkG7JTc+UdxPVMGtLXe4=;
 h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
 b=pnONbZ2p6xrbNb/5sM+6UQ2uRrIeoBT8/15qzNLogMvQ9Gfo5fsJU/j/ecWglLvVW
 0btgbzLyxwPCTNL5rGrrGhe2EufbpK9AJ4iBhFbTrUtlGj0wE9Q9arzpEqOzfwv2r2
 YbPRrY2P12+3IcDDelAHKOhcDB5eNnf+YSBqR2ReJwB9ewBBsk5tCkhfiMu/iSRfj2
 nzz7ot4TH1zkn0jphhCf1yrGdug95EaYO2oX1zjTqmjBotyQFmBV0sTSKin7oMSZ7E
 29CtqlBLvyhJWRmB1OgPQyIE+Qywk1eW/RvCok8Y+WtBO1XpRd6iay9bBmYIVj5Gm1
 DJS3eVvFTAAsQ==
From: Mark Brown <broonie@kernel.org>
To: brent.lu@intel.com, alsa-devel@alsa-project.org
In-Reply-To: <20220602051922.1232457-1-brent.lu@intel.com>
References: <20220602051922.1232457-1-brent.lu@intel.com>
Subject: Re: [PATCH v2] ASoC: Intel: cirrus-common: fix incorrect channel
 mapping
Message-Id: <165425559642.3863069.12777301220337016957.b4-ty@kernel.org>
Date: Fri, 03 Jun 2022 13:26:36 +0200
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Cc: cezary.rojewski@intel.com, linux-kernel@vger.kernel.org,
 yang.jie@linux.intel.com, tiwai@suse.com, pierre-louis.bossart@linux.intel.com,
 liam.r.girdwood@linux.intel.com, xiang.liu@cirrus.com,
 yung-chuan.liao@linux.intel.com
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

On Thu, 2 Jun 2022 13:19:22 +0800, Brent Lu wrote:
> From: xliu <xiang.liu@cirrus.com>
> 
> The default mapping of ASPRX1 (DAC source) is slot 0. Change the slot
> mapping of right amplifiers (WR and TR) to slot 1 to receive right
> channel data. Also update the ACPI instance ID mapping according to HW
> configuration.
> 
> [...]

Applied to

   broonie/sound.git for-linus

Thanks!

[1/1] ASoC: Intel: cirrus-common: fix incorrect channel mapping
      commit: d69a155555c9d57463b788c400f6b452d976bacd

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
