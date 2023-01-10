Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 60F6CC46467
	for <alsa-devel@archiver.kernel.org>; Tue, 10 Jan 2023 16:54:55 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 88C6593AD;
	Tue, 10 Jan 2023 17:54:02 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 88C6593AD
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1673369692;
	bh=SollqPHgY5I7lTwviKqNUa8+yrbzo1QLNEo3j1yUsrE=;
	h=From:To:In-Reply-To:References:Subject:Date:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Cc:From;
	b=ST6V9SGaDl7sEJ0i7pDoZv49yrYUrsXV2g7QmmhtbON3JhX3C1LIEbV5q21NdwOMR
	 RCaSyO7HYO/tyNP6N43Dz75xktE+omLzLpIGLOvvO/1LCV17kF85cUnieHvlFXbTfz
	 x4XzWh82tydVMVvae7uM5F72hhhTA4kPR9//ZA44=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 2876CF8026A;
	Tue, 10 Jan 2023 17:54:02 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id E965EF804C1; Tue, 10 Jan 2023 17:54:00 +0100 (CET)
Received: from sin.source.kernel.org (sin.source.kernel.org [145.40.73.55])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id F0F8CF8019B;
 Tue, 10 Jan 2023 17:53:55 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz F0F8CF8019B
Authentication-Results: alsa1.perex.cz; dkim=pass (2048-bit key,
 unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20201202 header.b=Pcx4YAWa
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by sin.source.kernel.org (Postfix) with ESMTPS id 6C22ACE1876;
 Tue, 10 Jan 2023 16:53:51 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D0B11C433F1;
 Tue, 10 Jan 2023 16:53:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1673369629;
 bh=SollqPHgY5I7lTwviKqNUa8+yrbzo1QLNEo3j1yUsrE=;
 h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
 b=Pcx4YAWaJufTQxXy4GmIV8Y1noj4cbwA15h92+yCwAy6+iAD1g4NCRKi+Pc/MhOrA
 9fZmAqK66hDCjjocSouT92wlgPUXT2FnN45SDl130vtR53DfSKC1oQEkT0Lx7E1SL1
 ltLqOXveg2pUrYZePevnJZCfBbzXF9kpl0BYd47uoGh72YpWX86DYd0ZURIMAlMzGC
 V8yVDpk/rzieN+Y7QR7ojyEB6u6BY/t2e41t2iEnUI/PFt4CbIk+sm+jdpd1KO99+1
 TA1i1vL7vlBrlVJ3Bpm+HFBdpWcpCrAlBH+y7CN7NvNMBTM8gXCBdNIY7wXWVZeel0
 OazQiUHiDX+Dw==
From: Mark Brown <broonie@kernel.org>
To: Rob Herring <robh+dt@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 Matthias Brugger <matthias.bgg@gmail.com>,
 Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
 Liam Girdwood <lgirdwood@gmail.com>,
 Peter Ujfalusi <peter.ujfalusi@linux.intel.com>,
 Bard Liao <yung-chuan.liao@linux.intel.com>,
 Ranjani Sridharan <ranjani.sridharan@linux.intel.com>,
 Kai Vehmanen <kai.vehmanen@linux.intel.com>,
 Daniel Baluta <daniel.baluta@nxp.com>, Jaroslav Kysela <perex@perex.cz>,
 Takashi Iwai <tiwai@suse.com>, Chunxu Li <chunxu.li@mediatek.com>,
 Dan Carpenter <error27@gmail.com>, YC Hung <yc.hung@mediatek.com>,
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
 Allen-KH Cheng <Allen-KH.Cheng@mediatek.com>,
 Tinghan Shen <tinghan.shen@mediatek.com>
In-Reply-To: <20221222072150.10627-1-tinghan.shen@mediatek.com>
References: <20221222072150.10627-1-tinghan.shen@mediatek.com>
Subject: Re: [PATCH v1 0/3] Add support of MediaTek mt8188 to SOF
Message-Id: <167336962456.1940041.13852570954333682480.b4-ty@kernel.org>
Date: Tue, 10 Jan 2023 16:53:44 +0000
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.12-dev-8b3d1
X-BeenThere: alsa-devel@alsa-project.org
X-Mailman-Version: 2.1.29
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
Cc: devicetree@vger.kernel.org, alsa-devel@alsa-project.org,
 linux-kernel@vger.kernel.org,
 Project_Global_Chrome_Upstream_Group@mediatek.com,
 linux-mediatek@lists.infradead.org, linux-arm-kernel@lists.infradead.org,
 sound-open-firmware@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: "Alsa-devel" <alsa-devel-bounces@alsa-project.org>

On Thu, 22 Dec 2022 15:21:47 +0800, Tinghan Shen wrote:
> Add support of MediaTek mt8188 SoC DSP to SOF.
> The sof driver patches in this series are taken from
> thesofproject/linux/tree/topic/sof-dev-rebase.
> 
> Tinghan Shen (3):
>   dt-bindings: dsp: mediatek: Add mt8188 dsp compatible
>   ASoC: SOF: mediatek: Support mt8188 platform
>   ASoC: SOF: mediatek: Provide debugfs_add_region_item ops for core
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/3] dt-bindings: dsp: mediatek: Add mt8188 dsp compatible
      commit: e15ec6892832d586069ce575c222366b94ad6a5e
[2/3] ASoC: SOF: mediatek: Support mt8188 platform
      commit: 6b43538f0698695fba9aa0c0b29a80c555cf1b63
[3/3] ASoC: SOF: mediatek: Provide debugfs_add_region_item ops for core
      commit: 6fa8c0732bff8e0ab794736837b25dc7ac38cd54

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
