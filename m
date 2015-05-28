From: Enric Balletbo Serra <eballetbo@gmail.com>
Subject: Audio play problem with tlv320aic3106 in mainline.
Date: Thu, 28 May 2015 13:36:52 +0200
Message-ID: <CAFqH_5332TNp+3cTH6O-UgqP8Ah-ZUiZpaTJpy3ZoL4-42fo_g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-ie0-f171.google.com (mail-ie0-f171.google.com
 [209.85.223.171])
 by alsa0.perex.cz (Postfix) with ESMTP id 4EA8726500C
 for <alsa-devel@alsa-project.org>; Thu, 28 May 2015 13:36:53 +0200 (CEST)
Received: by iesa3 with SMTP id a3so35845845ies.2
 for <alsa-devel@alsa-project.org>; Thu, 28 May 2015 04:36:52 -0700 (PDT)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
Cc: Lars-Peter Clausen <lars@metafoo.de>, Takashi Iwai <tiwai@suse.de>, Liam Girdwood <lgirdwood@gmail.com>, Jyri Sarha <jsarha@ti.com>, Peter Ujfalusi <peter.ujfalusi@ti.com>, Mark Brown <broonie@kernel.org>
List-Id: alsa-devel@alsa-project.org

Dear all,

Recently I sent some patches to add support for a new board based on
AM335x processor [1]. The board has the TLV320AIC3106 audio codec, the
MCLK signal is provided by an external oscillator of 12MHz. The
problem is that when I play a wav file for example I heard the song a
double speed. This is with v4.0 and current mainline.

In dts file I defined "ti,codec-clock-rate = <12000000>;" which is the
correct value. Curiously when I changed the clock rate value to
24000000 I heard the song at normal speed. AFAIK the correct value for
clock-rate is 12MHz so I suspect that something is wrong in the
driver, maybe it sets a wrong clock divider/multiplier ? Anyone can
point me in the right direction to fix the issue ? I see that
am335x-evm and am335x-pepper boards also uses this audio codec, did
anyone with those boards have the same problem?

[1] https://patchwork.kernel.org/patch/6480071/

Thanks in advance,
Enric
