From: Mysth-R <mysthr21@gmail.com>
Subject: Re: snd_usb_caiaq bug?
Date: Thu, 8 Jan 2009 15:26:39 +0100
Message-ID: <907c05c70901080626x83c3e2fn158d2938c4c8cbfd@mail.gmail.com>
References: <31e66c9e0901040829y4bedc1ebgcf91afe10d80341a@mail.gmail.com>
	<s5hprizv0yh.wl%tiwai@suse.de>
	<31e66c9e0901070741i2f6f363l9dc023223954ce2@mail.gmail.com>
	<s5hk597t6pm.wl%tiwai@suse.de>
	<31e66c9e0901071046v36112db7s757788bcf5beaeeb@mail.gmail.com>
	<907c05c70901071206y4bba38bej47f3eba51e6106d3@mail.gmail.com>
	<s5hy6xmhgp3.wl%tiwai@suse.de>
	<31e66c9e0901071659p63219af1wb392f50541cda7a0@mail.gmail.com>
	<31e66c9e0901071734t70c980a8t87f668f973b54635@mail.gmail.com>
	<s5h4p0at563.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from rv-out-0708.google.com (rv-out-0708.google.com [209.85.198.243])
	by alsa0.perex.cz (Postfix) with ESMTP id 0C3171037EE
	for <alsa-devel@alsa-project.org>; Thu,  8 Jan 2009 15:26:40 +0100 (CET)
Received: by rv-out-0708.google.com with SMTP id f25so8302638rvb.32
	for <alsa-devel@alsa-project.org>; Thu, 08 Jan 2009 06:26:40 -0800 (PST)
In-Reply-To: <s5h4p0at563.wl%tiwai@suse.de>
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
Cc: Marco Santamaria <marco.santamaria@gmail.com>, alsa-devel@alsa-project.org, Daniel Mack <daniel@caiaq.de>
List-Id: alsa-devel@alsa-project.org

Hi,

I tried the last patch, and I think we got it. I made some few tests, and
every thing is Ok for me now. No more crash, no more messages in dmesg.
I just had a warning during compilation, but I think this is not really
important :

sound/usb/caiaq/caiaq-midi.c: In function
\u2018snd_usb_caiaq_midi_output_done\u2019:
sound/usb/caiaq/caiaq-midi.c:170: attention : unused variable
\u2018buf\u2019

Perhaps this is not the same line (170) as you but, in my file, it concerns
the last function.

Thank you very much for your help !

Cheers,

Mysth-R
2009/1/8 Takashi Iwai <tiwai@suse.de>

> At Thu, 8 Jan 2009 02:34:46 +0100,
> Marco Santamaria wrote:
> >
> > Unfortunately I have to correct my previous message.
> >
> > After a load test with jack + qsynth + rosegarden (sample rate=3D88200,
> frames/
> > period=3D256,  periods/buffer=3D3), using a 16 tracks midi file and a 2=
9MB
> sound
> > font, the following message appeared:
> >
> > [ 1098.445807] ALSA /home/marco/build/linux-2.6.24-19-rt/alsa-1.0.17/
> > driver-patched/alsa-driver-1.0.17/usb/caiaq/../../alsa-kernel/usb/caiaq/
> > caiaq-midi.c:84: snd-usb-caiaq log: snd_usb_caiaq_midi_send(f64c66c0):
> > usb_submit_urb() failed, -22
>
> Hmm... what about this version?
>
>
> Takashi
>
> ---
> diff --git a/sound/usb/caiaq/caiaq-device.h
> b/sound/usb/caiaq/caiaq-device.h
> index f9fbdba..ab56e73 100644
> --- a/sound/usb/caiaq/caiaq-device.h
> +++ b/sound/usb/caiaq/caiaq-device.h
> @@ -75,6 +75,7 @@ struct snd_usb_caiaqdev {
>        wait_queue_head_t ep1_wait_queue;
>        wait_queue_head_t prepare_wait_queue;
>        int spec_received, audio_parm_answer;
> +       int midi_out_active;
>
>        char vendor_name[CAIAQ_USB_STR_LEN];
>        char product_name[CAIAQ_USB_STR_LEN];
> diff --git a/sound/usb/caiaq/caiaq-midi.c b/sound/usb/caiaq/caiaq-midi.c
> index 30b57f9..18bbe38 100644
> --- a/sound/usb/caiaq/caiaq-midi.c
> +++ b/sound/usb/caiaq/caiaq-midi.c
> @@ -59,6 +59,11 @@ static int snd_usb_caiaq_midi_output_open(struct
> snd_rawmidi_substream *substrea
>
>  static int snd_usb_caiaq_midi_output_close(struct snd_rawmidi_substream
> *substream)
>  {
> +       struct snd_usb_caiaqdev *dev =3D substream->rmidi->private_data;
> +       if (dev->midi_out_active) {
> +               usb_kill_urb(&dev->midi_out_urb);
> +               dev->midi_out_active =3D 0;
> +       }
>        return 0;
>  }
>
> @@ -69,7 +74,8 @@ static void snd_usb_caiaq_midi_send(struct
> snd_usb_caiaqdev *dev,
>
>        dev->midi_out_buf[0] =3D EP1_CMD_MIDI_WRITE;
>        dev->midi_out_buf[1] =3D 0; /* port */
> -       len =3D snd_rawmidi_transmit_peek(substream, dev->midi_out_buf+3,
> EP1_BUFSIZE-3);
> +       len =3D snd_rawmidi_transmit(substream, dev->midi_out_buf + 3,
> +                                  EP1_BUFSIZE - 3);
>
>        if (len <=3D 0)
>                return;
> @@ -79,24 +85,24 @@ static void snd_usb_caiaq_midi_send(struct
> snd_usb_caiaqdev *dev,
>
>        ret =3D usb_submit_urb(&dev->midi_out_urb, GFP_ATOMIC);
>         if (ret < 0)
> -               log("snd_usb_caiaq_midi_send(%p): usb_submit_urb() failed,
> %d\n",
> -                               substream, ret);
> +               log("snd_usb_caiaq_midi_send(%p): usb_submit_urb() failed=
,"
> +                   "ret=3D%d, len=3D%d\n",
> +                   substream, ret, len);
> +       else
> +               dev->midi_out_active =3D 1;
>  }
>
>  static void snd_usb_caiaq_midi_output_trigger(struct snd_rawmidi_substre=
am
> *substream, int up)
>  {
>        struct snd_usb_caiaqdev *dev =3D substream->rmidi->private_data;
>
> -       if (dev->midi_out_substream !=3D NULL)
> -               return;
> -
> -       if (!up) {
> +       if (up) {
> +               dev->midi_out_substream =3D substream;
> +               if (!dev->midi_out_active)
> +                       snd_usb_caiaq_midi_send(dev, substream);
> +       } else {
>                dev->midi_out_substream =3D NULL;
> -               return;
>        }
> -
> -       dev->midi_out_substream =3D substream;
> -       snd_usb_caiaq_midi_send(dev, substream);
>  }
>
>
> @@ -163,14 +169,13 @@ void snd_usb_caiaq_midi_output_done(struct urb* urb)
>         struct snd_usb_caiaqdev *dev =3D urb->context;
>        char *buf =3D urb->transfer_buffer;
>
> +       dev->midi_out_active =3D 0;
>        if (urb->status !=3D 0)
>                return;
>
>        if (!dev->midi_out_substream)
>                return;
>
> -       snd_rawmidi_transmit_ack(dev->midi_out_substream, buf[2]);
> -       dev->midi_out_substream =3D NULL;
>        snd_usb_caiaq_midi_send(dev, dev->midi_out_substream);
>  }
>
>


-- =

*
***************************************************************************=
************
*  {^_^} Mysth-R {^_^}
*  <=3D Aide Auditive =3D>
*
* http://myspace.com/mysthr
* http://myspace.com/aideauditive
* http://mysthr.free.fr/Joomla  =3D> Site d=E9di=E9 =E0 l'audio sous
Fedora/PlanetCCRMA.
*
***************************************************************************=
************
