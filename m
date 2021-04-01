Return-Path: <SRS0=rMx/=I6=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C1E79C433B4
	for <alsa-devel@archiver.kernel.org>; Thu,  1 Apr 2021 10:20:29 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 204E56108B
	for <alsa-devel@archiver.kernel.org>; Thu,  1 Apr 2021 10:20:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 204E56108B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 41007169F;
	Thu,  1 Apr 2021 12:19:37 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 41007169F
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1617272427;
	bh=P6MNOdaWHxHkb23Ta5r2u+eFDKM+94LggzIXr7z73p8=;
	h=From:To:Subject:Date:In-Reply-To:References:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=BdQRSxyBTdJ+uEfGI7LmSnFny5A59PFHE4dXA4UXXhJnOle25zNHYyqAYrwXmrlrn
	 ucOBj4TQk3eRE8I80oCo/H9sLHxzRNEzz3fGTqL2Hm0TCe4YCjfSQ6uDDvypzIK3kx
	 XmhWYQxWNC8z28RKeTHm0N4hYUBbdqUD6Lfqcl6Y=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 2441CF804AD;
	Thu,  1 Apr 2021 12:17:25 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id D40DAF804A9; Thu,  1 Apr 2021 12:17:22 +0200 (CEST)
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id BC769F8026F
 for <alsa-devel@alsa-project.org>; Thu,  1 Apr 2021 12:17:19 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz BC769F8026F
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org
 header.b="bB3/q6L8"
Received: by mail.kernel.org (Postfix) with ESMTPSA id 643446108B;
 Thu,  1 Apr 2021 10:17:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1617272238;
 bh=P6MNOdaWHxHkb23Ta5r2u+eFDKM+94LggzIXr7z73p8=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=bB3/q6L8wHVEBuWb4vrWXDawqc5HI321BuQs70r9pD5Pu42UnjT6pkIbR6IWVa/mD
 vsF8pLjzApOgQsY3A0LV+dpgxaiKjF4kSwNLi47X9Wl5YSypl0yctlKKxpEJJ4ILX4
 QMLUcTNRE18NB6aHIwa3/L2EJnvwMxtcsAP7vSfh863CF2Yi6Q2q7smLGs7Oc9bYWd
 seRR/vMn2JsgIWWvJlwmGtXnaWZvMl4/qp4JfyO1qOhv7bVIK2wfRAMz4wzcXr4MF4
 WHUE7W5JOnOCTtF9DUar7vCERshPb4292dTQ4+OWUcXwH8/0Sm08eydElEzmwv0iOP
 6I2PQnpXcKrEw==
From: Mark Brown <broonie@kernel.org>
To: Bhaskar Chowdhury <unixbhaskar@gmail.com>, cezary.rojewski@intel.com,
 perex@perex.cz, pierre-louis.bossart@linux.intel.com, tiwai@suse.com,
 liam.r.girdwood@linux.intel.com, linux-kernel@vger.kernel.org,
 yang.jie@linux.intel.com, gustavoars@kernel.org,
 alsa-devel@alsa-project.org
Subject: Re: [PATCH] ASoC: Intel: Fix a typo
Date: Thu,  1 Apr 2021 11:16:24 +0100
Message-Id: <161726938995.2219.9727885151861979594.b4-ty@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20210322210105.1575758-1-unixbhaskar@gmail.com>
References: <20210322210105.1575758-1-unixbhaskar@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Cc: Mark Brown <broonie@kernel.org>, rdunlap@infradead.org
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

On Tue, 23 Mar 2021 02:31:05 +0530, Bhaskar Chowdhury wrote:
> s/defintions/definitions/

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/1] ASoC: Intel: Fix a typo
      commit: bb0f78e59777d55e0065d16d070b5d43ae80b769

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
