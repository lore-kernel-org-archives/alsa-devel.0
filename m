Return-Path: <SRS0=cpFx=IC=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D9112C433DB
	for <alsa-devel@archiver.kernel.org>; Thu,  4 Mar 2021 01:00:22 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E59E064EE4
	for <alsa-devel@archiver.kernel.org>; Thu,  4 Mar 2021 01:00:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E59E064EE4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 73B401AA5;
	Thu,  4 Mar 2021 01:59:30 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 73B401AA5
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1614819620;
	bh=8nPQO8MexOePnyeYzs8lBN3FiZNT9O24IqQnDaZ9rR8=;
	h=From:To:In-Reply-To:References:Subject:Date:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=vDziBPhcZF6epVDVNPUXWff8TLN3Z6AfbfW3K/skOmNzCT+3EUIa9mmFqHy3TaYl7
	 44+bKindb2V7wHlqzvyWWJUk9SfMV6dznMwuxv/g/tLGIEqud2Qq/2xYUrafGGPLuR
	 70L8RILHnE45lX5QGSK2q62PfMOZXZ3UPFBYehds=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 87DD5F804E7;
	Thu,  4 Mar 2021 01:56:10 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id D3035F804F1; Thu,  4 Mar 2021 01:56:08 +0100 (CET)
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 26863F804E7
 for <alsa-devel@alsa-project.org>; Thu,  4 Mar 2021 01:56:06 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 26863F804E7
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org
 header.b="JRPNtuHO"
Received: by mail.kernel.org (Postfix) with ESMTPSA id 9C85664E7C;
 Thu,  4 Mar 2021 00:56:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1614819364;
 bh=8nPQO8MexOePnyeYzs8lBN3FiZNT9O24IqQnDaZ9rR8=;
 h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
 b=JRPNtuHOGAv3B3nt7jGwgWhHwyETn/gzxhogN0JzP5y0eLmx2YBs6Mrv4tNZVZ+/d
 69/n/9goH5rCFjYlxdG/F4wNAmef5LsCGRTzt3gwuuFBmdMTJkCgWOXNwkYaEscNnS
 8VSaHG0Xb5e/MKaLRknv4uhuQL+Iya+Nr26iFLuqQIcSJKENvO8RZfRBoK1WHCEpuP
 JQKVdTIxZFmZC7/M0nV9bSfiD3yqVuDpD+kk/R9kjKcqYU8pAjbdV6urNDJY5YJ5el
 USNZFWxeqf3dSONujSj2BjiTHO6IjZkV81X8jGmsiemUAIFOuplrpddDfdzGAbG//Q
 7mhSeAC6OOAVQ==
From: Mark Brown <broonie@kernel.org>
To: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
 alsa-devel@alsa-project.org
In-Reply-To: <20210301174639.117017-1-pierre-louis.bossart@linux.intel.com>
References: <20210301174639.117017-1-pierre-louis.bossart@linux.intel.com>
Subject: Re: [PATCH v2] ASoC: codecs: nau8825: fix kernel-doc
Message-Id: <161481924068.9553.9447813014180266555.b4-ty@kernel.org>
Date: Thu, 04 Mar 2021 00:54:00 +0000
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Cc: tiwai@suse.de, vkoul@kernel.org
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

On Mon, 1 Mar 2021 11:46:39 -0600, Pierre-Louis Bossart wrote:
> v5.12-rc1 flags new warnings with make W=1, fix missing or broken
> function descriptors.
> 
> sound/soc/codecs/nau8825.c:298: warning: wrong kernel-doc identifier
> on line:
>  * Ramp up the headphone volume change gradually to target level.
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/1] ASoC: codecs: nau8825: fix kernel-doc
      commit: e2fc891044762c3308380a002c36adf087e95542

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
