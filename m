Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 49A0BC0015E
	for <alsa-devel@archiver.kernel.org>; Wed, 19 Jul 2023 03:04:58 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 046CA1FE;
	Wed, 19 Jul 2023 05:04:05 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 046CA1FE
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1689735895;
	bh=he94OwgC9KHANHR7TFVj9abnWkS4N6subcM1CyuQYz4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Archive:List-Help:List-Owner:List-Post:List-Subscribe:
	 List-Unsubscribe:From;
	b=PktZNdIJ3jM9Fz/93diSqOSwidU+9EO/miW8YP0cJiolFnIInjfpe1fY0xFvStiXm
	 P5CzLQ9sbSspqQ+xjHK7LXf97ZQphX7bQ9NiRDrHH4bomYFRgWAmJEt8ixlsOpz+oK
	 CEJ20fzlGP0CdmQbzCOjnRjbxzLkQmi3P5WaQX5g=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id D2770F804DA; Wed, 19 Jul 2023 05:03:38 +0200 (CEST)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id 31B54F8047D;
	Wed, 19 Jul 2023 05:03:38 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 6B7BFF8047D; Wed, 19 Jul 2023 04:59:53 +0200 (CEST)
Received: from out28-121.mail.aliyun.com (out28-121.mail.aliyun.com
 [115.124.28.121])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest
 SHA256)
	(No client certificate requested)
	by alsa1.perex.cz (Postfix) with ESMTPS id 8BB67F80153
	for <alsa-devel@alsa-project.org>; Wed, 19 Jul 2023 04:59:39 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 8BB67F80153
X-Alimail-AntiSpam: 
 AC=CONTINUE;BC=0.1746865|-1;CH=green;DM=|CONTINUE|false|;DS=CONTINUE|ham_social|0.0353264-0.00181599-0.962858;FP=0|0|0|0|0|-1|-1|-1;HT=ay29a033018047193;MF=wangweidong.a@awinic.com;NM=1;PH=DS;RN=26;RT=26;SR=0;TI=SMTPD_---.Tx3JJXh_1689735568;
Received: from ubuntu-VirtualBox..(mailfrom:wangweidong.a@awinic.com
 fp:SMTPD_---.Tx3JJXh_1689735568)
          by smtp.aliyun-inc.com;
          Wed, 19 Jul 2023 10:59:31 +0800
From: wangweidong.a@awinic.com
To: rdunlap@infradead.org
Cc: alsa-devel@alsa-project.org,
	broonie@kernel.org,
	ckeepax@opensource.cirrus.com,
	colin.i.king@gmail.com,
	conor+dt@kernel.org,
	devicetree@vger.kernel.org,
	doug@schmorgal.com,
	fido_max@inbox.ru,
	flatmax@flatmax.com,
	herve.codina@bootlin.com,
	kiseok.jo@irondevice.com,
	krzysztof.kozlowski+dt@linaro.org,
	lgirdwood@gmail.com,
	linux-kernel@vger.kernel.org,
	liweilei@awinic.com,
	perex@perex.cz,
	pierre-louis.bossart@linux.intel.com,
	rf@opensource.cirrus.com,
	robh+dt@kernel.org,
	shumingf@realtek.com,
	tiwai@suse.com,
	trix@redhat.com,
	wangweidong.a@awinic.com,
	yijiangtao@awinic.com,
	zhangjianming@awinic.com
Subject: Re: [PATCH V1 4/5] ASoC: codecs: aw88261 chip register file,
 data type file and Kconfig Makefile
Date: Wed, 19 Jul 2023 10:59:27 +0800
Message-ID: <20230719025928.41357-1-wangweidong.a@awinic.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <94068cfc-186a-1cac-0f76-77b3b46a85bd@infradead.org>
References: <94068cfc-186a-1cac-0f76-77b3b46a85bd@infradead.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Message-ID-Hash: FHEG4NAPZHC6RJQ55SY4EM7YFEB6GYHJ
X-Message-ID-Hash: FHEG4NAPZHC6RJQ55SY4EM7YFEB6GYHJ
X-MailFrom: wangweidong.a@awinic.com
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency;
 loop; banned-address; member-moderation;
 header-match-alsa-devel.alsa-project.org-0;
 header-match-alsa-devel.alsa-project.org-1; nonmember-moderation;
 administrivia; implicit-dest; max-recipients; max-size; news-moderation;
 no-subject; digests; suspicious-header
X-Mailman-Version: 3.3.8
Precedence: list
List-Id: "Alsa-devel mailing list for ALSA developers -
 http://www.alsa-project.org" <alsa-devel.alsa-project.org>
Archived-At: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/FHEG4NAPZHC6RJQ55SY4EM7YFEB6GYHJ/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

Hi, Randy Dunlap,
 Thank you very much for your advice

> On 7/17/23 04:58, wangweidong.a@awinic.com wrote:
>> +config SND_SOC_AW88261
>> +	tristate "Soc Audio for awinic aw88261"

>	                        Awininc
> (as below)

I will modify it as suggested.

>> +	depends on I2C
>> +	select CRC8
>> +	select REGMAP_I2C
>> +	select GPIOLIB
>> +	select SND_SOC_AW88261_LIB
>> +	help
>> +	  this option enables support for aw88261 Smart PA.

	  This

>> +	  The Awinic AW88261 is an I2S/TDM input, high efficiency
>> +	  digital Smart K audio amplifier with an integrated 10.25V
>> +		smart boost convert.

> Less indentation on the last line (align it with the previous line).

I will modify it as suggested.

Best regards,
Weidong Wang
