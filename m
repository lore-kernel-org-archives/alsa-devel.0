From: mobidyc <mobidyc@gmail.com>
Subject: Re: Audio USB disappears suddenly
Date: Thu, 11 Dec 2014 01:13:22 +0100
Message-ID: <CAM4quvbxLf8ROk3WXjrgoxffsRm4UReSsCuMaMkB8q+uYzWMSA@mail.gmail.com>
References: <CAM4quvZC3L_mcQtt3giUjUqVnN1N1A05m=fP379xh61TDi_-mg@mail.gmail.com>
 <5488A6FE.5080308@ladisch.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-la0-f48.google.com (mail-la0-f48.google.com
 [209.85.215.48])
 by alsa0.perex.cz (Postfix) with ESMTP id E8C1426063E
 for <alsa-devel@alsa-project.org>; Thu, 11 Dec 2014 01:13:43 +0100 (CET)
Received: by mail-la0-f48.google.com with SMTP id gf13so3319286lab.7
 for <alsa-devel@alsa-project.org>; Wed, 10 Dec 2014 16:13:43 -0800 (PST)
In-Reply-To: <5488A6FE.5080308@ladisch.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Clemens Ladisch <clemens@ladisch.de>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Thanks for this information,

I think it's time to contact the manufacturer.

Do you know if I can take some relevant traces (kernel module to load,
/proc/asound file to parse, anything else)?
so I can detail my email to him.

Thanks.

--
Mobidyc

2014-12-10 21:03 GMT+01:00 Clemens Ladisch <clemens@ladisch.de>:

> mobidyc wrote:
> > USB DAC suddenly disappears, from dmesg I can see:
> >
> > [13083.161157] usb 1-1.3: 1:2: usb_set_interface failed (-110)
> > [13083.316344] usb 1-1.3: 1:2: usb_set_interface failed (-71)
> > [13083.471927] usb 1-1.3: 1:2: usb_set_interface failed (-71)
> > [13083.789810] usb 1-1.3: 1:2: usb_set_interface failed (-71)
>
> These error codes indicate that the device's firmware does not react at
> all.  Either the firmware has locked up due to a bug, or the hardware
> has shut down for some reason.
>
>
> Regards,
> Clemens
>
