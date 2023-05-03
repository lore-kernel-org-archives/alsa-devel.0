Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 13CF2C77B75
	for <alsa-devel@archiver.kernel.org>; Wed,  3 May 2023 14:50:25 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id B91241287;
	Wed,  3 May 2023 16:49:33 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz B91241287
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1683125423;
	bh=j/DoXZE5tcMsoj1vUSVMvpLdqie9YofqsfjW3h6Vyvo=;
	h=From:To:In-Reply-To:References:Subject:Date:List-Id:List-Archive:
	 List-Help:List-Owner:List-Post:List-Subscribe:List-Unsubscribe:
	 From;
	b=PDHi+ufg1YrsorTkogsVE/RA2f2fvrX84s3mK4E6FcdVdS454a1CT7YXah4f9+YiT
	 hdmKXd0r51iPzTi1KSEd+E15E78mYW7tVmQaavM4ghXJI857g81WfCVoEBUEzI8Dty
	 GbKztD155JlTr8Ms8QnvD+1w6ZHbjspHMISwSN70=
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id B2268F8052D;
	Wed,  3 May 2023 16:49:24 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 11976F8052E; Wed,  3 May 2023 16:49:22 +0200 (CEST)
Received: from webhooks-bot.alsa-project.org (vmi242170.contaboserver.net
 [207.180.221.201])
	by alsa1.perex.cz (Postfix) with ESMTP id B0995F80529
	for <alsa-devel@alsa-project.org>; Wed,  3 May 2023 16:49:20 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz B0995F80529
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
From: GitHub issues - edited <github@alsa-project.org>
To: alsa-devel@alsa-project.org
In-Reply-To: <1683125360709154606-webhooks-bot@alsa-project.org>
References: <1683125360709154606-webhooks-bot@alsa-project.org>
Subject: arecord: use better time granularity mili/micro/nanoseconds for split
 file names
Message-Id: <20230503144922.11976F8052E@alsa1.perex.cz>
Date: Wed,  3 May 2023 16:49:22 +0200 (CEST)
Message-ID-Hash: OB6I4NNAIMMGZSQIEBCWY562W4OYP2LF
X-Message-ID-Hash: OB6I4NNAIMMGZSQIEBCWY562W4OYP2LF
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
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/OB6I4NNAIMMGZSQIEBCWY562W4OYP2LF/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

alsa-project/alsa-utils issue #209 was edited from kfilipan:

This is more of a feature request rather than an issue. When using `arecord` with `--max-file-time` and `--use-strftime`, one cannot get nanoseconds in the file name. This is however available in the e.g. `date` command `date +"%Y-%m-%d_%H-%M-%S.%N"` (`%N` gives nanoseconds). This would be useful for testing sound card recording time delays because having only seconds is not precise enough, e.g. it could take days or weeks for even slightly better sound cards to experience a second of delay. Thank you!

Issue URL     : https://github.com/alsa-project/alsa-utils/issues/209
Repository URL: https://github.com/alsa-project/alsa-utils
