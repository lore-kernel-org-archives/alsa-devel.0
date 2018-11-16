From: David Ulricht <david.ulricht434@gmail.com>
Subject: Re: CS8409 Macbook Pro 2016 2017
Date: Fri, 16 Nov 2018 18:50:24 +0200
Message-ID: <CALbf9Myg=XJqiRN2YJAwYqP6hHDGnCwYptQvUT8WMqGmnN_XRQ@mail.gmail.com>
References: <CALbf9MzcxBqkBP4mbUKht72Ga6VnTubeiHcTr2joEf7i-enxFQ@mail.gmail.com>
 <s5h7el6vd91.wl-tiwai@suse.de>
 <CALbf9Mw=Y5ddFZDZQ4_mfYCHxKb9XFHN3v5ge0JaTca7NLMM7A@mail.gmail.com>
 <s5hzhy2t7ww.wl-tiwai@suse.de>
 <CALbf9MwN4pEk26R9c2-UMxzvLXQ3OOBTcqgdSvXeFb-dw7-Wnw@mail.gmail.com>
 <s5hwot6t5qz.wl-tiwai@suse.de>
 <CALbf9MzYvcz+d0HKmvc60WhTHVpiuTK8O66qNH3Xcuo5j3uU9Q@mail.gmail.com>
 <s5h1sbcu1t1.wl-tiwai@suse.de>
 <CALbf9MyfhiE73gLsimw4XS3pJyD1N+w6NMD5KzH-dSPAA3qbFg@mail.gmail.com>
 <s5h5zwxhyxh.wl-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-ot1-f49.google.com (mail-ot1-f49.google.com
 [209.85.210.49])
 by alsa0.perex.cz (Postfix) with ESMTP id 5E52E267947
 for <alsa-devel@alsa-project.org>; Fri, 16 Nov 2018 17:50:38 +0100 (CET)
Received: by mail-ot1-f49.google.com with SMTP id t5so21950222otk.1
 for <alsa-devel@alsa-project.org>; Fri, 16 Nov 2018 08:50:38 -0800 (PST)
In-Reply-To: <s5h5zwxhyxh.wl-tiwai@suse.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

> The stuff in sound/i2c/* are mostly for the i2c bus on a PCI sound
> cards, an implementation independent from the standard i2c stuff.
>
> And, in your case, it's hard to know how the i2c bus is connected.
> If it's controlled over HD-audio GPIO pin (one for clk and one for
> data), then some stuff in sound/i2c can be re-used.  Or, if it's on
> another i2c bus, the story will be completely different...
>
I have the schematics of the CS8409. the i2c is connected to the GPIO of
the HDA.

MAX98374 has a Reset Low pin which is connected to GPIO 5 on the HDA
controller CS8409.  This must
be driven high, then wait for 1.5 ms.  Only then will the amps be out of
device shutdown.
GPIO6 is  8409_I2C_SCL
GPIO7 is  8409_I2C_SDA

GPIO5 is AUD_SPKRAMP_RESET_L

Knowing GPIO6 is the clock and GPIO7 is the data, how can I use them?
Can I use hda-verb /dev/snd/hwC0D0 0x01 XXX YYY ? what XXX YYY would be ?
