From: Fabio Estevam <festevam@gmail.com>
Subject: Re: iMX6UL EVK with kernel 4.6
Date: Sun, 1 May 2016 16:22:13 -0300
Message-ID: <CAOMZO5Am7xQS556TpX5Xjk5s19CjMzH=+roY7jPhmRD25fiEvQ@mail.gmail.com>
References: <50f27095-3304-03fa-7209-3f05baccb346@jikos.cz>
 <CAOMZO5BU2--_CV8FUsvkkesKGLW9NcnDPNvxC7UnK5vWwgDqVQ@mail.gmail.com>
 <CAOMZO5BGDnECdRFU6XFws9poNyF-yGJbv=io43mQgcqO4L-fbw@mail.gmail.com>
 <0721dbbe-a122-6be3-743f-669672b2c83f@jikos.cz>
 <CAOMZO5BM-EM0s5zWUmbRMkzV11Az9D+KLmQJ7dgv_RvKX9mihg@mail.gmail.com>
 <e163b954-0c4b-b859-0e15-ea113d2f5ddd@jikos.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-ig0-f175.google.com (mail-ig0-f175.google.com
 [209.85.213.175])
 by alsa0.perex.cz (Postfix) with ESMTP id 4DE902604DF
 for <alsa-devel@alsa-project.org>; Sun,  1 May 2016 21:22:14 +0200 (CEST)
Received: by mail-ig0-f175.google.com with SMTP id s8so59523723ign.0
 for <alsa-devel@alsa-project.org>; Sun, 01 May 2016 12:22:14 -0700 (PDT)
In-Reply-To: <e163b954-0c4b-b859-0e15-ea113d2f5ddd@jikos.cz>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Petr Kulhavy <brain@jikos.cz>
Cc: Nicolin Chen <nicoleotsuka@gmail.com>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, Timur Tabi <timur@tabi.org>
List-Id: alsa-devel@alsa-project.org

On Sun, May 1, 2016 at 3:59 PM, Petr Kulhavy <brain@jikos.cz> wrote:

> I have not tried setting the bit 20 of the GPR1 register. How would that be
> set?

If you have memtool installed in your rootfs:

./memtool -32 20E4004=0F560005

You can do this via bootloader prompt or via devmem2 in the Linux prompt.

Without this MCLK will not be out.

>
> Both the 3.x and 4.1 work for me. However you need to set the headphone
> volume to non-zero and especially the pcm output mixer (unmute),
> otherwise the audio path is not routed through and the codec is switched off
> due to power saving (and generates no bclk and lrclk).
> This confused me as well, but after setting the mixer playback stasrts
> working with the Freescale kernel.

I was putting the volume to a suitable value, but didn't touch PCM output mixer.

I see in alsamixer: "PCM Playback -6dB [Off]", but it does not allow
me to change this setting though.
