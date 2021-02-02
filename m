Return-Path: <SRS0=BHSX=HE=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 255B4C433E6
	for <alsa-devel@archiver.kernel.org>; Tue,  2 Feb 2021 17:32:44 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 87B3564D99
	for <alsa-devel@archiver.kernel.org>; Tue,  2 Feb 2021 17:32:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 87B3564D99
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 1303B1786;
	Tue,  2 Feb 2021 18:31:52 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 1303B1786
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1612287162;
	bh=O8ORfPebUxsegzmZ5upgI8FYJs+6Qj2BQE4HaVbBXGw=;
	h=From:To:In-Reply-To:References:Subject:Date:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=LWNA7uEto8h/JWy1ZHt6jxxNsbRg4PRYPIdefF/UbC5gCYzbNzfHmC0Mw/jOiXCYd
	 v6I4NcoMclwS66lUnR9VZf8F/mDNC7ynLkafhriZDnDM9YUMCGMVf3pIhnnMnAfIWN
	 Bwc2TXOKYHCjK9iUVjcYqbvrrzjV1bXWkcq/N1Bk=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id A445AF8021C;
	Tue,  2 Feb 2021 18:31:03 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id C1995F8023C; Tue,  2 Feb 2021 18:31:01 +0100 (CET)
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id C2840F800E1
 for <alsa-devel@alsa-project.org>; Tue,  2 Feb 2021 18:30:53 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz C2840F800E1
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org
 header.b="rFqU1F/u"
Received: by mail.kernel.org (Postfix) with ESMTPSA id C524964F6A;
 Tue,  2 Feb 2021 17:30:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1612287052;
 bh=O8ORfPebUxsegzmZ5upgI8FYJs+6Qj2BQE4HaVbBXGw=;
 h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
 b=rFqU1F/uCCLHMtQk6FLV7GnA+IjQHWH+6wsISqx6jbng0uO23h9P7fbIBfAHwQ+rr
 7ahbAziDx4RAPQ7DmGn2tOvS/06gCM1t5Pz0AcM6/MlbMexfaEnzp4sqjMxYIlHih+
 hGbzH92uXrhAMZolNiiK6ce3S1TqBdZliMnT/xemJtfHUgqDOzKeX7twMHOp0/a1OH
 bDOeOjfbo/k1dDpmygzehhIFWd7qt0ydkkpgh8ZQ6QFAoxHHoPEcHq0IslQQNo2uCk
 4g0DT3wJ8f9cx+i4Erk8giFweb48m9GBgc3m1zisF2WKHPXIKT/shvByRrQiMeZvAO
 SlAaYi3Ki2YLA==
From: Mark Brown <broonie@kernel.org>
To: Takashi Iwai <tiwai@suse.com>, Amadeusz Sławiński <amadeuszx.slawinski@linux.intel.com>, Liam Girdwood <lgirdwood@gmail.com>
In-Reply-To: <20210202163123.3942040-1-amadeuszx.slawinski@linux.intel.com>
References: <20210202163123.3942040-1-amadeuszx.slawinski@linux.intel.com>
Subject: Re: [PATCH] ASoC: topology: KUnit: Convert from cpu to data format
Message-Id: <161228699993.35075.15148170146643689827.b4-ty@kernel.org>
Date: Tue, 02 Feb 2021 17:29:59 +0000
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Cc: Cezary Rojewski <cezary.rojewski@intel.com>,
 Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
 alsa-devel@alsa-project.org, kernel test robot <lkp@intel.com>
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

On Tue, 2 Feb 2021 17:31:23 +0100, Amadeusz Sławiński wrote:
> When creating topology templates and overriding data in specific test
> cases it should be done with cpu_to_le32 macro, so we operate on correct
> data on all architectures, as topology parser use le32_to_cpu to parse
> data from structures.

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/1] ASoC: topology: KUnit: Convert from cpu to data format
      commit: be6be67e135e59fb176b1e2e9d47a7436fb161d1

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
