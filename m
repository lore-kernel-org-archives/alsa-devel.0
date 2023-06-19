Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4A08AEB64DA
	for <alsa-devel@archiver.kernel.org>; Mon, 19 Jun 2023 22:31:29 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id D8BE286F;
	Tue, 20 Jun 2023 00:30:36 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz D8BE286F
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1687213886;
	bh=7FENT0fR9g/IHtG2MyCKYjPXZXSY5zPJGkenGVwXz+Y=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:List-Id:
	 List-Archive:List-Help:List-Owner:List-Post:List-Subscribe:
	 List-Unsubscribe:From;
	b=i/uuz5IqMUbXgVOG/OcL8eOgUKcWBgSRenNphn6UMyuVfZSFaEbCxEpqeLWQc6HpG
	 S1rrC0SV6dUeQjEGEYZoIYlnPP1VT5p3tfMyaOEo1RbAwnwRjHHP5psDViSk3CU6Of
	 Mak/WEG0KDvTWCHR0Psgyn8/YdGj3pqNBRzlbQbA=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 5E65FF80579; Tue, 20 Jun 2023 00:29:34 +0200 (CEST)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id E7C17F8057B;
	Tue, 20 Jun 2023 00:29:31 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 4643DF80169; Tue, 20 Jun 2023 00:29:21 +0200 (CEST)
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits))
	(No client certificate requested)
	by alsa1.perex.cz (Postfix) with ESMTPS id B70EFF80141
	for <alsa-devel@alsa-project.org>; Tue, 20 Jun 2023 00:29:13 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz B70EFF80141
Authentication-Results: alsa1.perex.cz;
	dkim=pass (2048-bit key,
 unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20201202 header.b=ZqiVl1cR
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits))
	(No client certificate requested)
	by dfw.source.kernel.org (Postfix) with ESMTPS id 5B51960F21;
	Mon, 19 Jun 2023 22:29:12 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5CAB6C433C8;
	Mon, 19 Jun 2023 22:29:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1687213751;
	bh=7FENT0fR9g/IHtG2MyCKYjPXZXSY5zPJGkenGVwXz+Y=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=ZqiVl1cRjY0IQLWbUGh5Xv1/mvoE3MtEMY7NPT9hqwUNg9teIML4fUlFY2nEoReTE
	 4a6GNmPWf7ZdRZM2qGIqPqyQ3m1Y4VHMCx95bxl7h4cAFL4wtsjrB5cvHfQ13OIFVW
	 lCw2tfDiH8O7tGXVNohBs0eM3AE9RKO82Cfyz7i1l6mYU9S4IM+W3mefmBdC30bD2L
	 bvJOAbhnFayYUgKlMxkmpeTz/mSwqgB3SP58cUeFzntIQo6Qej+sU+GK7xOOO5GOPf
	 K6eKOhq0eOFpHMlOdNdZrsWX1gEC/TbzhpBUH/ymvwcJvUI23REYiUsnwNIfYGzhTS
	 qUy/zGSQje0aw==
From: Mark Brown <broonie@kernel.org>
To: Yingkun Meng <mengyingkun@loongson.cn>,
 Dan Carpenter <dan.carpenter@linaro.org>
Cc: Liam Girdwood <lgirdwood@gmail.com>, Jaroslav Kysela <perex@perex.cz>,
 Takashi Iwai <tiwai@suse.com>, alsa-devel@alsa-project.org,
 kernel-janitors@vger.kernel.org
In-Reply-To: <fb14815d-2f9a-4b42-b193-cec61e7417ca@moroto.mountain>
References: <fb14815d-2f9a-4b42-b193-cec61e7417ca@moroto.mountain>
Subject: Re: [PATCH] ASoC: loongson: fix error codes in
 loongson_card_parse_acpi()
Message-Id: <168721375010.200161.14528592449735607386.b4-ty@kernel.org>
Date: Mon, 19 Jun 2023 23:29:10 +0100
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.13-dev-c6835
Message-ID-Hash: KMOTMYJ3JSGC6MSA2CS5EV4BBAHVD6JR
X-Message-ID-Hash: KMOTMYJ3JSGC6MSA2CS5EV4BBAHVD6JR
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
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/KMOTMYJ3JSGC6MSA2CS5EV4BBAHVD6JR/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

On Mon, 19 Jun 2023 12:46:21 +0300, Dan Carpenter wrote:
> The acpi_node_get_property_reference() function returns kernel error
> codes and not ACPI error codes.  So, although it does not affect the
> compiled code, using the ACPI_FAILURE() macro is wrong.  Secondly,
> if the is_acpi_device_node() function returns false, then we should
> return -ENOENT instead of returning success.
> 
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/1] ASoC: loongson: fix error codes in loongson_card_parse_acpi()
      commit: 8fba13f02c85b90deeba65a398f55d4b43a79595

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

