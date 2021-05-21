Return-Path: <SRS0=n5wC=KQ=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5860CC4707A
	for <alsa-devel@archiver.kernel.org>; Fri, 21 May 2021 19:39:01 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0A257613D9
	for <alsa-devel@archiver.kernel.org>; Fri, 21 May 2021 19:38:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0A257613D9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 1E86716C0;
	Fri, 21 May 2021 21:38:08 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 1E86716C0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1621625938;
	bh=/JJtWSxL7X10UdoL0Qg9p+7yXU5zypGEXSphis/GHdc=;
	h=From:To:Subject:Date:In-Reply-To:References:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=lDwCTGDLKpMSq4i3r1nrOABncUJ5/N6utKA9GPFoj08dUnXdaYjjsvBdDI24rVh5n
	 +b1tGDyX9lIPHU1PyVKIvGoKed/h5LE8NRT4DnapRBxYNg7BQtT7FIj34nQC8LvPdY
	 m6GUyZ65GSwcagTXlcVCubrczbDAKty00vSIAjx8=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 62515F8016E;
	Fri, 21 May 2021 21:38:07 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 04D32F801DB; Fri, 21 May 2021 21:38:06 +0200 (CEST)
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 5AEB4F80153
 for <alsa-devel@alsa-project.org>; Fri, 21 May 2021 21:38:02 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 5AEB4F80153
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org
 header.b="MuoTmAPA"
Received: by mail.kernel.org (Postfix) with ESMTPSA id 0028A613E1;
 Fri, 21 May 2021 19:37:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1621625879;
 bh=/JJtWSxL7X10UdoL0Qg9p+7yXU5zypGEXSphis/GHdc=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=MuoTmAPAUykKOkLMJ4QMOY+KhkXO7yWRCG6oCrsjaRH/v0d/8xIGkjzYsWummkKuV
 SkAhxG5Yeb8jrekT50jYdMEVmq6Av+eOU/GPePDwyiwfqz0K1G0YQSoEXnWfLjAhD8
 z/hrSsFTLJdqU1GE5T2yM5goaSgK7zQjyiKhS3kSzaotCdM8gzDCYk7l0fVyvCEkrP
 qTQNXobQ8MHijw4Q9YaMC9Dv87m0xwZGIT9wwg7poyQ/GyfPoaQS/s7TPexm9qODv9
 HRYmOGSK/759WyAkpW8dVpl0JJBx6iuuyGt73Gg7zpsKIWAeypAXMtV2fLqkI28rv9
 vbMD8YSLEgWOg==
From: Mark Brown <broonie@kernel.org>
To: alsa-devel@alsa-project.org,
	Kai Vehmanen <kai.vehmanen@linux.intel.com>
Subject: Re: [PATCH 1/2] ASoC: Intel: common: Add entries for sdw codecs in
 ADL match table
Date: Fri, 21 May 2021 20:37:53 +0100
Message-Id: <162162572418.40821.5764580959034015322.b4-ty@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20210521155632.3736393-1-kai.vehmanen@linux.intel.com>
References: <20210521155632.3736393-1-kai.vehmanen@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Cc: cezary.rojewski@intel.com, Jie Yang <yang.jie@linux.intel.com>,
 ranjani.sridharan@linux.intel.com, pierre-louis.bossart@linux.intel.com,
 Mark Brown <broonie@kernel.org>,
 Vamshi Krishna Gopal <vamshi.krishna.gopal@intel.com>,
 yung-chuan.liao@linux.intel.com, Bard Liao <bard.liao@intel.com>
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

On Fri, 21 May 2021 18:56:31 +0300, Kai Vehmanen wrote:
> RT5682 and Max98373 are added with SDW0,SDW2 links respectively.

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/2] ASoC: Intel: common: Add entries for sdw codecs in ADL match table
      commit: c0fbe9fd311a07bd8919e61d412db22e4b08dc43
[2/2] ASoC: Intel: sof_sdw: add quirk support for Brya and BT-offload
      commit: 03effde3a2ea1d82c4dd6b634fc6174545d2c34f

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
