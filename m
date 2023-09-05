Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AEB69C83F33
	for <alsa-devel@archiver.kernel.org>; Tue,  5 Sep 2023 03:33:01 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 69233827;
	Tue,  5 Sep 2023 05:32:08 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 69233827
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1693884778;
	bh=06P9TVTByhGMHQB15eXWRMf4fMVLupaEKGsqdutcMgs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Archive:List-Help:List-Owner:List-Post:List-Subscribe:
	 List-Unsubscribe:From;
	b=d99+7N/iiq78PE0vKCrHWuK7K1y4URKI0fk89gRQMhtHQPuYm9ZMdomDbkoiNqYfw
	 lEKXz+LAwTOE1efiiXEJomVthfw600q/qxkCDyiCWpMxtRbfluEmKSTlmxgXCeG+WN
	 tHB+8DRl81eoXxtRnXS2lxjEXW3BUTSoI+CaDkkw=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 350A8F80549; Tue,  5 Sep 2023 05:31:42 +0200 (CEST)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id 8F689F8047D;
	Tue,  5 Sep 2023 05:31:41 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id BDC46F8047D; Tue,  5 Sep 2023 05:31:32 +0200 (CEST)
Received: from out28-74.mail.aliyun.com (out28-74.mail.aliyun.com
 [115.124.28.74])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest
 SHA256)
	(No client certificate requested)
	by alsa1.perex.cz (Postfix) with ESMTPS id 25B4CF80141
	for <alsa-devel@alsa-project.org>; Tue,  5 Sep 2023 05:31:17 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 25B4CF80141
X-Alimail-AntiSpam: 
 AC=CONTINUE;BC=0.08675569|-1;CH=green;DM=|CONTINUE|false|;DS=CONTINUE|ham_social|0.00885644-0.00013455-0.991009;FP=0|0|0|0|0|-1|-1|-1;HT=ay29a033018047198;MF=wangweidong.a@awinic.com;NM=1;PH=DS;RN=25;RT=25;SR=0;TI=SMTPD_---.UXm5SLO_1693884663;
Received: from ubuntu-VirtualBox..(mailfrom:wangweidong.a@awinic.com
 fp:SMTPD_---.UXm5SLO_1693884663)
          by smtp.aliyun-inc.com;
          Tue, 05 Sep 2023 11:31:11 +0800
From: wangweidong.a@awinic.com
To: krzysztof.kozlowski@linaro.org
Cc: 13916275206@139.com,
	alsa-devel@alsa-project.org,
	broonie@kernel.org,
	ckeepax@opensource.cirrus.com,
	colin.i.king@gmail.com,
	conor+dt@kernel.org,
	devicetree@vger.kernel.org,
	herve.codina@bootlin.com,
	krzysztof.kozlowski+dt@linaro.org,
	lgirdwood@gmail.com,
	linus.walleij@linaro.org,
	linux-kernel@vger.kernel.org,
	liweilei@awinic.com,
	perex@perex.cz,
	rdunlap@infradead.org,
	rf@opensource.cirrus.com,
	robh+dt@kernel.org,
	ryans.lee@analog.com,
	shumingf@realtek.com,
	tiwai@suse.com,
	trix@redhat.com,
	wangweidong.a@awinic.com,
	yijiangtao@awinic.com,
	zhangjianming@awinic.com
Subject: Re: [PATCH V1 1/3] ASoC: dt-bindings: Add schema for "awinic,aw87390"
Date: Tue,  5 Sep 2023 11:31:03 +0800
Message-ID: <20230905033103.15343-1-wangweidong.a@awinic.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <a3ada071-4c8e-f65d-ad75-655370ba2c55@linaro.org>
References: <a3ada071-4c8e-f65d-ad75-655370ba2c55@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Message-ID-Hash: IDOSQCONGL2L5W5UTAAGQ4GJTH66EBA2
X-Message-ID-Hash: IDOSQCONGL2L5W5UTAAGQ4GJTH66EBA2
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
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/IDOSQCONGL2L5W5UTAAGQ4GJTH66EBA2/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

Thank you very much for your review. 
I would like to discuss something with you

On 04/09/2023 12:14, krzysztof.kozlowski@linaro.org wrote:
> On 04/09/2023 13:46, wangweidong.a@awinic.com wrote:
>> From: Weidong Wang <wangweidong.a@awinic.com>
>> 
>> Add a DT schema for describing awinic aw87390 audio amplifiers.
>> They are controlled using I2C.

> Thank you for your patch. There is something to discuss/improve.

>> +
>> +allOf:
>> +  - $ref: dai-common.yaml#
>> +
>> +properties:
>> +  compatible:
>> +    const: awinic,aw87390
>> +
>> +  reg:
>> +    maxItems: 1

> No reset-gpios? Shouldn't this be just merged with awinic,aw88395 bindings?

Yes, this chip does not have reset-gpios, and the i2c address of 
this chip is different from the aw88395 chip.So I didn't 
merge it with awinic, aw88395.

> Missing sound-dai-cells (const: 0 or 1)

Thank you very much. I'll add #sound-dai-cells

>> +
>> +required:
>> +  - compatible
>> +  - reg
>> +
>> +unevaluatedProperties: false
>> +
>> +examples:
>> +  - |
>> +    i2c {
>> +        #address-cells = <1>;
>> +        #size-cells = <0>;
>> +        audio-codec@58 {
>> +            compatible = "awinic,aw87390";
>> +            reg = <0x58>;

> Please add sound-dai-cells for the example to be complete.

Thank you very much, I will modify it in patch v2

Best regards,
Weidong Wang
