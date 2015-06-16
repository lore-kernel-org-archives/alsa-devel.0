From: Christian Hartmann <cornogle@googlemail.com>
Subject: Re: ASoC : WM5102 Audio Codec needs ACPI support and a
 baytrail machine driver
Date: Tue, 16 Jun 2015 14:27:02 +0200
Message-ID: <CAKor6TeP2HfqpHiKK86GLYLpCNk87y66bdjye_mAqXuMXxPMWA@mail.gmail.com>
References: <CAKor6TdbnLuJCsBPykPEmhGk-zBLggKxw4Z+=QuBb6Mz2ThD3g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-qk0-f175.google.com (mail-qk0-f175.google.com
 [209.85.220.175])
 by alsa0.perex.cz (Postfix) with ESMTP id EC63426571B
 for <alsa-devel@alsa-project.org>; Tue, 16 Jun 2015 14:27:02 +0200 (CEST)
Received: by qkhu186 with SMTP id u186so7674649qkh.0
 for <alsa-devel@alsa-project.org>; Tue, 16 Jun 2015 05:27:02 -0700 (PDT)
In-Reply-To: <CAKor6TdbnLuJCsBPykPEmhGk-zBLggKxw4Z+=QuBb6Mz2ThD3g@mail.gmail.com>
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
List-Id: alsa-devel@alsa-project.org

Hi again,


some notes to the NULL pointer dereference error
I have changed the function arizona_spi_probe in arizona-spi.c and
have looked into the code where the NULL is coming...

in drivers/spi/spi.c the function spi_get_device_id() returns NULL,
cause the called function spi_match_id() does never match an id string
(there is no modalias string available I think).
With the id = NULL the line
type = id->driver_data; will throw the described exception.

Going on further, it seems that "id" has no such structure element of
"->driver_data", or I cannot find it.

Can someone please explain me in some simple words where the element
driver_data is coming or will be set
in THIS function of arizona_spi_probe()

The id->driver_data is not working for the acpi case...
This tablet does not have openfirmware (OF) by the way. The code seems
to be optimized for the Openfirmware API, but not for the ACPI case.



this is the currently local changed code to test and find null pointer
inarizona-spi.c.

diff --git a/drivers/mfd/arizona-spi.c b/drivers/mfd/arizona-spi.c
index 1e845f6..de48cf6 100644
--- a/drivers/mfd/arizona-spi.c
+++ b/drivers/mfd/arizona-spi.c
@@ -25,16 +25,26 @@

 static int arizona_spi_probe(struct spi_device *spi)
 {
-       const struct spi_device_id *id = spi_get_device_id(spi);
+       const struct spi_device_id *id ;
        struct arizona *arizona;
        const struct regmap_config *regmap_config;
        unsigned long type;
        int ret;

-       if (spi->dev.of_node)
-               type = arizona_of_get_type(&spi->dev);
-       else
+       /*
+       id = spi_get_device_id(spi);
+
+       if (!id)
+               return -EINVAL;
+       type = id->driver_data;
+       */
+       id = WM5102;
+
+       if (id->driver_data)
                type = id->driver_data;
+       else
+               type = WM5102;
+

        switch (type) {
 #ifdef CONFIG_MFD_WM5102
@@ -90,11 +100,23 @@ static const struct spi_device_id arizona_spi_ids[] = {
 };
 MODULE_DEVICE_TABLE(spi, arizona_spi_ids);

+#ifdef CONFIG_ACPI
+static const struct acpi_device_id wm5102_acpi_match[] = {
+       { "WM510205", WM5102 },
+       {},
+};
+
+MODULE_DEVICE_TABLE(acpi, wm5102_acpi_match);
+#ifdef CONFIG_ACPI
+static const struct acpi_device_id wm5102_acpi_match[] = {
+       { "WM510205", WM5102 },
+       {},
+};
+
+MODULE_DEVICE_TABLE(acpi, wm5102_acpi_match);
+#endif
+
 static struct spi_driver arizona_spi_driver = {
        .driver = {
                .name   = "arizona",
                .owner  = THIS_MODULE,
                .pm     = &arizona_pm_ops,
+#ifdef CONFIG_ACPI
+               .acpi_match_table = wm5102_acpi_match,
+#endif
                .of_match_table = of_match_ptr(arizona_of_match),
        },
        .probe          = arizona_spi_probe,
@@ -107,3 +129,4 @@ module_spi_driver(arizona_spi_driver);
 MODULE_DESCRIPTION("Arizona SPI bus interface");
 MODULE_AUTHOR("Mark Brown <broonie@opensource.wolfsonmicro.com>");
 MODULE_LICENSE("GPL");
+MODULE_ALIAS("spi:WM510205");



cheers
chris






[    5.095808] pxa2xx-spi 80860F0E:00: no DMA channels available, using PIO
[    5.095892] pxa2xx-spi 80860F0E:00: registered master spi32766 (dynamic)
[    5.110575] spi spi-WM510205:00: 8333333 Hz actual, PIO
[    5.110585] spi spi-WM510205:00: setup mode 0, 8 bits/w, 8000000 Hz max --> 0
[    5.110664] pxa2xx-spi 80860F0E:00: registered child spi-WM510205:00
[    5.245307] ACPI: Battery Slot [BATC] (battery present)
[    5.246890] i2c i2c-4: Failed to register i2c client MAGN0001:00 at
0x1d (-16)
[    5.254246] i2c i2c-4: failed to add I2C device MAGN0001:00 from ACPI
[    5.320349] arizona: probe of spi-WM510205:00 failed with error -22

2015-06-16 12:00 GMT+02:00 Christian Hartmann <cornogle@googlemail.com>:
> Hi list,
>
> I have a device "Lenovo Yoga 851 F" which have a WM510205 Audio codec
> on a Baytrail System.
>
> I have sent already one patch (spi-pxa2xx) raise num_chipselect by one, which
> fixes to bind the arizona WM5102 codec as a spi slave attachted on a
> pxa2xx spi master device.
>
> I have tried several times and added the ACPI id "WM510205"  to
> the arizona-spi.c driver.
>
> The ACPI ID is extracted from the DSDT.dsl of this machine.
>
> But unfortunately it fails and I got only a NULL pointer deference error
> in arizona_spi_probe().
> I want to request ACPI support for this device and I cannot fix
> currently the NULL pointer.
>
> I do not know yet, if I have to add this ACPI id to the arizona-spi
> driver (sure,
> thats what I am trying and failing) or to the NEW baytrail machine driver.
>
> In this case it should be the bytcr_wm5102.c and byt-wm5102.c, which
> does not exists yet.
>
> I have a branched tovalds/master and added (my first attempt) the
> above mentioned machine driver on a local branch. The result is only
> a dsp boot timeout error.
>
> Any help, ideas, hints, patches to try would be appreciate
>
> sincerely yours
> Christian Hartmann
>
> a snap of the dsdt
>
> Device (LPEA)
>         {
>             Name (_ADR, Zero)  // _ADR: Address
>             Name (_HID, "80860F28" /* Intel SST Audio DSP */)  //
> _HID: Hardware ID
>             Name (_CID, "80860F28" /* Intel SST Audio DSP */)  //
> _CID: Compatible ID
>             Name (_DDN, "Intel(R) Low Power Audio Controller -
> 80860F28")  // _DDN: DOS Device Name
>             Name (_SUB, "17AA7004")  // _SUB: Subsystem ID
>             Name (_UID, One)  // _UID: Unique ID
>             Name (_DEP, Package (0x01)  // _DEP: Dependencies
>             {
>                 ^SPI1.AUDI
>             })
> ...
> ...
> Device (AUDI)
>             {
>                 Name (_HID, "WM510205")  // _HID: Hardware ID
>                 Name (_CID, "WM510205")  // _CID: Compatible ID
>                 Name (_DDN, "Wolfson Microelectronics Audio WM5102")
> // _DDN: DOS Device Name
>                 Method (_CRS, 0, NotSerialized)  // _CRS: Current
> Resource Settings
>                 {
>                     Name (SBUF, ResourceTemplate ()
>                     {
>                         SpiSerialBus (0x0001, PolarityLow, FourWireMode, 0x08,
>                             ControllerInitiated, 0x007A1200, ClockPolarityLow,
>                             ClockPhaseFirst, "\\_SB.SPI1",
>                             0x00, ResourceConsumer, ,
>                             )
>                         GpioInt (Edge, ActiveLow, ExclusiveAndWake,
> PullNone, 0x0000,
>                             "\\_SB.GPO2", 0x00, ResourceConsumer, ,
>                             )
>                             {   // Pin list
>                                 0x0004
>                             }
>                         GpioIo (Exclusive, PullDefault, 0x0000,
> 0x0000, IoRestrictionOutputOnly,
>                             "\\_SB.I2C7.PMIC", 0x00, ResourceConsumer, ,
>                             )
>                             {   // Pin list
>                                 0x0003
>                             }
>                         GpioIo (Exclusive, PullDefault, 0x0000,
> 0x0000, IoRestrictionOutputOnly,
>                             "\\_SB.GPO1", 0x00, ResourceConsumer, ,
>                             )
>                             {   // Pin list
>                                 0x0017
>                             }
>                     })
