From: Christian Hartmann <cornogle@googlemail.com>
Subject: ASoC : WM5102 Audio Codec needs ACPI support and a
	baytrail machine driver
Date: Tue, 16 Jun 2015 12:00:04 +0200
Message-ID: <CAKor6TdbnLuJCsBPykPEmhGk-zBLggKxw4Z+=QuBb6Mz2ThD3g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-qk0-f169.google.com (mail-qk0-f169.google.com
 [209.85.220.169])
 by alsa0.perex.cz (Postfix) with ESMTP id 9AE25261AC1
 for <alsa-devel@alsa-project.org>; Tue, 16 Jun 2015 12:00:05 +0200 (CEST)
Received: by qkdm188 with SMTP id m188so5990379qkd.1
 for <alsa-devel@alsa-project.org>; Tue, 16 Jun 2015 03:00:04 -0700 (PDT)
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
Cc: linux-acpi <linux-acpi@vger.kernel.org>, patches@opensource.wolfsonmicro.com
List-Id: alsa-devel@alsa-project.org

Hi list,

I have a device "Lenovo Yoga 851 F" which have a WM510205 Audio codec
on a Baytrail System.

I have sent already one patch (spi-pxa2xx) raise num_chipselect by one, which
fixes to bind the arizona WM5102 codec as a spi slave attachted on a
pxa2xx spi master device.

I have tried several times and added the ACPI id "WM510205"  to
the arizona-spi.c driver.

The ACPI ID is extracted from the DSDT.dsl of this machine.

But unfortunately it fails and I got only a NULL pointer deference error
in arizona_spi_probe().
I want to request ACPI support for this device and I cannot fix
currently the NULL pointer.

I do not know yet, if I have to add this ACPI id to the arizona-spi
driver (sure,
thats what I am trying and failing) or to the NEW baytrail machine driver.

In this case it should be the bytcr_wm5102.c and byt-wm5102.c, which
does not exists yet.

I have a branched tovalds/master and added (my first attempt) the
above mentioned machine driver on a local branch. The result is only
a dsp boot timeout error.

Any help, ideas, hints, patches to try would be appreciate

sincerely yours
Christian Hartmann

a snap of the dsdt

Device (LPEA)
        {
            Name (_ADR, Zero)  // _ADR: Address
            Name (_HID, "80860F28" /* Intel SST Audio DSP */)  //
_HID: Hardware ID
            Name (_CID, "80860F28" /* Intel SST Audio DSP */)  //
_CID: Compatible ID
            Name (_DDN, "Intel(R) Low Power Audio Controller -
80860F28")  // _DDN: DOS Device Name
            Name (_SUB, "17AA7004")  // _SUB: Subsystem ID
            Name (_UID, One)  // _UID: Unique ID
            Name (_DEP, Package (0x01)  // _DEP: Dependencies
            {
                ^SPI1.AUDI
            })
...
...
Device (AUDI)
            {
                Name (_HID, "WM510205")  // _HID: Hardware ID
                Name (_CID, "WM510205")  // _CID: Compatible ID
                Name (_DDN, "Wolfson Microelectronics Audio WM5102")
// _DDN: DOS Device Name
                Method (_CRS, 0, NotSerialized)  // _CRS: Current
Resource Settings
                {
                    Name (SBUF, ResourceTemplate ()
                    {
                        SpiSerialBus (0x0001, PolarityLow, FourWireMode, 0x08,
                            ControllerInitiated, 0x007A1200, ClockPolarityLow,
                            ClockPhaseFirst, "\\_SB.SPI1",
                            0x00, ResourceConsumer, ,
                            )
                        GpioInt (Edge, ActiveLow, ExclusiveAndWake,
PullNone, 0x0000,
                            "\\_SB.GPO2", 0x00, ResourceConsumer, ,
                            )
                            {   // Pin list
                                0x0004
                            }
                        GpioIo (Exclusive, PullDefault, 0x0000,
0x0000, IoRestrictionOutputOnly,
                            "\\_SB.I2C7.PMIC", 0x00, ResourceConsumer, ,
                            )
                            {   // Pin list
                                0x0003
                            }
                        GpioIo (Exclusive, PullDefault, 0x0000,
0x0000, IoRestrictionOutputOnly,
                            "\\_SB.GPO1", 0x00, ResourceConsumer, ,
                            )
                            {   // Pin list
                                0x0017
                            }
                    })
