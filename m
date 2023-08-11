Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DB961EB64DD
	for <alsa-devel@archiver.kernel.org>; Fri, 11 Aug 2023 16:49:10 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 4A5AF82C;
	Fri, 11 Aug 2023 18:48:13 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 4A5AF82C
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1691772543;
	bh=QwbdI+d1fSBoR7LNQF5X6YbqsBSiNv4gmh/zLfcouo0=;
	h=From:To:In-Reply-To:References:Subject:Date:List-Id:List-Archive:
	 List-Help:List-Owner:List-Post:List-Subscribe:List-Unsubscribe:
	 From;
	b=rriimxVjryMc1NG+1xlHE3/dEXVqqZPVA0yXhe3Db2TmTJ39CAgxEMbuZJtLxgHKa
	 SmqG43k6jU62Ca0Kglglactzzra9bnSzRamzhhz3jueigLGd00GByUqmNMHKdShit6
	 7P5kZ5Dh87ZK4Pta/k9fwtiRSco+KagnjduEcJXo=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 45E01F8055C; Fri, 11 Aug 2023 18:47:27 +0200 (CEST)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id D7B97F80553;
	Fri, 11 Aug 2023 18:47:26 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 60F18F80557; Fri, 11 Aug 2023 18:47:23 +0200 (CEST)
Received: from webhooks-bot.alsa-project.org (vmi242170.contaboserver.net
 [207.180.221.201])
	by alsa1.perex.cz (Postfix) with ESMTP id D7199F800F4
	for <alsa-devel@alsa-project.org>; Fri, 11 Aug 2023 18:47:21 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz D7199F800F4
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
From: GitHub pull_request - edited <github@alsa-project.org>
To: alsa-devel@alsa-project.org
In-Reply-To: <1691772441844830990-webhooks-bot@alsa-project.org>
References: <1691772441844830990-webhooks-bot@alsa-project.org>
Subject: [RFC] pcm: Add MSBITS subformat options
Message-Id: <20230811164723.60F18F80557@alsa1.perex.cz>
Date: Fri, 11 Aug 2023 18:47:23 +0200 (CEST)
Message-ID-Hash: PJILHKWGNKZX5EPNM4QYSGMYL5GF7CF2
X-Message-ID-Hash: PJILHKWGNKZX5EPNM4QYSGMYL5GF7CF2
X-MailFrom: github@alsa-project.org
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency;
 loop; banned-address; member-moderation;
 header-match-alsa-devel.alsa-project.org-0;
 header-match-alsa-devel.alsa-project.org-1; nonmember-moderation;
 administrivia; implicit-dest; max-recipients; max-size; news-moderation;
 no-subject; digests; suspicious-header
X-Mailman-Version: 3.3.8
Precedence: list
List-Id: "Alsa-devel mailing list for ALSA developers -
 http://www.alsa-project.org" <alsa-devel.alsa-project.org>
Archived-At: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/PJILHKWGNKZX5EPNM4QYSGMYL5GF7CF2/>
List-Archive: <>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

alsa-project/alsa-lib pull request #342 was edited from crojewsk-intel:

Improve granularity of format selection for S32/U32 formats by adding masks representing 20, 24 and 32 most significant bits. As a preparation step introduce `snd_pcm_subformat_value()` for easy name-to-subformat conversions.

While at it, fix few warnings that pop up in subformat-related code during compilation.

Request URL   : https://github.com/alsa-project/alsa-lib/pull/342
Patch URL     : https://github.com/alsa-project/alsa-lib/pull/342.patch
Repository URL: https://github.com/alsa-project/alsa-lib
