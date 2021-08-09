Return-Path: <SRS0=CTIr=NA=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4633BC4338F
	for <alsa-devel@archiver.kernel.org>; Mon,  9 Aug 2021 15:55:57 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2527960234
	for <alsa-devel@archiver.kernel.org>; Mon,  9 Aug 2021 15:55:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 2527960234
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id D8E721616;
	Mon,  9 Aug 2021 17:55:03 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz D8E721616
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1628524553;
	bh=0QkxDzqsUF7YVC0Z1evJykDt9DC/MHfDfmzv0D3EVUA=;
	h=From:To:Subject:Date:In-Reply-To:References:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=ulJeRYrqWzGjYwxvAcKYnt8zdqEJckfI+AKLNQYelf6tib1fDNzTT34DMdCMaj+wL
	 h0ZLftL7KLmLYJI1dSLFD/RD+Jfs49BB1UHHPDlGVbTFQqXi1Kkyq2Nxfkn0NYGscP
	 fnhfKrvFS3tZSrOfVtOMYnu9hoA6zpdheHmlJs2s=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 28192F80105;
	Mon,  9 Aug 2021 17:55:03 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 2C20AF802D2; Mon,  9 Aug 2021 17:55:01 +0200 (CEST)
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id B7D46F800C8
 for <alsa-devel@alsa-project.org>; Mon,  9 Aug 2021 17:54:57 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz B7D46F800C8
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org
 header.b="SGf89fpY"
Received: by mail.kernel.org (Postfix) with ESMTPSA id 99D4D6101E;
 Mon,  9 Aug 2021 15:54:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1628524494;
 bh=0QkxDzqsUF7YVC0Z1evJykDt9DC/MHfDfmzv0D3EVUA=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=SGf89fpYXEeogLPYP9VonbrJvlAqGONL8rOrzhF/FrxOq5AUwnhVOO3wNFSt/jhI3
 A+EpMH2v/7SKIEBGCggFPiq6dTPyYQ2NbmhpNScr1BGQVSPaYS0O7eEWfYhdemeoww
 C14rLinx0dmZNxuF1HQcHU+YPXIqc1avAym/xqTJ4vgPNnjOHlAg2SHJZZi1nCDofG
 5ewuvh2JMC7ZI03TSwn3N/+WSuX/WTdO2bVgoHd7uQHY7AeVa1mhQx/xurZ92rTl1d
 kiOKyHkxYsoFixSMNnpRD2MEBlb224JSUh2Wp0D+BoUDkQv4RKsl7EUVdXsRrO8a1U
 PRp8qF4GvWETw==
From: Mark Brown <broonie@kernel.org>
To: Jack Yu <jack.yu@realtek.com>,
	lgirdwood@gmail.com
Subject: Re: [PATCH] ASoC: rt1015p: add new acpi id and comapatible id
Date: Mon,  9 Aug 2021 16:54:33 +0100
Message-Id: <162852418086.21716.3875772923924644880.b4-ty@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20210317062309.14051-1-jack.yu@realtek.com>
References: <20210317062309.14051-1-jack.yu@realtek.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Cc: oder_chiou@realtek.com, alsa-devel@alsa-project.org, lars@metafoo.de,
 kent_chen@realtek.com, kenny_chen@realtek.com, tzungbi@google.com,
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

On Wed, 17 Mar 2021 14:23:09 +0800, Jack Yu wrote:
> Add new acpi id and compatible id for rt1015p.

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/1] ASoC: rt1015p: add new acpi id and comapatible id
      commit: 6d0a764d418fb508119e129c73f39ecc66826675

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
