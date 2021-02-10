Return-Path: <SRS0=/2j+=HM=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.6 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C44C8C433DB
	for <alsa-devel@archiver.kernel.org>; Wed, 10 Feb 2021 20:14:24 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 19F8564EE5
	for <alsa-devel@archiver.kernel.org>; Wed, 10 Feb 2021 20:14:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 19F8564EE5
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 9B8D916E5;
	Wed, 10 Feb 2021 21:13:32 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 9B8D916E5
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1612988062;
	bh=hMm//IaVgh+GxgjcDmzibqoGksuAmp+uhzD4AZx43yk=;
	h=From:To:In-Reply-To:References:Subject:Date:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=SC2wX2mGt7/Pni6gp30LS+x/RPE45SZm+CmRHtz0W85Eftmc69xtSapNrap6Im0Az
	 Awmpcjk9pELe5XH3cBXPPQI+8Kagv334PxH6i2m9s1q9Lk9XS84AizOPa+7keQOO9G
	 0ENbiVzY69c7+p0f3ngOHJ18/+RYejOMwGh7e23w=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id A0FD7F80240;
	Wed, 10 Feb 2021 21:12:46 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id E9AD6F800F1; Wed, 10 Feb 2021 21:12:38 +0100 (CET)
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 68BEBF800F1
 for <alsa-devel@alsa-project.org>; Wed, 10 Feb 2021 21:12:34 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 68BEBF800F1
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org
 header.b="JT/lR9gv"
Received: by mail.kernel.org (Postfix) with ESMTPSA id D359C64EDF;
 Wed, 10 Feb 2021 20:12:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1612987953;
 bh=hMm//IaVgh+GxgjcDmzibqoGksuAmp+uhzD4AZx43yk=;
 h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
 b=JT/lR9gvdEOZctq1JxB0+bPgGreYE0YWVPtFeH7Csh8uAyVJ7nnDN57JBA/8qUsJK
 e5R0orR2Us7opEiTQb2Q7mmAqUhhM+64ACbIQTloJP4HTSXoUQ98MuQHpCYlWX7Rsb
 /3V0NXdTtbVBSHlwj17ctIyPVXPFAAdCAX5/51sxoLmYaOpu1iKfeO8sK70HnXcz5Q
 WJgiB3jf+sHcefj1XlWl53YGYQCo8NHsXq+elMDtx7RedUzGOOxCVXuTajYyJtMHbd
 5SwhLgsnI2FcZxf8NX951QFDGHgbJCZT3h3GwwcQae1F0LWd6HfNL99IWnPT1mXHSj
 mbz9SihfEv/PA==
From: Mark Brown <broonie@kernel.org>
To: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
 alsa-devel@alsa-project.org
In-Reply-To: <20210208232149.58899-1-pierre-louis.bossart@linux.intel.com>
References: <20210208232149.58899-1-pierre-louis.bossart@linux.intel.com>
Subject: Re: [PATCH 0/5] ASoC: SOF: cleanups
Message-Id: <161298789618.5497.7329014289938073399.b4-ty@kernel.org>
Date: Wed, 10 Feb 2021 20:11:36 +0000
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Cc: tiwai@suse.de
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

On Mon, 8 Feb 2021 17:21:44 -0600, Pierre-Louis Bossart wrote:
> Minor cleanups for error formats, missing cases, useless functions and
> simplifications.
> 
> Curtis Malainey (2):
>   ASoC: SOF: add missing pm debug
>   ASoC: SOF: fix string format for errors
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/5] ASoC: SOF: add missing pm debug
      commit: a8f50cd9be7cc4c57f29c1390568225ebee90eda
[2/5] ASoC: SOF: fix string format for errors
      commit: ce1f55bac5534aa518e26b94728173ee45f91a8c
[3/5] ASoC: SOF: remove unused functions
      commit: 3be46fa21088740ae5790d84b882e5a3c98fce41
[4/5] ASoC: SOF: HDA: (cosmetic) simplify hda_dsp_d0i3_work()
      commit: f1bb023525fd654121f18f6e2587eeee84c9db04
[5/5] ASoC: SOF: ext_manifest: use explicit number for elem_type
      commit: cc11626dd9f894d93ed15d78b04452ca9acbb52b

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
