Return-Path: <SRS0=zdUo=3U=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 12D36C33CB2
	for <alsa-devel@archiver.kernel.org>; Fri, 31 Jan 2020 12:46:00 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8E90520CC7
	for <alsa-devel@archiver.kernel.org>; Fri, 31 Jan 2020 12:45:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="a3etaNNd"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8E90520CC7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id E554F168A;
	Fri, 31 Jan 2020 13:45:07 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz E554F168A
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1580474758;
	bh=LQge7jY+r0mX8c5AlC1PO+tMcBE9UqxtuoA0g0tERVw=;
	h=To:References:From:Date:In-Reply-To:Cc:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=a3etaNNdwQH4B+bTs4vpWR1uGKQql85P1VFoMNX48nOkbmYE+nfvknksGh4yg9qUu
	 xA4Ux6jBjE3TlCqYgrhtbPaYNmI73koJkjOk2oBTuftQcq7ckgszubYhJpypSM0/wS
	 pR99FUqfOF+2diTOrBg9z79gAFcpw3cnmFjYl17Y=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 6DD64F80143;
	Fri, 31 Jan 2020 13:45:07 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 4BAC5F80116; Fri, 31 Jan 2020 13:45:06 +0100 (CET)
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 0A0F7F80116
 for <alsa-devel@alsa-project.org>; Fri, 31 Jan 2020 13:45:02 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 0A0F7F80116
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
 by fmsmga104.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384;
 31 Jan 2020 04:44:59 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.70,385,1574150400"; d="scan'208";a="262535242"
Received: from crojewsk-mobl1.ger.corp.intel.com (HELO [10.237.137.172])
 ([10.237.137.172])
 by fmsmga002.fm.intel.com with ESMTP; 31 Jan 2020 04:44:58 -0800
To: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
References: <20200128104356.16570-1-cezary.rojewski@intel.com>
 <7817f679-fb6f-ad36-aeee-5ee62034a735@linux.intel.com>
 <462e700e-96e8-8941-5de1-fd8ef5f6c18f@intel.com>
 <450d7f9a-239a-0251-a58f-60591cc92736@linux.intel.com>
From: Cezary Rojewski <cezary.rojewski@intel.com>
Message-ID: <5c09c2db-932e-c29e-e0d0-ec363ba122f0@intel.com>
Date: Fri, 31 Jan 2020 13:44:58 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.1
MIME-Version: 1.0
In-Reply-To: <450d7f9a-239a-0251-a58f-60591cc92736@linux.intel.com>
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

On 2020-01-28 22:11, Pierre-Louis Bossart wrote:
> 
>>> I am fine with this update, but I just thought of an obscure case and 
>>> couldn't find the answer on my own.
>>>
>>> These probe points are enabled/disabled with direct IPC calls. Once 
>>> those routines have been called, I don't see any context maintained 
>>> by the driver (other than the stream tag for the extractor).
>>
>> These do not need to be maintained by the driver at all, it's FW's job 
>> actually. Notice the existence of _INFO getters for probe_points and 
>> dmas. FW caches all the necessary info for us and when required, host 
>> can request for it via IPCs.
> 
> D'oh. That's a major disconnect I am afraid.
> 
> When the the PCI device enters D3 on APL+, the power rails are turned 
> off and the SOF firmware does not save any context. On D0 resume, the 
> power rails are turned back on, firmware is downloaded again, and 
> ALSA/ASoC/topology cores restore the context with a set of IPCs.
> 
> The behavior you describe might be relevant for previous versions of the 
> closed-source firmware but not for SOF as of today. The 
> firmware-initiated context save/restore just does not exist.
> 
> I also wonder if a firmware-only solution would work, the DMA stream 
> tags are allocated on the host side, so on resume you could have a 
> coherency issue with possibly mismatches.
> 
>> Driver makes use of such operation during sof_probe_compr_free(). 
>> Before _probe_deinit() is called, all the probe_points should be 
>> disconnected and all the dmas detached. Since this patchset addresses 
>> extraction-only (from the runtime point of view), the later is ignored.
>>
>>>
>>> So here's my question: what happens if there is a pm_runtime or 
>>> system suspend after playing with debugfs to configure those probes? 
>>> Would all context be lost and the user needs to re-enable all probes?
>>>
>>> Also what happens if there is a system suspend while an extractor is 
>>> opened, would it be restored? I imagine a pm_runtime suspend is not 
>>> possible since the device is active then.
> 
>> As stated, there is no cache on the host side, caching is left up to 
>> FW alone. Debugfs files act only as a ipc-proxies. As probes require 
>> device to be up and running, suspend is not possible. After suspend, I 
>> believe FW context would be lost so all the actions had to be repeated.
>>
>> I'd suggest consulting SOF FW team in regard to probes design if you 
>> want to pursue the suspend case - whether it is achievable or not.
> 
> That team is in your building :-)
> 
> suspend/resume support is a requirement for all SOF capabilities - no 
> exceptions. At minimum, you would want to do a pm_runtime_get_sync() to 
> prevent runtime_pm from kicking-in while probes are enabled.

To make it clear: probes are not supported during D3/ S3.

Now to be transparent with the rest of the readers: change keeping the 
device alive throughout the entire lifetime of extractor compress stream 
has been merged on 2019-12-17:
https://lore.kernel.org/alsa-devel/20191217095851.19629-7-cezary.rojewski@intel.com/
so we're sure the suspend scenario will never occur.

However, indeed we could be more verbose - so user is not confused why 
his actions executed on probe-debugfs files are failing. To address 
this, v4 debugfs handlers output additional messages when invoked with 
no extraction stream running.

Czarek
_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
https://mailman.alsa-project.org/mailman/listinfo/alsa-devel
