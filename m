From: Stephan Gerhold <stephan@gerhold.net>
Subject: ASoC: Intel: sst: Missing IRQ at index 5 on BYT-T
	device
Date: Sun, 16 Dec 2018 19:54:29 +0100
Message-ID: <20181216185429.GA20408@gerhold.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mo4-p01-ob.smtp.rzone.de (mo4-p01-ob.smtp.rzone.de
 [85.215.255.53])
 by alsa0.perex.cz (Postfix) with ESMTP id D1A9B2677E4
 for <alsa-devel@alsa-project.org>; Sun, 16 Dec 2018 19:54:37 +0100 (CET)
Content-Disposition: inline
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Cc: Liam Girdwood <liam.r.girdwood@linux.intel.com>, Hans de Goede <hdegoede@redhat.com>, alsa-devel@alsa-project.org, Mark Brown <broonie@kernel.org>, Jie Yang <yang.jie@linux.intel.com>
List-Id: alsa-devel@alsa-project.org

Hi,

I have an Intel Bay Trail (BYT-T) tablet that was originally shipped 
with Android. With the right quirks, bytcr-rt5640 is working fine, but
there is a problem in sst_acpi.c that is preventing it from working
with a mainline kernel:

Even though this is a BYT-T device, there is no IRQ at index 5 in the 
ACPI DSDT table. This means that SST will fail to probe, and actually 
leads to a NULL pointer dereference later when the ALSA device is first 
opened. (I have submitted a possible solution for this as
"[PATCH] ASoC: Intel: sst: Delay machine device creation until after 
initialization")

The correct IRQ is actually located on index 0, just like it is already 
being used for BYT-CR devices. So if I force is_byt_cr() to return TRUE, 
everything works as expected.

Here is the relevant part from the ACPI DSDT table:

  Name (_ADR, Zero)  // _ADR: Address
  Name (_HID, "80860F28" /* Intel SST Audio DSP */)  // _HID: Hardware ID
  Name (_CID, "80860F28" /* Intel SST Audio DSP */)  // _CID: Compatible ID
  Name (_DDN, "Intel(R) Low Power Audio Controller - 80860F28")  // _DDN: DOS Device Name
  Name (_SUB, "80867270")  // _SUB: Subsystem ID
  Name (_UID, One)  // _UID: Unique ID

  Name (RBUF, ResourceTemplate ()
  {
      Memory32Fixed (ReadWrite,
          0x12345678,         // Address Base
          0x00200000,         // Address Length
          _Y08)
      Memory32Fixed (ReadWrite,
          0xFE830000,         // Address Base
          0x00001000,         // Address Length
          _Y09)
      Memory32Fixed (ReadWrite,
          0x55AA55AA,         // Address Base
          0x00200000,         // Address Length
          _Y0A)
      Interrupt (ResourceConsumer, Level, ActiveLow, Exclusive, ,, )
      {
          0x0000001D,
      }
  })

Unlike many of the other DSDT dumps I've looked at, there is only one 
interrupt listed. Full ACPI DSDT table is at [1].

Since there is no IRQ at index 5, platform_get_irq will return -ENXIO. 
Couldn't we fall back to index 0 in this case? I would say that if the 
seemingly "correct" IRQ at index 5 does not even exist, we still have
a better chance of picking the right one if we try the one at index 0.
Or we could check the number of interrupts that are actually available.

The other option would be some kind of DMI-based quirk, but personally
I would prefer to avoid that.. (In my opinion, there is way too much
device specific code with the quirks etc already...)

Or do you have any other suggestions?

Thanks,
Stephan

[1]: https://github.com/me176c-dev/me176c-acpi/blob/f48c78c11b0819b899f988407b6ece3d8c2cca71/dsdt.dsl#L3989-L4035
