Return-Path: <SRS0=9FQT=JZ=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 04D4BC433B4
	for <alsa-devel@archiver.kernel.org>; Wed, 28 Apr 2021 16:55:27 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 11CED6143D
	for <alsa-devel@archiver.kernel.org>; Wed, 28 Apr 2021 16:55:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 11CED6143D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 89DD716AF;
	Wed, 28 Apr 2021 18:54:32 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 89DD716AF
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1619628922;
	bh=lIC/pqsoxsAM0Fy/QGQnTVj7ZtLt54LhbkZ0xAPSS9E=;
	h=From:To:Subject:Date:In-Reply-To:References:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=Avkw1VRcvO9RExFsofxR6t+/n66guewIrcR8D+XVltXHhHOPvD8oiGjRuEkssMKa0
	 YuClJKb2daccbJIuF4oOztDcwqdqoactFaLh4b7xVCkheTTshFnkDB8nuMTw6stjY/
	 p0PV7Ceed3GE9aRNLICoO3FabR/uOP+HmtbMf6ek=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id D681DF80130;
	Wed, 28 Apr 2021 18:54:31 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 816E9F80171; Wed, 28 Apr 2021 18:54:29 +0200 (CEST)
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 92E12F80130
 for <alsa-devel@alsa-project.org>; Wed, 28 Apr 2021 18:54:26 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 92E12F80130
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org
 header.b="c/tlTFLO"
Received: by mail.kernel.org (Postfix) with ESMTPSA id 2DCEA6143B;
 Wed, 28 Apr 2021 16:54:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1619628862;
 bh=lIC/pqsoxsAM0Fy/QGQnTVj7ZtLt54LhbkZ0xAPSS9E=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=c/tlTFLO3kzIvoEubr+aHX0eeke0Gbkrmy9wxc3BXM9RUxd9ab5lWkV7vSMJoCSUX
 YNqY6bsoKJ0x3m9rhacs9HCg4WubaFN8FE3zo6m4w2zeAalaIZ92K+QQ6YmWbHk8bJ
 TK4+1GfcjJNXseB2l3SlFbWjEmpdDFiIG5riZCpb3gU2+4rrMcx+Kq5R7Iqu16Kg41
 C46gn7iEgz2ucClbpQ2mB0iMgVfhxJSnDIWRkbHFqSBS7AoUyDDWt9pW4znSIG2leD
 ZOw5RjzT4CVM6lPClS8kyoSP/q6a0Xqrp8Gu0tvnWZD9neAxfinWdTuwstRx34A6tt
 Pol1Qe6mJaBuw==
From: Mark Brown <broonie@kernel.org>
To: alsa-devel@alsa-project.org,
	Vijendar Mukunda <Vijendar.Mukunda@amd.com>
Subject: Re: [PATCH] ASoC: amd: fix for pcm_read() error
Date: Wed, 28 Apr 2021 17:53:43 +0100
Message-Id: <161962856273.49583.9768251008066165285.b4-ty@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <1619555017-29858-1-git-send-email-Vijendar.Mukunda@amd.com>
References: <1619555017-29858-1-git-send-email-Vijendar.Mukunda@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Cc: Sunil-kumar.Dommati@amd.com,
 Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>,
 Liam Girdwood <lgirdwood@gmail.com>, open list <linux-kernel@vger.kernel.org>,
 Basavaraj.Hiregoudar@amd.com, Takashi Iwai <tiwai@suse.com>,
 Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
 Alexander.Deucher@amd.com, Prike Liang <Prike.Liang@amd.com>,
 Mark Brown <broonie@kernel.org>,
 Ravulapati Vishnu vardhan rao <Vishnuvardhanrao.Ravulapati@amd.com>,
 yuhsuan@google.com, Akshu Agrawal <akshu.agrawal@amd.com>
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

On Wed, 28 Apr 2021 01:53:31 +0530, Vijendar Mukunda wrote:
> Below phython script throwing pcm_read() error.
> 
> import subprocess
> 
> p = subprocess.Popen(["aplay -t raw -D plughw:1,0 /dev/zero"], shell=True)
> subprocess.call(["arecord -Dhw:1,0 --dump-hw-params"], shell=True)
> subprocess.call(["arecord -Dhw:1,0 -fdat -d1 /dev/null"], shell=True)
> p.kill()
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/1] ASoC: amd: fix for pcm_read() error
      commit: 6879e8e759bf9e05eaee85e32ca1a936e6b46da1

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
