Return-Path: <SRS0=gQoH=JR=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B5FE5C433B4
	for <alsa-devel@archiver.kernel.org>; Tue, 20 Apr 2021 15:08:11 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7BBF2613AE
	for <alsa-devel@archiver.kernel.org>; Tue, 20 Apr 2021 15:08:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7BBF2613AE
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 7C28A1679;
	Tue, 20 Apr 2021 17:07:18 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 7C28A1679
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1618931288;
	bh=v8rHhdjz6I4eIUVLIiWhkhXjju6Tc4XietzMcTV2gRs=;
	h=From:To:Subject:Date:In-Reply-To:References:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=NXwFSjoimiE1GQwXNhbxteGEmgoN6fZlTvmfaCa3TO0TpoIj/3grhadAA6ScI6du4
	 MvOQHXdT/kkOO//8AaAcEwHvZqp6DTbp0bSN2xS6GbRqunG4fX2Y633DQgySzPWnb4
	 uvA7ibQvRZCMtmkoDNZPxOTYHZ7IX97TjYGQmiZk=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id E6646F80168;
	Tue, 20 Apr 2021 17:07:17 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 7287CF80253; Tue, 20 Apr 2021 17:07:16 +0200 (CEST)
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 601C7F80164
 for <alsa-devel@alsa-project.org>; Tue, 20 Apr 2021 17:07:11 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 601C7F80164
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org
 header.b="GW0qDh0T"
Received: by mail.kernel.org (Postfix) with ESMTPSA id 31CC66135F;
 Tue, 20 Apr 2021 15:07:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1618931228;
 bh=v8rHhdjz6I4eIUVLIiWhkhXjju6Tc4XietzMcTV2gRs=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=GW0qDh0TyN92bK2KcO9D4vKFuOfL65TwUzAf038OF3TyziE8yEHZ8oam6Uz7/ELw0
 tYljxvKSypOVJ+7nR7ozj/UtYQQlZaDJXgQ+k95B9I7XUox8a/HcS2CrSVwLx8krjZ
 Vz0mGLZSTMoqWiR8gfj8NQPibDnBSx7+Ee8kkrLlrvBbPM4E4CdEVxVe4E4uMy2nyX
 CR96ySlD+mvr/hWqkiJwjPMYrWrJ+YR6dV5NwI4KgvDrLX6ZPFJdWmW0MGhBsAl46U
 1WobchzJ+n+PvHWUuhjSkSvFMO6qHpXVU91y3CeLdZSRE1+oisgUusyuqgqeQBiF84
 q3tXUbu0r7dxA==
From: Mark Brown <broonie@kernel.org>
To: Jack Yu <jack.yu@realtek.com>,
	lgirdwood@gmail.com
Subject: Re: [PATCH] ASoC: rt1015p: add support on format S32_LE
Date: Tue, 20 Apr 2021 16:06:38 +0100
Message-Id: <161893058718.55483.11995149328502337743.b4-ty@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <377f0ee05d514c66b567eb6385ac7753@realtek.com>
References: <377f0ee05d514c66b567eb6385ac7753@realtek.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Cc: Oder Chiou <oder_chiou@realtek.com>, alsa-devel@alsa-project.org,
 lars@metafoo.de,
 =?UTF-8?q?kent=5Fchen=20=40=20realtek=20=2E=20com=20=5B=E9=99=B3=E5=BB=BA=E5=AE=8F=5D?=
 <kent_chen@realtek.com>,
 =?UTF-8?q?=E9=99=B3=E6=98=B6=E5=BF=97?= <kenny_chen@realtek.com>,
 Mark Brown <broonie@kernel.org>,
 =?UTF-8?q?Derek=20=5B=E6=96=B9=E5=BE=B7=E7=BE=A9=5D?= <derek.fang@realtek.com>,
 =?UTF-8?q?Shuming=20=5B=E8=8C=83=E6=9B=B8=E9=8A=98=5D?= <shumingf@realtek.com>,
 "Flove\(HsinFu\)" <flove@realtek.com>
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

On Tue, 20 Apr 2021 09:30:48 +0000, Jack Yu wrote:
> Add support on format S32_LE for rt1015p.

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/1] ASoC: rt1015p: add support on format S32_LE
      commit: 7f51384f17b3e1039fbb2d3535cc777585dc3175

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
