Return-Path: <SRS0=T7nt=2D=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 670D7C341B5
	for <alsa-devel@archiver.kernel.org>; Fri, 13 Dec 2019 20:51:52 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4FDFA2469B
	for <alsa-devel@archiver.kernel.org>; Fri, 13 Dec 2019 20:51:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="Vr5AwI0G"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4FDFA2469B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 573331757;
	Fri, 13 Dec 2019 14:05:40 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 573331757
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1576242390;
	bh=gOprwXaLBBUd3ERHNg2Xds1vqn5J0SD/+V6V60yeRJw=;
	h=Date:From:To:In-Reply-To:References:Cc:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=Vr5AwI0GC2wGmbWP8Zib6eDr+JedDF/ZT0InhyzQSXLMdKBLLKYLgDynoh5e2O8T5
	 6EcAq6Araw0pmu6WzdKpi2mLWKD40oa21pmD77LJ8OOfrnuJ+bpMK6UHh5XYAN1SWQ
	 GZ5TEn9UT4NwBPuG4fXqsPERIf4gl0ABPW95yELw=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id D80B8F801F4;
	Fri, 13 Dec 2019 14:05:39 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 15802F8021E; Fri, 13 Dec 2019 14:05:39 +0100 (CET)
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 8E516F8014F
 for <alsa-devel@alsa-project.org>; Fri, 13 Dec 2019 14:05:34 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 8E516F8014F
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga003.jf.intel.com ([10.7.209.27])
 by fmsmga102.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384;
 13 Dec 2019 05:05:33 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.69,309,1571727600"; d="scan'208";a="216635981"
Received: from zeliteleevi.tm.intel.com ([10.237.55.130])
 by orsmga003.jf.intel.com with ESMTP; 13 Dec 2019 05:05:31 -0800
Date: Fri, 13 Dec 2019 15:05:31 +0200 (EET)
From: Kai Vehmanen <kai.vehmanen@linux.intel.com>
X-X-Sender: kvehmane@zeliteleevi
To: Takashi Iwai <tiwai@suse.de>
In-Reply-To: <20191210145727.22054-1-tiwai@suse.de>
Message-ID: <alpine.DEB.2.21.1912131504070.16459@zeliteleevi>
References: <20191210145727.22054-1-tiwai@suse.de>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7 02160 Espoo
MIME-Version: 1.0
Cc: alsa-devel@alsa-project.org
Subject: Re: [alsa-devel] [PATCH] ALSA: hda: Use standard waitqueue for RIRB
 wakeup
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

Hey,

On Tue, 10 Dec 2019, Takashi Iwai wrote:

> This patch attempts to improve the situation by introducing the
> standard waitqueue in the RIRB waiter side instead of polling.  The

this patch was part of the testing as well, so looks good. One minor
nit only:

> @@ -216,6 +216,9 @@ void snd_hdac_bus_update_rirb(struct hdac_bus *bus)
>  		else if (bus->rirb.cmds[addr]) {
>  			bus->rirb.res[addr] = res;
>  			bus->rirb.cmds[addr]--;
> +			if (!bus->rirb.cmds[addr] &&
> +			    waitqueue_active(&bus->rirb_wq))
> +				wake_up(&bus->rirb_wq);

Checkpath would like to have a comment here:

WARNING: waitqueue_active without comment
#77: FILE: sound/hda/hdac_controller.c:220:
+                           waitqueue_active(&bus->rirb_wq))

Br, Kai

_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
https://mailman.alsa-project.org/mailman/listinfo/alsa-devel
