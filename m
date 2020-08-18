Return-Path: <SRS0=DJp9=B4=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4E93CC433E1
	for <alsa-devel@archiver.kernel.org>; Tue, 18 Aug 2020 16:58:51 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C2DEF207D3
	for <alsa-devel@archiver.kernel.org>; Tue, 18 Aug 2020 16:58:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="GerUJdHn";
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="dE/Aj3rN"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C2DEF207D3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 57489178A;
	Tue, 18 Aug 2020 18:57:59 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 57489178A
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1597769929;
	bh=6IjWju0cG/TFyI32CMnJxEjghzNZ8gdEUP+yjd7GWjw=;
	h=Date:From:To:In-Reply-To:References:Subject:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=GerUJdHn9nZiNZt98hvuMZGVckFABge4IMDakDIyReXwN2gh64jTASEUZranJo+2U
	 5QkW2ZpMclGttCnrCYOW+F8ZcQ9Vxqik0KRtSPcP/J8mZ/hjLGrJR9JSZHUXbV33P4
	 0WjYtD5T3W6r85MFfx/M8xEfHIyELOhMQeVYf+HE=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 5BA46F802F9;
	Tue, 18 Aug 2020 18:54:48 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 15133F802FB; Tue, 18 Aug 2020 18:54:45 +0200 (CEST)
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 4737CF802F7
 for <alsa-devel@alsa-project.org>; Tue, 18 Aug 2020 18:54:42 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 4737CF802F7
Authentication-Results: alsa1.perex.cz;
 dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org
 header.b="dE/Aj3rN"
Received: from localhost (fw-tnat.cambridge.arm.com [217.140.96.140])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id 4DD4E207DE;
 Tue, 18 Aug 2020 16:54:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1597769680;
 bh=6IjWju0cG/TFyI32CMnJxEjghzNZ8gdEUP+yjd7GWjw=;
 h=Date:From:To:Cc:In-Reply-To:References:Subject:From;
 b=dE/Aj3rNQfpPWtDt9bsbKDhDaacQfYNsR50BF/r59zwBDl4ti6z5EjYomGaCfAoM+
 D1JzBPTO5mx1sSkG5m1Cy5gAutNXkJLf+QsQr7WV/w9WVjqB+XezR1gKXisMt5sVxO
 5L8qyyK3KOEzkbA6N/bPOca0cucCkMd2kFT6lgoA=
Date: Tue, 18 Aug 2020 17:54:09 +0100
From: Mark Brown <broonie@kernel.org>
To: Randy Dunlap <rdunlap@infradead.org>, linux-kernel@vger.kernel.org
In-Reply-To: <20200808012209.10880-1-rdunlap@infradead.org>
References: <20200808012209.10880-1-rdunlap@infradead.org>
Subject: Re: [PATCH] ASoC: various vendors: delete repeated words in comments
Message-Id: <159776961931.56094.907020129915498135.b4-ty@kernel.org>
Cc: alsa-devel@alsa-project.org, Liam Girdwood <lgirdwood@gmail.com>
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

On Fri, 7 Aug 2020 18:22:09 -0700, Randy Dunlap wrote:
> Drop the repeated words {related, we, is, the} in comments.

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/1] ASoC: various vendors: delete repeated words in comments
      commit: 0d8aa2ccb2f21c79bc9d4dceab0c6f99ff20bae1

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
