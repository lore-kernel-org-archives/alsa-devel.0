Return-Path: <SRS0=tzaW=56=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1D309C2BA19
	for <alsa-devel@archiver.kernel.org>; Tue, 14 Apr 2020 16:37:29 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9CFE4206E9
	for <alsa-devel@archiver.kernel.org>; Tue, 14 Apr 2020 16:37:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="Qh0FhHVy"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9CFE4206E9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id E074516A6;
	Tue, 14 Apr 2020 18:36:36 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz E074516A6
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1586882247;
	bh=boCjHJ/yPPysasWR/PCxPk61SNMjTKBUv7fbm+bRgNk=;
	h=Subject:To:References:From:Date:In-Reply-To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=Qh0FhHVyl0u+fTSvJQped+qmwkDNEcN22YSD18fQ+xTwUw/iUeILtzkcacDRXbtNa
	 Nz43qn3sWEvyO5ApqJMRNK3x+E/SVUyx9/mpbXqn5fZDMHc56ZEv5rR+nfyJtNY6l0
	 Tt5sOpWLhFvlm5GZUxXIsGoyypZXqgCRD81szBS8=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 668E6F8016F;
	Tue, 14 Apr 2020 18:36:36 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id A1BEDF8016F; Tue, 14 Apr 2020 18:36:20 +0200 (CEST)
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 5A22FF80115
 for <alsa-devel@alsa-project.org>; Tue, 14 Apr 2020 18:36:13 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 5A22FF80115
IronPort-SDR: s/1ejzSyFfbT/dbvZmcAELW+vIdxhsO6wwA6rSNUuMA0UR1LrgZAviTSn/h0JbNWn4NvMfsd1/
 T7wIg6XmpJTw==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga003.jf.intel.com ([10.7.209.27])
 by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 14 Apr 2020 09:36:06 -0700
IronPort-SDR: dgbNyHHIgCTSDrlXsmJC6PhhzNdajrweGgvkvWTWQea6HxoDfLVwSRLxQ5eiuXDxXCxUDH3CHk
 AHVtWTXCDHBQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.72,383,1580803200"; d="scan'208";a="253246220"
Received: from svarahab-mobl.amr.corp.intel.com (HELO [10.212.190.40])
 ([10.212.190.40])
 by orsmga003.jf.intel.com with ESMTP; 14 Apr 2020 09:36:04 -0700
Subject: Re: [PATCH 03/13] ALSA: hda: Add ElkhartLake HDMI codec vid
To: Kai Vehmanen <kai.vehmanen@linux.intel.com>, Takashi Iwai <tiwai@suse.de>
References: <20200409185827.16255-1-pierre-louis.bossart@linux.intel.com>
 <20200409185827.16255-4-pierre-louis.bossart@linux.intel.com>
 <s5hd08emi2k.wl-tiwai@suse.de>
 <alpine.DEB.2.21.2004141838300.2957@eliteleevi.tm.intel.com>
From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Message-ID: <703d010b-d39b-1f1c-03a7-9daac3ddb2cd@linux.intel.com>
Date: Tue, 14 Apr 2020 11:36:03 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <alpine.DEB.2.21.2004141838300.2957@eliteleevi.tm.intel.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Cc: Guennadi Liakhovetski <guennadi.liakhovetski@linux.intel.com>,
 alsa-devel@alsa-project.org, broonie@kernel.org,
 Bard Liao <yung-chuan.liao@linux.intel.com>,
 Libin Yang <libin.yang@linux.intel.com>
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


>> On Thu, 09 Apr 2020 20:58:17 +0200, Pierre-Louis Bossart wrote:
>>> Add HDMI codec vid for the Intel ElkhartLake platform
>>
>> I suppose this can go through ASoC tree unless HDA legacy driver
>> supports the device.
> 
> hmm, good point. In short, both DSP and non-DSP usage continue to be
> possible, so HDA legacy driver can be used as well. This is a (positive)
> new problem of SOF now using common codec driver for HDMI. The patch got
> merged already (and I think this is ok as we specifically enable and test
> HDMI with the ASoC stack), but maybe in the future we can send these codec
> driver patches directly, and not via ASoC.

ElkhartLake support was added to the legacy driver a while back (5.3). 
Don't ask me why the hdmi codec id was not added at the time, it was 
indeed a miss.
I chose to send this patch as part of the ASoC series, so that at least 
we have consistency. Takashi, if you prefer it that way feel free to 
take this patch in your tree, but then Mark would need a tag for the 
rest of this series. I agree with Kai that moving forward the hdmi codec 
parts should be better tracked.
Thanks
-Pierre
