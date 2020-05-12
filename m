Return-Path: <SRS0=GrjN=62=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 26B03C54E8B
	for <alsa-devel@archiver.kernel.org>; Tue, 12 May 2020 07:34:22 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9C0B520733
	for <alsa-devel@archiver.kernel.org>; Tue, 12 May 2020 07:34:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="i9iGjhHV"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9C0B520733
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 07B0E166D;
	Tue, 12 May 2020 09:33:30 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 07B0E166D
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1589268860;
	bh=bY9imBKmdN5exRNl5zsEAmhsTZ++2GcU4h/h4sb/U7Q=;
	h=Subject:To:References:From:Date:In-Reply-To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=i9iGjhHVHwyAf0YxbaLXrgQf2KDO3tnka0gcI+dZjLxoBWWrzY5qiYk9bptZekjL1
	 soqfW6Q6yIQ7UtUMKMIJMg7D/uQAXJitwuXIl0abEJm+hCBbXmJ9/yQnQczxBih2Pc
	 VdN/PfNlOWQyJ0+k5js/UI34xOIy6KvGJmDhvNI4=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 5E1BBF80158;
	Tue, 12 May 2020 09:33:29 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 5B816F8015A; Tue, 12 May 2020 09:33:27 +0200 (CEST)
Received: from mga06.intel.com (mga06.intel.com [134.134.136.31])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id A82B8F800E3
 for <alsa-devel@alsa-project.org>; Tue, 12 May 2020 09:33:18 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz A82B8F800E3
IronPort-SDR: KpXXV0JV1uHiIoaGjjv7LpJ26ZjUtH3SgQ13gYPzqZWFyNtHHRQk2H6QT7GVhgKPET2VxtuVe4
 fGuCjUfvXihA==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga002.jf.intel.com ([10.7.209.21])
 by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 12 May 2020 00:33:16 -0700
IronPort-SDR: mOnhCYrI/hwbSJ6Rz5F8io09W6qWJabrV2NlQKxofM+IqC5c+4DH1bE8mlTPrl4sZg9a5w7Ngt
 H1uAKuXKx6hg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.73,383,1583222400"; d="scan'208";a="280037391"
Received: from mgleba-mobl.ger.corp.intel.com (HELO [10.213.17.239])
 ([10.213.17.239])
 by orsmga002.jf.intel.com with ESMTP; 12 May 2020 00:33:13 -0700
Subject: Re: [PATCH 1/2] ASoC: Intel: baytrail: Fix register access
To: "Lu, Brent" <brent.lu@intel.com>, =?UTF-8?Q?Amadeusz_S=c5=82awi=c5=84ski?=
 <amadeuszx.slawinski@linux.intel.com>,
 Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
 Liam Girdwood <lgirdwood@gmail.com>, Jie Yang <yang.jie@linux.intel.com>,
 Mark Brown <broonie@kernel.org>, Takashi Iwai <tiwai@suse.com>
References: <20200507133405.32251-1-amadeuszx.slawinski@linux.intel.com>
 <BN6PR1101MB2132B47AE82281E17C9CD78B97BE0@BN6PR1101MB2132.namprd11.prod.outlook.com>
From: Cezary Rojewski <cezary.rojewski@intel.com>
Message-ID: <1de7ea69-1a87-5a0b-45f1-ea38aff85d9a@intel.com>
Date: Tue, 12 May 2020 09:33:12 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <BN6PR1101MB2132B47AE82281E17C9CD78B97BE0@BN6PR1101MB2132.namprd11.prod.outlook.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>
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

On 2020-05-12 8:19 AM, Lu, Brent wrote:
>> -----Original Message-----
>> From: Alsa-devel <alsa-devel-bounces@alsa-project.org> On Behalf Of
>> Amadeusz Slawinski
>> Sent: Thursday, May 7, 2020 9:34 PM
>> To: Rojewski, Cezary <cezary.rojewski@intel.com>; Pierre-Louis Bossart
>> <pierre-louis.bossart@linux.intel.com>; Liam Girdwood
>> <lgirdwood@gmail.com>; Jie Yang <yang.jie@linux.intel.com>; Mark Brown
>> <broonie@kernel.org>; Takashi Iwai <tiwai@suse.com>
>> Cc: alsa-devel@alsa-project.org; Amadeusz Sławiński
>> <amadeuszx.slawinski@linux.intel.com>
>> Subject: [PATCH 1/2] ASoC: Intel: baytrail: Fix register access
>>
>> Baytrail has 64 bit registers, so we should use *read64* to read from it and
>> then use proper mask values to check status.
>>
>> Signed-off-by: Amadeusz Sławiński <amadeuszx.slawinski@linux.intel.com>
> 
> Tested-by: Brent Lu <brent.lu@intel.com>
> 
> 
> Regards,
> Brent
> 

Thanks Brent!

Acked-by: Cezary Rojewski <cezary.rojewski@intel.com>
