Return-Path: <SRS0=rxKz=KH=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7F3BBC433B4
	for <alsa-devel@archiver.kernel.org>; Wed, 12 May 2021 17:08:13 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2C92461432
	for <alsa-devel@archiver.kernel.org>; Wed, 12 May 2021 17:08:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2C92461432
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 785AC18B4;
	Wed, 12 May 2021 19:07:20 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 785AC18B4
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1620839290;
	bh=f1yg6o4pZ0xVUqxZrXjEN0qCyFQVPLEpsutlFLmfaOQ=;
	h=From:To:Subject:Date:In-Reply-To:References:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=lvv3kWVdWcUY13DJ/IjFW1cg7Ac9L8jfmX63mrGKNVXyreOlJUFTchCmiccMWSTv7
	 a9wgd9n9lq1DWM/uPHvqb1zh1kliIAHT2NK6ErWxwOKhG6zp4TBQDNVKIOFMEoAknb
	 8HzRbNXQtkRvGy0PY7ZOyRvEJ3XsdoEiDUMpjVgs=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id C6FEFF80430;
	Wed, 12 May 2021 19:05:54 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 9E108F80272; Wed, 12 May 2021 19:05:51 +0200 (CEST)
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 060D0F8012E
 for <alsa-devel@alsa-project.org>; Wed, 12 May 2021 19:05:49 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 060D0F8012E
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org
 header.b="TNl+QueU"
Received: by mail.kernel.org (Postfix) with ESMTPSA id 99B7A613C2;
 Wed, 12 May 2021 17:05:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1620839147;
 bh=f1yg6o4pZ0xVUqxZrXjEN0qCyFQVPLEpsutlFLmfaOQ=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=TNl+QueUaoWsG4POknskWP3eS+1B8xPYARWurU8CvRQn6mvkiWTO8N8I+Va1Ciiyp
 m+LUeh/3U1ZEuG/Ms2Fzd7VrH/aWJfcb3dCFoPrdVoKfrJZ4/VgKiGnoARnDpInNGh
 0GH+1hhvrlpdUgZFlSzxAedEqJ8rGhDZDbrqtB8yrLMLfgngu1bKo8hFHsWtdDEir2
 IKb5rNfqza22cfXhUWBbXHaU6yp1/2sVTrjlJmosj/41DNflLJji86woiZ4WwfcMdM
 EBz34NTxa5uLeKvJ3tQo+KAxzY2WoNGfXyUdn5YPB2irLcbNfPgLoFCVPuJwOfskJ1
 qJWQRY2uT6rTQ==
From: Mark Brown <broonie@kernel.org>
To: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
 alsa-devel@alsa-project.org
Subject: Re: [PATCH 0/9] ASoC: SOF/Intel: fix and remove Sparse warnings
Date: Wed, 12 May 2021 18:04:44 +0100
Message-Id: <162083892846.44734.8695493417421886431.b4-ty@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20210511213707.32958-1-pierre-louis.bossart@linux.intel.com>
References: <20210511213707.32958-1-pierre-louis.bossart@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Cc: tiwai@suse.de, Mark Brown <broonie@kernel.org>
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

On Tue, 11 May 2021 16:36:58 -0500, Pierre-Louis Bossart wrote:
> We updated our SOF CI settings last week (see below) to use more options
> for Sparse, and sure enough it detected one nasty single-character bug
> in one of my previous patches, along with more trivial issues with
> string/integer sizes and signed/unsigned confusions.
> 
> export ARCH=x86_64
> export CF="-Wsparse-error -Wsparse-all -Wno-bitwise-pointer -Wno-pointer-arith -Wno-typesign -Wnoshadow"
> make -k sound/soc/sof/ C=2
> make -k sound/soc/intel/common/ C=2
> make -k sound/soc/intel/boards/ C=2
> make -k drivers/soundwire/ C=2
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/9] ASoC: SOF: Intel: hda: fix index used in inner loop
      commit: ad839121dd4cece991b995a4bbe83fdeac45ccd0
[3/9] ASoC: Intel: sof_cs42l42: shrink platform id below 20 characters
      commit: 48a7e6e5b2c90abf06c7c299f2ba94c7415bb8ea
[4/9] ASoC: Intel: bxt_da7219_max98357a: shrink platform_id below 20 characters
      commit: 24e46fb811e991f56d5694b10ae7ceb8d2b8c846

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
