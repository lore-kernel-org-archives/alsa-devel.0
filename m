From: "Keith A. Milner" <maillist@superlative.org>
Subject: Re: Boss GT-001
Date: Thu, 08 Oct 2015 15:10:03 +0100
Message-ID: <2169905.Ah2pGDNdB3@kamdesktop>
References: <1481883.Y22cmGKEIB@kamdesktop>
 <alpine.DEB.2.02.1510080849080.30181@lnxricardw1.se.axis.com>
 <561675A6.8000202@ladisch.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-wi0-f169.google.com (mail-wi0-f169.google.com
 [209.85.212.169])
 by alsa0.perex.cz (Postfix) with ESMTP id B5A4F261A76
 for <alsa-devel@alsa-project.org>; Thu,  8 Oct 2015 16:10:06 +0200 (CEST)
Received: by wiclk2 with SMTP id lk2so30362333wic.0
 for <alsa-devel@alsa-project.org>; Thu, 08 Oct 2015 07:10:05 -0700 (PDT)
In-Reply-To: <561675A6.8000202@ladisch.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Clemens Ladisch <clemens@ladisch.de>, Ricard Wanderlof <ricard.wanderlof@axis.com>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On Thursday 08 Oct 2015 15:54:46 Clemens Ladisch wrote:

> In theory, the driver supports this, but there are known to be some
> bugs. And in any case there should be no problem getting the capture
> stream to start (it's the playback stream that would have a slightly
> wrong sample clock);

Thanks Clemens,

That was my reading of it too. My latest quirk tests for playback use explicit 
feedback, which seems to mirror what the Windows driver does.

I'm still having no luck with recording though.

> it's possible that this device needs some vendor-
> specific commands, or a different order of commands. (The interesting
> USB transactions would be everything except the isochronous ones.)

I've been looking at the usbmon dumps I have of recording under Windows and I 
don't see anything that stands out, but I'll keep looking.

Cheers,

Keith
