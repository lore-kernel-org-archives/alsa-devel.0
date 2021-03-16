Return-Path: <SRS0=ENK7=IO=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EFFAFC433DB
	for <alsa-devel@archiver.kernel.org>; Tue, 16 Mar 2021 17:44:33 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3AEA265125
	for <alsa-devel@archiver.kernel.org>; Tue, 16 Mar 2021 17:44:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3AEA265125
Authentication-Results: mail.kernel.org; dmarc=pass (p=none dis=none) header.from=alsa-project.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id A8E0118D8;
	Tue, 16 Mar 2021 18:43:39 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz A8E0118D8
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1615916669;
	bh=1fBS5g9BvaOl9eQkcdb/ll2xKtMOyX0wWmhEeNzYM7g=;
	h=From:To:In-Reply-To:References:Subject:Date:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=D33oNpBOle2CqZgAtHQZdlxwDFK+0nrsbAmtmMeFoXHov2cocGnG/VOZwPpiaz3Vl
	 QlORceaemt3lyqT0slD5SkqCy/uIJNZYdOiIiyQM6lNqZVsGpFy07HwSOtfo1JaMb6
	 LatqTJDwFD+3FNVxHrHqPI5FOi+ETGDq/SmBGs9s=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 21B76F80156;
	Tue, 16 Mar 2021 18:43:39 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id BA9F7F80163; Tue, 16 Mar 2021 18:43:36 +0100 (CET)
Received: from webhooks-bot.alsa-project.org (gate.perex.cz [77.48.224.242])
 by alsa1.perex.cz (Postfix) with ESMTP id 1EF89F80148
 for <alsa-devel@alsa-project.org>; Tue, 16 Mar 2021 18:43:30 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 1EF89F80148
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
From: GitHub pull_request - opened <github@alsa-project.org>
To: alsa-devel@alsa-project.org
In-Reply-To: <1615916605202157974-webhooks-bot@alsa-project.org>
References: <1615916605202157974-webhooks-bot@alsa-project.org>
Subject: conf: No SPDIF on Plantronics 3220 headset
Message-Id: <20210316174336.BA9F7F80163@alsa1.perex.cz>
Date: Tue, 16 Mar 2021 18:43:36 +0100 (CET)
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

alsa-project/alsa-lib pull request #126 was opened from drjhe:

The Plantronics Blackwire 3220 Series headset (USB ID 047f:c056) shows up in GNOME Settings with a non-existent digital output. Add it to the list to suppress this.

Request URL   : https://github.com/alsa-project/alsa-lib/pull/126
Patch URL     : https://github.com/alsa-project/alsa-lib/pull/126.patch
Repository URL: https://github.com/alsa-project/alsa-lib
