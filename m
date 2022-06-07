Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AB4DCC43334
	for <alsa-devel@archiver.kernel.org>; Tue,  7 Jun 2022 10:56:44 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id EE9201AC8;
	Tue,  7 Jun 2022 12:55:52 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz EE9201AC8
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1654599403;
	bh=gcmtrcdUa3hVAO5XH03O5X0/ZjiTd1gFVsjoFfV6Ufk=;
	h=From:To:In-Reply-To:References:Subject:Date:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=s2+2GGaawRwrGjBamrcGRBHc13YsGFYZYRnACr4kBriXQs4/jtIMAqxZ5xQjuqHUs
	 Ed/DGK4G6KmUiWrkGBgLUNHlqesXFmU6jpiGUTDiG8s64AtvN5NHN8t8YeMFXBIuAH
	 tQSwJaJIihUOZxWPIsAWL1BzRfkea9HHQkxoL8lM=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 7562CF8053B;
	Tue,  7 Jun 2022 12:55:07 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 4B1EFF80536; Tue,  7 Jun 2022 12:55:06 +0200 (CEST)
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id BE96EF80248
 for <alsa-devel@alsa-project.org>; Tue,  7 Jun 2022 12:55:02 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz BE96EF80248
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org
 header.b="OsHr0OH9"
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by dfw.source.kernel.org (Postfix) with ESMTPS id A7E4861563;
 Tue,  7 Jun 2022 10:55:01 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DB02BC34115;
 Tue,  7 Jun 2022 10:54:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1654599301;
 bh=gcmtrcdUa3hVAO5XH03O5X0/ZjiTd1gFVsjoFfV6Ufk=;
 h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
 b=OsHr0OH9UvFkH890qMNNXAfeyyWuXw5NXtBEeusigmeZMhlyi1EgX/dBrxYvfO1Tb
 6ApjqD7jaHtvhofSujYRPqfL1Lt2+biigAJgnZ4/C1PkvQjVPguQJvqMOR5j9XdCRZ
 P1nOLCKKisdXtad1mgpHidvnXP2rvpFpsNNBKiWzlwa8WThV0GmvKGTYRMx9fs77Wz
 2uadzPJxEVkhfUhUYvWRVXpPSHxRA6gmv+h3KDoF6G/sEPVJg2iq2+p+alHc7rncTo
 e73qdgBzYTu3NiZLs/4zYBRVS73KPwQdGWGw6YNbVZ6mb7tblBRqe1dBycr8N36Ajq
 BmKEIhDNoc2vg==
From: Mark Brown <broonie@kernel.org>
To: alsa-devel@alsa-project.org, Vsujithkumar.Reddy@amd.com
In-Reply-To: <20220523132353.1767614-1-Vsujithkumar.Reddy@amd.com>
References: <20220523132353.1767614-1-Vsujithkumar.Reddy@amd.com>
Subject: Re: [PATCH v3 0/2] Add Machine driver support for nau8825,
 max98560 and rt5682s, rt1019
Message-Id: <165459929961.399031.555690590042324791.b4-ty@kernel.org>
Date: Tue, 07 Jun 2022 11:54:59 +0100
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Cc: Basavaraj.Hiregoudar@amd.com, Sunil-kumar.Dommati@amd.com,
 ajitkumar.pandey@amd.com, Vijendar.Mukunda@amd.com
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

On Mon, 23 May 2022 18:53:51 +0530, V sujith kumar Reddy wrote:
> This patch set depends on:
>         --gpio patch
>         --https://patchwork.kernel.org/project/alsa-devel/patch/20220516160619.17832-1-Vsujithkumar.Reddy@amd.com/
>         --https://patchwork.kernel.org/project/alsa-devel/patch/20220516160619.17832-2-Vsujithkumar.Reddy@amd.com/
> 
> Resolved  compilation error:
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/2] ASoC: amd: acp: Add support for nau8825 and max98360 card
      commit: 0439eb4d94e0fc17c6dd3829fabd88c11773381d
[2/2] ASoC: amd: acp: Add support for rt5682s and rt1019 card with hs instance
      commit: 4dc6737cfe882765d914fcb88b5eaa14551ffddd

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
