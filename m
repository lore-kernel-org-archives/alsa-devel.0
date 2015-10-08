From: "Keith A. Milner" <maillist@superlative.org>
Subject: Re: Boss GT-001
Date: Thu, 08 Oct 2015 15:03:15 +0100
Message-ID: <2785415.8nT9MSXHrq@kamdesktop>
References: <1481883.Y22cmGKEIB@kamdesktop>
 <alpine.DEB.2.02.1510080849080.30181@lnxricardw1.se.axis.com>
 <53501158.2GJHLGgpfJ@kamdesktop>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-wi0-f172.google.com (mail-wi0-f172.google.com
 [209.85.212.172])
 by alsa0.perex.cz (Postfix) with ESMTP id 46FAD261A76
 for <alsa-devel@alsa-project.org>; Thu,  8 Oct 2015 16:03:18 +0200 (CEST)
Received: by wicge5 with SMTP id ge5so27353477wic.0
 for <alsa-devel@alsa-project.org>; Thu, 08 Oct 2015 07:03:18 -0700 (PDT)
Received: from kamdesktop.localnet ([2001:8b0:be0a:29af::201])
 by smtp.gmail.com with ESMTPSA id he3sm46431254wjc.48.2015.10.08.07.03.16
 for <alsa-devel@alsa-project.org>
 (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
 Thu, 08 Oct 2015 07:03:16 -0700 (PDT)
In-Reply-To: <53501158.2GJHLGgpfJ@kamdesktop>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On Thursday 08 Oct 2015 12:51:54 Keith A. Milner wrote:

> I have some usbmon dumps which I will try to find time to analyze.
> 

Well the results of my packet dumps were interesting.

For audio playback, I noticed the Windows drive seemed to enable the IN 
endpoint (EP 14) as well as the OUT one (EP 13). This seemed to match with the 
view that explicit feedback is required for asynchronous host-to-device 
transfers.

So I've changed the quirk as follows, which appears to work for playback 
still:

.ep_attr = 0x15,

This is USB_ENDPOINT_USAGE_FEEDBACK + USB_ENDPOINT_SYNC_ASYNC + 
USB_ENDPOINT_XFER_ISOC

I say works "still" because the previous value I had (0x01) worked as well. 
However, this was basically setting the sync type to NONE instead of ASYNC, 
and didn't configure any feedback type. This was probably free-running and, 
effectively, similar to "ADAPTIVE", but is probably prone to occasional sync 
problems/buffer overflows on the device.

The resulting usbmon dump seems to follow the one from Windows now.

Input is still a problem!

Under ALSA, the input stream (via URB_ISOCHRONOUS in requests/responses) to IN 
endpoint 14 seems to be working. However, under Windows the driver also 
initiates the OUT endpoint 13 which then has an output stream  (via 
URB_ISOCHRONOUS out requests/responses).

I don't know if this is required by the device for some reason (explicit 
feedback, although that doesn't make much sense to me?) or if it's just 
something irrelevant that the Windows driver happens to do.

Either way, Linux seems to get stuck with the input data (for instance, the 
playhead in Audacity doesn't move).

Cheers,

Keith
