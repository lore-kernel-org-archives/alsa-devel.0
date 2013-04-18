From: Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>
Subject: [RFC] ASoC: Current state of Dynamic PCM API
Date: Thu, 18 Apr 2013 14:07:07 +0200
Message-ID: <CABJ1b_QQS7amB3jTMvKGsJAC-QuPj4DmPNg-1waAqgC-Y8Ry7A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-oa0-f41.google.com (mail-oa0-f41.google.com
 [209.85.219.41])
 by alsa0.perex.cz (Postfix) with ESMTP id 6A997265E7E
 for <alsa-devel@alsa-project.org>; Thu, 18 Apr 2013 14:07:08 +0200 (CEST)
Received: by mail-oa0-f41.google.com with SMTP id g12so1714723oah.28
 for <alsa-devel@alsa-project.org>; Thu, 18 Apr 2013 05:07:07 -0700 (PDT)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>
Cc: Peter Ujfalusi <peter.ujfalusi@ti.com>, alsa-devel@alsa-project.org, Mark Brown <broonie@opensource.wolfsonmicro.com>, Liam Girdwood <lrg@slimlogic.co.uk>
List-Id: alsa-devel@alsa-project.org

Hi,

I am rewriting Marvell Kirkwood ASoC driver to also support Dove and
reflect the audio controller's capabilities. The audio controller can
have one DMA stream for playback and capture respectively. While capture
source can be either I2S or SPDIF, playback can be on both interfaces
simultaneously.

The setup I have in mind for a generic Kirkwood/Dove soundcard is:

(DMA)-->(CPU_DAI)--+<-->(I2S Codec)
                   |
                   +--->(SPDIF TX Codec)
                   |
                   +<---(SPDIF RX Codec)

I sent a mail on how to handle multiple codecs on a single cpu_dai
earlier, and Mark pointed me to Dynamic PCM API. Unfortunately,
current mainline ASoC has no driver using DPCM as an example and
integration of DPCM patches look kind-of incomplete to me.

Can any of you point me to patches, repositories, or documentation
about DPCM where I can start with?

Regards,
  Sebastian
