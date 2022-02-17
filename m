Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 13627C433F5
	for <alsa-devel@archiver.kernel.org>; Thu, 17 Feb 2022 16:24:16 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 3186418FA;
	Thu, 17 Feb 2022 17:23:24 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 3186418FA
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1645115054;
	bh=8kpe80mOxPS/SGjqkJ3vWoncz+N/bK9/xmYEGk5hQIQ=;
	h=From:To:In-Reply-To:References:Subject:Date:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=GRg7jf5MU4cXrXafnbZMOM7EDICbrs+7lpLDvVes3D7yJM9i+ICTsMO3ClFLMG786
	 DKfEfrrVFpTa5Ebi9va7fJQjktrb6Px7woZJ+1pLBUWv+1tWpfUzbXxem3y4X4g1SA
	 FTZYDqXSqKZM23O6D+pzzRuUUFQevWVzg32/Wi60=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 67768F804A9;
	Thu, 17 Feb 2022 17:22:48 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id AB1E6F80240; Thu, 17 Feb 2022 17:22:45 +0100 (CET)
Received: from dfw.source.kernel.org (dfw.source.kernel.org
 [IPv6:2604:1380:4641:c500::1])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id D9EA3F800C0
 for <alsa-devel@alsa-project.org>; Thu, 17 Feb 2022 17:22:41 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz D9EA3F800C0
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org
 header.b="nbavmWir"
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by dfw.source.kernel.org (Postfix) with ESMTPS id 8FD38612C8;
 Thu, 17 Feb 2022 16:22:38 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 81435C340EF;
 Thu, 17 Feb 2022 16:22:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1645114958;
 bh=8kpe80mOxPS/SGjqkJ3vWoncz+N/bK9/xmYEGk5hQIQ=;
 h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
 b=nbavmWir30Hsw16F9dwuLSYxFVSXmmYS3OHWARtluGyUPhPxvE/myxAv1DZ+HLoYB
 /LYrR2MNy3rQ8TnSoRIiWfjtaDMpBB+9HtD5jNQUhLfURIK0tVro7cS1OSLc9whwE+
 LTtzFPpptnYRhZo9irFVmCUrbZFBtwtsEfmYEGwVVosoDKZ+BAvV88hiDfQDIlddNL
 npSJ/JSIuFnuEDB1f5YLFf3TBu13EMD9obcDUrnwkLAO3lzs25mLJ4RSueJOiPVN5K
 HnwRhcwp9HDBRXhUBUg4DAndbkL2rcaWeo1EiViX6uMAlqtLyyfeU/48mx98IhO+/T
 tyqSZL/i0etWQ==
From: Mark Brown <broonie@kernel.org>
To: Kai Vehmanen <kai.vehmanen@linux.intel.com>, alsa-devel@alsa-project.org
In-Reply-To: <20220216133241.3990281-1-kai.vehmanen@linux.intel.com>
References: <20220216133241.3990281-1-kai.vehmanen@linux.intel.com>
Subject: Re: [PATCH v2] ASoC: SOF: core: unregister clients and machine
 drivers in .shutdown
Message-Id: <164511495622.1843697.17340279937128582992.b4-ty@kernel.org>
Date: Thu, 17 Feb 2022 16:22:36 +0000
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Cc: pierre-louis.bossart@linux.intel.com, yung-chuan.liao@linux.intel.com,
 peter.ujfalusi@linux.intel.com, ranjani.sridharan@linux.intel.com,
 lgirdwood@gmail.com, amadeuszx.slawinski@linux.intel.com,
 daniel.baluta@nxp.com
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

On Wed, 16 Feb 2022 15:32:41 +0200, Kai Vehmanen wrote:
> From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
> 
> On a platform shutdown, the expectation for most drivers is that
> userspace tasks will release all resources. When those sequences do
> not complete, it can be the case that PCM devices exposed by ALSA
> cards are used *after* the DSP shutdown completes, leading to a
> platform hang.
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/1] ASoC: SOF: core: unregister clients and machine drivers in .shutdown
      commit: 83bfc7e793b555291785136c3ae86abcdc046887

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
