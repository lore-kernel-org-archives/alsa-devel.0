Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8CB1FEB64DD
	for <alsa-devel@archiver.kernel.org>; Thu, 27 Jul 2023 22:54:34 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id E3ED6843;
	Fri, 28 Jul 2023 00:53:41 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz E3ED6843
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1690498472;
	bh=nccD0Mf6wU5sbJ5COVN/p0FKMBOhmCCUxaTQs85SCqw=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:List-Id:
	 List-Archive:List-Help:List-Owner:List-Post:List-Subscribe:
	 List-Unsubscribe:From;
	b=tnrqnKfYLipVn3yLxXhifn6ZFaJVoIZccxzamFxTnZvRODgdlDss0G+76i1jbg9PG
	 K07DqDLHBAo8Rh3j2/k2fX0xNXJyu+Ci8o8paaDUktNhbyYk4RHKQF4DEvVjxSPd0n
	 lwcnNfXTkRDtZJM8xSJybVAxLzCRDQ8ZELqEJmkc=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 3FDCDF8053B; Fri, 28 Jul 2023 00:53:13 +0200 (CEST)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id B0F06F8019B;
	Fri, 28 Jul 2023 00:53:12 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 78E6AF8019B; Fri, 28 Jul 2023 00:53:08 +0200 (CEST)
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest
 SHA256)
	(No client certificate requested)
	by alsa1.perex.cz (Postfix) with ESMTPS id 6BCA1F800C7
	for <alsa-devel@alsa-project.org>; Fri, 28 Jul 2023 00:53:03 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 6BCA1F800C7
Authentication-Results: alsa1.perex.cz;
	dkim=pass (2048-bit key,
 unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20201202 header.b=t/0s9ZMj
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits))
	(No client certificate requested)
	by dfw.source.kernel.org (Postfix) with ESMTPS id BFCE461F74;
	Thu, 27 Jul 2023 22:53:01 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 97FD1C433C8;
	Thu, 27 Jul 2023 22:52:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1690498381;
	bh=nccD0Mf6wU5sbJ5COVN/p0FKMBOhmCCUxaTQs85SCqw=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=t/0s9ZMj4z70dOkGNrjMII3EjJTPEzzV5nIVm20v6HgGEhnEWJxOffzdNbfWNjjeT
	 PNLu1JgLK4zZ3zYhF4dwVNAPZPSCcxO5FsYnafndjX6muIEp98ZDRvTW1CR0oZwRSk
	 Yge5GKj2vEyQwZ0jMDa4Na2fxOnUTJYviYPFrS21NNJYEMG+uTmAoryZofn/b0c/Vw
	 F42P5sXjniepCZUWGlsRGBAvS3gqNq7XvwPKV9KeOvZCQGl4H2HaD58DoSjw5M7jrf
	 wYKo8oNwFbVUArRrwQD+X3fwQFFYXWKDw15Stv5b3Z7Rl5oqzlWSFPDZyejgjp/z7+
	 Fay54jzGP9HTA==
From: Mark Brown <broonie@kernel.org>
To: oder_chiou@realtek.com, Jiapeng Chong <jiapeng.chong@linux.alibaba.com>
Cc: lgirdwood@gmail.com, perex@perex.cz, tiwai@suse.com,
 alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
 Abaci Robot <abaci@linux.alibaba.com>
In-Reply-To: <20230727021632.88912-1-jiapeng.chong@linux.alibaba.com>
References: <20230727021632.88912-1-jiapeng.chong@linux.alibaba.com>
Subject: Re: [PATCH] ASoC: rt1017: Remove unused function
Message-Id: <169049837934.173381.10017429412134576375.b4-ty@kernel.org>
Date: Thu, 27 Jul 2023 23:52:59 +0100
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Mailer: b4 0.13-dev-099c9
Message-ID-Hash: QQMMJ6GJAUT3SXOUYKEUMQ3MH6HSL2C4
X-Message-ID-Hash: QQMMJ6GJAUT3SXOUYKEUMQ3MH6HSL2C4
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
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/QQMMJ6GJAUT3SXOUYKEUMQ3MH6HSL2C4/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

On Thu, 27 Jul 2023 10:16:32 +0800, Jiapeng Chong wrote:
> The function are defined in the rt1017-sdca-sdw.h file, but not called
> elsewhere, so delete the unused functions.
> 
> sound/soc/codecs/rt1017-sdca-sdw.h:183:33: warning: ‘rt1017_sdca_mbq_defaults’ defined but not used.
> 
> 

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/1] ASoC: rt1017: Remove unused function
      commit: 8f59c7ed230784ca914c98e250c65768b71d5de4

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

