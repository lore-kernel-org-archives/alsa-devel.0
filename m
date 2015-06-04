From: Michele Curti <michele.curti@gmail.com>
Subject: Re: writing an alsa driver
Date: Thu, 4 Jun 2015 21:39:22 +0200
Message-ID: <20150604193922.GA627@asus>
References: <20150527085440.GA4445@dellaz> <1432752116.8235.25.camel@loki>
 <20150527201320.GA309@asus> <1432812668.2726.18.camel@loki>
 <20150528125325.GA418@asus> <1432819294.2726.33.camel@loki>
 <20150528191721.GA608@asus> <1432892521.2732.14.camel@loki>
 <20150529131753.GA339@asus> <1433156768.2642.21.camel@loki>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-wi0-f169.google.com (mail-wi0-f169.google.com
 [209.85.212.169])
 by alsa0.perex.cz (Postfix) with ESMTP id E613C261480
 for <alsa-devel@alsa-project.org>; Thu,  4 Jun 2015 21:39:40 +0200 (CEST)
Received: by wiwd19 with SMTP id d19so31967248wiw.0
 for <alsa-devel@alsa-project.org>; Thu, 04 Jun 2015 12:39:39 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <1433156768.2642.21.camel@loki>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Liam Girdwood <liam.r.girdwood@linux.intel.com>
Cc: Takashi Iwai <tiwai@suse.de>, Bard Liao <bardliao@realtek.com>, alsa-devel@alsa-project.org, "Nikula, Jarkko" <jarkko.nikula@intel.com>
List-Id: alsa-devel@alsa-project.org

On Mon, Jun 01, 2015 at 12:06:08PM +0100, Liam Girdwood wrote:
> + Jarkko
> 
> On Fri, 2015-05-29 at 15:17 +0200, Michele Curti wrote:
> > On Fri, May 29, 2015 at 10:42:01AM +0100, Liam Girdwood wrote:
> > > On Thu, 2015-05-28 at 21:17 +0200, Michele Curti wrote:
> > > 
> > > > to let the probe continue, the system become quite unusable but I get the 
> > > > logs.
> > > > 
> > > > May 28 20:34:00 asus kernel: byt-rt5645 byt-rt5645: ASoC: CPU DAI baytrail-pcm-audio not registered
> > > > May 28 20:34:00 asus kernel: baytrail-pcm-audio baytrail-pcm-audio: initialising Byt DSP IPC
> > > > May 28 20:34:00 asus kernel: baytrail-pcm-audio baytrail-pcm-audio: initialising audio DSP id 0xf28
> > > > May 28 20:34:00 asus kernel: irq used for dsp = 6
> > > > 
> > > > ---> The IRQ number used is 6
> > > > 
> 
> Jarkko thinks the IRQ may be incorrectly reported by ACPI and that it
> could be using another ACPI index. This could probably be checked by
> decompiling the ACPi data and searching for the audio DSP.
>

Done an acpidump/iasl and (I think) the interesting part is:

    Scope (_SB)
    {
        Device (LPEA)
        {
            Name (_ADR, Zero)  // _ADR: Address
            Name (_HID, "80860F28" /* Intel SST Audio DSP */)  // _HID: Hardware ID
            Name (_CID, "80860F28" /* Intel SST Audio DSP */)  // _CID: Compatible ID
            Name (_DDN, "Intel(R) Low Power Audio Controller - 80860F28")  // _DDN: DOS Device Name
            Name (_SUB, "1043182D")  // _SUB: Subsystem ID
            Name (_UID, One)  // _UID: Unique ID
            Name (ADEP, Package (0x01)
            {
                ^I2C2.TTLV
            })
            Name (_DEP, Package (0x01)  // _DEP: Dependencies
            {
                ^I2C2.RTEK
            })
            Name (_PR0, Package (0x01)  // _PR0: Power Resources for D0
            {
                PLPE
            })
            Method (_STA, 0, NotSerialized)  // _STA: Status
            {
                If (((LPEE == 0x02) && (LPED == Zero)))
                {
                    Return (0x0F)
                }

                Return (Zero)
            }

            Method (_DIS, 0, NotSerialized)  // _DIS: Disable Device
            {
            }

            Name (RBUF, ResourceTemplate ()
            {
                Memory32Fixed (ReadWrite,
                    0x12345678,         // Address Base
                    0x00200000,         // Address Length
                    _Y04)
                Memory32Fixed (ReadWrite,
                    0xFE830000,         // Address Base
                    0x00001000,         // Address Length
                    _Y05)
                Memory32Fixed (ReadWrite,
                    0x55AA55AA,         // Address Base
                    0x00200000,         // Address Length
                    _Y06)
                Interrupt (ResourceConsumer, Level, ActiveLow, Exclusive, ,, )
                {
                    0x0000001D,
                }
                Interrupt (ResourceConsumer, Level, ActiveLow, Exclusive, ,, )
                {
                    0x00000018,
                }
                Interrupt (ResourceConsumer, Level, ActiveLow, Exclusive, ,, )
                {
                    0x00000019,
                }
                Interrupt (ResourceConsumer, Level, ActiveLow, Exclusive, ,, )
                {
                    0x0000001A,
                }
                Interrupt (ResourceConsumer, Level, ActiveLow, Exclusive, ,, )
                {
                    0x0000001B,
                }
                Interrupt (ResourceConsumer, Level, ActiveLow, Exclusive, ,, )
                {
                    0x0000001C,
                }
            })
            Method (_CRS, 0, NotSerialized)  // _CRS: Current Resource Settings
            {
                CreateDWordField (RBUF, \_SB.LPEA._Y04._BAS, B0BA)  // _BAS: Base Address
                B0BA = LPE0 /* \LPE0 */
                CreateDWordField (RBUF, \_SB.LPEA._Y05._BAS, B1BA)  // _BAS: Base Address
                B1BA = LPE1 /* \LPE1 */
                CreateDWordField (RBUF, \_SB.LPEA._Y06._BAS, B2BA)  // _BAS: Base Address
                B2BA = LPE2 /* \LPE2 */
                Return (RBUF) /* \_SB_.LPEA.RBUF */
            }

            OperationRegion (KEYS, SystemMemory, LPE1, 0x0100)
            Field (KEYS, DWordAcc, NoLock, WriteAsZeros)
            {
                Offset (0x84), 
                PSAT,   32
            }

            PowerResource (PLPE, 0x05, 0x0000)
            {
                Method (_STA, 0, NotSerialized)  // _STA: Status
                {
                    Return (One)
                }

                Method (_ON, 0, NotSerialized)  // _ON_: Power On
                {
                    PSAT &= 0xFFFFFFFC
                    Local0 = PSAT /* \_SB_.LPEA.PSAT */
                }

                Method (_OFF, 0, NotSerialized)  // _OFF: Power Off
                {
                    PSAT |= 0x03
                    Local0 = PSAT /* \_SB_.LPEA.PSAT */
                }
            }

So, 6 possible IRQs for the LPE core, from 0x18 to 0x1D?

Changed the code and tried all six

diff --git a/sound/soc/intel/common/sst-acpi.c b/sound/soc/intel/common/sst-acpi.c
index bb28e84..a306502 100644
--- a/sound/soc/intel/common/sst-acpi.c
+++ b/sound/soc/intel/common/sst-acpi.c
@@ -149,8 +149,12 @@ static int sst_acpi_probe(struct platform_device *pdev)
 		sst_pdata->dma_size = desc->dma_size;
 	}
 
-	if (desc->irqindex_host_ipc >= 0)
-		sst_pdata->irq = platform_get_irq(pdev, desc->irqindex_host_ipc);
+	if (desc->irqindex_host_ipc >= 0) {
+		sst_pdata->irq = 0x1D; /* acpi-dump, from 0x18 to 0x1D */
+		pr_info("audio dsp: IRQ # was %d, force to %d\n",
+				platform_get_irq(pdev, desc->irqindex_host_ipc),
+				sst_pdata->irq);
+	}
 
 	if (desc->resindex_lpe_base >= 0) {
 		mmio = platform_get_resource(pdev, IORESOURCE_MEM,

without success, I get always the "dsp boot timeout".

I'm going to investigate why platform_get_irq() returns 6 instead of something
in the range 0x18-0x1D.. :)

Thanks for the time spent,
Michele
