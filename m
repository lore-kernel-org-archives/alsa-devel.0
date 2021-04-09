Return-Path: <SRS0=zNzy=JG=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 452A9C433B4
	for <alsa-devel@archiver.kernel.org>; Fri,  9 Apr 2021 16:28:12 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B873E6108B
	for <alsa-devel@archiver.kernel.org>; Fri,  9 Apr 2021 16:28:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B873E6108B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 2AFE5165E;
	Fri,  9 Apr 2021 18:27:20 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 2AFE5165E
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1617985690;
	bh=v3Zqc/3dsZP8D8F+VP4VtmHrJNK58dXKx2K3a3/TSzM=;
	h=From:To:Subject:Date:In-Reply-To:References:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=phY6qTDJWSUFnbbfnZIlbi0kJWlsydUICAAKMHEmo4vQSNxIRExm8v2MxH/kxj0gW
	 KJZz0xdpf0QoPwIi9b3jwiaRRGQ5oz+jHRBoO9ZeCJfHKH1M1UOw4UFYmOFNruPKl5
	 8wUeQ8eu+9f1o+pBTDQu0ZA4Bzb3sWP6djuJ9MWM=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 71DE6F804EB;
	Fri,  9 Apr 2021 18:24:18 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id C3F43F804E0; Fri,  9 Apr 2021 18:24:12 +0200 (CEST)
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 21F6EF804B2
 for <alsa-devel@alsa-project.org>; Fri,  9 Apr 2021 18:24:10 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 21F6EF804B2
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org
 header.b="oYueY1PD"
Received: by mail.kernel.org (Postfix) with ESMTPSA id D1F78610A8;
 Fri,  9 Apr 2021 16:24:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1617985448;
 bh=v3Zqc/3dsZP8D8F+VP4VtmHrJNK58dXKx2K3a3/TSzM=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=oYueY1PD40MhKLT5JZec4XfAUfEgLY5xLGXOKcbIjGVUnxuCaw1vJWIZwiQnXxDS8
 W4qI9U9lKrnBXgnHLRwfwz8ElzPwmNbF2P/X7GFQsOSQrwi/7m3IQcgud52hyMahpH
 jhPMgwLVIWa4OePL3raO5EUZwze9ZufeIkyL97RTi2DiDJ4qcG3HtBpb94Uzde2rX8
 E/aG8s/zbhqqGOIZ4nRnHjwBmxbuTeHsSzNQ0SK9WMlpfLUpksSVOM/Tg9sDvv/A+m
 REhH9jrfb5mvgfOxwaM8d9QEPznMi8q/UAOszOc6vqW9wi3mq33N/4kbTKRAawgql8
 c0Gn8JrilnhXw==
From: Mark Brown <broonie@kernel.org>
To: Jaroslav Kysela <perex@perex.cz>, Akshu Agrawal <akshu.agrawal@amd.com>,
 Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>,
 Ye Bin <yebin10@huawei.com>,
 Ravulapati Vishnu vardhan rao <Vishnuvardhanrao.Ravulapati@amd.com>,
 Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
 Liam Girdwood <lgirdwood@gmail.com>, Takashi Iwai <tiwai@suse.com>
Subject: Re: [PATCH -next] ASoC: amd: raven: acp3x-i2s: Constify static struct
 snd_soc_dai_ops
Date: Fri,  9 Apr 2021 17:22:57 +0100
Message-Id: <161798344183.47643.9676736315193814010.b4-ty@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20210408062651.803413-1-yebin10@huawei.com>
References: <20210408062651.803413-1-yebin10@huawei.com>
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

On Thu, 8 Apr 2021 14:26:51 +0800, Ye Bin wrote:
> The snd_soc_dai_ops structures is only stored in the ops field of a
> snd_soc_dai_driver structure, so make the snd_soc_dai_ops structure
> const to allow the compiler to put it in read-only memory.

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/1] ASoC: amd: raven: acp3x-i2s: Constify static struct snd_soc_dai_ops
      commit: 3e075e842899779bd321520a3524a278442467d0

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
