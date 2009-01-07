From: "Marco Santamaria" <marco.santamaria@gmail.com>
Subject: Re: snd_usb_caiaq bug?
Date: Wed, 7 Jan 2009 19:46:17 +0100
Message-ID: <31e66c9e0901071046v36112db7s757788bcf5beaeeb@mail.gmail.com>
References: <31e66c9e0901040829y4bedc1ebgcf91afe10d80341a@mail.gmail.com>
	<s5hprizv0yh.wl%tiwai@suse.de>
	<31e66c9e0901070741i2f6f363l9dc023223954ce2@mail.gmail.com>
	<s5hk597t6pm.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-bw0-f20.google.com (mail-bw0-f20.google.com
	[209.85.218.20])
	by alsa0.perex.cz (Postfix) with ESMTP id 5B4A91037E3
	for <alsa-devel@alsa-project.org>; Wed,  7 Jan 2009 19:46:19 +0100 (CET)
Received: by bwz13 with SMTP id 13so22330040bwz.8
	for <alsa-devel@alsa-project.org>; Wed, 07 Jan 2009 10:46:18 -0800 (PST)
In-Reply-To: <s5hk597t6pm.wl%tiwai@suse.de>
Content-Disposition: inline
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel@alsa-project.org, Daniel Mack <daniel@caiaq.de>, Mysth-R <mysthr21@gmail.com>
List-Id: alsa-devel@alsa-project.org

The "rawmidi drain error" went away.
Now if I start and shut down jackd nothing bad happens.
But when I launch Rosegarden there are several lines containing the
following new message:

[  455.025168] ALSA
/home/marco/build/linux-2.6.24-19-rt/alsa-1.0.17/driver-patched/alsa-driver-1.0.17/usb/caiaq/../../alsa-kernel/usb/caiaq/caiaq-midi.c:84:
snd-usb-caiaq log: snd_usb_caiaq_midi_send(f76a5ac0): usb_submit_urb()
failed, -22

Furthermore the first time I rebooted my system, it freezed during the
startup procedure (loading hardware drivers), but it didn't happen again.


Marco

2009/1/7 Takashi Iwai <tiwai@suse.de>

> At Wed, 7 Jan 2009 16:41:21 +0100,
> Marco Santamaria wrote:
> >
> > I applied the patch (or I think so...). I just removed the line:
> >
> > dev->midi_out_substream = NULL;
> >
> > from the function snd_usb_caiaq_midi_output_done in the file
> caiaq-midi.c.
> > Then I recompiled the driver.
> >
> > The main issue is sorted out: I can start and shut down jackd without big
> > problems.
> >
> > But with dmesg I still have the following message:
> >
> > ALSA /home/marco/build/linux-2.6.24-19-rt/alsa-1.0.17/driver-patched/
> > alsa-driver-1.0.17/acore/rawmidi.c:196: rawmidi drain error (avail =
> 4095,
> > buffer_size = 4096)
> >
> > Not sure if it is safe to ignore it.
>
> Hmm, what about the patch below?
>
>
> Takashi
>
> ---
> diff --git a/sound/usb/caiaq/caiaq-midi.c b/sound/usb/caiaq/caiaq-midi.c
> index 30b57f9..9557635 100644
> --- a/sound/usb/caiaq/caiaq-midi.c
> +++ b/sound/usb/caiaq/caiaq-midi.c
> @@ -69,7 +69,8 @@ static void snd_usb_caiaq_midi_send(struct
> snd_usb_caiaqdev *dev,
>
>        dev->midi_out_buf[0] = EP1_CMD_MIDI_WRITE;
>        dev->midi_out_buf[1] = 0; /* port */
> -       len = snd_rawmidi_transmit_peek(substream, dev->midi_out_buf+3,
> EP1_BUFSIZE-3);
> +       len = snd_rawmidi_transmit(substream, dev->midi_out_buf + 3,
> +                                  EP1_BUFSIZE - 3);
>
>        if (len <= 0)
>                return;
> @@ -87,16 +88,12 @@ static void snd_usb_caiaq_midi_output_trigger(struct
> snd_rawmidi_substream *subs
>  {
>        struct snd_usb_caiaqdev *dev = substream->rmidi->private_data;
>
> -       if (dev->midi_out_substream != NULL)
> -               return;
> -
> -       if (!up) {
> +       if (up) {
> +               dev->midi_out_substream = substream;
> +               snd_usb_caiaq_midi_send(dev, substream);
> +       } else {
>                 dev->midi_out_substream = NULL;
> -               return;
>        }
> -
> -       dev->midi_out_substream = substream;
> -       snd_usb_caiaq_midi_send(dev, substream);
>  }
>
>
> @@ -169,8 +166,6 @@ void snd_usb_caiaq_midi_output_done(struct urb* urb)
>        if (!dev->midi_out_substream)
>                 return;
>
> -       snd_rawmidi_transmit_ack(dev->midi_out_substream, buf[2]);
> -       dev->midi_out_substream = NULL;
>        snd_usb_caiaq_midi_send(dev, dev->midi_out_substream);
>  }
>
>
