Return-Path: <SRS0=FVIg=OV=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6EDC8C433F5
	for <alsa-devel@archiver.kernel.org>; Fri,  1 Oct 2021 09:54:26 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BA2EE61A08
	for <alsa-devel@archiver.kernel.org>; Fri,  1 Oct 2021 09:54:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org BA2EE61A08
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 6F4A416CB;
	Fri,  1 Oct 2021 11:53:32 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 6F4A416CB
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1633082062;
	bh=U8zAJCxBg1krB/fvwpClEGGvIBz5l1rainTNWvCWniY=;
	h=Date:From:To:Subject:In-Reply-To:References:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=dh6zWidLBn3Ymbj5/mBTvXdO42Fa6MJB3eTqKhQy3VC7IkEeEW2nxTj1uyVr0wVNz
	 UDRL8K9I984mgbwWbXQDcucG5SbgvB6TA77zTyZD36Vhk4Y/RnFVO9cjmXPtzyS6eK
	 iiUNV+qoSo+sy4orcwUurTmB4VkIkb/yLRUJ7TFw=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id D8244F80227;
	Fri,  1 Oct 2021 11:53:31 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id EC23AF80245; Fri,  1 Oct 2021 11:53:29 +0200 (CEST)
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id ED143F801F7
 for <alsa-devel@alsa-project.org>; Fri,  1 Oct 2021 11:53:23 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz ED143F801F7
X-IronPort-AV: E=McAfee;i="6200,9189,10123"; a="225041219"
X-IronPort-AV: E=Sophos;i="5.85,337,1624345200"; d="scan'208";a="225041219"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
 by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 01 Oct 2021 02:53:19 -0700
X-IronPort-AV: E=Sophos;i="5.85,337,1624345200"; d="scan'208";a="618986914"
Received: from eliteleevi.tm.intel.com ([10.237.54.20])
 by fmsmga001-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 01 Oct 2021 02:53:17 -0700
Date: Fri, 1 Oct 2021 12:46:26 +0300 (EEST)
From: Kai Vehmanen <kai.vehmanen@linux.intel.com>
X-X-Sender: kvehmane@eliteleevi.tm.intel.com
To: Takashi Iwai <tiwai@suse.de>
Subject: Re: hda: how to implement component master_unbind?
In-Reply-To: <s5ha6jxnekp.wl-tiwai@suse.de>
Message-ID: <alpine.DEB.2.22.394.2110011129450.3554566@eliteleevi.tm.intel.com>
References: <alpine.DEB.2.22.394.2109221456080.3554566@eliteleevi.tm.intel.com>
 <s5ha6jxnekp.wl-tiwai@suse.de>
User-Agent: Alpine 2.22 (DEB 394 2020-01-19)
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7 02160 Espoo
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: Daniel Vetter <daniel.vetter@ffwll.ch>, alsa-devel@alsa-project.org,
 Jani Nikula <jani.nikula@linux.intel.com>,
 Kai Vehmanen <kai.vehmanen@linux.intel.com>,
 Chris Wilson <chris@chris-wilson.co.uk>
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

On Tue, 28 Sep 2021, Takashi Iwai wrote:

> Removing a component from the card is a PITA for now, indeed,
> especially when its influence is over different APIs (PCM, control,
> whatever)...
> 
> One thing I can think of is to perform like the vga_switcheroo
> handling in hda_intel.c; it's essentially a forced runtime suspend,
> and disable the whole card.  But in the case of audio-component
> unbind, we need to think about re-binding -- or completely ignore
> re-binding until the whole driver gets unloaded. 

thanks for the feedback! The switcheroo approach doesn't work too well for 
integrated HDA controllers that will typically have other codecs connected 
as well (and may have a DSP -> e.g. SOF/SST used as controller driver 
which would all need to implement this separately), but for the discrete 
GPU case this might be a workable approach (and makes sense as this is 
what switcheroo is meant for). I think gracefully handling the unbind is 
priority, but re-binding should be possible as well. We could do a 
switcheroo-enable type of flow in hdac_component_master_bind() and have 
the controller back up.

Of course it's not perfect still. I'd guess at least attempt to reach the 
codec#x procfs entry would hit timeouts if the controller is disabled this 
way.

Br, Kai
