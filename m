Return-Path: <SRS0=iyFA=JF=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 68EBEC433B4
	for <alsa-devel@archiver.kernel.org>; Thu,  8 Apr 2021 16:58:08 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DB681610CC
	for <alsa-devel@archiver.kernel.org>; Thu,  8 Apr 2021 16:58:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DB681610CC
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 1B9811683;
	Thu,  8 Apr 2021 18:57:16 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 1B9811683
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1617901086;
	bh=bADBejaDDFUvPit3yESreAk5CCNK7QnwI7lBb+jFjuo=;
	h=From:To:Subject:Date:In-Reply-To:References:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=XxD+2dKsOXuRuwrube2wb5J6w79TvsC6iXZ4y1nj2uKWQL3DhX61JbSs5eFqGbljA
	 xX4GIKE6Ur8e4j18GiYivSRxa60/AaxOwlgkT4j5j+VMXo6iGPdFb3wLTzJ9WsGWuW
	 mcqwvHliwnV4tklsGzc51zh22fgPOEIip78y6k8c=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 0430EF804AD;
	Thu,  8 Apr 2021 18:55:54 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id B7ABEF804AB; Thu,  8 Apr 2021 18:55:43 +0200 (CEST)
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id D7ED0F80431
 for <alsa-devel@alsa-project.org>; Thu,  8 Apr 2021 18:55:40 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz D7ED0F80431
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org
 header.b="V3PoMP8P"
Received: by mail.kernel.org (Postfix) with ESMTPSA id DED42610A2;
 Thu,  8 Apr 2021 16:55:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1617900939;
 bh=bADBejaDDFUvPit3yESreAk5CCNK7QnwI7lBb+jFjuo=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=V3PoMP8PWrYTANRipi8JY/moMuFySOsdM6qc0jJ40mGGWWL3w5S51fbPA9wWjEi2Z
 X/zD/laG2yXM3sy0IoPjtcy5ODU5UC73huouPRC3swZGw0skdiQ0raPkrESrmXhIgX
 m4dgbfa+EWmSm+UaXdszeMoHJEvwoCxKTcGibgJ0Lu72kGXVobcPX36v3K0Xzm+Bi6
 HlvqCSkia0jzef0oX2up6l0rvIX9iCD9QbDmEBGjkwCkWykmG4OngatgN9lpEYOn14
 oDdPh3suF7DtROY15rxmFznBTIZKd9sCaG6hSON8oyktgiQ1P1bYLEIkJmBvDSAREt
 V3hE7q7fMOPvA==
From: Mark Brown <broonie@kernel.org>
To: Dan Murphy <dmurphy@ti.com>,
 Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
 Ye Bin <yebin10@huawei.com>, Peter Ujfalusi <peter.ujfalusi@ti.com>,
 Liam Girdwood <lgirdwood@gmail.com>,
 "Alexander A. Klimov" <grandmaster@al2klimov.de>,
 Jaroslav Kysela <perex@perex.cz>,
 Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>,
 Takashi Iwai <tiwai@suse.com>
Subject: Re: [PATCH -next] ASoC: tas2770: Constify static struct
 snd_soc_dai_ops
Date: Thu,  8 Apr 2021 17:54:41 +0100
Message-Id: <161790012551.16915.15616439731032639355.b4-ty@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20210408062646.803053-1-yebin10@huawei.com>
References: <20210408062646.803053-1-yebin10@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Cc: Hulk Robot <hulkci@huawei.com>, alsa-devel@alsa-project.org,
 Mark Brown <broonie@kernel.org>, kernel-janitors@vger.kernel.org,
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

On Thu, 8 Apr 2021 14:26:46 +0800, Ye Bin wrote:
> The snd_soc_dai_ops structures is only stored in the ops field of a
> snd_soc_dai_driver structure, so make the snd_soc_dai_ops structure
> const to allow the compiler to put it in read-only memory.

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/1] ASoC: tas2770: Constify static struct snd_soc_dai_ops
      commit: f2ec1ebb257155fb534cad390575d696dfd567fb

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
