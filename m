Return-Path: <SRS0=cpFx=IC=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 59B58C433E6
	for <alsa-devel@archiver.kernel.org>; Thu,  4 Mar 2021 01:00:04 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B861064F27
	for <alsa-devel@archiver.kernel.org>; Thu,  4 Mar 2021 01:00:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B861064F27
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 0A3961ADC;
	Thu,  4 Mar 2021 01:59:12 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 0A3961ADC
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1614819602;
	bh=Zo9ejpK3J2YIjy6+5NGUQ8DdIFh8iL3EeJFdU7B3QdQ=;
	h=From:To:In-Reply-To:References:Subject:Date:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=ot0XOuknir/FPhNnpgieaGJ2ucHtC0Ul3xBwHPor2t6wdWZEBQnoUHPYll4CPnjws
	 S69RHxdQ+muqk0jfG8522S7tmYmlqMtAx9I7oAQcYZxHEfiSHA5+ckJ54Q8Bq65V3B
	 z1JgLUsEzJd2ngMqzN/Zrui65sMDbevY9SbuLUmo=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 294D7F804EB;
	Thu,  4 Mar 2021 01:56:07 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 1783FF804EB; Thu,  4 Mar 2021 01:56:05 +0100 (CET)
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 62224F804E6
 for <alsa-devel@alsa-project.org>; Thu,  4 Mar 2021 01:56:00 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 62224F804E6
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org
 header.b="ecJ/RPVd"
Received: by mail.kernel.org (Postfix) with ESMTPSA id 5495D64EC3;
 Thu,  4 Mar 2021 00:55:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1614819358;
 bh=Zo9ejpK3J2YIjy6+5NGUQ8DdIFh8iL3EeJFdU7B3QdQ=;
 h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
 b=ecJ/RPVdkKlVdbrEtmweTIIhN8aAj3VaNB1MFvdlHRmQSgTV8VfuNlmdJlbzyfTmM
 AVF85i5OQBNownfzpk3/t38bm+wOHUxpn1hSsTzXJ+JQAzIJdcChyRevJPz38j0G+D
 MNv1xGRIGuvLjX1aVCldFbb5gZs/mUJc0Kmi+kDqyJMlKpAgUMJv5Z42901XsNdg5f
 y6YwEyVBcX+8yqNfRKqXyCmOaElQQKjNWgLkCOjgjiYYEEaBhCAXkXpqRkS7lqXfrk
 KGsAckSvQOkEU+HbVLmSUbUCwqhwIRWw7uJErXBonDbFVsODKFNPuPNnXzKhGB2gxv
 2zLHBJlUJwGkQ==
From: Mark Brown <broonie@kernel.org>
To: Fabio Estevam <festevam@gmail.com>
In-Reply-To: <20210301193328.2123511-1-festevam@gmail.com>
References: <20210301193328.2123511-1-festevam@gmail.com>
Subject: Re: [PATCH] ASoC: wm8524: Do not print probe defer error
Message-Id: <161481924069.9553.4493444690118060877.b4-ty@kernel.org>
Date: Thu, 04 Mar 2021 00:54:00 +0000
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Cc: patches@opensource.cirrus.com, shengjiu.wang@nxp.com,
 alsa-devel@alsa-project.org, cphealy@gmail.com
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

On Mon, 1 Mar 2021 16:33:28 -0300, Fabio Estevam wrote:
> On an imx8mq-evk the following error is seen:
> 
> [    1.375809] wm8524-codec audio-codec: Failed to get mute line: -517
> 
> It happens because the codec driver may probe prior to the imx gpio
> driver, which causes a probe defer.
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/1] ASoC: wm8524: Do not print probe defer error
      commit: 59dffc7769d720aab10b8c70acfcf1dea4a493f3

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
