From: Dennis Mungai <dmngaie@gmail.com>
Subject: Re: The SPDIF light on the Eurocom Q6 (Clevo
 P95xER-series) is always on
Date: Sat, 23 Jun 2018 03:54:09 +0300
Message-ID: <CAKKYfmEJk0jsZn2yMvpzpUmwsYXJt7cLfyj7KwACkr3+qRGxng@mail.gmail.com>
References: <CAKKYfmGwTxx2pArezdg7mdmH31-S+K0vP=67A+7T66Rg584hkQ@mail.gmail.com>
 <s5h602a3of2.wl-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-io0-f196.google.com (mail-io0-f196.google.com
 [209.85.223.196])
 by alsa0.perex.cz (Postfix) with ESMTP id 230192670D7
 for <alsa-devel@alsa-project.org>; Sat, 23 Jun 2018 02:54:51 +0200 (CEST)
Received: by mail-io0-f196.google.com with SMTP id r24-v6so7626701ioh.9
 for <alsa-devel@alsa-project.org>; Fri, 22 Jun 2018 17:54:51 -0700 (PDT)
In-Reply-To: <s5h602a3of2.wl-tiwai@suse.de>
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

Hello Takashi,

Running amixer -c0 cset iface=mixer,name='IEC958 Playback Switch',index=16
off turns off the SPDIF light.

If I may ask, with this model, the primary sound card shows up as the
ALC1120:

cat /proc/asound/car*/co* |  grep Codec
Codec: Realtek ALC1220
Codec: Intel Kabylake HDMI
Codec: Nvidia GPU 83 HDMI/DP

Would a model override via:

options snd-hda-intel model={model_name}

in /etc/modprobe.d/alsa-base.conf using a model name from
https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable.git/tree/Documentation/sound/hd-audio/models.rst
be applied to work around the issue above?

Also, does turning off the SPDIF light as shown above disable SDPIF output?

Regards,

Dennis.





On 22 June 2018 at 17:07, Takashi Iwai <tiwai@suse.de> wrote:

> On Fri, 22 Jun 2018 01:29:33 +0200,
> Dennis Mungai wrote:
> >
> > Hello there,
> >
> > As stated in the subject, the SPDIF light on the machine is always on,
> and
> > this is only when I boot into Linux.
> >
> > Output from alsa-info:
> > http://www.alsa-project.org/db/?f=29b57d6465130b92dd70360150aad5
> 28cfb85f92
> >
> > I can get both the internal audio + headphone jack to work by editing
> > /usr/share/pulseaudio/alsa-mixer/paths/iec958-stereo-output.conf and
> adding:
>
> Try to run like:
>   amixer -c0 cset iface=mixer,name='IEC958 Playback Switch',index=16 off
>
> Does this turn off the SPDIF light?
>
>
> Takashi
>
