Return-Path: <SRS0=KNeL=FW=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 97552C4361B
	for <alsa-devel@archiver.kernel.org>; Fri, 18 Dec 2020 12:17:26 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 084D22395C
	for <alsa-devel@archiver.kernel.org>; Fri, 18 Dec 2020 12:17:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 084D22395C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id D0B03175E;
	Fri, 18 Dec 2020 13:16:31 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz D0B03175E
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1608293841;
	bh=IQoQ0V//vJbQmszW8LL7/TZUVWrrjPTLu15m1jF880g=;
	h=From:To:In-Reply-To:References:Subject:Date:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=bfdTCSc9rZ6+71Iw3VxE/ZSRaEVUacEoAEs3K0kDkZMQvBgE3+/IYurN9So2n3jaW
	 SHOTi9VnaotC+t0gbgHfiEsck4KeGY1OtjuITw8pJ9Vr6ScMyOF6tE9Kgt+0rAgsmr
	 GCcQP4D9Y//WSgo5T96ARWpjiNgBp0iiMS+gdfB4=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 6DF77F80171;
	Fri, 18 Dec 2020 13:16:31 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id B4D6CF801F7; Fri, 18 Dec 2020 13:16:29 +0100 (CET)
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 54E8EF8014B
 for <alsa-devel@alsa-project.org>; Fri, 18 Dec 2020 13:16:26 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 54E8EF8014B
From: Mark Brown <broonie@kernel.org>
Authentication-Results: mail.kernel.org;
 dkim=permerror (bad message/signature format)
To: Cezary Rojewski <cezary.rojewski@intel.com>, alsa-devel@alsa-project.org
In-Reply-To: <20201217105401.27865-1-cezary.rojewski@intel.com>
References: <20201217105401.27865-1-cezary.rojewski@intel.com>
Subject: Re: [PATCH] ASoC: Intel: haswell: Add missing pm_ops
Message-Id: <160829377018.10885.10506165188431726601.b4-ty@kernel.org>
Date: Fri, 18 Dec 2020 12:16:10 +0000
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Cc: hdegoede@redhat.com, tiwai@suse.com, pierre-louis.bossart@linux.intel.com,
 lgirdwood@gmail.com
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

On Thu, 17 Dec 2020 11:54:01 +0100, Cezary Rojewski wrote:
> haswell machine board is missing pm_ops what prevents it from undergoing
> suspend-resume procedure successfully. Assign default snd_soc_pm_ops so
> this is no longer the case.

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/1] ASoC: Intel: haswell: Add missing pm_ops
      commit: bb224c3e3e41d940612d4cc9573289cdbd5cb8f5

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
