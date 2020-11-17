Return-Path: <SRS0=TkwG=EX=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1FA08C63697
	for <alsa-devel@archiver.kernel.org>; Tue, 17 Nov 2020 22:39:57 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EF73320709
	for <alsa-devel@archiver.kernel.org>; Tue, 17 Nov 2020 22:39:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="VLLA2Tvm";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="RxRKJK3y"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EF73320709
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 6C0BE17BF;
	Tue, 17 Nov 2020 23:39:04 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 6C0BE17BF
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1605652794;
	bh=RcLKHkW3XsWqdPM91oIiy4VtLboMA/41WJfQchqi9x0=;
	h=Date:From:To:In-Reply-To:References:Subject:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=VLLA2TvmyWhYCwuDzZlcOFIeM8BD9G0fz0wYdkBFACckB+0OxWikNbiVQX1PPIgpb
	 rESLduofW+WCBXOcorztt1uwDK76Sbh7I81hmQu7Op1DODViwRFmOjBV3HTEf9q8Bb
	 7svtx6z1+7cRzDW/Q6ogDq9/jiEErjIvC6slf4e8=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id DDC8BF802A9;
	Tue, 17 Nov 2020 23:38:15 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 2F98BF804B1; Tue, 17 Nov 2020 23:38:13 +0100 (CET)
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 586D3F800FE
 for <alsa-devel@alsa-project.org>; Tue, 17 Nov 2020 23:38:11 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 586D3F800FE
Authentication-Results: alsa1.perex.cz;
 dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org
 header.b="RxRKJK3y"
Received: from localhost (fw-tnat.cambridge.arm.com [217.140.96.140])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id D817B21D7E;
 Tue, 17 Nov 2020 22:38:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1605652689;
 bh=RcLKHkW3XsWqdPM91oIiy4VtLboMA/41WJfQchqi9x0=;
 h=Date:From:To:Cc:In-Reply-To:References:Subject:From;
 b=RxRKJK3yjB1dsp1gwjslCASMai/Zic10iw+5JAJGi0cu9ymWMHBavzkCpe8mrbH0K
 iXNOjC7+iq+muHrgyjz7MfUPPhVPbcsoKJUykxee56Hkbma5wDKFlG7UC8yZF/ZgAd
 CnsiAAOvIHVBS+X8p39BuDHepBL5woFhjP0Gxwew=
Date: Tue, 17 Nov 2020 22:37:49 +0000
From: Mark Brown <broonie@kernel.org>
To: alsa-devel@alsa-project.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org,
 Alexandru Ardelean <alexandru.ardelean@analog.com>
In-Reply-To: <20201110084754.46756-1-alexandru.ardelean@analog.com>
References: <20201106102052.32582-1-alexandru.ardelean@analog.com>
 <20201110084754.46756-1-alexandru.ardelean@analog.com>
Subject: Re: [PATCH v2] dt-bindings: adau1977: convert text binding to yaml
 format
Message-Id: <160565265702.23689.9722907741077657192.b4-ty@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Cc: robh+dt@kernel.org, lgirdwood@gmail.com, lars@metafoo.de
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

On Tue, 10 Nov 2020 10:47:54 +0200, Alexandru Ardelean wrote:
> This change converts the old device-tree binding for ADAU1977 from text
> format to the new yaml format.

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/1] ASoC: adau1977: convert text binding to yaml format
      commit: f077770b2675feb2ea2188ef7109d5a41545e7a9

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
