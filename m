From: cee1 <fykcee1@gmail.com>
Subject: Re: Adjust volume may cause audio playback corruption
Date: Tue, 15 May 2012 16:30:14 +0800
Message-ID: <CAGXxSxWksJ2RB1f_Cmx_H9SniLH=1dTUiv0FjarLSZe1SSgM3g@mail.gmail.com>
References: <CAGXxSxUxFbC3mGWa-pbUKrzUqsBbvoQ5PmXNrKfL2W_BXyv1_A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-pz0-f51.google.com (mail-pz0-f51.google.com
	[209.85.210.51]) by alsa0.perex.cz (Postfix) with ESMTP id 5344B24C7A
	for <alsa-devel@alsa-project.org>;
	Tue, 15 May 2012 10:30:36 +0200 (CEST)
Received: by dajt11 with SMTP id t11so9840539daj.38
	for <alsa-devel@alsa-project.org>; Tue, 15 May 2012 01:30:35 -0700 (PDT)
In-Reply-To: <CAGXxSxUxFbC3mGWa-pbUKrzUqsBbvoQ5PmXNrKfL2W_BXyv1_A@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: pulseaudio-discuss@lists.freedesktop.org, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Witch a patch[1] of PA which dumps playback PCM data, I found the
dumped data(with ./wavformat.py[2] <dumpped_data> to convert to wav
file) is not corrupted.
Since PA uses mmap to transfer PCM data, the driver's DMA buffer
should also be "good".

It seems related to HDA controller of SB710, I tried HDMI output, and
can reproduce the problem
too(http://dev.lemote.com/files/upload/software/PA-apc/HDMI-corrupted_sound=
.ogg).
2012/5/12 cee1 <fykcee1@gmail.com>:
> Hi all,
>
> We're using PA on our product, and sometimes audio playback may
> corrupt after adjusting volume.
>
> We found a way to (relatively) easily reproduce the problem:
> 1. Play sample.mp3 through totem in repeat mode.
> 2. In gnome-volume-control, Hardware tap, repeat to shift between "Off
> profile" and "Analog Stereo Duplex profile".
>
> When the problem happens, the corruption continues until I:
> * Do one more shift between "Off profile" and "Analog Stereo Duplex profi=
le".
> * Close totem (close all PA playback clients).
> * Adjust volume.
>
> When the problem happens, open another PA client doing audio playback,
> is also corrupt.
>
> Some additional information:
> * Output of alsa-info.sh on our product:
> http://dev.lemote.com/files/upload/software/PA-apc/alsa-info-lemote
> * PA daemon log:
> http://dev.lemote.com/files/upload/software/PA-apc/pulseaudio.log
> * The corrupted sound:
> http://dev.lemote.com/files/upload/software/PA-apc/corrupted_sound.ogg
> * The sample mp3: http://dev.lemote.com/files/upload/software/PA-apc/samp=
le.mp3
>
> We've tried PA 1.0-0ubuntu3, 1.1-0ubuntu15 and 2.0, the problem continues.
>
> The problem can also be reproduced on an AMD turion 64 x2 board with
> ubuntu 10.10 and ubuntu 12.04:
> * Output of alsa-info:
> =A0ubuntu 10.10(32bit)
> http://dev.lemote.com/files/upload/software/PA-apc/alsa-info-ubuntu-10.10
> =A0ubuntu 12.04(32bit)
> http://dev.lemote.com/files/upload/software/PA-apc/alsa-info-ubuntu-12.04
>
> Note:
> * The AMD turion 64 x2 board uses the same chipset as our product.
> * gnome-volume-control is removed in ubuntu 12.04, thus we compiled
> it: http://dev.lemote.com/files/upload/software/PA-apc/gnome-volume-contr=
ol

----
[1] http://dev.lemote.com/files/upload/software/PA-apc/debug/debug-alsa-sin=
k.patch
[2] http://dev.lemote.com/files/upload/software/PA-apc/debug/wavformat.py



-- =

Regards,

- cee1
