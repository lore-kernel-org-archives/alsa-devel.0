Return-Path: <SRS0=jAxA=GI=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.3 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F0CC2C433DB
	for <alsa-devel@archiver.kernel.org>; Tue,  5 Jan 2021 16:09:08 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4205D22C9E
	for <alsa-devel@archiver.kernel.org>; Tue,  5 Jan 2021 16:09:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4205D22C9E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id BDD8216B8;
	Tue,  5 Jan 2021 17:08:16 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz BDD8216B8
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1609862946;
	bh=aCLo2xhJZFJinAotkDQjeIIeunXHBJXvp+JElZ9J2cU=;
	h=From:To:In-Reply-To:References:Subject:Date:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=Lyl1hmWRVihYDqNQI7PnjGRhLye04IXwWOkQcSCc4JzugNOezGRxiOvCt5+5xYiTo
	 HZ/nashyT0Q4u7yoGIuqO8cgIDskGveIQuNZEx099P7VR8ZWwbGF7HRGzYKLJhFio0
	 DSVDBXiI7bg13sFFJLKWcZFm0/dSqoHIEfhDl/bU=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 3F47BF8015B;
	Tue,  5 Jan 2021 17:07:28 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 66C0EF802C4; Tue,  5 Jan 2021 17:07:26 +0100 (CET)
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 757BFF8015B
 for <alsa-devel@alsa-project.org>; Tue,  5 Jan 2021 17:07:22 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 757BFF8015B
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org
 header.b="GADbFOyZ"
Received: by mail.kernel.org (Postfix) with ESMTPSA id 7CCE422C9E;
 Tue,  5 Jan 2021 16:07:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1609862841;
 bh=aCLo2xhJZFJinAotkDQjeIIeunXHBJXvp+JElZ9J2cU=;
 h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
 b=GADbFOyZ+OkRLo7B5KKQk6sQOsr+q+2wHTbJ/yPZnlPABhEHOi0teeyFTpMXn1M0e
 C2PEoZLVgU+M11TSBhTLYrq/23bdP+i7DzJ0GJqBC+7x3sMRO6Xfp5QOZD1WlMfiAb
 7B7YAMnKI2UPSit1x8M39mJGBAsNXHyHVR/YdAqC8RHS9iGNt/pN116ydv2FPAPdjB
 T0u2I57e7FvU34A7n8O37bPHVp+3w5Eph2/y3MDL3OH+9+hKKaWGaK6EVTPVPEjN26
 QqxuTwEqAIaGYTdXMSrbhCfV0X6JNRB25LvvDEedyzlI1N+bI6CgDTaw0p5YbBqFWX
 iCUgQVhuJ6Xjw==
From: Mark Brown <broonie@kernel.org>
To: Tzung-Bi Shih <tzungbi@google.com>
In-Reply-To: <20201225030845.4138497-1-tzungbi@google.com>
References: <20201225030845.4138497-1-tzungbi@google.com>
Subject: Re: [PATCH] ASoC: rt1015: re-calibrate again when resuming
Message-Id: <160986280837.50063.9380709468821926841.b4-ty@kernel.org>
Date: Tue, 05 Jan 2021 16:06:48 +0000
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Cc: alsa-devel@alsa-project.org
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

On Fri, 25 Dec 2020 11:08:45 +0800, Tzung-Bi Shih wrote:
> Assuming the calibration state gets lost after system suspend.
> Re-calibrates again when resuming.
> 
> The rt1015_priv is alloced by kzalloc.  No need to initialize cali_done
> to 0 in component probe callback.

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/1] ASoC: rt1015: re-calibrate again when resuming
      commit: d750570e048165c54a99703729438b2a4ccf379b

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
