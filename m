Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 04934CD8CB2
	for <alsa-devel@archiver.kernel.org>; Wed, 10 Jun 2026 07:59:46 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [45.14.194.44])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 24C7A60214;
	Wed, 10 Jun 2026 09:59:31 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 24C7A60214
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1781078381;
	bh=PDGr1qjNRsFIh5qLZXtdJHYogX0XJjRXo3AfQCNPcNk=;
	h=From:To:Cc:Subject:Date:List-Id:List-Archive:List-Help:List-Owner:
	 List-Post:List-Subscribe:List-Unsubscribe:From;
	b=BWCBTs8mZGOz1o9NNIbcooG1YtdPdwR0RJeWMrr/hvpQYHdynJrpjLIQfFoJXcmlg
	 5OQaywYBWDRZm6LlEvJxjyQSGZAOZjyBJf44ve9TCMxzOCfDfj0NidTHv01J9sywCx
	 8f3oHGwFPaanbQeVtyWRYHTe0AmHmTK9hqgZZNHM=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 655DCF8064C; Wed, 10 Jun 2026 09:58:41 +0200 (CEST)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id A7A2DF80637;
	Wed, 10 Jun 2026 09:58:41 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id E0F6AF80496; Tue,  9 Jun 2026 13:46:18 +0200 (CEST)
Authentication-Results: alsa1.perex.cz; arc=none smtp.remote-ip=202.108.3.55
ARC-Seal: i=1; d=alsa-project.org; s=arc; a=rsa-sha256; cv=none; t=1781005574;
	b=oui1q47++jAqxR/n6P39hpwhjOzZChp8rxff+pVRPzxssP5pXS7I6qcPpNfe78BZzWn8
	 OiHh6uUPty7Y2LwChkkdKz6a0ro/EGXDiPUKt6CGCcD3RAKsq2JZ+5tTBnZShVOADtXjR
	 LIHL3Wrv06igEGh32iiiPJ/ki/cu4Ckq67bsGuKWqhQZ/ox1V2ECy8Ul+AMFajZj14PJ5
	 h+g04XZimn/NHLvMpGUqzdOIAPbRH5wfu00bJabS+DStoTThkCI4HKWBD+a6tqT1McBg5
	 vq6GwScAR/wC88RPGJI4JQ/RgPB+hpr+eP5eTUlb4/4beGcfEk6mrwgaCcyOWMn2wVA==
ARC-Message-Signature: i=1; d=alsa-project.org; s=arc; a=rsa-sha256;
	c=relaxed/simple; t=1781005574;
	h=From:To:Subject:Date:Message-ID:MIME-Version;
	bh=5QFaW1o+YTLNWPAdkZ06Ve5AYrRlloTveULfn/zqyj0=;
	b=q7xb9cSzyu9YKTjfKGak0fJCpSnyKpavE9QBMlFJMBDaZWM5XCJq+C1BqQ41pM3hIeIH
	 K9/PZ1wuDOfXtSS5w7/6ZriFT3uDv6E+QkztCNqowmO/6X8LDAxipK+INCztqKqyG/A7c
	 7uy6zaZWxduEBiT/Qg+ufWux+ZIchvOmS6S/IL2vSHr+274Vkvda3fDuwKJqwywg2x6il
	 mqQC7FvjhYxzhtGw6ttlk1TpwrSrMYbHIPeR+7rCkpFH0M/NIEHb1uVU2WvvCGB03NLLo
	 cOzBX4Lvd5op4/zNsRXhhzWvvHkJkxQ6QV8S9D9ceiJyTF/SFjNZxavfhtfLvY7tSvg==
ARC-Authentication-Results: i=1; alsa1.perex.cz;
 arc=none smtp.remote-ip=202.108.3.55
Received: from r3-55.sinamail.sina.com.cn (r3-55.sinamail.sina.com.cn
 [202.108.3.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by alsa1.perex.cz (Postfix) with ESMTPS id E2E0DF801F5
	for <alsa-devel@alsa-project.org>; Tue,  9 Jun 2026 13:46:11 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz E2E0DF801F5
Received: from unknown (HELO DESKTOPQJC4P40)([58.38.107.94])
	by sina.net (10.54.253.38) with ESMTP
	id 6A27FCFD00002724; Tue, 9 Jun 2026 19:46:05 +0800 (CST)
X-Sender: zhangyi@everest-semi.com
X-Auth-ID: zhangyi@everest-semi.com
Authentication-Results: sina.net;
	 spf=none smtp.mailfrom=zhangyi@everest-semi.com;
	 dkim=none header.i=none;
	 dmarc=none action=none header.from=zhangyi@everest-semi.com
X-SMAIL-MID: 9629FCA8D19C40AFB99DDBD823C89582
X-SMAIL-UIID: 9629FCA8D19C40AFB99DDBD823C89582-20260609-194605
From: <zhangyi@everest-semi.com>
To: <krzk@kernel.org>
Cc: <alsa-devel@alsa-project.org>,
	<broonie@kernel.org>,
	<conor+dt@kernel.org>,
	<devicetree@vger.kernel.org>,
	<krzk+dt@kernel.org>,
	<robh@kernel.org>,
	<tiwai@suse.com>,
	<zhangyi@everest-semi.com>
Subject: Re: [PATCH 7/7] ASoC: dt-bindings: ES8389: Add members about HPF and
 clock
Date: Tue, 9 Jun 2026 19:46:05 +0800
Message-ID: <05a401dcf805$8ecda900$ac68fb00$@everest-semi.com>
MIME-Version: 1.0
X-Mailer: Microsoft Outlook 16.0
Content-Language: zh-cn
Thread-Index: Adz4BVwuQPcFlI2RSb2cq/YdaN8dBQ==
X-MailFrom: zhangyi@everest-semi.com
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; loop;
 banned-address; header-match-alsa-devel.alsa-project.org-0;
 header-match-alsa-devel.alsa-project.org-1; emergency; member-moderation
Message-ID-Hash: RGX3NADSVM6OHAM4OFHH22UKM255O5A5
X-Message-ID-Hash: RGX3NADSVM6OHAM4OFHH22UKM255O5A5
X-Mailman-Approved-At: Wed, 10 Jun 2026 07:58:36 +0000
Content-Transfer-Encoding: 7bit
Content-Type: text/plain;
	charset="US-ASCII"
X-Content-Filtered-By: Mailman/MimeDel 3.3.10
X-Mailman-Version: 3.3.10
Precedence: list
List-Id: "Alsa-devel mailing list for ALSA developers -
 http://www.alsa-project.org" <alsa-devel.alsa-project.org>
Archived-At: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/RGX3NADSVM6OHAM4OFHH22UKM255O5A5/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

> Please organize the patch documenting the ABI (DT bindings)

> before the patch using that ABI.

> See also:
https://elixir.bootlin.com/linux/v6.14-rc6/source/Documentation/devicetree/b
indings/submitting-patches.rst#L46

 

Thanks for the reminder

 

> > +  everest,mclk-from-sclk:

> > +    $ref: /schemas/types.yaml#/definitions/flag

> > +    description:

> > +      Indicates that SCLK is used as the internal clock.

> 

> And what happens with mclk in such case? Is it still wired?

 

Yes, setting mclk-from-sclk does not affect the MCLK connection.

 

> > +

> > +  everest,hpfl:

> > +    $ref: /schemas/types.yaml#/definitions/uint8

> > +    description:

> > +      the HPF value of ADCL.

> 

> Is HPF value in dB? If so, use proper unit suffix and proper units.

 

No, the values here correspond to the values in the registers.

The value is not in dB

 

> >          vddd-supply = <&vdd3v3>;

> >          vdda-supply = <&vdd3v3>;

> > +        everest,hpfl = [0a];

> 

> <0xa>? What did you want to say here?

 

I just wanted to give an example to show how to set the values of
everest,hpfl to 0x0a.

 

