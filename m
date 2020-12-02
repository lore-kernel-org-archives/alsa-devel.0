Return-Path: <SRS0=YmRK=FG=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8760DC64E7B
	for <alsa-devel@archiver.kernel.org>; Wed,  2 Dec 2020 15:52:48 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B7303221EB
	for <alsa-devel@archiver.kernel.org>; Wed,  2 Dec 2020 15:52:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B7303221EB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id DAF871790;
	Wed,  2 Dec 2020 16:51:53 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz DAF871790
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1606924364;
	bh=kFogjcNCiQNrz4HDIHzhRak/GyRjNI866YGzUbwPOuE=;
	h=Subject:To:References:From:Date:In-Reply-To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=jFTqnIZ8MNzaYVOVEmP3e8o5glRHFg7A4c3X6V47eZX+5IZLRxr5WTNYCw8iZCGLj
	 XIV9ExmcEHwQ7XYd20cA4wL7cxqToRFIJY+oCeZolB4QBMRURbcmtKFKqjZy8ZJsRQ
	 tKUgLHJ1kPOlrfkjbrb3YiH2hR86lpYKRd1jyJ/o=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 3CC31F80168;
	Wed,  2 Dec 2020 16:51:53 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id A56C6F8025F; Wed,  2 Dec 2020 16:51:50 +0100 (CET)
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 3F63AF80158
 for <alsa-devel@alsa-project.org>; Wed,  2 Dec 2020 16:51:44 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 3F63AF80158
IronPort-SDR: xH+0MCvAY2kT+d578QYEND5w8OA/Bsjs7equiF19Rl2oq22YNpRVfFmCB8JTEBYzxg5DHDKx/U
 72AJtheo2VpA==
X-IronPort-AV: E=McAfee;i="6000,8403,9823"; a="152862648"
X-IronPort-AV: E=Sophos;i="5.78,387,1599548400"; d="scan'208";a="152862648"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
 by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 02 Dec 2020 07:51:40 -0800
IronPort-SDR: 1saECTZ06J0Pd5CoYIuPgi5eATW5aWi8+qDgwlYZOHd3VIFz1dSC0xiV7ioAnAQHfGrLS1G/NE
 /4ISzNp5WTyA==
X-IronPort-AV: E=Sophos;i="5.78,387,1599548400"; d="scan'208";a="539740422"
Received: from ajrodr4-mobl1.amr.corp.intel.com (HELO [10.213.167.252])
 ([10.213.167.252])
 by fmsmga005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 02 Dec 2020 07:51:38 -0800
Subject: Re: [PATCH] ASoC: intel: sof_rt5682: Add support for tgl_rt1011_rt5682
To: Brent Lu <brent.lu@intel.com>, alsa-devel@alsa-project.org
References: <20201202015826.7678-1-brent.lu@intel.com>
From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Message-ID: <9d3d76fd-869c-ec20-0fa0-a0da88e32502@linux.intel.com>
Date: Wed, 2 Dec 2020 09:18:16 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20201202015826.7678-1-brent.lu@intel.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Cc: Guennadi Liakhovetski <guennadi.liakhovetski@linux.intel.com>,
 Cezary Rojewski <cezary.rojewski@intel.com>,
 Dharageswari R <dharageswari.r@intel.com>,
 Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>,
 Kai Vehmanen <kai.vehmanen@linux.intel.com>,
 Rander Wang <rander.wang@linux.intel.com>, Jie Yang <yang.jie@linux.intel.com>,
 linux-kernel@vger.kernel.org, Takashi Iwai <tiwai@suse.com>,
 Liam Girdwood <liam.r.girdwood@linux.intel.com>,
 Ben Zhang <benzh@chromium.org>, Mark Brown <broonie@kernel.org>,
 Sathyanarayana Nujella <sathyanarayana.nujella@intel.com>,
 Naveen Manohar <naveen.m@intel.com>, Libin Yang <libin.yang@linux.intel.com>,
 Bard Liao <yung-chuan.liao@linux.intel.com>, Fred Oh <fred.oh@linux.intel.com>,
 Yong Zhi <yong.zhi@intel.com>
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


> +struct {
> +	unsigned int tx;
> +	unsigned int rx;
> +} rt1011_tdm_mask[] = {
> +	{.tx = 0x4, .rx = 0x1},
> +	{.tx = 0x8, .rx = 0x2},
> +};

as noted in the GitHub review this should be static and possibly const.

