Return-Path: <SRS0=EqiG=CR=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1A0B1C433E2
	for <alsa-devel@archiver.kernel.org>; Tue,  8 Sep 2020 15:00:02 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A9B0B22C9E
	for <alsa-devel@archiver.kernel.org>; Tue,  8 Sep 2020 15:00:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="OQw5G2Xo";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=ti.com header.i=@ti.com header.b="u5cgThpU"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A9B0B22C9E
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=ti.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 11EA51788;
	Tue,  8 Sep 2020 16:59:09 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 11EA51788
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1599577199;
	bh=cwoxDQpdGVX0ANxIPNQoLEaU5vGtQ2qRoEe7iDEszXM=;
	h=Subject:From:To:References:Date:In-Reply-To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=OQw5G2XoMhvRjzbS4rF3UlsnRnlJ2XhDYiaFXl+t+0U2REzpbeJkSJvGnfxX6nerE
	 KBWRZ903kEAKYw7hdV5fh9ze5JPcci5SEU6oFgbAZNJmKbenn6/OoPmptcVFekSLC3
	 7Zf1BEo74N67AOQzRGvT6HjMYDAtURFr5NOjG6M8=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 52E76F801F2;
	Tue,  8 Sep 2020 16:59:08 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 73A64F80264; Tue,  8 Sep 2020 16:59:06 +0200 (CEST)
Received: from lelv0142.ext.ti.com (lelv0142.ext.ti.com [198.47.23.249])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 25F80F8015F
 for <alsa-devel@alsa-project.org>; Tue,  8 Sep 2020 16:58:59 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 25F80F8015F
Authentication-Results: alsa1.perex.cz;
 dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="u5cgThpU"
Received: from fllv0034.itg.ti.com ([10.64.40.246])
 by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id 088Ewtci011590;
 Tue, 8 Sep 2020 09:58:55 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1599577135;
 bh=fKarsEyMOJcKTwtf5n0tGq73QBl/jjsYYqxZnKWLtfU=;
 h=Subject:From:To:CC:References:Date:In-Reply-To;
 b=u5cgThpU3AlHzuETTDonZHqMfFUtNgZRBjQwQyWHhuJeOoNft0cOIeqIVbic0RiB7
 JvMJ80lOItnioC30vw/zZJU6VnY303X8j/ZkIqIZ0T2otDT/oYoekdZHQJC3wYPGEa
 UqbCO2fBUSWG8TEtgpZNpcBy843k6qnVy/gatlt8=
Received: from DFLE105.ent.ti.com (dfle105.ent.ti.com [10.64.6.26])
 by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 088EwtaO121227
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Tue, 8 Sep 2020 09:58:55 -0500
Received: from DFLE100.ent.ti.com (10.64.6.21) by DFLE105.ent.ti.com
 (10.64.6.26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3; Tue, 8 Sep
 2020 09:58:55 -0500
Received: from fllv0039.itg.ti.com (10.64.41.19) by DFLE100.ent.ti.com
 (10.64.6.21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3 via
 Frontend Transport; Tue, 8 Sep 2020 09:58:55 -0500
Received: from [10.250.38.37] (ileax41-snat.itg.ti.com [10.172.224.153])
 by fllv0039.itg.ti.com (8.15.2/8.15.2) with ESMTP id 088EwtuK053861;
 Tue, 8 Sep 2020 09:58:55 -0500
Subject: Re: [PATCH 2/2] ASoC: tlv320adcx140: Wake up codec before accessing
 register
From: Dan Murphy <dmurphy@ti.com>
To: Camel Guo <camel.guo@axis.com>, <lgirdwood@gmail.com>,
 <broonie@kernel.org>, <tiwai@suse.com>
References: <20200908083521.14105-1-camel.guo@axis.com>
 <20200908083521.14105-2-camel.guo@axis.com>
 <89f8cce0-2407-15f5-a8e5-0aa17a2eb2c4@ti.com>
Message-ID: <8160bf81-a72d-2db0-0767-79b0509ff143@ti.com>
Date: Tue, 8 Sep 2020 09:58:55 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <89f8cce0-2407-15f5-a8e5-0aa17a2eb2c4@ti.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Cc: alsa-devel@alsa-project.org, kernel@axis.com, linux-kernel@vger.kernel.org,
 Camel Guo <camelg@axis.com>
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

Camel

On 9/8/20 6:49 AM, Dan Murphy wrote:
> Camel
>
> On 9/8/20 3:35 AM, Camel Guo wrote:
>> From: Camel Guo <camelg@axis.com>
>>
>> According to its datasheet, after reset this codec goes into sleep
>> mode. In this mode, any register accessing should be avoided except for
>> exiting sleep mode. Hence this commit moves SLEEP_CFG access before any
>> register accessing.
>
> This is interesting because our HW team suggested putting the device 
> into sleep mode when doing register writes/reads because they were 
> finding abnormalities in the register settings when the device is active.
>
> I have a local patch that changes this as well that the HW team 
> requested.


OK I have clarification on this now.  Their original request was 
incorrect they indicate the BIAS, ADC and PLLs be powered down during 
writes and reads.


>
> Mark
>
> Let me run this by the HW team first before applying this patch.

Mark

Acked-by: Dan Murphy <dmurphy@ti.com>


>
> Dan
>
