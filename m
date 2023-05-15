Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D616BC77B7D
	for <alsa-devel@archiver.kernel.org>; Mon, 15 May 2023 11:12:29 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id AEE9A839;
	Mon, 15 May 2023 13:11:37 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz AEE9A839
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1684149147;
	bh=AzqOmQc7OrwPNPM/ssnco453fybt0WCECRc/Pyq/wu0=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:List-Id:
	 List-Archive:List-Help:List-Owner:List-Post:List-Subscribe:
	 List-Unsubscribe:From;
	b=VJ4QU5ntcTib5iD5qeCT61TY7g8Kvvqaw5Npy2SzOtOfYsVOokOWtvFoYV2D71Gah
	 CsC3EkLYWF/SzWpSwX10OcolHDLvkphVZNsGwZXK3/735LvfP233WUPMIvdbIRt9yb
	 k1O1Qzpe7X6LnvNNOm7Wrin1MgPj9hH1YpOoJkWE=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id E1238F805B1; Mon, 15 May 2023 13:10:01 +0200 (CEST)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id 28CD9F8057B;
	Mon, 15 May 2023 13:10:01 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 53E96F80568; Mon, 15 May 2023 13:09:51 +0200 (CEST)
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa1.perex.cz (Postfix) with ESMTPS id 23558F80431
	for <alsa-devel@alsa-project.org>; Mon, 15 May 2023 13:09:48 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 23558F80431
Authentication-Results: alsa1.perex.cz;
	dkim=pass (2048-bit key,
 unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20201202 header.b=LB03kSID
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.source.kernel.org (Postfix) with ESMTPS id 1300D6229C;
	Mon, 15 May 2023 11:09:47 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 76926C433D2;
	Mon, 15 May 2023 11:09:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1684148986;
	bh=AzqOmQc7OrwPNPM/ssnco453fybt0WCECRc/Pyq/wu0=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=LB03kSIDbU5zCmAqtLnCcGqTE1YXvzkj9MSUdYA0qHhOAfityGb7oI8oPH412R67d
	 Ks5SEV7MYOkjwEIET6zHeE9YRRW8QmzChbrysCVJ7hJSJBh6JHMMhLaZKo6Od+VG1o
	 bxchNBsaQg2YMEYuCiugpcL4rOjWEirjtHbyoloSuIXYRx4JEiNauacN7t3Xj72YiC
	 WQI4Ccfk47XWi7M8aa8amEvjCB+IKKU3D+Z5izH/5PiY+9OTwXMOf0obhc08u2Bxb9
	 06fvUUm+WdL66JKwMPOuB/N9R3OeTQszOV5UsiJNKOq+U3AGUGHp+xugFUItwYNAax
	 kZUKlPuifOupA==
From: Mark Brown <broonie@kernel.org>
To: Richard Fitzgerald <rf@opensource.cirrus.com>
Cc: alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
 patches@opensource.cirrus.com,
 Lucas Tanure <tanureal@opensource.cirrus.com>
In-Reply-To: <20230512154503.741718-1-rf@opensource.cirrus.com>
References: <20230512154503.741718-1-rf@opensource.cirrus.com>
Subject: Re: [PATCH RESEND] MAINTAINERS: Remove self from Cirrus Codec
 drivers
Message-Id: <168414898513.394037.16270681416045014663.b4-ty@kernel.org>
Date: Mon, 15 May 2023 20:09:45 +0900
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.13-dev-bfdf5
Message-ID-Hash: WRAOHSOSWNNGNHKU6GEG5FIODTSFOZ2H
X-Message-ID-Hash: WRAOHSOSWNNGNHKU6GEG5FIODTSFOZ2H
X-MailFrom: broonie@kernel.org
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency;
 loop; banned-address; member-moderation;
 header-match-alsa-devel.alsa-project.org-0;
 header-match-alsa-devel.alsa-project.org-1; nonmember-moderation;
 administrivia; implicit-dest; max-recipients; max-size; news-moderation;
 no-subject; digests; suspicious-header
X-Mailman-Version: 3.3.8
Precedence: list
List-Id: "Alsa-devel mailing list for ALSA developers -
 http://www.alsa-project.org" <alsa-devel.alsa-project.org>
Archived-At: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/WRAOHSOSWNNGNHKU6GEG5FIODTSFOZ2H/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

On Fri, 12 May 2023 16:45:03 +0100, Richard Fitzgerald wrote:
> I'm leaving Cirrus Logic, and will no longer have access to
> hardware and documentation necessary to be effective in a
> maintainership role.
> 
> 

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/1] MAINTAINERS: Remove self from Cirrus Codec drivers
      commit: dc60b67d259ea63196dcd0400dd43ba062e2e097

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

