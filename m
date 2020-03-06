Return-Path: <SRS0=YoTX=4X=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9E536C10DCE
	for <alsa-devel@archiver.kernel.org>; Fri,  6 Mar 2020 15:50:55 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1F5A22072D
	for <alsa-devel@archiver.kernel.org>; Fri,  6 Mar 2020 15:50:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="Orzd8pwg"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1F5A22072D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 6273D826;
	Fri,  6 Mar 2020 16:50:03 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 6273D826
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1583509853;
	bh=srlI4P8vEwDXfyXrFkpSRkq2z46lnk3+jB2Jp/8T8bw=;
	h=Subject:To:References:From:Date:In-Reply-To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=Orzd8pwgG9yPZxvS84QZ0Pfdhz4phwrM59sgG/WsZOPnqiNrgRKk/0nNpGxBxxOYe
	 SHz+nczDTWSRITGRFQ3fbeD/JjLXr7zKDJBnOj8/SPHHHujJxNBBQSCoiub5ja6Rnn
	 8zuWfpC1rEdxAcOlAKPcvhQmkQ9IwCb50clPZaps=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 84851F801EC;
	Fri,  6 Mar 2020 16:50:02 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 0C1B9F801ED; Fri,  6 Mar 2020 16:50:00 +0100 (CET)
Received: from mga06.intel.com (mga06.intel.com [134.134.136.31])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id CD6DAF80125
 for <alsa-devel@alsa-project.org>; Fri,  6 Mar 2020 16:49:56 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz CD6DAF80125
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
 by orsmga104.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384;
 06 Mar 2020 07:49:52 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.70,522,1574150400"; d="scan'208";a="275583273"
Received: from jrbond-mobl.amr.corp.intel.com (HELO [10.254.11.58])
 ([10.254.11.58])
 by fmsmga002.fm.intel.com with ESMTP; 06 Mar 2020 07:49:50 -0800
Subject: Re: [PATCH 5/7] ASoC: Intel: skl_hda_dsp: Enable Dmic configuration
To: Kai Vehmanen <kai.vehmanen@linux.intel.com>,
 Cezary Rojewski <cezary.rojewski@intel.com>
References: <20200305145314.32579-1-cezary.rojewski@intel.com>
 <20200305145314.32579-6-cezary.rojewski@intel.com>
 <alpine.DEB.2.21.2003061636580.2957@eliteleevi.tm.intel.com>
From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Message-ID: <b4874ca6-4c47-ffc8-f3b0-a2ba39797dcc@linux.intel.com>
Date: Fri, 6 Mar 2020 09:49:50 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <alpine.DEB.2.21.2003061636580.2957@eliteleevi.tm.intel.com>
Content-Type: text/plain; charset=iso-8859-15; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Cc: alsa-devel@alsa-project.org, lgirdwood@gmail.com, tiwai@suse.com,
 vkoul@kernel.org, broonie@kernel.org,
 Mateusz Gorski <mateusz.gorski@linux.intel.com>
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


> But a more pressing issue is that this breaks platforms using SOF
> firmware:
> 
> [   28.751756] skl_hda_dsp_generic skl_hda_dsp_generic: ASoC: no sink widget found for dmic01_hifi
> [   28.751987] skl_hda_dsp_generic skl_hda_dsp_generic: ASoC: Failed to add route DMIC01 Rx -> direct -> dmic01_hifi
> 
> ... maybe you can align the topology to mathc so we can reuse the same
> widget mapping for both SOF and SST firmwares..?

Yeah, I thought this would break userspace and installed topologies and 
that just confirms it. Adding hard-coded routes is really not recommended.

the alternate solution is what I suggested in another thread "No sound 
since 5.4 on skl_n88l25_s4567", we could mark this machine driver as 
having an incomplete topology and remove the topology checks in the core.

I couldn't really test my initial patch but that that Cezary 
unintentionally broke SOF actually that gives me a tool to test the 
solution.


