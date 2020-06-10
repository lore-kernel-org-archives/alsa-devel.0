Return-Path: <SRS0=lC1U=7X=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E506AC433E0
	for <alsa-devel@archiver.kernel.org>; Wed, 10 Jun 2020 14:13:20 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6F4982067B
	for <alsa-devel@archiver.kernel.org>; Wed, 10 Jun 2020 14:13:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="asSm0CP+";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=ti.com header.i=@ti.com header.b="afvjACCP"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6F4982067B
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=ti.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id EA5C715E4;
	Wed, 10 Jun 2020 16:12:28 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz EA5C715E4
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1591798399;
	bh=qmlUysp1/OkI6KKe5YmubLDJoZTff3NkISzDcAEE8c4=;
	h=Subject:To:References:From:Date:In-Reply-To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=asSm0CP+HGUtcNo31M7oGD1EK4BAvx1ukBX4SwNTxbNIQLq+GEkIG23yDsTUdrwDB
	 6sCBVQq5qHgdwbpxu2tdOAU/auMwrsf7R9LyzfUcH/F22+KHlndL72440JUIs39tj3
	 n7Gq7o4SmVyTW0lDazyGHQdcmNLpzlx4Ql5Voe24=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 6E007F801F7;
	Wed, 10 Jun 2020 16:12:28 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id F152FF8021C; Wed, 10 Jun 2020 16:12:26 +0200 (CEST)
Received: from lelv0142.ext.ti.com (lelv0142.ext.ti.com [198.47.23.249])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 6B198F800E0
 for <alsa-devel@alsa-project.org>; Wed, 10 Jun 2020 16:12:22 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 6B198F800E0
Authentication-Results: alsa1.perex.cz;
 dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="afvjACCP"
Received: from fllv0035.itg.ti.com ([10.64.41.0])
 by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id 05AECJ3e108368;
 Wed, 10 Jun 2020 09:12:19 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1591798339;
 bh=M6xkOjg3ZDZEAeNUvfjnKS/Ad55tPzrwQaDSRurU5cc=;
 h=Subject:To:CC:References:From:Date:In-Reply-To;
 b=afvjACCPdnbDmVqRfX8f0zKOBmY9rg4cWCK7zArxo9riELGH3cHx9TJpHXVrJKdeQ
 GymgnaosAsYh0fy0IWJmFZgJT+0cqDima0Yo+2+egzOLa9KST9G2joFxyA6zb+stHG
 HVh729z6a4WQYzWzYNRAayMo722dVTEWYCXQoI4U=
Received: from DLEE111.ent.ti.com (dlee111.ent.ti.com [157.170.170.22])
 by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTP id 05AECJ16130904;
 Wed, 10 Jun 2020 09:12:19 -0500
Received: from DLEE106.ent.ti.com (157.170.170.36) by DLEE111.ent.ti.com
 (157.170.170.22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3; Wed, 10
 Jun 2020 09:12:19 -0500
Received: from fllv0039.itg.ti.com (10.64.41.19) by DLEE106.ent.ti.com
 (157.170.170.36) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3 via
 Frontend Transport; Wed, 10 Jun 2020 09:12:19 -0500
Received: from [10.250.65.13] (ileax41-snat.itg.ti.com [10.172.224.153])
 by fllv0039.itg.ti.com (8.15.2/8.15.2) with ESMTP id 05AECGkD054825;
 Wed, 10 Jun 2020 09:12:17 -0500
Subject: Re: [RFC PATCH 1/2] dt-bindings: tas2562: Add firmware support for
 tas2563
To: Mark Brown <broonie@kernel.org>
References: <20200609172841.22541-1-dmurphy@ti.com>
 <20200609172841.22541-2-dmurphy@ti.com> <20200609173143.GN4583@sirena.org.uk>
 <bb7cff87-f814-1b37-c9eb-e68919e3c077@ti.com>
 <20200609175852.GQ4583@sirena.org.uk>
 <414a2d73-6d09-1e76-59c8-4943c0e8f720@ti.com>
 <20200609184734.GS4583@sirena.org.uk>
 <014b85b5-677b-569a-4eb2-74526d3f00bc@ti.com>
 <20200610102920.GC5005@sirena.org.uk>
From: Dan Murphy <dmurphy@ti.com>
Message-ID: <84a6dd5f-cc3e-adb4-ae94-b4fe389adfd9@ti.com>
Date: Wed, 10 Jun 2020 09:12:15 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <20200610102920.GC5005@sirena.org.uk>
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

On 6/10/20 5:29 AM, Mark Brown wrote:
> On Tue, Jun 09, 2020 at 02:20:29PM -0500, Dan Murphy wrote:
>> On 6/9/20 1:47 PM, Mark Brown wrote:
>>> That's really not very idiomatic for how Linux does stuff and seems to
>>> pretty much guarantee issues with hotplugging controls and ordering -
>>> you'd need special userspace to start up even if it was just a really
>>> simple DSP config doing only speaker correction or something.  I'm not
>>> sure what the advantage would be - what problem is this solving over
>>> static names?
>> IMO having a static name is the problem. It is an inflexible design.
>> Besides the firmware-name property seems to be used in other drivers to
>> declare firmwares for the boards.
>> But if no one is complaining or submitting patches within the codecs to be
>> more flexible with firmware then I can just hard code the name like other
>> drivers do.
> I'm not *completely* opposed to having the ability to suggest a name in
> firmware, the big problem is making use of the DSP completely dependent
> on having a DT property or doing some non-standard dance in userspace.

Well from what I see we have 4 options.

1.  We can have a DT node like RFC'd (Need Rob's comments here)

2.  We can have a defconfig flag that hard codes the name (This will 
probably be met with some resistance if not some really bad reactions 
and I don't prefer to do it this way)

3.  We can hard code the name of the firmware in the c file.

4.  Dynamically derive a file name based on the I2C bus-address-device 
so it would be expected to be "2_4c_tas2563.bin".  Just need to figure 
out how to get the bus number.

I don't see the user space as a viable option because the codec will 
have to load and then the user space would have to request to load the 
firmware and then more mixer controls will appear.

Again only option 1 allows us to have different firmware binaries per IC 
instance and also denotes the use of the DSP.  The DSP is not programmed 
until the user space selects the program or configuration from the 
binary.  So special audio handling is very explicit in the user space.  
More then likely most standard distributions will not even use the DSP 
for this device it is more of a specialized use case for each product.



