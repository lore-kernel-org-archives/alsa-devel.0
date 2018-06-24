From: Dennis Mungai <dmngaie@gmail.com>
Subject: Re: The SPDIF light on the Eurocom Q6 (Clevo
 P95xER-series) is always on
Date: Sun, 24 Jun 2018 03:25:45 +0300
Message-ID: <CAKKYfmGmVugUSkwaCR4azYwDOz5EwLzELtBWMyNkNPcKGnmU-w@mail.gmail.com>
References: <CAKKYfmGwTxx2pArezdg7mdmH31-S+K0vP=67A+7T66Rg584hkQ@mail.gmail.com>
 <s5h602a3of2.wl-tiwai@suse.de>
 <CAKKYfmEJk0jsZn2yMvpzpUmwsYXJt7cLfyj7KwACkr3+qRGxng@mail.gmail.com>
 <s5htvpte8iv.wl-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-it0-f67.google.com (mail-it0-f67.google.com
 [209.85.214.67])
 by alsa0.perex.cz (Postfix) with ESMTP id DD832266E0E
 for <alsa-devel@alsa-project.org>; Sun, 24 Jun 2018 02:25:57 +0200 (CEST)
Received: by mail-it0-f67.google.com with SMTP id m194-v6so7668212itg.2
 for <alsa-devel@alsa-project.org>; Sat, 23 Jun 2018 17:25:57 -0700 (PDT)
In-Reply-To: <s5htvpte8iv.wl-tiwai@suse.de>
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

Thank you for the clarification.

On Sat, Jun 23, 2018, 20:07 Takashi Iwai <tiwai@suse.de> wrote:

> On Sat, 23 Jun 2018 02:54:09 +0200,
> Dennis Mungai wrote:
> >
> > Hello Takashi,
> >
> > Running amixer -c0 cset iface=mixer,name='IEC958 Playback
> Switch',index=16
> > off turns off the SPDIF light.
>
> And is the SPDIF light turned on again by some other action?
>
> > If I may ask, with this model, the primary sound card shows up as the
> > ALC1120:
> >
> > cat /proc/asound/car*/co* |  grep Codec
> > Codec: Realtek ALC1220
> > Codec: Intel Kabylake HDMI
> > Codec: Nvidia GPU 83 HDMI/DP
> >
> > Would a model override via:
> >
> > options snd-hda-intel model={model_name}
> >
> > in /etc/modprobe.d/alsa-base.conf using a model name from
> >
> https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable.git/tree/Documentation/sound/hd-audio/models.rst
> > be applied to work around the issue above?
>
> No, this has nothing to do with the model.
> It's only the question who turned on the mixer.
>
> > Also, does turning off the SPDIF light as shown above disable SDPIF
> output?
>
> Yes.
>
>
> Takashi
>
