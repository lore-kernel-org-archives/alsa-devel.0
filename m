Return-Path: <SRS0=W9hU=NK=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 638B6C4338F
	for <alsa-devel@archiver.kernel.org>; Thu, 19 Aug 2021 18:35:54 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6B04F60E76
	for <alsa-devel@archiver.kernel.org>; Thu, 19 Aug 2021 18:35:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 6B04F60E76
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=vanheusden.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 3F1C51678;
	Thu, 19 Aug 2021 20:35:00 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 3F1C51678
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1629398150;
	bh=RYB1OWiATLy8nVP68r9qP+kO59GgKV6Y7AFx58xwnmw=;
	h=Date:From:To:Subject:References:In-Reply-To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=uq259RhQ24QwgMPfrqGTrwm3jEGMz/NTaoGJPsbSxwpC9hd3QZnN15r+REJPkV/F0
	 nEzb33Qvdhgp4XqMo81lO6ESe97V37xL+nN7JcKpbFAR6gFQTE3CGSGVgRF9kl88AC
	 32WGdS+8IWCl5B1l29uxJeaAK2YI76pRFK30AZwU=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id C05D8F801EC;
	Thu, 19 Aug 2021 20:34:59 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 679ACF8026D; Thu, 19 Aug 2021 20:34:57 +0200 (CEST)
Received: from lb1-smtp-cloud8.xs4all.net (lb1-smtp-cloud8.xs4all.net
 [194.109.24.21])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 7CE67F800EC
 for <alsa-devel@alsa-project.org>; Thu, 19 Aug 2021 20:34:53 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 7CE67F800EC
Received: from cust-b66e5d83 ([IPv6:fc0c:c157:b88d:62c6:5e3c:5f07:82d0:1b4])
 by smtp-cloud8.xs4all.net with ESMTPA
 id GmsNmI7dkUWyVGmsOmpaDg; Thu, 19 Aug 2021 20:34:53 +0200
Received: from localhost (localhost [127.0.0.1])
 by keetweej.vanheusden.com (Postfix) with ESMTP id 8446D161E54;
 Thu, 19 Aug 2021 20:34:51 +0200 (CEST)
Received: from keetweej.vanheusden.com ([127.0.0.1])
 by localhost (mauer.intranet.vanheusden.com [127.0.0.1]) (amavisd-new,
 port 10024)
 with ESMTP id aIEWfWhXja_Z; Thu, 19 Aug 2021 20:34:50 +0200 (CEST)
Received: from belle.intranet.vanheusden.com (belle.intranet.vanheusden.com
 [192.168.64.100])
 by keetweej.vanheusden.com (Postfix) with ESMTP id B5C34161E6B;
 Thu, 19 Aug 2021 20:34:50 +0200 (CEST)
Received: by belle.intranet.vanheusden.com (Postfix, from userid 1000)
 id A6DF7162DC6; Thu, 19 Aug 2021 20:34:50 +0200 (CEST)
Date: Thu, 19 Aug 2021 20:34:50 +0200
From: folkert <folkert@vanheusden.com>
To: sujith kumar reddy <sujithreddy6192@gmail.com>
Subject: Re: arecord is failing with -V stereo
Message-ID: <20210819183450.GV890690@belle.intranet.vanheusden.com>
References: <CAAd2w=btf3DZLbPuovAC9xo3rizmFeT4iAxJs6zNZwKxOnKT6A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAAd2w=btf3DZLbPuovAC9xo3rizmFeT4iAxJs6zNZwKxOnKT6A@mail.gmail.com>
Reply-By: Fri 16 Jul 2021 08:34:34 AM CEST
User-Agent: Mutt/1.10.1 (2018-07-13)
X-CMAE-Envelope: MS4xfHWjS19mawIN8GoHiGcfMhq0MPssc0IWmjgrA6kysvhXzNZB/fujVcRgDbt9Vxu1Za34ZVb6wC4qLjnH2eVOROd9DBdStmCWTvybAPSjBs3AVIODM+Zt
 aYrxjSN0tg1+Dxsa9iejbaGV/BV+NQWpjLpG+wJrOqKVbfxOZn3vnkqF4/OlIxw3pS5D/FgwHjxixNZoOdq4jk+9G+OEbmM7wpwYSEGzk6FnlsL44OZ+oqNJ
 azDGW3YxutAaA94B4BWpCw==
Cc: alsa-devel@alsa-project.org
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

> arecord is  failing vumeter option -V stereo only.

What version?
Because the commandline you provide works fine here with 1.2.4-1ubuntu3.


