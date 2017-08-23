From: Clemens Ladisch <clemens@ladisch.de>
Subject: Re: Attempting to understand odd snd-usb-audio code
 and behavior
Date: Wed, 23 Aug 2017 12:23:00 +0200
Message-ID: <ac221250-a87f-0875-1172-846530607635@ladisch.de>
References: <2006820.TBXnYHJvYE@kamdesktop>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from webclient5.webclient5.de (webclient5.webclient5.de
 [136.243.32.179])
 by alsa0.perex.cz (Postfix) with ESMTP id 695D42664EB
 for <alsa-devel@alsa-project.org>; Wed, 23 Aug 2017 12:23:01 +0200 (CEST)
Received: from [10.1.2.4] (unknown [94.101.37.79])
 by webclient5.webclient5.de (Postfix) with ESMTPSA id A0DDC558044F
 for <alsa-devel@alsa-project.org>; Wed, 23 Aug 2017 12:23:00 +0200 (CEST)
In-Reply-To: <2006820.TBXnYHJvYE@kamdesktop>
Content-Language: en-US
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

Keith A. Milner wrote:
> I'm struggling to understand why the code is behaving as it does in
> practice

Because the code has evolved over a long time, and it tries to handle
not only both versions of the USB audio specification, but also devices
as they are behaving in practice.

> My observation when plugging the USB device in is that, as expected, it tries
> to build the audio device, and add components to it including attaching
> capture and playback streams. It seems to go through this phase without too
> many surprises, and we get to the standard dmesg output:
>
> usbcore: registered new interface driver snd-usb-audio
>
> After this, it gets confusing.
>
> It seems to open and close the PCMs

That happens due to requests from user space, probably PulseAudio.

> kernel: [ 1987.452947] usb 1-1: Unable to change format on ep #8e: already in use

So this is a Roland device?  Playback-synchronized-to-capture is a very
special case; at the moment, nobody understands this code completely.

But the problem for this device might be that it requires some
vendor-specific messages to enable it in the first place.


Regards,
Clemens
