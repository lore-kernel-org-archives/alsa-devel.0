From: Daniel Mack <zonque@gmail.com>
Subject: Re: [PATCH v3 5/5] ALSA: snd-usb: add quirks handler
 for DSD streams
Date: Mon, 12 Aug 2013 10:52:29 +0200
Message-ID: <5208A24D.5000400@gmail.com>
References: <CANNq7HhLg=1p4ASYzRdN4igexQX11NhwdbiKF2eS=avnyU1ykA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-bk0-f44.google.com (mail-bk0-f44.google.com
 [209.85.214.44])
 by alsa0.perex.cz (Postfix) with ESMTP id 5AB3A26030A
 for <alsa-devel@alsa-project.org>; Mon, 12 Aug 2013 10:52:31 +0200 (CEST)
Received: by mail-bk0-f44.google.com with SMTP id mz10so2063008bkb.3
 for <alsa-devel@alsa-project.org>; Mon, 12 Aug 2013 01:52:31 -0700 (PDT)
In-Reply-To: <CANNq7HhLg=1p4ASYzRdN4igexQX11NhwdbiKF2eS=avnyU1ykA@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Jesus R <sonorejr@gmail.com>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On 11.08.2013 18:37, Jesus R wrote:
> Daniel/team, I have access to a few DSD devices and or USB based devices. I
> can provide any information you need to help with allowing ALSA to identify
> the device's capabilities. Just let me know how to get the information you
> need from command line:)

Nice. I take it those devices are DOP-capable?

Given than none of devices have a chance to report their capabilities to
the host, finding out which modes to use is a trial-and-error game,
unless you have access to the firmware sources.

Hence, please just look up the USB IDs and alternate interface settings
of your connected device with lsusb, and then augment the code in
snd_usb_interface_dsd_format_quirks() (file sound/usb/quirks.c) and play
around with different possibilities (bitreverse on/off, DSD_U8 vs
DSD_U16 etc). Follow the example that I provided in that function.

You have to recompile and rmmod/insmod the snd-usb driver every time you
make a change, and then you need some sort of userspace tool to test it.
I published one here:

 https://github.com/zonque/alsa-dsd-player


Once you have more quirks sorted out, please send a patch. I'm sorry
there's no easier way to work on this. Let me know if you need more
instructions.


Thanks,
Daniel
