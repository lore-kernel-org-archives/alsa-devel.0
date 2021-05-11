Return-Path: <SRS0=Cjbi=KG=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D8AFBC433B4
	for <alsa-devel@archiver.kernel.org>; Tue, 11 May 2021 08:34:05 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 473CE6134F
	for <alsa-devel@archiver.kernel.org>; Tue, 11 May 2021 08:34:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 473CE6134F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id AB9791798;
	Tue, 11 May 2021 10:33:13 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz AB9791798
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1620722043;
	bh=7C4N6xhr3iLJ06IpEWXsW6Mhbp8fwEkNVFfMBYJL4Hc=;
	h=From:To:Subject:Date:In-Reply-To:References:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=coKTIyNPeetMuAWa8iPbMgpK0ZIcTFn9vFARX2K/I7K0Xgy8xSkTJrxLE7JhheurQ
	 mO4rI87s9B7Cuxk9Lgn+YDbu6Y5b+sSeE6bbiY7W+tqDEO+TrD77QvUIaobnrLsMvy
	 U4xxJoJvFjNQ1e/dSqAk/hx3qdDknCAnMWrl8+9o=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 27F9BF80510;
	Tue, 11 May 2021 10:28:40 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id AA684F804D1; Tue, 11 May 2021 10:28:12 +0200 (CEST)
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 018B4F80163
 for <alsa-devel@alsa-project.org>; Tue, 11 May 2021 10:28:09 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 018B4F80163
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org
 header.b="ZMLazoSV"
Received: by mail.kernel.org (Postfix) with ESMTPSA id CD14061944;
 Tue, 11 May 2021 08:28:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1620721688;
 bh=7C4N6xhr3iLJ06IpEWXsW6Mhbp8fwEkNVFfMBYJL4Hc=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=ZMLazoSVLczu9/tZp9358cwQQx7is/gIgfqItfeNED0/l9vyz3WWiixEcRLyRyGF+
 T4dJGl3TC6MYR0nu5j4D/brT9QowFo6as1cswCpldxk3DsNAWPR2VmE05OgVwTKB9p
 X9CZmjiEEJF2GTSwGj5M+oGbi4ZTNc0O3Cri0SKGObbNPelFgH8ed6etG1vDHArN5u
 6OIwtvBnQl2zTW9b9vUDnRjiD98mTgG7mf/QuDFCqMUhApoRJgY9t5UPL4KCZWQX+V
 KnnIFZuSpqdjLZa0gnX6EVlDWrkE1yUoo+DQ3C2Y0cz7lgwLy2frgqj23OuDiuC8Af
 ozX8P82HpQMJg==
From: Mark Brown <broonie@kernel.org>
To: festevam@gmail.com, alsa-devel@alsa-project.org,
 Shengjiu Wang <shengjiu.wang@nxp.com>, perex@perex.cz,
 nicoleotsuka@gmail.com, timur@kernel.org, Xiubo.Lee@gmail.com,
 tiwai@suse.com
Subject: Re: [PATCH] ASoC: imx-pcm-rpmsg: Fix warning of incorrect type in
 assignment
Date: Tue, 11 May 2021 09:25:58 +0100
Message-Id: <162072058169.33157.6496454869060714703.b4-ty@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <1620268240-1005-1-git-send-email-shengjiu.wang@nxp.com>
References: <1620268240-1005-1-git-send-email-shengjiu.wang@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Cc: Mark Brown <broonie@kernel.org>, linuxppc-dev@lists.ozlabs.org,
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

On Thu, 6 May 2021 10:30:40 +0800, Shengjiu Wang wrote:
> The format in rpmsg is defained as unsigned char, there is warning
> when convert snd_pcm_format_t to it.
> 
> sound/soc/fsl/imx-pcm-rpmsg.c:164:43: sparse: warning: incorrect type in assignment (different base types)
> sound/soc/fsl/imx-pcm-rpmsg.c:164:43: sparse:    expected unsigned char format
> sound/soc/fsl/imx-pcm-rpmsg.c:164:43: sparse:    got restricted snd_pcm_format_t [usertype]
> sound/soc/fsl/imx-pcm-rpmsg.c:167:43: sparse: warning: incorrect type in assignment (different base types)
> sound/soc/fsl/imx-pcm-rpmsg.c:167:43: sparse:    expected unsigned char format
> sound/soc/fsl/imx-pcm-rpmsg.c:167:43: sparse:    got restricted snd_pcm_format_t [usertype]
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/1] ASoC: imx-pcm-rpmsg: Fix warning of incorrect type in assignment
      commit: a387040ab401cc114d0b1a7a86431c5ae34b163b

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
