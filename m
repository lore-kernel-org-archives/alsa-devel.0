Return-Path: <SRS0=mFEw=MZ=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A4D2AC432BE
	for <alsa-devel@archiver.kernel.org>; Mon,  2 Aug 2021 20:46:26 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D73C860F41
	for <alsa-devel@archiver.kernel.org>; Mon,  2 Aug 2021 20:46:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org D73C860F41
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 73BEF172F;
	Mon,  2 Aug 2021 22:45:34 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 73BEF172F
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1627937184;
	bh=Jtdbyw1KtfZCbl5QABW1yDpMjvPPKCrXpdVs6/siGp4=;
	h=From:To:Subject:Date:In-Reply-To:References:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=t9iwox13GRruoaYMc7lvY3ENqIsrhnFka4RyN2O4RGYzHSvUcrWZo6S/wv3hWv0qB
	 zMiKLk/SLLoegDEZ4FgjR1iqkXV2V9bY0+vLHxHTIsq7uNfakL/uyxPcg/zV/JsSwh
	 FeRu5WejfTsUfMirpIJddkpSE/7s+G+9C5w1trnI=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id D30A7F804E1;
	Mon,  2 Aug 2021 22:44:40 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 0DDF3F80279; Mon,  2 Aug 2021 22:44:39 +0200 (CEST)
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id B5DF8F800BF
 for <alsa-devel@alsa-project.org>; Mon,  2 Aug 2021 22:44:34 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz B5DF8F800BF
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org
 header.b="i6GO5xdG"
Received: by mail.kernel.org (Postfix) with ESMTPSA id D92FF60F93;
 Mon,  2 Aug 2021 20:44:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1627937072;
 bh=Jtdbyw1KtfZCbl5QABW1yDpMjvPPKCrXpdVs6/siGp4=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=i6GO5xdG7FdvsjacXaTTLv1vh9cr04K3iTE1lLTT7ZFDwsSelwsSg6Uc3NBF0f8xx
 /MCTbqOJYsdvl9ke6NfAZ/zAKkWl2Yz8IBdTCjRWxXS8vldsYUnvj5s/zEIqROko9Y
 cElwZxLdQRr9tB6MBPeP4KdKX5+faQQf8Va+kp0lPz27yr+6HfEAORg5gvlJhPP7WF
 Pm1HnXUMSgpu71XsVXkyb++TI8JImTXHfISIhkkzC1H69Iz9KAiMK9Jpel6HXEGPwI
 hPgq2nnh41hYE1RyEZj9wsBnSIC4u+6th+DFVeptsZo/lvjetEn6Ji3CC9qIGx9Kkh
 bW5BoGwAyddcQ==
From: Mark Brown <broonie@kernel.org>
To: vkoul@kernel.org, Bard Liao <yung-chuan.liao@linux.intel.com>,
 alsa-devel@alsa-project.org
Subject: Re: [PATCH v2 0/6] soundwire/ASoC: abstract platform-dependent bases
Date: Mon,  2 Aug 2021 21:44:13 +0100
Message-Id: <162793640708.55982.13298433414874844018.b4-ty@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20210723115451.7245-1-yung-chuan.liao@linux.intel.com>
References: <20210723115451.7245-1-yung-chuan.liao@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Cc: vinod.koul@linaro.org, tiwai@suse.de, gregkh@linuxfoundation.org,
 linux-kernel@vger.kernel.org, pierre-louis.bossart@linux.intel.com,
 Mark Brown <broonie@kernel.org>, sanyog.r.kale@intel.com, bard.liao@intel.com
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

On Fri, 23 Jul 2021 19:54:45 +0800, Bard Liao wrote:
> shim base and alh base are platform-dependent. This series suggests
> to use variables for those bases. It allows us to use different bases
> for new platforms.
> 
> v2:
>  - Update the commit message of "soundwire: move intel sdw register
>    definitions to sdw_intel.h"
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/6] soundwire: move intel sdw register definitions to sdw_intel.h
      commit: f01639589e252a6f72c04716e1b5f9bb10e2debc
[2/6] ASoC: SOF: intel: add sdw_shim/alh_base to sof_intel_dsp_desc
      commit: 1cbf6443f0de6489044909b35962ba71940d48fe
[3/6] ASoC: SOF: intel: hda: remove HDA_DSP_REG_SNDW_WAKE_STS definition
      commit: 781dd3c822683f4b5dc332b68ac49d2db3d400e9
[4/6] ASoC: SOF: intel: move sof_intel_dsp_desc() forward
      commit: 2f1315ae94b46bf0d5b4be29be15cc3641364404
[5/6] ASoC: SOF: intel: add snd_sof_dsp_check_sdw_irq ops
      commit: 198fa4bcf6a1e8685b43e37790d45f3ebcbc2784
[6/6] soundwire: intel: introduce shim and alh base
      commit: 60e9feb781dfe84158b4ec7a4d61c5103e96e6f3

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
