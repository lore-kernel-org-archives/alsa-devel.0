Return-Path: <SRS0=4l9v=GP=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.3 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B8EF5C433E0
	for <alsa-devel@archiver.kernel.org>; Tue, 12 Jan 2021 16:44:30 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0176423110
	for <alsa-devel@archiver.kernel.org>; Tue, 12 Jan 2021 16:44:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0176423110
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 55FF916EC;
	Tue, 12 Jan 2021 17:43:38 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 55FF916EC
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1610469868;
	bh=kvA6EzFMifrlgziq/mCenSbkFpe3vuE+zD9SvpBIBaM=;
	h=From:To:In-Reply-To:References:Subject:Date:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=Okf0iCCuImSjBOZ+58kdIWr7LGzRDijyDCwP+nPAdIhiV/U7r+EX/wC189kH3qr1n
	 McsFAGtqZ2TjsEM8lWt7gFZs+LHHPi7G6EfaQALhpTSDMfrGGv+wI1ECGLnKwVy11s
	 e1AWQi9HwQ+vis2Q0k7rUVb0Np9CAHCc6vQp1CGQ=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 4B5FEF804D2;
	Tue, 12 Jan 2021 17:42:55 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 88731F804D2; Tue, 12 Jan 2021 17:42:53 +0100 (CET)
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 9E848F80113
 for <alsa-devel@alsa-project.org>; Tue, 12 Jan 2021 17:42:47 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 9E848F80113
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org
 header.b="M0NwxyZW"
Received: by mail.kernel.org (Postfix) with ESMTPSA id 7C9C323107;
 Tue, 12 Jan 2021 16:42:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1610469766;
 bh=kvA6EzFMifrlgziq/mCenSbkFpe3vuE+zD9SvpBIBaM=;
 h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
 b=M0NwxyZWDCsqKIT+E54qzEYbDdNlntT1M1W5fTrJyP+jIpl0OFHTEVxN/whiq73E/
 xcD7w6H9LBMJD2vPvqmnuxzkq3gHfmNSBK/0z4BCSXX9ZKpQuyySQXQ9ZnDxT41xVc
 quyJgpdqcY6wIdoUk0ZbbDxfDDEZpNhDj0HBcW9CqaVwy6bPRwFE5f+gXLM38fR/3x
 f3bXRNQy7uT07YdbOG9iV9FESo8Xt7s1/9ujpoJw6w8AveL6y+gBdK5oKh1AC9HFOf
 przWUtEHRPNJQxrBrb9eJhOV/rMeRz4wo2XXnQAUob22t7GtX7Ua0qgLsqfuft6G4Z
 Wvoor/7v/f6Yw==
From: Mark Brown <broonie@kernel.org>
To: nuno.sa@analog.com, Xu Wang <vulab@iscas.ac.cn>,
 alsa-devel@alsa-project.org, tiwai@suse.com, lgirdwood@gmail.com,
 perex@perex.cz, lars@metafoo.de
In-Reply-To: <20210108084456.6603-1-vulab@iscas.ac.cn>
References: <20210108084456.6603-1-vulab@iscas.ac.cn>
Subject: Re: [PATCH] ASoC: adau17x1: Remove redundant null check before
 clk_disable_unprepare
Message-Id: <161046972100.805.6254857210248726641.b4-ty@kernel.org>
Date: Tue, 12 Jan 2021 16:42:01 +0000
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Cc: linux-kernel@vger.kernel.org
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

On Fri, 8 Jan 2021 08:44:56 +0000, Xu Wang wrote:
> Because clk_disable_unprepare() already checked NULL clock parameter,
> so the additional check is unnecessary, just remove it.

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/1] ASoC: adau17x1: Remove redundant null check before clk_disable_unprepare
      commit: 554a1b00957ec1033994a2d03b5b8eac59a24f3c

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
