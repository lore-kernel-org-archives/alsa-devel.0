Return-Path: <SRS0=Z19R=PP=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EF8B3C433F5
	for <alsa-devel@archiver.kernel.org>; Wed, 27 Oct 2021 17:33:28 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6566B60EFF
	for <alsa-devel@archiver.kernel.org>; Wed, 27 Oct 2021 17:33:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 6566B60EFF
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 920D716C1;
	Wed, 27 Oct 2021 19:32:36 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 920D716C1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1635356006;
	bh=6/NHya5tluTrQEPd0tEH6Q2dZSJ/1QN4FsU4SYRmBb0=;
	h=From:To:In-Reply-To:References:Subject:Date:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=hrk9gbmFi8p4sxwqhmWSGMRFn8XStkNNmnE4QEdDkXUZWDTpNCEjYat8TeGd4yBmS
	 rbdAp1kwZ5mpR4LO0dBu7WyKwGfofF38tBfAQaRpGMt/YR6Pts7c6L1+sYCkX6VSxd
	 x9FbNLpwxgBhZyu+92komQLbiPo9rOi+blnIVyEg=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 8789FF80516;
	Wed, 27 Oct 2021 19:29:58 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 2B466F804E3; Wed, 27 Oct 2021 19:29:28 +0200 (CEST)
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 2B228F8016C
 for <alsa-devel@alsa-project.org>; Wed, 27 Oct 2021 19:29:20 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 2B228F8016C
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org
 header.b="T6Y9NUw/"
Received: by mail.kernel.org (Postfix) with ESMTPSA id 298B0610C8;
 Wed, 27 Oct 2021 17:29:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1635355758;
 bh=6/NHya5tluTrQEPd0tEH6Q2dZSJ/1QN4FsU4SYRmBb0=;
 h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
 b=T6Y9NUw/gjSYo/O4IXch6dBzZNVD5kLtz66iyel41V7Xv/kqUn61n/CpZ4STda4XB
 qfFFVPRDovTXZlxRw0pLNP0ObLugcfNiZz6A2Jh5UYwCMt7/m5bx0PwQafW75jCawN
 Lj+gFEsf4QRxmVbbc9pM/VboOOklNRzSW8eUpWK/KlYs/uznAihXNLK7iF8DFIfMMg
 y+PIFr/pSwxxPcq3Od93Ir+/o4ghJ94MOl0qJ4iGqfHpx58T8bRkDoFwHrK5I6qkO5
 I5a0CN7ZwDFi0BfWMQl81gID3jCjXP1/kH5jsikU2/DtLQxALmryJLy2oB0WaIuaRK
 yYATzztXgNREg==
From: Mark Brown <broonie@kernel.org>
To: tiwai@suse.de, Bard Liao <yung-chuan.liao@linux.intel.com>
In-Reply-To: <20211027023311.25005-1-yung-chuan.liao@linux.intel.com>
References: <20211027023311.25005-1-yung-chuan.liao@linux.intel.com>
Subject: Re: [PATCH] ASoC: Intel: soc-acpi: add entry for ESSX8336 on JSL
Message-Id: <163535575691.4012075.3600186563235772420.b4-ty@kernel.org>
Date: Wed, 27 Oct 2021 18:29:16 +0100
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Cc: alsa-devel@alsa-project.org, pierre-louis.bossart@linux.intel.com,
 bard.liao@intel.com
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

On Wed, 27 Oct 2021 10:33:11 +0800, Bard Liao wrote:
> From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
> 
> We have configurations for this codec on APL, GLK and TGL, somehow the
> information that some designs rely on JasperLake was not shared.
> 
> 

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/1] ASoC: Intel: soc-acpi: add entry for ESSX8336 on JSL
      commit: 63ff4c50ac5667f697799d780c0fe7b74585e28b

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
