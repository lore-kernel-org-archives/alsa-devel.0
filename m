From: Max Filippov <jcmvbkbc@gmail.com>
Subject: Customizing simple audio card?
Date: Fri, 24 Oct 2014 17:31:43 +0400
Message-ID: <CAMo8BfLfMEwTqLnSt+WnzdrbRh0kh1hCYxj6u-xxwrKotiWx3Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-ob0-f178.google.com (mail-ob0-f178.google.com
 [209.85.214.178])
 by alsa0.perex.cz (Postfix) with ESMTP id 5552226055A
 for <alsa-devel@alsa-project.org>; Fri, 24 Oct 2014 15:31:45 +0200 (CEST)
Received: by mail-ob0-f178.google.com with SMTP id wn1so311534obc.37
 for <alsa-devel@alsa-project.org>; Fri, 24 Oct 2014 06:31:44 -0700 (PDT)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org, Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
List-Id: alsa-devel@alsa-project.org

Hello,

I'm developing ALSA driver for sound hardware on Xtensa FPGA boards.
The hardware is very simple, we have AIC23 codec connected to I2S bus
and I2S bus master that pumps data pushed by CPU into its FIFO.
Both are connected to the same clock synthesizer output. There are no other
devices that need to be supported now.

Due to its simplicity the setup could happily use the simple sound card driver.
But to support both 44100 and 48000 frequency ranges I need to change master
clock, setting it either to 11289600 or to 12288000 Hz. I can do it in the I2S
driver, but I see no way to inform audio codec of that change. I used
the following
hack to debug everything with the simple audio card:

diff --git a/sound/soc/generic/simple-card.c b/sound/soc/generic/simple-card.c
index cef7776..abef5ed 100644
--- a/sound/soc/generic/simple-card.c
+++ b/sound/soc/generic/simple-card.c
@@ -43,6 +44,22 @@ static int asoc_simple_card_hw_params(struct
snd_pcm_substream *substream,
                                             SND_SOC_CLOCK_IN);
        }

+       switch (params_rate(params)) {
+       case 48000:
+       case 32000:
+       case 16000:
+       case 8000:
+               ret = snd_soc_dai_set_sysclk(codec_dai, 0, 12288000,
+                                            SND_SOC_CLOCK_IN);
+               break;
+       case 44100:
+       case 22050:
+       case 11025:
+               ret = snd_soc_dai_set_sysclk(codec_dai, 0, 11289600,
+                                            SND_SOC_CLOCK_IN);
+               break;
+
+       }
        return ret;
 }

but that's of course not a solution. So my question is is there any way I can
subclass or inherit from the simple audio card driver to add such functionality
to it?

-- 
Thanks.
-- Max
