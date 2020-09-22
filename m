Return-Path: <SRS0=PysP=C7=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8481EC2D0E2
	for <alsa-devel@archiver.kernel.org>; Tue, 22 Sep 2020 11:50:44 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A2E0523600
	for <alsa-devel@archiver.kernel.org>; Tue, 22 Sep 2020 11:50:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="WJ04rNgF";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="Q0kzW0fq"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A2E0523600
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id DE20D16F9;
	Tue, 22 Sep 2020 13:49:50 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz DE20D16F9
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1600775440;
	bh=Q4KDNQJE+iH1DnDYsmw0dPu90gd1omWDNMB3ZeVjjGg=;
	h=Date:From:To:In-Reply-To:References:Subject:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=WJ04rNgF5qNi/7yw6ZT3pMoVHV/Dc3ytHYLcD+oDJ/BkBAW9q7s51VSJaaUnFmm7i
	 zQJaNRTdOETdQ56MWOO0e9eLgedmlDq07vgAJMkBSjsBi+PpkJsHeMke+Z+p21ekn8
	 yom58OCJpuFQdlfVVRpQu/EXKvlm89ZAGCBcQvUw=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 5F027F800ED;
	Tue, 22 Sep 2020 13:49:50 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id DFCF5F80229; Tue, 22 Sep 2020 13:49:45 +0200 (CEST)
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 865DBF800ED
 for <alsa-devel@alsa-project.org>; Tue, 22 Sep 2020 13:49:39 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 865DBF800ED
Authentication-Results: alsa1.perex.cz;
 dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org
 header.b="Q0kzW0fq"
Received: from localhost (fw-tnat.cambridge.arm.com [217.140.96.140])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id BC07A221EB;
 Tue, 22 Sep 2020 11:49:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1600775377;
 bh=Q4KDNQJE+iH1DnDYsmw0dPu90gd1omWDNMB3ZeVjjGg=;
 h=Date:From:To:Cc:In-Reply-To:References:Subject:From;
 b=Q0kzW0fqgH/ZynkmIIsZ+Sk3TIZn1d1t5vPwcPmXgKloPcyO+FEfgbJPD2ON45Hz8
 OOhutiHnFCkdlS2Oq5dnBkZlt3W7mf2vS5wJL9kS7AQvzZ8+wJETBuTKgGLs+1yuJc
 NnwNw6eHuWv6vW9+hMhEnlq2sqh22UhUiTpgzLzI=
Date: Tue, 22 Sep 2020 12:48:44 +0100
From: Mark Brown <broonie@kernel.org>
To: Cheng-Yi Chiang <cychiang@chromium.org>, linux-kernel@vger.kernel.org
In-Reply-To: <20200922062316.1172935-1-cychiang@chromium.org>
References: <20200922062316.1172935-1-cychiang@chromium.org>
Subject: Re: [PATCH] ASoC: hdmi-codec: Use set_jack ops to set jack
Message-Id: <160077532459.10007.8996932486569302078.b4-ty@kernel.org>
Cc: dianders@chromium.org, alsa-devel@alsa-project.org, tzungbi@chromium.org,
 Srinivasa Rao <srivasam@codeaurora.org>, Heiko Stuebner <heiko@sntech.de>,
 linux-rockchip@lists.infradead.org, Liam Girdwood <lgirdwood@gmail.com>,
 Takashi Iwai <tiwai@suse.com>, Tzung-Bi Shih <tzungbi@google.com>,
 Rob Herring <robh+dt@kernel.org>, Rohit kumar <rohitkr@codeaurora.org>,
 Matthias Brugger <matthias.bgg@gmail.com>, linux-mediatek@lists.infradead.org,
 dgreid@chromium.org, linux-arm-kernel@lists.infradead.org
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

On Tue, 22 Sep 2020 14:23:16 +0800, Cheng-Yi Chiang wrote:
> Use set_jack ops to set jack so machine drivers do not need to include
> hdmi-codec.h explicitly.

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/1] ASoC: hdmi-codec: Use set_jack ops to set jack
      commit: 55c5cc63ab3277aa20637dc20f6528987ac23743

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
