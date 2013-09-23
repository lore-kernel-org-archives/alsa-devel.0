From: Fabio Estevam <festevam@gmail.com>
Subject: fsl_ssi: Cannot do simultaneous capture and playback
Date: Sun, 22 Sep 2013 23:05:03 -0300
Message-ID: <CAOMZO5CPmYtzbR0Ahn5STKwPO_NnC=n314gJtj3WciUonXuqaQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-ve0-f172.google.com (mail-ve0-f172.google.com
 [209.85.128.172])
 by alsa0.perex.cz (Postfix) with ESMTP id E75852650D4
 for <alsa-devel@alsa-project.org>; Mon, 23 Sep 2013 04:05:04 +0200 (CEST)
Received: by mail-ve0-f172.google.com with SMTP id oz11so1863031veb.17
 for <alsa-devel@alsa-project.org>; Sun, 22 Sep 2013 19:05:04 -0700 (PDT)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@kernel.org>, Lars-Peter Clausen <lars@metafoo.de>, Shawn Guo <shawn.guo@linaro.org>, Sascha Hauer <kernel@pengutronix.de>, Nicolin Chen <b42378@freescale.com>
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

Hi,

I am trying to do simultaneous capture and playback on mx6 wandboard
and I noticed that it only works if I run 'aplay first'.

Here is the sequence that works:

1) aplay file.wav

2) Run 'alsamixer' and select line-in in the capture tab

3) Connect audio via line-in input

4) arecord -f cd -c 2 | aplay -f cd

Then I am able to hear the playback.

However, if I do not do step 1, and try to do the arecord/aplay directly I get:

$ arecord -f cd  | aplay -f cd
imx-sgtl5000 sound.13: set sample size in capture stream first
fsl-ssi-dai 2028000.ssi: ASoC: can't open interface 2028000.ssi: -11
ALSA lib pcm_dmix.c:1018:(snd_pcm_dmix_
open) unable to open slave
aplay: main:660: audio open error: Device or resource busy
Recording WAVE 'stdin' : Signed 16 bit Little Endian, Rate 44100 Hz, Stereo

I will try to debug this, but if anyone has any suggestions, please let me know.

Thanks,

Fabio Estevam
