Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0D1E5C43334
	for <alsa-devel@archiver.kernel.org>; Tue,  7 Jun 2022 10:51:07 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 4C0191A8F;
	Tue,  7 Jun 2022 12:50:15 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 4C0191A8F
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1654599065;
	bh=cl2kJ6HTDe0yukX7nr1xYKMvqp7lqxgQZ48J6FS5Cu0=;
	h=From:To:In-Reply-To:References:Subject:Date:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=kV8E9HXe54m/8Aj4edC2HvBEgqj2Jy6fmMyDbm/mP7TLnw2ld2Hq7X6M1Tadm21fa
	 5m5FRqMl10HaKQGq7lr9qhH+tp9cA2PwWeYRCtckzJchWkQb5iS9oRa2Kq9P0bzo1L
	 Zpbm6EMAB5S3AdLCAS4+lk1QQFy8vhe/oZzlcIYM=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 35360F805BF;
	Tue,  7 Jun 2022 12:46:06 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id B8A0BF805B1; Tue,  7 Jun 2022 12:46:02 +0200 (CEST)
Received: from ams.source.kernel.org (ams.source.kernel.org
 [IPv6:2604:1380:4601:e00::1])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 0C71FF805B1
 for <alsa-devel@alsa-project.org>; Tue,  7 Jun 2022 12:46:00 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 0C71FF805B1
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org
 header.b="k4wxjE+U"
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by ams.source.kernel.org (Postfix) with ESMTPS id 1CAC1B81F01;
 Tue,  7 Jun 2022 10:45:59 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9934CC34114;
 Tue,  7 Jun 2022 10:45:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1654598757;
 bh=cl2kJ6HTDe0yukX7nr1xYKMvqp7lqxgQZ48J6FS5Cu0=;
 h=From:To:In-Reply-To:References:Subject:Date:From;
 b=k4wxjE+UoQ8CtcvorC7C6F8xX+9lfSc/Mhez6uwNgnafTahMtqjXHys0us70fzpSY
 9HvPau5q34kT3A4koEMEZ7iinwHC26WeKeA0X6SrU0+XvkKeBjtNvNaD6DMTs/34RT
 ZF/w1123ishJ/2k39nAAtgfTi2nFv4FC23HNnPlolMFPYSdsvlnNRrMV1xHxfah7Ox
 HTxOf481UKpI74BS7fFHKJDxOx+BKutXW63ZzOnRMq/NINOh65qjfi/2540yFyES/m
 7ATpXkZCYkXgDKVfMtZXkKSYWmuUSHGo57F7NOM7m9pg2DS0xBDS1cva9KTJ+0ibx8
 5aGxcDVHQnFuw==
From: Mark Brown <broonie@kernel.org>
To: cychiang@chromium.org, chrome-platform@lists.linux.dev, linmq006@gmail.com,
 Liam Girdwood <lgirdwood@gmail.com>, tzungbi@google.com,
 Takashi Iwai <tiwai@suse.com>, groeck@chromium.org,
 linux-kernel@vger.kernel.org, bleung@chromium.org,
 Jaroslav Kysela <perex@perex.cz>, alsa-devel@alsa-project.org
In-Reply-To: <20220602114529.6303-1-linmq006@gmail.com>
References: <20220602114529.6303-1-linmq006@gmail.com>
Subject: Re: [PATCH] ASoC: cros_ec_codec: Fix refcount leak in
 cros_ec_codec_platform_probe
Message-Id: <165459875534.301808.8602571934037682831.b4-ty@kernel.org>
Date: Tue, 07 Jun 2022 11:45:55 +0100
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
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

On Thu, 2 Jun 2022 15:45:29 +0400, Miaoqian Lin wrote:
> of_parse_phandle() returns a node pointer with refcount
> incremented, we should use of_node_put() on it when not need anymore.
> Add missing of_node_put() to avoid refcount leak.
> 
> 

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/1] ASoC: cros_ec_codec: Fix refcount leak in cros_ec_codec_platform_probe
      commit: 0a034d93ee929a9ea89f3fa5f1d8492435b9ee6e

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
