Return-Path: <SRS0=H+KG=D4=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_2 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 635D6C388F9
	for <alsa-devel@archiver.kernel.org>; Wed, 21 Oct 2020 13:41:34 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CB28520BED
	for <alsa-devel@archiver.kernel.org>; Wed, 21 Oct 2020 13:41:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="R4lIFfc7";
	dkim=pass (1024-bit key) header.d=nic.cz header.i=@nic.cz header.b="mBLaCSEt"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CB28520BED
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nic.cz
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 021191757;
	Wed, 21 Oct 2020 15:40:41 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 021191757
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1603287691;
	bh=FLr+kjAv6yLD8bqjEwLyprnEfz/mXe2f1830qS+iF0A=;
	h=Date:From:To:Subject:In-Reply-To:References:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=R4lIFfc7qwSxg8duo63xqFCFIL8gd1nykFdbNEj5goAdGNkbWPb+3g5ILc2KxnVZS
	 QRgXO21XPXGonsrW8Ouj1AYx01wEoMPqbds6eeg8cK9RTb/7jZ1ZZkfAVDR7HTTfT3
	 WPQQWU7LfJ7Il8dhke4CUF8i2uZpbMxmFmiTQdOY=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 47293F804DF;
	Wed, 21 Oct 2020 15:37:44 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id BDB3CF80247; Mon, 19 Oct 2020 12:59:04 +0200 (CEST)
Received: from mail.nic.cz (mail.nic.cz [217.31.204.67])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 927C7F8010F
 for <alsa-devel@alsa-project.org>; Mon, 19 Oct 2020 12:58:57 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 927C7F8010F
Authentication-Results: alsa1.perex.cz;
 dkim=pass (1024-bit key) header.d=nic.cz header.i=@nic.cz header.b="mBLaCSEt"
Received: from dellmb.labs.office.nic.cz (unknown
 [IPv6:2001:1488:fffe:6:cac7:3539:7f1f:463])
 by mail.nic.cz (Postfix) with ESMTPSA id 7D33D13FFC2;
 Mon, 19 Oct 2020 12:58:56 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=nic.cz; s=default;
 t=1603105136; bh=FLr+kjAv6yLD8bqjEwLyprnEfz/mXe2f1830qS+iF0A=;
 h=Date:From:To;
 b=mBLaCSEteSW/F3f9hFbWoHi9mMcq3c8B9laIMisAPFqFlKgUaMZHFpd7Lt2fHlmtp
 /2EVm7TlcXNofS8NSGd90jxiIY415NdHZJ5HedyfjjmzDjxKC3hMK85A6DN0O9fVoe
 NO2hOCjWn268C+tu3IzYLK7nTNervKHXUQDVtsP0=
Date: Mon, 19 Oct 2020 12:58:56 +0200
From: Marek =?ISO-8859-1?Q?Beh=FAn?= <marek.behun@nic.cz>
To: Udo van den Heuvel <udovdh@xs4all.nl>
Subject: Re: disabling CONFIG_LED_CLASS (SND_HDA_CODEC_REALTEK)
Message-ID: <20201019125856.02cebbee@dellmb.labs.office.nic.cz>
In-Reply-To: <d8e450ef-cde9-b799-88e9-8ed9940b95fe@xs4all.nl>
References: <1e6b1961-9e9b-5f82-86a1-bf838cb68f55@xs4all.nl>
 <d7774b58-caf5-5bd8-845d-a5d45aaef4c6@infradead.org>
 <s5hblh5mele.wl-tiwai@suse.de> <s5ha6wpmei5.wl-tiwai@suse.de>
 <20201014075853.GB29881@amd>
 <056a8933-378f-30f2-c7af-5514d93d3c36@xs4all.nl>
 <20201014081116.GC29881@amd>
 <2be6e184-97d4-a2b1-a500-6ea3528cff37@xs4all.nl>
 <20201014082752.GA31728@amd>
 <9cf705b9-1fca-2445-43de-916b13b9103f@xs4all.nl>
 <20201014083758.GB31728@amd>
 <d8e450ef-cde9-b799-88e9-8ed9940b95fe@xs4all.nl>
X-Mailer: Claws Mail 3.17.6 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Virus-Scanned: clamav-milter 0.102.2 at mail
X-Virus-Status: Clean
X-Mailman-Approved-At: Wed, 21 Oct 2020 15:37:33 +0200
Cc: moderated for non-subscribers <alsa-devel@alsa-project.org>,
 Takashi Iwai <tiwai@suse.de>, Randy Dunlap <rdunlap@infradead.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 Dan Murphy <dmurphy@ti.com>, Pavel Machek <pavel@ucw.cz>,
 linux-leds@vger.kernel.org
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

On Mon, 19 Oct 2020 10:35:12 +0200
Udo van den Heuvel <udovdh@xs4all.nl> wrote:

> People,
> 
> At https://www.kernel.org/doc/html/latest/leds/leds-class.html we can
> read that the LEDS code supposedly optimizes away when certain
> conditions are met.
> Especially the Realtek HDA driver *unconditionally* (as found in
> 5.9.1) *wants* to enable LED functionality.
> I.e.: if this blockade is lifted in the source tree then I can live
> with the 'is optimized out' predictions, assuming that gcc (from
> Fedora 32) can do this.
> So the request is clear; we're almost there.
> Please make it so that the compiler can do the 'optimize away' work
> bij changing a tad in the Realtek HDA driver, along the lines of the
> patch sent to me earlier or something even more beautiful.
> 
> Thanks in advance and kind regards,
> Udo

Udo,

The documentation says that LED trigger code optimises away, not LED
core.

But yes, something similar could maybe be done for the whole LED
class... (maybe!)

BTW, you are welcome to propose a patch as well, since it seems that
nobody else is interested as much as you are in this :)

Marek
