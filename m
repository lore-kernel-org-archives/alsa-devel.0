Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8CC33EB7EB5
	for <alsa-devel@archiver.kernel.org>; Wed,  4 Mar 2026 09:41:56 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [45.14.194.44])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id ED49560237;
	Wed,  4 Mar 2026 10:41:43 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz ED49560237
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1772617314;
	bh=OeEKMK7jiDWsQozRkYh7/F2rzCFsychqZ2r0sZ8MwxI=;
	h=From:To:In-Reply-To:References:Subject:Date:List-Id:List-Archive:
	 List-Help:List-Owner:List-Post:List-Subscribe:List-Unsubscribe:
	 From;
	b=kOSxUp7mKTigAuIWWgf4R8vKMD5yg/7RhG25ErtZMBq92EqZHkrs/JKjFDCUZIobf
	 jT+m3Av9vqb1mw6Hney+bKv3ASWXi25VsrT/kmlwHv1/cxBWhO7hHtIVP+RWJnvSC0
	 clNqikJN+C4ja0x14Iism3q0dyGk9rXY3A+R6VLM=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id D0B9DF805F5; Wed,  4 Mar 2026 10:41:20 +0100 (CET)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id 27430F805F3;
	Wed,  4 Mar 2026 10:41:20 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id EC61FF805B5; Wed,  4 Mar 2026 10:41:09 +0100 (CET)
Received: from webhooks-bot.alsa-project.org (vmi2259423.contaboserver.net
 [45.14.194.44])
	by alsa1.perex.cz (Postfix) with ESMTP id D2B14F804E5
	for <alsa-devel@alsa-project.org>; Wed,  4 Mar 2026 10:41:06 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz D2B14F804E5
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
From: GitHub pull_request - opened <github@alsa-project.org>
To: alsa-devel@alsa-project.org
Message-Id: <18999a02facfff00-webhooks-bot@alsa-project.org>
In-Reply-To: <alsa-project/alsa-ucm-conf/pr/713@alsa-project.org>
References: <alsa-project/alsa-ucm-conf/pr/713@alsa-project.org>
Subject: Qualcomm: glymur: Add GLYMUR CRD HiFi config
Date: Wed,  4 Mar 2026 10:41:09 +0100 (CET)
Message-ID-Hash: 5BAZX7WN7DTN5STFF7OWLLX7KE6JEQL6
X-Message-ID-Hash: 5BAZX7WN7DTN5STFF7OWLLX7KE6JEQL6
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
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/5BAZX7WN7DTN5STFF7OWLLX7KE6JEQL6/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

alsa-project/alsa-ucm-conf pull request #713 was opened from mohsRafi:

Add UCM2 configs for the Qualcomm GLYMUR CRD Board.

Request URL   : https://github.com/alsa-project/alsa-ucm-conf/pull/713
Patch URL     : https://github.com/alsa-project/alsa-ucm-conf/pull/713.patch
Repository URL: https://github.com/alsa-project/alsa-ucm-conf
