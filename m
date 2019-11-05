Return-Path: <SRS0=4Snk=Y5=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 31388C5DF60
	for <alsa-devel@archiver.kernel.org>; Tue,  5 Nov 2019 16:14:33 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 38F75214B2
	for <alsa-devel@archiver.kernel.org>; Tue,  5 Nov 2019 16:14:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="HzHqR0Yn"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 38F75214B2
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=chris-wilson.co.uk
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 6ACB11694;
	Tue,  5 Nov 2019 17:13:40 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 6ACB11694
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1572970470;
	bh=e1Z6mm30wxaFfXL2GkRCAfF0eF+MHmn43vos2b7K9EM=;
	h=To:From:In-Reply-To:References:Date:Cc:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=HzHqR0Yn0n81SjPJM2Kky3YRTWNT+Yppfj3Fm3Vvi25R2mUMTr6AYnBPEoBLJRJu7
	 nNqE/LhNWh7m5lx54ECSYBvUpsfES3POkNJTgb9souldXf/CzdDa7YIOrW6xRD1O/p
	 XhsZfToPs9HYnUdvd6+4Ag7LEHZZIBavtHqk7NWk=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 0F127F80446;
	Tue,  5 Nov 2019 17:13:40 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 536B4F8049B; Tue,  5 Nov 2019 17:13:38 +0100 (CET)
Received: from fireflyinternet.com (mail.fireflyinternet.com [109.228.58.192])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256
 bits)) (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 2DD95F8015B
 for <alsa-devel@alsa-project.org>; Tue,  5 Nov 2019 17:13:34 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 2DD95F8015B
X-Default-Received-SPF: pass (skip=forwardok (res=PASS))
 x-ip-name=78.156.65.138; 
Received: from localhost (unverified [78.156.65.138]) 
 by fireflyinternet.com (Firefly Internet (M1)) with ESMTP (TLS) id
 19091488-1500050 for multiple; Tue, 05 Nov 2019 16:13:10 +0000
MIME-Version: 1.0
To: Kai Vehmanen <kai.vehmanen@linux.intel.com>, alsa-devel@alsa-project.org, 
 tiwai@suse.de
From: Chris Wilson <chris@chris-wilson.co.uk>
In-Reply-To: <20191105161053.22958-1-kai.vehmanen@linux.intel.com>
References: <20191105161053.22958-1-kai.vehmanen@linux.intel.com>
Message-ID: <157297038783.18566.4452216868127032897@skylake-alporthouse-com>
User-Agent: alot/0.6
Date: Tue, 05 Nov 2019 16:13:07 +0000
Cc: Pan Xiuli <xiuli.pan@linux.intel.com>, lakshminarayana.vudum@intel.com,
 kai.vehmanen@linux.intel.com, jani.saarinen@intel.com
Subject: Re: [alsa-devel] [PATCH] ALSA: hda: hdmi - add Tigerlake support
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: "Alsa-devel" <alsa-devel-bounces@alsa-project.org>

Quoting Kai Vehmanen (2019-11-05 16:10:53)
> Add Tigerlake HDMI codec support.
> 
> BugLink: https://bugzilla.kernel.org/show_bug.cgi?id=205379
> BugLink: https://bugs.freedesktop.org/show_bug.cgi?id=112171
> Cc: Pan Xiuli <xiuli.pan@linux.intel.com>
> Signed-off-by: Kai Vehmanen <kai.vehmanen@linux.intel.com>

For thos watching,
https://patchwork.freedesktop.org/series/68972/#rev1
includes the revert so that this is tested. Not that the first run
through BAT tgl died too early to be conclusive.
-Chris
_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
https://mailman.alsa-project.org/mailman/listinfo/alsa-devel
