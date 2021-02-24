Return-Path: <SRS0=BjaJ=H2=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 134D5C433DB
	for <alsa-devel@archiver.kernel.org>; Wed, 24 Feb 2021 10:22:17 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BE84C64ECF
	for <alsa-devel@archiver.kernel.org>; Wed, 24 Feb 2021 10:22:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BE84C64ECF
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 20A401662;
	Wed, 24 Feb 2021 11:21:23 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 20A401662
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1614162133;
	bh=RrPb2RSxCiHCU25x8nBOe74MUCcb2+P3V+ZSKF9hsq4=;
	h=Date:From:To:Subject:In-Reply-To:References:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=VyLLWXwEdmCyuSFWAs4wgzAXtfS4xtQNxHkvDV4b/1lOSfSMr4hYlWUfw/Kca9wkY
	 g/00+u/+GrY/mEFnP2zJl9SD1j0GWFJLcP40LeqQ0/ctrB3pX1cXQrhVgB/U7BSpG6
	 T1SEndQ2K2sMcVWEY/hkc4u48QAf29alzTUg9X/4=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 9CB83F80129;
	Wed, 24 Feb 2021 11:21:22 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id DC2AFF8016C; Wed, 24 Feb 2021 11:21:20 +0100 (CET)
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id A5299F80129
 for <alsa-devel@alsa-project.org>; Wed, 24 Feb 2021 11:21:16 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz A5299F80129
IronPort-SDR: 2Servx7OF8I8pL+ueCX5dTkUkYe+bNLcDDdQCbc4ehx0iYmuKU2ujfCuI1Ro3HgxUMc4r1C1O5
 BwoQElL+f1wA==
X-IronPort-AV: E=McAfee;i="6000,8403,9904"; a="184417951"
X-IronPort-AV: E=Sophos;i="5.81,202,1610438400"; d="scan'208";a="184417951"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
 by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 24 Feb 2021 02:21:13 -0800
IronPort-SDR: uwtj2Y+s8FLLCSO/h3sXUKxH/9r3zgsbOkyI8iBLbFZ6Ft5ClYqwg4rA5MRqCI6QQmcQPfMgBs
 fw3jFA39oQeQ==
X-IronPort-AV: E=Sophos;i="5.81,202,1610438400"; d="scan'208";a="403633798"
Received: from eliteleevi.tm.intel.com ([10.237.54.20])
 by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 24 Feb 2021 02:21:12 -0800
Date: Wed, 24 Feb 2021 12:17:34 +0200 (EET)
From: Kai Vehmanen <kai.vehmanen@linux.intel.com>
X-X-Sender: kvehmane@eliteleevi.tm.intel.com
To: Hui Wang <hui.wang@canonical.com>
Subject: Re: [PATCH] ALSA: hda/hdmi: let new platforms assign the pcm slot
 dynamically
In-Reply-To: <cb3fe45f-97d0-3d9e-0f20-bfe78a612c5a@canonical.com>
Message-ID: <alpine.DEB.2.22.394.2102241153320.864696@eliteleevi.tm.intel.com>
References: <20210223122205.233701-1-hui.wang@canonical.com>
 <alpine.DEB.2.22.394.2102231545050.864696@eliteleevi.tm.intel.com>
 <ccc1fd32-5838-a2ca-39aa-75ef2d7e3b16@perex.cz>
 <s5hsg5mu4ko.wl-tiwai@suse.de>
 <alpine.DEB.2.22.394.2102231918010.864696@eliteleevi.tm.intel.com>
 <cb3fe45f-97d0-3d9e-0f20-bfe78a612c5a@canonical.com>
User-Agent: Alpine 2.22 (DEB 394 2020-01-19)
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7 02160 Espoo
MIME-Version: 1.0
Content-ID: <alpine.DEB.2.22.394.2102241154080.864696@eliteleevi.tm.intel.com>
Content-Type: text/plain; CHARSET=ISO-8859-15
Content-Transfer-Encoding: 8BIT
X-Content-Filtered-By: Mailman/MimeDel 2.1.15
Cc: Takashi Iwai <tiwai@suse.de>, alsa-devel@alsa-project.org,
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

Hey,

On Wed, 24 Feb 2021, Hui Wang wrote:

> On 2/24/21 1:51 AM, Kai Vehmanen wrote:
> > interface all pins are exposed. Each pin does provide functionality to
> > query whether a display is connected to it, and whether the connected
> > display has audio capability.
> > 
> > The maximum number of concurrent displays is described as converters.
> > On TGL this is 4.
> If a physical port supports DP-MST, does the 3 connections on this physical
> port share a single converter? And each connection has an independent pcm, 
> maybe the driver should create pcm pool according to num_converter * 3.

DP-MST is is reported per-pin, so basicly the interface can report display 
connection status for "numpins*3" endpoints so that would be 9*3 on 
Intel TGL systems.

However, this doesn't affect the converters. There is still four 
converters, so 4 PCMs are enough to cover all possible combination of 
plain DP/HDMI and DP-MST. User-space can query the ELD information to 
learn the mapping from a PCM to a specific display (like e.g. Pulseaudio 
does).

I sent a patch "ALSA: hda/proc - print DP-MST connections" to visualize 
these a bit better in procfs output. I put example output in the commit:
https://lore.kernel.org/r/20201208185736.2877541-1-kai.vehmanen@linux.intel.com

The existing driver provides a PCM for each pin, plus reserve two extra 
PCMs for DP-MST. There's merit to this design as well, but arguably 
the SOF approach is easier to understand on systems like TGL and ICL.

Br, Kai
