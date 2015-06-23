From: Christian Hartmann <cornogle@googlemail.com>
Subject: [PATCH 1/1] SPI : spi-pxa2xx : fix spi init of
 WM510205 codec via ACPI (resend)
Date: Tue, 23 Jun 2015 13:16:54 +0200
Message-ID: <CAKor6TeUOa6GdcscTWziw_q3GXj4wNh=8jnQigQfS7Se8iL+Nw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-qk0-f175.google.com (mail-qk0-f175.google.com
 [209.85.220.175])
 by alsa0.perex.cz (Postfix) with ESMTP id BC2542654DF
 for <alsa-devel@alsa-project.org>; Tue, 23 Jun 2015 13:16:54 +0200 (CEST)
Received: by qkfe185 with SMTP id e185so2777042qkf.3
 for <alsa-devel@alsa-project.org>; Tue, 23 Jun 2015 04:16:54 -0700 (PDT)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: patches@opensource.wolfsonmicro.com, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Hello,

I have one patch that enables the spi initialization of the WM510205 audio codec
Without the patch, this message indicates that the codec chip fails
with the current chipselect number in spi-pxa2xx:


[ 0.296256] pxa2xx-spi 80860F0E:00: cs1 >= max 1
[ 0.296270] spi_master spi32766: failed to add SPI device
WM510205:00 from ACPI

So raise num_chipselect by one to enable the codec. The WM510202 is on
chipselect = 1.

With the patch applied I got in dmesg now:

[    6.056829] pxa2xx-spi 80860F0E:00: no DMA channels available, using PIO
[    6.067035] pxa2xx-spi 80860F0E:00: registered master spi32766 (dynamic)
[    6.067214] spi spi-WM510205:00: 8333333 Hz actual, PIO
[    6.067221] spi spi-WM510205:00: setup mode 0, 8 bits/w, 8000000 Hz max --> 0
[    6.067287] pxa2xx-spi 80860F0E:00: registered child spi-WM510205:00

Signed-off-by: Christian Hartmann <cornogle@googlemail.com>
---
 drivers/spi/spi-pxa2xx.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/spi/spi-pxa2xx.c b/drivers/spi/spi-pxa2xx.c
index e3223ac..7b54b04 100644
--- a/drivers/spi/spi-pxa2xx.c
+++ b/drivers/spi/spi-pxa2xx.c
@@ -1279,7 +1279,7 @@ pxa2xx_spi_acpi_get_pdata(struct platform_device *pdev)
     if (adev->pnp.unique_id && !kstrtoint(adev->pnp.unique_id, 0, &devid))
         ssp->port_id = devid;

-    pdata->num_chipselect = 1;
+    pdata->num_chipselect = 2;
     pdata->enable_dma = true;

     return pdata;
-- 
1.8.3.1


would be nice to hear some feedback or comments about this patch.

Notice: That is my first attempt to make the codec chip via ACPI
(DSDT) configuration
working on Linux systems and some other patches are needed to let the
codec work together with the intel_sst_acpi driver under baytrail systems.
Currently I am trying to write the also needed machine driver which
binds to this
codec chip. Also the arizona-core / arizona-spi drivers have to be patched,
but that patches will be landing later...

cheers
Christian Hartmann
