Return-Path: <SRS0=8DMN=4I=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AE066C11D0C
	for <alsa-devel@archiver.kernel.org>; Thu, 20 Feb 2020 19:28:57 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3DED4222C4
	for <alsa-devel@archiver.kernel.org>; Thu, 20 Feb 2020 19:28:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="kBuV3DkM";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=ti.com header.i=@ti.com header.b="LAPmdFJ/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3DED4222C4
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=ti.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 5798616A3;
	Thu, 20 Feb 2020 20:28:05 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 5798616A3
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1582226935;
	bh=nK+ZSH6LRcjW5ZP2lQGzIOfPAhmE+VxGDyH4h1W9vFM=;
	h=Subject:To:References:From:Date:In-Reply-To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=kBuV3DkMJ2NgyYt+2HMD9lOHZXomqpEa4MjsqF62JQ1Z8RR97LY6AkVUuJ1wveP3O
	 x2BB3boODAnxwKhcC0sBDOZNe6Z+V9sne4afUd/S8CazM8L0HeI07vD5iAUNVvXnnV
	 HhLvQMFR/s1yTI9eFf/+AO8r5HVwgtUv+UvpXIE0=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 232A2F80145;
	Thu, 20 Feb 2020 20:28:03 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 2803CF80148; Thu, 20 Feb 2020 20:28:01 +0100 (CET)
Received: from fllv0015.ext.ti.com (fllv0015.ext.ti.com [198.47.19.141])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 9519CF8011D
 for <alsa-devel@alsa-project.org>; Thu, 20 Feb 2020 20:27:56 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 9519CF8011D
Authentication-Results: alsa1.perex.cz;
 dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="LAPmdFJ/"
Received: from fllv0035.itg.ti.com ([10.64.41.0])
 by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 01KJRs19059352;
 Thu, 20 Feb 2020 13:27:54 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1582226874;
 bh=bQZBs4R8I7SS5K4xnJzvOySpsb0IN5aljouYPVfbqJE=;
 h=Subject:To:CC:References:From:Date:In-Reply-To;
 b=LAPmdFJ/We64GPO2f7Rw7VcZ6mNHuZ8mOvNP8+YMK6vVjiz4Lfz1fHEY5hY3YoZC6
 Gn3VDyX0J1d8jdHfhwBQh2U2ey+p55+j9TsGwLa8MZ7+V8rggIlD/qyQWZ1ym9Rpen
 z+pM99r/DaxeHvY12codHvrgMvR0gDlCIgSTq6Bc=
Received: from DLEE100.ent.ti.com (dlee100.ent.ti.com [157.170.170.30])
 by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTP id 01KJRsfB000862;
 Thu, 20 Feb 2020 13:27:54 -0600
Received: from DLEE105.ent.ti.com (157.170.170.35) by DLEE100.ent.ti.com
 (157.170.170.30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1847.3; Thu, 20
 Feb 2020 13:27:54 -0600
Received: from fllv0040.itg.ti.com (10.64.41.20) by DLEE105.ent.ti.com
 (157.170.170.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1847.3 via
 Frontend Transport; Thu, 20 Feb 2020 13:27:54 -0600
Received: from [128.247.59.107] (ileax41-snat.itg.ti.com [10.172.224.153])
 by fllv0040.itg.ti.com (8.15.2/8.15.2) with ESMTP id 01KJRdtc041257;
 Thu, 20 Feb 2020 13:27:39 -0600
Subject: Re: [PATCH] ASoC: tas2562: Add support for digital volume control
To: Mark Brown <broonie@kernel.org>
References: <20200220172721.10547-1-dmurphy@ti.com>
 <20200220184507.GF3926@sirena.org.uk>
 <de0e8a5b-8c2a-ee04-856f-f0d678a3c66b@ti.com>
 <20200220191803.GH3926@sirena.org.uk>
From: Dan Murphy <dmurphy@ti.com>
Message-ID: <6f3ff810-5e75-cb33-10d6-198a7c5cd202@ti.com>
Date: Thu, 20 Feb 2020 13:22:34 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <20200220191803.GH3926@sirena.org.uk>
Content-Type: text/plain; charset="windows-1252"; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Cc: linux-kernel@vger.kernel.org, alsa-devel@alsa-project.org, tiwai@suse.com,
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

On 2/20/20 1:18 PM, Mark Brown wrote:
> On Thu, Feb 20, 2020 at 12:46:57PM -0600, Dan Murphy wrote:
>> On 2/20/20 12:45 PM, Mark Brown wrote:
>>> Is there a reason not to use the chip default here?  Otherwise this
>>> looks good.
>> Chip default is set to 0dB full blast+ 0x40400000.  This sets the volume to
>> -110dB.
> OK...  that's a policy decision the same as all other volume changes and
> so shouldn't be done by the driver - as ever we don't know how the
> system is set up and what values make sense and keeping things out of
> the driver means we don't end up with competing system integration
> decisions causing changes in the driver.  The system may have an
> external amplifier they prefer to use for hardware volume control, may
> prefer to do entirely soft volume control in their sound server or
> something like that.

But this is an amplifier.  Not sure why the system designer would design 
cascading amplifiers.

And if that was the case wouldn't you want the output to be low so you 
don't overdrive the ext amplifier front end?

I mean I have no qualms with removing the init from the driver. I will 
send v3 tomorrow after a 24 hour review cycle.

I was considering safety in that the device is on at full blast (not 
sure why the HW is defaulted that way but it is).

But if volume is adjusted prior to playback then this is not an issue.  
But if volume is not adjusted then it plays full blast.

Dan

