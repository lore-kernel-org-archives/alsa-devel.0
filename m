From: Daniel Mack <daniel@zonque.org>
Subject: Re: [PATCH] First attempt at a driver for the internal
 codec on the Allwinner A20.
Date: Wed, 02 Jul 2014 15:20:37 +0200
Message-ID: <53B40725.5030704@zonque.org>
References: <20140701153627.17679.17922.stgit@studio>
 <CAKON4OzzK-+hYWYFXPySnHuiz++6J-9PkEBzZ6eB+pHLS4vDEQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail.zonque.de (svenfoo.org [82.94.215.22])
 by alsa0.perex.cz (Postfix) with ESMTP id 05BA02650CA
 for <alsa-devel@alsa-project.org>; Wed,  2 Jul 2014 15:20:39 +0200 (CEST)
In-Reply-To: <CAKON4OzzK-+hYWYFXPySnHuiz++6J-9PkEBzZ6eB+pHLS4vDEQ@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: "jonsmirl@gmail.com" <jonsmirl@gmail.com>, alsa-devel mailing list <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

On 07/02/2014 03:05 PM, jonsmirl@gmail.com wrote:
> Missing DMA buffer was caused by missing platform_name.
> 
> static struct snd_soc_dai_link cdc_dai = {
> .name = "cdc",
> .stream_name = "CDC PCM",
> .codec_dai_name = "sunxi-codec-dai",
> .cpu_dai_name = "1c22c00.codec",
> .codec_name = "1c22c00.codec",
> .platform_name = "1c22c00.codec",
> 
> Something is still messed up...
> 
> root@linaro-developer:~# aplay x.wav
> Playing WAVE 'x.wav' : Signed 16 bit Little Endian, Rate 48000 Hz, Mono
> aplay: pcm_write:1939: write error: Input/output error
> root@linaro-developer:~#

This error is usually caused by a stuck DMA channel. IOW, the DMA
pointer is not moving forward, and after some seconds, ALSA decides that
something can't be right and shuts down the stream again.

Maybe start with adding printks to your DMA controller's IRQ routine or
something.


Daniel
