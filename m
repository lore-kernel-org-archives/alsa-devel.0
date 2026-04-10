Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 060E4E99052
	for <alsa-devel@archiver.kernel.org>; Fri, 10 Apr 2026 08:09:12 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [45.14.194.44])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id CBB3260205;
	Fri, 10 Apr 2026 10:08:59 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz CBB3260205
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1775808549;
	bh=6PlSzo/x/D6SiFUnVlWmMBMrUyd3/1woGI2OIy0j8tU=;
	h=From:To:In-Reply-To:References:Subject:Date:List-Id:List-Archive:
	 List-Help:List-Owner:List-Post:List-Subscribe:List-Unsubscribe:
	 From;
	b=XKh7e7Emh5OOsZfNI4gEl7BHPKsQh1b4xLdZAHu6GKUQ1Bj3+XWal929PtuvHSTDv
	 8adENiWckpFcmu1vT4DIa2pg95ewtf9aWOdCsh3bfPv+NaaDM7VT/UmcbzsVEHQUX9
	 iHnNISqFM+1YNzH7f2rcqJPvrG3Nsk8b4V2yw7Pc=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id EFD47F805E8; Fri, 10 Apr 2026 10:08:36 +0200 (CEST)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id 5C973F805EE;
	Fri, 10 Apr 2026 10:08:36 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 2857DF8052D; Fri, 10 Apr 2026 10:08:26 +0200 (CEST)
Received: from webhooks-bot.alsa-project.org (vmi2259423.contaboserver.net
 [45.14.194.44])
	by alsa1.perex.cz (Postfix) with ESMTP id 6BADFF80100
	for <alsa-devel@alsa-project.org>; Fri, 10 Apr 2026 10:08:22 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 6BADFF80100
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
From: GitHub pull_request - opened <github@alsa-project.org>
To: alsa-devel@alsa-project.org
Message-Id: <18a4f06cb932ac00-webhooks-bot@alsa-project.org>
In-Reply-To: <alsa-project/alsa-ucm-conf/pr/743@alsa-project.org>
References: <alsa-project/alsa-ucm-conf/pr/743@alsa-project.org>
Subject: Support Lenovo laptops with rt722 and rt1320 codecs
Date: Fri, 10 Apr 2026 10:08:26 +0200 (CEST)
Message-ID-Hash: KFCBMMFSGTZI74IRSGE7DQFSF3GZJCLI
X-Message-ID-Hash: KFCBMMFSGTZI74IRSGE7DQFSF3GZJCLI
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
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/KFCBMMFSGTZI74IRSGE7DQFSF3GZJCLI/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

alsa-project/alsa-ucm-conf pull request #743 was opened from oortcomet:

Add configs to support Lenovo laptops with rt722 and rt1320 codecs.

Request URL   : https://github.com/alsa-project/alsa-ucm-conf/pull/743
Patch URL     : https://github.com/alsa-project/alsa-ucm-conf/pull/743.patch
Repository URL: https://github.com/alsa-project/alsa-ucm-conf
