Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A9CA7CD8CA8
	for <alsa-devel@archiver.kernel.org>; Sun, 14 Jun 2026 19:15:07 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [45.14.194.44])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id CA6296019C;
	Sun, 14 Jun 2026 21:14:54 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz CA6296019C
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1781464504;
	bh=C6drdSS6nmRw5Oq/6zJT922ykfgja5SlZ+0aC8VuZ00=;
	h=From:To:In-Reply-To:References:Subject:Date:List-Id:List-Archive:
	 List-Help:List-Owner:List-Post:List-Subscribe:List-Unsubscribe:
	 From;
	b=hWi0kJU33YLZwqV10wmtB81PyvutmsQ6JGW+mV8evKemMJPyxYBs/DQXOscnpYLiT
	 uP8FPjr9TKnWAuHGn5YnccYUl/7Qo5IqTDT2IdxPV/3uvfV/LKcRjtWRJu8iNZfvsu
	 cPmdQm5RzIedfaxRH2u+J8uYdno1bt6sU1RzR/Q4=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 9A5D0F805F8; Sun, 14 Jun 2026 21:14:30 +0200 (CEST)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id EFBB6F80600;
	Sun, 14 Jun 2026 21:14:29 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 9C7ECF80524; Sun, 14 Jun 2026 21:14:24 +0200 (CEST)
Authentication-Results: alsa1.perex.cz; arc=none smtp.remote-ip=45.14.194.44
ARC-Seal: i=1; d=alsa-project.org; s=arc; a=rsa-sha256; cv=none; t=1781464464;
	b=qKg2kAgRnZPorYeh5rP8hnP8t8wXTskBegJKP9cKwv6DbHwK1E8iF2HUa6HcHOFfdn9Q
	 Q68y1rNwa0MXKd7hRSV8oqXS3inkTV94LEjmPt5x7pqFe3D/LOHkXILMGnneAVetmtYrG
	 SyMz75vBT8Q37dn0S2dASC8EYtY45ohLuVrntIWXm0QUm3Cj35jBF34HcS4y4ocXCgqzB
	 u5iksyifpbQhkZiJpEvgoUNGfVhL3+tKCs9Ci+BaVOtbkV1GnPJCy2m9nwBc6tyeZ1MXM
	 i/JOwGVFCSO7XOVp667Mf+9j7v9jfYh5sJKjMbuKHhFaNxbOGbWAvDvcZiKYxOYBnbw==
ARC-Message-Signature: i=1; d=alsa-project.org; s=arc; a=rsa-sha256;
	c=relaxed/simple; t=1781464464;
	h=MIME-Version:From:To:Message-Id:Subject;
	bh=C6drdSS6nmRw5Oq/6zJT922ykfgja5SlZ+0aC8VuZ00=;
	b=Czcbre8q6JGiVJzONanzyPoyDZ1En4OxrdNnCdFSI9w6mpB6c+YPFdkTGyzpk5MiiEDn
	 Gwq/pXzvRoNQBjZDWN8ItGR5+9fF620TP82e3kbIjjmKcvgc+Yml3Y7rV2Xikq9qWBFQK
	 h38DtcyPBnhtzZ1AO5juGEFJUUxCOvs4yZe8mppJHYkmfJSJd6wmstsa35Fq9pekzEuQs
	 dr8kBY7V1BPGDrWdq++vhRs1uGGzgb2c/MhPdmp1xIU3k7NaJtcwXWDnIBvnL9cmGyLyx
	 VT/C0X1uTLMZ5JBHBpfToM4nkF67BOstTFygJLDvrinHIzHMPZhf+pSfgkpXtV3MsAA==
ARC-Authentication-Results: i=1; alsa1.perex.cz;
 arc=none smtp.remote-ip=45.14.194.44
Received: from webhooks-bot.alsa-project.org (vmi2259423.contaboserver.net
 [45.14.194.44])
	by alsa1.perex.cz (Postfix) with ESMTP id 23647F80100
	for <alsa-devel@alsa-project.org>; Sun, 14 Jun 2026 21:14:22 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 23647F80100
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
From: GitHub pull_request - opened <github@alsa-project.org>
To: alsa-devel@alsa-project.org
Message-Id: <18b9087d72a20600-webhooks-bot@alsa-project.org>
In-Reply-To: <alsa-project/alsa-lib/pr/511@alsa-project.org>
References: <alsa-project/alsa-lib/pr/511@alsa-project.org>
Subject: conf: fix snd_func_imul accumulator initialization
Date: Sun, 14 Jun 2026 21:14:24 +0200 (CEST)
Message-ID-Hash: N2KM7QKV2RQIWFU3JTLMSSNQ6TUE6NVF
X-Message-ID-Hash: N2KM7QKV2RQIWFU3JTLMSSNQ6TUE6NVF
X-MailFrom: github@alsa-project.org
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; loop;
 banned-address; header-match-alsa-devel.alsa-project.org-0;
 header-match-alsa-devel.alsa-project.org-1; emergency; member-moderation;
 nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size;
 news-moderation; no-subject; digests; suspicious-header
X-Mailman-Version: 3.3.10
Precedence: list
List-Id: "Alsa-devel mailing list for ALSA developers -
 http://www.alsa-project.org" <alsa-devel.alsa-project.org>
Archived-At: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/N2KM7QKV2RQIWFU3JTLMSSNQ6TUE6NVF/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

alsa-project/alsa-lib pull request #511 was opened from orange-dot:

snd_func_iops() initialized result to 0 for both iadd and imul. For
imul, every multiplication step therefore multiplied by 0, so @func imul
always evaluated to 0.

Initialize the accumulator to 1 for imul, while preserving the existing
0 result for an empty integers list. Add regression coverage for iadd and
imul evaluation.

Fixes: https://github.com/alsa-project/alsa-lib/issues/456

Request URL   : https://github.com/alsa-project/alsa-lib/pull/511
Patch URL     : https://github.com/alsa-project/alsa-lib/pull/511.patch
Repository URL: https://github.com/alsa-project/alsa-lib
