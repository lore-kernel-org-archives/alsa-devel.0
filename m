Return-Path: <SRS0=30sX=ZH=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 72E42C432C3
	for <alsa-devel@archiver.kernel.org>; Fri, 15 Nov 2019 09:40:59 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EDC8E20732
	for <alsa-devel@archiver.kernel.org>; Fri, 15 Nov 2019 09:40:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="TM5ty3QV";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=nvidia.com header.i=@nvidia.com header.b="qbjlL55X"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EDC8E20732
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nvidia.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 088BC1615;
	Fri, 15 Nov 2019 10:40:07 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 088BC1615
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1573810857;
	bh=4OlPkHOtsFWyRClUaAXZSH0OKgVlW6+p/eH4fW46Zl4=;
	h=To:References:From:Date:In-Reply-To:Cc:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=TM5ty3QVXNGdt8bsChIyuQUQZvfyKmTpHFxqysKtr59wr6UcejJtCVKPWNfqEyF83
	 ffGqY9j+1qHGzKFSkX3vEvWPldQn5y+VudIA1/8kBsUv3PQFBioTCeKRg9u4NJk/Ka
	 dZYw0ET/7KxHOzLNb0UvVK3QNI7V6fvxfhMVJQPQ=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 7AC7CF80102;
	Fri, 15 Nov 2019 10:40:06 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 2CCD0F80103; Fri, 15 Nov 2019 10:40:05 +0100 (CET)
Received: from hqemgate14.nvidia.com (hqemgate14.nvidia.com [216.228.121.143])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256
 bits)) (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id CB30DF8007E
 for <alsa-devel@alsa-project.org>; Fri, 15 Nov 2019 10:40:01 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz CB30DF8007E
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=nvidia.com header.i=@nvidia.com
 header.b="qbjlL55X"
Received: from hqpgpgate101.nvidia.com (Not Verified[216.228.121.13]) by
 hqemgate14.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
 id <B5dce72720000>; Fri, 15 Nov 2019 01:40:02 -0800
Received: from hqmail.nvidia.com ([172.20.161.6])
 by hqpgpgate101.nvidia.com (PGP Universal service);
 Fri, 15 Nov 2019 01:39:59 -0800
X-PGP-Universal: processed;
 by hqpgpgate101.nvidia.com on Fri, 15 Nov 2019 01:39:59 -0800
Received: from [10.24.218.121] (10.124.1.5) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Fri, 15 Nov
 2019 09:39:57 +0000
To: Kai Vehmanen <kai.vehmanen@linux.intel.com>
References: <20191114033704.18171-1-nmahale@nvidia.com>
 <20191114033704.18171-3-nmahale@nvidia.com>
 <alpine.DEB.2.21.1911141241280.16459@zeliteleevi>
From: Nikhil Mahale <nmahale@nvidia.com>
Message-ID: <6820ece3-5c13-e627-ce71-2e4aac8c0b96@nvidia.com>
Date: Fri, 15 Nov 2019 15:09:54 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.1
MIME-Version: 1.0
In-Reply-To: <alpine.DEB.2.21.1911141241280.16459@zeliteleevi>
X-Originating-IP: [10.124.1.5]
X-ClientProxiedBy: HQMAIL111.nvidia.com (172.20.187.18) To
 HQMAIL107.nvidia.com (172.20.187.13)
Content-Language: en-US
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
 t=1573810802; bh=sVa8gG6rfv1/qmIG/CI4spV6eL9Z128IS6ZdiZz32Gg=;
 h=X-PGP-Universal:Subject:To:CC:References:From:Message-ID:Date:
 User-Agent:MIME-Version:In-Reply-To:X-Originating-IP:
 X-ClientProxiedBy:Content-Type:Content-Language:
 Content-Transfer-Encoding;
 b=qbjlL55XkcT1UHFghqpraNmDVLnA14S68gCI4yniBu4gZWzFGKmOACMV0U5Le4VjU
 Tn3V7DtaZrUnk+goA1gmX3N3WZV0b+0sgOTxBcs9EwOUQ8IZ51nNT5pWSrcgUxIkRQ
 QKNvTtM0OxK/sgkY6BnMbdStZp1i/gPQr4IVHnlOSrlyzuFc0hQa4b9rIqCw94Ntpv
 Tp0exPV/XV9tbvgS3c0Ecgun787COeB3R8intnvq92lrBE/Itw2T9/JXraTXgChfb2
 KKWJB/0Dkr0oLD3Xj2lVt1jwJyLve6aKC3S5yKgcYmENxIdIJ/20ObTJnufVtonTDZ
 euDcuxcMqOcmg==
Cc: alsa-devel@alsa-project.org, tiwai@suse.com, aplattner@nvidia.com
Subject: Re: [alsa-devel] [PATCH v1 2/5] ALSA: hda - Add DP-MST jack support
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: "Alsa-devel" <alsa-devel-bounces@alsa-project.org>

On 11/14/19 4:16 PM, Kai Vehmanen wrote:
> Hi Nikhil,
> 
> On Thu, 14 Nov 2019, Nikhil Mahale wrote:
> 
>> This patch adds DP-MST jack support which will be used on NVIDIA
>> platforms. Today, DP-MST audio is supported only if the codec has
>> acomp support. This patch makes it possible to add DP-MST support
>> for non-acomp codecs.
> [...]
>> +++ b/sound/pci/hda/hda_generic.c
>> @@ -4203,7 +4203,7 @@ static bool detect_pin_state(struct hda_codec *codec, hda_nid_t pin)
>>  {
>>  	if (!is_jack_detectable(codec, pin))
>>  		return true;
>> -	return snd_hda_jack_detect_state(codec, pin) != HDA_JACK_NOT_PRESENT;
>> +	return snd_hda_jack_detect_state(codec, pin, 0) != HDA_JACK_NOT_PRESENT;
>>  }
> 
> the patch adds quite a few checkpatch warnings. E.g. this line over 
> 80 character limit. Run checkpatch yourself or take a look at e.g.
> https://travis-ci.org/thesofproject/linux/jobs/611787177?utm_medium=notification&utm_source=github_status
> 
> I'll queued the series to SOF CI to do some testing against regressions 
> on our platforms. I'll report later if anything major found.

Thanks Kai, I have fixed all errors reported by checkpatch.pl,
in 2nd version of patch set. Sending out 2nd version of
patch set for review.

Thanks,
Nikhil Mahale
 
> Br, Kai
> 

-----------------------------------------------------------------------------------
This email message is for the sole use of the intended recipient(s) and may contain
confidential information.  Any unauthorized review, use, disclosure or distribution
is prohibited.  If you are not the intended recipient, please contact the sender by
reply email and destroy all copies of the original message.
-----------------------------------------------------------------------------------
_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
https://mailman.alsa-project.org/mailman/listinfo/alsa-devel
