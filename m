From: Stephan Gerhold <stephan@gerhold.net>
Subject: Re: ASoC: Intel: sst: Missing IRQ at index 5 on BYT-T
	device
Date: Mon, 17 Dec 2018 19:03:31 +0100
Message-ID: <20181217180330.GA845@gerhold.net>
References: <20181216185429.GA20408@gerhold.net>
 <e82d5720-3c73-3dff-1b31-dae9a0b09408@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mo4-p00-ob.smtp.rzone.de (mo4-p00-ob.smtp.rzone.de
 [81.169.146.161])
 by alsa0.perex.cz (Postfix) with ESMTP id 7DECF2678D5
 for <alsa-devel@alsa-project.org>; Mon, 17 Dec 2018 19:03:40 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <e82d5720-3c73-3dff-1b31-dae9a0b09408@redhat.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Hans de Goede <hdegoede@redhat.com>
Cc: Liam Girdwood <liam.r.girdwood@linux.intel.com>, alsa-devel@alsa-project.org, Mark Brown <broonie@kernel.org>, Jie Yang <yang.jie@linux.intel.com>, Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
List-Id: alsa-devel@alsa-project.org

On Sun, Dec 16, 2018 at 08:07:30PM +0100, Hans de Goede wrote:
> Hi,
> 
> On 16-12-18 19:54, Stephan Gerhold wrote:
> > Hi,
> > 
> > I have an Intel Bay Trail (BYT-T) tablet that was originally shipped
> > with Android. With the right quirks, bytcr-rt5640 is working fine, but
> > there is a problem in sst_acpi.c that is preventing it from working
> > with a mainline kernel:
> > 
> > Even though this is a BYT-T device, there is no IRQ at index 5 in the
> > ACPI DSDT table. This means that SST will fail to probe, and actually
> > leads to a NULL pointer dereference later when the ALSA device is first
> > opened. (I have submitted a possible solution for this as
> > "[PATCH] ASoC: Intel: sst: Delay machine device creation until after
> > initialization")
> > 
> > The correct IRQ is actually located on index 0, just like it is already
> > being used for BYT-CR devices. So if I force is_byt_cr() to return TRUE,
> > everything works as expected.
> > 
> > Here is the relevant part from the ACPI DSDT table:
> > 
> >    Name (_ADR, Zero)  // _ADR: Address
> >    Name (_HID, "80860F28" /* Intel SST Audio DSP */)  // _HID: Hardware ID
> >    Name (_CID, "80860F28" /* Intel SST Audio DSP */)  // _CID: Compatible ID
> >    Name (_DDN, "Intel(R) Low Power Audio Controller - 80860F28")  // _DDN: DOS Device Name
> >    Name (_SUB, "80867270")  // _SUB: Subsystem ID
> >    Name (_UID, One)  // _UID: Unique ID
> > 
> >    Name (RBUF, ResourceTemplate ()
> >    {
> >        Memory32Fixed (ReadWrite,
> >            0x12345678,         // Address Base
> >            0x00200000,         // Address Length
> >            _Y08)
> >        Memory32Fixed (ReadWrite,
> >            0xFE830000,         // Address Base
> >            0x00001000,         // Address Length
> >            _Y09)
> >        Memory32Fixed (ReadWrite,
> >            0x55AA55AA,         // Address Base
> >            0x00200000,         // Address Length
> >            _Y0A)
> >        Interrupt (ResourceConsumer, Level, ActiveLow, Exclusive, ,, )
> >        {
> >            0x0000001D,
> >        }
> >    })
> > 
> > Unlike many of the other DSDT dumps I've looked at, there is only one
> > interrupt listed. Full ACPI DSDT table is at [1].
> > 
> > Since there is no IRQ at index 5, platform_get_irq will return -ENXIO.
> > Couldn't we fall back to index 0 in this case? I would say that if the
> > seemingly "correct" IRQ at index 5 does not even exist, we still have
> > a better chance of picking the right one if we try the one at index 0.
> > Or we could check the number of interrupts that are actually available.
> 
> If I'm not mistaken then you already mentioned in another thread
> (the "tusb1210 probe of dwc3.0.auto.ulpi fails with EBUSY on 4.19+")
> thread that the DSTD of this Andriod only device has several bugs in
> there such as wrong GPIOs in some places, etc. and you need to do a
> DSDT override anyways to get some things to work, right ?

Yes, at the moment I use DSDT override to fix some things and add a few 
missing GPIOs. For example I have not yet found a nice way to fixup the
ACPI parent of the Bluetooth device (it's listed under the wrong UART 
controller).

Note that this is rather painful, especially because I can't share the 
fixed table as-is with others (there is a memory address in there that 
is different depending on the BIOS state or something).
So I'm still trying to keep the necessary changes as minimal as possible,
and have the majority of things working without it. Eventually, I will 
find nicer workarounds and can stop doing this entirely in the future.

> 
> In that case I believe it would be best to just also patch up this
> part of the DSDT in your override and leave the current kernel code
> as is.

I have just looked through a few other DSDTs of Android based Bay Trail 
devices and have found this pattern in at least two more of them. So in 
case someone tries to run mainline on those devices in the future,
I believe it would be better to fix it on the kernel side in this case.
(Getting sound working has been a rather painful process for me, and
took a lot of time. I would like to make this easier for others...)

I was thinking of something along the lines of:

  if (platform_irq_count(pdev) == 1)
  	byt_rvp_platform_data.res_info = &bytcr_res_info;

Pretty simple, and since all currently supported devices are either 
BYT-CR or have at least 5 IRQs listed, the change would not affect them 
in any way.


Side note:
I have considered fixing this in the DSDT table a few times before but 
have never tried it because it kind of feels wrong to me. It would 
probably work, but I believe the kernel is at fault here:

I've been fixing mistakes and adding missing GPIOs to the DSDT, but is 
this really the case here? Everything that is needed for the driver 
exists in the ACPI table. If this was a BYT-CR device, it would work 
as-is, with no additional modifications.

Now, in order to fulfill the current expectations for BYT-T devices,
I would need to add 4 additional IRQs that would never be used.
But which IRQs would I list there? Dummy/invalid IRQs? To me, that
does not sound like the DSDT will become any more valid.

Let me know what you think! :)

> 
> Regards,
> 
> Hans
> 
