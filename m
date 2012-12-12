From: Damien Zammit <damien.zammit@gmail.com>
Subject: Re: Bug in aplay?
Date: Wed, 12 Dec 2012 23:08:19 +1100
Message-ID: <CABXa2sHoAuhR=HWp-_0PqQoLb0Z=dXE85C52c8fkyDMMWc=JCg@mail.gmail.com>
References: <CABXa2sHAWX-q=tpMdLqJSXbu-kNeuuhhPY5UQ41qKQ+SisD=Rg@mail.gmail.com>
 <s5h38zbh557.wl%tiwai@suse.de>
 <CABXa2sEdsWcT8Prq59mTO6szeSvO9-AD6Me=gPF3-wpAGgHB9A@mail.gmail.com>
 <50C87185.6030008@ladisch.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-ob0-f179.google.com (mail-ob0-f179.google.com
 [209.85.214.179])
 by alsa0.perex.cz (Postfix) with ESMTP id CB525261662
 for <alsa-devel@alsa-project.org>; Wed, 12 Dec 2012 13:08:20 +0100 (CET)
Received: by mail-ob0-f179.google.com with SMTP id x4so513770obh.38
 for <alsa-devel@alsa-project.org>; Wed, 12 Dec 2012 04:08:20 -0800 (PST)
In-Reply-To: <50C87185.6030008@ladisch.de>
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
Cc: Takashi Iwai <tiwai@suse.de>, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

I wish to record and playback streams from my sound card which uses 24
bit big endian format, but I do not wish to resample it.  Is it
possible to reorder the endianess on the fly so that I can play and
record using alsa tools without losing any quality?

On 12 December 2012 22:59, Clemens Ladisch <clemens@ladisch.de> wrote:
> Damien Zammit wrote:
>> pi@raspberrypi ~ $ hexdump -C 48000-S24_3BE.wav |head
>> 00000000  52 49 46 58 01 c3 20 48  57 41 56 45 66 6d 74 20  |RIFX.. HWAVEfmt |
>
> aplay does not support big-endian .wav files.
>
>
> Regards,
> Clemens
