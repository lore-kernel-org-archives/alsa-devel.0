Return-Path: <SRS0=rI3+=CL=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1FDFBC433E2
	for <alsa-devel@archiver.kernel.org>; Wed,  2 Sep 2020 15:24:14 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8714220829
	for <alsa-devel@archiver.kernel.org>; Wed,  2 Sep 2020 15:24:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="BMPSbUxI";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="0vlvv5xk"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8714220829
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id D8327187D;
	Wed,  2 Sep 2020 17:23:21 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz D8327187D
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1599060251;
	bh=PafC4luDUVsLd0CvhpVv+0h3RiIUnGou8VQWTyXKaH4=;
	h=Date:From:To:Subject:References:In-Reply-To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=BMPSbUxIBuazoOvfcJyxIuzUOz6j3OAR+13DWFb/SWG9G/KWVa9l9ChK7UGV5COq7
	 EC6zxbGXkZ5Px4MUyWp6Ts5Kqs0IA9n3OKHsSQtj6/MUqmOv84bcvolx9AhTCVMdPR
	 kWQk38mwCC7dA3Z68hvf3ddT9Y46tOtOyIsPkM4s=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 2BB66F80276;
	Wed,  2 Sep 2020 17:22:32 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 2FA88F802C3; Wed,  2 Sep 2020 17:22:30 +0200 (CEST)
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 479DAF802A1
 for <alsa-devel@alsa-project.org>; Wed,  2 Sep 2020 17:22:23 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 479DAF802A1
Authentication-Results: alsa1.perex.cz;
 dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org
 header.b="0vlvv5xk"
Received: from localhost (83-86-74-64.cable.dynamic.v4.ziggo.nl [83.86.74.64])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256
 bits)) (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id EB09B20767;
 Wed,  2 Sep 2020 15:22:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1599060142;
 bh=PafC4luDUVsLd0CvhpVv+0h3RiIUnGou8VQWTyXKaH4=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=0vlvv5xkZfFzOch2k7oTHhJc577RFRmad/f4nIOgptOpLm4VyphiT4+lWXH9Ch9Mb
 f/q94ZLdLFwBvqo5pW9SGyvATymfNUxqK6GeqGoWJIfp5jQpSX0XTTcfwkMkUHfoji
 78aMyrwzA/VJvMJl5zab+f+IAe9ZuMdDJ/In0okI=
Date: Wed, 2 Sep 2020 17:22:48 +0200
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Takashi Iwai <tiwai@suse.de>
Subject: Re: [PATCH 7/9] sound: line6: convert to use new usb control
 function...
Message-ID: <20200902152248.GB2032878@kroah.com>
References: <20200902110115.1994491-1-gregkh@linuxfoundation.org>
 <20200902110115.1994491-9-gregkh@linuxfoundation.org>
 <s5ha6y89r6u.wl-tiwai@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <s5ha6y89r6u.wl-tiwai@suse.de>
Cc: alsa-devel@alsa-project.org, johan.hedberg@gmail.com,
 linux-kernel@vger.kernel.org, marcel@holtmann.org, linux-usb@vger.kernel.org,
 tiwai@suse.com, stern@rowland.harvard.ed, linux-bluetooth@vger.kernel.org,
 dvyukov@google.com, himadrispandya@gmail.com
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

On Wed, Sep 02, 2020 at 04:41:29PM +0200, Takashi Iwai wrote:
> On Wed, 02 Sep 2020 13:01:10 +0200,
> Greg Kroah-Hartman wrote:
> > 
> > Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> 
> I guess this and a few others with (x/9) are stale patches, right?

Ugh, yes, those were still in my directory, my fault for using 'git
send-email *patch'

:(

greg k-h
