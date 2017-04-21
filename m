From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH 2/2] ASoC: codec: wm8960: Relax bit clock
 computation when using PLL
Date: Fri, 21 Apr 2017 16:44:25 +0200
Message-ID: <CAK8P3a3n-pzaPkyximnW8kt8HXS=gjtGtf_j=at-1Ea=gbkD-A@mail.gmail.com>
References: <1492780055-4892-1-git-send-email-daniel.baluta@nxp.com>
 <1492780055-4892-3-git-send-email-daniel.baluta@nxp.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-oi0-f52.google.com (mail-oi0-f52.google.com
 [209.85.218.52])
 by alsa0.perex.cz (Postfix) with ESMTP id 8D10F266F52
 for <alsa-devel@alsa-project.org>; Fri, 21 Apr 2017 16:44:26 +0200 (CEST)
Received: by mail-oi0-f52.google.com with SMTP id y11so65878590oie.0
 for <alsa-devel@alsa-project.org>; Fri, 21 Apr 2017 07:44:26 -0700 (PDT)
In-Reply-To: <1492780055-4892-3-git-send-email-daniel.baluta@nxp.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Daniel Baluta <daniel.baluta@nxp.com>
Cc: alsa-devel@alsa-project.org, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, patches@opensource.wolfsonmicro.com, tiwai@suse.com, Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, Charles Keepax <ckeepax@opensource.wolfsonmicro.com>
List-Id: alsa-devel@alsa-project.org

On Fri, Apr 21, 2017 at 3:07 PM, Daniel Baluta <daniel.baluta@nxp.com> wrote:
> Bitclk is derived from sysclk using bclk_divs.
> Sysclk can be derived in two ways:
>         (1) directly from MLCK
>         (2) MCLK via PLL
>
> Commit 3c01b9ee2ab9d0d ("ASoC: codec: wm8960: Relax bit clock
> computation")
> relaxed bitclk computation when sysclk is directly derived from MCLK.
>
> Lets do the same thing when sysclk is derived via PLL.
>
> Signed-off-by: Daniel Baluta <daniel.baluta@nxp.com>
> ---
> Here, I forced the following harmless initialization:
>
>         *sysclk_idx = *dac_idx = *bclk_idx = -1;
>
> otherwise I would trigger a gcc false positive warning:
>
> sound/soc/codecs/wm8960.c: In function 'wm8960_configure_clocking':
> sound/soc/codecs/wm8960.c:810:46: warning: 'j' may be used uninitialized
> in this function [-Wmaybe-uninitialized]
>   snd_soc_update_bits(codec, WM8960_CLOCK1, 0x7 << 6, j << 6);
>                                             ~~^~~~
> sound/soc/codecs/wm8960.c:806:44: warning: 'i' may be used uninitialized
> in this function [-Wmaybe-uninitialized]
> snd_soc_update_bits(codec, WM8960_CLOCK1, 3 << 1, i << 1);
>                                           ~~^~~~

I saw the same warning earlier, but it was gone after the rework
I posted the other day. Please try if that works for you as well, I think
that would be better than a bogus initialization.

       Arnd
