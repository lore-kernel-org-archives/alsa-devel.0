From: Hans de Goede <hdegoede@redhat.com>
Subject: Re: ASoC: Intel: sst: Missing IRQ at index 5 on BYT-T
	device
Date: Sun, 16 Dec 2018 20:07:30 +0100
Message-ID: <e82d5720-3c73-3dff-1b31-dae9a0b09408@redhat.com>
References: <20181216185429.GA20408@gerhold.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-wr1-f67.google.com (mail-wr1-f67.google.com
 [209.85.221.67])
 by alsa0.perex.cz (Postfix) with ESMTP id 965C62677E4
 for <alsa-devel@alsa-project.org>; Sun, 16 Dec 2018 20:07:32 +0100 (CET)
Received: by mail-wr1-f67.google.com with SMTP id z5so10122635wrt.11
 for <alsa-devel@alsa-project.org>; Sun, 16 Dec 2018 11:07:32 -0800 (PST)
In-Reply-To: <20181216185429.GA20408@gerhold.net>
Content-Language: en-US
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Stephan Gerhold <stephan@gerhold.net>, Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Cc: Liam Girdwood <liam.r.girdwood@linux.intel.com>, alsa-devel@alsa-project.org, Mark Brown <broonie@kernel.org>, Jie Yang <yang.jie@linux.intel.com>
List-Id: alsa-devel@alsa-project.org

Hi,

On 16-12-18 19:54, Stephan Gerhold wrote:
> Hi,
> 
> I have an Intel Bay Trail (BYT-T) tablet that was originally shipped
> with Android. With the right quirks, bytcr-rt5640 is working fine, but
> there is a problem in sst_acpi.c that is preventing it from working
> with a mainline kernel:
> 
> Even though this is a BYT-T device, there is no IRQ at index 5 in the
> ACPI DSDT table. This means that SST will fail to probe, and actually
> leads to a NULL pointer dereference later when the ALSA device is first
> opened. (I have submitted a possible solution for this as
> "[PATCH] ASoC: Intel: sst: Delay machine device creation until after
> initialization")
> 
> The correct IRQ is actually located on index 0, just like it is already
> being used for BYT-CR devices. So if I force is_byt_cr() to return TRUE,
> everything works as expected.
> 
> Here is the relevant part from the ACPI DSDT table:
> 
>    Name (_ADR, Zero)  // _ADR: Address
>    Name (_HID, "80860F28" /* Intel SST Audio DSP */)  // _HID: Hardware ID
>    Name (_CID, "80860F28" /* Intel SST Audio DSP */)  // _CID: Compatible ID
>    Name (_DDN, "Intel(R) Low Power Audio Controller - 80860F28")  // _DDN: DOS Device Name
>    Name (_SUB, "80867270")  // _SUB: Subsystem ID
>    Name (_UID, One)  // _UID: Unique ID
> 
>    Name (RBUF, ResourceTemplate ()
>    {
>        Memory32Fixed (ReadWrite,
>            0x12345678,         // Address Base
>            0x00200000,         // Address Length
>            _Y08)
>        Memory32Fixed (ReadWrite,
>            0xFE830000,         // Address Base
>            0x00001000,         // Address Length
>            _Y09)
>        Memory32Fixed (ReadWrite,
>            0x55AA55AA,         // Address Base
>            0x00200000,         // Address Length
>            _Y0A)
>        Interrupt (ResourceConsumer, Level, ActiveLow, Exclusive, ,, )
>        {
>            0x0000001D,
>        }
>    })
> 
> Unlike many of the other DSDT dumps I've looked at, there is only one
> interrupt listed. Full ACPI DSDT table is at [1].
> 
> Since there is no IRQ at index 5, platform_get_irq will return -ENXIO.
> Couldn't we fall back to index 0 in this case? I would say that if the
> seemingly "correct" IRQ at index 5 does not even exist, we still have
> a better chance of picking the right one if we try the one at index 0.
> Or we could check the number of interrupts that are actually available.

If I'm not mistaken then you already mentioned in another thread
(the "tusb1210 probe of dwc3.0.auto.ulpi fails with EBUSY on 4.19+")
thread that the DSTD of this Andriod only device has several bugs in
there such as wrong GPIOs in some places, etc. and you need to do a
DSDT override anyways to get some things to work, right ?

In that case I believe it would be best to just also patch up this
part of the DSDT in your override and leave the current kernel code
as is.

Regards,

Hans
