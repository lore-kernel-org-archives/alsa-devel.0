From: Raymond Yau <superquad.vortex2@gmail.com>
Subject: Re: snd jack report and unsolicited event ad1988
Date: Mon, 9 May 2011 11:56:11 +0800
Message-ID: <BANLkTinNiWDMKVt8U-7o9GRvJG3KmC-osQ@mail.gmail.com>
References: <BANLkTikbOGHJp9VJ+yyA4dJxgcbuNk4LeA@mail.gmail.com>
	<s5hsjstmq6i.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-fx0-f51.google.com (mail-fx0-f51.google.com
	[209.85.161.51])
	by alsa0.perex.cz (Postfix) with ESMTP id BEB5A10380A
	for <alsa-devel@alsa-project.org>;
	Mon,  9 May 2011 05:56:11 +0200 (CEST)
Received: by fxm5 with SMTP id 5so3827157fxm.38
	for <alsa-devel@alsa-project.org>; Sun, 08 May 2011 20:56:11 -0700 (PDT)
In-Reply-To: <s5hsjstmq6i.wl%tiwai@suse.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Takashi Iwai <tiwai@suse.de>, ALSA Development Mailing List <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

2011/5/5 Takashi Iwai <tiwai@suse.de>

>> This mean that the driver need to define FRONT_MIC_EVENT, REAR_MIC_EVENT,
>> LINE_IN_EVENT in addition to HP_EVENT

>Does it mean that the codec can't accept the same id tag for multiple
>pins?

No, the event can be received by the event handler but there is no way to
know the event is related to which jack

>> Can  snd_jack_report used to report the mic event of two pink jacks
(front
>> panel and rear panel) of the desktop to the user space program?

> I assumed so, but someone needs to confirm.
> Assigning different tags is easy and safe, so even if it worked, we
> can go forward for individual tags.

So  the point is whether the user space program need to know

1) the event is related to the plug in or out of the front mic jack / rear
mic jack
2) whether earphone or speaker is plugged into correct/wrong jacks by
measured impedance .


 So, adding some delay like below makes it working?
>

       if (!codec->no_trigger_sense) {
>                pincap = snd_hda_query_pin_caps(codec, nid);
> -               if (pincap & AC_PINCAP_TRIG_REQ) /* need trigger? */
> +               if (pincap & AC_PINCAP_TRIG_REQ) { /* need trigger? */
>                        snd_hda_codec_read(codec, nid, 0,
>                                        AC_VERB_SET_PIN_SENSE, 0);
> +                       if (codec->trigger_delay > 0)
> +                               mdelay(codec->trigger_delay);
> +               }
>        }
>        return snd_hda_codec_read(codec, nid, 0,
>                                  AC_VERB_GET_PIN_SENSE, 0);
>

Noise appear  when delay is add at here

Have to wait until someone find a safe way to get the impedance without any
side effect


       spec->vmaster_nid = 0x04;
>
> -       codec->no_trigger_sense = 1;
> +       /* codec->no_trigger_sense = 1; */
> +       codec->trigger_delay = 5;
>        codec->no_sticky_stream = 1;
>
>        return 0;
>


So no need to change if the objective of snd_hda_jack_detect() is to get
presence detect bit

As mentioned in 729d55ba972348234759f8e40abf8d
e020f0d505

use tigger at pin-sensing seem generate a lot of responses

Is there any way to stop the measurement ?
