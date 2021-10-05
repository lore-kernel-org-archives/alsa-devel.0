Return-Path: <SRS0=jGB1=OZ=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4D927C433EF
	for <alsa-devel@archiver.kernel.org>; Tue,  5 Oct 2021 08:32:30 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 91EF861056
	for <alsa-devel@archiver.kernel.org>; Tue,  5 Oct 2021 08:32:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 91EF861056
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=perex.cz
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id C7E9D1666;
	Tue,  5 Oct 2021 10:31:35 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz C7E9D1666
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1633422745;
	bh=f5Y7Pkl2sJbXFB+jNFv9YPg8pCZ5S/dseUCyeMFeE5I=;
	h=Date:Subject:To:References:From:In-Reply-To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=Upzg1JriTCQ1Nx6nkE01YVtvOpKjiJdZK4/Qy73QZ3OUBVDc4xBsyiF+C+78Srxi8
	 7i5aKdzSaUy9EFBQ3yLfwWlEIPPFl6AK/BrumlEbXXa0Cp31ujCseMA7+5L5TJMgTs
	 g2gMwAaoxASrdIkpzqESJPQm9/4kdcZeX0WWJVRA=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 40CA6F80259;
	Tue,  5 Oct 2021 10:31:35 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 66C7EF8027D; Tue,  5 Oct 2021 10:31:31 +0200 (CEST)
Received: from mail1.perex.cz (mail1.perex.cz [77.48.224.245])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id B1AFCF80154
 for <alsa-devel@alsa-project.org>; Tue,  5 Oct 2021 10:31:22 +0200 (CEST)
Received: from mail1.perex.cz (localhost [127.0.0.1])
 by smtp1.perex.cz (Perex's E-mail Delivery System) with ESMTP id 64DBAA003F;
 Tue,  5 Oct 2021 10:31:22 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.perex.cz 64DBAA003F
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=perex.cz; s=default;
 t=1633422682; bh=CmJmzIZwnrWo2dPBRxT9DuRPxdASAnD9Ov2mtQeiTG0=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
 b=lKqs+ZTXVDQLzB4G6nVQ3JpBMEBil64WCCSx3ahnZ+T4a+0sH1DIbrAvJGj5z/qS2
 hDFS5gUhkcn1Ol4af/uC90/8EZgh6NS4he+F+W0M2rbnAciyIqKKswGtMREWU8qn9g
 RJ3BHe8ZRHFfGRe5HokEh16ZzCMTVUep+KZf2T1c=
Received: from [192.168.100.98] (unknown [192.168.100.98])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested) (Authenticated sender: perex)
 by mail1.perex.cz (Perex's E-mail Delivery System) with ESMTPSA;
 Tue,  5 Oct 2021 10:31:17 +0200 (CEST)
Message-ID: <e671d525-ac9b-bb83-936b-728a12644852@perex.cz>
Date: Tue, 5 Oct 2021 10:31:17 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.1.0
Subject: Re: User unsubscribed from mailing list
Content-Language: en-US
To: Manish DUBEY <manish.dubey-ext@st.com>,
 "review@review.trustedfirmware.org" <review@review.trustedfirmware.org>,
 "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>,
 "stratos-dev@op-lists.linaro.org." <stratos-dev@op-lists.linaro.org>
References: <VI1PR10MB2797F8838245AABC3F7FC130A7AF9@VI1PR10MB2797.EURPRD10.PROD.OUTLOOK.COM>
From: Jaroslav Kysela <perex@perex.cz>
In-Reply-To: <VI1PR10MB2797F8838245AABC3F7FC130A7AF9@VI1PR10MB2797.EURPRD10.PROD.OUTLOOK.COM>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Mohd TANVEER <mohd.tanveer-ext@st.com>
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

On 05. 10. 21 7:31, Manish DUBEY wrote:
> Hello Team,
> 
> Hope you are doing well.
> 
> We have some users in ST environment being subscribed to your Mailing list. After few days they use to get an email stating that "Your membership in the mailing list has been disabled due to excessive bounces"..
> 
> We have verified at our end and didn't find any bounce back email getting generated. To investigate the case, could you please share couple of sample bounce back (NDR) email received by you from ST environment. The NDR may help us to investigate the cause of bounce back email getting generated.
> 
> If possible, we can schedule a call as well to discuss the case. Feel free to share your availability to discuss the case and we can share a Teams invite accordingly.
> Awaiting your response.

It seems like a DMARC verification issue on your side:

Oct  5 07:29:12 alsa0 postfix/smtp[23459]: AFEC9839: 
to=<arnaud.pouliquen@foss.st.com>, 
relay=mxa-00178001.gslb.pphosted.com[185.132.182.106]:25, delay=51, 
delays=50/0.19/0.48/0.33, dsn=5.7.0, status=bounced (host 
mxa-00178001.gslb.pphosted.com[185.132.182.106] said: 550 5.7.0 Local Policy 
Violation - DMARC Reject (in reply to end of DATA command))

					Jaroslav

-- 
Jaroslav Kysela <perex@perex.cz>
Linux Sound Maintainer; ALSA Project; Red Hat, Inc.
