Return-Path: <SRS0=TLt2=KT=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8034FC04FF3
	for <alsa-devel@archiver.kernel.org>; Mon, 24 May 2021 12:02:23 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 717B161370
	for <alsa-devel@archiver.kernel.org>; Mon, 24 May 2021 12:02:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 717B161370
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 67B6A16B5;
	Mon, 24 May 2021 14:01:30 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 67B6A16B5
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1621857740;
	bh=deELojG0GVOR5hOrGRpvoLD+MzpRTxuHnqd7MioDR54=;
	h=From:To:Subject:Date:In-Reply-To:References:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=nDCsB8t8Er6hgkD8swyTfbYjhGcfRLVntKwhhWeZSrCfKQRPP3DNhtaNDAN+6WX79
	 4oZJ4n9oFJ1kNEKewRcL/4jza8nunKiqTFtEDbTY/RbD1CDiQNXSbexLN/bAsQU5uJ
	 hbS0ocvlqJLhJB98hjcsBPEiyIusgvLEiPMMTefo=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 66B99F80260;
	Mon, 24 May 2021 14:00:41 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id D1CF6F8022D; Mon, 24 May 2021 14:00:38 +0200 (CEST)
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 747B1F8021D
 for <alsa-devel@alsa-project.org>; Mon, 24 May 2021 14:00:36 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 747B1F8021D
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org
 header.b="HI3ZjinZ"
Received: by mail.kernel.org (Postfix) with ESMTPSA id 830856135D;
 Mon, 24 May 2021 12:00:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1621857635;
 bh=deELojG0GVOR5hOrGRpvoLD+MzpRTxuHnqd7MioDR54=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=HI3ZjinZnin5VKhEyzrUgr1pZ5MBv4W7Iu8XYLIxFefCJ6BYfD+0FYTCffBq81d+Z
 njfqY3/2k2FkceSSN8lhS6HeECtCtOgBBFyaAuc+3RcK5lspwmlSJ+Zto0ALr8HBKX
 4D648BFpTi2y/CO53plelwKFeTG76Q9AdA1ePGJ9/ZRhbly4PP11ZFhIcqRH6rIZLO
 IrnWzPbf/B2qVI3YmloX8DjSM2Vsd8lgxvpB07QsHaJPc8DhrSrDClHdA57hGFF7Hc
 jzhCmuoJjQkA5/UM8jKfMHn+dNlSpDkrwVrWgTEMhfhY0qBqq+94/1FnYvzZVSkTfu
 cljJwMnlmOCkw==
From: Mark Brown <broonie@kernel.org>
To: Kefeng Wang <wangkefeng.wang@huawei.com>, Takashi Iwai <tiwai@suse.com>,
 Jaroslav Kysela <perex@perex.cz>
Subject: Re: [PATCH] ASoC: core: Fix Null-point-dereference in
 fmt_single_name()
Date: Mon, 24 May 2021 12:59:58 +0100
Message-Id: <162185746497.49382.14192167282801063293.b4-ty@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20210524024941.159952-1-wangkefeng.wang@huawei.com>
References: <20210524024941.159952-1-wangkefeng.wang@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Cc: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
 Hulk Robot <hulkci@huawei.com>, alsa-devel@alsa-project.org,
 Mark Brown <broonie@kernel.org>, linux-kernel@vger.kernel.org
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

On Mon, 24 May 2021 10:49:41 +0800, Kefeng Wang wrote:
> Check the return value of devm_kstrdup() in case of
> Null-point-dereference.

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/1] ASoC: core: Fix Null-point-dereference in fmt_single_name()
      commit: 41daf6ba594d55f201c50280ebcd430590441da1

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
