From: Daniel Mack <zonque@gmail.com>
Subject: Re: usb-audio: Reloop Play support (TI TUSB3200AC)
Date: Fri, 19 Oct 2012 15:20:30 +0200
Message-ID: <5081539E.40705@gmail.com>
References: <1350652166.5549.8.camel@didier-laptop>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-bk0-f51.google.com (mail-bk0-f51.google.com
 [209.85.214.51])
 by alsa0.perex.cz (Postfix) with ESMTP id 08BA4265351
 for <alsa-devel@alsa-project.org>; Fri, 19 Oct 2012 15:20:32 +0200 (CEST)
Received: by mail-bk0-f51.google.com with SMTP id e19so183570bku.38
 for <alsa-devel@alsa-project.org>; Fri, 19 Oct 2012 06:20:32 -0700 (PDT)
In-Reply-To: <1350652166.5549.8.camel@didier-laptop>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Didier 'Ptitjes' Villevalois <ptitjes@free.fr>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On 19.10.2012 15:09, Didier 'Ptitjes' Villevalois wrote:
> Hello,
> 
> I've bought a Reloop Play usb soundcard and I'd like to make it work
> with ALSA.
> 
> It is a 4-channels USB soundcard. It is currently correctly recognized
> by ALSA as a 4-channels soundcard and I can correctly open the channels
> and feed them with audio. However, no audio is output by the box.

You're most probably affected by a regression in the driver that was
fixes in 3.6.0 and 3.5.5 (and all later kernels). Could you please try
one of these and tell us if that works?

> It seems to contain a Texas Instrument TUSB3200AC chipset (same chipset
> as the Maya44 USB and Hercules DJ console). I guess the problem is a
> firmware problem but I don't know what to do about it.
> 
> I've got a MacOS X driver that works correctly, if that of any help. (I
> suppose the Windows driver works too but I don't have any Windows at
> hand.)

Did you install any vendor driver on OS X or does it just work with the
one that ships with the OS?


Daniel
