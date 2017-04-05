From: Daniel Baluta <daniel.baluta@gmail.com>
Subject: Re: [PATCH 1/2] ASoC: codec: wm9860: Refactor PLL out
 freq search
Date: Wed, 5 Apr 2017 13:02:59 +0300
Message-ID: <CAEnQRZAFPZYHNwmsaJ_4q1S-EaathwtEp=5fCS9Huu6qoZb3Hg@mail.gmail.com>
References: <1491324314-27067-1-git-send-email-daniel.baluta@nxp.com>
 <1491324314-27067-2-git-send-email-daniel.baluta@nxp.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-it0-f47.google.com (mail-it0-f47.google.com
 [209.85.214.47])
 by alsa0.perex.cz (Postfix) with ESMTP id 977352668F6
 for <alsa-devel@alsa-project.org>; Wed,  5 Apr 2017 12:03:01 +0200 (CEST)
Received: by mail-it0-f47.google.com with SMTP id a140so5627209ita.0
 for <alsa-devel@alsa-project.org>; Wed, 05 Apr 2017 03:03:01 -0700 (PDT)
In-Reply-To: <1491324314-27067-2-git-send-email-daniel.baluta@nxp.com>
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
Cc: alsa-devel@alsa-project.org, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, shengjiu.wang@nxp.com, patches@opensource.wolfsonmicro.com, Takashi Iwai <tiwai@suse.com>, Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, viorel.suman@nxp.com, mihai.serban@nxp.com, Charles Keepax <ckeepax@opensource.wolfsonmicro.com>
List-Id: alsa-devel@alsa-project.org

On Tue, Apr 4, 2017 at 7:45 PM, Daniel Baluta <daniel.baluta@nxp.com> wrote:
> Add a separate function for deriving (sysclk, lrclk, bclk)
> when the clock is auto or pll.
>
> Signed-off-by: Daniel Baluta <daniel.baluta@nxp.com>

Just noticed this warnings:

sound/soc/codecs/wm8960.c:743:3: warning: 'best_freq_out' may be used
uninitialized in this function [-Wmaybe-uninitialized]
   wm8960_set_pll(codec, freq_in, best_freq_out);
   ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
sound/soc/codecs/wm8960.c:703:21: note: 'best_freq_out' was declared here
  int diff, closest, best_freq_out;
                     ^~~~~~~~~~~~~
sound/soc/codecs/wm8960.c:806:46: warning: 'j' may be used
uninitialized in this function [-Wmaybe-uninitialized]
  snd_soc_update_bits(codec, WM8960_CLOCK1, 0x7 << 6, j << 6);
                                            ~~^~~~
sound/soc/codecs/wm8960.c:802:44: warning: 'i' may be used
uninitialized in this function [-Wmaybe-uninitialized]
  snd_soc_update_bits(codec, WM8960_CLOCK1, 3 << 1, i << 1);


There is no way I can end up with these variable uninitialized. Will
look more close and resend.

Thanks Charles for review.
