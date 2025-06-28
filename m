Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 41E0BC7EE32
	for <alsa-devel@archiver.kernel.org>; Sat, 28 Jun 2025 12:09:29 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [45.14.194.44])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 3E15060202;
	Sat, 28 Jun 2025 14:09:17 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 3E15060202
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1751112567;
	bh=eqeWcCjPPiZO/i4GcY70xQz1rr4iDh3i56ZticLlDTU=;
	h=From:To:In-Reply-To:References:Subject:Date:List-Id:List-Archive:
	 List-Help:List-Owner:List-Post:List-Subscribe:List-Unsubscribe:
	 From;
	b=RhGD+1riAfFWhRczSCmse3srqj3WJ/mUQz9Bjj24tY1tSf0X1GFjtuD+HTmMdfIf1
	 dFhCVNNP51Ia5dIKSTDd789/QuVHLHN76LET/N3JtmIdBZD2ac/CBgd4Tg3EDdlrWo
	 6MhybSoe3KbzP+rM4ILjH3jt+EdDjDbcJyD8kwp4=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 08C76F805C6; Sat, 28 Jun 2025 14:08:53 +0200 (CEST)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id D2A47F805CA;
	Sat, 28 Jun 2025 14:08:53 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id B6C5DF80494; Sat, 28 Jun 2025 14:08:50 +0200 (CEST)
Received: from webhooks-bot.alsa-project.org (vmi2259423.contaboserver.net
 [45.14.194.44])
	by alsa1.perex.cz (Postfix) with ESMTP id 123A4F80124
	for <alsa-devel@alsa-project.org>; Sat, 28 Jun 2025 14:08:48 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 123A4F80124
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
From: GitHub pull_request - opened <github@alsa-project.org>
To: alsa-devel@alsa-project.org
Message-Id: <184d339127263900-webhooks-bot@alsa-project.org>
In-Reply-To: <alsa-project/alsa-ucm-conf/pr/587@alsa-project.org>
References: <alsa-project/alsa-ucm-conf/pr/587@alsa-project.org>
Subject: ucm2: Qualcomm: add Dell XPS 9345
Date: Sat, 28 Jun 2025 14:08:50 +0200 (CEST)
Message-ID-Hash: IBCCQ7QCOFHHAX3IBCD2KXOS226LMZMV
X-Message-ID-Hash: IBCCQ7QCOFHHAX3IBCD2KXOS226LMZMV
X-MailFrom: github@alsa-project.org
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
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/IBCCQ7QCOFHHAX3IBCD2KXOS226LMZMV/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

alsa-project/alsa-ucm-conf pull request #587 was opened from alexVinarskis:

Add a Regex string, seems to be mostly compatible with Yoga Slim7x. x4 speakers, x2 DMICs (unlike Yoga's 4), x2 DP, no headphone jack. DMI_info evaluates to `Dell Inc.-XPS-0DXPNM`. It appears to be okay to re-use Yoga, as [only 2 microphone channels are considered](https://github.com/alsa-project/alsa-ucm-conf/blob/master/ucm2/Qualcomm/x1e80100/Slim7x-HiFi.conf#L40-L43).

Audio part of Dell XPS 9345 DT is available [out of tree](https://github.com/alexVinarskis/linux-x1e80100-dell-tributo), will be submitted to the lists shortly. audioreach-topology was [merged a while ago](https://github.com/linux-msm/audioreach-topology/pull/20).

Tested that speakers, MICs are working.

**Known issues:** L and R sides are swapped due to kernel driver not taking DT labels into account just yet, and particular platform having WSAs connected to different soundwires interfaces than the rest of x1e80100 devices. Identified by Abel Vesa at Linaro. Fix will be on the kernel and/or DT side.

Request URL   : https://github.com/alsa-project/alsa-ucm-conf/pull/587
Patch URL     : https://github.com/alsa-project/alsa-ucm-conf/pull/587.patch
Repository URL: https://github.com/alsa-project/alsa-ucm-conf
