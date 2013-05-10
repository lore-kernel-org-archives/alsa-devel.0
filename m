From: Troy Kisky <troy.kisky@boundarydevices.com>
Subject: Re: [PATCH v5 2/2] ASoC: sgtl5000: Fix driver probe
	after reset
Date: Fri, 10 May 2013 12:11:28 -0700
Message-ID: <518D4660.9070202@boundarydevices.com>
References: <1368144947-23775-1-git-send-email-festevam@gmail.com>
 <1368144947-23775-2-git-send-email-festevam@gmail.com>
 <518C4A8E.6020501@boundarydevices.com>
 <CAOMZO5AoWqhSdH5WVu=TFgejis=8mWNGYyHneRc5idwCd8RZWA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-pd0-f169.google.com (mail-pd0-f169.google.com
 [209.85.192.169])
 by alsa0.perex.cz (Postfix) with ESMTP id F0BA7261691
 for <alsa-devel@alsa-project.org>; Fri, 10 May 2013 21:11:32 +0200 (CEST)
Received: by mail-pd0-f169.google.com with SMTP id bv13so2976064pdb.28
 for <alsa-devel@alsa-project.org>; Fri, 10 May 2013 12:11:31 -0700 (PDT)
In-Reply-To: <CAOMZO5AoWqhSdH5WVu=TFgejis=8mWNGYyHneRc5idwCd8RZWA@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Fabio Estevam <festevam@gmail.com>
Cc: Fabio Estevam <fabio.estevam@freescale.com>, alsa-devel@alsa-project.org, lars@metafoo.de, matt@genesi-usa.com, eric.nelson@boundarydevices.com, broonie@kernel.org
List-Id: alsa-devel@alsa-project.org

On 5/9/2013 7:12 PM, Fabio Estevam wrote:
> On Thu, May 9, 2013 at 10:17 PM, Troy Kisky
> <troy.kisky@boundarydevices.com> wrote:
>
>> Did you test a reset/reboot ?  Since the fill_defaults now happens after the
>> read of the device id,
>> how does this fix the mentioned problem ?
> Yes, tested several times :-)
>
> The chip ID has to be read from the register and it always read
> correctly. In patch 1/2, I  just moved the reading to a more standard
> location (in i2c_probe function), just like many other codecs do.
>
> Patch 2/2 fixes the issue by ensuring that we start from sane values
> from power-on reset.
>
> Let's look at the original error:
>
> sgtl5000 0-000a: Device with ID register ffff is not a sgtl5000
> sgtl5000 0-000a: ASoC: failed to probe CODEC -19
> imx-sgtl5000 sound.12: ASoC: failed to instantiate card -19
> imx-sgtl5000 sound.12: snd_soc_register_card failed (-19)
>
> If I move the chip ID reading to i2c_probe (ie, only apply patch 1/2),
> the device ID would be read correctly, but the fail would happen at a
> later point:
>
> sgtl5000 0-000a: sgtl5000 revision 0x11
> sgtl5000 0-000a: Failed to get supply 'VDDD': -517
>   mmcblk0: p1
> 0-000a: 1200 mV normal
> sgtl5000 0-000a: Using internal LDO instead of VDDD
> usb 2-1: new high-speed USB device number 2 using ci_hdrc
> hub 2-1:1.0: USB hub found
> hub 2-1:1.0: 3 ports detected
> sgtl5000 0-000a: ASoC: failed to probe CODEC -110
> imx-sgtl5000 sound.12: ASoC: failed to instantiate card -110
> imx-sgtl5000 sound.12: snd_soc_register_card failed (-110)
> imx-sgtl5000: probe of sound.12 failed with error -110

Shouldn't you update your commit log with this then ?
>
> So the original issue was not about reading the chip ID correctly.
>
> The power related registers change from POR to reset (among others)
>
> If the chip is not properly powered, then we are not able to read its
> ID and we get that original error.
>

Thanks for fixing, I guess I don't need to understand how the fix works.

Troy
