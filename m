Return-Path: <SRS0=1fsy=7W=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0E266C433DF
	for <alsa-devel@archiver.kernel.org>; Tue,  9 Jun 2020 08:54:32 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 89BC4206D5
	for <alsa-devel@archiver.kernel.org>; Tue,  9 Jun 2020 08:54:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="KWfRkQok";
	dkim=pass (1024-bit key) header.d=perex.cz header.i=@perex.cz header.b="cP+EBLT7"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 89BC4206D5
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=perex.cz
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 2193D16A1;
	Tue,  9 Jun 2020 10:53:40 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 2193D16A1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1591692870;
	bh=G0Z36vJm6MKi79MJpWjyMFUont+71H1+otKr9THsnoU=;
	h=Subject:To:References:From:Date:In-Reply-To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=KWfRkQokvqCmACA5RqXteB88z0DbB++TDExTNvGrix7lxiCFUWkhB3mSv1WOwbsRb
	 UmPVflxBp8lpfkilGeNhXO6i88OsMmCI4ABWv0P5gCMg6nUyHD5Hhvts8QDcYdYIRy
	 hxSGgLcFRqyDllhfO2+8hjDfh2+/fcpVKUWNXPOI=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 06078F802E8;
	Tue,  9 Jun 2020 10:51:07 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id A33E2F80299; Tue,  9 Jun 2020 10:51:05 +0200 (CEST)
Received: from mail1.perex.cz (mail1.perex.cz [77.48.224.245])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 926C3F80299
 for <alsa-devel@alsa-project.org>; Tue,  9 Jun 2020 10:50:59 +0200 (CEST)
Received: from mail1.perex.cz (localhost [127.0.0.1])
 by smtp1.perex.cz (Perex's E-mail Delivery System) with ESMTP id 3AD12A0047;
 Tue,  9 Jun 2020 10:50:59 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.perex.cz 3AD12A0047
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=perex.cz; s=default;
 t=1591692659; bh=Z/q6twbTFhYqrjS0mKlasZyOvjLBdt1bqCLTXH7n1Aw=;
 h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
 b=cP+EBLT7o4Sab9MC95xHTVWNheDgsXmV1y6r1xYj411Jxg7vVws4iXrxxik6bFta9
 w2PzqSuZtjXRA1eUSxUN2tHWQI0RW6TO5nwUhcbxug46PsQrFAabrc/3X0xu0Jw3Wq
 Z3pwfv3MKMrdgMllWen0s+p0QOw4IsVszllcmATQ=
Received: from p50.perex-int.cz (unknown [192.168.100.94])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested) (Authenticated sender: perex)
 by mail1.perex.cz (Perex's E-mail Delivery System) with ESMTPSA;
 Tue,  9 Jun 2020 10:50:57 +0200 (CEST)
Subject: Re: [PATCH 2/3] bytcr-rt5651: Fix high noise level + soft input on
 DMIC
To: Hans de Goede <hdegoede@redhat.com>
References: <20200608202142.92894-1-hdegoede@redhat.com>
 <20200608202142.92894-2-hdegoede@redhat.com>
From: Jaroslav Kysela <perex@perex.cz>
Message-ID: <da4d9fb5-c8be-526d-5c51-8c2f39eec381@perex.cz>
Date: Tue, 9 Jun 2020 10:50:57 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <20200608202142.92894-2-hdegoede@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Cc: alsa-devel@alsa-project.org
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

Dne 08. 06. 20 v 22:21 Hans de Goede napsal(a):
> The DMIC needs to have the DMIC ASRC enabled, otherwise capturing audio
> from it results in mostly capturing noise + the actual recorded voice
> very soft in the background of the noise.
> 
> This has been tested on a Point of View P1006W v1.0 tablet, which is the
> only RT5651 X86 device using a DMIC that I am aware of.
> 
> Signed-off-by: Hans de Goede <hdegoede@redhat.com>
> ---
>   ucm2/codecs/rt5651/DigitalMic.conf | 2 ++
>   1 file changed, 2 insertions(+)
> 
> diff --git a/ucm2/codecs/rt5651/DigitalMic.conf b/ucm2/codecs/rt5651/DigitalMic.conf
> index aa40c1c..d21b21d 100644
> --- a/ucm2/codecs/rt5651/DigitalMic.conf
> +++ b/ucm2/codecs/rt5651/DigitalMic.conf
> @@ -4,12 +4,14 @@ SectionDevice."Mic" {
>   	EnableSequence [
>   		cset "name='Stereo1 ADC MIXL ADC2 Switch' on"
>   		cset "name='Stereo1 ADC MIXR ADC2 Switch' on"
> +		cset "name='DMIC ASRC Switch' on"
>   		cset "name='Internal Mic Switch' on"
>   	]
>   
>   	DisableSequence [
>   		cset "name='Stereo1 ADC MIXL ADC2 Switch' off"
>   		cset "name='Stereo1 ADC MIXR ADC2 Switch' off"
> +		cset "name='DMIC ASRC Switch' off"
>   		cset "name='Internal Mic Switch' off"
>   	]
>   
> 

Applied to the alsa-ucm-conf repo. Thank you.

						Jaroslav

-- 
Jaroslav Kysela <perex@perex.cz>
Linux Sound Maintainer; ALSA Project; Red Hat, Inc.
