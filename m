Return-Path: <SRS0=LtCP=G4=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 419D8C433E0
	for <alsa-devel@archiver.kernel.org>; Mon, 25 Jan 2021 09:33:19 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7A1A722D02
	for <alsa-devel@archiver.kernel.org>; Mon, 25 Jan 2021 09:33:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7A1A722D02
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id EA12816F5;
	Mon, 25 Jan 2021 10:32:24 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz EA12816F5
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1611567195;
	bh=wELP+YvEcV59+ipofpYULKnsJAQvx/iCqDSfFzyoYG4=;
	h=Date:From:To:Subject:In-Reply-To:References:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=EAYImTyPdGudjbXV2aaIQ9QtRRKgj8TCrnzCXJL20Xsn8kO0afo2FELUC9BRMow61
	 n+WQhhjXEFF9W6NVa1DpaklyLDFHJsAKdi5icoHz0zbaDFZ44lhUil3kvcgIHYwJzN
	 uAIZAAaw4UAa1S2ofcIcLyOWm7VOev5/9rDmik+s=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 72627F80218;
	Mon, 25 Jan 2021 10:32:24 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id EDBCCF8014D; Mon, 25 Jan 2021 10:32:22 +0100 (CET)
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id D6E29F8014D
 for <alsa-devel@alsa-project.org>; Mon, 25 Jan 2021 10:32:17 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz D6E29F8014D
IronPort-SDR: /ybXu43ZnR6Pj3cplMi+SSUcKRH1Y+a14HuPgqA4QnVVXVjP8q3kmNPP15Xb2wt6HheP65oAAm
 mHHwxvnE8Iiw==
X-IronPort-AV: E=McAfee;i="6000,8403,9874"; a="179843995"
X-IronPort-AV: E=Sophos;i="5.79,373,1602572400"; d="scan'208";a="179843995"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
 by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 25 Jan 2021 01:32:13 -0800
IronPort-SDR: krrYwPo72PKzZX/Sy7R3p82JyVurH0k9Y0NYXY/7xncHblnVo6XU2tre4QfUk24OXAKV476V76
 KmtkjvMSnEIQ==
X-IronPort-AV: E=Sophos;i="5.79,373,1602572400"; d="scan'208";a="387270690"
Received: from eliteleevi.tm.intel.com ([10.237.54.20])
 by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 25 Jan 2021 01:32:11 -0800
Date: Mon, 25 Jan 2021 11:28:58 +0200 (EET)
From: Kai Vehmanen <kai.vehmanen@linux.intel.com>
X-X-Sender: kvehmane@eliteleevi.tm.intel.com
To: Jaroslav Kysela <perex@perex.cz>
Subject: Re: [PATCH] ALSA: hda: intel-dsp-config: add PCI id for TGL-H
In-Reply-To: <e04b942a-0f61-2c6c-ceb1-393668cfe549@perex.cz>
Message-ID: <alpine.DEB.2.22.394.2101251122060.864696@eliteleevi.tm.intel.com>
References: <20210125083051.828205-1-kai.vehmanen@linux.intel.com>
 <s5h35yp5rli.wl-tiwai@suse.de>
 <e04b942a-0f61-2c6c-ceb1-393668cfe549@perex.cz>
User-Agent: Alpine 2.22 (DEB 394 2020-01-19)
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7 02160 Espoo
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: Libin Yang <libin.yang@intel.com>, alsa-devel@alsa-project.org,
 Kai Vehmanen <kai.vehmanen@linux.intel.com>, Takashi Iwai <tiwai@suse.de>,
 Xiuli Pan <xiuli.pan@intel.com>, broonie@kernel.org,
 Bard Liao <bard.liao@intel.com>
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

On Mon, 25 Jan 2021, Jaroslav Kysela wrote:

> Dne 25. 01. 21 v 9:49 Takashi Iwai napsal(a):
> > Is this needed for 5.11 or only for 5.12?
> > (Or potentially needed for 5.11.x stable later? -- then we can take it
> 
> All patches sent by Kai today are required to add support for the SoundWire
> device Dell TGL-H SKU 0A5E in 5.11. But I think that this standalone patch may
> enable the DMIC only platforms.

ack on that. We are a bit late for 5.11 with these patches, but the more 
we can get to 5.11, the better. 5.11-rc already has support for 
snd-hda-intel and baseline SOF support, but this single patch helps system 
with a PCH-DMIC.

The remaining patches sent via today ASoC, enable one Soundwire SKU.

Br, Kai
