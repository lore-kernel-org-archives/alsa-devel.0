Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3D951C433F5
	for <alsa-devel@archiver.kernel.org>; Thu,  3 Mar 2022 13:34:15 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 4B73A18FB;
	Thu,  3 Mar 2022 14:33:23 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 4B73A18FB
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1646314453;
	bh=p2C7b5c/cUQV9McqiJLePU5w1eCpvl0FqwxxR66KW3c=;
	h=From:To:In-Reply-To:References:Subject:Date:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=s/5ywenDG1sP09vU5Q/787iRbvGy2R438CDlYzZvvYnUKCCw4bsbOVZG6m+OM8hTR
	 bx++Fg43dKCw5MtcoBUwP3DCyCBg374wu9utCaxVvmns3yz2xVyNxxyjZD/wjSgdzL
	 tt1UPtduXHFkmpc+V/3y8u/DRqDPgDlrSNs9QVhU=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id CB51AF8013D;
	Thu,  3 Mar 2022 14:33:22 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 1E85AF80152; Thu,  3 Mar 2022 14:33:20 +0100 (CET)
Received: from ams.source.kernel.org (ams.source.kernel.org
 [IPv6:2604:1380:4601:e00::1])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 5D0B6F8013D
 for <alsa-devel@alsa-project.org>; Thu,  3 Mar 2022 14:33:13 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 5D0B6F8013D
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org
 header.b="Hfiz7Szl"
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by ams.source.kernel.org (Postfix) with ESMTPS id 486FDB8254C;
 Thu,  3 Mar 2022 13:33:12 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6EAC9C004E1;
 Thu,  3 Mar 2022 13:33:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1646314391;
 bh=p2C7b5c/cUQV9McqiJLePU5w1eCpvl0FqwxxR66KW3c=;
 h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
 b=Hfiz7SzlXv23kTOu2VKGxKVgiYhP4fTT7098Cx4jimhp/UBzWjBSlsmpA4PwCP0BI
 ZDn+4+G8eE+Iiin/G+HGlKI6JW89ENHtP3szsQLgOSJpIUUy5K/pMmyikLSpu5n+uo
 FmBzmcY/4fnqIXvljAWbFHPO9duZuh4Eu92asbi6E0Ok1Q2k1rV1FNfj3DydPqGydM
 LzbDei8LBdviYQKbIAqDRRTnXwVO0YP7vKSG0beUdQgR9lz7BV30dEfxK9bfzRBjRR
 4BOUrXs9w/KhHeeD6RZ4xWEsRaFwbg8sAZhSs3AY+RxNozi4NlZ9Im31Fupzl18zwG
 Hb8uFwEI84NCg==
From: Mark Brown <broonie@kernel.org>
To: Jiaxin Yu <jiaxin.yu@mediatek.com>
In-Reply-To: <20220302013533.29068-1-jiaxin.yu@mediatek.com>
References: <20220302013533.29068-1-jiaxin.yu@mediatek.com>
Subject: Re: [v2] ASoC: bt-sco: fix bt-sco-pcm-wb dai widget don't connect to
 the endpoint
Message-Id: <164631438805.1870788.7887428309950116158.b4-ty@kernel.org>
Date: Thu, 03 Mar 2022 13:33:08 +0000
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Cc: devicetree@vger.kernel.org, alsa-devel@alsa-project.org,
 linux-kernel@vger.kernel.org,
 Project_Global_Chrome_Upstream_Group@mediatek.com, tzungbi@google.com,
 linux-mediatek@lists.infradead.org, trevor.wu@mediatek.com,
 matthias.bgg@gmail.com, linux-arm-kernel@lists.infradead.org
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

On Wed, 2 Mar 2022 09:35:33 +0800, Jiaxin Yu wrote:
> This patch fix the second dai driver's dai widget can't connect to the
> endpoint. Because "bt-sco-pcm" and "bt-sco-pcm-wb" dai driver have the
> same stream_name, so it will cause they have the same widget name.
> Therefor it will just create only one route when do snd_soc_dapm_add_route
> that only find the widget through the widget name.
> 
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/1] ASoC: bt-sco: fix bt-sco-pcm-wb dai widget don't connect to the endpoint
      commit: 8f2b025abc31bc15d38657d1286d7470bbbd5efa

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
