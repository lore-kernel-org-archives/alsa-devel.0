Return-Path: <SRS0=7Yh/=DV=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5C973C433DF
	for <alsa-devel@archiver.kernel.org>; Wed, 14 Oct 2020 19:32:23 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9C72722246
	for <alsa-devel@archiver.kernel.org>; Wed, 14 Oct 2020 19:32:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="qZTXEmQI";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="xDg3VOac"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9C72722246
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id A60511733;
	Wed, 14 Oct 2020 21:31:28 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz A60511733
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1602703938;
	bh=SfS3RFzptwmHuBnDOPZHLIF2wX0UY/GsugjsIH7VjZc=;
	h=Date:From:To:In-Reply-To:References:Subject:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=qZTXEmQImNiFAsSSRtg8+A40bdUcAAVkoKjJ0H9H1fLYRQU2sA0QIF4AdiWBanfAd
	 XJ9McukN5wlShpfxJHUPLZ3I1uOAgNRLwzJjX+gJpHP6HQnXVBmmvBOyImIYZ+5XCu
	 nei5XBfDgfSgvVMMSMi+LoODtgB0EdtgvIb5cyFE=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 2F178F8020D;
	Wed, 14 Oct 2020 21:31:28 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 96DE5F80217; Wed, 14 Oct 2020 21:31:26 +0200 (CEST)
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 86AE3F80118
 for <alsa-devel@alsa-project.org>; Wed, 14 Oct 2020 21:31:22 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 86AE3F80118
Authentication-Results: alsa1.perex.cz;
 dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org
 header.b="xDg3VOac"
Received: from localhost (fw-tnat.cambridge.arm.com [217.140.96.140])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id 4A0BB2222C;
 Wed, 14 Oct 2020 19:31:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1602703879;
 bh=SfS3RFzptwmHuBnDOPZHLIF2wX0UY/GsugjsIH7VjZc=;
 h=Date:From:To:Cc:In-Reply-To:References:Subject:From;
 b=xDg3VOacp5wUSR/prKODk6X6L4RLWURqfZw56nT9mlv3Q7r9tQU/FlFqgWQkudOmr
 NNd3o9CEf1NdPIGsJJYyjOLQSxqf2gIYG9D0yLBiq5Tq5GRgUUwfkCXPXLib3/hxNH
 r9O+krm0BBDI6r793smd9hQH3OjX3Vs8d7qXZF44=
Date: Wed, 14 Oct 2020 20:31:13 +0100
From: Mark Brown <broonie@kernel.org>
To: alsa-devel@alsa-project.org, Cezary Rojewski <cezary.rojewski@intel.com>
In-Reply-To: <20201012103221.30759-1-cezary.rojewski@intel.com>
References: <20201012103221.30759-1-cezary.rojewski@intel.com>
Subject: Re: [PATCH 1/2] ASoC: Intel: catpt: Wake up device before configuring
 SSP port
Message-Id: <160270387383.42239.7999753085969402667.b4-ty@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Cc: tiwai@suse.com, pierre-louis.bossart@linux.intel.com, lgirdwood@gmail.com,
 hdegoede@redhat.com, vkoul@kernel.org, andriy.shevchenko@linux.intel.com
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

On Mon, 12 Oct 2020 12:32:20 +0200, Cezary Rojewski wrote:
> catpt_dai_pcm_new() invoked during new PCM runtime creation configures
> SSP by sending IPC to DSP firmware. For that to succeed device needs to
> be up and running. While components default probing behavior -
> snd_soc_catpt causing machine board module to load just after it - needs
> no changes, machine board's module may be unloaded and re-loaded at a
> different time e.g.: when catpt is already asleep.
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/2] ASoC: Intel: catpt: Wake up device before configuring SSP port
      commit: 1d159edf19542793851a04202e5b0dd548a9415c
[2/2] ASoC: Intel: catpt: Relax clock selection conditions
      commit: 3d53c6df4299134525ad9e197f480e89bc8b06af

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
