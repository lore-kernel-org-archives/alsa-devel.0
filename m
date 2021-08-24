Return-Path: <SRS0=yNKw=NP=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B383AC4338F
	for <alsa-devel@archiver.kernel.org>; Tue, 24 Aug 2021 10:00:28 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0528A6120A
	for <alsa-devel@archiver.kernel.org>; Tue, 24 Aug 2021 10:00:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 0528A6120A
Authentication-Results: mail.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=alsa-project.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 7723D84C;
	Tue, 24 Aug 2021 11:59:35 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 7723D84C
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1629799225;
	bh=VvPTKKufmvnOEnFUypkRs7dpbx4C1pDQEvr+rWErewU=;
	h=From:To:In-Reply-To:References:Subject:Date:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=ulFRiV070ek4VlT8Cx1Rr62LkcmP9HrNZ+m/TfdXfD3q70l0gdLHIqujTO3g/Mcs7
	 5Ey+UnS/QIocwOnRAWPGjiw2YjD2ODfEVceDGkx5VlW6QDt83lXsmXJZOXPeDv2gcW
	 +Poipi1vA/y0182of/m8UJh07abye8nLBSrmayxU=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 0BCC6F80087;
	Tue, 24 Aug 2021 11:59:35 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id A46FEF801D8; Tue, 24 Aug 2021 11:59:33 +0200 (CEST)
Received: from webhooks-bot.alsa-project.org (gate.perex.cz [77.48.224.242])
 by alsa1.perex.cz (Postfix) with ESMTP id 723A8F80087
 for <alsa-devel@alsa-project.org>; Tue, 24 Aug 2021 11:59:23 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 723A8F80087
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
From: GitHub issues - opened <github@alsa-project.org>
To: alsa-devel@alsa-project.org
In-Reply-To: <1629799158080141068-webhooks-bot@alsa-project.org>
References: <1629799158080141068-webhooks-bot@alsa-project.org>
Subject: Pinebook Pro's audio does not work
Message-Id: <20210824095933.A46FEF801D8@alsa1.perex.cz>
Date: Tue, 24 Aug 2021 11:59:33 +0200 (CEST)
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

alsa-project/alsa-ucm-conf issue #110 was opened from starnight:

I have a Pinebook Pro whose audio (including the internal speaker, headphone and internal MIC) does not work by default with general Linux.

Here is the [alsa-info.txt](https://github.com/alsa-project/alsa-ucm-conf/files/7037916/alsa-info.txt)

I notice Manjaro ARM has [asound.state](https://gitlab.manjaro.org/manjaro-arm/packages/community/pinebookpro-post-install/-/blob/master/asound.state) in [pinebookpro-post-install](https://gitlab.manjaro.org/manjaro-arm/packages/community/pinebookpro-post-install) package.  If I install the [asound.state](https://gitlab.manjaro.org/manjaro-arm/packages/community/pinebookpro-post-install/-/blob/master/asound.state) into `/var/lib/alsa/`, then `alsactl restore`, all of the audio works!

However, I guess that **asound.state** is produced as a result, not the original configuration.  If this relates to alsa-ucm-conf project, how should I configure the ucm for Pinebook Pro's audio?

Issue URL     : https://github.com/alsa-project/alsa-ucm-conf/issues/110
Repository URL: https://github.com/alsa-project/alsa-ucm-conf
