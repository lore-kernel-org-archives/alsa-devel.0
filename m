Return-Path: <SRS0=vr1N=NB=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D0D03C4338F
	for <alsa-devel@archiver.kernel.org>; Tue, 10 Aug 2021 15:22:19 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A8C7360F41
	for <alsa-devel@archiver.kernel.org>; Tue, 10 Aug 2021 15:22:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org A8C7360F41
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 7FBAB85D;
	Tue, 10 Aug 2021 17:21:26 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 7FBAB85D
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1628608936;
	bh=kU8MFV7YslYW2xJNL20kvQgQdTi2xb/hQWirMa3PqBs=;
	h=From:To:Subject:Date:In-Reply-To:References:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=BLJwjC2mZxAk91d1KhR5A5Rx1eX0uTqzJ3PsBkz+9I6lwV4uboCyJiBfc+pCQp9El
	 G5G9IZT/m8lfDrRmilUu6EvZDcQmIWO50if3myCOhDd838Uj1VqPhA3oI4rj1x6dqe
	 WQa1NnoAiHmy5KGeW0M24j9YRUVAVCBMqoX+/rXs=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 26D7EF80279;
	Tue, 10 Aug 2021 17:20:41 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 37AC6F804B1; Tue, 10 Aug 2021 17:20:37 +0200 (CEST)
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id D4A29F80279
 for <alsa-devel@alsa-project.org>; Tue, 10 Aug 2021 17:20:31 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz D4A29F80279
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org
 header.b="rgYcDxXh"
Received: by mail.kernel.org (Postfix) with ESMTPSA id 729D160F13;
 Tue, 10 Aug 2021 15:20:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1628608828;
 bh=kU8MFV7YslYW2xJNL20kvQgQdTi2xb/hQWirMa3PqBs=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=rgYcDxXhoTo3MejFlwZdWMwaKtKkIaT1sACghr0IryQ6KdEMyhmsh6bSz3aNyM6pH
 7jHUIBmTbIP0hHs342xow7Bh5HgTbx73M/VlnSMT7NvPtuKa3rLjUGOHGL2ueBtoYi
 Ao3JVCJYyLIsJmAuOxImrxq16qOD+DvsJ18SOO/x6/XhZk58A5wLARyh0YeEtKHLsN
 m6OZ6q5hijai+2TueBP6esygdWTvvmGp8JkfjEMNXaczYBY9nH2nR3i6qkOwkCt+eu
 lPvRT7OZJRjZFqb/F6aSPfoDJxoHf2W2VKYqww8CeYcz/VrmoxEbElUG4gj9sCSrMu
 l1eI9HMq9tSlw==
From: Mark Brown <broonie@kernel.org>
To: robh@kernel.org,
	lgirdwood@gmail.com,
	Jack Yu <jack.yu@realtek.com>
Subject: Re: [PATCH] ASoC: dt-bindings: rt1015p: fix syntax error in
 dts-binding document
Date: Tue, 10 Aug 2021 16:20:02 +0100
Message-Id: <162860604513.6045.15119662311844913843.b4-ty@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20210810020834.32414-1-jack.yu@realtek.com>
References: <20210810020834.32414-1-jack.yu@realtek.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Cc: oder_chiou@realtek.com, devicetree@vger.kernel.org,
 alsa-devel@alsa-project.org, lars@metafoo.de, kent_chen@realtek.com,
 kenny_chen@realtek.com, linux-kernel@vger.kernel.org,
 Mark Brown <broonie@kernel.org>, derek.fang@realtek.com, shumingf@realtek.com,
 flove@realtek.com
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

On Tue, 10 Aug 2021 10:08:34 +0800, Jack Yu wrote:
> Fix syntax error in dts-binding document.
> 
> 
> 
> 

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/1] ASoC: dt-bindings: rt1015p: fix syntax error in dts-binding document
      commit: eb7ab747efd600382bc2e9406ea1fc2a867e9804

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
