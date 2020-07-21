Return-Path: <SRS0=ClfJ=BA=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 63220C433E4
	for <alsa-devel@archiver.kernel.org>; Tue, 21 Jul 2020 12:18:00 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E5A2221702
	for <alsa-devel@archiver.kernel.org>; Tue, 21 Jul 2020 12:17:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="bqBo+jEB";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=ti.com header.i=@ti.com header.b="pAoMEIdw"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E5A2221702
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=ti.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 507DC1614;
	Tue, 21 Jul 2020 14:17:08 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 507DC1614
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1595333878;
	bh=BRkp6FODU0qnPve2anCuTkEriRXZ3rtgXs0XnUhpOyQ=;
	h=Subject:To:References:From:Date:In-Reply-To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=bqBo+jEBxOv0NCtfM50h/1nRCrZzxnSpx5aQ0x4H8PzUwQOpXluvrDIXN6MKqNa8S
	 PG93gY7FNzq2GRtr4pnaTlEU+rt5aq8fOprNA09bS4TfuEmgwL57bElOJo+90i4F+R
	 LIb/XB1fGk1GzFGptTGjmXdjaKGySdW6hkfJTxlY=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id DBC88F80212;
	Tue, 21 Jul 2020 14:17:07 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id A225CF8024A; Tue, 21 Jul 2020 14:17:05 +0200 (CEST)
Received: from fllv0015.ext.ti.com (fllv0015.ext.ti.com [198.47.19.141])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 01C2FF800CE
 for <alsa-devel@alsa-project.org>; Tue, 21 Jul 2020 14:16:57 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 01C2FF800CE
Authentication-Results: alsa1.perex.cz;
 dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="pAoMEIdw"
Received: from fllv0035.itg.ti.com ([10.64.41.0])
 by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 06LCGtFC067912;
 Tue, 21 Jul 2020 07:16:55 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1595333815;
 bh=gFm3GQJD6iGfxn3i2RyDU92dAWg7cMKkvcOz7EYvjjE=;
 h=Subject:To:CC:References:From:Date:In-Reply-To;
 b=pAoMEIdw6mPN7Ym2CU2zbGryEo4eeD7nkTnb8KZSUlf3NNF5SJkm0uo3CHjIlVHet
 UMOcbNCsyYGMXWRAwdP3WHV+Ij0eKn5KFK/1utcElgu7dY/cqoI83u/Hh2xhzFYWol
 17pok/O6sxhIffgU1E/pzBalGXqulTVMYQoe6hA4=
Received: from DFLE108.ent.ti.com (dfle108.ent.ti.com [10.64.6.29])
 by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTP id 06LCGts4043901;
 Tue, 21 Jul 2020 07:16:55 -0500
Received: from DFLE113.ent.ti.com (10.64.6.34) by DFLE108.ent.ti.com
 (10.64.6.29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3; Tue, 21
 Jul 2020 07:16:55 -0500
Received: from fllv0039.itg.ti.com (10.64.41.19) by DFLE113.ent.ti.com
 (10.64.6.34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3 via
 Frontend Transport; Tue, 21 Jul 2020 07:16:55 -0500
Received: from [10.250.32.229] (ileax41-snat.itg.ti.com [10.172.224.153])
 by fllv0039.itg.ti.com (8.15.2/8.15.2) with ESMTP id 06LCGsZE096585;
 Tue, 21 Jul 2020 07:16:54 -0500
Subject: Re: [PATCH v3 1/2] dt-bindings: tas2770: Convert tas2770 binding to
 yaml
To: Mark Brown <broonie@kernel.org>
References: <20200720181202.31000-1-dmurphy@ti.com>
 <20200721093358.GA4845@sirena.org.uk>
From: Dan Murphy <dmurphy@ti.com>
Message-ID: <6cf0b470-f064-7d25-0509-252d6f845d62@ti.com>
Date: Tue, 21 Jul 2020 07:16:54 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200721093358.GA4845@sirena.org.uk>
Content-Type: text/plain; charset="windows-1252"; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Cc: devicetree@vger.kernel.org, alsa-devel@alsa-project.org,
 Rob Herring <robh@kernel.org>, linux-kernel@vger.kernel.org, tiwai@suse.com,
 lgirdwood@gmail.com
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

Mark

On 7/21/20 4:33 AM, Mark Brown wrote:
> On Mon, Jul 20, 2020 at 01:12:01PM -0500, Dan Murphy wrote:
>> Convert the tas2770 binding to yaml format.
>> Add in the reset-gpio to the binding as it is in the code but not
>> documented in the binding.
> What's new about this version?

The licensing was updated and added reviewed-by from Rob from v1 of the 
patchset.

https://lore.kernel.org/patchwork/patch/1255425/

