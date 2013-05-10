From: Fabio Estevam <festevam@gmail.com>
Subject: Re: [PATCH v5 2/2] ASoC: sgtl5000: Fix driver probe
	after reset
Date: Thu, 9 May 2013 23:12:33 -0300
Message-ID: <CAOMZO5AoWqhSdH5WVu=TFgejis=8mWNGYyHneRc5idwCd8RZWA@mail.gmail.com>
References: <1368144947-23775-1-git-send-email-festevam@gmail.com>
 <1368144947-23775-2-git-send-email-festevam@gmail.com>
 <518C4A8E.6020501@boundarydevices.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-vc0-f176.google.com (mail-vc0-f176.google.com
 [209.85.220.176])
 by alsa0.perex.cz (Postfix) with ESMTP id 788F32608B8
 for <alsa-devel@alsa-project.org>; Fri, 10 May 2013 04:12:34 +0200 (CEST)
Received: by mail-vc0-f176.google.com with SMTP id ib11so3244824vcb.21
 for <alsa-devel@alsa-project.org>; Thu, 09 May 2013 19:12:33 -0700 (PDT)
In-Reply-To: <518C4A8E.6020501@boundarydevices.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Troy Kisky <troy.kisky@boundarydevices.com>
Cc: Fabio Estevam <fabio.estevam@freescale.com>, alsa-devel@alsa-project.org, lars@metafoo.de, matt@genesi-usa.com, eric.nelson@boundarydevices.com, broonie@kernel.org
List-Id: alsa-devel@alsa-project.org

On Thu, May 9, 2013 at 10:17 PM, Troy Kisky
<troy.kisky@boundarydevices.com> wrote:

> Did you test a reset/reboot ?  Since the fill_defaults now happens after the
> read of the device id,
> how does this fix the mentioned problem ?

Yes, tested several times :-)

The chip ID has to be read from the register and it always read
correctly. In patch 1/2, I  just moved the reading to a more standard
location (in i2c_probe function), just like many other codecs do.

Patch 2/2 fixes the issue by ensuring that we start from sane values
from power-on reset.

Let's look at the original error:

sgtl5000 0-000a: Device with ID register ffff is not a sgtl5000
sgtl5000 0-000a: ASoC: failed to probe CODEC -19
imx-sgtl5000 sound.12: ASoC: failed to instantiate card -19
imx-sgtl5000 sound.12: snd_soc_register_card failed (-19)

If I move the chip ID reading to i2c_probe (ie, only apply patch 1/2),
the device ID would be read correctly, but the fail would happen at a
later point:

sgtl5000 0-000a: sgtl5000 revision 0x11
sgtl5000 0-000a: Failed to get supply 'VDDD': -517
 mmcblk0: p1
0-000a: 1200 mV normal
sgtl5000 0-000a: Using internal LDO instead of VDDD
usb 2-1: new high-speed USB device number 2 using ci_hdrc
hub 2-1:1.0: USB hub found
hub 2-1:1.0: 3 ports detected
sgtl5000 0-000a: ASoC: failed to probe CODEC -110
imx-sgtl5000 sound.12: ASoC: failed to instantiate card -110
imx-sgtl5000 sound.12: snd_soc_register_card failed (-110)
imx-sgtl5000: probe of sound.12 failed with error -110

So the original issue was not about reading the chip ID correctly.

The power related registers change from POR to reset (among others)

If the chip is not properly powered, then we are not able to read its
ID and we get that original error.
