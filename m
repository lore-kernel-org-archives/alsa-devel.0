Return-Path: <SRS0=jKKe=K3=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 592A5C4708F
	for <alsa-devel@archiver.kernel.org>; Tue,  1 Jun 2021 16:50:09 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6D445613C1
	for <alsa-devel@archiver.kernel.org>; Tue,  1 Jun 2021 16:50:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6D445613C1
Authentication-Results: mail.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=alsa-project.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 0AB2F16BA;
	Tue,  1 Jun 2021 18:49:17 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 0AB2F16BA
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1622566207;
	bh=Cng6dvv/xqaql8Sw5b9zEDO8B5LxbBg9LdrC76G2FDk=;
	h=From:To:In-Reply-To:References:Subject:Date:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=cDowwLgGlChwPDmw38YVzX1/TkPzxZyJA3fa7W8ouc738VKJFasJiblaHiInXx4oc
	 9FJeq9I+k5rZuGbzyThTgT+CVD/NubYTyXaEs0FMbEuw7moAu/4oq4O8XDTJKAASPR
	 0Wlgs96OdnXAN7i67aOP6GEZVw93k11p5RiuWfi8=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id A380AF80253;
	Tue,  1 Jun 2021 18:49:16 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id CACC8F80269; Tue,  1 Jun 2021 18:49:14 +0200 (CEST)
Received: from webhooks-bot.alsa-project.org (gate.perex.cz [77.48.224.242])
 by alsa1.perex.cz (Postfix) with ESMTP id 6BC86F80141
 for <alsa-devel@alsa-project.org>; Tue,  1 Jun 2021 18:49:11 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 6BC86F80141
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
From: GitHub issues - edited <github@alsa-project.org>
To: alsa-devel@alsa-project.org
In-Reply-To: <1622566151294723034-webhooks-bot@alsa-project.org>
References: <1622566151294723034-webhooks-bot@alsa-project.org>
Subject: alsa-lib 1.2.5 no devices on Lenovo Carbon (gen 7) - pipewire
Message-Id: <20210601164914.CACC8F80269@alsa1.perex.cz>
Date: Tue,  1 Jun 2021 18:49:14 +0200 (CEST)
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

alsa-project/alsa-lib issue #142 was edited from sambo57u:

I use Fedora 34 and updated alsa-lib and all other alsa products to version 1.2.5. They work fine on my desktop machines but on Lenovo laptop I am getting the message alsactl cannot find hw:0 and daemon deactivates with no devices showing. Downgrading
to 1.2.4 solves the problem.

Issue URL     : https://github.com/alsa-project/alsa-lib/issues/142
Repository URL: https://github.com/alsa-project/alsa-lib
