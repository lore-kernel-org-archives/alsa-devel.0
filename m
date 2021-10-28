Return-Path: <SRS0=jYMw=PQ=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 317ADC433F5
	for <alsa-devel@archiver.kernel.org>; Thu, 28 Oct 2021 14:32:52 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B671B60F58
	for <alsa-devel@archiver.kernel.org>; Thu, 28 Oct 2021 14:32:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org B671B60F58
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 23D0F16E3;
	Thu, 28 Oct 2021 16:31:59 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 23D0F16E3
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1635431569;
	bh=K+l5odgqXWaWSoZ5TSKrWFF1AGO0qpuukpQqVgkBT0I=;
	h=Subject:To:References:From:Date:In-Reply-To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=RxxcwPYtQvLxFGouUpWLnnesK1Omh2MtYhj/0nsY/K61ZRKtuK/bNaA0gZfbUu1Bv
	 CdLlgROyNEp4dOnTntS9xgrst6rGX9reshXnF6AXAMYCz1vRk5seEr8KtxmVJkChWk
	 9Q3Mqt2RT7UFVNaVV6752Fkocr/ZOFxcPTDe594U=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id AFEE3F80269;
	Thu, 28 Oct 2021 16:31:58 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 2A9AFF802C8; Thu, 28 Oct 2021 16:31:57 +0200 (CEST)
Received: from mga06.intel.com (mga06.intel.com [134.134.136.31])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 549F6F8014E
 for <alsa-devel@alsa-project.org>; Thu, 28 Oct 2021 16:31:48 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 549F6F8014E
X-IronPort-AV: E=McAfee;i="6200,9189,10151"; a="291255037"
X-IronPort-AV: E=Sophos;i="5.87,190,1631602800"; d="scan'208";a="291255037"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
 by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 28 Oct 2021 07:31:45 -0700
X-IronPort-AV: E=Sophos;i="5.87,190,1631602800"; d="scan'208";a="573767285"
Received: from sjsanghv-mobl.amr.corp.intel.com (HELO [10.212.61.51])
 ([10.212.61.51])
 by fmsmga003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 28 Oct 2021 07:31:43 -0700
Subject: Re: [PATCH v2] ASoc: Intel: glk_rt5682_max98357a: support ALC5682I-VS
 codec
To: Brent Lu <brent.lu@intel.com>, alsa-devel@alsa-project.org
References: <20211028140909.496022-1-brent.lu@intel.com>
From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Message-ID: <5a69b8e0-b602-a6bf-e98d-0593e500973e@linux.intel.com>
Date: Thu, 28 Oct 2021 09:31:42 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Firefox/78.0 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <20211028140909.496022-1-brent.lu@intel.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Cc: Guennadi Liakhovetski <guennadi.liakhovetski@linux.intel.com>,
 Cezary Rojewski <cezary.rojewski@intel.com>,
 Julian Braha <julianbraha@gmail.com>,
 Kai Vehmanen <kai.vehmanen@linux.intel.com>,
 Nathan Chancellor <nathan@kernel.org>, Jie Yang <yang.jie@linux.intel.com>,
 Takashi Iwai <tiwai@suse.com>, linux-kernel@vger.kernel.org,
 Liam Girdwood <liam.r.girdwood@linux.intel.com>,
 Mark Brown <broonie@kernel.org>, Geert Uytterhoeven <geert@linux-m68k.org>,
 Paul Olaru <paul.olaru@oss.nxp.com>, Rander Wang <rander.wang@intel.com>,
 Peter Ujfalusi <peter.ujfalusi@linux.intel.com>
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



On 10/28/21 9:09 AM, Brent Lu wrote:
> Detect the codec variant in probe function and update DAI link
> accordingly. Also add an new entry in enumeration table for machine
> driver enumeration.
> 
> Signed-off-by: Brent Lu <brent.lu@intel.com>

Acked-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
