Return-Path: <SRS0=wkXm=LE=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D4E36C47094
	for <alsa-devel@archiver.kernel.org>; Thu, 10 Jun 2021 11:54:44 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 588A761406
	for <alsa-devel@archiver.kernel.org>; Thu, 10 Jun 2021 11:54:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 588A761406
Authentication-Results: mail.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=alsa-project.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id B210B1786;
	Thu, 10 Jun 2021 13:53:51 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz B210B1786
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1623326081;
	bh=zyLGIhMelTrKmjD64+4lMcfrQmC2wjVKVf3hR/rcqWc=;
	h=From:To:In-Reply-To:References:Subject:Date:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=LolrDIwlczfWuCC6uXYdVGfOvi92fznOLObT5GHDUVcxB/QiVzbXzXHdlPYAYTzh/
	 WPEmIHItBW20427OtyEdPONYQiI9h9jnGcXc1ammUPED4DGq5Z+2l52D8Ivb5I5hoF
	 fv0aSyNfllMMjwwfIV9StgVN2Tlq9YxFJdCKwwiM=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 430B7F8020D;
	Thu, 10 Jun 2021 13:53:51 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id B0069F80218; Thu, 10 Jun 2021 13:53:50 +0200 (CEST)
Received: from webhooks-bot.alsa-project.org (gate.perex.cz [77.48.224.242])
 by alsa1.perex.cz (Postfix) with ESMTP id 71534F801EC
 for <alsa-devel@alsa-project.org>; Thu, 10 Jun 2021 13:53:43 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 71534F801EC
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
From: GitHub issues - opened <github@alsa-project.org>
To: alsa-devel@alsa-project.org
In-Reply-To: <1623326022462129116-webhooks-bot@alsa-project.org>
References: <1623326022462129116-webhooks-bot@alsa-project.org>
Subject: Undeclarated constant
Message-Id: <20210610115350.B0069F80218@alsa1.perex.cz>
Date: Thu, 10 Jun 2021 13:53:50 +0200 (CEST)
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

alsa-project/alsa-plugins issue #24 was opened from unknown2045:

Hi,
I am trying to install the alsa-plugins, when I do the make command I get the following errors:

![Captura de pantalla de 2021-06-10 13-52-37](https://user-images.githubusercontent.com/85682900/121520376-229ecb00-c9f3-11eb-9230-3f5ace4c3042.png)

How can I solve it?

Thanks in advance!

Issue URL     : https://github.com/alsa-project/alsa-plugins/issues/24
Repository URL: https://github.com/alsa-project/alsa-plugins
