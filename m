Return-Path: <SRS0=AR4N=C6=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2241EC43465
	for <alsa-devel@archiver.kernel.org>; Mon, 21 Sep 2020 17:03:41 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B38DE2073A
	for <alsa-devel@archiver.kernel.org>; Mon, 21 Sep 2020 17:03:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="OA012fp8";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="Mdrq8lxr"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B38DE2073A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 4357016BB;
	Mon, 21 Sep 2020 19:02:48 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 4357016BB
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1600707818;
	bh=2aslu1ivz1KEDe+tgjaIkEZwIP4cmYNaWXIHYB/Mrvs=;
	h=Date:From:To:In-Reply-To:References:Subject:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=OA012fp8zqXqBIMZQJaDjJYUoelQguOwjmuZVnc0jo0fHw2YpPDaR1mWvbw2cvt65
	 6kfx41kUBwb610vsaOklMRj97Bw23v6xegi2AWOmH6rHekVVXZFEGVTrp9MycWfLjf
	 VgBhS1OplCcBov5B3HzVyzBPcQycZIl0GTWt0Odo=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 7906FF802FD;
	Mon, 21 Sep 2020 18:59:11 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 2EA6BF802FE; Mon, 21 Sep 2020 18:59:10 +0200 (CEST)
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 4484AF802E2
 for <alsa-devel@alsa-project.org>; Mon, 21 Sep 2020 18:59:02 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 4484AF802E2
Authentication-Results: alsa1.perex.cz;
 dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org
 header.b="Mdrq8lxr"
Received: from localhost (fw-tnat.cambridge.arm.com [217.140.96.140])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id 43BE22223E;
 Mon, 21 Sep 2020 16:59:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1600707540;
 bh=2aslu1ivz1KEDe+tgjaIkEZwIP4cmYNaWXIHYB/Mrvs=;
 h=Date:From:To:Cc:In-Reply-To:References:Subject:From;
 b=Mdrq8lxrcFaRKCbAdI1pJrMMTz13ehyh4nVZMmxjWt4U6fqycdz6vbLR+6kNpG+Rn
 dTPR7lbLWUlqzgGV/pYdbh1Z0wQuPpJZFbIRR3hUkYcZy31bVBaSQdToxYafAsyvzk
 nRXK0149eFO7ZwAr+k07G/1hp8j8EgI/RKnBaYds=
Date: Mon, 21 Sep 2020 17:58:08 +0100
From: Mark Brown <broonie@kernel.org>
To: Kai Vehmanen <kai.vehmanen@linux.intel.com>, alsa-devel@alsa-project.org
In-Reply-To: <20200921105038.2909899-1-kai.vehmanen@linux.intel.com>
References: <20200921105038.2909899-1-kai.vehmanen@linux.intel.com>
Subject: Re: [PATCH] ASoC: SOF: pm: Fix prepare callback behavior for OF
 usecase
Message-Id: <160070745847.56122.5442062495067528588.b4-ty@kernel.org>
Cc: ranjani.sridharan@linux.intel.com, daniel.baluta@nxp.com,
 pierre-louis.bossart@linux.intel.com, lgirdwood@gmail.com
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

On Mon, 21 Sep 2020 13:50:38 +0300, Kai Vehmanen wrote:
> On i.MX platforms PM is not managed via ACPI although CONFIG_ACPI
> can be set. So, in order to correctly set the system target state
> we introduce a flag for platforms that require to use acpi target
> states.

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/1] ASoC: SOF: pm: Fix prepare callback behavior for OF usecase
      commit: 43437d0417a36bc9174deedce4ecc2c516ffde57

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
