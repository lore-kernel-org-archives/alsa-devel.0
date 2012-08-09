From: Scott Jiang <scott.jiang.linux@gmail.com>
Subject: ASoC: how to calculate dma size in tdm mode
Date: Thu, 9 Aug 2012 17:56:57 +0800
Message-ID: <CAHG8p1Am-FcJ0CO9Mo-Wc1-i=LHrX1-46rVe4w9nXyCs7iD10w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-ob0-f179.google.com (mail-ob0-f179.google.com
 [209.85.214.179])
 by alsa0.perex.cz (Postfix) with ESMTP id 10058265F52
 for <alsa-devel@alsa-project.org>; Thu,  9 Aug 2012 11:27:12 +0200 (CEST)
Received: by obbeh20 with SMTP id eh20so399954obb.38
 for <alsa-devel@alsa-project.org>; Thu, 09 Aug 2012 02:56:58 -0700 (PDT)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@opensource.wolfsonmicro.com>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Hi Mark,

If user app use 2 channels but codec need 8 channels in tdm mode, I
need to copy this data from user space to dma buffer. I wonder how to
calculate dma size, snd_pcm_hardware.buffer_bytes_max or
buffer_bytes_max * tdm_channels / channels_min?

Thanks,
Scott
