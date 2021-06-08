Return-Path: <SRS0=yD/C=LC=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.2 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 64BF9C48BCD
	for <alsa-devel@archiver.kernel.org>; Tue,  8 Jun 2021 16:09:05 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AB9726120F
	for <alsa-devel@archiver.kernel.org>; Tue,  8 Jun 2021 16:09:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AB9726120F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 54460176B;
	Tue,  8 Jun 2021 18:08:13 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 54460176B
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1623168543;
	bh=IE90yMmSiIO5UaTrZFRNwPp96wF1YEO0nCwugAP0epY=;
	h=From:To:Subject:Date:In-Reply-To:References:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=rz62TStuBHMIk8STv+GWebU7EI6VU3i0nv0kGFn6F38ivfesZaG7z0walj+7vjs3/
	 q9BC3TnvE96WnesOWt6S+gwi/+2FYyZ8KRQ4qTN8eSKegt2z6HClF/dfM/JC5PZFOW
	 tllRme4E3X8h5iVtdLhG2aioXRF4vxAYUy+bnuhQ=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 3BEA5F804B2;
	Tue,  8 Jun 2021 18:07:20 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 21E91F801EC; Tue,  8 Jun 2021 18:07:17 +0200 (CEST)
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id C2250F80116
 for <alsa-devel@alsa-project.org>; Tue,  8 Jun 2021 18:07:10 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz C2250F80116
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org
 header.b="fqPMKPPe"
Received: by mail.kernel.org (Postfix) with ESMTPSA id 167526128E;
 Tue,  8 Jun 2021 16:07:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1623168428;
 bh=IE90yMmSiIO5UaTrZFRNwPp96wF1YEO0nCwugAP0epY=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=fqPMKPPeW/P0hexZl0gL22JgSpzyOrJNl8xzuPKwFmToc9DLOE33WmVJPFqhJc25O
 K9z3lZWgMkmlWH/BzWmKg1E1lf1NHJwglEwGs4Kq2QXEc77ZDmSpPRR839jf8LDhF2
 /pp/adr2F8HEg2fYuTimT/q33IKUaAqeXCyh//7mcwhzO4MHVU99Fw3L6KQmxu8f5k
 HS+9zMdEYNj4o3cBVfrVRi8Ew1ICl5U+FFl5lRKqvmOu3GAhVhFSrFV1pXp5ufg/fW
 lyXRWhGISncdQvDACKpgrr8xk8suG76qPaG9nvsaBHDDcXgMZ/1zHUSn8nrNF47PXj
 Y2EKMbHcTBKwg==
From: Mark Brown <broonie@kernel.org>
To: Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>,
 Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
 linux-kernel@vger.kernel.org, Banajit Goswami <bgoswami@codeaurora.org>,
 Liam Girdwood <lgirdwood@gmail.com>, Wan Jiabing <wanjiabing@vivo.com>,
 alsa-devel@alsa-project.org
Subject: Re: [PATCH] ASoC: remove unneeded semicolons in wcd934x.c
Date: Tue,  8 Jun 2021 17:06:36 +0100
Message-Id: <162316808975.49749.566650719258018902.b4-ty@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20210608030656.24052-1-wanjiabing@vivo.com>
References: <20210608030656.24052-1-wanjiabing@vivo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Cc: Mark Brown <broonie@kernel.org>
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

On Tue, 8 Jun 2021 11:06:55 +0800, Wan Jiabing wrote:
> Fix following coccicheck warning:
> ./sound/soc/codecs/wcd934x.c:5136:2-3: Unneeded semicolon
> ./sound/soc/codecs/wcd934x.c:2466:2-3: Unneeded semicolon
> ./sound/soc/codecs/wcd934x.c:2527:2-3: Unneeded semicolon

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/1] ASoC: remove unneeded semicolons in wcd934x.c
      commit: 3ea8a7459861def90bbb184396651d47a4cf4f20

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
