Return-Path: <SRS0=ZHdS=DI=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C1657C4727E
	for <alsa-devel@archiver.kernel.org>; Thu,  1 Oct 2020 22:52:24 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E87172074B
	for <alsa-devel@archiver.kernel.org>; Thu,  1 Oct 2020 22:52:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="C7cnKMjB";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="I0UhHf1/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E87172074B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 66EB81AED;
	Fri,  2 Oct 2020 00:51:32 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 66EB81AED
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1601592742;
	bh=dgOc7PzkS9dX0GvioWzqzTEvNibcFB20VrGfE/OrTRc=;
	h=Date:From:To:In-Reply-To:References:Subject:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=C7cnKMjB4yOuX/vQuYuCUxr8bgL9iFXzLv9EQRR7N4YdHJBQz2qDPNfK2FT6D1/Aj
	 Ctokr1hzgz2OHLmjFLAoxfKFJjemV0CB9xJDKbWlkgyRfgDfwWJrzv/2VBPlqmdTNl
	 8r/beAQPgSGVQWURnE1183P0TS25wpYLpH1m2mUw=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 4ED84F802FD;
	Fri,  2 Oct 2020 00:47:56 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 09AB5F802FE; Fri,  2 Oct 2020 00:47:54 +0200 (CEST)
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 6089BF802EC
 for <alsa-devel@alsa-project.org>; Fri,  2 Oct 2020 00:47:51 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 6089BF802EC
Authentication-Results: alsa1.perex.cz;
 dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org
 header.b="I0UhHf1/"
Received: from localhost (fw-tnat.cambridge.arm.com [217.140.96.140])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id 1808120754;
 Thu,  1 Oct 2020 22:47:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1601592469;
 bh=dgOc7PzkS9dX0GvioWzqzTEvNibcFB20VrGfE/OrTRc=;
 h=Date:From:To:Cc:In-Reply-To:References:Subject:From;
 b=I0UhHf1/EEu41m0bagSshbbuYJCNcGfX9njUCUn6rJWKBBT9pwc0FPAKVK3pIflnp
 TS0rrRkVPHF8UE556VyO/Al3BasgRON1mQpme3kE3CmDI6L0VusmW/gnnvZp9SRySG
 /y/EsxFrPbgOOaFki3noODayaYq1VANex4yH86BU=
Date: Thu, 01 Oct 2020 23:46:50 +0100
From: Mark Brown <broonie@kernel.org>
To: Liam Girdwood <lgirdwood@gmail.com>,
 Qinglang Miao <miaoqinglang@huawei.com>,
 Jonathan Hunter <jonathanh@nvidia.com>, Takashi Iwai <tiwai@suse.com>,
 Jaroslav Kysela <perex@perex.cz>, Thierry Reding <thierry.reding@gmail.com>
In-Reply-To: <20200929112939.47661-1-miaoqinglang@huawei.com>
References: <20200929112939.47661-1-miaoqinglang@huawei.com>
Subject: Re: [PATCH -next] ASoC: tegra: trimslice.c: use
 devm_snd_soc_register_card()
Message-Id: <160159237544.44588.10343139613050328062.b4-ty@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Cc: linux-tegra@vger.kernel.org, alsa-devel@alsa-project.org,
 linux-kernel@vger.kernel.org
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

On Tue, 29 Sep 2020 19:29:39 +0800, Qinglang Miao wrote:
> Using devm_snd_soc_register_card() can make the code
> shorter and cleaner.

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/1] ASoC: tegra: trimslice.c: use devm_snd_soc_register_card()
      commit: 27f41dfebf226c74691b4b30527459417b6510e8

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
