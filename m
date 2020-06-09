Return-Path: <SRS0=1fsy=7W=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 52DECC433E0
	for <alsa-devel@archiver.kernel.org>; Tue,  9 Jun 2020 17:36:50 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EB12C20774
	for <alsa-devel@archiver.kernel.org>; Tue,  9 Jun 2020 17:36:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="PZweqnkV";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=ti.com header.i=@ti.com header.b="WD1/Wl8I"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EB12C20774
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=ti.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 8E9D11660;
	Tue,  9 Jun 2020 19:35:57 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 8E9D11660
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1591724207;
	bh=738JUeJp+hT13YJEiEzIyJiW7MuosL7D0mqFZbnPdG0=;
	h=Subject:To:References:From:Date:In-Reply-To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=PZweqnkVnaYjUJ6gju/fTHCMeYTU380OJRXElh3PHClxV+c4t7qGP6MzDUtlLFFJm
	 AYgjDCbz1tpfb3E/wwTFliMBwoJs7Mn61qaEtE261Y4J7+zGFZAnSmBnVDnZXnxL1T
	 BrLHGWIHeRlrnCR7QTt/wGGULAy7SgXunOk6SUfs=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id F30F8F80278;
	Tue,  9 Jun 2020 19:35:56 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 9BACFF8028C; Tue,  9 Jun 2020 19:35:55 +0200 (CEST)
Received: from lelv0142.ext.ti.com (lelv0142.ext.ti.com [198.47.23.249])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id A92DEF80124
 for <alsa-devel@alsa-project.org>; Tue,  9 Jun 2020 19:35:52 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz A92DEF80124
Authentication-Results: alsa1.perex.cz;
 dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="WD1/Wl8I"
Received: from lelv0265.itg.ti.com ([10.180.67.224])
 by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id 059HZot6046157;
 Tue, 9 Jun 2020 12:35:50 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1591724150;
 bh=ulNJut/tfEzVpGlFxRW9r3khnz5f2N4uIk9e8tk29mw=;
 h=Subject:To:CC:References:From:Date:In-Reply-To;
 b=WD1/Wl8ITIn7CjclZy8e17qbQLxWjWCaCvCqb65B93zj5us74qrqpR8T1MnTxMYlY
 5v0sKw9NGKDOVQ0MTB6pQKAnYkoDUV7U5nNvb3gy+f6wFygEErcdbDyCfIGRlRUC4n
 i98wZPpburooNob5kL+A/PK4RpcG6WiFOhCnKaoc=
Received: from DFLE113.ent.ti.com (dfle113.ent.ti.com [10.64.6.34])
 by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 059HZom8051593
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Tue, 9 Jun 2020 12:35:50 -0500
Received: from DFLE112.ent.ti.com (10.64.6.33) by DFLE113.ent.ti.com
 (10.64.6.34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3; Tue, 9 Jun
 2020 12:35:50 -0500
Received: from fllv0040.itg.ti.com (10.64.41.20) by DFLE112.ent.ti.com
 (10.64.6.33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3 via
 Frontend Transport; Tue, 9 Jun 2020 12:35:50 -0500
Received: from [10.250.65.13] (ileax41-snat.itg.ti.com [10.172.224.153])
 by fllv0040.itg.ti.com (8.15.2/8.15.2) with ESMTP id 059HZo2k032887;
 Tue, 9 Jun 2020 12:35:50 -0500
Subject: Re: [RFC PATCH 1/2] dt-bindings: tas2562: Add firmware support for
 tas2563
To: Mark Brown <broonie@kernel.org>
References: <20200609172841.22541-1-dmurphy@ti.com>
 <20200609172841.22541-2-dmurphy@ti.com> <20200609173143.GN4583@sirena.org.uk>
From: Dan Murphy <dmurphy@ti.com>
Message-ID: <bb7cff87-f814-1b37-c9eb-e68919e3c077@ti.com>
Date: Tue, 9 Jun 2020 12:35:50 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <20200609173143.GN4583@sirena.org.uk>
Content-Type: text/plain; charset="windows-1252"; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Cc: robh@kernel.org, alsa-devel@alsa-project.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, tiwai@suse.com, lgirdwood@gmail.com
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

On 6/9/20 12:31 PM, Mark Brown wrote:
> On Tue, Jun 09, 2020 at 12:28:40PM -0500, Dan Murphy wrote:
>> Add a property called firmware-name that will be the name of the
>> firmware that will reside in the file system or built into the kernel.
> Why not just use a standard name for the firmware?  If the firmwares
> vary per-board then building it using the machine compatible (or DMI
> info) could handle that, with a fallback to a standard name for a
> default setup.

The number of firmwares can vary per IC on the board itself.  So you may 
have X number of firmware files all with different names all targets for 
different TAS2563 ICs.

Also TI will not be providing the individual binaries to the customer.  
There is a customer tool that the user uses to create the binaries.

So the output names are arbitrary.

I was going to mention this in the cover letter but did not think 
mentioning the user tool had any value

Dan

