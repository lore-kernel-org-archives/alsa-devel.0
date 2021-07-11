Return-Path: <SRS0=hvs4=MD=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 852C3C07E96
	for <alsa-devel@archiver.kernel.org>; Sun, 11 Jul 2021 14:56:20 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B3D08601FD
	for <alsa-devel@archiver.kernel.org>; Sun, 11 Jul 2021 14:56:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B3D08601FD
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=rowland.harvard.edu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 75FCE1658;
	Sun, 11 Jul 2021 16:55:26 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 75FCE1658
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1626015376;
	bh=V4UXWswHWjlNuQUexbS5A3tQAL5mKwwjDvcIYpcWlvQ=;
	h=Date:From:To:Subject:References:In-Reply-To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=H6hOpx8cf/4IPph+qQ6bN7abdIWrjTY8hKPkEg5Qu00ybo3A9ERikrPPd5743fxv3
	 kmQsziwCx0Uxpbo5jruHGt6UiFP0PHyXpJ1tMKIFrSKsVzq3CG5ikTBJMiYRo9Xnib
	 ko18DzDBEngzxuUvT20wTT2HDu2Bkv+2nf8OdclU=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id DEBC0F8013D;
	Sun, 11 Jul 2021 16:55:25 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 36132F80217; Sun, 11 Jul 2021 16:55:21 +0200 (CEST)
Received: from netrider.rowland.org (netrider.rowland.org [192.131.102.5])
 by alsa1.perex.cz (Postfix) with SMTP id D901AF8013D
 for <alsa-devel@alsa-project.org>; Sun, 11 Jul 2021 16:54:33 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz D901AF8013D
Received: (qmail 294122 invoked by uid 1000); 11 Jul 2021 10:54:29 -0400
Date: Sun, 11 Jul 2021 10:54:29 -0400
From: Alan Stern <stern@rowland.harvard.edu>
To: Tristan Miller <psychonaut@nothingisreal.com>
Subject: Re: "Chipmunk audio" on Logitech USB webcams
Message-ID: <20210711145429.GA293743@rowland.harvard.edu>
References: <20210711102503.179b154b.psychonaut@nothingisreal.com>
 <YOrKFIlEHopiVKJT@kroah.com>
 <20210711141546.0ac1eec7.psychonaut@nothingisreal.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210711141546.0ac1eec7.psychonaut@nothingisreal.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Cc: alsa-devel@alsa-project.org, linux-usb@vger.kernel.org
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

On Sun, Jul 11, 2021 at 02:15:46PM +0200, Tristan Miller wrote:
> Greetings.
> 
> On Sun, 11 Jul 2021 12:38:12 +0200, Greg KH
> <gregkh@linuxfoundation.org> wrote:
> > On Sun, Jul 11, 2021 at 10:25:03AM +0200, Tristan Miller wrote:
> > > Many models of Logitech USB webcams malfunction under Linux by
> > > producing audio that sounds distorted, garbled, or high-pitched.
> > > For most users, the problem happens randomly, and can usually be
> > > worked around by restarting the audio application or by unplugging
> > > the webcam and then plugging it back in again.
> > 
> > Please report the information directly here, to this list, and to the
> > sound developers at alsa-devel@alsa-project.org and we can all work to
> > resolve this.
> 
> The problem as I'm currently experiencing it is as follows:
> 
> I have a Logitech C270 USB webcam running on openSUSE Tumbleweed for
> x86_64 with the 5.13.0 kernel.  Sometimes audio recorded by the
> camera's built-in microphone sounds artificially high-pitched and
> garbled.  I've experienced this with lots of different applications,
> including arecord, Skype, and various browser-based videoconferencing
> software running in Firefox or Chromium.  The problem occurs rarely
> (maybe once every 30 times I use the webcam microphone) and seemingly
> at random; restarting the audio application or unplugging the webcam
> and plugging it back in again usually works around the issue.  So
> unfortunately I can't reliably reproduce the problem.  I haven't
> noticed any errors in the system logs but then again am not sure exactly
> what to look for and where. I've been experiencing this problem at
> least as far back as kernel 4.13.12.
> 
> Some further details (more available on request):
> 
> # uname -a
> Linux butterfield.nothingisreal.com 5.13.0-1-default #1 SMP Fri Jul 2 05:54:32 UTC 2021 (aa40472) x86_64 x86_64 x86_64 GNU/Linux
> 
> # lsusb -s 001:004 -v |head -17
> Bus 001 Device 004: ID 046d:0825 Logitech, Inc. Webcam C270
> Device Descriptor:
>   bLength                18
>   bDescriptorType         1
>   bcdUSB               2.00
>   bDeviceClass          239 Miscellaneous Device
>   bDeviceSubClass         2 
>   bDeviceProtocol         1 Interface Association
>   bMaxPacketSize0        64
>   idVendor           0x046d Logitech, Inc.
>   idProduct          0x0825 Webcam C270
>   bcdDevice            0.10
>   iManufacturer           0 
>   iProduct                0 
>   iSerial                 2 6457F4D0
>   bNumConfigurations
> 
> Previous reports which apparently cover the same problem:

Some additional details about these bug reports:

> https://bugzilla.kernel.org/show_bug.cgi?id=35922

This is a completely different bug, which was fixed back in 2011.

> https://bugzilla.kernel.org/show_bug.cgi?id=44281

This report mentions three separate bugs, the first of which was 
fixed in 2012.  The bug discussed here is the third one in the 
report.

> https://bugzilla.kernel.org/show_bug.cgi?id=105081

This is a repeat of the second bug in #44281.

> https://bugzilla.kernel.org/show_bug.cgi?id=203763

This is the same as the bug discussed here.

> https://bugs.launchpad.net/ubuntu/+source/linux/+bug/459445

This is the same as the second bug in #44281.

> https://bugs.launchpad.net/ubuntu/+source/linux/+bug/843431

At first glance this seems to be the same as the bug discussed here, 
but this one was fixed in 2011.

> https://bugs.launchpad.net/ubuntu/+source/linux/+bug/884210

This is the same as the second bug in #44281.

> https://bugs.launchpad.net/ubuntu/+source/linux/+bug/1018020

This seems to be a combination of the first and second bugs in 
#44281.

The rest of these appear to be mixtures of the bugs mentioned above.

> https://bugzilla.suse.com/show_bug.cgi?id=736093
> https://bugzilla.redhat.com/show_bug.cgi?id=729269
> https://bugzilla.redhat.com/show_bug.cgi?id=742010
> https://bugs.archlinux.org/task/26528
> https://bbs.archlinux.org/viewtopic.php?id=121607
> https://bbs.archlinux.org/viewtopic.php?id=236056
> https://forums.linuxmint.com/viewtopic.php?t=237677

Alan Stern
