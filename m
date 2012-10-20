From: Daniel Mack <zonque@gmail.com>
Subject: Re: usb-audio: Reloop Play support (TI TUSB3200AC)
Date: Sat, 20 Oct 2012 14:49:50 +0200
Message-ID: <50829DEE.7020004@gmail.com>
References: <1350652166.5549.8.camel@didier-laptop> <5081539E.40705@gmail.com>
 <1350654327.8310.4.camel@didier-laptop> <50815B51.3090402@gmail.com>
 <1350659344.5494.11.camel@didier-laptop> <508195B4.2090809@gmail.com>
 <1350728568.5932.6.camel@didier-laptop>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-bk0-f51.google.com (mail-bk0-f51.google.com
 [209.85.214.51])
 by alsa0.perex.cz (Postfix) with ESMTP id 57DEF264F2B
 for <alsa-devel@alsa-project.org>; Sat, 20 Oct 2012 14:50:03 +0200 (CEST)
Received: by mail-bk0-f51.google.com with SMTP id e19so398152bku.38
 for <alsa-devel@alsa-project.org>; Sat, 20 Oct 2012 05:50:03 -0700 (PDT)
In-Reply-To: <1350728568.5932.6.camel@didier-laptop>
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
Cc: alsa-devel <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

On 20.10.2012 12:22, Didier 'Ptitjes' Villevalois wrote:
> On ven., 2012-10-19 at 20:02 +0200, Daniel Mack wrote:
> [...]
>> Let me know of you make any progress here.
>>
> I diff-ed the ioreg output when the play is connected without the driver
> (-) and with the driver (+). So I can see that it is using its
> proprietary driver.
> 
> http://ptitjes.free.fr/reloop-play/play-ioreg-without-and-with-driver.diff

Hmm, that output doesn't make a whole lot of sense. Could you do the
same thing with lsusb under Linux? Boot into Linux after the OS X driver
downloaded the firmware for one run, and freshly connect (power cycle)
device for the other.

> I also traced (with Apple's USB Probe tool) the USB when connecting the
> PLAY.
> 
> At log level 6:
> http://ptitjes.free.fr/reloop-play/usb-log-withdriver-l6.txt
> 
> At log level 7: (3.5Mo!!)
> http://ptitjes.free.fr/reloop-play/usb-log-withdriver-l7.txt
> 
> I have to do the same thing when streaming some sound. But should I
> output some easily recognizable sound ? Something like a sine or some
> silence ?

Yes, that can help. You could for example stream a sine that is on just
one channel, so you can debug the muxing (interleaving) on the wire. Or
a sine at ~ -48dB, which would just leave the 8 MSB empty (to check the
endianess).

Most probably though, the streaming mode is already supported by the
Linux driver, and it's the recognition of the right format that fails,
or the cards needs a different setup sequence than the generic one.


Daniel
