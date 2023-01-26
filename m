Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2CA59C52D11
	for <alsa-devel@archiver.kernel.org>; Thu, 26 Jan 2023 17:11:42 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id E1747E85;
	Thu, 26 Jan 2023 18:10:49 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz E1747E85
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1674753099;
	bh=94LxLH7gn/i6If/hYiugUAdFtrZzTMpOWAhYT85GbpY=;
	h=From:To:In-Reply-To:References:Subject:Date:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Cc:From;
	b=u12tDAxgK4gMyYV4JE1l7HmdhvyY7byc3pQ/FWSpoSt9AsWcz+FTuq7bsm2A+G/Rr
	 n9EFSHdQ+Q9PlGR8lqcIfFalLkJJh4b/JgbwwIf93TMz0SG2Ddkx1YUTU4shk0AvLU
	 duZrdBaVWSRuYoA7WCRRiP8OQNK/b+Z8u9NxwORE=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id C6DE2F80539;
	Thu, 26 Jan 2023 18:10:01 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 14934F803DC; Thu, 26 Jan 2023 18:10:00 +0100 (CET)
Received: from ams.source.kernel.org (ams.source.kernel.org
 [IPv6:2604:1380:4601:e00::1])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 77BD6F8016E
 for <alsa-devel@alsa-project.org>; Thu, 26 Jan 2023 18:09:54 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 77BD6F8016E
Authentication-Results: alsa1.perex.cz; dkim=pass (2048-bit key,
 unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20201202 header.b=pNivwEpo
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by ams.source.kernel.org (Postfix) with ESMTPS id B0E86B81E71;
 Thu, 26 Jan 2023 17:09:53 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C534EC4339B;
 Thu, 26 Jan 2023 17:09:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1674752992;
 bh=94LxLH7gn/i6If/hYiugUAdFtrZzTMpOWAhYT85GbpY=;
 h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
 b=pNivwEpoTadqieg/XUvOQgd5MK0CCEVZwTg7Cn4g8/VyShxLcb12+hqE/gKIrK6E2
 8j6CbGt+cU8jgXTKHAMyI6VH71jTHRCaczQAQYeo35ASSEBEY8EU4BBhOimgFKrIRg
 7D5U6DJ+Y4UBC3UrPRbQxq/2FEIjjXy6TIQGjYki6HZAsJbDv5R0fj/dZefyXHaL35
 Q+8FcsbJ2xDp/Gv0FhzmkCAcgalxKf1JuYMhispOvXLoKKYBQAAS0RANF28Vs4rmna
 afO719mScBUXxNwq364jznMvPDFUvSN3DvUPgYTLf48w5O4cQPdgbsppzaX9YXka3S
 fxX84Y+ZBJFnQ==
From: Mark Brown <broonie@kernel.org>
To: lgirdwood@gmail.com, Peter Ujfalusi <peter.ujfalusi@linux.intel.com>
In-Reply-To: <20230125141317.30302-1-peter.ujfalusi@linux.intel.com>
References: <20230125141317.30302-1-peter.ujfalusi@linux.intel.com>
Subject: Re: [PATCH v2] ASoC: SOF: ipc4-topology: use different channel
 mask for each sdw amp feedback
Message-Id: <167475299048.4003145.22787922384757053.b4-ty@kernel.org>
Date: Thu, 26 Jan 2023 17:09:50 +0000
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.12.0
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
Cc: alsa-devel@alsa-project.org, yung-chuan.liao@linux.intel.com,
 pierre-louis.bossart@linux.intel.com, kai.vehmanen@linux.intel.com,
 ranjani.sridharan@linux.intel.com
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: "Alsa-devel" <alsa-devel-bounces@alsa-project.org>

On Wed, 25 Jan 2023 16:13:17 +0200, Peter Ujfalusi wrote:
> Currently, we use the same channel mask for aggregated speakers.
> It works fine for playback because we duplicate the audio data for all
> aggregated speakers. But we need to get audio data from each aggregated
> speaker and combine them to the captured audio. So we need to set
> non-overlapping channel mask for aggregated ALH DAIs.
> 
> 
> [...]

Applied to

   broonie/sound.git for-next

Thanks!

[1/1] ASoC: SOF: ipc4-topology: use different channel mask for each sdw amp feedback
      commit: 0390a102cc18cb7456d6c1f15ac51f1af90fcf9c

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

