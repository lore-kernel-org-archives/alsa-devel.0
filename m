Return-Path: <SRS0=oBR+=GY=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D5A78C433E0
	for <alsa-devel@archiver.kernel.org>; Thu, 21 Jan 2021 00:11:48 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3CC3B23441
	for <alsa-devel@archiver.kernel.org>; Thu, 21 Jan 2021 00:11:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3CC3B23441
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id CD1E418B1;
	Thu, 21 Jan 2021 01:10:56 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz CD1E418B1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1611187906;
	bh=fJmBuuQz1f9NwhONIikUc47J0yR0liG2Nz8foWUbmEk=;
	h=From:To:In-Reply-To:References:Subject:Date:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=ioGjK7dFj/cfvyZpnUtIe6wLvIQJhVEfRCweaP4txCgoSAs07qZCk/sXyjBwz0shP
	 ZH1fTwqyVfx8t3ZF6UAesGxv9xy+kBr9jcgkCM3PSASbQW0Z42/YsdBpRzOSBehJTB
	 YZK0iyPFGws8Ckkxk3UfdTQWanwOhKVI7VcWo/uY=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 23C38F8019B;
	Thu, 21 Jan 2021 01:07:36 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 4DE48F80518; Thu, 21 Jan 2021 01:07:35 +0100 (CET)
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id C9D11F80516
 for <alsa-devel@alsa-project.org>; Thu, 21 Jan 2021 01:07:30 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz C9D11F80516
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org
 header.b="SnPsPXl1"
Received: by mail.kernel.org (Postfix) with ESMTPSA id 51FDC2371F;
 Thu, 21 Jan 2021 00:07:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1611187648;
 bh=fJmBuuQz1f9NwhONIikUc47J0yR0liG2Nz8foWUbmEk=;
 h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
 b=SnPsPXl1tiPS+azOKnNIvzhGrwT4/YsQ63jr5C1n3T4hL4SWX9mRhcHx7O8HIS0uQ
 2ImssWH4HdpuYfd2hgF303mSaC7eaysm/WVETJ8oUQxa7TSZbhArcaQ9zOASmwi/OF
 FIqqiIuWIFPj7RTk1wpJpInHK4HnF3xD6FepnjxTVZoJvA+r66T3SIRKetAYy9Jvpu
 iOIrcef9mu29soIhGZnGLNJIV/1NaHCiWa2doZWPI1Md5gMC9n7+hr44VEOQDcgj+n
 Rwl/KVAL/OXdRN+2ZujJdbJenTeB8dUsBvPxnZtCvPXmsrl/lJCNrFBV+rqwI/Ztxo
 TASnIVbV6hD/w==
From: Mark Brown <broonie@kernel.org>
To: Yu-Hsuan Hsu <yuhsuan@chromium.org>, linux-kernel@vger.kernel.org
In-Reply-To: <20210115075301.47995-1-yuhsuan@chromium.org>
References: <20210115075301.47995-1-yuhsuan@chromium.org>
Subject: Re: [PATCH v7 1/2] cros_ec_commands: Add EC_CODEC_I2S_RX_RESET
Message-Id: <161118753483.45718.10581891654341693206.b4-ty@kernel.org>
Date: Thu, 21 Jan 2021 00:05:34 +0000
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Cc: alsa-devel@alsa-project.org, Liam Girdwood <lgirdwood@gmail.com>,
 "Gustavo A . R . Silva" <gustavoars@kernel.org>, Takashi Iwai <tiwai@suse.com>,
 Guenter Roeck <groeck@chromium.org>, Prashant Malani <pmalani@chromium.org>,
 Pi-Hsun Shih <pihsun@chromium.org>,
 Enric Balletbo i Serra <enric.balletbo@collabora.com>,
 Benson Leung <bleung@chromium.org>, Cheng-Yi Chiang <cychiang@chromium.org>
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

On Fri, 15 Jan 2021 15:53:00 +0800, Yu-Hsuan Hsu wrote:
> Add the new command EC_CODEC_I2S_RX_RESET in ec_codec_i2s_rx_subcmd,
> which is used for resetting the EC codec.

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/2] cros_ec_commands: Add EC_CODEC_I2S_RX_RESET
      commit: f4d3bd8be4f2bc43e4b13490cbc9969d15c2f058
[2/2] ASoC: cros_ec_codec: Reset I2S RX when probing
      commit: 7f1f7ae102ea082745e320b3c8c003f43c063edf

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
