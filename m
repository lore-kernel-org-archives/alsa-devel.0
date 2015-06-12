From: Azizul Hakim <azizulfahim2002@gmail.com>
Subject: Re: Can't Unload ALSA Driver Without Disconnecting the
	Device
Date: Fri, 12 Jun 2015 02:51:03 -0400
Message-ID: <CA+k7Wwbr=TE63GLLSbKzCLBeWSSg0EjdLJW-2TXagP5FSgrBLQ@mail.gmail.com>
References: <CA+k7WwZ+vosLDQ8jz_3E+CtAokjerp_vUtK7bbBCRrD4ZxinOg@mail.gmail.com>
 <s5h616t77jd.wl-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-ob0-f175.google.com (mail-ob0-f175.google.com
 [209.85.214.175])
 by alsa0.perex.cz (Postfix) with ESMTP id 540EE266711
 for <alsa-devel@alsa-project.org>; Fri, 12 Jun 2015 08:51:04 +0200 (CEST)
Received: by obbqz1 with SMTP id qz1so17616997obb.3
 for <alsa-devel@alsa-project.org>; Thu, 11 Jun 2015 23:51:03 -0700 (PDT)
In-Reply-To: <s5h616t77jd.wl-tiwai@suse.de>
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

I tried that command. The output is as below:

                                    USER        PID ACCESS COMMAND
/dev/snd/controlC0:  mhaki005   2043 F.... pulseaudio
/dev/snd/controlC1:  mhaki005   2043 F.... pulseaudio
/dev/snd/pcmC0D0c:   mhaki005   2043 F...m pulseaudio


I think pcmC0D0c stands for "Capture" device. My device is a playback
device. So I don't think it is being used by anyone.


On Fri, Jun 12, 2015 at 2:41 AM, Takashi Iwai <tiwai@suse.de> wrote:

> At Fri, 12 Jun 2015 02:28:16 -0400,
> Azizul Hakim wrote:
> >
> > Hi,
> >
> > I've been developing a sound card driver for a USB device using ALSA. My
> > driver is almost working but I've got one small issue. If I try to unload
> > the driver module using "rmmod" command  when the device is still
> connected
> > to the USB port, it says "Module is in use" even though I'm not playing
> any
> > sound files or anything.
> >
> >
> > If I try to execute the "lsmod" command I see that it is saying the usage
> > count of my driver to be 1, but it doesn't say anything about who is
> using
> > it. Once I disconnect the device from the USB port, I can easily unload
> the
> > module.
> >
> >
> > So it seems to me it won't be possible to unload a sound card driver if
> the
> > card is attached in the computer. Is my assumption correct? If not, what
> > might be some key points to solve the issue?
>
> Check "fuser -v /dev/snd/*" as root.  Something (e.g. a mixer
> application or sound backend) must be accessing the device.
>
>
> Takashi
>
