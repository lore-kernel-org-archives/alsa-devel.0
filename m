From: Mutz Heuer <mutz.heuer@gmail.com>
Subject: Re: [USB-Audio - PX USB,
 playback] snd-usb-audio: probe of 2-3:1.0 failed with error -22
 after kernel upgrade
Date: Tue, 30 Oct 2018 19:45:36 +0100
Message-ID: <CAHU8kAqRB_t6pt81YRvtX+UfW+TNyWUxtZZ4_Hp0LHAsw5LNtQ@mail.gmail.com>
References: <CAHU8kApb6us8A4r9vwzZaM+Y7BQoty0HqXARJXLpQJqjv0OMCA@mail.gmail.com>
 <s5h1s873cev.wl-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-lj1-f194.google.com (mail-lj1-f194.google.com
 [209.85.208.194])
 by alsa0.perex.cz (Postfix) with ESMTP id 3889A26770D
 for <alsa-devel@alsa-project.org>; Tue, 30 Oct 2018 19:45:49 +0100 (CET)
Received: by mail-lj1-f194.google.com with SMTP id s15-v6so12424904lji.3
 for <alsa-devel@alsa-project.org>; Tue, 30 Oct 2018 11:45:48 -0700 (PDT)
In-Reply-To: <s5h1s873cev.wl-tiwai@suse.de>
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

I checked the source code of quirks-table.h on branch 4.19-rc8. It still
contains the problematic workaround. It doesn't seem to fit any longer to
the headphones current firmware. Checking the 4.15.7 kernel (without the
quirk) works much better. At least the device is shown in the mixer and
fixing the samplerate to 48kHz leads to a useful configuration. To be
honest I do not really understand how to define a fixed table for supported
sample rate without fiddling with other parameters. The HID seems to
working too. At least I am able to use the headphone buttons to in/decrease
the volume and to stop and restart playback. The microphone is not shown -
but that does not seem to work on windows either - as far as I understand
the orginal patch to support the headphones.

With the qurik in place I get no really helpful error messages ...

I hope that helps to clarify the situation,

Mutz

Takashi Iwai <tiwai@suse.de> schrieb am Di., 30. Okt. 2018 um 12:24 Uhr:

> On Sun, 28 Oct 2018 22:00:35 +0100,
> Mutz Heuer wrote:
> >
> > USB-Audio Connection on Bowers & Wilkens PX Bluetooth Headphones started
> > working when upgrading kernel from 4.13 to 4.15 series. Then it suddenly
> > stopped working again on newer kernels. The bug report has been generated
> > on the latest working mainline kernel 4.15.7. All newer kernels have some
> > usb quirks in place, which should fix the playback sample rates to 48
> kHz.
> > The quirk seems not to be working correctly - it seems to hinder the
> audio
> > system to recognize the USB-device as a sound device.
> >
> > The Headphones work on kernels before 4,15.7 when manually configuring
> > pulseaudio to a default samplerate of 48 kHz.
> >
> > PX Headphones are on the newest firmware level.
> >
> > See https://patchwork.kernel.org/patch/10265345/. Dropping that patch
> and
> > recompiling the kernel leads to a situation where alsa and pulseaudio
> seem
> > to to be working again.
> >
> > Adding
> >
> >       default-sample-rate = 48000
> >
> > to /etc/pulse/daemon.conf leads to working headphones.
> >
> > Maybe the patch has to be adjusted to newer firmware? A quirk seems to be
> > really necessary to avoid the specific patch to daemon.conf.
> >
> >
> > More details can be found in
> > https://bugs.launchpad.net/ubuntu/+source/linux/+bug/1773697
> > What would be the best way to proceed?
>
> Could you check the latest Linus git tree (or for-linus branch of
> sound git tree)?  The workaround for the buggy firmware was already
> included there.  Let me know if it still doesn't suffice.
>
>
> thanks,
>
> Takashi
>
