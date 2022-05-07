Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8DA8CC433F5
	for <alsa-devel@archiver.kernel.org>; Tue, 10 May 2022 12:23:42 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 8B60B187D;
	Tue, 10 May 2022 14:22:50 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 8B60B187D
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1652185420;
	bh=eieCeE9Fdh+mCSq7kvDqUtqD4dWmttb7ZzhtYGZmMhA=;
	h=Date:From:To:Subject:References:In-Reply-To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=nLUWBh0UwawyDLCR0iXbs/NoS1k11jfke1Ly6yFxJ6+ycZRfHECAuVgFqTh3OY4sE
	 2ZmsaQ6hfru6lB4cX+jXaTCTF4d30kcnsewo4thFjs2jSdH+832ZLUkvqFXv9IYUeC
	 /KjOXkjwQD/nnu7OFKf7G/iUVYkaTBGe8ug1Qovo=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id C5C7EF80508;
	Tue, 10 May 2022 14:21:52 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 75430F80155; Sat,  7 May 2022 10:33:36 +0200 (CEST)
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 51493F800D3
 for <alsa-devel@alsa-project.org>; Sat,  7 May 2022 10:33:32 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 51493F800D3
Authentication-Results: alsa1.perex.cz;
 dkim=pass (1024-bit key) header.d=linuxfoundation.org
 header.i=@linuxfoundation.org header.b="02sb1bav"
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by dfw.source.kernel.org (Postfix) with ESMTPS id 5E9C161007;
 Sat,  7 May 2022 08:33:30 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3BA8AC385AC;
 Sat,  7 May 2022 08:33:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
 s=korg; t=1651912409;
 bh=eieCeE9Fdh+mCSq7kvDqUtqD4dWmttb7ZzhtYGZmMhA=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=02sb1bav56AqxmyArlrAX21IGgeG1DopOeTzyubuc25nQZRtkFcUnmmwdZwUUUUPs
 OY63D6KlNDo8TblbXBPoRpa4TpHokrst1y0/x2OVYqK8/uFCBbASkg07cBIFpC+Db9
 L0Uue1gdqUxJvOVbFKRQqTVTEHKgTDmQXZaK/0+k=
Date: Sat, 7 May 2022 10:33:25 +0200
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <u.kleine-koenig@pengutronix.de>
Subject: Re: [PATCH] kernel/drivers: Remove redundant driver match function
Message-ID: <YnYu1XGeyRvMn77g@kroah.com>
References: <20220506045952.136290-1-sensor1010@163.com>
 <20220507082137.i23gbxkbjwt36ggd@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20220507082137.i23gbxkbjwt36ggd@pengutronix.de>
X-Mailman-Approved-At: Tue, 10 May 2022 14:21:49 +0200
Cc: alsa-devel@alsa-project.org, target-devel@vger.kernel.org,
 srinivas.kandagatla@linaro.org, zbr@ioremap.net, agordeev@linux.ibm.com,
 lee.jones@linaro.org, linux-s390@vger.kernel.org, bvanassche@acm.org,
 linux-scsi@vger.kernel.org, pasic@linux.ibm.com, wens@csie.org,
 borntraeger@linux.ibm.com, jejb@linux.ibm.com, jjherne@linux.ibm.com,
 gor@linux.ibm.com, lizhe <sensor1010@163.com>, hca@linux.ibm.com,
 linux-m68k@lists.linux-m68k.org, freude@linux.ibm.com, hare@suse.de,
 dan.j.williams@intel.com, akrowiak@linux.ibm.com, martin.petersen@oracle.com,
 fthain@linux-m68k.org, tiwai@suse.com, linux-kernel@vger.kernel.org,
 svens@linux.ibm.com, colin.king@intel.com
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

On Sat, May 07, 2022 at 10:21:37AM +0200, Uwe Kleine-König wrote:
> Hello,
> 
> On Thu, May 05, 2022 at 09:59:52PM -0700, lizhe wrote:
> > If there is no driver match function, the driver core assumes that each
> > candidate pair (driver, device) matches, see driver_match_device().
> 
> I wonder who is supposed to apply this patch. Either it should be split
> by file and go in via the respective maintainers, or it goes in via
> Greg's tree? I added Greg to To: for him to chime in.

It should be split up into each subsystem patch and submitted that way.

> Best regards
> Uwe
>  
> > Signed-off-by: lizhe <sensor1010@163.com>

We also need a "real name" here that is used to sign legal documents.  I
doubt an all-lower-case name is used that way, so I have to ask.

thanks,

greg k-h
