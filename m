Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 70782C4332F
	for <alsa-devel@archiver.kernel.org>; Wed, 30 Nov 2022 12:49:09 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 61E5E16DE;
	Wed, 30 Nov 2022 13:48:17 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 61E5E16DE
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1669812547;
	bh=BLAKdb4dnsjbP0lYTaCvKJAcBM9q6yWu8b6MFiBT2UA=;
	h=From:To:In-Reply-To:References:Subject:Date:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=YG5C6zFbZzOekKQcloBLMW2D1DyvRJorKoALwQkFeS2+5o+Q4QIO7DLuoM/EzupPl
	 1nhlnmWgNL6Ori2+IAGbwfDSMXWDelGoB4aBNoGvB3NUGqt2VIShWNcRr660z+8Hqu
	 6IrXQ6c525dmMbbmWAWP8V/eSLOoPhqPuTY+PeDE=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 10071F8016B;
	Wed, 30 Nov 2022 13:48:03 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 9D70EF80507; Wed, 30 Nov 2022 13:47:57 +0100 (CET)
Received: from ams.source.kernel.org (ams.source.kernel.org
 [IPv6:2604:1380:4601:e00::1])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id EB95CF80118
 for <alsa-devel@alsa-project.org>; Wed, 30 Nov 2022 13:47:52 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz EB95CF80118
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org
 header.b="X+olPv4y"
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by ams.source.kernel.org (Postfix) with ESMTPS id 439EDB81B34;
 Wed, 30 Nov 2022 12:47:52 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7A058C433D6;
 Wed, 30 Nov 2022 12:47:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1669812471;
 bh=BLAKdb4dnsjbP0lYTaCvKJAcBM9q6yWu8b6MFiBT2UA=;
 h=From:To:In-Reply-To:References:Subject:Date:From;
 b=X+olPv4y6WYjDc7MSsAE/qe6J3xjPn0IorKeeom46CFZG8X8lcAvYai4f/4BmmIah
 VSUD31DnzKkt7oxcophN17qTSZI4Op/mtR6uDGPFWveZ836efRKrDxcP8GlHtUQ553
 Qmj7akMObBY2JOM1uCJlxDTkEncbDwHZ2svNtJC8n14J83VA16+cQ5DlJjn2igGOCs
 hSKfmycOsxMtFZyBVPA6oRYJIJXUBzHPtocFopaZce6U8FSb/bNu1sptU6hyjLm3Ki
 cpDibtSoamRw8XFSzVSyps1k6WhhL/1ldUKkusprUgV2pGvifGGfgiWboYtEvxKHuQ
 UH4mFxsezhlJA==
From: Mark Brown <broonie@kernel.org>
To: alsa-devel@alsa-project.org, Artem Lukyanov <dukzcry@ya.ru>
In-Reply-To: <20221130085247.85126-1-dukzcry@ya.ru>
References: <20221130085247.85126-1-dukzcry@ya.ru>
Subject: Re: [RESEND PATCH -next] ASoC: amd: yc: Add Xiaomi Redmi Book Pro 14
 2022 into DMI table
Message-Id: <166981247022.67172.14005315296527818647.b4-ty@kernel.org>
Date: Wed, 30 Nov 2022 12:47:50 +0000
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Mailer: b4 0.10.0-dev-fc921
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

On Wed, 30 Nov 2022 11:52:47 +0300, Artem Lukyanov wrote:
> This model requires an additional detection quirk to enable the
> internal microphone - BIOS doesn't seem to support AcpDmicConnected
> (nothing in acpidump output).
> 
> 

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/1] ASoC: amd: yc: Add Xiaomi Redmi Book Pro 14 2022 into DMI table
      commit: c1dd6bf6199752890d8c59d895dd45094da51d1f

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
