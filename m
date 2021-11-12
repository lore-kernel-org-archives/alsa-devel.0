Return-Path: <SRS0=QusE=P7=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B1E1FC433F5
	for <alsa-devel@archiver.kernel.org>; Fri, 12 Nov 2021 12:36:24 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6ABD260F93
	for <alsa-devel@archiver.kernel.org>; Fri, 12 Nov 2021 12:36:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 6ABD260F93
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id B52F91616;
	Fri, 12 Nov 2021 13:35:30 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz B52F91616
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1636720580;
	bh=KyrrxJ3muIvGnp1xwIu6sJTZlsdIsXCJsaZpG0UgVFQ=;
	h=Date:From:To:Subject:In-Reply-To:References:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=RP6ZRrPrSE82jzaHYPvYu7tWVNGuXI7KYtr7Ki+eddDSvMBGHAxU22Ke4l1dEf+tv
	 OBYto9g+nPD0jY0tK08VQrDjpBe3S86rVvQQznhNavCaB7axN7ubArYL7JY6NHAkbF
	 s8n4XLLeBA0WCxERP5x3cwV1tkBao828+1E6hgXc=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 34614F800C1;
	Fri, 12 Nov 2021 13:35:30 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 19AC3F8049E; Fri, 12 Nov 2021 13:35:27 +0100 (CET)
Received: from mga06.intel.com (mga06.intel.com [134.134.136.31])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 19D9EF800C1
 for <alsa-devel@alsa-project.org>; Fri, 12 Nov 2021 13:35:18 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 19D9EF800C1
X-IronPort-AV: E=McAfee;i="6200,9189,10165"; a="293949577"
X-IronPort-AV: E=Sophos;i="5.87,229,1631602800"; d="scan'208";a="293949577"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
 by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 12 Nov 2021 04:35:15 -0800
X-IronPort-AV: E=Sophos;i="5.87,229,1631602800"; d="scan'208";a="504872249"
Received: from eliteleevi.tm.intel.com ([10.237.54.20])
 by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 12 Nov 2021 04:35:13 -0800
Date: Fri, 12 Nov 2021 14:27:34 +0200 (EET)
From: Kai Vehmanen <kai.vehmanen@linux.intel.com>
X-X-Sender: kvehmane@eliteleevi.tm.intel.com
To: Takashi Iwai <tiwai@suse.de>
Subject: Re: [PATCH] ALSA: hda: fix general protection fault in
 azx_runtime_idle
In-Reply-To: <s5hczn53d4l.wl-tiwai@suse.de>
Message-ID: <alpine.DEB.2.22.394.2111121424170.3554566@eliteleevi.tm.intel.com>
References: <20211110210307.1172004-1-kai.vehmanen@linux.intel.com>
 <s5hzgqb65h0.wl-tiwai@suse.de>
 <alpine.DEB.2.22.394.2111110015250.3554566@eliteleevi.tm.intel.com>
 <s5h1r3m6csi.wl-tiwai@suse.de>
 <alpine.DEB.2.22.394.2111111920450.3554566@eliteleevi.tm.intel.com>
 <s5hczn53d4l.wl-tiwai@suse.de>
User-Agent: Alpine 2.22 (DEB 394 2020-01-19)
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7 02160 Espoo
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: alsa-devel@alsa-project.org, intel-gfx@lists.freedesktop.org,
 Kai Vehmanen <kai.vehmanen@linux.intel.com>, mahesh.meena@intel.com
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

Hi,

On Fri, 12 Nov 2021, Takashi Iwai wrote:

> On Thu, 11 Nov 2021 18:39:36 +0100, Kai Vehmanen wrote:
> > And later
> > [   54.770701] Enabling runtime PM for inactive device (0000:00:1f.3) with active children
> > [   54.770718] WARNING: CPU: 0 PID: 10 at drivers/base/power/runtime.c:1439 pm_runtime_enable+0x98/0xb0
> > 
> > Adding a "pm_runtime_set_active(&pci->dev)" to both azx_free() and 
> > azx_probe_continue() seems to help and fix still works.
> 
> Ah yes, I was confused as if it were already called in hdac_device.c,
> but this was about the HD-audio bus controller, not the codec.
> 
> Below is the revised one.
[...]
> Currently we haven't explicitly enable and allow/forbid the runtime PM
> at the probe and the remove phases of HD-audio controller driver, and
> this was the reason of a GPF mentioned in the commit e81478bbe7a1
> ("ALSA: hda: fix general protection fault in azx_runtime_idle");
> namely, even after the resources are released, the runtime PM might be
> still invoked by the bound graphics driver during the remove of the
> controller driver.  Although we've fixed it by clearing the drvdata
> reference, it'd be also better to cover the runtime PM issue more
> properly.
> 
> This patch adds a few more pm_runtime_*() calls at the probe and the
> remove time for setting and cleaning up the runtime PM.  Particularly,
> now more explicitly pm_runtime_enable() and _disable() get called as
> well as pm_runtime_forbid() call at the remove callback, so that a
> use-after-free should be avoided.
> 
> Reported-by: Kai Vehmanen <kai.vehmanen@linux.intel.com>
> Signed-off-by: Takashi Iwai <tiwai@suse.de>

ack, tested this and no warnings anymore.

Reviewed-by: Kai Vehmanen <kai.vehmanen@linux.intel.com>
Tested-by: Kai Vehmanen <kai.vehmanen@linux.intel.com>

Br, Kai
