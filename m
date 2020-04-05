Return-Path: <SRS0=oqyN=5V=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 33D01C2BA1E
	for <alsa-devel@archiver.kernel.org>; Sun,  5 Apr 2020 01:28:49 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B6EBE2072B
	for <alsa-devel@archiver.kernel.org>; Sun,  5 Apr 2020 01:28:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="YJuXCbQE"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B6EBE2072B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=rowland.harvard.edu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id F187C1660;
	Sun,  5 Apr 2020 03:27:56 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz F187C1660
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1586050127;
	bh=5VQx0G+uwQNpv2Av9QIWs7ER47KUrP63pPv57SzKFTo=;
	h=Date:From:To:Subject:In-Reply-To:Cc:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:From;
	b=YJuXCbQEM/55SgkZIGSBYal7f0TQlll8jVKRtL31sYXuv9nvr2Q/BHHQJp3f6GzDC
	 slHJFkr2PHrPDoUGalUbiIF5BHvXzZUGcMK3jsi9+9EJ3XN+y4ilG9nN98NdaWeHj6
	 8e8FPzkEUSTiLwlQFVXFxQKoQy2cq7nh+CG3yUrQ=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 66100F80146;
	Sun,  5 Apr 2020 03:27:56 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 31ADAF80148; Sun,  5 Apr 2020 03:27:54 +0200 (CEST)
Received: from netrider.rowland.org (netrider.rowland.org [192.131.102.5])
 by alsa1.perex.cz (Postfix) with SMTP id 4D622F800E4
 for <alsa-devel@alsa-project.org>; Sun,  5 Apr 2020 03:27:44 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 4D622F800E4
Received: (qmail 25974 invoked by uid 500); 4 Apr 2020 21:27:42 -0400
Received: from localhost (sendmail-bs@127.0.0.1)
 by localhost with SMTP; 4 Apr 2020 21:27:42 -0400
Date: Sat, 4 Apr 2020 21:27:42 -0400 (EDT)
From: Alan Stern <stern@rowland.harvard.edu>
X-X-Sender: stern@netrider.rowland.org
To: Ruslan Bilovol <ruslan.bilovol@gmail.com>
Subject: Re:
In-Reply-To: <CAB=otbS1RTnn9PixJYjsW4U_37GcFvR-O3WZ-7YnamdcDGKvRA@mail.gmail.com>
Message-ID: <Pine.LNX.4.44L0.2004042124390.25831-100000@netrider.rowland.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: alsa-devel@alsa-project.org, Linux USB <linux-usb@vger.kernel.org>,
 Colin Williams <colin.williams.seattle@gmail.com>
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

On Sun, 5 Apr 2020, Ruslan Bilovol wrote:

> Hi,
> 
> Please also add to CC related mailing lists (alsa-devel, linux-usb) rather
> then directly emailing - community may also help with the issue. Also it can be
> googled so if somebody else have same issue it can find answers faster.
> 
> On Fri, Apr 3, 2020 at 10:56 AM Colin Williams
> <colin.williams.seattle@gmail.com> wrote:
> >
> > https://ubuntuforums.org/showthread.php?t=2439897
> >
> > On Thu, Apr 2, 2020 at 4:50 PM Colin Williams <colin.williams.seattle@gmail.com> wrote:
> >>
> >> Hello,
> >>
> >> Is it possible that one of these commits or related broke support for the Blue Mic Yeti?
> >>
> >> https://github.com/torvalds/linux/blame/ac438771ccb4479528594c7e19f2c39cf1814a86/sound/usb/stream.c#L816
> 
> Tha'ts workaround to ignore last altsetting which is the same as previous.
> During UAC3 implementation, I reimplemented that workaround carefully,
> but I didn't have (and still do not own) any Blue Mic USB device.
> I don't know whether it was tested after that by anyone.
> 
> >>
> >> I am getting the following when I plug my mic in:
> 
> Which kernel version is that? Have you tried latest Linux Kernel?
> 
> >>
> >> [ 1283.848740] usb 1-1.2: new full-speed USB device number 82 using ehci-pci
> >> [ 1283.964802] usb 1-1.2: New USB device found, idVendor=b58e, idProduct=9e84, bcdDevice= 1.00
> >> [ 1283.964808] usb 1-1.2: New USB device strings: Mfr=1, Product=2, SerialNumber=0
> >> [ 1283.964810] usb 1-1.2: Product: Yeti Stereo Microphone
> >> [ 1283.964812] usb 1-1.2: Manufacturer: Blue Microphones
> >> [ 1284.080671] usb 1-1.3: new low-speed USB device number 83 using ehci-pci
> >> [ 1284.784678] usb 1-1.3: device descriptor read/64, error -32
> >> [ 1285.180674] usb 1-1.3: device descriptor read/64, error -32
> >> [ 1285.992682] usb 1-1.3: new low-speed USB device number 84 using ehci-pci
> >> [ 1286.696672] usb 1-1.3: device descriptor read/64, error -32
> >> [ 1287.092695] usb 1-1.3: device descriptor read/64, error -32
> >> [ 1287.200804] usb 1-1-port3: attempt power cycle
> >> [ 1287.804662] usb 1-1.3: new low-speed USB device number 85 using ehci-pci
> >> [ 1288.220686] usb 1-1.3: device not accepting address 85, error -32
> >> [ 1288.508685] usb 1-1.3: new low-speed USB device number 86 using ehci-pci
> >> [ 1288.924690] usb 1-1.3: device not accepting address 86, error -32
> >> [ 1288.924916] usb 1-1-port3: unable to enumerate USB device
> >> [ 1288.925391] usb 1-1.2: USB disconnect, device number 82
> >> [ 1289.308736] usb 1-1.3: new low-speed USB device number 87 using ehci-pci
> >> [ 1289.596727] usb 1-1.3: device descriptor read/64, error -32
> >> [ 1289.992635] usb 1-1.3: device descriptor read/64, error -32
> >> [ 1290.596683] usb 1-1.3: new low-speed USB device number 88 using ehci-pci
> >> [ 1290.888718] usb 1-1.3: device descriptor read/64, error -32
> >> [ 1291.284673] usb 1-1.3: device descriptor read/64, error -32
> >> [ 1291.392928] usb 1-1-port3: attempt power cycle
> 
> Looking at this log, it seems the issue happens during enumeration,
> so mentioned workaround isn't executed yet at this moment.
> So it seems this is related to USB core, not to ALSA driver.

All those errors were for the 1-1.3 device.  The microphone was 1-1.2.
It's not clear from the log above what the relationship between those 
two devices is, but it sure looks like the microphone was enumerated 
okay.

What shows up in /sys/kernel/debug/usb/devices?

Alan Stern

