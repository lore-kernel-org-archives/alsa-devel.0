Return-Path: <SRS0=GCF0=3R=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C6712C2D0DB
	for <alsa-devel@archiver.kernel.org>; Tue, 28 Jan 2020 19:31:07 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 536FB214D8
	for <alsa-devel@archiver.kernel.org>; Tue, 28 Jan 2020 19:31:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="W3BDoQvp"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 536FB214D8
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id AAD03950;
	Tue, 28 Jan 2020 20:30:15 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz AAD03950
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1580239865;
	bh=kH+elXBRDRp2pYDieTin+oiqcGEWcUD5f0cU21hkcC4=;
	h=To:References:From:Date:In-Reply-To:Cc:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=W3BDoQvp4hZbkolG811Y3JqERE/uuyMVHLGv0a3V9v0DyDhrfRsXmdbK51+pV5o8I
	 doYsRw4eaCgXiIYb5OjydPUu45JnhuCKb/jLLUq2wugnHvMrma2t5sWPqv8FTIpKt1
	 nEmM9oJ8QNemONTuvIyFDI7vLROvX7hau2FBeXg4=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 19E52F8014B;
	Tue, 28 Jan 2020 20:30:15 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id D3B8FF80150; Tue, 28 Jan 2020 20:30:13 +0100 (CET)
Received: from mga06.intel.com (mga06.intel.com [134.134.136.31])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id A3812F80123
 for <alsa-devel@alsa-project.org>; Tue, 28 Jan 2020 20:30:03 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz A3812F80123
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
 by orsmga104.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384;
 28 Jan 2020 11:29:59 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.70,375,1574150400"; d="scan'208";a="261546920"
Received: from crojewsk-mobl1.ger.corp.intel.com (HELO [10.251.82.5])
 ([10.251.82.5])
 by fmsmga002.fm.intel.com with ESMTP; 28 Jan 2020 11:29:56 -0800
To: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
References: <20200128104356.16570-1-cezary.rojewski@intel.com>
 <7817f679-fb6f-ad36-aeee-5ee62034a735@linux.intel.com>
From: Cezary Rojewski <cezary.rojewski@intel.com>
Message-ID: <462e700e-96e8-8941-5de1-fd8ef5f6c18f@intel.com>
Date: Tue, 28 Jan 2020 20:29:55 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.1
MIME-Version: 1.0
In-Reply-To: <7817f679-fb6f-ad36-aeee-5ee62034a735@linux.intel.com>
Content-Language: en-US
Cc: alsa-devel@alsa-project.org, broonie@kernel.org, tiwai@suse.com,
 lgirdwood@gmail.com
Subject: Re: [alsa-devel] [PATCH v3 00/11] ASoC: SOF: Data probing
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
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: "Alsa-devel" <alsa-devel-bounces@alsa-project.org>

On 2020-01-28 18:55, Pierre-Louis Bossart wrote:
> On 1/28/20 4:43 AM, Cezary Rojewski wrote:
>> This set of patches achieves few goals in order to enable data probing
>> feature for audio DSP.
> 
> I am fine with this update, but I just thought of an obscure case and 
> couldn't find the answer on my own.
> 
> These probe points are enabled/disabled with direct IPC calls. Once 
> those routines have been called, I don't see any context maintained by 
> the driver (other than the stream tag for the extractor).

These do not need to be maintained by the driver at all, it's FW's job 
actually. Notice the existence of _INFO getters for probe_points and 
dmas. FW caches all the necessary info for us and when required, host 
can request for it via IPCs.

Driver makes use of such operation during sof_probe_compr_free(). Before 
_probe_deinit() is called, all the probe_points should be disconnected 
and all the dmas detached. Since this patchset addresses extraction-only 
(from the runtime point of view), the later is ignored.

> 
> So here's my question: what happens if there is a pm_runtime or system 
> suspend after playing with debugfs to configure those probes? Would all 
> context be lost and the user needs to re-enable all probes?
> 
> Also what happens if there is a system suspend while an extractor is 
> opened, would it be restored? I imagine a pm_runtime suspend is not 
> possible since the device is active then.
> 
> I'd be fine if this was handled in a follow-up series, just want to see 
> if my question is relevant and if yes what it takes to support suspend.
> 
> Thanks
> -Pierre

As stated, there is no cache on the host side, caching is left up to FW 
alone. Debugfs files act only as a ipc-proxies. As probes require device 
to be up and running, suspend is not possible. After suspend, I believe 
FW context would be lost so all the actions had to be repeated.

I'd suggest consulting SOF FW team in regard to probes design if you 
want to pursue the suspend case - whether it is achievable or not.

Czarek
_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
https://mailman.alsa-project.org/mailman/listinfo/alsa-devel
