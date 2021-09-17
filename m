Return-Path: <SRS0=EuHN=OH=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 98E42C433EF
	for <alsa-devel@archiver.kernel.org>; Fri, 17 Sep 2021 14:07:36 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 92A3E60E08
	for <alsa-devel@archiver.kernel.org>; Fri, 17 Sep 2021 14:07:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 92A3E60E08
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 27E0C173B;
	Fri, 17 Sep 2021 16:06:44 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 27E0C173B
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1631887654;
	bh=/CK2dZYUQmLhnlMj58OJuZVVoVuymz/ma6hGeXhDqR8=;
	h=From:To:Subject:Date:In-Reply-To:References:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=K15ASS7FfTesnVZP09dkyBW8E+z8XvJZA6mly94mleQHynefDrAAbdXPQ6F11UgiA
	 d4GaoxYxyxwGQlJn8m7MZFGJzFbk1torbXUN5t+n3RKD3skJK0eEhjofx5wDVri4rs
	 5zK3lf00uJPu6ve0BiEBcKRPqQ+/tlPWjHJORBbQ=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 7F6E2F804F3;
	Fri, 17 Sep 2021 16:05:00 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 7DAF1F804E6; Fri, 17 Sep 2021 16:04:57 +0200 (CEST)
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id E7CAEF804E4
 for <alsa-devel@alsa-project.org>; Fri, 17 Sep 2021 16:04:52 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz E7CAEF804E4
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org
 header.b="icUKMmih"
Received: by mail.kernel.org (Postfix) with ESMTPSA id 2F1476103B;
 Fri, 17 Sep 2021 14:04:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1631887488;
 bh=/CK2dZYUQmLhnlMj58OJuZVVoVuymz/ma6hGeXhDqR8=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=icUKMmihE8Z1/HdSTUTU8kBVswwrrFd5T1vy8A/4uEqFh+CyEZJ6jSVI2TSKpW7Wm
 efBXoGZmGv53Q1BmY4koZAIX1qTNA5oXtWyUsROApsl6Xgqgr4aVaQ2tEnIpbsgRMg
 70FL0a9voEmro1tiHAqMuaI7XNQv3JU50+/u1uWbAEz2a24p+Xi2NrICYHXSaBbCiq
 oP6pviK9rbtm9j1Mk8uU5liHaUNRZ/KxoMnBrGK53+YcfN4+GhCy1j6eqVr2IG7k02
 tOVOxCQnD9TG5XgLvRkzFAjG+PRxnX69bivW3Upzoo7s5RbzY87qT1n3PGhKvA4Nb9
 R7bjDZZxCtZHQ==
From: Mark Brown <broonie@kernel.org>
To: lgirdwood@gmail.com, pierre-louis.bossart@linux.intel.com,
 Peter Ujfalusi <peter.ujfalusi@linux.intel.com>
Subject: Re: [PATCH 0/2] ASoC: SOF: ipc: Small cleanups for message handler
 functions
Date: Fri, 17 Sep 2021 15:03:48 +0100
Message-Id: <163188719815.50326.18041784066899820901.b4-ty@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20210917085823.27222-1-peter.ujfalusi@linux.intel.com>
References: <20210917085823.27222-1-peter.ujfalusi@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Cc: guennadi.liakhovetski@linux.intel.com, alsa-devel@alsa-project.org,
 kai.vehmanen@linux.intel.com, ranjani.sridharan@linux.intel.com,
 Mark Brown <broonie@kernel.org>, daniel.baluta@nxp.com, bard.liao@intel.com
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

On Fri, 17 Sep 2021 11:58:21 +0300, Peter Ujfalusi wrote:
> Rename the parameter for ipc_trace_message() to match it's content and use
> %#x" for hexadecimal prints in remaining places.
> 
> Regards,
> Peter
> 

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/2] ASoC: SOF: ipc: Clarify the parameter name for ipc_trace_message()
      commit: 59fdde1d4e268dbb9df5df77a7569c7d987607b6
[2/2] ASoC: SOF: ipc: Print 0x prefix for errors in ipc_trace/stream_message()
      commit: b95b64510ac964429a265508e2da4eeb4f8a57dc

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
