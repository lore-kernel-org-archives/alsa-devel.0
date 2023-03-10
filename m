Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DABB6C6FD19
	for <alsa-devel@archiver.kernel.org>; Fri, 10 Mar 2023 19:19:26 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 0959117F7;
	Fri, 10 Mar 2023 20:18:34 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 0959117F7
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1678475964;
	bh=XzCf/+ATeKmfPYySHOBMRueenNzNsaWDxYQoLFXrA0E=;
	h=From:To:In-Reply-To:References:Subject:Date:List-Id:List-Archive:
	 List-Help:List-Owner:List-Post:List-Subscribe:List-Unsubscribe:
	 From;
	b=dvsM+JAO3GgT7O85PNT6nA/8S1wGu6k9LlORVrw+2f2NufyxjZ8CbK2heE2WcDV8r
	 NfJP8SX6kbAuxDg6Hpbo/joEl9ukyFrK7TkF9fn5FI3RoMOcVCBtB4Ua63pOJC29nR
	 1P/ZPE7dRFXnseVnctciSYQeOb8tXVjMlLvZjTYs=
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id 1DC75F80093;
	Fri, 10 Mar 2023 20:18:12 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 3F0D6F8042F; Fri, 10 Mar 2023 20:18:08 +0100 (CET)
Received: from webhooks-bot.alsa-project.org (vmi242170.contaboserver.net
 [207.180.221.201])
	by alsa1.perex.cz (Postfix) with ESMTP id 96C67F800DF
	for <alsa-devel@alsa-project.org>; Fri, 10 Mar 2023 20:18:04 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 96C67F800DF
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
From: GitHub issues - opened <github@alsa-project.org>
To: alsa-devel@alsa-project.org
In-Reply-To: <1678475883469756126-webhooks-bot@alsa-project.org>
References: <1678475883469756126-webhooks-bot@alsa-project.org>
Subject: amidi or aplaymidi filtering
Message-Id: <20230310191808.3F0D6F8042F@alsa1.perex.cz>
Date: Fri, 10 Mar 2023 20:18:08 +0100 (CET)
Message-ID-Hash: 6T7WME3PLPQR2OD3223BOLAJU2UU63KX
X-Message-ID-Hash: 6T7WME3PLPQR2OD3223BOLAJU2UU63KX
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
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/6T7WME3PLPQR2OD3223BOLAJU2UU63KX/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

alsa-project/alsa-utils issue #194 was opened from wraybowling:

I would like to see filtering in either aplaymidi so things like sysex messages can be ignored. Or, as a compromise, if it's more appropriate to add to amidi, then a user would pipe the midi output from aplaymidi to amidi with that filtering. I would find the latter solution to be more clunky though.

Issue URL     : https://github.com/alsa-project/alsa-utils/issues/194
Repository URL: https://github.com/alsa-project/alsa-utils
