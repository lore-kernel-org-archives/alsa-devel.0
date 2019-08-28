From: Pavel Hofman <pavhofman@gmail.com>
Subject: Options for ASYNC feedback source in USB-audio gadget
	(USB OTG)?
Date: Wed, 28 Aug 2019 13:17:01 +0200
Message-ID: <CA+SWvNwqg3Q37BWNpw7C+75Z+CO-zUo2UUYjvz88L3hW1tk=gQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-qk1-x72f.google.com (mail-qk1-x72f.google.com
 [IPv6:2607:f8b0:4864:20::72f])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 946ADF89754
 for <Alsa-devel@alsa-project.org>; Wed, 28 Aug 2019 13:17:15 +0200 (CEST)
Received: by mail-qk1-x72f.google.com with SMTP id m2so1982965qkd.10
 for <Alsa-devel@alsa-project.org>; Wed, 28 Aug 2019 04:17:15 -0700 (PDT)
List-Unsubscribe: <https://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <https://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: "Alsa-devel" <alsa-devel-bounces@alsa-project.org>
To: Alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Hi,

The existing usb-audio v.2 gadget defines its EP OUT as asynchronous
https://github.com/torvalds/linux/blob/master/drivers/usb/gadget/function/f_uac2.c#L276
, but does not define any feedback IN EP (which is against USB audio
class 2.0 specs).  Windows 10 USB audio class 2 driver requires
presence of the feedback EP. By changing the EP OUT to adaptive (which
in fact it is), we could fix the driver issue and windows plays
through such device (RPi4) correctly now (linux/OSX already worked OK
before). We will post a patch soon.

RPi can now be used as an "intelligent" USB soundcard, allowing
further processing in linux on RPi, before outputting to some final
sound device.

However, there are two clock domains involved - the host USB
controller sending stream to the USB gadget, and the output soundcard
of the gadget. While adaptive resampling is possible (jackd, PA do
that), IMO the correct solution is going back to ASYNC EP OUT in the
audio gadget and implementing a proper feedback EP.

But the feedback EP needs input data. The whole chain behind the
virtual capture alsa device defined by the gadget driver is clocked by
the playback soundcard. May I ask for your opinions on possible
options for

1) gathering the feedback data from the playback chain
2) passing the gathered samplerate-diff data to the gadget module for
the feedback EP to send to the USB host

A general solution would be very useful, at best without using
alsa-lib defined PCM devices (e.g. Java still supports only hardware
devices (hw:X), not  PCM devices defined by alsa-lib).

I very much appreciate your suggestions and help.

Best regards,

Pavel.
