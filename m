Return-Path: <SRS0=+sGq=OL=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 90229C433EF
	for <alsa-devel@archiver.kernel.org>; Tue, 21 Sep 2021 15:26:59 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9BF5161186
	for <alsa-devel@archiver.kernel.org>; Tue, 21 Sep 2021 15:26:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 9BF5161186
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 05AB8827;
	Tue, 21 Sep 2021 17:26:07 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 05AB8827
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1632238017;
	bh=MMbO/dp99d6AGhgnvypPqLozrpUzaCRHRwEsnb7xVcg=;
	h=From:To:Subject:Date:In-Reply-To:References:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=FI2Lmum4izhVwDef9GlF4Yc45Tl2H35YxnAxOc4U4CcJaBJp3pDt7Iu4JMDBMacGQ
	 Z7fyh7zYycl358YnSI3qvAPB1LJrhhEVFeB6w1myMTNZMIWvbNmlLxEpT10CCy2YB6
	 eN8zw8R+VmTouD7Sy0R1uPGsfrkEMlfKKATc3ZuU=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 46779F80268;
	Tue, 21 Sep 2021 17:26:06 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id AA0C3F8026A; Tue, 21 Sep 2021 17:26:04 +0200 (CEST)
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id F07F1F8011F
 for <alsa-devel@alsa-project.org>; Tue, 21 Sep 2021 17:26:01 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz F07F1F8011F
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org
 header.b="Zj/glYkL"
Received: by mail.kernel.org (Postfix) with ESMTPSA id B4BC3611EF;
 Tue, 21 Sep 2021 15:25:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1632237959;
 bh=MMbO/dp99d6AGhgnvypPqLozrpUzaCRHRwEsnb7xVcg=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=Zj/glYkLeYHvNm4rJBXMrstUrYxzgtl5fQlmUpnsy/JVmXmyeYK/ARNQ9YmJBZ8wb
 vS5g+AFFbz75mhq4UwHC+/hwt0oiva/SEPuekzCsNIiEL+AL5nMzx25vuFjHTQFehC
 CmxwdOlXJSJTdqdq8LDAkvE6Ysa0DBqwjOgEhRjfWElrM00vdezmOre3oPCWrBV41C
 IYYduHHmDocdWnYUI7IsdsPDEj7bsbxoi2x9A5NJzcC+HWaPzJjhlHSqjlQ22yBwhc
 O7yKp+VN79dbtryyel+kEnR8p7S3qiSd+iy+r3EGXhI6/XwuSyW5hSa9xWV1rt90LF
 P0KGMrYaZhb8Q==
From: Mark Brown <broonie@kernel.org>
To: Shawn Guo <shawnguo@kernel.org>, Takashi Iwai <tiwai@suse.com>,
 Rikard Falkeborn <rikard.falkeborn@gmail.com>,
 Jaroslav Kysela <perex@perex.cz>, Xiubo Li <Xiubo.Lee@gmail.com>,
 Nicolin Chen <nicoleotsuka@gmail.com>,
 Sascha Hauer <s.hauer@pengutronix.de>
Subject: Re: [PATCH] ASoC: fsl: Constify static snd_soc_ops
Date: Tue, 21 Sep 2021 16:25:08 +0100
Message-Id: <163223651320.32236.13916304424900961086.b4-ty@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20210920193947.10237-1-rikard.falkeborn@gmail.com>
References: <20210920193947.10237-1-rikard.falkeborn@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Cc: alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
 Shengjiu Wang <shengjiu.wang@gmail.com>, linuxppc-dev@lists.ozlabs.org,
 Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>,
 NXP Linux Team <linux-imx@nxp.com>,
 Pengutronix Kernel Team <kernel@pengutronix.de>,
 Fabio Estevam <festevam@gmail.com>, linux-arm-kernel@lists.infradead.org
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

On Mon, 20 Sep 2021 21:39:47 +0200, Rikard Falkeborn wrote:
> These are only assigned to the ops field in the snd_soc_dai_link struct
> which is a pointer to const struct snd_soc_ops. Make them const to allow
> the compiler to put them in read-only memory.
> 
> 

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/1] ASoC: fsl: Constify static snd_soc_ops
      commit: 815b55e1101f074e737c084e996d086dcb454399

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
