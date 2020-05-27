Return-Path: <SRS0=+ZhY=7J=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DDE70C433DF
	for <alsa-devel@archiver.kernel.org>; Wed, 27 May 2020 01:08:53 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6ADC3207CB
	for <alsa-devel@archiver.kernel.org>; Wed, 27 May 2020 01:08:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="hVSRDe/1"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6ADC3207CB
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=zju.edu.cn
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id D403D1724;
	Wed, 27 May 2020 03:08:01 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz D403D1724
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1590541731;
	bh=gt/T8fJRy9zc5ZIiAq99M+iyJqPMeHLiRxcb5NqQszw=;
	h=Date:From:To:Subject:In-Reply-To:References:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=hVSRDe/1JrZEOB7DvrM5/yxaC33TM0JGOLEDfn+bazRfG9TcntlQRTptAfFySgDgH
	 DleIDl5NGscpaIgIw6YO0tlEk6fLKhB9r5i0Y82ruI8N+DM95JKXXUyjelQ/o5GQKM
	 4ZyXHyvy8n9LAtjt8GFhZJX+7jQFsaO6jseRaJYA=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 6D76DF80150;
	Wed, 27 May 2020 03:08:01 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 66A96F8015C; Wed, 27 May 2020 03:07:59 +0200 (CEST)
Received: from zju.edu.cn (mail.zju.edu.cn [61.164.42.155])
 by alsa1.perex.cz (Postfix) with ESMTP id CFC8CF80146
 for <alsa-devel@alsa-project.org>; Wed, 27 May 2020 03:07:51 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz CFC8CF80146
Received: by ajax-webmail-mail-app2 (Coremail) ; Wed, 27 May 2020 09:07:40
 +0800 (GMT+08:00)
X-Originating-IP: [222.205.60.151]
Date: Wed, 27 May 2020 09:07:40 +0800 (GMT+08:00)
X-CM-HeaderCharset: UTF-8
From: dinghao.liu@zju.edu.cn
To: "Pierre-Louis Bossart" <pierre-louis.bossart@linux.intel.com>
Subject: Re: Re: [PATCH] ASoC: Intel: sst: Fix runtime PM imbalance in
 sst_power_control
X-Priority: 3
X-Mailer: Coremail Webmail Server Version XT5.0.10 build 20190906(84e8bf8f)
 Copyright (c) 2002-2020 www.mailtech.cn zju.edu.cn
In-Reply-To: <922ac37c-0a5a-dff7-0cd7-d3487cf9ff00@linux.intel.com>
References: <20200525070701.3888-1-dinghao.liu@zju.edu.cn>
 <922ac37c-0a5a-dff7-0cd7-d3487cf9ff00@linux.intel.com>
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset=UTF-8
MIME-Version: 1.0
Message-ID: <73fef900.d8158.17253abb08c.Coremail.dinghao.liu@zju.edu.cn>
X-Coremail-Locale: zh_CN
X-CM-TRANSID: by_KCgCnEbxcvc1eVVkcAA--.3818W
X-CM-SenderInfo: qrrzjiaqtzq6lmxovvfxof0/1tbiAg0MBlZdtOUT6wAGsh
X-Coremail-Antispam: 1Ur529EdanIXcx71UUUUU7IcSsGvfJTRUUUbuCS07vEb7Iv0x
 C_Xr1lV2xY67kC6x804xWlV2xY67CY07I20VC2zVCF04k26cxKx2IYs7xG6rWj6s0DMIAI
 bVAFxVCF77xC64kEw24lV2xY67C26IkvcIIF6IxKo4kEV4ylV2xY628lY4IE4IxF12IF4w
 CS07vE84x0c7CEj48ve4kI8wCS07vE84ACjcxK6xIIjxv20xvE14v26w1j6s0DMIAIbVA2
 z4x0Y4vE2Ix0cI8IcVCY1x0267AKxVW0oVCq3wCS07vE84ACjcxK6I8E87Iv67AKxVW0oV
 Cq3wCS07vE84ACjcxK6I8E87Iv6xkF7I0E14v26rxl6s0DMIAIbVAS0I0E0xvYzxvE52x0
 82IY62kv0487MIAIbVAqx4xG64xvF2IEw4CE5I8CrVC2j2WlV2xY6cIj6xIIjxv20xvE14
 v26r1j6r18MIAIbVAv7VC2z280aVAFwI0_Jr0_Gr1lV2xY6cvjeVCFs4IE7xkEbVWUJVW8
 JwCS07vEFIxGxcIEc7CjxVA2Y2ka0xkIwI1lV2xY6x02cVAKzwCS07vEc2xSY4AK67AK6w
 4lV2xY6xkI7II2jI8vz4vEwIxGrwCS07vE42xK82IY6x8ErcxFaVAv8VW8uw4UJr1UMIAI
 bVCF72vE77IF4wCS07vE4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lV2xY6I8I3I0E5I8CrVAFwI
 0_Jr0_Jr4lV2xY6I8I3I0E7480Y4vE14v26r106r1rMIAIbVC2zVAF1VAY17CE14v26r1q
 6r43MIAIbVCI42IY6xIIjxv20xvE14v26r1j6r1xMIAIbVCI42IY6xIIjxv20xvEc7CjxV
 AFwI0_Gr0_Cr1lV2xY6IIF0xvE42xK8VAvwI8IcIk0rVWrZr1j6s0DMIAIbVCI42IY6I8E
 87Iv67AKxVWUJVW8JwCS07vEIxAIcVC2z280aVCY1x0267AKxVW8JVW8JrUvcSsGvfC2Kf
 nxnUU==
Cc: Cezary Rojewski <cezary.rojewski@intel.com>, linux-kernel@vger.kernel.org,
 alsa-devel@alsa-project.org, kjlu@umn.edu, Jie Yang <yang.jie@linux.intel.com>,
 Takashi Iwai <tiwai@suse.com>, Liam Girdwood <liam.r.girdwood@linux.intel.com>,
 Alexios Zavras <alexios.zavras@intel.com>, Mark Brown <broonie@kernel.org>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Thomas Gleixner <tglx@linutronix.de>, Allison Randal <allison@lohutok.net>
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

PiAKPiB0aGlzIGNoYW5nZSBkb2Vzbid0IHNlZW0gcXVpdGUgcmlnaHQsIGlmIHlvdSBsb29rIHRo
ZSBjb2RlIGJlbG93IHRoZXJlIAo+IGlzIG5vIFBNIGltYmFsYW5jZSwgaXMgdGhlcmU/Cj4gCj4g
aW50IHNzdF9wbV9ydW50aW1lX3B1dChzdHJ1Y3QgaW50ZWxfc3N0X2RydiAqc3N0X2RydikKPiB7
Cj4gCWludCByZXQ7Cj4gCj4gCXBtX3J1bnRpbWVfbWFya19sYXN0X2J1c3koc3N0X2Rydi0+ZGV2
KTsKPiAJcmV0ID0gcG1fcnVudGltZV9wdXRfYXV0b3N1c3BlbmQoc3N0X2Rydi0+ZGV2KTsKPiAJ
aWYgKHJldCA8IDApCj4gCQlyZXR1cm4gcmV0Owo+IAlyZXR1cm4gMDsKPiB9CgpZb3UgYXJlIHJp
Z2h0LiBUaGFuayB5b3UgZm9yIHlvdXIgY29ycmVjdGlvbiEKClJlZ2FyZHMsCkRpbmdoYW8K
