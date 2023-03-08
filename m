Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BFAADC64EC4
	for <alsa-devel@archiver.kernel.org>; Wed,  8 Mar 2023 13:58:34 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 7E21D1891;
	Wed,  8 Mar 2023 14:57:42 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 7E21D1891
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1678283912;
	bh=j9Mhwz/qVbBK/bmvufxQsilCLcYcZBe7yhhQn1n+LiQ=;
	h=From:To:In-Reply-To:References:Subject:Date:CC:List-Id:
	 List-Archive:List-Help:List-Owner:List-Post:List-Subscribe:
	 List-Unsubscribe:From;
	b=juH8pJRyn94HVFN9WhGexPdCl5V1xls6HJN3dk8E+wWfP7TILscFgfMy2MxP7B1+t
	 zLslCKNY4vP/Eh46eNNwjueAGRB3n9EcAWvM48q13UsQla/joTbpR0dwHVd1HrhoWz
	 Yzc0XgaVTyNAja0S0eorrMDu3NEMOkf1scTn8w94=
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id 07FC8F805CA;
	Wed,  8 Mar 2023 14:53:31 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 1183DF8057B; Wed,  8 Mar 2023 14:53:04 +0100 (CET)
Received: from ams.source.kernel.org (ams.source.kernel.org
 [IPv6:2604:1380:4601:e00::1])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa1.perex.cz (Postfix) with ESMTPS id BA6B9F8056F
	for <alsa-devel@alsa-project.org>; Wed,  8 Mar 2023 14:53:01 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz BA6B9F8056F
Authentication-Results: alsa1.perex.cz;
	dkim=pass (2048-bit key,
 unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20201202 header.b=LJvHx9LU
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.source.kernel.org (Postfix) with ESMTPS id 38901B81CD1;
	Wed,  8 Mar 2023 13:53:01 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 852CCC4339C;
	Wed,  8 Mar 2023 13:52:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1678283580;
	bh=j9Mhwz/qVbBK/bmvufxQsilCLcYcZBe7yhhQn1n+LiQ=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=LJvHx9LUPlFekT8DgO487HeJkGUn1MAa2VOsaCskTukTXluQ1BNg8L61rQPMXo/nb
	 ASAoPMTfWPJRggddo/MOsWzhLv3ewndw/Bae7tOZd1p+eo4jJFcz8UdUmmGlO7a6JB
	 DrVxz/E1Z04MsTcMhTLjFniWx+VgvNrxs9CTsaUdYnmENPlskWgON8eG3nIE6zK5+d
	 SFjKTj2LRXNkJAawgF/opL3H4t9WCh+2u+vc2cwhLY8SVDoEcwJNyef9bKfCxuRQ7K
	 kj8/jvN6bLZUmjMIBKBJqW0/YHPiaXAfD58FllihkpretNIclLJJ74C17T+DlJrVwi
	 1EuIpAufqnDlA==
From: Mark Brown <broonie@kernel.org>
To: lgirdwood@gmail.com, Peter Ujfalusi <peter.ujfalusi@linux.intel.com>
In-Reply-To: <20230307110846.2265-1-peter.ujfalusi@linux.intel.com>
References: <20230307110846.2265-1-peter.ujfalusi@linux.intel.com>
Subject: Re: [PATCH] ASoC: SOF: ipc4-mtrace: process pending logs upon FW
 crash
Message-Id: <167828357822.31859.5790787159246591803.b4-ty@kernel.org>
Date: Wed, 08 Mar 2023 13:52:58 +0000
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.13-dev-bd1bf
Message-ID-Hash: TB7SQIYRR6RYBV4IXHK6IF7ARJQ45RDI
X-Message-ID-Hash: TB7SQIYRR6RYBV4IXHK6IF7ARJQ45RDI
X-MailFrom: broonie@kernel.org
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency;
 loop; banned-address; member-moderation;
 header-match-alsa-devel.alsa-project.org-0;
 header-match-alsa-devel.alsa-project.org-1; nonmember-moderation;
 administrivia; implicit-dest; max-recipients; max-size; news-moderation;
 no-subject; digests; suspicious-header
CC: alsa-devel@alsa-project.org, pierre-louis.bossart@linux.intel.com,
 ranjani.sridharan@linux.intel.com, kai.vehmanen@linux.intel.com
X-Mailman-Version: 3.3.8
Precedence: list
List-Id: "Alsa-devel mailing list for ALSA developers -
 http://www.alsa-project.org" <alsa-devel.alsa-project.org>
Archived-At: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/TB7SQIYRR6RYBV4IXHK6IF7ARJQ45RDI/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

On Tue, 07 Mar 2023 13:08:46 +0200, Peter Ujfalusi wrote:
> If the DSP firmware has crashed, some log messages may be pending in the
> mtrace buffer, but not consumed by the driver as no IPC notification has
> been sent by the firmware. Check the buffer status for all mtrace slots
> and ensure any pending log messages are processed before DSP is possibly
> powered down and the log buffer contents is lost.
> 
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/1] ASoC: SOF: ipc4-mtrace: process pending logs upon FW crash
      commit: db97cc0f7459a2bee68e6e8bf0b2f7a286137fa8

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

