Return-Path: <SRS0=Cjbi=KG=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E51DAC433ED
	for <alsa-devel@archiver.kernel.org>; Tue, 11 May 2021 08:32:20 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 51B4661184
	for <alsa-devel@archiver.kernel.org>; Tue, 11 May 2021 08:32:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 51B4661184
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id C6A681753;
	Tue, 11 May 2021 10:31:28 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz C6A681753
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1620721938;
	bh=rVZx4H7SLhEfY9uZaZksv7D3ECMJkUkfL2J6l5EyOKc=;
	h=From:To:Subject:Date:In-Reply-To:References:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=rcP+nZTox1iR2LtxXiD7alPUmYEKI4jCemUTmKcj04aJOW9bTopm8Glx4YBl3S/qz
	 wf+z/ClQkHxkK7TPrtv7KPO2yrjnjMP39kZo5GCmoqs90qrhgs0uKDjQsy7XMKDeIx
	 +04R+NichaYb+xuE5kFTGalW1bKdR5WVtan/WUVQ=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id B2952F804E5;
	Tue, 11 May 2021 10:28:31 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id B1AE8F804B1; Tue, 11 May 2021 10:27:58 +0200 (CEST)
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 67B72F804B1
 for <alsa-devel@alsa-project.org>; Tue, 11 May 2021 10:27:55 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 67B72F804B1
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org
 header.b="a7L85Q6o"
Received: by mail.kernel.org (Postfix) with ESMTPSA id 40BA061942;
 Tue, 11 May 2021 08:27:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1620721673;
 bh=rVZx4H7SLhEfY9uZaZksv7D3ECMJkUkfL2J6l5EyOKc=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=a7L85Q6oK67wz+PpJvPdesYqBNI6/Ua6fNPiZBQIUfRO/xM0SxJTmgmeuILQ8lwt4
 6Y8x7tvptZvOHTmWNddPVDaJkOExChnXAcVauKTZcr5PK8YgAe7V+5gEM8SsFxatH9
 37MIeoMu9OM7RP/SFiNyDulq6z7gCdXTarmTvcrxqLe+CAHdHbEOy6si9KMNCCDmzt
 eA8puvHhI/SmkyauOq2SeQOFptIngcejZV5qhm8mLhXLj9O3CliK+QpveQkbAruTRo
 40W6cM9DHtK++5M+do4uIUHJ1Ej7qs7lbPCQfEmgx9A6ZycvEsQhDP3RkOeNNf8/RP
 zoMctCAu65VrQ==
From: Mark Brown <broonie@kernel.org>
To: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
 linux-kernel@vger.kernel.org, alsa-devel@alsa-project.org,
 Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
 Liam Girdwood <lgirdwood@gmail.com>, Yang Li <yang.lee@linux.alibaba.com>,
 Takashi Iwai <tiwai@suse.com>, Colin Ian King <colin.king@canonical.com>,
 Wan Jiabing <wanjiabing@vivo.com>, Jaroslav Kysela <perex@perex.cz>
Subject: Re: [PATCH] ASoC: codecs: lpass-rx-macro: Remove unneeded semicolon
Date: Tue, 11 May 2021 09:25:53 +0100
Message-Id: <162072058169.33157.72791432961188955.b4-ty@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20210506021005.4897-1-wanjiabing@vivo.com>
References: <20210506021005.4897-1-wanjiabing@vivo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Cc: kael_w@yeah.net, Mark Brown <broonie@kernel.org>
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

On Thu, 6 May 2021 10:09:49 +0800, Wan Jiabing wrote:
> Fix the following coccicheck warning:
> 
> ./sound/soc/codecs/lpass-rx-macro.c:2631:2-3: Unneeded semicolon

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/1] ASoC: codecs: lpass-rx-macro: Remove unneeded semicolon
      commit: f758b9ef9a1abeea37086b8da0073c27eebf74aa

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
