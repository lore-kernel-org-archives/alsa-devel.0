Return-Path: <SRS0=tzaW=56=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 003F9C2BA19
	for <alsa-devel@archiver.kernel.org>; Tue, 14 Apr 2020 13:25:14 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 538BB2063A
	for <alsa-devel@archiver.kernel.org>; Tue, 14 Apr 2020 13:25:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="MoavM9zj";
	dkim=pass (1024-bit key) header.d=perex.cz header.i=@perex.cz header.b="xfLyr6Nk"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 538BB2063A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=perex.cz
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id AE5DB1691;
	Tue, 14 Apr 2020 15:24:22 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz AE5DB1691
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1586870712;
	bh=b5j/0cIAUn4NRxwDB7/NIA/3GLka6G3fLDEMQqdAM8Y=;
	h=Subject:To:References:From:Date:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=MoavM9zjtGQFPaXdfGtIZLXlR/xf+GS4hmlDFyaRmCklpNu8C3q2Lt2GIeeGwDc7J
	 hlUrYzp11ZWjQed4hPaN9JUPZk3z2WdEFwc5LldyUTTSVHuIsHraJRv2VYGUjs8t/S
	 apcUDLC+4jkteuNmweYOx7C53j7mAvNic/URf5qQ=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 2D825F80126;
	Tue, 14 Apr 2020 15:24:22 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 3AE8FF8013D; Tue, 14 Apr 2020 15:24:21 +0200 (CEST)
Received: from mail1.perex.cz (mail1.perex.cz [77.48.224.245])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 5C508F80115
 for <alsa-devel@alsa-project.org>; Tue, 14 Apr 2020 15:24:14 +0200 (CEST)
Received: from mail1.perex.cz (localhost [127.0.0.1])
 by smtp1.perex.cz (Perex's E-mail Delivery System) with ESMTP id 6187DA003F;
 Tue, 14 Apr 2020 15:24:14 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.perex.cz 6187DA003F
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=perex.cz; s=default;
 t=1586870654; bh=qrt5UN4ljS9hH8lxeNjXZ9+DXgOq04x4E56TkuUyn6Q=;
 h=Subject:To:References:From:Date:In-Reply-To:From;
 b=xfLyr6NkQi5xd+VZtNIu2jUgyJxh6+fbsVAb87Qd9SptfRrja/7PKe87nl/xYwKVH
 q8qmT2j7qN6uBxtQbul4ZpkEU/ykWfSDymxlTwiFpJHMaLFoaCl8nLCUyXFSRNFdna
 xLXxtXl/7wQmzI5ND3T8V9OwSarGW4cIgUFTcREE=
Received: from p50.perex-int.cz (unknown [192.168.100.94])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested) (Authenticated sender: perex)
 by mail1.perex.cz (Perex's E-mail Delivery System) with ESMTPSA;
 Tue, 14 Apr 2020 15:24:11 +0200 (CEST)
Subject: Re: [PATCH] alsactl: don't exit on EINTR from epoll_wait().
To: Zev Weiss <zev@bewilderbeest.net>, alsa-devel@alsa-project.org,
 Takashi Sakamoto <o-takashi@sakamocchi.jp>
References: <20191015043650.23536-1-zev@bewilderbeest.net>
 <20200412021457.GA3961@workstation>
From: Jaroslav Kysela <perex@perex.cz>
Message-ID: <44c2c1cd-4324-a059-ce9d-63389b3b5447@perex.cz>
Date: Tue, 14 Apr 2020 15:24:11 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <20200412021457.GA3961@workstation>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
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

Dne 12. 04. 20 v 4:15 Takashi Sakamoto napsal(a):
> On Mon, Oct 14, 2019 at 11:36:50PM -0500, Zev Weiss wrote:
>> Previously, things like attaching strace to a running 'alsactl monitor'
>> process would cause it to exit.
>>
>> Signed-off-by: Zev Weiss <zev@bewilderbeest.net>
>> ---
>>   alsactl/monitor.c | 2 ++
>>   1 file changed, 2 insertions(+)
>   
> I'm sorry but I overlooked the post. It looks good to me.
> 
> Reviewed-by: Takashi Sakamoto <o-takashi@sakamocchi.jp>
> Tested-by: Takashi Sakamoto <o-takashi@sakamocchi.jp>
> 
>> diff --git a/alsactl/monitor.c b/alsactl/monitor.c
>> index 6b090e4f5c92..cf4167bee165 100644
>> --- a/alsactl/monitor.c
>> +++ b/alsactl/monitor.c
>> @@ -342,6 +342,8 @@ static int run_dispatcher(int epfd, int sigfd, int infd, struct list_head *srcs,
>>   
>>   		count = epoll_wait(epfd, epev, max_ev_count, 200);
>>   		if (count < 0) {
>> +			if (errno == EINTR)
>> +				continue;
>>   			err = count;
>>   			break;
>>   		}
>> -- 
>> 2.23.0
> 
> Regards
> 
> Takashi Sakamoto
> 


-- 
Jaroslav Kysela <perex@perex.cz>
Linux Sound Maintainer; ALSA Project; Red Hat, Inc.
