From: Grant Diffey <gdiffey@gmail.com>
Subject: Re: trying to get an eleven rack to work
Date: Mon, 19 Mar 2012 18:19:46 +1100
Message-ID: <CACckToUSQt_VwhC75rn4mz=QNh1S3UJQQw+iWqLuVnA3Zdzvyw@mail.gmail.com>
References: <CAOyn=DH_BCQh-DksiLGQnQw1kq0eNNH+Zi7KdRdX5=uot9x2Eg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-qc0-f179.google.com (mail-qc0-f179.google.com
	[209.85.216.179])
	by alsa0.perex.cz (Postfix) with ESMTP id D4B3E103FE2
	for <alsa-devel@alsa-project.org>; Mon, 19 Mar 2012 08:19:47 +0100 (CET)
Received: by qcha6 with SMTP id a6so1101372qch.38
	for <alsa-devel@alsa-project.org>; Mon, 19 Mar 2012 00:19:46 -0700 (PDT)
In-Reply-To: <CAOyn=DH_BCQh-DksiLGQnQw1kq0eNNH+Zi7KdRdX5=uot9x2Eg@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: David Alexander <lidxv0n@gmail.com>, Clemens Ladisch <clemens@ladisch.de>, Daniel Mack <zonque@gmail.com>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On Sun, Mar 18, 2012 at 10:17 AM, David Alexander <lidxv0n@gmail.com> wrote:

> Hi.
>
> I bought and would like to get an eleven rack interface to work.  It
> is a usb gutiar amp emulator/audio interface.  It is a avid/digi
> device that normal uses asio vendor specific drivers.
>
>
Appologies to all for 2 copies I forgot alsa-devel.

David,

So it should show up when plugged in as a midi device but the audio i/o is
typical m-audio almost but not quiet compliant.

so you do need a quirk based on reading the lsusb output above my guess is:

Interface 0 is a DFU firmware upgrade
Interface 1 is really custom (perhaps some sort of custom
control/management thing tho I would of thought they'd use midi sysex for
that)
Interface 2 is the midi
Interface 3 looks like maybe a usb mixer without a descriptor? but that's a
guess.
Interface 4 is potentially usb2 audio output
Interface 5 is potentially usb2 audio input.

So if you were to look at the fast track ultra quirk building something
that can get audio in and out should be straightforward.
(ignore the mixer using QUIRK_IGNORE_INTERFACE or whatever the right macro
name is)

that said. there is a devil in the detail here... which is..


         Transfer Type            Isochronous
         Synch Type               Asynchronous
         Usage Type               Implicit feedback Data

on interface 5 indicates this is implicit feedback used for clocking
control... of the output on interface 4
This is not supported by the alsa snd-usb driver but work is underway to
add support for this usb transfer mode.

Regards

Grant.
