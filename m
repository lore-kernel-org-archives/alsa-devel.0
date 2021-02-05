Return-Path: <SRS0=mf2d=HH=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 795A2C433E0
	for <alsa-devel@archiver.kernel.org>; Fri,  5 Feb 2021 20:17:32 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C70C064FCE
	for <alsa-devel@archiver.kernel.org>; Fri,  5 Feb 2021 20:17:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C70C064FCE
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 3E7BD167A;
	Fri,  5 Feb 2021 21:16:40 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 3E7BD167A
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1612556250;
	bh=qgY/DVuIqSludWLeA3R0K2D/h0Yt+L6hRa2j/mG7ovM=;
	h=From:To:In-Reply-To:References:Subject:Date:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=KyxNnSZcRQx2lfQjA9k5ySuXaYVFk3SeXR6uBLsPur4ihVT9JqO9p4dkDNICVQjhw
	 eP8K3cTS4IdxB4H3tARbGoxlvhIRPcRf/gHAK0VlQ4qSWS9Hya+ZziZTVeUcqruI8h
	 MqcLTDScA6mtAWnC0RNch6dECt9YFVF0/vtkPVT0=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id BFBE9F8025C;
	Fri,  5 Feb 2021 21:15:53 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 32286F8025D; Fri,  5 Feb 2021 21:15:50 +0100 (CET)
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 31D59F80156
 for <alsa-devel@alsa-project.org>; Fri,  5 Feb 2021 21:15:47 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 31D59F80156
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org
 header.b="JHNd0zi9"
Received: by mail.kernel.org (Postfix) with ESMTPSA id B2D1264FBB;
 Fri,  5 Feb 2021 20:15:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1612556145;
 bh=qgY/DVuIqSludWLeA3R0K2D/h0Yt+L6hRa2j/mG7ovM=;
 h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
 b=JHNd0zi92Uv88DwkPWRe87CobScKHeKGVO7+dGg3kVNKeTOjx+YLRINqFRKnfog51
 lYN6iYzA/2/ivVyELn2U7gAnD+J51SQhvZcMPsgqLf/Jlo39BV1Xxp4rWZ0o5XakBT
 C2akIFP5EmLdIdf4QfoxT1iQriryfu6XT5d8/skqfheNX9JtNP480VLQMt6VcuQvhp
 E5lDJ896C0lLyljjqpsgo5cC0Fo2HNhAvtOZYU93ga9OrxxWmBbsDNEq2vCy/ZDVxU
 odY7UZOO1Git0+yg7qzvBw7u8tCrcXKF6JxQvs1Zg3gEo9x2bf/ptG6Nu3i1TxPQy4
 deKcZTojy26Zw==
From: Mark Brown <broonie@kernel.org>
To: Liam Girdwood <lgirdwood@gmail.com>,
 Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>,
 Geert Uytterhoeven <geert+renesas@glider.be>, Rob Herring <robh+dt@kernel.org>
In-Reply-To: <20210204130022.1646427-1-geert+renesas@glider.be>
References: <20210204130022.1646427-1-geert+renesas@glider.be>
Subject: Re: [PATCH] ASoC: dt-bindings: renesas,
 rsnd: Group tuples in playback/capture properties
Message-Id: <161255607745.56562.5489379179875398712.b4-ty@kernel.org>
Date: Fri, 05 Feb 2021 20:14:37 +0000
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Cc: linux-renesas-soc@vger.kernel.org, devicetree@vger.kernel.org,
 alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
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

On Thu, 4 Feb 2021 14:00:22 +0100, Geert Uytterhoeven wrote:
> To improve human readability and enable automatic validation, the tuples
> in "playback" and "capture" properties in sound device nodes should be
> grouped using angle brackets.

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/1] ASoC: dt-bindings: renesas, rsnd: Group tuples in playback/capture properties
      commit: f08c74a3b52d126d053c741b906ee1ca2a4f3568

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
