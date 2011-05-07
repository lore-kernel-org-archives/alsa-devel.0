From: Raymond Yau <superquad.vortex2@gmail.com>
Subject: Re: Multistreaming Playback using Front Panel
	Headphone with realtek codec
Date: Sat, 7 May 2011 11:48:19 +0800
Message-ID: <BANLkTin0hV2gKHVk1xzKKszy_tPmvGNYFw@mail.gmail.com>
References: <BANLkTimSTYjZoMACA4PoLJa0swo3L2_e4Q@mail.gmail.com>
	<s5hoc3hmq0b.wl%tiwai@suse.de>
	<BANLkTinz8=YMH0sE35abu_cneaJpra_eEg@mail.gmail.com>
	<s5hr58cieiv.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-fx0-f51.google.com (mail-fx0-f51.google.com
	[209.85.161.51])
	by alsa0.perex.cz (Postfix) with ESMTP id 509B6103807
	for <alsa-devel@alsa-project.org>;
	Sat,  7 May 2011 05:48:20 +0200 (CEST)
Received: by fxm5 with SMTP id 5so3122303fxm.38
	for <alsa-devel@alsa-project.org>; Fri, 06 May 2011 20:48:20 -0700 (PDT)
In-Reply-To: <s5hr58cieiv.wl%tiwai@suse.de>
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

2011/5/6 Takashi Iwai <tiwai@suse.de>

>
> >
> > Use "Independent HP" just because patch_via.c already used it so it is
> > better to use a standard name for all hda codecs
>
> Yeah, I know.  But this name is confusing, so better to change in
> patch_via.c as well.
>
>
> Takashi
>

To force pulseaudio to get the correct subdevice for via codec, you may need
to add "subdevice 0" to HDA-intel.conf

since subdevice 0 support multichannel but subdevice 1 only support stereo


    playback.pcm {
        type softvol
        slave.pcm {
            type hw
            card $CARD
+          subdevice 0
        }
        control {
            name "PCM Playback Volume"
            card $CARD
        }
    }

HDA-Intel.pcm.surround40.0 cards.HDA-Intel.pcm.front.0
HDA-Intel.pcm.surround51.0 cards.HDA-Intel.pcm.front.0
HDA-Intel.pcm.surround71.0 cards.HDA-Intel.pcm.front.0
