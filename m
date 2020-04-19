Return-Path: <SRS0=/ZdJ=6D=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 51211C38A30
	for <alsa-devel@archiver.kernel.org>; Sun, 19 Apr 2020 12:04:12 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C4C8121744
	for <alsa-devel@archiver.kernel.org>; Sun, 19 Apr 2020 12:04:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="IsQBphYJ";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="BQIo366f"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C4C8121744
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 2215C1663;
	Sun, 19 Apr 2020 14:03:20 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 2215C1663
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1587297850;
	bh=x2vOiaCnxxSwfQdLjmqVJM8lbr3nu9ilx4uLADcHgbI=;
	h=Date:From:To:Subject:References:In-Reply-To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=IsQBphYJhyEOqaN2zFRqUnqmjGWmH9nZu1/bybZ4TzZdERTdi3sIZTdBnen0wgJ4n
	 A1/P46lGJxIviTLuF2FL3Bj8pfLZ7IxvfHfDUJp4Q2K6BM7Y2EIKgRhMK/ZHq14xhS
	 qP6+nKa0g2FGJy6cmB664zcdEDcxeb+AAp6qisyU=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id B33B9F800E7;
	Sun, 19 Apr 2020 14:03:19 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id E438FF801EC; Sun, 19 Apr 2020 14:03:17 +0200 (CEST)
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id AA23DF800E7
 for <alsa-devel@alsa-project.org>; Sun, 19 Apr 2020 14:03:11 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz AA23DF800E7
Authentication-Results: alsa1.perex.cz;
 dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org
 header.b="BQIo366f"
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl
 [83.86.89.107])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id EEB2F21841;
 Sun, 19 Apr 2020 12:03:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1587297788;
 bh=x2vOiaCnxxSwfQdLjmqVJM8lbr3nu9ilx4uLADcHgbI=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=BQIo366fubUyRRR8gy2ghwhRQu0Kwnh4p0dbM2JbxKVFUDW8yZ1SDgiYSl5JqwVeR
 wZ5SL8Ku8jXAHvkI6SEOWx2BKIwYfUnNkbRnpiO/xRR81S6FYbEAx2Q4OceLmb8Ctn
 LwJSFTVsq/8XLc3RC94BktgRcZXJ/hdv3QPM50lA=
Date: Sun, 19 Apr 2020 14:03:04 +0200
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [PATCH 7/9] drivers/base: fix empty-body warnings in devcoredump.c
Message-ID: <20200419120304.GA3668771@kroah.com>
References: <20200418184111.13401-1-rdunlap@infradead.org>
 <20200418184111.13401-8-rdunlap@infradead.org>
 <20200418185033.GQ5820@bombadil.infradead.org>
 <b88d6f8b-e6af-7071-cefa-dc12e79116b6@infradead.org>
 <d018321b0f281ff29efb04dd1496c8e6499812fb.camel@perches.com>
 <CAHk-=wi4QU90W1j1VVUrqdrkrq-0XPA06sjGUm-g1VHRB-35YA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHk-=wi4QU90W1j1VVUrqdrkrq-0XPA06sjGUm-g1VHRB-35YA@mail.gmail.com>
Cc: alsa-devel@alsa-project.org, Randy Dunlap <rdunlap@infradead.org>,
 Rafael Wysocki <rafael@kernel.org>, Zzy Wysm <zzy@zzywysm.com>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 "J. Bruce Fields" <bfields@fieldses.org>,
 target-devel <target-devel@vger.kernel.org>, Dave Jiang <dave.jiang@intel.com>,
 linux-scsi <linux-scsi@vger.kernel.org>,
 linux-nvdimm <linux-nvdimm@lists.01.org>,
 Vishal Verma <vishal.l.verma@intel.com>, Matthew Wilcox <willy@infradead.org>,
 Chuck Lever <chuck.lever@oracle.com>, linux-input@vger.kernel.org,
 Joe Perches <joe@perches.com>, Alexander Viro <viro@zeniv.linux.org.uk>,
 Dan Williams <dan.j.williams@intel.com>,
 Andrew Morton <akpm@linux-foundation.org>, "open list:NFS, SUNRPC,
 AND..." <linux-nfs@vger.kernel.org>,
 "Martin K. Petersen" <martin.petersen@oracle.com>,
 Dmitry Torokhov <dmitry.torokhov@gmail.com>, Takashi Iwai <tiwai@suse.com>,
 linux-usb@vger.kernel.org, linux-fsdevel <linux-fsdevel@vger.kernel.org>,
 Johannes Berg <johannes@sipsolutions.net>
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

On Sat, Apr 18, 2020 at 12:15:57PM -0700, Linus Torvalds wrote:
> On Sat, Apr 18, 2020 at 11:57 AM Joe Perches <joe@perches.com> wrote:
> >
> > sysfs_create_link is __must_check
> 
> The way to handle __must_check if you really really don't want to test
> and have good reasons is
> 
>  (a) add a big comment about why this case ostensibly doesn't need the check
> 
>  (b) cast a test of it to '(void)' or something (I guess we could add
> a helper for this). So something like
> 
>         /* We will always clean up, we don't care whether this fails
> or succeeds */
>         (void)!!sysfs_create_link(...)
> 
> There are other alternatives (like using WARN_ON_ONCE() instead, for
> example). So it depends on the code. Which is why that comment is
> important to show why the code chose that option.
> 
> However, I wonder if in this case we should just remove the
> __must_check. Greg? It goes back a long long time.

Yeah, maybe it is time to remove it, the gyrations people go through to
remove the warning when they "know" they are doing it right feels pretty
bad compared to forcing people to check things for "normal" calls to the
function.

thanks,

greg k-h
