Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 91FE2C4332F
	for <alsa-devel@archiver.kernel.org>; Wed, 14 Dec 2022 13:33:59 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id B83462A36;
	Wed, 14 Dec 2022 14:33:07 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz B83462A36
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1671024837;
	bh=ZVmx5Rff4Vm5MIo621M/fPY+vW9rWQEpruPjysJg/r0=;
	h=From:To:In-Reply-To:References:Subject:Date:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Cc:From;
	b=fuil/vs1lh6qU0VeLWLTlgv7y2EkqSc78UluePYf8W3yOYdeRIz0zEwEwShXtC8TU
	 tyzB0t7818nXnhp3siL1TeCP6K/+KOGHK80sPjkVHrae/Ki5tOmazkZ9qfczwA8eX+
	 DTxokd+pz/PLRbmZlgUXYQ2pyavcCPauSko3Y++g=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 47729F8055A;
	Wed, 14 Dec 2022 14:32:14 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 97711F8055B; Wed, 14 Dec 2022 14:32:13 +0100 (CET)
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 210B6F80552
 for <alsa-devel@alsa-project.org>; Wed, 14 Dec 2022 14:32:11 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 210B6F80552
Authentication-Results: alsa1.perex.cz; dkim=pass (2048-bit key,
 unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20201202 header.b=RIJ8TqrD
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by ams.source.kernel.org (Postfix) with ESMTPS id DE52CB818B6;
 Wed, 14 Dec 2022 13:32:10 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9C082C433F1;
 Wed, 14 Dec 2022 13:32:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1671024729;
 bh=ZVmx5Rff4Vm5MIo621M/fPY+vW9rWQEpruPjysJg/r0=;
 h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
 b=RIJ8TqrDbzKoEcGhBRkUncWimFEIVpBfF1UfcRCwU2LjXarjYOWnaUbOIa4Kk+1dR
 1P2p9i13S4NV+gabSXv7y4RAfMFjwV12vBVgM+0DJB7ZbXAWXCkORMGsvhsmZQcY5l
 1ye0HLxqwV7yzDuoaylfYAnAeLqJtqBjoA2AEgMlPQXwsLIv3/AkIXvJsoUu3XQ+og
 6GvmcGJlapxKXNHsTx1sfjqsgf7yg7BlX6rQlrJarHDqDKqyqfwU6vNCQuOBFnymNN
 Uj6OZ5EwPXuIjKwV3dBUQ5Pkj6rGQ5LuOycZ1xDicAfWUhnfZBhjxJLwYpvwCF7PXM
 JSfRzWt+HuHhw==
From: Mark Brown <broonie@kernel.org>
To: tiwai@suse.de, Bard Liao <yung-chuan.liao@linux.intel.com>
In-Reply-To: <20221212085527.1886168-1-yung-chuan.liao@linux.intel.com>
References: <20221212085527.1886168-1-yung-chuan.liao@linux.intel.com>
Subject: Re: [PATCH] ASoC: Intel: soc-acpi: update codec addr on 0C11/0C4F
 product
Message-Id: <167102472836.27755.16754783350587988867.b4-ty@kernel.org>
Date: Wed, 14 Dec 2022 13:32:08 +0000
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.11.0-dev-7e003
X-BeenThere: alsa-devel@alsa-project.org
X-Mailman-Version: 2.1.29
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
Cc: alsa-devel@alsa-project.org, pierre-louis.bossart@linux.intel.com,
 bard.liao@intel.com
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: "Alsa-devel" <alsa-devel-bounces@alsa-project.org>

On Mon, 12 Dec 2022 16:55:27 +0800, Bard Liao wrote:
> The unique ID is determined by the ADR pin level of rt1318.
> ODM changed design, update codec addr to match new design.
> 
> 

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/1] ASoC: Intel: soc-acpi: update codec addr on 0C11/0C4F product
      commit: 0612d748003ce7bcd0d67a8d270900fcdadb1009

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
