Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C575DC433FE
	for <alsa-devel@archiver.kernel.org>; Tue,  5 Apr 2022 09:32:58 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id B88BF17CC;
	Tue,  5 Apr 2022 11:32:03 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz B88BF17CC
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1649151173;
	bh=YypSHEp1rOHcihtmVFUWRUSVBqn1rhBtj2pQDDhyoOI=;
	h=From:To:In-Reply-To:References:Subject:Date:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=rPwrn9qYQtJ6ksMvlqEW6gnjWGejHlHEcu2vfyYom8SeEPJ4VzKH1STRCdG1/LVT6
	 nlru++Rh754kbYSFIsADeWcpKjLRKQP+OLdFYT9vezvC5Tgzs+oKlqhbZ7mSOT4q09
	 zvIZvXG32SxaIDLC15Ldvxb6fyNLp0uJEHK+mD3M=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 5CF43F80519;
	Tue,  5 Apr 2022 11:31:13 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 99401F8016A; Tue,  5 Apr 2022 11:31:10 +0200 (CEST)
Received: from ams.source.kernel.org (ams.source.kernel.org
 [IPv6:2604:1380:4601:e00::1])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 2DC1DF8014B
 for <alsa-devel@alsa-project.org>; Tue,  5 Apr 2022 11:31:07 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 2DC1DF8014B
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org
 header.b="OQgUIMa2"
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by ams.source.kernel.org (Postfix) with ESMTPS id 619ACB81C6E;
 Tue,  5 Apr 2022 09:31:07 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 81404C385A2;
 Tue,  5 Apr 2022 09:31:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1649151066;
 bh=YypSHEp1rOHcihtmVFUWRUSVBqn1rhBtj2pQDDhyoOI=;
 h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
 b=OQgUIMa2+Jl5ZN/tEN/rPzkKmhEaurR5d+v0K2yZR31kmlkdJkgvJ1UiBhBzt5RSM
 ydqLwdVnexufAh7HFSeU/S0f2WHs6PYKrJOB1GpykjS42ntFc3btzZzVpLYEU8V481
 5xnHiBquaMN7puc//Amlvcf2iRbUseZUCom+xKF66Nm87x/vy11Phosp0dENqtVdkG
 WkgGsQd1vJpfhYNB0H0g8IcYzxPeMSwSGV1XxmNF3AtxqaHR9nCMjA6iQ+TduCEobD
 z/Dt03CLIwASXP+0esQU+i1N9gdzwE5cTKsr/P7p7sOhaxmLVUNB7FtbmJC7ECnRTw
 yeHets5eAbOyw==
From: Mark Brown <broonie@kernel.org>
To: tiwai@suse.com, trevor.wu@mediatek.com, robh+dt@kernel.org,
 matthias.bgg@gmail.com
In-Reply-To: <20220324053851.27350-1-trevor.wu@mediatek.com>
References: <20220324053851.27350-1-trevor.wu@mediatek.com>
Subject: Re: [PATCH v4 0/6] ASoC: mediatek: Add support for MT8195 sound card
 with max98390 and rt5682
Message-Id: <164915106325.276574.14625118005435337786.b4-ty@kernel.org>
Date: Tue, 05 Apr 2022 10:31:03 +0100
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Cc: devicetree@vger.kernel.org, alsa-devel@alsa-project.org,
 linux-kernel@vger.kernel.org, tzungbi@google.com, miles.chen@mediatek.com,
 linux-mediatek@lists.infradead.org, yc.hung@mediatek.com, aaronyu@google.com,
 linux-arm-kernel@lists.infradead.org, angelogioacchino.delregno@collabora.com
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

On Thu, 24 Mar 2022 13:38:45 +0800, Trevor Wu wrote:
> This series of patches adds support for mt8195 board with mt6359, max98390
> and rt5682.
> 
> To prevent from copy-paste components, mt8195 machine drivers and
> dt-bindings are merged in the patch.
> 
> Patches are based on broonie tree "for-next" branch.
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/6] ASoC: mediatek: mt8195: revise mt8195-mt6359-rt1019-rt5682.c
      commit: 4dbc714fe07641e7a07731f82152448ef09f3002
[2/6] ASoC: mediatek: mt8195: merge machine driver
      commit: 094e30efa444a118a535cb67ec000bbee9f8d150
[3/6] ASoC: dt-bindings: mediatek: mt8195: merge mt8195 machine yaml
      commit: dc16399078aea4c98f17aa99f0cdea9d5ac9c4a9
[4/6] ASoC: mediatek: mt8195: rename card controls
      commit: 3a0323c26c6720447fd5eff6495c1aea514b77d5
[5/6] ASoC: mediatek: mt8195: add machine support for max98390 and rt5682
      commit: 86a6b9c9dffff1bd653d582cfc5138da75e5f7b0
[6/6] ASoC: dt-bindings: mediatek: mt8195: support mt8195-mt6359-max98390-rt5682
      commit: cae34da5323b6ce4d0dc365d1b971f838dcff318

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
