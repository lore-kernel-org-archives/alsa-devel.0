Return-Path: <SRS0=GrjN=62=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 45536CA90AF
	for <alsa-devel@archiver.kernel.org>; Tue, 12 May 2020 16:30:59 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C4416206F5
	for <alsa-devel@archiver.kernel.org>; Tue, 12 May 2020 16:30:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="ETsHp8v1"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C4416206F5
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 17FCF16AC;
	Tue, 12 May 2020 18:30:07 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 17FCF16AC
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1589301057;
	bh=uAD0Dhgd7yeJ+4vRCo8bF75oMq2FZg1EjVnoCI0oUX8=;
	h=Subject:To:References:From:Date:In-Reply-To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=ETsHp8v1UQErLB+fS3f3A3IrH40FDVOrlgnMmP/vagUFh4FSJ/Tib6E5vK9nydD0r
	 QQa7CXYwCi5j7D3HPKVDSLu14qYE0LUXJzSIfUsPkphyc++ziqfvkZHZ/ZMVl54KP5
	 pORcFwBbtCq2mGjMn+HKlkD2F4H4kGxFmUb3Tvwk=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id DAA99F800AA;
	Tue, 12 May 2020 18:30:05 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 7B253F8014C; Tue, 12 May 2020 18:29:47 +0200 (CEST)
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 49A3BF800AA
 for <alsa-devel@alsa-project.org>; Tue, 12 May 2020 18:29:34 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 49A3BF800AA
IronPort-SDR: vZgeY6ExpJ+q/N3qL/CsOTzmjdlEcsuRasXaqb7jW9NvWnXnU0K/b56+eyX9G/BFFowz3BvRDz
 CGqQNTUx9C/Q==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga004.jf.intel.com ([10.7.209.38])
 by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 12 May 2020 09:29:31 -0700
IronPort-SDR: 11iyl/MGKlMRiYJhqLuSqDeXTzVcOYBtIqrzh1dEKN+GUkY9o4T7VojTTc5Bsqaq802cOg2qaT
 6ZLVSOWMK41Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.73,384,1583222400"; d="scan'208";a="409359961"
Received: from bmtannen-mobl.amr.corp.intel.com (HELO [10.255.228.231])
 ([10.255.228.231])
 by orsmga004.jf.intel.com with ESMTP; 12 May 2020 09:29:30 -0700
Subject: Re: [PATCH] ASoC: topology: log all headers being parsed
To: Keyon Jie <yang.jie@linux.intel.com>, alsa-devel@alsa-project.org
References: <20200509082248.2757-1-yang.jie@linux.intel.com>
 <75fb69cc-830f-432a-c724-7449309f2eba@linux.intel.com>
 <36aab97b-a45a-de39-dea1-a1aa84c5a6d9@linux.intel.com>
From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Message-ID: <b00ab72b-df95-b9dc-eb94-4491b8074413@linux.intel.com>
Date: Tue, 12 May 2020 11:22:57 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <36aab97b-a45a-de39-dea1-a1aa84c5a6d9@linux.intel.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Cc: Takashi Iwai <tiwai@suse.de>, Mark Brown <broonie@kernel.org>
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



> I can add a function to reconcile the two list, but since we already 
> have "tplg->pass != SOC_TPLG_PASS_xxx" check in each xxx_load(), do you 
> suggest to moving the logging inside these xxx_load() to reduce the 
> redundant check?

yes, you could add a static inline sof_tplg_log_hdr(hdr); after each 
pass check, sounds good to me.
