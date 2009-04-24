From: Lee Revell <rlrevell@joe-job.com>
Subject: Re: Problem bringing up new alsa driver
Date: Fri, 24 Apr 2009 00:40:19 -0400
Message-ID: <75b66ecd0904232140x3d59b726sf4474146697402f7@mail.gmail.com>
References: <9e4733910904231050p76caeeacn89d65c17f0c12408@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from yx-out-1718.google.com (yx-out-1718.google.com [74.125.44.156])
	by alsa0.perex.cz (Postfix) with ESMTP id 64813244AC
	for <alsa-devel@alsa-project.org>;
	Fri, 24 Apr 2009 06:40:20 +0200 (CEST)
Received: by yx-out-1718.google.com with SMTP id 6so647305yxn.2
	for <alsa-devel@alsa-project.org>; Thu, 23 Apr 2009 21:40:19 -0700 (PDT)
In-Reply-To: <9e4733910904231050p76caeeacn89d65c17f0c12408@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Jon Smirl <jonsmirl@gmail.com>
Cc: alsa-devel mailing list <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

2009/4/23 Jon Smirl <jonsmirl@gmail.com>:
> My new ALSA driver is playing the first three samples in a loop. It's
> not progressing forward in the wav file. =A0It's behaving like I'm not
> calling snd_pcm_period_elapsed() but I have a printk() in it so I'm
> sure it is being called. Later samples are not getting copied into the
> DMA buffer,
>
> Can anyone give me a clue as to what to look for?
>
> root@phyCORE-MPC5200B-tiny:~ aplay phone.wav
> snd_pcm_playback_open
> snd_pcm_open
> snd_pcm_open_file
> snd_pcm_open_substream
> mpc5200-psc-ac97 f0002200.sound: psc_dma_startup(substream=3Dc78bd800)
> mpc5200-psc-ac97 f0002200.sound: psc_dma_pcm_open(substream=3Dc78bd800)
> Playing WAVE 'phone.wav' : Signed 16 bit Little Endian, Rate 44100 Hz, St=
ereo
> mpc5200-psc-ac97 f0002200.sound:
> psc_ac97_hw_analog_params(substream=3Dc78bd800) p_size=3D5513
> p_bytes=3D22052 periods=3D3 buffer_size=3D22050 =A0buffer_bytes=3D88200

Your buffer is 4x the period size, but periods=3D3.  Off by one error somew=
here?

Lee
