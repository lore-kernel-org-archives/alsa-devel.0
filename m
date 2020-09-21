Return-Path: <SRS0=AR4N=C6=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 81588C4346E
	for <alsa-devel@archiver.kernel.org>; Mon, 21 Sep 2020 19:19:59 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B3E0F2193E
	for <alsa-devel@archiver.kernel.org>; Mon, 21 Sep 2020 19:19:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="R0NEeBwA";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=ti.com header.i=@ti.com header.b="dDMKxawe"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B3E0F2193E
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=ti.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 117D316C1;
	Mon, 21 Sep 2020 21:19:07 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 117D316C1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1600715997;
	bh=3JLQr4yIOmtSnIfAVmHfB7/og/tZONaQr/y+hFnXacg=;
	h=Subject:To:References:From:Date:In-Reply-To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=R0NEeBwAv3CYvEyExDgbxAVhAJC/ZW4kFvGd4ky6eao+Xy0DFEFSJcx2G/+kW3eF6
	 eRcten58TE+QwyoL9Eg5rZav+tUSwlAapx3Z9sPTQINfQyAHsuVzz6CgxydocCEOvs
	 zCDdS1ME0ah4q1xPGAOUzvzZ6k2T/jH7e9uQsso4=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 4EFC1F80161;
	Mon, 21 Sep 2020 21:19:06 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id E82A9F80162; Mon, 21 Sep 2020 21:19:04 +0200 (CEST)
Received: from lelv0143.ext.ti.com (lelv0143.ext.ti.com [198.47.23.248])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 2A028F800B2
 for <alsa-devel@alsa-project.org>; Mon, 21 Sep 2020 21:18:56 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 2A028F800B2
Authentication-Results: alsa1.perex.cz;
 dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="dDMKxawe"
Received: from fllv0035.itg.ti.com ([10.64.41.0])
 by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id 08LJIrMh014804;
 Mon, 21 Sep 2020 14:18:53 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1600715933;
 bh=n6AcmAnZQPAOcrHBCbDDHL+97WDS2HL4O3BZYyKbAQ4=;
 h=Subject:To:CC:References:From:Date:In-Reply-To;
 b=dDMKxawedHj+J//4dkP1vrW4eEkNGEbPocQpxb24SkUsqm8PFBC9S6tjyugqYFTGZ
 jTNHpoIeU9zF5Q9ArOlsI4PJMXtM+kSd3pMSrDk/fQDYn3Ib518Tq9og9wsKouMgyo
 M91PondY8rkBhP7H6SiAyxoIrb3EpasO5UcxdDkk=
Received: from DFLE112.ent.ti.com (dfle112.ent.ti.com [10.64.6.33])
 by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTP id 08LJIrfm047334;
 Mon, 21 Sep 2020 14:18:53 -0500
Received: from DFLE110.ent.ti.com (10.64.6.31) by DFLE112.ent.ti.com
 (10.64.6.33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3; Mon, 21
 Sep 2020 14:18:52 -0500
Received: from lelv0327.itg.ti.com (10.180.67.183) by DFLE110.ent.ti.com
 (10.64.6.31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3 via
 Frontend Transport; Mon, 21 Sep 2020 14:18:53 -0500
Received: from [10.250.35.164] (ileax41-snat.itg.ti.com [10.172.224.153])
 by lelv0327.itg.ti.com (8.15.2/8.15.2) with ESMTP id 08LJIqpb084280;
 Mon, 21 Sep 2020 14:18:52 -0500
Subject: Re: [PATCH 6/9] ASoC: tas2770: Convert bit mask to GENMASK in header
To: Mark Brown <broonie@kernel.org>
References: <20200918190548.12598-1-dmurphy@ti.com>
 <20200918190548.12598-6-dmurphy@ti.com> <20200921190437.GJ4792@sirena.org.uk>
From: Dan Murphy <dmurphy@ti.com>
Message-ID: <bea218c8-c71d-2ce8-da92-14af73ac4da5@ti.com>
Date: Mon, 21 Sep 2020 14:18:52 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200921190437.GJ4792@sirena.org.uk>
Content-Type: text/plain; charset="windows-1252"; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Cc: devicetree@vger.kernel.org, alsa-devel@alsa-project.org, tiwai@suse.com,
 lgirdwood@gmail.com, linux-kernel@vger.kernel.org, robh+dt@kernel.org
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

On 9/21/20 2:04 PM, Mark Brown wrote:
> On Fri, Sep 18, 2020 at 02:05:45PM -0500, Dan Murphy wrote:
>> Update the hardcoded masks with the GENMASK macro. Also update some of
>> the hardcoded bits with the BIT macro
> Cleanups like this should come after any fixes in the series, that way
> fixes can be sent as fixes if needed which isn't appropriate for random
> cleanups.

OK I can re-order so the clean up comes at the end.  During the clean up 
I found patch 7-9.

Dan

