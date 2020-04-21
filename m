Return-Path: <SRS0=/Ps/=6F=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C40D9C54FCC
	for <alsa-devel@archiver.kernel.org>; Tue, 21 Apr 2020 13:59:06 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4F2BB206F4
	for <alsa-devel@archiver.kernel.org>; Tue, 21 Apr 2020 13:59:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="MvlqmZx1"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4F2BB206F4
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=rowland.harvard.edu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 99CE016C7;
	Tue, 21 Apr 2020 15:58:14 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 99CE016C7
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1587477544;
	bh=DOnAI/GE4L5BFVC2JEPAf2zyLKGZBcy/P5vmGm1QEjo=;
	h=Date:From:To:Subject:In-Reply-To:Cc:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:From;
	b=MvlqmZx1Cjndp6/7RSPL3Y81R9p8KLM79gSBRZkLfjBYRd6pCXmx5NAnH38tx2GX/
	 rQWDmEwdgB3bDkeUSJeCQWi9fGPj/H6PWG5voGZJwDffOFw1IOgeon2igfsGFnCziv
	 Bw1S3z/ltkl5COERLXByL0V9z9q5yYfonviD3XG4=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 317DAF800E7;
	Tue, 21 Apr 2020 15:58:14 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 3AE3BF801EC; Tue, 21 Apr 2020 15:58:12 +0200 (CEST)
Received: from netrider.rowland.org (netrider.rowland.org [192.131.102.5])
 by alsa1.perex.cz (Postfix) with SMTP id 45625F800E7
 for <alsa-devel@alsa-project.org>; Tue, 21 Apr 2020 15:58:04 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 45625F800E7
Received: (qmail 21373 invoked by uid 500); 21 Apr 2020 09:58:02 -0400
Received: from localhost (sendmail-bs@127.0.0.1)
 by localhost with SMTP; 21 Apr 2020 09:58:02 -0400
Date: Tue, 21 Apr 2020 09:58:02 -0400 (EDT)
From: Alan Stern <stern@rowland.harvard.edu>
X-X-Sender: stern@netrider.rowland.org
To: NeilBrown <neilb@suse.de>
Subject: Re: [PATCH 5/9] usb: fix empty-body warning in sysfs.c
In-Reply-To: <87368xskga.fsf@notabene.neil.brown.name>
Message-ID: <Pine.LNX.4.44L0.2004210956590.20254-100000@netrider.rowland.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: alsa-devel@alsa-project.org, Randy Dunlap <rdunlap@infradead.org>,
 Zzy Wysm <zzy@zzywysm.com>, linux-kernel@vger.kernel.org,
 "J. Bruce Fields" <bfields@fieldses.org>, target-devel@vger.kernel.org,
 Dave Jiang <dave.jiang@intel.com>, linux-scsi@vger.kernel.org,
 linux-nvdimm@lists.01.org, Vishal Verma <vishal.l.verma@intel.com>,
 Matthew Wilcox <willy@infradead.org>, Chuck Lever <chuck.lever@oracle.com>,
 linux-input@vger.kernel.org, Alexander Viro <viro@zeniv.linux.org.uk>,
 Dan Williams <dan.j.williams@intel.com>,
 Andrew Morton <akpm@linux-foundation.org>, linux-nfs@vger.kernel.org,
 "Martin K. Petersen" <martin.petersen@oracle.com>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Dmitry Torokhov <dmitry.torokhov@gmail.com>, Takashi Iwai <tiwai@suse.com>,
 linux-usb@vger.kernel.org, linux-fsdevel@vger.kernel.org,
 Johannes Berg <johannes@sipsolutions.net>,
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

On Tue, 21 Apr 2020, NeilBrown wrote:

> On Sat, Apr 18 2020, Alan Stern wrote:
> 
> > On Sat, 18 Apr 2020, Matthew Wilcox wrote:
> >
> >> On Sat, Apr 18, 2020 at 11:41:07AM -0700, Randy Dunlap wrote:
> >> > +++ linux-next-20200327/drivers/usb/core/sysfs.c
> >> > @@ -1263,7 +1263,7 @@ void usb_create_sysfs_intf_files(struct
> >> >  	if (!alt->string && !(udev->quirks & USB_QUIRK_CONFIG_INTF_STRINGS))
> >> >  		alt->string = usb_cache_string(udev, alt->desc.iInterface);
> >> >  	if (alt->string && device_create_file(&intf->dev, &dev_attr_interface))
> >> > -		;	/* We don't actually care if the function fails. */
> >> > +		do_empty(); /* We don't actually care if the function fails. */
> >> >  	intf->sysfs_files_created = 1;
> >> >  }
> >> 
> >> Why not just?
> >> 
> >> +	if (alt->string)
> >> +		device_create_file(&intf->dev, &dev_attr_interface);
> >
> > This is another __must_check function call.
> >
> > The reason we don't care if the call fails is because the file
> > being created holds the USB interface string descriptor, something
> > which is purely informational and hardly ever gets set (and no doubt
> > gets used even less often).
> >
> > Is this another situation where the comment should be expanded and the 
> > code modified to include a useless test and cast-to-void?
> >
> > Or should device_create_file() not be __must_check after all?
> 
> One approach to dealing with __must_check function that you don't want
> to check is to cause failure to call
>    pr_debug("usb: interface descriptor file not created");
> or similar.  It silences the compiler, serves as documentation, and
> creates a message that is almost certainly never seen.
> 
> This is what I did in drivers/md/md.c...
> 
> 	if (mddev->kobj.sd &&
> 	    sysfs_create_group(&mddev->kobj, &md_bitmap_group))
> 		pr_debug("pointless warning\n");
> 
> (I give better warnings elsewhere - I must have run out of patience by
>  this point).

That's a decent idea.  I'll do something along those lines.

Alan Stern

