Return-Path: <SRS0=eqSS=OD=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.4 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9F368C433F5
	for <alsa-devel@archiver.kernel.org>; Mon, 13 Sep 2021 10:55:31 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D38C56103B
	for <alsa-devel@archiver.kernel.org>; Mon, 13 Sep 2021 10:55:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org D38C56103B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 6604A1607;
	Mon, 13 Sep 2021 12:54:39 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 6604A1607
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1631530529;
	bh=+LuT1nw1zwnEKWg8ze5we++x+gTI9O+Ydnbmy+cNIDk=;
	h=From:To:Subject:Date:In-Reply-To:References:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=EbZLzaEqkokGfDYdJhAb17IL7Cj0fn6fLD8EPfes1VYCJ7RuhNAk/32E3sbrqyyQ+
	 oWwdAlurXomVsTY5qKIZzptMp9miHgiE7I4xqSXQLwmR0rWso+dfeohR6OCX733qcl
	 M/kg89dOFwz55PbzbHCIfS2jgt2lQuaE7cmIT96k=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id D78F8F8027C;
	Mon, 13 Sep 2021 12:54:38 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 8D691F80132; Mon, 13 Sep 2021 12:54:37 +0200 (CEST)
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id F3632F80132
 for <alsa-devel@alsa-project.org>; Mon, 13 Sep 2021 12:54:34 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz F3632F80132
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org
 header.b="bNahRGyD"
Received: by mail.kernel.org (Postfix) with ESMTPSA id 0DD4760F12;
 Mon, 13 Sep 2021 10:54:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1631530471;
 bh=+LuT1nw1zwnEKWg8ze5we++x+gTI9O+Ydnbmy+cNIDk=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=bNahRGyD1ZY6zifYN/gxH5aVeOELABzlt4ajoCiJRWLAPK5COx9axY0N5rjUmWE4V
 0b/4W4ggOtOwniiAcBF/ust8zByALc111DVKiZGddaPPyWPeR4Dd3moLMYNgG0gkz1
 2PFhTwWsV6p3dm3V2NYsMuyhMBJlnAHZXnBU24U9z2pxiTbxxjiWSCj7wM2tly4fHD
 3kliVyMz1SFgcQEAVBQs9YXyfQyMGkUDTy18U8vW3gdTxNObaIQGKlfUa+rrrpLJyJ
 H+3Yi2bmfRHtKIHB2xAakl9JuBB8GrFz3G7s6zOHnayTAHdXZeqP+RUKckhfZ5aUYh
 +TY/+KiIqSFyQ==
From: Mark Brown <broonie@kernel.org>
To: perex@perex.cz, plai@codeaurora.org, linux-kernel@vger.kernel.org,
 srinivas.kandagatla@linaro.org, alsa-devel@alsa-project.org,
 bgoswami@codeaurora.org, bjorn.andersson@linaro.org,
 rohitkr@codeaurora.org, robh+dt@kernel.org, lgirdwood@gmail.com,
 devicetree@vger.kernel.org, agross@kernel.org, tiwai@suse.com,
 linux-arm-msm@vger.kernel.org, swboyd@chromium.org,
 Srinivasa Rao Mandadapu <srivasam@codeaurora.org>, judyhsiao@chromium.org
Subject: Re: [PATCH] ASoC: dt-bindings: lpass: add binding headers for digital
 codecs
Date: Mon, 13 Sep 2021 11:53:13 +0100
Message-Id: <163152996584.45703.6233667847951933638.b4-ty@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <1630934854-14086-1-git-send-email-srivasam@codeaurora.org>
References: <1630934854-14086-1-git-send-email-srivasam@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Cc: Mark Brown <broonie@kernel.org>
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

On Mon, 6 Sep 2021 18:57:34 +0530, Srinivasa Rao Mandadapu wrote:
> Add header defining for lpass internal digital codecs rx,tx and va
> dai node id's.
> 
> 

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/1] ASoC: dt-bindings: lpass: add binding headers for digital codecs
      commit: bfad37c53ae6168d03ab06868ea44e77995c43d5

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
