Return-Path: <SRS0=xeto=OF=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2EB12C433EF
	for <alsa-devel@archiver.kernel.org>; Wed, 15 Sep 2021 15:25:36 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 85D5660F5B
	for <alsa-devel@archiver.kernel.org>; Wed, 15 Sep 2021 15:25:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 85D5660F5B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 0120C183E;
	Wed, 15 Sep 2021 17:24:44 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 0120C183E
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1631719534;
	bh=wfCrkPF9uiip+dMt9hQgVwVQGgywxVqYrYAQt4PemHc=;
	h=From:To:Subject:Date:In-Reply-To:References:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=C5iASKXK8HiXYkx5m5OoRif8acpuy3U6PLBPXbUZPUZE3erbWPMVVLVLm7ez+TRqb
	 Y3vpez6wHEJljuWpiUoDN1wfpcAdPmCIN0k+k4tDtwMUPZSiYQzPdIKPlsWyI0r9n0
	 txDLBKm80iAM64innA5AohaVRfXv8jfwyXq7JEU0=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id B866DF80507;
	Wed, 15 Sep 2021 17:22:57 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id A2458F80508; Wed, 15 Sep 2021 17:22:56 +0200 (CEST)
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 415C7F804E7
 for <alsa-devel@alsa-project.org>; Wed, 15 Sep 2021 17:22:50 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 415C7F804E7
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org
 header.b="uS+lULv9"
Received: by mail.kernel.org (Postfix) with ESMTPSA id D3738611C6;
 Wed, 15 Sep 2021 15:22:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1631719367;
 bh=wfCrkPF9uiip+dMt9hQgVwVQGgywxVqYrYAQt4PemHc=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=uS+lULv9jwBDnz23rHC++bq3uxzQPTAOTeaM7Hvgi2cgl/5P9k5vGozDCXPjHhLvF
 oIz+FfbTEOYlfUYzuXXYMDgcsAjpfUilNTPlG+MSHOoZZ+b1rtIbWFKOsVG1NNUd8Y
 gEOtXaFuEIIZf5MkKeo5BFSAHDFcrgIg5joODAAQrPlLrkFplB/4YysjMa2ZRHnhdM
 Fy1hIRyMsYXW0WH3sI9tLTVismpNYEDDU6+V45+XLoy3ebV9KsZwmjdcZS6kFzGgAF
 LXG3QnezUEE6r9R6YvVr20JIZNWznKObj2yiW7xQ9fYWz5Nz0a0AWTzdi2xNDSfe6e
 JiRsmbq6kp6NQ==
From: Mark Brown <broonie@kernel.org>
To: Takashi Iwai <tiwai@suse.com>, Matthias Brugger <matthias.bgg@gmail.com>,
 alsa-devel@alsa-project.org, Colin King <colin.king@canonical.com>,
 linux-mediatek@lists.infradead.org, Liam Girdwood <lgirdwood@gmail.com>,
 Jaroslav Kysela <perex@perex.cz>, linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH] ASoC: mediatek: mt8195: make array adda_dai_list static
 const
Date: Wed, 15 Sep 2021 16:21:47 +0100
Message-Id: <163171901943.9674.10990878164291138218.b4-ty@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20210915105027.10805-1-colin.king@canonical.com>
References: <20210915105027.10805-1-colin.king@canonical.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Cc: Mark Brown <broonie@kernel.org>, kernel-janitors@vger.kernel.org,
 linux-kernel@vger.kernel.org
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

On Wed, 15 Sep 2021 11:50:27 +0100, Colin King wrote:
> From: Colin Ian King <colin.king@canonical.com>
> 
> Don't populate the array adda_dai_list on the stack but instead it
> static const. Also makes the object code smaller by 33 bytes:
> 
> Before:
>    text	   data	    bss	    dec	    hex	filename
>   28271	  11640	      0	  39911	   9be7	mt8195/mt8195-dai-adda.o
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/1] ASoC: mediatek: mt8195: make array adda_dai_list static const
      commit: ce3f9357638720f4a78f6a6e481941c37f33bceb

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
