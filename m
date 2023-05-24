Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1329BC77B73
	for <alsa-devel@archiver.kernel.org>; Wed, 24 May 2023 12:00:33 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 165B8828;
	Wed, 24 May 2023 13:59:42 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 165B8828
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1684929632;
	bh=UMiHL7ethwa+018lGBl2r8MGW4Lj2YlyfJiTZIjuQVk=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:List-Id:
	 List-Archive:List-Help:List-Owner:List-Post:List-Subscribe:
	 List-Unsubscribe:From;
	b=EZGtTVh7U2ZW79GB6AkFo2W7HK436WKYF9LjPlejUsJ6vXFYbWS7IfdOeVJs0/Wfr
	 C2k9Dnp22d1FNMErAO1kzBgYuphmKNmL4A8MvzxDMs4TiLP2npmH3IbFjROKFytAsJ
	 boxrtGBl79KZgEEAREeZVPYXq77uFJ3ZmW3STI0E=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id A4DF6F80563; Wed, 24 May 2023 13:58:51 +0200 (CEST)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id 18A79F80425;
	Wed, 24 May 2023 13:58:51 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id EA01FF8024E; Wed, 24 May 2023 13:58:47 +0200 (CEST)
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa1.perex.cz (Postfix) with ESMTPS id 1E751F8016A
	for <alsa-devel@alsa-project.org>; Wed, 24 May 2023 13:58:43 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 1E751F8016A
Authentication-Results: alsa1.perex.cz;
	dkim=pass (2048-bit key,
 unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20201202 header.b=O5mHpTzt
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.source.kernel.org (Postfix) with ESMTPS id AC60C63200;
	Wed, 24 May 2023 11:58:42 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AE6BEC4339C;
	Wed, 24 May 2023 11:58:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1684929522;
	bh=UMiHL7ethwa+018lGBl2r8MGW4Lj2YlyfJiTZIjuQVk=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=O5mHpTzthzLsO1nX1RVg8URiT3Q4rvVlypW+BB2EbR+YMZZb21twVFEs3RLysTiXg
	 C/Tjba7bl/AohPlk2PYE16mrg8HTXO/fvOHXEnDIZmy4JUPlCHJykZSlu4gG/qdFK/
	 Xbf1RXA+0D8xmiRYDDSAL2Qm9rvvKpMw0Firp3WBFRll1YGDDWj4TvqHL1gNDrRU5W
	 NSU+2xfupwMNlruwnXdsWRU5q1ceHdr5uO1uaWKQ+Q/nxU2dMryLUkGjxEbRhvFpUO
	 2SjD04QvlDT7h/AMm5iS9tWNSs2Up6WvwxV143q6CXAkFTMv5/mCay90lJ8oXAl/CP
	 HaSoaj8zGt2xA==
From: Mark Brown <broonie@kernel.org>
To: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Cc: gregkh@linuxfoundation.org, rafael@kernel.org,
 ckeepax@opensource.cirrus.com, tanureal@opensource.cirrus.com,
 linux-kernel@vger.kernel.org, alsa-devel@alsa-project.org
In-Reply-To: <20230523154747.5429-1-srinivas.kandagatla@linaro.org>
References: <20230523154747.5429-1-srinivas.kandagatla@linaro.org>
Subject: Re: [PATCH] regmap: sdw: check for invalid multi-register writes
 config
Message-Id: <168492952043.55912.13195955442624432460.b4-ty@kernel.org>
Date: Wed, 24 May 2023 12:58:40 +0100
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.13-dev-bfdf5
Message-ID-Hash: 624SBH6KY6TN2236CY336LN4OBNLNPHK
X-Message-ID-Hash: 624SBH6KY6TN2236CY336LN4OBNLNPHK
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
Archived-At: <>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

On Tue, 23 May 2023 16:47:47 +0100, Srinivas Kandagatla wrote:
> SoundWire code as it is only supports Bulk register writes and
> it does not support multi-register writes.
> 
> Any drivers that set can_multi_write and use regmap_multi_reg_write() will
> easily endup with programming the hardware incorrectly without any errors.
> 
> So, add this check in bus code to be able to validate the drivers config.
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/regmap.git for-next

Thanks!

[1/1] regmap: sdw: check for invalid multi-register writes config
      commit: 95856d1f3c223c015780fffb8373a827fc4efd2e

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

