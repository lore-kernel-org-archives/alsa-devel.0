Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A105FCDB465
	for <alsa-devel@archiver.kernel.org>; Mon, 16 Oct 2023 12:34:32 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 0EA8D84B;
	Mon, 16 Oct 2023 14:33:40 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 0EA8D84B
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1697459670;
	bh=nn/9q/RI7b7UUmwVECjvU4vR89lGGwSB/WS/OzwZgzg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-Id:
	 List-Archive:List-Help:List-Owner:List-Post:List-Subscribe:
	 List-Unsubscribe:From;
	b=mPa7Xq0AOqxDROx9H4qPFe6fYLhxe944pZaPxeWjQhlHudXZFO8z0iSy7+m8CtPu3
	 pdWEeZ7ZlPcmEJuvF6prnIyhm1U3CJvOuB9bRSg/W6uYPx9ug0jubOhN0IWeoWwmbL
	 nYNiKaRrDfMD3IMtgZZsbjVJ1UwZzl4NBwWlucaI=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 20F00F80564; Mon, 16 Oct 2023 14:33:01 +0200 (CEST)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id 9E9F3F80557;
	Mon, 16 Oct 2023 14:33:00 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id CDE04F80567; Mon, 16 Oct 2023 14:32:55 +0200 (CEST)
Received: from m.b4.vu (m.b4.vu [203.16.231.148])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest
 SHA256)
	(No client certificate requested)
	by alsa1.perex.cz (Postfix) with ESMTPS id 83270F80557
	for <alsa-devel@alsa-project.org>; Mon, 16 Oct 2023 14:32:48 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 83270F80557
Received: by m.b4.vu (Postfix, from userid 1000)
	id AB43B6147B95; Mon, 16 Oct 2023 23:02:42 +1030 (ACDT)
Date: Mon, 16 Oct 2023 23:02:42 +1030
From: "Geoffrey D. Bennett" <g@b4.vu>
To: Jaroslav Kysela <perex@perex.cz>
Cc: Takashi Iwai <tiwai@suse.com>, alsa-devel@alsa-project.org
Subject: Re: [PATCH RFC] ALSA: scarlett2: Add ioctls for user-space access
Message-ID: <ZS0tajzKr68CZ5uA@m.b4.vu>
References: <ZSqehHhedJQY9h/1@m.b4.vu>
 <76c1526d-78be-92d2-cf2b-148278394575@perex.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <76c1526d-78be-92d2-cf2b-148278394575@perex.cz>
Message-ID-Hash: RP3SAR5P5MONKGASK4W7EHUOEYC6J4Z6
X-Message-ID-Hash: RP3SAR5P5MONKGASK4W7EHUOEYC6J4Z6
X-MailFrom: g@b4.vu
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency;
 loop; banned-address; member-moderation;
 header-match-alsa-devel.alsa-project.org-0;
 header-match-alsa-devel.alsa-project.org-1; nonmember-moderation;
 administrivia; implicit-dest; max-recipients; max-size; news-moderation;
 no-subject; digests; suspicious-header
X-Mailman-Version: 3.3.8
Precedence: list
List-Id: "Alsa-devel mailing list for ALSA developers -
 http://www.alsa-project.org" <alsa-devel.alsa-project.org>
Archived-At: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/RP3SAR5P5MONKGASK4W7EHUOEYC6J4Z6/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

On Mon, Oct 16, 2023 at 09:04:21AM +0200, Jaroslav Kysela wrote:
> On 14. 10. 23 15:58, Geoffrey D. Bennett wrote:
> > In order to support functions such as firmware upgrade from
> > user-space, add ioctls for submitting arbitrary proprietary requests
> > through scarlett2_usb() and requesting/releasing exclusive access.
> > ---
> > 
> > Hi Takashi,
> > 
> > I recently figured how to update the firmware on Scarlett Gen 2+
> > devices. I think the best way to implement this is with an ioctl
> > giving access to the scarlett2_usb() function from user-space, plus
> > two ioctls to request/release exclusive access.
> > 
> > Does something like this seem reasonable?
> 
> Maybe you can use libusb for this job without an additional kernel
> interface. It allows to detach the USB kernel driver and attach it again
> when the job is complete.

Hi Jaroslav,

I considered using libusb (I used it during initial development of the
driver), and if the only purpose of the ioctl would be for firmware
updates then it would be reasonable to detach the kernel driver for
that. However...

Beyond just being able to do firmware operations, that ioctl would
also allow access to all of the configuration space using cmd =
SCARLETT2_USB_GET_DATA and SCARLETT2_USB_SET_DATA. I think this would
be the cleanest way to allow implementing non-mixer related
functionality in user-space, such as reading the current firmware
version, reading/updating the device name and channel names, and
updating the software configuration space for Focusrite Control
compatibility to name a few. These sorts of applications need to be
able to make these proprietary requests through the scarlett2 driver
to avoid disrupting it (or disrupting audio).

Regards,
Geoffrey.
