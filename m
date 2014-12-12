From: =?UTF-8?Q?Johan_Aires_Rast=C3=A9n?= <johan@oljud.se>
Subject: Re: Audio USB disappears suddenly
Date: Fri, 12 Dec 2014 08:17:18 +0100
Message-ID: <CAMFLXsDCfmsFKD1d8uvk45_XaHo=_PEXqSmrkZuiVBWbttfjsA@mail.gmail.com>
References: <CAM4quvZC3L_mcQtt3giUjUqVnN1N1A05m=fP379xh61TDi_-mg@mail.gmail.com>
 <5488A6FE.5080308@ladisch.de>
 <CAM4quvbxLf8ROk3WXjrgoxffsRm4UReSsCuMaMkB8q+uYzWMSA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-ie0-f182.google.com (mail-ie0-f182.google.com
 [209.85.223.182])
 by alsa0.perex.cz (Postfix) with ESMTP id 8D246265317
 for <alsa-devel@alsa-project.org>; Fri, 12 Dec 2014 08:17:19 +0100 (CET)
Received: by mail-ie0-f182.google.com with SMTP id x19so6371407ier.27
 for <alsa-devel@alsa-project.org>; Thu, 11 Dec 2014 23:17:18 -0800 (PST)
In-Reply-To: <CAM4quvbxLf8ROk3WXjrgoxffsRm4UReSsCuMaMkB8q+uYzWMSA@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: mobidyc <mobidyc@gmail.com>
Cc: alsa-devel@alsa-project.org, Clemens Ladisch <clemens@ladisch.de>
List-Id: alsa-devel@alsa-project.org

Please try the following commands when the card is recently plugged in and
working and post the output:

lsusb -d 249c:9313 -v

amixer -c 1 contents

Assuming 249c:9313 is your card's ID and that it's still enumerated as card
1 in your system. The output from lsusb might be very long so it could be
better to use pastebin.com or similar.

//Johan

On 11 December 2014 at 01:13, mobidyc <mobidyc@gmail.com> wrote:
>
> Thanks for this information,
>
> I think it's time to contact the manufacturer.
>
> Do you know if I can take some relevant traces (kernel module to load,
> /proc/asound file to parse, anything else)?
> so I can detail my email to him.
>
> Thanks.
>
> --
> Mobidyc
>
> 2014-12-10 21:03 GMT+01:00 Clemens Ladisch <clemens@ladisch.de>:
>
> > mobidyc wrote:
> > > USB DAC suddenly disappears, from dmesg I can see:
> > >
> > > [13083.161157] usb 1-1.3: 1:2: usb_set_interface failed (-110)
> > > [13083.316344] usb 1-1.3: 1:2: usb_set_interface failed (-71)
> > > [13083.471927] usb 1-1.3: 1:2: usb_set_interface failed (-71)
> > > [13083.789810] usb 1-1.3: 1:2: usb_set_interface failed (-71)
> >
> > These error codes indicate that the device's firmware does not react at
> > all.  Either the firmware has locked up due to a bug, or the hardware
> > has shut down for some reason.
> >
> >
> > Regards,
> > Clemens
> >
> _______________________________________________
> Alsa-devel mailing list
> Alsa-devel@alsa-project.org
> http://mailman.alsa-project.org/mailman/listinfo/alsa-devel
>
