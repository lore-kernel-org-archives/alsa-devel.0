From: Mike Dyer <mike.dyer@md-soft.co.uk>
Subject: Samsung S5PV210 I2S DMA
Date: Sun, 07 Apr 2013 12:36:05 +0100
Message-ID: <1365334565.5261.4.camel@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-samsung-soc-owner@vger.kernel.org>
Sender: linux-samsung-soc-owner@vger.kernel.org
To: linux-samsung-soc@vger.kernel.org
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Hi All,

I'm attempting to play audio into a WM8960 codec attached to I2S 0 on a
Samsung S5PV210.

The DMA engine emits a lot of messages complaining of (I think) a read
fault:

dma-pl330 dma-pl330.0: Reset Channel-0 CS-20000f FTC-40000
dma-pl330 dma-pl330.0: Reset Channel-0 CS-20000f FTC-40000
...

I've had audio playing using the I2S idma driver, so I know clocks +
mixer settings are OK.  I'd like to get the external DMA working because
I also need to do capture.

Any suggestions on how to debug?

Cheers,
Mike
