Return-Path: <SRS0=jEei=6M=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 37BD8C83000
	for <alsa-devel@archiver.kernel.org>; Tue, 28 Apr 2020 16:20:23 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7F94E2054F
	for <alsa-devel@archiver.kernel.org>; Tue, 28 Apr 2020 16:20:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="dqypbnyT"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7F94E2054F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id DC0C31673;
	Tue, 28 Apr 2020 18:19:30 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz DC0C31673
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1588090820;
	bh=J4YLk98EXyq1O55m8ZiQphNNiSGmIhyk/ddmN++HfZg=;
	h=Date:From:To:Subject:In-Reply-To:References:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=dqypbnyTS081pWYkJe0anJa74lN9KIMMwqV5goQxPZN2maqjmuv1wyKTJ/cWhGzeG
	 iSrEKlV0ZkuAOpBMSf3odlhUcfzbIQqOD3G8fRdBCOHLkxcFGkOE4/PlzyTVwucMz4
	 sgUIBxav2M5UCtfwLsyG8SeHTbT5aQpk9a2Vy/q0=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 5A67FF80136;
	Tue, 28 Apr 2020 18:19:30 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 60590F801DB; Tue, 28 Apr 2020 18:19:28 +0200 (CEST)
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 12F99F800D2
 for <alsa-devel@alsa-project.org>; Tue, 28 Apr 2020 18:19:24 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 12F99F800D2
IronPort-SDR: lfEB6wVBOD8T9v+YJkzrZDywdXIFi+pILDrwxQ/iULTTq0FV7n7oBVHGKeloUEEJEVtBL+CxrM
 8/I+dj1SfKNg==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
 by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 28 Apr 2020 09:19:20 -0700
IronPort-SDR: ViEGs8AdAv4MZyPCMT3TUjdchrkkWfUDLP7Y0NymWxGrVaFtOlihlzpCDZZjZgFm44XYCn+0el
 qMYrHEodlh7g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.73,328,1583222400"; d="scan'208";a="282195847"
Received: from eliteleevi.tm.intel.com ([10.237.54.20])
 by fmsmga004.fm.intel.com with ESMTP; 28 Apr 2020 09:19:19 -0700
Date: Tue, 28 Apr 2020 19:19:18 +0300 (EEST)
From: Kai Vehmanen <kai.vehmanen@linux.intel.com>
X-X-Sender: kvehmane@eliteleevi.tm.intel.com
To: Takashi Iwai <tiwai@suse.de>
Subject: Re: Functionality of pcm_notify in snd-aloop?
In-Reply-To: <s5hmu6vlin9.wl-tiwai@suse.de>
Message-ID: <alpine.DEB.2.21.2004281910520.2957@eliteleevi.tm.intel.com>
References: <b4af9071-f8d7-5b47-4d7a-c5743bd67394@ivitera.com>
 <61d837f1-de1a-7aa6-ca8f-d0cfaa36ea69@perex.cz>
 <28a05a44-55bf-1831-aa3c-875e0499caea@ivitera.com>
 <28063dd1-71ab-a313-04b8-f4d97312b1b5@ivitera.com>
 <a325c165-5ced-618b-0b71-c0c4381473a1@perex.cz>
 <s5hmu6vlin9.wl-tiwai@suse.de>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7 02160 Espoo
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: Pavel Hofman <pavel.hofman@ivitera.com>,
 "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>
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

Hey,

On Tue, 28 Apr 2020, Takashi Iwai wrote:

> I believe the missing piece here is a generic way to tell user-space
> that the stream got invalidated.  This would be useful not only for
> aloop but can be applied in general when a stream becomes temporarily
> unavailable (e.g. the HDMI monitor disconnected or the DSP route
> switched).

ack on that. I've been preparing this patch to add -ENODATA to alsa-lib 
documentation:
"[RFC] pcm: add documentation for -ENODATA error code handling"
https://github.com/kv2019i/alsa-lib/commit/87b298106e04054489ee93b26a610e37f99a3171

Have not yet had time to send a proper version to the list, but it's 
addressing specifically this need. This would serve as the interface for 
SOF DSP to tell that a given PCM node will not be providing data (as the 
DSP topology is not fully connected) [1].

To test the above, I've used a small hack to aplay/arecord that keeps 
trying to restart the PCM after a delay, in case -ENODATA is returned:
https://github.com/kv2019i/alsa-utils/commit/a2ba541ea0b3e86a65687de88a41f10cf0a8ddc2

[1] https://github.com/thesofproject/sof/issues/2564

Br, Kai
