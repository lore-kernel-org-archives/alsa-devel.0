From: Pete Leigh <pete.leigh@gmail.com>
Subject: Re: Fwd: Support for Roland VG-99 (working code,
 but could use help)
Date: Tue, 16 Oct 2012 09:31:03 +0100
Message-ID: <CABn3OEF1L7hqVAcjs5E5NveA741HPVd4a9eq0w9sS77PYg+2hQ@mail.gmail.com>
References: <CABn3OEFatrnhGs1xzpmOfXSxpSLuGwgRtN8v=1B96i6=7_9vTg@mail.gmail.com>
 <CABn3OEHRK7TLp+J_pZjMoFts4bZ=-FquQX0WKCzUcaaMZ8Nrpg@mail.gmail.com>
 <507D0F6D.1000102@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-ie0-f179.google.com (mail-ie0-f179.google.com
 [209.85.223.179])
 by alsa0.perex.cz (Postfix) with ESMTP id E11A5261708
 for <alsa-devel@alsa-project.org>; Tue, 16 Oct 2012 10:31:04 +0200 (CEST)
Received: by mail-ie0-f179.google.com with SMTP id c10so9059530ieb.38
 for <alsa-devel@alsa-project.org>; Tue, 16 Oct 2012 01:31:04 -0700 (PDT)
In-Reply-To: <507D0F6D.1000102@gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Daniel Mack <zonque@gmail.com>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Hi Daniel, thanks for taking the time..

On 16 October 2012 08:40, Daniel M

> are you sure 44100 is the only supported sample rate?

Yep, the manual is pretty clear about that. Also,
http://www.rolandus.com/products/details/849 in the "specs" section.

>>  the device name no longer shows up in lsusb output [...]
> lsusb -v should still show it

Hmm... and now it's there! I guess I must have missed it.

>  For the normal output, you could submit
> an entry here: http://www.linux-usb.org/usb-ids.html

Right! I've just done that - the id comes up differently for the two
"driver modes", so I put both in.

> Check out the latestes sound.git[*] and make sure your patch applies
> there. Also note that the entries in this file are sorted by VID/PID.

Ok, I'll give this a shot.. Does the quirk definition look sane? Is it
worth showing the lsusb -v output with that patch in place (would you
expect that to look any different... it still has the "unrecognized"
parts)?

Cheers,

- Pete.
