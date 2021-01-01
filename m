Return-Path: <SRS0=z4jS=GE=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5F86BC433E0
	for <alsa-devel@archiver.kernel.org>; Fri,  1 Jan 2021 17:51:25 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BB00A221E9
	for <alsa-devel@archiver.kernel.org>; Fri,  1 Jan 2021 17:51:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BB00A221E9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 780AC16BB;
	Fri,  1 Jan 2021 18:50:31 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 780AC16BB
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1609523481;
	bh=zY7KikxfEZVEKn0pSa4SyJ8bgTIikPPXbCWbsGpsFac=;
	h=Date:From:To:Subject:In-Reply-To:References:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=vkm5c3qfKLrUrqY6Jswcv26aewMxfEgFKJ2wdfbQCgJZN+9+M+C3BSkKqF4VLlxO2
	 dL31rjqmaXStAnSgz1gycwvQFc/rgylIXzPwRS5Tvfwbmdd0akXBp4Jdnv/UL6aMzc
	 Cd0xFbgdjlh+JEhiiJnI8fHGcMMDsY7FZLf82ntk=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id ECBA9F8015F;
	Fri,  1 Jan 2021 18:50:30 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id CD1F9F801F5; Fri,  1 Jan 2021 18:50:29 +0100 (CET)
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id ACF7AF8015F
 for <alsa-devel@alsa-project.org>; Fri,  1 Jan 2021 18:50:20 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz ACF7AF8015F
IronPort-SDR: aPfJPCASeysaccqWzvT7FpLikxpoWaLpHqFQwyOibMfR1A6JkgN9BphSAkbZ/v3wmbwCivUWXM
 soMwpE2nYjng==
X-IronPort-AV: E=McAfee;i="6000,8403,9851"; a="173280566"
X-IronPort-AV: E=Sophos;i="5.78,467,1599548400"; d="scan'208";a="173280566"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
 by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 01 Jan 2021 09:50:18 -0800
IronPort-SDR: Xw7AFN160ANT5nl22RCkUkfTmiTiM45KujxaeMWZJuGPpqabRj1yGWd1rWT1ZIhkJznxyJioU5
 kvNaRTrjiYsg==
X-IronPort-AV: E=Sophos;i="5.78,467,1599548400"; d="scan'208";a="348913388"
Received: from eliteleevi.tm.intel.com ([10.237.54.20])
 by fmsmga008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 01 Jan 2021 09:50:17 -0800
Date: Fri, 1 Jan 2021 19:47:23 +0200 (EET)
From: Kai Vehmanen <kai.vehmanen@linux.intel.com>
X-X-Sender: kvehmane@eliteleevi.tm.intel.com
To: Takashi Iwai <tiwai@suse.de>
Subject: Re: [PATCH] ALSA: hda/hdmi: Fix incorrect mutex unlock in
 silent_stream_disable()
In-Reply-To: <20210101083852.12094-1-tiwai@suse.de>
Message-ID: <alpine.DEB.2.22.394.2101011936070.864696@eliteleevi.tm.intel.com>
References: <20210101083852.12094-1-tiwai@suse.de>
User-Agent: Alpine 2.22 (DEB 394 2020-01-19)
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7 02160 Espoo
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: Jan Alexander Steffens <heftig@archlinux.org>, alsa-devel@alsa-project.org,
 Kai Vehmanen <kai.vehmanen@linux.intel.com>
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

uh oh, I need to do some soul searching on how this slipped through. Seems
to have been introduced in the V2 of the patch. Fix is correct, thanks 
Jan for reporting!

On Fri, 1 Jan 2021, Takashi Iwai wrote:

> The silent_stream_disable() function introduced by the commit
> b1a5039759cb ("ALSA: hda/hdmi: fix silent stream for first playback to
> DP") takes the per_pin->lock mutex, but it unlocks the wrong one,
> spec->pcm_lock, which causes a deadlock.  This patch corrects it.

Acked-by: Kai Vehmanen <kai.vehmanen@linux.intel.com>

Br, Kai
