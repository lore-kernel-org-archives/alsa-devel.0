Return-Path: <SRS0=mFEw=MZ=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 76B95C4338F
	for <alsa-devel@archiver.kernel.org>; Mon,  2 Aug 2021 20:45:32 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2F27C604D7
	for <alsa-devel@archiver.kernel.org>; Mon,  2 Aug 2021 20:45:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 2F27C604D7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id E7AE11712;
	Mon,  2 Aug 2021 22:44:38 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz E7AE11712
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1627937129;
	bh=bJwDkyQNQBiepvcFDfyoPxnra84M/0DeMIw1RsSoIOA=;
	h=From:To:Subject:Date:In-Reply-To:References:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=VX6YmTzo1/bhWsn0nwpp0bisMSUJA7PQo6KCpYHjK92ApQgeQqnLLYriWSDbwdLRi
	 7CK+88k8Dbw+A4MStHI/IpzFWqdwFFQ3X5wD1R9GgZx+u3jyfIBlVFuff5St65G+i0
	 R7cj8eIu0ICb2X4M1QqC4MKeRlO4aAd1xqA1YAGA=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 2A020F8014D;
	Mon,  2 Aug 2021 22:44:38 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 90213F8025F; Mon,  2 Aug 2021 22:44:35 +0200 (CEST)
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id EB8E2F800BF
 for <alsa-devel@alsa-project.org>; Mon,  2 Aug 2021 22:44:32 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz EB8E2F800BF
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org
 header.b="TdaK8ysB"
Received: by mail.kernel.org (Postfix) with ESMTPSA id B80D160F35;
 Mon,  2 Aug 2021 20:44:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1627937067;
 bh=bJwDkyQNQBiepvcFDfyoPxnra84M/0DeMIw1RsSoIOA=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=TdaK8ysBnHBJZATDT3DW1M9iThckpltR7gPIhWwwqhpnwJaZ+sa6lnrM1wn5DzPxl
 CQ8IamKh1qGLpQFQjA1hrqdIDECt9t35h0WTTQsNV8caPFeJTMq/T9IWdZRn25PG5U
 Vz5Y+HTsebRIjwq30QOAeWkD2W6aXTwckth/PjVhVnOQpzRx3bInFkvci4DFQBZmRL
 ZeDjMVisZFvoDp5d8HdAO90UTUEUDdUwTn7PMPdBA4sdLTmRciu+d6QLuo0mwzBf9d
 ab31UC/uOUtfFiWy5L2xcJBRfsUgHnIxqaQklR/LPohrmvYIFAIgNRYvOz5kIWjoPV
 Dd6osfUE2B7iQ==
From: Mark Brown <broonie@kernel.org>
To: Liam Girdwood <liam.r.girdwood@linux.intel.com>,
 Cezary Rojewski <cezary.rojewski@intel.com>,
 Hans de Goede <hdegoede@redhat.com>,
 Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
 Jie Yang <yang.jie@linux.intel.com>
Subject: Re: [PATCH v2 0/6] ASoC: Intel: bytcr_rt5640: Fix HP ElitePad 1000 G2
 audio routing
Date: Mon,  2 Aug 2021 21:44:11 +0100
Message-Id: <162793640710.55982.1472416722893108555.b4-ty@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20210802142501.991985-1-hdegoede@redhat.com>
References: <20210802142501.991985-1-hdegoede@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Cc: alsa-devel@alsa-project.org, Mark Brown <broonie@kernel.org>,
 Bard Liao <bard.liao@intel.com>
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

On Mon, 2 Aug 2021 16:24:55 +0200, Hans de Goede wrote:
> Changes in v2:
> - Only set lineout_string if BYT_RT5640_LINEOUT is set, since
>   BYT_RT5640_LINEOUT_AS_HP2 only works if the lineout is enabled in
>   the first place
> 
> Original cover-letter:
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/6] ASoC: Intel: bytcr_rt5640: Move "Platform Clock" routes to the maps for the matching in-/output
      commit: dccd1dfd0770bfd494b68d1135b4547b2c602c42
[2/6] ASoC: Intel: bytcr_rt5640: Add line-out support
      commit: dd3e2025100c08d1fabd116bf5b6646f1589a95e
[3/6] ASoC: Intel: bytcr_rt5640: Add a byt_rt5640_get_codec_dai() helper
      commit: 810711407467667761f7fd6aa1b8884203ecbeca
[4/6] ASoC: Intel: bytcr_rt5640: Add support for a second headphones output
      commit: 044c76571277bb87dd3318e55c7ae46a0c27ab0f
[5/6] ASoC: Intel: bytcr_rt5640: Add support for a second headset mic input
      commit: 79c1123bac3b878874a8d7163f2eab6a7448733b
[6/6] ASoC: Intel: bytcr_rt5640: Fix HP ElitePad 1000 G2 quirk
      commit: 780feaf4ad8848e48aa679c0fb9d98d45f691e4e

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
