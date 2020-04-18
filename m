Return-Path: <SRS0=/ZdJ=6D=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E9587C2BA2B
	for <alsa-devel@archiver.kernel.org>; Sun, 19 Apr 2020 07:40:11 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7708821D82
	for <alsa-devel@archiver.kernel.org>; Sun, 19 Apr 2020 07:40:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="YaNTUlGZ";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="musbWlm7"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7708821D82
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id C4FC91669;
	Sun, 19 Apr 2020 09:39:19 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz C4FC91669
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1587282009;
	bh=mJjGb9reRbZ/Zj5q8JTzd4iUBDCX7JTDlEYlVLaDIU4=;
	h=Date:From:To:Subject:References:In-Reply-To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=YaNTUlGZH9M+/fhBz+M4pS6HxX+yDyQ7VYckukDvg0pjXeIBpZ2AHY4WhoZ3kig6S
	 GUa7WAIiO5WLvppKsy6PfwhO5s0SuscK3Ew2c9YyF/wjJdksovzQzIim72tAwCeSF4
	 /viK+m1fhMIscGIneY6uy1FdpxpKc7iFxhzigY80=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 75B3CF80212;
	Sun, 19 Apr 2020 09:38:27 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 14516F80240; Sat, 18 Apr 2020 20:50:43 +0200 (CEST)
Received: from bombadil.infradead.org (bombadil.infradead.org
 [IPv6:2607:7c80:54:e::133])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id B806BF8016F
 for <alsa-devel@alsa-project.org>; Sat, 18 Apr 2020 20:50:40 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz B806BF8016F
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org
 header.b="musbWlm7"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
 :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
 Content-Transfer-Encoding:Content-ID:Content-Description;
 bh=M2qa3/vc2/myvbMk+MYALeJsSLdNzC1fZAyoJyG68gE=; b=musbWlm7i2hjImd1CYGB5QW7l8
 Wn/kGpq4MEnK3EQO7eZeKDFT8eS5LR23e3CnYhCDStAgjQAFY5YBGVt6kelglv19B681ienPPYSaq
 YfDJC+H0H5NLdOmuRZEmcigYq143fNpyKGLW6QQRzawQ8loN2w3Tr8KqH0mfYRp8Pfor829wVUHqA
 l1trL/tl9vJG07nJcZqpDQmkbddJurRYVp9wZ2ld/OgdRFRqUkk7SeljH7WfG/EzD5GnLgRWzeBn2
 +F+hn6JAaMQT4MLsGR2BZlvqMq0c/4rnwpzB0mmIRStMWYlkSjUiT2M0RY1BWI/jkco5Jw22oyFTf
 oqBggJew==;
Received: from willy by bombadil.infradead.org with local (Exim 4.92.3 #3 (Red
 Hat Linux)) id 1jPsXx-0005fx-6n; Sat, 18 Apr 2020 18:50:33 +0000
Date: Sat, 18 Apr 2020 11:50:33 -0700
From: Matthew Wilcox <willy@infradead.org>
To: Randy Dunlap <rdunlap@infradead.org>
Subject: Re: [PATCH 7/9] drivers/base: fix empty-body warnings in devcoredump.c
Message-ID: <20200418185033.GQ5820@bombadil.infradead.org>
References: <20200418184111.13401-1-rdunlap@infradead.org>
 <20200418184111.13401-8-rdunlap@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200418184111.13401-8-rdunlap@infradead.org>
X-Mailman-Approved-At: Sun, 19 Apr 2020 09:38:23 +0200
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

On Sat, Apr 18, 2020 at 11:41:09AM -0700, Randy Dunlap wrote:
> @@ -294,11 +295,11 @@ void dev_coredumpm(struct device *dev, s
>  
>  	if (sysfs_create_link(&devcd->devcd_dev.kobj, &dev->kobj,
>  			      "failing_device"))
> -		/* nothing - symlink will be missing */;
> +		do_empty(); /* nothing - symlink will be missing */
>  
>  	if (sysfs_create_link(&dev->kobj, &devcd->devcd_dev.kobj,
>  			      "devcoredump"))
> -		/* nothing - symlink will be missing */;
> +		do_empty(); /* nothing - symlink will be missing */
>  
>  	INIT_DELAYED_WORK(&devcd->del_wk, devcd_del);
>  	schedule_delayed_work(&devcd->del_wk, DEVCD_TIMEOUT);

Could just remove the 'if's?

+	sysfs_create_link(&devcd->devcd_dev.kobj, &dev->kobj,
+			"failing_device");
