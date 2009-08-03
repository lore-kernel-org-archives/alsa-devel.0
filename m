From: javier Martin <javier.martin@vista-silicon.com>
Subject: Re: ASoC: DMA and SSI drivers for i.MX27
Date: Mon, 3 Aug 2009 12:31:51 +0200
Message-ID: <eedb5540908030331v58488bfif018921f826c232c@mail.gmail.com>
References: <eedb5540908030205t602cf2c6j32267ab548e34609@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from ey-out-1920.google.com (ey-out-1920.google.com [74.125.78.148])
	by alsa0.perex.cz (Postfix) with ESMTP id 2C589246D0
	for <alsa-devel@alsa-project.org>;
	Mon,  3 Aug 2009 12:31:52 +0200 (CEST)
Received: by ey-out-1920.google.com with SMTP id 13so761600eye.56
	for <alsa-devel@alsa-project.org>; Mon, 03 Aug 2009 03:31:51 -0700 (PDT)
In-Reply-To: <eedb5540908030205t602cf2c6j32267ab548e34609@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
Cc: Mark Brown <broonie@sirena.org.uk>
List-Id: alsa-devel@alsa-project.org

2009/8/3 javier Martin <javier.martin@vista-silicon.com>:
> As I described in one of my previous mails, I have been trying to port
> an old ASoC driver for kernel 2.6.22 to latest stable 2.6.30 kernel.
> I am currently facing a big problem which make some repeated samples
> appear with a regular pattern:
> - frequency of bad samples = 2 * period_size
> - bad samples in audio stream are taken from "buffer_size" samples
> back in the original file.
>
> You can reproduce this with:
> aplay -t raw -f S16_LE -r8000 8k16bitpcm.wav
>
> (http://en.wikipedia.org/wiki/WAV to get this file)
>
> Here I submit two patches:
> - One which adds ssi and dma drivers plus a custom machine driver
> (imx27asoc_list.patch).
> - Another patch which adds wm8974 codec support taken from ASoC
> wm8974-upstream branch (wm8974_list.patch).
>
> Note that the machine driver attached uses wm8974 codec, thus second
> patch is needed. Please, note also that patches are currently quite
> dirty, and in an early development state. The purpose of this mail is
> not to even consider to include them in any branch right now, but to
> gather some help to solve the problem. As soon as I have it solved I
> will clean all the stuff and try to prepare it for mainline.
>
>
>
> --
> Javier Martin
> Vista Silicon S.L.
> Universidad de Cantabria
> CDTUC - FASE C - Oficina S-345
> Avda de los Castros s/n
> 39005- Santander. Cantabria. Spain
> +34 942 25 32 60
> www.vista-silicon.com
>

I was doing some random tests and I have found that using "-M" option
in aplay makes it work fine. It seems a problem of performance when
not using mmap.

I don't know if you have something to comment about this.

Thanks.

-- 
Javier Martin
Vista Silicon S.L.
Universidad de Cantabria
CDTUC - FASE C - Oficina S-345
Avda de los Castros s/n
39005- Santander. Cantabria. Spain
+34 942 25 32 60
www.vista-silicon.com
