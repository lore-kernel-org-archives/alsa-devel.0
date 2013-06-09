From: Fabio Estevam <festevam@gmail.com>
Subject: Codec driver gets probed prior to the machine driver
Date: Sun, 9 Jun 2013 11:50:01 -0300
Message-ID: <CAOMZO5BzaAmt0BNXvSw+a18QorOBmEjGwaA5PoQ_D6mVb6QiUw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-vc0-f181.google.com (mail-vc0-f181.google.com
 [209.85.220.181])
 by alsa0.perex.cz (Postfix) with ESMTP id C8D882602C6
 for <alsa-devel@alsa-project.org>; Sun,  9 Jun 2013 16:50:02 +0200 (CEST)
Received: by mail-vc0-f181.google.com with SMTP id lf11so3038164vcb.40
 for <alsa-devel@alsa-project.org>; Sun, 09 Jun 2013 07:50:02 -0700 (PDT)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@kernel.org>, Troy Kisky <troy.kisky@boundarydevices.com>
Cc: alsa-devel@alsa-project.org, Shawn Guo <shawn.guo@linaro.org>, Lars-Peter Clausen <lars@metafoo.de>, Sascha Hauer <kernel@pengutronix.de>
List-Id: alsa-devel@alsa-project.org

Hi,

When running linux-next 20130607 on a mx6qsabrelite I see that the
audio drivers fail to probe.
Added some printk's to better illustrate the problem:

mmcblk0: mmc0:b5a1 SD04G 3.69 GiB
**** reading the chip ID
sgtl5000: probe of 0-000a failed with error -5
****** enabling the codec clock
imx-sgtl5000 sound.13: ASoC: CODEC (null) not registered
imx-sgtl5000 sound.13: snd_soc_register_card failed (-517)
platform sound.13: Driver imx-sgtl5000 requests probe defer

The problem here is that the codec driver (sgtl5000) is being probed
prior to the machine driver (imx-sgtl5000).

The reading of the chip ID fails because at this point in time there
is no codec clock, which is turned on by imx-sgtl5000.

Running 3.10-rc4, the order of the events is as expected: imx-sgtl5000
is called first and sgtl5000 is called later.
In this case the probe works as usual.

Tried doing a bisect, but this was not succesful due to several bisect
breakages (build issues and non-booting kernels) on  its way.

Would anyone have some suggestion as to why the codec driver is
getting probed first?

Thanks,

Fabio Estevam
