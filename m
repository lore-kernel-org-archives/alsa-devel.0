Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C5332CDD573
	for <alsa-devel@archiver.kernel.org>; Thu, 19 Sep 2024 13:15:41 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id B9D65850;
	Thu, 19 Sep 2024 15:15:29 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz B9D65850
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1726751739;
	bh=04M62AnevvKOpl+yrEWkhUipAMKBwSj5m1kfSIBHe7E=;
	h=From:To:CC:Subject:Date:In-Reply-To:References:List-Id:
	 List-Archive:List-Help:List-Owner:List-Post:List-Subscribe:
	 List-Unsubscribe:From;
	b=qa8A9hsIJp2dYrwb/J9u6jfVk53tSed+cPrdOwPzkFYv+f99GtTSVHQqZG4vfDO5Q
	 v5zDCTgAkDmLBVsc/N0+240huYWHqvpXqpJGUXaT+OhBS8QjeWvRtfKwiQFdqw79Q4
	 FaKmo21AIq19F33hx1Vst2JpJ3wwYyyqLyzxyGDU=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 2A383F806D9; Thu, 19 Sep 2024 15:13:25 +0200 (CEST)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id 45D2DF806D9;
	Thu, 19 Sep 2024 15:13:25 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 3F283F8020D; Mon, 16 Sep 2024 13:34:17 +0200 (CEST)
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com
 [68.232.154.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by alsa1.perex.cz (Postfix) with ESMTPS id A19FAF80107
	for <alsa-devel@alsa-project.org>; Mon, 16 Sep 2024 13:34:13 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz A19FAF80107
Authentication-Results: alsa1.perex.cz;
	dkim=pass (2048-bit key,
 unprotected) header.d=microchip.com header.i=@microchip.com
 header.a=rsa-sha256 header.s=mchp header.b=YP0KVLnk
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1726486456; x=1758022456;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=04M62AnevvKOpl+yrEWkhUipAMKBwSj5m1kfSIBHe7E=;
  b=YP0KVLnkfZmW5TS81gTX22hnn4EaCTDkjBlFe8oYkAgvBjRRe+kZ083i
   XsXYXXGD+ZIYi88tIZqNbfIyD35DKekA6PowM71fi6+Bg26iSPNqrCbFQ
   QwmyBPJltfH6K+x1N/QLa1hLmEOJmg4d+FkYAIv4abo9PNXsyHNThR4lV
   +UVp/0V0JUBCdjbx6TdK+1QMiMhkCgglGt63vvwwqjMHot6MDIR+eaKfF
   UfRGRKVzIe5RbRQy83qt7OCwAiwstifYTC91xkhYn2VjVGhXlTiIXdC86
   1ufPRS+DerdU4/WyzTEjxJdwsjKqDj6LAHYPP9TRik0wTXlFfPWZuTrOM
   A==;
X-CSE-ConnectionGUID: Onkqnjp3T4uu7VkYLySsmg==
X-CSE-MsgGUID: DF5Odg+jTkKSP28grZCI6g==
X-IronPort-AV: E=Sophos;i="6.10,233,1719903600";
   d="scan'208";a="32447859"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa2.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256;
 16 Sep 2024 04:34:11 -0700
Received: from chn-vm-ex03.mchp-main.com (10.10.85.151) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Mon, 16 Sep 2024 04:34:05 -0700
Received: from ROB-ULT-M76677.microchip.com (10.10.85.11) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server id
 15.1.2507.35 via Frontend Transport; Mon, 16 Sep 2024 04:34:03 -0700
From: Andrei Simion <andrei.simion@microchip.com>
To: <alexandre.belloni@bootlin.com>
CC: <alsa-devel@alsa-project.org>, <andrei.simion@microchip.com>,
	<broonie@kernel.org>, <claudiu.beznea@tuxon.dev>,
	<codrin.ciubotariu@microchip.com>, <lgirdwood@gmail.com>,
	<linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
	<linux-sound@vger.kernel.org>, <nicolas.ferre@microchip.com>,
	<perex@perex.cz>, <tiwai@suse.com>
Subject: Re: [PATCH 2/2] ASoC: atmel: atmel_ssc_dai: Drop S24_LE support due
 to single channel limitation
Date: Mon, 16 Sep 2024 14:32:05 +0300
Message-ID: <20240916113203.17871-1-andrei.simion@microchip.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240916100006f2db7b06@mail.local>
References: <20240916100006f2db7b06@mail.local>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-MailFrom: prvs=98237714c=Andrei.Simion@microchip.com
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency;
 loop; banned-address; member-moderation;
 header-match-alsa-devel.alsa-project.org-0;
 header-match-alsa-devel.alsa-project.org-1
Message-ID-Hash: 7VUQBQGSL3PMQD2NA2QFC77M4LHSQO2A
X-Message-ID-Hash: 7VUQBQGSL3PMQD2NA2QFC77M4LHSQO2A
X-Mailman-Approved-At: Thu, 19 Sep 2024 13:13:10 +0000
X-Mailman-Version: 3.3.9
Precedence: list
List-Id: "Alsa-devel mailing list for ALSA developers -
 http://www.alsa-project.org" <alsa-devel.alsa-project.org>
Archived-At: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/7VUQBQGSL3PMQD2NA2QFC77M4LHSQO2A/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

On 16.09.2024 12:59, Alexandre Belloni wrote:
> EXTERNAL EMAIL: Do not click links or open attachments unless you know the content is safe
> 
> On 16/09/2024 11:52:15+0300, Andrei Simion wrote:
>> From: Codrin Ciubotariu <codrin.ciubotariu@microchip.com>
>>
>> Drop S24_LE format because it is not supported if more than 2 channels
>> (of TDM slots) are used. This limitation makes it impractical for use cases
>> requiring more than 2 TDM slots, leading to potential issues in
>> multi-channel configurations.
>>
>> [andrei.simion@microchip.com: Reword the commit title and the commit
>> message.]
>>
>> Signed-off-by: Codrin Ciubotariu <codrin.ciubotariu@microchip.com>
>> Signed-off-by: Andrei Simion <andrei.simion@microchip.com>
>> ---
>>  sound/soc/atmel/atmel_ssc_dai.c | 2 +-
>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/sound/soc/atmel/atmel_ssc_dai.c b/sound/soc/atmel/atmel_ssc_dai.c
>> index 7047f17fe7a8..475e7579c64c 100644
>> --- a/sound/soc/atmel/atmel_ssc_dai.c
>> +++ b/sound/soc/atmel/atmel_ssc_dai.c
>> @@ -822,7 +822,7 @@ static int atmel_ssc_resume(struct snd_soc_component *component)
>>  }
>>
>>  #define ATMEL_SSC_FORMATS (SNDRV_PCM_FMTBIT_S8     | SNDRV_PCM_FMTBIT_S16_LE |\
>> -                       SNDRV_PCM_FMTBIT_S24_LE | SNDRV_PCM_FMTBIT_S32_LE)
>> +                        SNDRV_PCM_FMTBIT_S32_LE)
>
> I believe this requires a comment. Else someone may add it back later
> on.
>

It is unclear to me. Would it be good to send v2 with this update?

>>
>>  static const struct snd_soc_dai_ops atmel_ssc_dai_ops = {
>>       .startup        = atmel_ssc_startup,
>> --
>> 2.34.1
>>
>
> --
> Alexandre Belloni, co-owner and COO, Bootlin
> Embedded Linux and Kernel engineering
> https://bootlin.com

Best regards,
Andrei Simion
