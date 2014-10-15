From: Anatol Pomozov <anatol.pomozov@gmail.com>
Subject: Re: [PATCH v2] ASoC: rt5677: Support DSP function for
 VAD application
Date: Wed, 15 Oct 2014 14:04:10 -0700
Message-ID: <CAOMFOmXMJm2gxnZSq9vLqTf-1Jmrk8b-R7SvK0J4RSOkwi8P-g@mail.gmail.com>
References: <1412584251-29167-1-git-send-email-oder_chiou@realtek.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-vc0-f178.google.com (mail-vc0-f178.google.com
 [209.85.220.178])
 by alsa0.perex.cz (Postfix) with ESMTP id 888B7260432
 for <alsa-devel@alsa-project.org>; Wed, 15 Oct 2014 23:04:11 +0200 (CEST)
Received: by mail-vc0-f178.google.com with SMTP id hq12so1662375vcb.23
 for <alsa-devel@alsa-project.org>; Wed, 15 Oct 2014 14:04:10 -0700 (PDT)
In-Reply-To: <1412584251-29167-1-git-send-email-oder_chiou@realtek.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Oder Chiou <oder_chiou@realtek.com>
Cc: Bard Liao <bardliao@realtek.com>, alsa-devel@alsa-project.org, broonie@kernel.org, Liam Girdwood <lgirdwood@gmail.com>, flove@realtek.com
List-Id: alsa-devel@alsa-project.org

Hi

On Mon, Oct 6, 2014 at 1:30 AM, Oder Chiou <oder_chiou@realtek.com> wrote:
> The ALC5677 has a programmable DSP, and there is a SPI that is dadicated for DSP
> firmware loading. Therefore, the patch includes a SPI driver for writing the DSP
> firmware. The VAD(Voice Activaty Detection) has be implemented and use the DSP to
> recognize the key phase.
>
> Signed-off-by: Oder Chiou <oder_chiou@realtek.com>
> ---
>  sound/soc/codecs/Makefile     |   2 +-
>  sound/soc/codecs/rt5677-spi.c | 129 +++++++++++++++++++
>  sound/soc/codecs/rt5677-spi.h |  21 +++
>  sound/soc/codecs/rt5677.c     | 288 +++++++++++++++++++++++++++++++++++++++++-
>  sound/soc/codecs/rt5677.h     |   6 +
>  5 files changed, 441 insertions(+), 5 deletions(-)
>  create mode 100644 sound/soc/codecs/rt5677-spi.c
>  create mode 100644 sound/soc/codecs/rt5677-spi.h

I am trying to compile rt5677 topic branch from Mark's repo and I get
following linking problem

  LD [M]  sound/soc/codecs/snd-soc-rt5670.o
  LD [M]  sound/soc/codecs/snd-soc-rt5677.o
sound/soc/codecs/rt5677-spi.o: In function `init_module':
rt5677-spi.c:(.init.text+0x0): multiple definition of `init_module'
sound/soc/codecs/rt5677.o:rt5677.c:(.init.text+0x0): first defined here
sound/soc/codecs/rt5677-spi.o: In function `cleanup_module':
rt5677-spi.c:(.exit.text+0x0): multiple definition of `cleanup_module'
sound/soc/codecs/rt5677.o:rt5677.c:(.exit.text+0x0): first defined here
make[3]: *** [sound/soc/codecs/snd-soc-rt5677.o] Error 1
make[2]: *** [sound/soc/codecs] Error 2
make[1]: *** [sound/soc] Error 2
make[1]: *** Waiting for unfinished jobs....

I use CONFIG_SND_SOC_ALL_CODEC.
