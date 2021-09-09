Return-Path: <SRS0=Rqaf=N7=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4E8F8C433F5
	for <alsa-devel@archiver.kernel.org>; Thu,  9 Sep 2021 15:41:11 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 97AF86023D
	for <alsa-devel@archiver.kernel.org>; Thu,  9 Sep 2021 15:41:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 97AF86023D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 3C712836;
	Thu,  9 Sep 2021 17:40:19 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 3C712836
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1631202069;
	bh=T/mw/UbjbrrOlnUVot7WIwHPaeG3mY6jLafZbnQXNto=;
	h=From:To:Subject:Date:In-Reply-To:References:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=qtLR86wl8qPs5fuNofzq5q/QooBfHD2bdg/yD9U4390jkB8aPogIgN0QekhLxuPWs
	 YRNvyc2Xoi7sLQtaMCMQHunGf3DjARihM7I2B6Ae2NSGeaM/W/W0/OANJEzNB2ERto
	 j1SALwNy7SJXXonlzs8W0TQGvgksx1BIMb3LomuY=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 01CEAF800C7;
	Thu,  9 Sep 2021 17:39:40 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id AA0A2F80224; Thu,  9 Sep 2021 17:39:38 +0200 (CEST)
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 458F1F80224
 for <alsa-devel@alsa-project.org>; Thu,  9 Sep 2021 17:39:35 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 458F1F80224
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org
 header.b="i8P0a3DY"
Received: by mail.kernel.org (Postfix) with ESMTPSA id 3BD1C61101;
 Thu,  9 Sep 2021 15:39:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1631201973;
 bh=T/mw/UbjbrrOlnUVot7WIwHPaeG3mY6jLafZbnQXNto=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=i8P0a3DYUqvolCsgpd39ALimrV04sYugsuGLc5z5sEQyVPkWyJFfAxH7cg9M1R2z5
 R/MKKdhX6Q7jDQZ7CZI/XES508M3xPOjd2XQuoSAilrOegH5H66zULlkHCLu0SFYJG
 DjLdUAQ8UPe5bXX2KeP3Q/qK0WC46Mb32vGS7fSBdcLt8MKvNiLCHRgEHg7CVBrlvH
 GiwtibH8jKOviM/abCb6w4QW1kXZRdpuONi+172Esj+bnZTO6ogtN+SF/yEYr0zjl/
 yGOvVIO5gTOh4eNh5pILwXnsMvc6/jxgChwt9ygrGCtKOrIw9u1L95SbNUDk9qtME7
 iUj+hTgHtlBTA==
From: Mark Brown <broonie@kernel.org>
To: Arnaud Pouliquen <arnaud.pouliquen@foss.st.com>,
 Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
Subject: Re: [PATCH] MAINTAINERS: fix update references to stm32 audio bindings
Date: Thu,  9 Sep 2021 16:38:51 +0100
Message-Id: <163120168200.50116.15964820004324884962.b4-ty@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20210909145449.24388-1-arnaud.pouliquen@foss.st.com>
References: <20210909145449.24388-1-arnaud.pouliquen@foss.st.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Cc: alsa-devel@alsa-project.org, Mark Brown <broonie@kernel.org>,
 linux-stm32@st-md-mailman.stormreply.com, linux-kernel@vger.kernel.org
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

On Thu, 9 Sep 2021 16:54:49 +0200, Arnaud Pouliquen wrote:
> The 00d38fd8d2524 ("MAINTAINERS: update references to stm32 audio bindings")
> commit update the bindings reference, by
> removing bindings/sound/st,stm32-adfsdm.txt, to set the
> new reference to bindings/iio/adc/st,stm32-*.yaml.
> 
> This leads to "get_maintainer finds" the match for the
> Documentation/devicetree/bindings/iio/adc/st,stm32-dfsdm-adc.yaml,
> but also to the IIO bindings
> Documentation/devicetree/bindings/iio/adc/st,stm32-adc.yaml
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/1] MAINTAINERS: fix update references to stm32 audio bindings
      commit: 26be23af1866eead5a29f8501f9d774ac277d0bd

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
