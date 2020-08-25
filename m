Return-Path: <SRS0=+Hcd=CD=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5B699C433DF
	for <alsa-devel@archiver.kernel.org>; Tue, 25 Aug 2020 20:26:16 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C537E20665
	for <alsa-devel@archiver.kernel.org>; Tue, 25 Aug 2020 20:26:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="EOm/9GB5";
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="sMxX8Q8P"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C537E20665
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 520FB16F4;
	Tue, 25 Aug 2020 22:25:24 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 520FB16F4
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1598387174;
	bh=olxuYwvUisJl7u7cXkvg1W6hA+A5C56u6qCVWX5oAZ8=;
	h=Date:From:To:In-Reply-To:References:Subject:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=EOm/9GB5CKd2+/3YUuQka94IDgJK4MqPDpzxyGetOfGv3/0RKlWM3OtNv4CyuLaO7
	 SZHSU9W6QOvf6lryyCxL/+ZW7LORbBW5AuTujqTsRnxpPmRc/wMT0hyDNfuiR5Pbm6
	 GLJAuKIQc+T5KWkOKab56OBQTzNMVHV3IUjqBvJg=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 31CA4F802E7;
	Tue, 25 Aug 2020 22:20:08 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 79670F802C4; Tue, 25 Aug 2020 22:20:03 +0200 (CEST)
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 2B063F802C2
 for <alsa-devel@alsa-project.org>; Tue, 25 Aug 2020 22:20:00 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 2B063F802C2
Authentication-Results: alsa1.perex.cz;
 dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org
 header.b="sMxX8Q8P"
Received: from localhost (fw-tnat.cambridge.arm.com [217.140.96.140])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id 3AC4E2074D;
 Tue, 25 Aug 2020 20:19:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1598386798;
 bh=olxuYwvUisJl7u7cXkvg1W6hA+A5C56u6qCVWX5oAZ8=;
 h=Date:From:To:Cc:In-Reply-To:References:Subject:From;
 b=sMxX8Q8PWIcR7ZohUGwIE6jvCQdI6S6R5tPTrKuXC2BOxUf8Fdhv6XkK8hIQzVvse
 dRvfcK2x9Zhnp9ZU/m0i0jyEPGulwd+S2mPuUnz/0uLerH0x5WRrvtR38c6TIJd46l
 NcMgIQX5NX6YAXpax4WvYtep81eXAvsO6VE2rZFs=
Date: Tue, 25 Aug 2020 21:19:23 +0100
From: Mark Brown <broonie@kernel.org>
To: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
In-Reply-To: <87blizy5ts.wl-kuninori.morimoto.gx@renesas.com>
References: <87blizy5ts.wl-kuninori.morimoto.gx@renesas.com>
Subject: Re: [PATCH] ASoC: ti: fixup ams_delta_mute() function name
Message-Id: <159838674787.41542.10749253876222247416.b4-ty@kernel.org>
Cc: Linux-ALSA <alsa-devel@alsa-project.org>
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

On 25 Aug 2020 08:38:54 +0900, Kuninori Morimoto wrote:
> commit 059374fe9ea5d ("ASoC: ti: merge .digital_mute() into .mute_stream()")
> merged .digital_mute() into .mute_stream().
> But it didn't rename ams_delta_digital_mute() to ams_delta_mute().
> This patch fixup it.

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/1] ASoC: ti: fixup ams_delta_mute() function name
      commit: d062085d61b1c2015845d1d9c475266381cce785

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
