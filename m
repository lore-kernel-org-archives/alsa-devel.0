From: Raymond Yau <superquad.vortex2@gmail.com>
Subject: Re: Trying to enable digital audio output - Intel HDA
	- AD1983
Date: Tue, 17 Jun 2014 19:39:31 +0800
Message-ID: <CAN8ccibK5C4Ns1=pFjspqncJGCs9Xq8gt4r3Wy=3E88w7jenmw@mail.gmail.com>
References: <CAK_KU4a90_WVjFhbHXfOKN4gZqLyugSER+XPSnYpkdAviA6EhQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-qc0-f176.google.com (mail-qc0-f176.google.com
 [209.85.216.176])
 by alsa0.perex.cz (Postfix) with ESMTP id D216526557B
 for <alsa-devel@alsa-project.org>; Tue, 17 Jun 2014 13:39:32 +0200 (CEST)
Received: by mail-qc0-f176.google.com with SMTP id w7so8505667qcr.21
 for <alsa-devel@alsa-project.org>; Tue, 17 Jun 2014 04:39:32 -0700 (PDT)
In-Reply-To: <CAK_KU4a90_WVjFhbHXfOKN4gZqLyugSER+XPSnYpkdAviA6EhQ@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Scott D'Vileskis <sdvileskis@gmail.com>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

> I have a Lenovo M55 SFF desktop I use for a media center computer
> (XBMCbuntu). It has the AD1983 chip on it. From the factory, it had 2
> ports in the back (mic + speaker) , and 2 ports in the front (mic +
> speaker). It also has an on-board speaker.
>
> It never shipped with a SPDIF output, but I soldered a wire to the
> AD1983 and installed an RCA jack on the back of the case. Earlier
> versions of XBMC shipped with a different version of alsa, and I was
> able to use this custom SPDIF output without issue for the last year
> or two, but the current version only enables the 'proper'
> inputs/outputs
>
> I have tried editing the module options and specifying several
> different models, but the documentation doesn't list any 'model'
> options for the AD1983.
>
> I suspect I need to overwrite the pin configs.
> cat init_pin_configs:
> 0x05 0x01014010
> 0x06 0x0221401f
> 0x07 0x991301f0
> 0x08 0x02a19020
> 0x09 0x0181302e
> 0x0a 0x414511f0

Node 0x0a [Pin Complex] wcaps 0x400301: Stereo Digital
  Pincap 0x00000010: OUT
  Pin Default 0x414511f0: [N/A] SPDIF Out at Ext Rear
    Conn = Optical, Color = Black
    DefAssociation = 0xf, Sequence = 0x0
    Misc = NO_PRESENCE
  Pin-ctls: 0x40: OUT
  Connection: 1
     0x02

Use hda-jack-retask or early patching to change pin default of node 0x0a
from [N/A] to [JACK]
