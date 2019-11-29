Return-Path: <SRS0=Vfj9=ZV=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1BD00C432C0
	for <alsa-devel@archiver.kernel.org>; Fri, 29 Nov 2019 16:02:52 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D663A216F4
	for <alsa-devel@archiver.kernel.org>; Fri, 29 Nov 2019 16:02:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="SqQgYaCi";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=perex.cz header.i=@perex.cz header.b="eegNLqIv"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D663A216F4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=perex.cz
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 970DC16BF;
	Fri, 29 Nov 2019 17:01:58 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 970DC16BF
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1575043368;
	bh=kZEKdL63F5/WQdOGhU1XZUSSu+/eqmSAGv0papJzX/E=;
	h=To:References:From:Date:In-Reply-To:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=SqQgYaCi6FDmUzvagj/FIx3v40aumic+QNWhnPK9Se6AzryeSFIi6gE579wJQ8v9w
	 Q2YVoWoiqro518dYtvCN5K0wpYnFBlXSgJtBaBI5pVLQlQRCcjPut31y1j+N5VcQAo
	 p2DIarMRQhkOuK9mAj1govh4txnyxMEYWlD7G8C0=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 12CE9F80141;
	Fri, 29 Nov 2019 17:01:58 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 82B5FF8016F; Fri, 29 Nov 2019 17:01:56 +0100 (CET)
Received: from mail1.perex.cz (mail1.perex.cz [77.48.224.245])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 46A19F80141
 for <alsa-devel@alsa-project.org>; Fri, 29 Nov 2019 17:01:51 +0100 (CET)
Received: from mail1.perex.cz (localhost [127.0.0.1])
 by smtp1.perex.cz (Perex's E-mail Delivery System) with ESMTP id 595C3A0046;
 Fri, 29 Nov 2019 17:01:51 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.perex.cz 595C3A0046
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=perex.cz; s=default;
 t=1575043311; bh=SwZJ4aP38Ng80UDgSUBZreMlt+2xRx91K9PYdgrI+kM=;
 h=Subject:To:References:From:Date:In-Reply-To:From;
 b=eegNLqIvrzSjsqzlQllI/AkHRJbL9rK2+/yl3z/4bOdX+p+8cB/S8y6IAqJQ1aEEZ
 uaPlSF/W/fBs7ltS+8+Zj+7I/P5TX9csk2ciTWW43wJAj32+tco2mUDqSevrT7Cfko
 egZTWMRABNjk2Dvti0HI7c4colCOUUK/iujgc+P4=
Received: from p50.perex-int.cz (unknown [192.168.100.94])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested) (Authenticated sender: perex)
 by mail1.perex.cz (Perex's E-mail Delivery System) with ESMTPSA;
 Fri, 29 Nov 2019 17:01:49 +0100 (CET)
To: Curtis Malainey <cujomalainey@chromium.org>,
 ALSA development <alsa-devel@alsa-project.org>
References: <20191107015808.26844-1-cujomalainey@chromium.org>
 <20191107015808.26844-2-cujomalainey@chromium.org>
 <4b378b2c-fea2-5d77-26ff-0ff409d8e527@perex.cz>
From: Jaroslav Kysela <perex@perex.cz>
Message-ID: <0626a79d-4950-ab27-d10a-366cd74da332@perex.cz>
Date: Fri, 29 Nov 2019 17:01:49 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.1
MIME-Version: 1.0
In-Reply-To: <4b378b2c-fea2-5d77-26ff-0ff409d8e527@perex.cz>
Content-Language: en-US
Subject: Re: [alsa-devel] [PATCH 02/11] ucm: docs: Add JackType value
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
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: "Alsa-devel" <alsa-devel-bounces@alsa-project.org>

Dne 11. 11. 19 v 14:39 Jaroslav Kysela napsal(a):
> Dne 07. 11. 19 v 2:57 Curtis Malainey napsal(a):
>> Identifies the type of jack and how it should be accessed
>>
>> Signed-off-by: Curtis Malainey <cujomalainey@chromium.org>
>> ---
>>    include/use-case.h | 3 +++
>>    1 file changed, 3 insertions(+)
>>
>> diff --git a/include/use-case.h b/include/use-case.h
>> index 2051bd40..3208cc30 100644
>> --- a/include/use-case.h
>> +++ b/include/use-case.h
>> @@ -322,6 +322,9 @@ int snd_use_case_get_list(snd_use_case_mgr_t *uc_mgr,
>>     *        configuration that doesn't belong to UCM configuration files.
>>     *   - JackName
>>     *      - Input name is the input device name for the jack
>> + *   - JackType
>> + *      - Specifies whether the jack is accessed via hctl or gpio and therefore
>> + *        only carries the possible values of "gpio" or "hctl"
>>     */
>>    int snd_use_case_get(snd_use_case_mgr_t *uc_mgr,
>>                         const char *identifier,
>>
> 
> What is meant with the "gpio" type? The standard input device interface? I
> believe it should be "inputdev" and "ctl" (hctl is just interface on top of
> ctl and the application can access the jack through snd_ctl functions, too.

I see (when I was cleaning this extra Chrome stuff in the ucm profiles) that 
it's related to the gpio (general purpose i/o pin interface) in the linux 
kernel. The JackSwitch is probably also related and defines the pin number 
where the application should watch for the jack state. In this case, it would 
be probably more nice to follow the JackControl and JackDev and define the pin 
number through JackGPIO or something like that. We will cover all three 
posibilities: ALSA control interface, Input interface, GPIO interface .

					Jaroslav

-- 
Jaroslav Kysela <perex@perex.cz>
Linux Sound Maintainer; ALSA Project; Red Hat, Inc.
_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
https://mailman.alsa-project.org/mailman/listinfo/alsa-devel
