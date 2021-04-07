Return-Path: <SRS0=4JIF=JE=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 89E21C433ED
	for <alsa-devel@archiver.kernel.org>; Wed,  7 Apr 2021 05:45:19 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AD3B261260
	for <alsa-devel@archiver.kernel.org>; Wed,  7 Apr 2021 05:45:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AD3B261260
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=aksignal.cz
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 967C6166B;
	Wed,  7 Apr 2021 07:44:25 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 967C6166B
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1617774315;
	bh=n1drV1BqtqadnhhaA7cB1jAgEEO4ZyeNVeJnxO3Z7lw=;
	h=Subject:To:References:From:Date:In-Reply-To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=hy8le4UvmBY/dl3BZHPpf7J0PlXyYObXT4/ZDtNtc11dLaym6Ol9JehzgrGZplgH+
	 66lcImMCw+9f+KTH1pjF6deulZenjhCZ05oyenzFMmNxSROTtN7SvCZATVAm4W16j+
	 W2FYAObmE68b4lhJMmenVcH+dxpYnuV7bTUlwMo4=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id C3584F80168;
	Wed,  7 Apr 2021 07:44:24 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id ECFF8F8016A; Wed,  7 Apr 2021 07:44:22 +0200 (CEST)
Received: from router.aksignal.cz (router.aksignal.cz [62.44.4.214])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 86A87F80162
 for <alsa-devel@alsa-project.org>; Wed,  7 Apr 2021 07:44:13 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 86A87F80162
Received: from localhost (localhost [127.0.0.1])
 by router.aksignal.cz (Postfix) with ESMTP id 2E7C03FA51;
 Wed,  7 Apr 2021 07:44:12 +0200 (CEST)
X-Virus-Scanned: Debian amavisd-new at router.aksignal.cz
Received: from router.aksignal.cz ([127.0.0.1])
 by localhost (router.aksignal.cz [127.0.0.1]) (amavisd-new, port 10026)
 with LMTP id QpbZcTgWFh_K; Wed,  7 Apr 2021 07:44:11 +0200 (CEST)
Received: from [172.25.161.36] (unknown [83.240.30.185])
 (Authenticated sender: jiri.prchal@aksignal.cz)
 by router.aksignal.cz (Postfix) with ESMTPSA id 549EF3FA50;
 Wed,  7 Apr 2021 07:44:11 +0200 (CEST)
Subject: Re: [PATCH 4/4] ASoC: codecs: tlv320aic3x: add SPI support
To: Mark Brown <broonie@kernel.org>
References: <20210406142439.102396-1-jiri.prchal@aksignal.cz>
 <20210406142439.102396-5-jiri.prchal@aksignal.cz>
 <20210406165440.GN6443@sirena.org.uk>
From: =?UTF-8?B?SmnFmcOtIFByY2hhbA==?= <jiri.prchal@aksignal.cz>
Message-ID: <afb3d94a-ad3b-369d-e370-1fc82232e11c@aksignal.cz>
Date: Wed, 7 Apr 2021 07:44:11 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.1
MIME-Version: 1.0
In-Reply-To: <20210406165440.GN6443@sirena.org.uk>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Cc: alsa-devel@alsa-project.org, Takashi Iwai <tiwai@suse.com>,
 Liam Girdwood <lgirdwood@gmail.com>
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



On 06. 04. 21 18:54, Mark Brown wrote:
> On Tue, Apr 06, 2021 at 04:24:39PM +0200, Jiri Prchal wrote:
>> Added SPI support.
>>
>> Signed-off-by: Jiri Prchal <jiri.prchal@aksignal.cz>
>> ---
>>   sound/soc/codecs/Kconfig           |  7 +++
>>   sound/soc/codecs/Makefile          |  2 +
>>   sound/soc/codecs/tlv320aic3x-spi.c | 76 ++++++++++++++++++++++++++++++
>>   3 files changed, 85 insertions(+)
>>   create mode 100644 sound/soc/codecs/tlv320aic3x-spi.c
> 
> This looks good but we should also add an update to the DT binding which
> notes that SPI is also supported, right now reg is documented as being
> at an I2C address.
> 
Mark, please, will you navigate me where DT binding is.
I just added this to my board dts and that's all:
	spi0: spi@f0000000 {
	...
		// audio codec
		tlv320aic3106: codec@3 {
			compatible = "ti,tlv320aic3106";
			reg = <3>;
			#sound-dai-cells = <0>;
			spi-max-frequency = <1000000>;
			status = "okay";
			DRVDD-supply = <&reg_3v3>;
			AVDD-supply = <&reg_3v3>;
			IOVDD-supply = <&reg_3v3>;
			DVDD-supply = <&reg_1v8>;
			ai3x-ocmv = <0>;
		};
