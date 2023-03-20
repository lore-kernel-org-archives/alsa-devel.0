Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A2CB6C7618A
	for <alsa-devel@archiver.kernel.org>; Mon, 20 Mar 2023 09:13:55 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 731491F4;
	Mon, 20 Mar 2023 10:13:02 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 731491F4
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1679303632;
	bh=eJDi7VmCJPwdhn51rls84NY3kMe6hLd/04eqYQ7vwx4=;
	h=From:To:In-Reply-To:References:Subject:Date:List-Id:List-Archive:
	 List-Help:List-Owner:List-Post:List-Subscribe:List-Unsubscribe:
	 From;
	b=NalMfi/bwGk6Lfzl1zUHlPXbE+M3872kTnv1Ipygismg/Dn5Gf+Zxyf4ygUqO1jLU
	 BN8TawB13q4X/ayxDHCqwHoOQCc947iXjSiZ+Rjb6K9J8TxAvkgLib0mJVodp4HnCj
	 xeuFICwSNtiMlZFanR8JTLNz9fTQNEpZ+9zkdtS8=
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id EFBAFF8027B;
	Mon, 20 Mar 2023 10:12:40 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id B1002F8027B; Mon, 20 Mar 2023 10:12:35 +0100 (CET)
Received: from webhooks-bot.alsa-project.org (vmi242170.contaboserver.net
 [207.180.221.201])
	by alsa1.perex.cz (Postfix) with ESMTP id CFF3EF800C9
	for <alsa-devel@alsa-project.org>; Mon, 20 Mar 2023 10:12:29 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz CFF3EF800C9
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
From: GitHub issues - opened <github@alsa-project.org>
To: alsa-devel@alsa-project.org
In-Reply-To: <1679303549731095314-webhooks-bot@alsa-project.org>
References: <1679303549731095314-webhooks-bot@alsa-project.org>
Subject: Using mili/micro/nanoseconds in split files
Message-Id: <20230320091235.B1002F8027B@alsa1.perex.cz>
Date: Mon, 20 Mar 2023 10:12:35 +0100 (CET)
Message-ID-Hash: WLWWZJQBYWKDCQFK7SPEB7HHC6GHJ3OJ
X-Message-ID-Hash: WLWWZJQBYWKDCQFK7SPEB7HHC6GHJ3OJ
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
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/WLWWZJQBYWKDCQFK7SPEB7HHC6GHJ3OJ/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

alsa-project/alsa-tools issue #15 was opened from kfilipan:

This is more of a feature request rather than an issue. When using `arecord` with `--max-file-time` and `--use-strftime`, one cannot get nanoseconds in the file name. This is however available in the e.g. `date` command `date +"%Y-%m-%d_%H-%M-%S.%N"` (`%N` gives nanoseconds). This would be useful for testing sound card recording time delays because having only seconds is not precise enough, e.g. it could take days or weeks for even slightly better sound cards to experience a second of delay. Thank you!

Issue URL     : https://github.com/alsa-project/alsa-tools/issues/15
Repository URL: https://github.com/alsa-project/alsa-tools
