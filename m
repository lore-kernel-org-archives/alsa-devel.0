Return-Path: <SRS0=riU+=6C=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2AFB5C352BE
	for <alsa-devel@archiver.kernel.org>; Sat, 18 Apr 2020 18:48:42 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AD1CD21D93
	for <alsa-devel@archiver.kernel.org>; Sat, 18 Apr 2020 18:48:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="XhDNnl5Y";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="nqtHk9Rc"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AD1CD21D93
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 1A423166D;
	Sat, 18 Apr 2020 20:47:50 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 1A423166D
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1587235720;
	bh=qJ9ZRRipWsRhXR39p1+akt73YbVrxrjMQ0jJtNxyl+E=;
	h=Subject:To:References:From:Date:In-Reply-To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=XhDNnl5YTJHeWLm0k5rbWq1/uy+4Mw5seHEmRCvsGS+QwLEZuLnSgyz+8L5zUPu9H
	 KZgoFLOEk96V6Q7RnMNPNKu7bPEFXageQjuxHqS0frb2ukjvJSyNSj0S0dBwz0l9OD
	 TKEkKqGvcmNjjOvnP//A1FC6tMsWg3wffVbldiN4=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id CE701F80240;
	Sat, 18 Apr 2020 20:46:48 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 8297FF80248; Sat, 18 Apr 2020 20:46:46 +0200 (CEST)
Received: from bombadil.infradead.org (bombadil.infradead.org
 [IPv6:2607:7c80:54:e::133])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 04F94F80122
 for <alsa-devel@alsa-project.org>; Sat, 18 Apr 2020 20:46:43 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 04F94F80122
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org
 header.b="nqtHk9Rc"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
 Content-Type:In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:
 Subject:Sender:Reply-To:Content-ID:Content-Description;
 bh=VISMEuIrdwsT06Me0Ojm4dxgrzpFN+IXsxHmlBlB8Qk=; b=nqtHk9RcEHVzyndzlvZR0ApTMu
 IN1fIO34WRJMJqoiVj7+SryUcbwhljitvqy/ICpkyIIe3BbMMImIye+e0/hX/bK155cyiYWUCLYSi
 BtcqtD6RrusuGCd9kZzO2uiwoFPl/pFtQB+EGVC0bUi41qqnl4Vd22sCWLoaS3qMDLJU6B+8Y/b3B
 pwlcV/D8BHV05r1/Bqcf3oReONTpcDhMqDTzxTxGSy3/capPzIfLqB6dlPwacRlKAaiVeGpJyRWHw
 KugYiErRe0UugJTz9HVHOvQZE01XSsMXRBvnxI0dM+ehHI+0RgwUw4Yb5V/AkkYq+jOPkS4NBxqRm
 SktMceiA==;
Received: from [2601:1c0:6280:3f0::19c2]
 by bombadil.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
 id 1jPsU6-0002Y8-4x; Sat, 18 Apr 2020 18:46:34 +0000
Subject: Re: [PATCH 5/9] usb: fix empty-body warning in sysfs.c
To: Matthew Wilcox <willy@infradead.org>
References: <20200418184111.13401-1-rdunlap@infradead.org>
 <20200418184111.13401-6-rdunlap@infradead.org>
 <20200418184409.GP5820@bombadil.infradead.org>
From: Randy Dunlap <rdunlap@infradead.org>
Message-ID: <3998d056-e115-4e36-2705-eea132cce7de@infradead.org>
Date: Sat, 18 Apr 2020 11:46:32 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <20200418184409.GP5820@bombadil.infradead.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Cc: alsa-devel@alsa-project.org, Dmitry Torokhov <dmitry.torokhov@gmail.com>,
 Zzy Wysm <zzy@zzywysm.com>, linux-kernel@vger.kernel.org,
 "J. Bruce Fields" <bfields@fieldses.org>, target-devel@vger.kernel.org,
 Dave Jiang <dave.jiang@intel.com>, linux-scsi@vger.kernel.org,
 linux-nvdimm@lists.01.org, Vishal Verma <vishal.l.verma@intel.com>,
 linux-input@vger.kernel.org, Alexander Viro <viro@zeniv.linux.org.uk>,
 Dan Williams <dan.j.williams@intel.com>,
 Andrew Morton <akpm@linux-foundation.org>, linux-nfs@vger.kernel.org,
 "Martin K. Petersen" <martin.petersen@oracle.com>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-usb@vger.kernel.org,
 Takashi Iwai <tiwai@suse.com>, Chuck Lever <chuck.lever@oracle.com>,
 linux-fsdevel@vger.kernel.org, Johannes Berg <johannes@sipsolutions.net>,
 Linus Torvalds <torvalds@linux-foundation.org>
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

On 4/18/20 11:44 AM, Matthew Wilcox wrote:
> On Sat, Apr 18, 2020 at 11:41:07AM -0700, Randy Dunlap wrote:
>> +++ linux-next-20200327/drivers/usb/core/sysfs.c
>> @@ -1263,7 +1263,7 @@ void usb_create_sysfs_intf_files(struct
>>  	if (!alt->string && !(udev->quirks & USB_QUIRK_CONFIG_INTF_STRINGS))
>>  		alt->string = usb_cache_string(udev, alt->desc.iInterface);
>>  	if (alt->string && device_create_file(&intf->dev, &dev_attr_interface))
>> -		;	/* We don't actually care if the function fails. */
>> +		do_empty(); /* We don't actually care if the function fails. */
>>  	intf->sysfs_files_created = 1;
>>  }
> 
> Why not just?
> 
> +	if (alt->string)
> +		device_create_file(&intf->dev, &dev_attr_interface);
> 

Yes, looks good. Thanks.

-- 
~Randy

