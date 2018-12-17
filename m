From: Stephan Gerhold <stephan@gerhold.net>
Subject: Re: ASoC: Intel: sst: Missing IRQ at index 5 on BYT-T
	device
Date: Mon, 17 Dec 2018 20:10:55 +0100
Message-ID: <20181217191054.GA10938@gerhold.net>
References: <20181216185429.GA20408@gerhold.net>
 <3b96d716-1d9f-a569-2afa-82b386e752e4@linux.intel.com>
 <20181217181729.GB845@gerhold.net>
 <b3cf2bc5-bde3-3c3d-fd6a-ff426281563c@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mo4-p01-ob.smtp.rzone.de (mo4-p01-ob.smtp.rzone.de
 [81.169.146.166])
 by alsa0.perex.cz (Postfix) with ESMTP id 8EA2D267AFC
 for <alsa-devel@alsa-project.org>; Mon, 17 Dec 2018 20:11:08 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <b3cf2bc5-bde3-3c3d-fd6a-ff426281563c@linux.intel.com>
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

On Mon, Dec 17, 2018 at 12:29:43PM -0600, Pierre-Louis Bossart wrote:
> =

> On 12/17/18 12:17 PM, Stephan Gerhold wrote:
> > On Mon, Dec 17, 2018 at 08:52:46AM -0600, Pierre-Louis Bossart wrote:
> > > On 12/16/18 12:54 PM, Stephan Gerhold wrote:
> > > > Hi,
> > > > =

> > > > I have an Intel Bay Trail (BYT-T) tablet that was originally shipped
> > > > with Android. With the right quirks, bytcr-rt5640 is working fine, =
but
> > > > there is a problem in sst_acpi.c that is preventing it from working
> > > > with a mainline kernel:
> > > > =

> > > > Even though this is a BYT-T device, there is no IRQ at index 5 in t=
he
> > > > ACPI DSDT table. This means that SST will fail to probe, and actual=
ly
> > > > leads to a NULL pointer dereference later when the ALSA device is f=
irst
> > > > opened. (I have submitted a possible solution for this as
> > > > "[PATCH] ASoC: Intel: sst: Delay machine device creation until after
> > > > initialization")
> > > > =

> > > > The correct IRQ is actually located on index 0, just like it is alr=
eady
> > > > being used for BYT-CR devices. So if I force is_byt_cr() to return =
TRUE,
> > > > everything works as expected.
> > > So the root cause of your problem is that the detection of byt-cr doe=
sn't
> > > work? That would be a first.
> > No. is_byt_cr() works correctly, as my device is a BYT-T (not a BYT-CR)
> > device. :)
> =

> What information is your analysis based on and how do you infer this
> conclusion? The BYT-T and BYT-CR silicon dies are identical, product
> documentation can barely be trusted and it's a package difference that can
> only be tested indirectly.

Okay, sorry - I'm not _that_ sure. :)
It's mostly based on something called "spid" that was being used in the =

stock Android kernel on the device and some code from the stock kernel =

I've looked at.

I don't mind checking this again to be absolutely sure :)

The call to iosf_mbi_read() returns 0x400b0100

	/* bits 26:27 mirror PMIC options */
	bios_status =3D (bios_status >> 26) & 3;

Results in bios_status =3D 0x0

The stock kernel printed this on every startup:

SPID updated according to ACPI Table:
	spid customer id : 0000
	spid vendor id : 0000
	spid manufacturer id : 00ff
	spid platform family id : 0007 --> INTEL_BYT_TABLET
	spid product line id : 0000 --> INTEL_BYT_TABLET_BLK_PRO
	spid hardware id : 0004 --> BYT_TABLET_BLK_8PR0 /* Bay Lake FFRD-8 PR0 */
	spid fru[4..0] : 00 00 00 00 00
	spid fru[9..5] : 00 00 00 00 00

Based on spid.h [1] I added the "-->" above. Then I guessed that this is =

BYT-T (there is another "BYT T CR V2" value), but to be honest I don't
know for sure.

[1]: https://github.com/me176c-dev/me176c-kernel/blob/stock/kernel/arch/x86=
/include/asm/spid.h

> =

> I don't mean to dismiss your claim, just want to find out if this is a ca=
se
> where the PMIC-type-based byt_cr detection fails or if we have a BIOS iss=
ue.
> Another smoking gun is if you find in your code traces of SSP0 being used.
> =


The quirks to get sound working with bytcr-rt5640 on that device are:
BYT_RT5640_SSP0_AIF1 | BYT_RT5640_IN1_MAP | BYT_RT5640_MCLK_EN

I guess this means that SSP0 is being used?

> > =

> > The problem here is that the kernel expects the IRQ at index 5 for BYT-T
> > devices, but my device has only a single IRQ listed. Forcing is_byt_cr()
> > to return TRUE is just a workaround to make it use the IRQ at index 0
> > (which is the correct one).
> > =

> > Currently, sst_acpi supports these two variations:
> >    - BYT-T:  5 IRQs listed -> acpi_ipc_irq_index =3D 5
> >    - BYT-CR: 5 IRQs listed -> acpi_ipc_irq_index =3D 0
> > =

> > On my device (and a few other Android based BYT-T devices) I have found:
> >    - BYT-T:  1 IRQ  listed -> acpi_ipc_irq_index =3D 0
> > but at the moment the kernel attempts to use acpi_ipc_irq_index =3D 5 f=
rom
> > BYT-T above.
> > =

> > > Can you please double-check that CONFIG_IOSF_MBI is enabled and provi=
de a
> > > trace of the bios status in this piece of code:
> > > =

> > >  =A0=A0=A0 /* bits 26:27 mirror PMIC options */
> > >  =A0=A0=A0 =A0=A0=A0 =A0=A0=A0 bios_status =3D (bios_status >> 26) & =
3;
> > > =

> > >  =A0=A0=A0 =A0=A0=A0 =A0=A0=A0 if ((bios_status =3D=3D 1) || (bios_st=
atus =3D=3D 3))
> > >  =A0=A0=A0 =A0=A0=A0 =A0=A0=A0 =A0=A0=A0 *bytcr =3D true;
> > >  =A0=A0=A0 =A0=A0=A0 =A0=A0=A0 else
> > >  =A0=A0=A0 =A0=A0=A0 =A0=A0=A0 =A0=A0=A0 dev_info(dev, "BYT-CR not de=
tected\n");
> > > =

> > > > Here is the relevant part from the ACPI DSDT table:
> > > > =

> > > >     Name (_ADR, Zero)  // _ADR: Address
> > > >     Name (_HID, "80860F28" /* Intel SST Audio DSP */)  // _HID: Har=
dware ID
> > > >     Name (_CID, "80860F28" /* Intel SST Audio DSP */)  // _CID: Com=
patible ID
> > > >     Name (_DDN, "Intel(R) Low Power Audio Controller - 80860F28")  =
// _DDN: DOS Device Name
> > > >     Name (_SUB, "80867270")  // _SUB: Subsystem ID
> > > >     Name (_UID, One)  // _UID: Unique ID
> > > > =

> > > >     Name (RBUF, ResourceTemplate ()
> > > >     {
> > > >         Memory32Fixed (ReadWrite,
> > > >             0x12345678,         // Address Base
> > > >             0x00200000,         // Address Length
> > > >             _Y08)
> > > >         Memory32Fixed (ReadWrite,
> > > >             0xFE830000,         // Address Base
> > > >             0x00001000,         // Address Length
> > > >             _Y09)
> > > >         Memory32Fixed (ReadWrite,
> > > >             0x55AA55AA,         // Address Base
> > > >             0x00200000,         // Address Length
> > > >             _Y0A)
> > > >         Interrupt (ResourceConsumer, Level, ActiveLow, Exclusive, ,=
, )
> > > >         {
> > > >             0x0000001D,
> > > >         }
> > > >     })
> > > > =

> > > > Unlike many of the other DSDT dumps I've looked at, there is only o=
ne
> > > > interrupt listed. Full ACPI DSDT table is at [1].
> > > > =

> > > > Since there is no IRQ at index 5, platform_get_irq will return -ENX=
IO.
> > > > Couldn't we fall back to index 0 in this case? I would say that if =
the
> > > > seemingly "correct" IRQ at index 5 does not even exist, we still ha=
ve
> > > > a better chance of picking the right one if we try the one at index=
 0.
> > > > Or we could check the number of interrupts that are actually availa=
ble.
> > > > =

> > > > The other option would be some kind of DMI-based quirk, but persona=
lly
> > > > I would prefer to avoid that.. (In my opinion, there is way too much
> > > > device specific code with the quirks etc already...)
> > > > =

> > > > Or do you have any other suggestions?
> > > > =

> > > > Thanks,
> > > > Stephan
> > > > =

> > > > [1]: https://github.com/me176c-dev/me176c-acpi/blob/f48c78c11b0819b=
899f988407b6ece3d8c2cca71/dsdt.dsl#L3989-L4035
> > > > _______________________________________________
> > > > Alsa-devel mailing list
> > > > Alsa-devel@alsa-project.org
> > > > http://mailman.alsa-project.org/mailman/listinfo/alsa-devel
