Return-Path: <SRS0=y4EY=CX=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A79BAC43461
	for <alsa-devel@archiver.kernel.org>; Mon, 14 Sep 2020 14:56:09 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1781721741
	for <alsa-devel@archiver.kernel.org>; Mon, 14 Sep 2020 14:56:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="M0ZGAOy7";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="jEb9gTfE"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1781721741
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 8B1801699;
	Mon, 14 Sep 2020 16:55:17 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 8B1801699
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1600095367;
	bh=reCFGQsdm/FQSMiTmTYTWSoEk4KOIZ92Cihs2TyWIQM=;
	h=Date:From:To:In-Reply-To:References:Subject:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=M0ZGAOy7cjxrxWxnXQcGu6IhdBIHNODMX5pi9AMQkk/GPad36s2uHtgtj/OjTIx62
	 ko3/ixIx8EuLjw0wxNrP+p0DwuFCQddLwc+/XEXvjDKlOaxjXjQSHF2Rf8/iaXpR/M
	 tCiX1yBNeqATX4p1RDBqfrBLm5GdkloJrbYfp9gU=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 1FF83F802E7;
	Mon, 14 Sep 2020 16:52:25 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 9310CF802E1; Mon, 14 Sep 2020 16:52:22 +0200 (CEST)
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id F17C2F802E0
 for <alsa-devel@alsa-project.org>; Mon, 14 Sep 2020 16:52:19 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz F17C2F802E0
Authentication-Results: alsa1.perex.cz;
 dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org
 header.b="jEb9gTfE"
Received: from localhost (fw-tnat.cambridge.arm.com [217.140.96.140])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id 23904216C4;
 Mon, 14 Sep 2020 14:52:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1600095138;
 bh=reCFGQsdm/FQSMiTmTYTWSoEk4KOIZ92Cihs2TyWIQM=;
 h=Date:From:To:Cc:In-Reply-To:References:Subject:From;
 b=jEb9gTfERrOMksBHtj41rYFZv5bXRcDE5Gw+J/G50tdVPRIx8pbXu+UV/QdqObFH1
 D0ImwhMdcGlW2kKo9cadC3xmCyIZcIfHGgjYFdkdc/6N/Xu3V6BzwjWCKApQxJSa3P
 ff0AVYyhoHZtPu3CD0p6SwCyzHk8+UUUL5QAcr+s=
Date: Mon, 14 Sep 2020 15:51:30 +0100
From: Mark Brown <broonie@kernel.org>
To: Kai Vehmanen <kai.vehmanen@linux.intel.com>, alsa-devel@alsa-project.org
In-Reply-To: <20200910162705.2026036-1-kai.vehmanen@linux.intel.com>
References: <20200910162705.2026036-1-kai.vehmanen@linux.intel.com>
Subject: Re: [PATCH] ASoC: SOF: Intel: Use DMI oem string search for
 tgl_max98373_rt5682
Message-Id: <160009506911.439.9001583222831808483.b4-ty@kernel.org>
Cc: lgirdwood@gmail.com,
 Sathyanarayana Nujella <sathyanarayana.nujella@intel.com>,
 ranjani.sridharan@linux.intel.com, pierre-louis.bossart@linux.intel.com
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

On Thu, 10 Sep 2020 19:27:05 +0300, Kai Vehmanen wrote:
> DMI product name is used to support system variants based out of
> tgl_max98373_rt5682 in current implementation. Replace this DMI search with
> DMI_OEM_STRING. Coreboot(BIOS used in these systems) is
> setting the needed DMI_OEM_STRING field to uniquely identify these
> systems.

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/1] ASoC: SOF: Intel: Use DMI oem string search for tgl_max98373_rt5682
      commit: 2a4b91a26403fa3e7b07271700c3ca7103664bba

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
