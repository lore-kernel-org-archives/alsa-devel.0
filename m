Return-Path: <SRS0=iyFA=JF=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 859EAC433ED
	for <alsa-devel@archiver.kernel.org>; Thu,  8 Apr 2021 16:59:42 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0571A60FDB
	for <alsa-devel@archiver.kernel.org>; Thu,  8 Apr 2021 16:59:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0571A60FDB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 94C891658;
	Thu,  8 Apr 2021 18:58:50 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 94C891658
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1617901180;
	bh=ZJb6iLVqWt5B42gyms7TM+jaafU+bwfrgC8V3lIAN+0=;
	h=From:To:Subject:Date:In-Reply-To:References:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=UFpoCKj4qXbbGm9N8UKBIvom98hLWPebqqsfglypgitCEO1UV0lAtoH61JZajNN+q
	 kM8zpfW3/lh2Lax4aQo2iZ9YRx3Bf/6V4Ue20i2gOnULkY7V/srmphUeFoP/yfA1l/
	 mh4ngvCC72vLG+EknjBAB2BUA4t7UiWVj6D7W0bQ=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 4C266F804E5;
	Thu,  8 Apr 2021 18:56:00 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 16410F804B0; Thu,  8 Apr 2021 18:55:55 +0200 (CEST)
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id CFCA7F8032D
 for <alsa-devel@alsa-project.org>; Thu,  8 Apr 2021 18:55:51 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz CFCA7F8032D
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org
 header.b="ECPi1Cqr"
Received: by mail.kernel.org (Postfix) with ESMTPSA id D8F50610CB;
 Thu,  8 Apr 2021 16:55:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1617900950;
 bh=ZJb6iLVqWt5B42gyms7TM+jaafU+bwfrgC8V3lIAN+0=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=ECPi1CqrJNwFooTycsCE4X7bxbHdqUQkTtIZqOOCRFmSdUl9ywHSyHkPDz8GPwf/k
 Zc4O14oW1QEPjXIsqNcK2s263iR9ZeEDvpjptFbiWJ/lDKlozdnEfWBVuPVuvu+Wfo
 p5PZ94rU8gE3pTLLfvOXKaNRRDNtqQsp3HRPJrsLVY+cmvp9v5X783oOrFeZN18HCI
 BE+cCBNjGD7KmXEmHx0E9W+ErhncwCIhc6E800fY8ZWydW0cPvDPdySkKyg5PSYU8E
 Wfc8sbPkAwEdLc60x7xJpLpHciY4cUB0GdgkOeYgdNbLiRRvfClZCGkkZqaRknGRY+
 wL8S2W3OsiNHQ==
From: Mark Brown <broonie@kernel.org>
To: Jack Yu <jack.yu@realtek.com>,
	lgirdwood@gmail.com
Subject: Re: [PATCH] ASoC: rt1011: remove pack_id check in rt1011
Date: Thu,  8 Apr 2021 17:54:45 +0100
Message-Id: <161790012551.16915.9662390862685702998.b4-ty@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <4cbe1cd3b8664140889132464c7dee7b@realtek.com>
References: <4cbe1cd3b8664140889132464c7dee7b@realtek.com>
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

On Thu, 8 Apr 2021 08:32:40 +0000, Jack Yu wrote:
> For latest design, different package could use the same setting,
> therefore the check of pack_id will no longer be used.

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/1] ASoC: rt1011: remove pack_id check in rt1011
      commit: 44de8d80dba4e65f4fe7c17ea4be75e3cf9a902c

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
