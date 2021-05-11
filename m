Return-Path: <SRS0=Cjbi=KG=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A22F3C433B4
	for <alsa-devel@archiver.kernel.org>; Tue, 11 May 2021 18:24:29 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8AC6A617ED
	for <alsa-devel@archiver.kernel.org>; Tue, 11 May 2021 18:24:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8AC6A617ED
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id D2F7318C6;
	Tue, 11 May 2021 20:23:36 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz D2F7318C6
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1620757466;
	bh=D5mDH9l7FbQZwQF2bCf2UhGqe6AvN8dUNJ3eVmIIVMs=;
	h=From:To:Subject:Date:In-Reply-To:References:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=aD15GTzOSYTA8TYN3N1Ln2x+L4s8wmOC6OQ93tQ4KRmlu6O/HEnjPTlzaQ4SyS3OQ
	 wS0VtD9IGPLAn3SyhilQwvChIfzhTV1t1pOy/pi+J3g0PJCI3IiLjZ+pQNRHVCbivo
	 nO8pTbCvx4+d6yC5zyQDOh/CpQGyY5iH8qiemfbI=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id F3C77F8042F;
	Tue, 11 May 2021 20:22:43 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 30DF1F80279; Tue, 11 May 2021 20:22:40 +0200 (CEST)
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 9744DF8016B
 for <alsa-devel@alsa-project.org>; Tue, 11 May 2021 20:22:37 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 9744DF8016B
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org
 header.b="SLdw2num"
Received: by mail.kernel.org (Postfix) with ESMTPSA id 8C61A61207;
 Tue, 11 May 2021 18:22:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1620757356;
 bh=D5mDH9l7FbQZwQF2bCf2UhGqe6AvN8dUNJ3eVmIIVMs=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=SLdw2numIYxXSEL3fhHbiQVddlOTO7it7HYtNuw0sEfjkBRuLEtnTQU4gK0N8eYrq
 xPcGyPyc285d89m5C95xMyPJAlVzyKdVnSdPEvKLDTLTgtrMz+MWc5NtMoXSSmL+MV
 vqhTjkAMXhlmXNIE5U9GvpBLipufBL+e4DIid+6gl1sHsmDZZgXLmQqSybxWLL9tnL
 uE3izOqKazh4kjeexls+brpApnTkqj70Ye6R7oQVRxmnd8B/uwNLbz58xwblSR8XUw
 pCY/9pcF5aOwNuMvR+anER6pbNnfyOMrlCorFGsEqO9EzvcLcR1PiKr9z1QgpG0TEN
 XLAXRynIR01/A==
From: Mark Brown <broonie@kernel.org>
To: Charles Keepax <ckeepax@opensource.cirrus.com>
Subject: Re: [PATCH 1/3] ASoC: cs35l36: Remove unneeded variable initialisation
Date: Tue, 11 May 2021 19:21:31 +0100
Message-Id: <162075713909.17925.4212189860182304030.b4-ty@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20210511101051.17726-1-ckeepax@opensource.cirrus.com>
References: <20210511101051.17726-1-ckeepax@opensource.cirrus.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Cc: alsa-devel@alsa-project.org, patches@opensource.cirrus.com,
 lgirdwood@gmail.com, pierre-louis.bossart@linux.intel.com,
 Mark Brown <broonie@kernel.org>, james.schulman@cirrus.com,
 david.rhodes@cirrus.com
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

On Tue, 11 May 2021 11:10:49 +0100, Charles Keepax wrote:
> 


Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/3] ASoC: cs35l36: Remove unneeded variable initialisation
      commit: 634a4be0f9d16428779d60bb40fd852f888f0a34
[2/3] ASoC: cs4265: Minor tidy up of error paths
      commit: fd4e6baa6256b9c5cb6d8d6a020093ee9aee0372
[3/3] ASoC: cs42l52: Minor tidy up of error paths
      commit: 4ac9b48adf4d561d0e33419d548278f205dd70b5

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
