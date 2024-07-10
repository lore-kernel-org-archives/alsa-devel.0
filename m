Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9BC02C3DA41
	for <alsa-devel@archiver.kernel.org>; Wed, 10 Jul 2024 05:47:51 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 01491A4A;
	Wed, 10 Jul 2024 07:47:39 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 01491A4A
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1720590469;
	bh=nxY3bmwxzmUjpGJqiGyt0zCho88LtDR8cLyci2z6gm0=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:List-Id:
	 List-Archive:List-Help:List-Owner:List-Post:List-Subscribe:
	 List-Unsubscribe:From;
	b=E1sOkintXCpGOMQc5CswV3fnuQ2Xoe3KA4vFaVLZUA3fcI7mPsrKUWDkgzJMGR9NU
	 TWvY0PeXxabqjOs01egTxQv1ozUJRG/oRscTo7IrjtbOdEuth4T7UTQt3o2iuK++HY
	 K9yubAoieM9KcMTYDwgdaUEG7GD49kVtGANYv9Rk=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 5DCE3F80508; Wed, 10 Jul 2024 07:47:16 +0200 (CEST)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id A4464F805B4;
	Wed, 10 Jul 2024 07:47:16 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 94AEAF801F5; Wed, 10 Jul 2024 07:46:07 +0200 (CEST)
Received: from dfw.source.kernel.org (dfw.source.kernel.org
 [IPv6:2604:1380:4641:c500::1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest
 SHA256)
	(No client certificate requested)
	by alsa1.perex.cz (Postfix) with ESMTPS id 50E6AF8013D
	for <alsa-devel@alsa-project.org>; Wed, 10 Jul 2024 07:46:02 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 50E6AF8013D
Authentication-Results: alsa1.perex.cz;
	dkim=pass (2048-bit key,
 unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20201202 header.b=a+E90/GV
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by dfw.source.kernel.org (Postfix) with ESMTP id 6DF2161904;
	Wed, 10 Jul 2024 05:45:59 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9C3B4C32781;
	Wed, 10 Jul 2024 05:45:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1720590358;
	bh=nxY3bmwxzmUjpGJqiGyt0zCho88LtDR8cLyci2z6gm0=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=a+E90/GV6BqjiquWrReBLSRMqeR731DKWbhPn+cWvGXmWcAqyj9zlOONrDN1hmkIn
	 b6trdmcAfa0rCAmhDH7YMHlK2lxX4C58Fwfsra4Ooq0rtLt2/zpcJdyUZCSa96Gkk2
	 zWsUMOqOciFYxUepWp7z5bszRk0tXcuMgqAZGsA+y5J5j/wqqkkGRlby1cQ7qi4hOW
	 Ie16VhGFHjGi7R9AyodWrdXutDmntSONywLHnvPIU5fwxOYyyuCqFGI101Vg7YP4T5
	 KaE0HQ1NlrccDnwQpl1TVT6/B2VDntkqihWhjFtlEQWwa2wOsrpzC8qptEDqeB0Rzi
	 vVWiI2PfHT3jQ==
From: Vinod Koul <vkoul@kernel.org>
To: Bard Liao <yung-chuan.liao@linux.intel.com>,
 Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
 Sanyog Kale <sanyog.r.kale@intel.com>,
 Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc: alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
In-Reply-To: <20240703-soundwire-cleanup-h-v1-0-24fa0dbb948f@linaro.org>
References: <20240703-soundwire-cleanup-h-v1-0-24fa0dbb948f@linaro.org>
Subject: Re: [PATCH 0/9] soundwire: simplify code with cleanup.h
Message-Id: <172059035617.363871.9938538584566291024.b4-ty@kernel.org>
Date: Wed, 10 Jul 2024 11:15:56 +0530
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.13.0
Message-ID-Hash: V2TYAA5NCGVTS5DHQMJBSHDRRVPCOV6E
X-Message-ID-Hash: V2TYAA5NCGVTS5DHQMJBSHDRRVPCOV6E
X-MailFrom: vkoul@kernel.org
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency;
 loop; banned-address; member-moderation;
 header-match-alsa-devel.alsa-project.org-0;
 header-match-alsa-devel.alsa-project.org-1; nonmember-moderation;
 administrivia; implicit-dest; max-recipients; max-size; news-moderation;
 no-subject; digests; suspicious-header
X-Mailman-Version: 3.3.9
Precedence: list
List-Id: "Alsa-devel mailing list for ALSA developers -
 http://www.alsa-project.org" <alsa-devel.alsa-project.org>
Archived-At: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/V2TYAA5NCGVTS5DHQMJBSHDRRVPCOV6E/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>


On Wed, 03 Jul 2024 12:15:52 +0200, Krzysztof Kozlowski wrote:
> Allocate the memory with scoped/cleanup.h to reduce error handling
> (simpler error paths) and make the code a bit smaller.
> 
> Best regards,
> Krzysztof
> 

Applied, thanks!

[1/9] soundwire: amd: simplify return path in hw_params
      commit: 89cc1354d388ba8c8f8b41095736202a83591497
[2/9] soundwire: amd: simplify with cleanup.h
      commit: 02611eeec5893c17ad85769007ecfb5cbe7a5987
[3/9] soundwire: amd_init: simplify with cleanup.h
      commit: 1f93cb229b0e2d78233690c9ca65715e1f798803
[4/9] soundwire: intel: simplify return path in hw_params
      commit: ba874a8c2f895d898bbaf67f9e952425aff1557d
[5/9] soundwire: intel: simplify with cleanup.h
      commit: e4fcf153d91809aefa6860d285e747fd7dd9e61c
[6/9] soundwire: intel_ace2x: simplify return path in hw_params
      commit: 13814ed162687be08e34762040cfc2e58831219d
[7/9] soundwire: intel_ace2x: simplify with cleanup.h
      commit: 3dce65898e0911aa76a0a321540b78e9218b9a6a
[8/9] soundwire: cadence: simplify with cleanup.h
      commit: b72d4af98cae2f74dc8061befcc3c0c2a174894f
[9/9] soundwire: debugfs: simplify with cleanup.h
      commit: fdd3d14ca3c8c5269174f10d33d6181173cbd0b4

Best regards,
-- 
Vinod Koul <vkoul@kernel.org>

