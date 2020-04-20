Return-Path: <SRS0=3aoS=6E=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A4220C3815B
	for <alsa-devel@archiver.kernel.org>; Mon, 20 Apr 2020 14:30:57 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 294C120775
	for <alsa-devel@archiver.kernel.org>; Mon, 20 Apr 2020 14:30:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="BLOZCv4H";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="dc9gBCaH"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 294C120775
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 8C7FD16A1;
	Mon, 20 Apr 2020 16:30:05 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 8C7FD16A1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1587393055;
	bh=ac2OWWBXr53L9YPDwHbJzkfcGUHqONQngqqS3KBJ9c4=;
	h=Date:From:To:In-Reply-To:References:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=BLOZCv4HTQnc7BJB3W/vdsy0g+2E6wVMaZjMbqa+vECxTO0AWOckJkgS4ozld8Kqu
	 s8W636J/5374PyzfMFan2G84XKrKn9diIAlqPfgoRe65ggrBwWVh/d3Y/4i5b/Xvfk
	 7g+dUE+k3QF/4GGvqjLK2Hb0d+3h64EagGfoHQfA=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id D89A5F802A7;
	Mon, 20 Apr 2020 16:27:49 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 9EF3AF802A8; Mon, 20 Apr 2020 16:27:48 +0200 (CEST)
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 8221FF8029A
 for <alsa-devel@alsa-project.org>; Mon, 20 Apr 2020 16:27:45 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 8221FF8029A
Authentication-Results: alsa1.perex.cz;
 dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org
 header.b="dc9gBCaH"
Received: from localhost (fw-tnat.cambridge.arm.com [217.140.96.140])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id 7772E20857;
 Mon, 20 Apr 2020 14:27:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1587392864;
 bh=ac2OWWBXr53L9YPDwHbJzkfcGUHqONQngqqS3KBJ9c4=;
 h=Date:From:To:Cc:In-Reply-To:References:Subject:From;
 b=dc9gBCaHLppl0lmTl0FUd0mpoZ+mCwdv5If1wx36/CY6OYatqWHnHzjp7AGCe0ZC6
 IdX6hFxgFvrL0hTzILU3XhyMgDGS7eV7x1CSVjmE6aHLqMotG3YLBqWvg/5N/jd3Z4
 V3OkQRSL9jR6QUKQucJHQbDaerx4bDIcMdXSLNuU=
Date: Mon, 20 Apr 2020 15:27:41 +0100
From: Mark Brown <broonie@kernel.org>
To: tiwai@suse.com, linux-kernel@vger.kernel.org,
 Jason Yan <yanaijie@huawei.com>, alsa-devel@alsa-project.org,
 lgirdwood@gmail.com, srinivas.kandagatla@linaro.org, perex@perex.cz
In-Reply-To: <20200420042911.19379-1-yanaijie@huawei.com>
References: <20200420042911.19379-1-yanaijie@huawei.com>
Subject: Re: [PATCH] ASoC: wcd934x: remove unneeded semicolon
Message-Id: <158739283776.7647.11335076851233885002.b4-ty@kernel.org>
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

On Mon, 20 Apr 2020 12:29:11 +0800, Jason Yan wrote:
> Fix the following coccicheck warning:
> 
> sound/soc/codecs/wcd934x.c:3621:2-3: Unneeded semicolon
> sound/soc/codecs/wcd934x.c:4270:2-3: Unneeded semicolon
> sound/soc/codecs/wcd934x.c:4018:2-3: Unneeded semicolon
> sound/soc/codecs/wcd934x.c:4043:2-3: Unneeded semicolon
> sound/soc/codecs/wcd934x.c:3804:2-3: Unneeded semicolon
> sound/soc/codecs/wcd934x.c:3866:2-3: Unneeded semicolon
> sound/soc/codecs/wcd934x.c:3596:2-3: Unneeded semicolon
> sound/soc/codecs/wcd934x.c:3542:2-3: Unneeded semicolon
> sound/soc/codecs/wcd934x.c:3673:2-3: Unneeded semicolon
> sound/soc/codecs/wcd934x.c:3723:2-3: Unneeded semicolon
> sound/soc/codecs/wcd934x.c:2492:2-3: Unneeded semicolon
> sound/soc/codecs/wcd934x.c:1790:3-4: Unneeded semicolon
> sound/soc/codecs/wcd934x.c:1806:3-4: Unneeded semicolon
> sound/soc/codecs/wcd934x.c:1812:2-3: Unneeded semicolon
> 
> [...]

Applied to

	https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-5.7

Thanks!

[1/1] ASoC: wcd934x: remove unneeded semicolon
      commit: b40efd0f254356556443355bc87c9a5e6e3d9dee

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
