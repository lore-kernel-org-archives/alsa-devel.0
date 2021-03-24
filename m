Return-Path: <SRS0=3oXn=IW=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E2DFDC433C1
	for <alsa-devel@archiver.kernel.org>; Wed, 24 Mar 2021 18:52:24 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 62C2461A0A
	for <alsa-devel@archiver.kernel.org>; Wed, 24 Mar 2021 18:52:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 62C2461A0A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id B7C2D1616;
	Wed, 24 Mar 2021 19:51:31 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz B7C2D1616
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1616611941;
	bh=T9PuEBMW2Ugsu7ZpEQxirxtXq3CnoSXNqgelwfQ8hxI=;
	h=Date:From:To:Subject:References:In-Reply-To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=edLg00I0ZtnymgWcyuQwdeIMdNx0s1V2KgzWelD0NGbyzknI5rjGVb2FZWE6F9+zI
	 8q7XAupWRsjrEG5bTnXFha7m4+fwKQi2RYdx6/ChAjx6+khDjKJ2/og+iSAK92LHot
	 jBb3I3Vs+8sJOTrtfVEG8RrF8Z+PjwN12FYqWlSs=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 21494F80156;
	Wed, 24 Mar 2021 19:51:31 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id D2CFAF8016B; Wed, 24 Mar 2021 19:51:29 +0100 (CET)
Received: from aserp2130.oracle.com (aserp2130.oracle.com [141.146.126.79])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id AE03BF80104
 for <alsa-devel@alsa-project.org>; Wed, 24 Mar 2021 19:51:20 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz AE03BF80104
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com
 header.b="w1L/wZbG"
Received: from pps.filterd (aserp2130.oracle.com [127.0.0.1])
 by aserp2130.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 12OIiHrC145718;
 Wed, 24 Mar 2021 18:51:17 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=corp-2020-01-29;
 bh=it5Jx4mfOUvPNC0feT8uQU3Wr784UnyNfdgedmnfFKg=;
 b=w1L/wZbGEqS6URcwn2AwPXHaJ9xHwh9CD3FqRgVxEnAOQvUoi4MpQfFOIy+eUgEuscPx
 ths8WRQZqjw5DGUb1RMDzdCnaFGKwPGhKMV0m4ix/EkQ2T+w/vdo5MOwkRxhG6ShYZYy
 EeoFKRq6aNtK3QWcas9Hf+9hM/XHE9rTXICMn7iBUnJxzkgLfC7KtF5nr5d5mW5lvhbH
 Jt7r/B3xE3Or01nAwpOju8bF/LRuapw4FWmxfNe7OVNvfuFnQnBNvHSe9iea53xFkrJM
 qrBXStSYm5iwHpA9eptV7AO250DZOYCZsfif4Hubcd1y8kprVkoahiqxdPYgDqYR6+Ls /g== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
 by aserp2130.oracle.com with ESMTP id 37d6jbm068-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 24 Mar 2021 18:51:17 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
 by aserp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 12OIpC82188179;
 Wed, 24 Mar 2021 18:51:16 GMT
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
 by aserp3030.oracle.com with ESMTP id 37dtmr6yrb-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 24 Mar 2021 18:51:16 +0000
Received: from abhmp0014.oracle.com (abhmp0014.oracle.com [141.146.116.20])
 by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 12OIoufO016250;
 Wed, 24 Mar 2021 18:50:59 GMT
Received: from kadam (/102.36.221.92) by default (Oracle Beehive Gateway v4.0)
 with ESMTP ; Wed, 24 Mar 2021 11:50:55 -0700
Date: Wed, 24 Mar 2021 21:50:47 +0300
From: Dan Carpenter <dan.carpenter@oracle.com>
To: Muhammad Usama Anjum <musamaanjum@gmail.com>
Subject: Re: [PATCH] ALSA: usb-audio: Fix missing return assignment
Message-ID: <20210324185047.GP1667@kadam>
References: <20210324172604.GA380592@LEGION>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210324172604.GA380592@LEGION>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Proofpoint-IMR: 1
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9933
 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0
 mlxscore=0 phishscore=0
 bulkscore=0 suspectscore=0 malwarescore=0 mlxlogscore=999 spamscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2103240135
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9933
 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0
 phishscore=0
 lowpriorityscore=0 suspectscore=0 clxscore=1015 priorityscore=1501
 spamscore=0 adultscore=0 impostorscore=0 mlxlogscore=999 mlxscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2103240134
Cc: alsa-devel@alsa-project.org, kernel-janitors@vger.kernel.org,
 linux-kernel@vger.kernel.org, Takashi Iwai <tiwai@suse.com>,
 colin.king@canonical.com
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

On Wed, Mar 24, 2021 at 10:26:04PM +0500, Muhammad Usama Anjum wrote:
> Return value of usb_driver_claim_interface should not be ignored.
> Instead it should be stored in err variable and returned from
> this function.
> 
> Signed-off-by: Muhammad Usama Anjum <musamaanjum@gmail.com>
> ---
>  sound/usb/quirks.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/sound/usb/quirks.c b/sound/usb/quirks.c
> index 9e5e37eff10e..dd32ceaef18a 100644
> --- a/sound/usb/quirks.c
> +++ b/sound/usb/quirks.c
> @@ -427,10 +427,10 @@ static int create_autodetect_quirks(struct snd_usb_audio *chip,
>  
>  		err = create_autodetect_quirk(chip, iface, driver);
>  		if (err >= 0)

create_autodetect_quirk() never returns positive values.  Flip this
condition.  (Always do error handling, don't do success handling).

		if (err)
			continue;


> -			usb_driver_claim_interface(driver, iface, (void *)-1L);
> +			err = usb_driver_claim_interface(driver, iface, (void *)-1L);

This is in a loop so only the last return value is used.  Which seems
sort of weird and pointless that the last value would matter more than
the others.

>  	}
>  
> -	return 0;
> +	return err;

regards,
dan carpenter

