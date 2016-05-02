From: Fabio Estevam <festevam@gmail.com>
Subject: Re: iMX6UL EVK with kernel 4.6
Date: Mon, 2 May 2016 16:53:53 -0300
Message-ID: <CAOMZO5DY9BVJXXemW7-jdTDXeiEN6WukmkLJ8uWjSke3shf=BA@mail.gmail.com>
References: <50f27095-3304-03fa-7209-3f05baccb346@jikos.cz>
 <CAOMZO5BU2--_CV8FUsvkkesKGLW9NcnDPNvxC7UnK5vWwgDqVQ@mail.gmail.com>
 <CAOMZO5BGDnECdRFU6XFws9poNyF-yGJbv=io43mQgcqO4L-fbw@mail.gmail.com>
 <0721dbbe-a122-6be3-743f-669672b2c83f@jikos.cz>
 <CAOMZO5BM-EM0s5zWUmbRMkzV11Az9D+KLmQJ7dgv_RvKX9mihg@mail.gmail.com>
 <e163b954-0c4b-b859-0e15-ea113d2f5ddd@jikos.cz>
 <CAOMZO5Am7xQS556TpX5Xjk5s19CjMzH=+roY7jPhmRD25fiEvQ@mail.gmail.com>
 <3bede708-4c7c-dfae-fb26-c20a42289836@jikos.cz>
 <CAOMZO5CbtgcencL7UTk8HUmJwEd7HuLDSNNGuLA0UUn5Grxdig@mail.gmail.com>
 <CAOMZO5Bjg6b4prxMDsJPceYGMv3kL+0fQ4Acm8bjAa=Ey728+g@mail.gmail.com>
 <CAOMZO5DKeAN2bBOHz+yc0JtLpDeQdh+fhz2_SR-3FsDkgJR-Bw@mail.gmail.com>
 <4cc213b7-8e4e-c47c-1ac9-57a3bf1b91b7@jikos.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-io0-f172.google.com (mail-io0-f172.google.com
 [209.85.223.172])
 by alsa0.perex.cz (Postfix) with ESMTP id 19C9B260438
 for <alsa-devel@alsa-project.org>; Mon,  2 May 2016 21:53:55 +0200 (CEST)
Received: by mail-io0-f172.google.com with SMTP id d62so2483453iof.2
 for <alsa-devel@alsa-project.org>; Mon, 02 May 2016 12:53:55 -0700 (PDT)
In-Reply-To: <4cc213b7-8e4e-c47c-1ac9-57a3bf1b91b7@jikos.cz>
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

On Mon, May 2, 2016 at 4:30 PM, Petr Kulhavy <brain@jikos.cz> wrote:

> Mine plays at the correct speed. For the correct speed the clock assignment
> from the Freescale DTS needs to be copied, so that the SAI2 clock generates
> 12.288MHz.
> Below are the relevant nodes from my DTS:
>
> &clks {
>         assigned-clocks = <&clks IMX6UL_CLK_PLL4_AUDIO_DIV>;
>         assigned-clock-rates = <786432000>;
> };

That was the part I was missing, thanks!

It plays correctly now, but I get this error message from the wm8960 driver:

$ aplay /home/clarinet.wav
[   55.007221] wm8960 1-001a: failed to configure clock
[   55.012583] wm8960 1-001a: ASoC: Failed to prepare bias: -22

Do you see this too?

>> 2. Find a proper way to enable MCLK.
>>
>
> I would tend to put the control of the SAIx_MCLK_DIR into the SAI driver and
> if needed add an extra boolean property like "enable-mclk-output".

Yes, I think this makes sense.

I will propose some patches today or tomorrow and will keep you on Cc.

Thanks for the cooperation :-)
