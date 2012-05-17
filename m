From: cee1 <fykcee1@gmail.com>
Subject: Re: Adjust volume may cause audio playback corruption
Date: Thu, 17 May 2012 17:15:24 +0800
Message-ID: <CAGXxSxWQbySMzKXssQZLfW+Ppi97-DRCHgV_7qFGWhvu3mmLZw@mail.gmail.com>
References: <CAGXxSxUxFbC3mGWa-pbUKrzUqsBbvoQ5PmXNrKfL2W_BXyv1_A@mail.gmail.com>
	<CAGXxSxWksJ2RB1f_Cmx_H9SniLH=1dTUiv0FjarLSZe1SSgM3g@mail.gmail.com>
	<s5hehqlddoq.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-pb0-f51.google.com (mail-pb0-f51.google.com
	[209.85.160.51]) by alsa0.perex.cz (Postfix) with ESMTP id 4FBF924355
	for <alsa-devel@alsa-project.org>;
	Thu, 17 May 2012 11:15:47 +0200 (CEST)
Received: by pbbrp16 with SMTP id rp16so2863429pbb.38
	for <alsa-devel@alsa-project.org>; Thu, 17 May 2012 02:15:44 -0700 (PDT)
In-Reply-To: <s5hehqlddoq.wl%tiwai@suse.de>
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
Cc: alsa-devel@alsa-project.org, pulseaudio-discuss@lists.freedesktop.org
List-Id: alsa-devel@alsa-project.org

Hi,

Thanks for reply.
2012/5/15 Takashi Iwai <tiwai@suse.de>
>
> At Tue, 15 May 2012 16:30:14 +0800,
> cee1 wrote:
> >
> > Witch a patch[1] of PA which dumps playback PCM data, I found the
> > dumped data(with ./wavformat.py[2] <dumpped_data> to convert to wav
> > file) is not corrupted.
> > Since PA uses mmap to transfer PCM data, the driver's DMA buffer
> > should also be "good".
> >
> > It seems related to HDA controller of SB710, I tried HDMI output, and
> > can reproduce the problem
> > too(http://dev.lemote.com/files/upload/software/PA-apc/HDMI-corrupted_s=
ound.ogg).
>
> If you are using the recent kernel, try snoop=3Doff option of
> snd-hda-intel driver. =A0The recent AMD and VIA controllers are known to
> work with the non-snooping mode.

I'm trying=A0snd-hda-intel.snoop=3D0 under ubuntu10.10(32bit) with kernel
from ubuntu 12.04(32bit), I still can reproduce it.

BTW, what is difference between snoop and no snoop?
Enable no snoop mode will render no sound on our platform(which is
mips compatible).



----
Regards,
cee1
