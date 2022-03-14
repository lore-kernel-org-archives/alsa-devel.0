Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 69406C433EF
	for <alsa-devel@archiver.kernel.org>; Mon, 14 Mar 2022 08:55:24 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id CEE1617CF;
	Mon, 14 Mar 2022 09:54:31 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz CEE1617CF
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1647248121;
	bh=p4ElLYQEUziQquOXGjlyVsfodhAUjuWMOWPfRqiA1CQ=;
	h=From:To:In-Reply-To:References:Subject:Date:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=qEO6ap0boK67difhBmkcPT0IqiRhgJmDTUGOrwGU7t4Wj051Un+GLALvuKPaZ0b3c
	 wurwS8EtJZFhG1Je0tXrEWikHfFxI5BtE6vZuEm9fyIB9ifFejI/ezZpgTPPgmVGAQ
	 B3IZ4/+cGSPD4/nAolo6en7rukMB3XO/SSyQwua4=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 44487F80139;
	Mon, 14 Mar 2022 09:54:31 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id E2F70F80139; Mon, 14 Mar 2022 09:54:29 +0100 (CET)
Received: from sin.source.kernel.org (sin.source.kernel.org
 [IPv6:2604:1380:40e1:4800::1])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 66070F8011C
 for <alsa-devel@alsa-project.org>; Mon, 14 Mar 2022 09:54:27 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 66070F8011C
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org
 header.b="ClgaSrxx"
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by sin.source.kernel.org (Postfix) with ESMTPS id E7403CE108C;
 Mon, 14 Mar 2022 08:54:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 55FC8C340E9;
 Mon, 14 Mar 2022 08:54:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1647248062;
 bh=p4ElLYQEUziQquOXGjlyVsfodhAUjuWMOWPfRqiA1CQ=;
 h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
 b=ClgaSrxx+YK8DEi3hv7eB7Q+IoSshccFeUtdX8T5E6uFsQpYY+Mm8cVEPPRapks/L
 IkLFlZBfuDEyoN6cE70GklFm24i3tIPac8h5UjBPeV1V1d3CsjdbaPdl/a6nXV3hha
 f+RYjYBwZ+YUmW+V8usHP6corE2R9hEJipc6rjNI2YT+vSYqcmffAzGwWeZJ644MfR
 3q49nU6yqtfAP/XyhGhYrRiRrMUy5DZNMM4xCspBvQG6KBCQtUtg2KNcWe0KhMb2zL
 iiVhPfD40byS0Xf9yK4sV2SqRB1dT+CDMJY5jhDZHJo36kld1DYgQXrwTPZA2xEsXL
 ZK5vSmvdltg2Q==
From: Mark Brown <broonie@kernel.org>
To: vkoul@kernel.org, Jiasheng Jiang <jiasheng@iscas.ac.cn>, perex@perex.cz,
 lgirdwood@gmail.com, dan.carpenter@oracle.com, tiwai@suse.com
In-Reply-To: <20220310030041.1556323-1-jiasheng@iscas.ac.cn>
References: <20220310030041.1556323-1-jiasheng@iscas.ac.cn>
Subject: Re: [PATCH] ASoC: soc-compress: Change the check for codec_dai
Message-Id: <164724806003.972788.200710356447512162.b4-ty@kernel.org>
Date: Mon, 14 Mar 2022 08:54:20 +0000
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Cc: alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
 kernel test robot <lkp@intel.com>
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

On Thu, 10 Mar 2022 11:00:41 +0800, Jiasheng Jiang wrote:
> It should be better to reverse the check on codec_dai
> and returned early in order to be easier to understand.
> 
> 

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/1] ASoC: soc-compress: Change the check for codec_dai
      commit: ccb4214f7f2a8b75acf493f31128e464ee1a3536

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
