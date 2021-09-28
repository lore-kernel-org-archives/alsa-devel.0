Return-Path: <SRS0=duqq=OS=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2DF53C433F5
	for <alsa-devel@archiver.kernel.org>; Tue, 28 Sep 2021 16:25:53 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5632A60462
	for <alsa-devel@archiver.kernel.org>; Tue, 28 Sep 2021 16:25:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 5632A60462
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id EB8D916AB;
	Tue, 28 Sep 2021 18:25:00 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz EB8D916AB
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1632846351;
	bh=6hWvGOle/2+2TeWx4tUsgFaZzillo5KnbpUn3z0yFYY=;
	h=From:To:Subject:Date:In-Reply-To:References:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=Jsk2/UZEpEUxs9fOA673J9kwrsFd6fu4z432bcOXlVqJq+Zfym6JhnUcPj493jMUn
	 YVn6j7z7uHWYU/OjAQr8t2R0zQAJLAv0GGPVq2h+9BErIUAi3fT5rV3WPE0qLovVMH
	 3mNja71o97aTa2KcxaTD89tMg9/fn9lO7qN+8OSk=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 92B7BF804D1;
	Tue, 28 Sep 2021 18:24:14 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id C3635F804E1; Tue, 28 Sep 2021 18:24:11 +0200 (CEST)
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id A048FF80105
 for <alsa-devel@alsa-project.org>; Tue, 28 Sep 2021 18:24:05 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz A048FF80105
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org
 header.b="B56Zf1jh"
Received: by mail.kernel.org (Postfix) with ESMTPSA id 3BE806124B;
 Tue, 28 Sep 2021 16:24:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1632846242;
 bh=6hWvGOle/2+2TeWx4tUsgFaZzillo5KnbpUn3z0yFYY=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=B56Zf1jhEFvFvSDz5m6Vl61aXSIeW2mYD89pk41doku4fpWabTkbEONa7+tayZAGr
 IBv3+J5BUl+3srxqXWgbIThh3hPm+/GP7AvYreXw/2K9bBsvTYxMXK+aeGMY3Z261n
 dCi5rdEyKyKc2bZ9qyMwplmIcnhMb3ndy3cQFgowoB+rZYBqKIacWqSjvAYx89LQ8P
 Ivn9TGzkCgwDurmnGlp3XyT+M7K1F9yNpkWJKLg1xf/DC0LX43/0n0QpAA1I0qjiu5
 yjEEDh69BRMjq0cSuoBjwfyzJdfwpg5Q++LsRUlYTkFIRluI6TFZNrnUw/ZAyjbqfB
 1nMCBLiJHomTQ==
From: Mark Brown <broonie@kernel.org>
To: pierre-louis.bossart@linux.intel.com, ranjani.sridharan@linux.intel.com,
 lgirdwood@gmail.com, Peter Ujfalusi <peter.ujfalusi@linux.intel.com>
Subject: Re: [PATCH] ASoC: SOF: pm: fix a stale comment
Date: Tue, 28 Sep 2021 17:23:01 +0100
Message-Id: <163284573551.17390.205358041085476333.b4-ty@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20210928074030.30553-1-peter.ujfalusi@linux.intel.com>
References: <20210928074030.30553-1-peter.ujfalusi@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Cc: alsa-devel@alsa-project.org, kai.vehmanen@linux.intel.com,
 Mark Brown <broonie@kernel.org>, paul.olaru@oss.nxp.com, daniel.baluta@nxp.com,
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

On Tue, 28 Sep 2021 10:40:30 +0300, Peter Ujfalusi wrote:
> From: Ranjani Sridharan <ranjani.sridharan@linux.intel.com>
> 
> There is no restore_stream flag anymmore.
> 
> 

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/1] ASoC: SOF: pm: fix a stale comment
      commit: a1ce6e43e2accf30e780a9a339218b4958857377

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
