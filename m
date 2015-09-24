From: Francesco Lavra <francescolavra.fl@gmail.com>
Subject: Re: MIDI port using UART interface
Date: Thu, 24 Sep 2015 08:58:07 +0200
Message-ID: <CAOau3s_Y9KnBsQj9BRKQ9hfnd91PXs63Ur0_zycmdk6d-X10=A@mail.gmail.com>
References: <55FD6494.8030208@gmail.com>
	<5602EBFE.5000203@ladisch.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-ob0-f177.google.com (mail-ob0-f177.google.com
 [209.85.214.177])
 by alsa0.perex.cz (Postfix) with ESMTP id C92972612D1
 for <alsa-devel@alsa-project.org>; Thu, 24 Sep 2015 08:58:08 +0200 (CEST)
Received: by obbmp4 with SMTP id mp4so51525541obb.3
 for <alsa-devel@alsa-project.org>; Wed, 23 Sep 2015 23:58:07 -0700 (PDT)
In-Reply-To: <5602EBFE.5000203@ladisch.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Clemens Ladisch <clemens@ladisch.de>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On Wed, Sep 23, 2015 at 8:14 PM, Clemens Ladisch <clemens@ladisch.de> wrote:
> Francesco Lavra wrote:
>> So how would you approach the task of writing a MIDI driver that uses
>> UART behind the scenes? Am I correct in assuming that I have to use
>> the RawMIDI interface (as the UART 16550 driver does) to make my MIDI
>> port available to ALSA applications? Or is there a better alternative?
>
> The kernel-internal serial port interfaces are designed to be able to
> run a console.
>
> The easiest way would be a userspace daemon that bridges between some
> /dev/tty* and the ALSA sequencer.
> See <http://www.alsa-project.org/~clemens/usbmidid/usbmidid.c> for an
> example that uses some other device.

There already is an userspace daemon that bridges a tty with the ALSA
sequencer: ttymidi (http://www.varal.org/ttymidi/). Unfortunately it
doesn't support non-standard baud rates such as 31.25 kbps, and using
the termios API it's not possible to set non-standard baud rates.
Messing with the serial port settings via setserial could do the trick
(not sure if it works on my system, though), otherwise another
solution could be to use the (non-POSIX) termios2 API...

Regards,
Francesco
