Return-Path: <SRS0=iyFA=JF=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6305BC43460
	for <alsa-devel@archiver.kernel.org>; Thu,  8 Apr 2021 16:57:24 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D45DE610CB
	for <alsa-devel@archiver.kernel.org>; Thu,  8 Apr 2021 16:57:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D45DE610CB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 645C0168C;
	Thu,  8 Apr 2021 18:56:32 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 645C0168C
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1617901042;
	bh=UsVHxXwhtxO6C1oI6waKzeTDm3pWIG9eRG5PEkfaJsg=;
	h=From:To:Subject:Date:In-Reply-To:References:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=k+1sgj5XPtk5pH1FMTYbVbMrikDXEKHASgcZMSR7/HKkMVDy3MnMLPr+kmzedQ1r/
	 364XGONwaHk/FJO/0qbgMUxKQCVDHjDCkRwT8a8c6tcMIQhAkveAz32hIojoKy5kjZ
	 CBgcD3m1sSCEsqxEZY6n4lFfRs/MLlxGgmQiAFD0=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id D57FEF80475;
	Thu,  8 Apr 2021 18:55:42 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 82999F80425; Thu,  8 Apr 2021 18:55:38 +0200 (CEST)
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 4FD86F80162
 for <alsa-devel@alsa-project.org>; Thu,  8 Apr 2021 18:55:35 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 4FD86F80162
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org
 header.b="t3UZCM7J"
Received: by mail.kernel.org (Postfix) with ESMTPSA id 3DB7C61056;
 Thu,  8 Apr 2021 16:55:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1617900933;
 bh=UsVHxXwhtxO6C1oI6waKzeTDm3pWIG9eRG5PEkfaJsg=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=t3UZCM7JrYN3ubeZfioQX7f2h42ORE7juF8FqgeklugDqA2ixmes5UKy8d/zUQeO8
 b0GEC9VpdDNtPe0FxTtgNgxbH4AUG08AHJ7Z9keciqiu37FZDgelNnAWHJPDRkKDVD
 QBXMdXxArt6HrXStGx2lTYgXWqsiwfVHrTB6NW3hMFBfDeGmIXSIhjKlVdj+yd+hVn
 e4JDq9aRF5SqPxaxEpChryykf6pnuSuYpbU2AqS+1/5inPFgzlZgYuy/BF4e6OgQU6
 wqYKLr3R0aKlr23m1J3Kckjwl2OuM4EUMbHs5P8AQBmSnpX3p7E3RCh9C+uDV+wpyV
 Z4GLCo2SqAdlw==
From: Mark Brown <broonie@kernel.org>
To: Dinghao Liu <dinghao.liu@zju.edu.cn>,
	kjlu@umn.edu
Subject: Re: [PATCH] [v2] ASoC: codecs: Fix runtime PM imbalance in
 tas2552_probe
Date: Thu,  8 Apr 2021 17:54:39 +0100
Message-Id: <161790012550.16915.9175549460514503586.b4-ty@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20210408064036.6691-1-dinghao.liu@zju.edu.cn>
References: <20210408064036.6691-1-dinghao.liu@zju.edu.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Cc: alsa-devel@alsa-project.org, "Gustavo A. R. Silva" <gustavoars@kernel.org>,
 Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>,
 Takashi Iwai <tiwai@suse.com>, linux-kernel@vger.kernel.org,
 Liam Girdwood <lgirdwood@gmail.com>, Peter Ujfalusi <peter.ujfalusi@ti.com>,
 Mark Brown <broonie@kernel.org>,
 "Alexander A. Klimov" <grandmaster@al2klimov.de>
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

On Thu, 8 Apr 2021 14:40:34 +0800, Dinghao Liu wrote:
> There is a rumtime PM imbalance between the error handling path
> after devm_snd_soc_register_component() and all other error
> handling paths. Add a PM runtime increment to balance refcount.

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/1] ASoC: codecs: Fix runtime PM imbalance in tas2552_probe
      commit: 7b3f5b207da5116add56c335c5fb92cee140dc63

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
