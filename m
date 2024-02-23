Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9E191C54798
	for <alsa-devel@archiver.kernel.org>; Fri, 23 Feb 2024 04:51:55 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 806E5B70;
	Fri, 23 Feb 2024 05:51:43 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 806E5B70
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1708663913;
	bh=iEo6RNB1MGoq1fRK5HPMakKAYa2sXxhmXLt+4/bhZ3c=;
	h=From:To:In-Reply-To:References:Subject:Date:List-Id:List-Archive:
	 List-Help:List-Owner:List-Post:List-Subscribe:List-Unsubscribe:
	 From;
	b=XEZbVrcLvq8HJ2pcwhS4a43NI/mzDoORgPMIyW3tkSGgXJebI5m4Y/VgpWwfmXgEg
	 K/fDkZeVgpixz4el706p63hjhrAF+YuZk90o9G3vvXwPFcxxnD/7hDad0Lg4HnBKb2
	 maEFTEP52i2P3ti7AqlJ5N+NfGFkYOoCKwUvwECA=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 273C7F805AB; Fri, 23 Feb 2024 05:51:03 +0100 (CET)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id 67035F805B6;
	Fri, 23 Feb 2024 05:51:02 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id CDECEF80496; Fri, 23 Feb 2024 05:48:55 +0100 (CET)
Received: from webhooks-bot.alsa-project.org (vmi242170.contaboserver.net
 [207.180.221.201])
	by alsa1.perex.cz (Postfix) with ESMTP id 1D201F800EE
	for <alsa-devel@alsa-project.org>; Fri, 23 Feb 2024 05:48:51 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 1D201F800EE
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
From: GitHub pull_request - opened <github@alsa-project.org>
To: alsa-devel@alsa-project.org
In-Reply-To: <1708663729883996010-webhooks-bot@alsa-project.org>
References: <1708663729883996010-webhooks-bot@alsa-project.org>
Subject: Skip missing ladspa directories
Message-Id: <20240223044855.CDECEF80496@alsa1.perex.cz>
Date: Fri, 23 Feb 2024 05:48:55 +0100 (CET)
Message-ID-Hash: ORGLPMMRQ7HKRU2ZOZOHWS5J5YERMIHT
X-Message-ID-Hash: ORGLPMMRQ7HKRU2ZOZOHWS5J5YERMIHT
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
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/ORGLPMMRQ7HKRU2ZOZOHWS5J5YERMIHT/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

alsa-project/alsa-lib pull request #385 was opened from m42a:

If there is a nonexistent directory in the user's ladspa path, skip it instead of immediately failing the search.

Request URL   : https://github.com/alsa-project/alsa-lib/pull/385
Patch URL     : https://github.com/alsa-project/alsa-lib/pull/385.patch
Repository URL: https://github.com/alsa-project/alsa-lib
