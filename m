Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0D1D1EB64DD
	for <alsa-devel@archiver.kernel.org>; Mon, 14 Aug 2023 00:35:14 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 3CC0C74C;
	Mon, 14 Aug 2023 02:34:22 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 3CC0C74C
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1691973312;
	bh=2JpnIkFmiSfBKgqa6r7852offQiZM3dmbHPQeH8JDDc=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:List-Id:
	 List-Archive:List-Help:List-Owner:List-Post:List-Subscribe:
	 List-Unsubscribe:From;
	b=psO3n2bsd81CkhARstWr+ctKPnJet3vhjOvjuB9AWUI2B76W+f7ZeAhBUtdkty2jJ
	 BKtewhEbn9vQeu211d8Io9f1z5xXMPNo4ssUStQVaR1xRGiasveORv8ffrcJG1kGvn
	 oty0KpeGgJ0oOzTWhRKFByxWna1miOzoIxn11euQ=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id E5F1CF80567; Mon, 14 Aug 2023 02:33:32 +0200 (CEST)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id 67214F80558;
	Mon, 14 Aug 2023 02:33:32 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id CDB83F80272; Mon, 14 Aug 2023 02:33:26 +0200 (CEST)
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits))
	(No client certificate requested)
	by alsa1.perex.cz (Postfix) with ESMTPS id 78A3DF80254
	for <alsa-devel@alsa-project.org>; Mon, 14 Aug 2023 02:33:23 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 78A3DF80254
Authentication-Results: alsa1.perex.cz;
	dkim=pass (2048-bit key,
 unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20201202 header.b=Fotf87FS
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits))
	(No client certificate requested)
	by dfw.source.kernel.org (Postfix) with ESMTPS id 63B2761701;
	Mon, 14 Aug 2023 00:33:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7A83BC433C9;
	Mon, 14 Aug 2023 00:33:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1691973201;
	bh=2JpnIkFmiSfBKgqa6r7852offQiZM3dmbHPQeH8JDDc=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=Fotf87FS6jgLLKFYVGrdJp2iwRVH5WS6fDdKgadgnlbluVsG41pZ2KWlvcYKZrz9Y
	 5Mq3/wUc+uaOq/yUHuGq7+zFwrehDCR6Y4K60qnjSiW9EXTL/zfvd2k4zw7Sq3WhIY
	 LAcuIwLiplhUPn9+Pvv6gMz2INnbT/3UjziYpdnQEACBUBfy2WPCruCIVrkxo96K6A
	 o3p7Gg6t0dfXTi8yxCyH0rEBwGUVuBK0EQfqob1i7qWd48LxyYcoazCdGgytGcgFJn
	 nPSX7krf8l/Sgc1uwlXHTT90R5/3Mjd5qbTbXhFvNzNNZx8zrRLEWr5frUHTHjTEV0
	 vtBCHojZHBQuA==
From: Mark Brown <broonie@kernel.org>
To: lgirdwood@gmail.com, shumingf@realtek.com
Cc: alsa-devel@alsa-project.org, lars@metafoo.de, flove@realtek.com,
 oder_chiou@realtek.com, jack.yu@realtek.com, derek.fang@realtek.com,
 pierre-louis.bossart@intel.com, jfmiranda@gmail.com
In-Reply-To: <20230811093822.37573-1-shumingf@realtek.com>
References: <20230811093822.37573-1-shumingf@realtek.com>
Subject: Re: [PATCH] ASoC: rt1308-sdw: fix random louder sound
Message-Id: <169197319921.2741913.6888710556689341849.b4-ty@kernel.org>
Date: Mon, 14 Aug 2023 01:33:19 +0100
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.13-dev-099c9
Message-ID-Hash: RO5UZEYG6KPTZ5F47CDSTOQBEGOVFIVF
X-Message-ID-Hash: RO5UZEYG6KPTZ5F47CDSTOQBEGOVFIVF
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
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/RO5UZEYG6KPTZ5F47CDSTOQBEGOVFIVF/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

On Fri, 11 Aug 2023 17:38:22 +0800, shumingf@realtek.com wrote:
> This patch uses a vendor register to check whether the system hibernated ever.
> The driver will only set the preset when the driver brings up or the system hibernated.
> It will avoid the unknown issue that makes the speaker output louder and can't control the volume.
> 
> 

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/1] ASoC: rt1308-sdw: fix random louder sound
      commit: 37aba3190891d4de189bd5192ee95220e295f34d

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

