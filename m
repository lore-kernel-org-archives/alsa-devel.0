Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 56FBFC433FE
	for <alsa-devel@archiver.kernel.org>; Wed, 19 Oct 2022 15:51:32 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 6C256ADE9;
	Wed, 19 Oct 2022 17:50:40 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 6C256ADE9
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1666194690;
	bh=5u5hq3ASPhUNq8qN4fBNNy4Gefv5SW3e7er4wQmRM6U=;
	h=From:To:In-Reply-To:References:Subject:Date:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=D1M/ERttt4KyDlQ+pQOH9yyqLwALmvhg6rRBCdGZXgP++KbdrUsUh4UqZtxxWXqtS
	 kXqkeTIvUnjoBcWTBJQZ3JZi3FhFxxizasc7o7N8y//lFmWatT6G2RB6n/cMxLpOlg
	 +9c3GDxmm1eRLKcOM1R7TCcn3TwgjIVw8+kiTpdA=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id E3067F8054A;
	Wed, 19 Oct 2022 17:50:34 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 50BE5F80549; Wed, 19 Oct 2022 17:50:33 +0200 (CEST)
Received: from sin.source.kernel.org (sin.source.kernel.org [145.40.73.55])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id E32CCF80535
 for <alsa-devel@alsa-project.org>; Wed, 19 Oct 2022 17:50:24 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz E32CCF80535
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org
 header.b="d3YeK0GQ"
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by sin.source.kernel.org (Postfix) with ESMTPS id ACB50CE22CB;
 Wed, 19 Oct 2022 15:50:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 10EC9C433D7;
 Wed, 19 Oct 2022 15:50:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1666194620;
 bh=5u5hq3ASPhUNq8qN4fBNNy4Gefv5SW3e7er4wQmRM6U=;
 h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
 b=d3YeK0GQ8UdkPCdWjhqE7gNiRO4r2yR/48wLhmOJN9dNWxwAKlkSXeXnOrVS8vQyz
 Q6dOhv6U74SDuS6mw/LiPFChZ98qjtmH07OPlcly9vI7JM/+s0yhoCiGiJh7szSx5q
 RsH6ZrUrCVTticLVFnsDgehyUEtlDzQRmKRjgdNaxseJ5cyYFfARCKNZnlkSKLUARf
 ksg9R5W4S6th/190a/JmlAGMRqrD/Po7lpMeFXZ+rsmWz4egB7/9TyVeXJ2mSl+Ws4
 MQdiTLx/zgdKLgVoxQC2VPaBYwhRjbEKagPylU3zxqOGSkTI2EDV2F4tY9GyZpffMC
 ZK5FYnQ1MSCUw==
From: Mark Brown <broonie@kernel.org>
To: shumingf@realtek.com, lgirdwood@gmail.com
In-Reply-To: <20221019095731.31101-1-shumingf@realtek.com>
References: <20221019095731.31101-1-shumingf@realtek.com>
Subject: Re: [PATCH 2/2] ASoC: rt1308-sdw: update the preset settings
Message-Id: <166619461779.884966.2874794280080203501.b4-ty@kernel.org>
Date: Wed, 19 Oct 2022 16:50:17 +0100
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Mailer: b4 0.10.0-dev-fc921
Cc: oder_chiou@realtek.com, jack.yu@realtek.com, alsa-devel@alsa-project.org,
 lars@metafoo.de, derek.fang@realtek.com, bard.liao@intel.com,
 flove@realtek.com, pierre-louis.bossart@intel.com
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

On Wed, 19 Oct 2022 17:57:31 +0800, shumingf@realtek.com wrote:
> From: Shuming Fan <shumingf@realtek.com>
> 
> This patch updates the pad control and checks the
> hardware version to set the different preset settings.
> 
> 

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[2/2] ASoC: rt1308-sdw: update the preset settings
      commit: 00aaf8bfe0ee2b807b452df806d725e080d85404

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
