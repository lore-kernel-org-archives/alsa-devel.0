Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 25BD8C433F5
	for <alsa-devel@archiver.kernel.org>; Tue, 22 Mar 2022 18:04:02 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 76C3616DE;
	Tue, 22 Mar 2022 19:03:10 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 76C3616DE
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1647972240;
	bh=z9IOlF4mySUenpQ0Cg444rtrc/A+3gqsjt9sjklrqkk=;
	h=Date:From:To:Subject:References:In-Reply-To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=alSTcFGisDn8XG5wUn0QtZmJ0O4UTLLd/N1CHxDHVwFA8uqdcTZq9xUgv6zJUfca1
	 2NPcSub26PYerrK8jl6tXTziY/rrQHE0TGKWGH6BExIEZB8AM6lFuXYz3U+3o5hdnC
	 O0i/J9UjB8Q2RWE/J6vFrzZC6g8ifuYVDZLmlNNo=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 0A556F800FD;
	Tue, 22 Mar 2022 19:03:10 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id B1C0BF8016C; Tue, 22 Mar 2022 19:03:08 +0100 (CET)
Received: from netrider.rowland.org (netrider.rowland.org [192.131.102.5])
 by alsa1.perex.cz (Postfix) with SMTP id 3FC67F80116
 for <alsa-devel@alsa-project.org>; Tue, 22 Mar 2022 19:03:02 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 3FC67F80116
Received: (qmail 132790 invoked by uid 1000); 22 Mar 2022 14:03:00 -0400
Date: Tue, 22 Mar 2022 14:03:00 -0400
From: Alan Stern <stern@rowland.harvard.edu>
To: Petr Janecek <janecek@ucw.cz>
Subject: Re: Apogee ONEv2 keeps resetting
Message-ID: <YjoPVAxeKtY6aV1s@rowland.harvard.edu>
References: <3f4d1bce-7459-9ea4-be73-9b51f569e526@ucw.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3f4d1bce-7459-9ea4-be73-9b51f569e526@ucw.cz>
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

On Sun, Mar 20, 2022 at 02:15:40AM +0100, Petr Janecek wrote:
> Hi,
>    I'm trying to use Apogee ONEv2.  From usb dumps under
> macos or windows it seems like a usb Class Audio 2.0
> device, but in linux, it keeps resetting every two seconds
> or so.  It keeps resetting even when the snd-usb-audio
> driver is disabled, so the problem is probably at a lower
> level.

Can you post the log output on a system where snd-usb-audio is disabled?

>   The messages below are from v5.16.16, but it behaves
> the same no matter what I plug it into.
> 
> [  253.708616] usb 3-8: new high-speed USB device number 6 using xhci_hcd
> [  253.899363] usb 3-8: New USB device found, idVendor=0c60, idProduct=0017,
> bcdDevice= 1.05
> [  253.899370] usb 3-8: New USB device strings: Mfr=1, Product=2,
> SerialNumber=3
> [  253.899373] usb 3-8: Product: ONEv2
> [  253.899375] usb 3-8: Manufacturer: Apogee
> [  253.899377] usb 3-8: SerialNumber: 0C12FF2020204652334D513A7A2A9B
> [  253.960901] mc: Linux media interface: v0.10

Any idea where that line came from?

You should try capturing a usbmon trace showing what happens when the 
device is plugged in and then resets.  Preferably on a system where 
snd-usb-audio is disabled.

One other thing you might try: Disable runtime PM for USB ("echo -1 
>/sys/module/usbcore/parameters/autosuspend" before plugging in the 
device).

Alan Stern
