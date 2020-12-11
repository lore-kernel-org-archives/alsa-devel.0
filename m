Return-Path: <SRS0=kZkJ=FP=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C66FAC4361B
	for <alsa-devel@archiver.kernel.org>; Fri, 11 Dec 2020 13:39:54 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 11F1B23EB2
	for <alsa-devel@archiver.kernel.org>; Fri, 11 Dec 2020 13:39:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 11F1B23EB2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id CA1001761;
	Fri, 11 Dec 2020 14:39:00 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz CA1001761
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1607693990;
	bh=uS0nAf/tZm41rt4IuB27w/7b30kdyViyiELdYB3l4sg=;
	h=Date:From:To:Subject:In-Reply-To:References:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=ql7XByVZMV4juouxGGlG3OIfG2c+xTjPEfWanfCN8a6truSqeYViehtUYE8L/ukZc
	 O4QCmQwjvGacpVyka/Mua1wUMc6uF+4Sgtk84slNia2eADS+fadPAiF+vuVMgLGQfs
	 5ST/B6m3npqtBW3TtrAPdiJChv3okzHy4gy0s+x0=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 5A870F801D8;
	Fri, 11 Dec 2020 14:39:00 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id EA4ECF8020D; Fri, 11 Dec 2020 14:38:58 +0100 (CET)
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 156BAF80105
 for <alsa-devel@alsa-project.org>; Fri, 11 Dec 2020 14:38:53 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 156BAF80105
IronPort-SDR: WsOyBmcTyQA4CRbBJynPZ6fjoKKRD3eSOASMprAD7YBjCUU6vQAgrwK6VIN2HkXY9edr9icvvz
 3rfUO6j2+bIw==
X-IronPort-AV: E=McAfee;i="6000,8403,9831"; a="174543883"
X-IronPort-AV: E=Sophos;i="5.78,411,1599548400"; d="scan'208";a="174543883"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
 by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 11 Dec 2020 05:38:48 -0800
IronPort-SDR: 1hD5RjtMvNg2i9bysekS9G1oFTxtbSbHcBky3lxCUg7X2Cmv4V6zDEhvEH6m2kOpD04l045nhs
 BuESam9lEJYA==
X-IronPort-AV: E=Sophos;i="5.78,411,1599548400"; d="scan'208";a="440967359"
Received: from eliteleevi.tm.intel.com ([10.237.54.20])
 by fmsmga001-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 11 Dec 2020 05:38:46 -0800
Date: Fri, 11 Dec 2020 15:36:04 +0200 (EET)
From: Kai Vehmanen <kai.vehmanen@linux.intel.com>
X-X-Sender: kvehmane@eliteleevi.tm.intel.com
To: Jaroslav Kysela <perex@perex.cz>, Hui Wang <hui.wang@canonical.com>
Subject: Re: [RFC][PATCH 0/2] design a way to change audio Jack state by
 software
In-Reply-To: <575811fc-cb64-c7d4-bf6b-5044949a326c@perex.cz>
Message-ID: <alpine.DEB.2.22.394.2012111522490.864696@eliteleevi.tm.intel.com>
References: <20201209124344.219158-1-hui.wang@canonical.com>
 <575811fc-cb64-c7d4-bf6b-5044949a326c@perex.cz>
User-Agent: Alpine 2.22 (DEB 394 2020-01-19)
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7 02160 Espoo
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: Takashi Iwai <tiwai@suse.de>, alsa-devel@alsa-project.org
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

On Wed, 9 Dec 2020, Jaroslav Kysela wrote:

> Dne 09. 12. 20 v 13:43 Hui Wang napsal(a):
> > After we change sth in the userspace audio stack like alsa-ucm or
> > pulseaudio, we want to perform remote audio auto test to verify if the
> > change introduce the regression or not, some of the tests are about
> > the defaut_sink/default_source or active_port switching, this needs

thanks Hui for the RFC.

I do think this is a very tempting capability to add. I understand 
Jaroslav's concerns as well, but there is clearly a category of issues 
where user-space functionality is broken due to a mismatch of element 
names between UCM file and the driver. I.e. the actual jack detection 
(codec hw and its driver) is working, but due to wrong UCM file chosen, 
wrong driven is chosen, or errors in either UCM or driver, event does not 
get parsed right and user ends with no audio.

A pure user-space test harness would not catch these, and building full 
automation of external codec events, is a complex task and coverage of 
devices is likely limited. 

The 'edid_override' debugfs interface in i915 is a bit similar. It allows
inject EDID content irrespectively of the actual monitor connected.

> Also, the first patch can be omitted if you just create another
> snd_jack_report() function for the user API and put the common code to the
> static function in jack.c.

++votes on this

Br, Kai
