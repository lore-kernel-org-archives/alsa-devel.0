Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 45060C433FE
	for <alsa-devel@archiver.kernel.org>; Mon,  3 Oct 2022 01:00:10 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 7F2FF2803;
	Mon,  3 Oct 2022 02:59:18 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 7F2FF2803
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1664758808;
	bh=QB5F6VjouYR1UVv1z6b1Ik08dJXhmt1D99Myjm9Z8/8=;
	h=From:To:In-Reply-To:References:Subject:Date:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=GzyB1omb6jHZkxbt+tMwEv2J4N0z7lqvoD3cuNBq3iYXEbwkdh6t+PUXj+tf/LEJ/
	 2r68WXGF9X8gJSxXNfCiPzgYPkJiT+KEeSxhQb+MZ0ZfOV2BUVaazyr0603qNfZFgg
	 v3opF9zJYya2d8dA7aoSHecmvvp5bOLxv8V3Gstg=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 0E5D3F800CC;
	Mon,  3 Oct 2022 02:59:18 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 1DEEFF80246; Mon,  3 Oct 2022 02:59:17 +0200 (CEST)
Received: from webhooks-bot.alsa-project.org (gate.perex.cz [77.48.224.242])
 by alsa1.perex.cz (Postfix) with ESMTP id B3062F800CC
 for <alsa-devel@alsa-project.org>; Mon,  3 Oct 2022 02:59:14 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz B3062F800CC
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
From: GitHub issues - opened <github@alsa-project.org>
To: alsa-devel@alsa-project.org
In-Reply-To: <1664758754151483059-webhooks-bot@alsa-project.org>
References: <1664758754151483059-webhooks-bot@alsa-project.org>
Subject: Backport new UCM configs to 1.2.6 or document preferred upgrade method
Message-Id: <20221003005917.1DEEFF80246@alsa1.perex.cz>
Date: Mon,  3 Oct 2022 02:59:17 +0200 (CEST)
X-BeenThere: alsa-devel@alsa-project.org
X-Mailman-Version: 2.1.15
Precedence: list
List-Id: "Alsa-devel mailing list for ALSA developers -
 http://www.alsa-project.org" <alsa-devel.alsa-project.org>
List-Unsubscribe: <https://mailman.alsa-project.org/mailman/options/alsa-devel>, 
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <https://mailman.alsa-project.org/mailman/listinfo/alsa-devel>, 
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: "Alsa-devel" <alsa-devel-bounces@alsa-project.org>

alsa-project/alsa-ucm-conf issue #222 was opened from micimize:

In ubuntu the latest available `alsa-utils` is `1.2.6`, so `alsaucm reload`  throws a syntax error:
```
$ alsaucm reload
ALSA lib ucm_cond.c:155:(if_eval_regex_match) RegexMatch error (If.Condition.Regex)
ALSA lib main.c:1541:(snd_use_case_mgr_open) error: failed to import hw:1 use case configuration -22
alsaucm: error failed to open sound card hw:1: Invalid argument
```

Issue URL     : https://github.com/alsa-project/alsa-ucm-conf/issues/222
Repository URL: https://github.com/alsa-project/alsa-ucm-conf
