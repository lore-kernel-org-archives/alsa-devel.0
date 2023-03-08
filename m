Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 64CA5C678D5
	for <alsa-devel@archiver.kernel.org>; Wed,  8 Mar 2023 13:56:56 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id B2AE017F8;
	Wed,  8 Mar 2023 14:56:03 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz B2AE017F8
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1678283813;
	bh=ucNKfKAQ3+noQrie+j0CH1mFGm+9f2PQhuW3nVaH2vA=;
	h=From:To:In-Reply-To:References:Subject:Date:CC:List-Id:
	 List-Archive:List-Help:List-Owner:List-Post:List-Subscribe:
	 List-Unsubscribe:From;
	b=OODkNnI46U4vwxJ8HIQc6mbXf8dqacXwXtRaKxPUXsQzp1nU2difZQSZaHi2tBNJ8
	 qXmqGKRvagxsWD27EOF8YD1tF0RuTg/f0CGR+YERWNCQTovtlfMb3/7AGy6ijhxj7h
	 ORNYR7OQY+v7zD0loxQayWBSXJoRF0etW8+E+DhI=
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id CCE1BF805AA;
	Wed,  8 Mar 2023 14:53:13 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 3E0F7F80553; Wed,  8 Mar 2023 14:52:52 +0100 (CET)
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa1.perex.cz (Postfix) with ESMTPS id 88173F80549
	for <alsa-devel@alsa-project.org>; Wed,  8 Mar 2023 14:52:49 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 88173F80549
Authentication-Results: alsa1.perex.cz;
	dkim=pass (2048-bit key,
 unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20201202 header.b=DoenKR2k
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.source.kernel.org (Postfix) with ESMTPS id 4BDBC61807;
	Wed,  8 Mar 2023 13:52:48 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A6D8CC433EF;
	Wed,  8 Mar 2023 13:52:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1678283568;
	bh=ucNKfKAQ3+noQrie+j0CH1mFGm+9f2PQhuW3nVaH2vA=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=DoenKR2k/UeMGPHStQIoPMBQJIv5cjzGBndjJ6cK+HAghs+S/yyE1prtYebuSvftI
	 1DP7QytUPANIKOVnKvdDdYjFRb+/0MlZQhRCAWGFqrHZM0JFumbUwqdiTGBStzJdjU
	 BaNTrDPlN5vJhHvruxWGh/wdhZFzQ7F/qQ8wlG8D1yIsAJAa+f+zhAlZT4Ky2O25Vb
	 2kHBpwK9yarRiL/q7q09NkIg7u+MP4uFJ6G/ucwGvwvBP3/zhP6y4uUp+zfZZ3bZn1
	 Ac+2LVSXMSOSq+8md1v+kjDLLYGQKiAuTSEKxvIhyXtulcZo4e8D25O1JagnZzqhxV
	 j0BULtDycqVYg==
From: Mark Brown <broonie@kernel.org>
To: lgirdwood@gmail.com, Peter Ujfalusi <peter.ujfalusi@linux.intel.com>
In-Reply-To: <20230307114917.5124-1-peter.ujfalusi@linux.intel.com>
References: <20230307114917.5124-1-peter.ujfalusi@linux.intel.com>
Subject: Re: [PATCH] ASoC: SOF: ipc3: Check for upper size limit for the
 received message
Message-Id: <167828356639.31859.8093770621170664346.b4-ty@kernel.org>
Date: Wed, 08 Mar 2023 13:52:46 +0000
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.13-dev-bd1bf
Message-ID-Hash: 3F4Y3KRRWYM6HJNXG5MCEUIH5C7XTEVJ
X-Message-ID-Hash: 3F4Y3KRRWYM6HJNXG5MCEUIH5C7XTEVJ
X-MailFrom: broonie@kernel.org
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency;
 loop; banned-address; member-moderation;
 header-match-alsa-devel.alsa-project.org-0;
 header-match-alsa-devel.alsa-project.org-1; nonmember-moderation;
 administrivia; implicit-dest; max-recipients; max-size; news-moderation;
 no-subject; digests; suspicious-header
CC: alsa-devel@alsa-project.org, pierre-louis.bossart@linux.intel.com,
 ranjani.sridharan@linux.intel.com, kai.vehmanen@linux.intel.com,
 cujomalainey@chromium.org
X-Mailman-Version: 3.3.8
Precedence: list
List-Id: "Alsa-devel mailing list for ALSA developers -
 http://www.alsa-project.org" <alsa-devel.alsa-project.org>
Archived-At: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/3F4Y3KRRWYM6HJNXG5MCEUIH5C7XTEVJ/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

On Tue, 07 Mar 2023 13:49:17 +0200, Peter Ujfalusi wrote:
> The sof_ipc3_rx_msg() checks for minimum size of a new rx message but it is
> missing the check for upper limit.
> Corrupted or compromised firmware might be able to take advantage of this
> to cause out of bounds reads outside of the message area.
> 
> 

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/1] ASoC: SOF: ipc3: Check for upper size limit for the received message
      commit: 989a3e4479177d0f4afab8be1960731bc0ffbbd0

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

