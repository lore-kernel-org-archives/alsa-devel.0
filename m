From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Subject: Re: Intel SST and HP ElitePad 1000 G2
Date: Tue, 24 Nov 2015 09:19:02 -0600
Message-ID: <56547FE6.6050204@linux.intel.com>
References: <6A230045C5A9854B97A1D40971AC8BE1023ACE6013@NTMBOX.central.cirsa.com>
 <6A230045C5A9854B97A1D40971AC8BE1023ACE601C@NTMBOX.central.cirsa.com>
 <565346A2.8060702@linux.intel.com>
 <6A230045C5A9854B97A1D40971AC8BE1023ACE601E@NTMBOX.central.cirsa.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"; Format="flowed"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
 by alsa0.perex.cz (Postfix) with ESMTP id E11EC2659C4
 for <alsa-devel@alsa-project.org>; Tue, 24 Nov 2015 16:19:06 +0100 (CET)
In-Reply-To: <6A230045C5A9854B97A1D40971AC8BE1023ACE601E@NTMBOX.central.cirsa.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Jorge Fernandez Monteagudo <jorgefm@cirsa.com>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org


> I've download your t100-v4.3-24bit branch, then I've patched it with my c=
hanges
> and I've deployed it in the tablet. I've copied the bytcr-rt5640 from UCM=
 master
> branch in the /usr/share/alsa/ucm tablet directory, but after rebooting I=
 have no
> sound.
>
> Attached you can find the dmesg log and the .config used to generate the =
kernel,
> maybe any option has to be enabled...

the .config looks problematic, you can't have both haswell/broadwell =

enabled at the same time. I only have these options defined:

CONFIG_SND_SST_MFLD_PLATFORM=3Dm
CONFIG_SND_SST_IPC=3Dm
CONFIG_SND_SST_IPC_ACPI=3Dm
CONFIG_SND_SOC_INTEL_BYTCR_RT5640_MACH=3Dm

Also make sure you have a 'recent' /lib/firmware.

>
> Regards,
> Jorge
> ________________________________________
> From: Pierre-Louis Bossart [pierre-louis.bossart@linux.intel.com]
> Sent: Monday, November 23, 2015 6:02 PM
> To: Jorge Fernandez Monteagudo; alsa-devel@alsa-project.org
> Subject: Re: [alsa-devel] Intel SST and HP ElitePad 1000 G2
>
> On 11/23/15 9:13 AM, Jorge Fernandez Monteagudo wrote:
>> Hi,
>>
>> I've been able to get the audio working in the HP ElitePad 1000G2 tablet.
>> Attached the patch I've used in a 4.2.5 to get it working.
>
> Thanks for sharing and good to hear that you have audio working. I have
> no idea why BIOS folks keep inventing new (and illegal) ACPI _HID values.=
..
>
> We may need to use the same tricks as in sst-acpi to find out which
> string to use for .codec_name based on which _HID is handled by the ACPI
> subsystem instead of a hard-coded value.
>
> Note that we are trying to move away from this older driver to a newer
> one based on DPCM that would also support BYT-CR devices and MinnowMax
> Board. It's not ready yet for upstream but if you want to add those
> changes to the newer version and test it'd be great. See
> https://github.com/plbossart/sound.git t100-v4.3-24bit and matching UCM
> files at https://github.com/plbossart/UCM
>
>>
>> Basically in this tablet the rt5640 realtek audio codec is identified wi=
th
>> INTCCFFD. I don't know how to share 'byt-rt5640.c' with two identifiers
>> because I had to change:
>>
>> @@ -186,7 +194,7 @@
>>                .stream_name =3D "Audio",
>>                .cpu_dai_name =3D "baytrail-pcm-audio",
>>                .codec_dai_name =3D "rt5640-aif1",
>> -             .codec_name =3D "i2c-10EC5640:00",
>> +             .codec_name =3D "i2c-INTCCFFD:00",
>>                .platform_name =3D "baytrail-pcm-audio",
>>                .dai_fmt =3D SND_SOC_DAIFMT_I2S | SND_SOC_DAIFMT_NB_NF |
>>                           SND_SOC_DAIFMT_CBS_CFS,
>>
>> but the correct will be to two both of them.
>>
>> Regards
>>
>> ________________________________________
>> From: alsa-devel-bounces@alsa-project.org [alsa-devel-bounces@alsa-proje=
ct.org] On Behalf Of Jorge Fernandez Monteagudo [jorgefm@cirsa.com]
>> Sent: Friday, November 20, 2015 4:27 PM
>> To: alsa-devel@alsa-project.org
>> Subject: [alsa-devel] Intel SST and HP ElitePad 1000 G2
>>
>> Hi,
>>
>> This is my first email in this list, and my last chance to make my tablet
>> audio system work
>>
>> I'm trying to get my tablet audio system working but I'm run out of idea=
s.
>> The HP ElitePad 1000 G2 it's an Atom Z3795 1.60GHz Bay Trail-T tablet.
>>
>> I'm using a kernel 4.2.5 with all the SST configs enabled:
>>
>> CONFIG_SND_SST_MFLD_PLATFORM=3Dm
>> CONFIG_SND_SST_IPC=3Dm
>> CONFIG_SND_SST_IPC_ACPI=3Dm
>> CONFIG_SND_SOC_INTEL_SST=3Dm
>> CONFIG_SND_SOC_INTEL_SST_ACPI=3Dm
>> CONFIG_SND_SOC_INTEL_HASWELL=3Dm
>> CONFIG_SND_SOC_INTEL_BAYTRAIL=3Dm
>> CONFIG_SND_SOC_INTEL_HASWELL_MACH=3Dm
>> CONFIG_SND_SOC_INTEL_BYT_RT5640_MACH=3Dm
>> CONFIG_SND_SOC_INTEL_BYT_MAX98090_MACH=3Dm
>> CONFIG_SND_SOC_INTEL_BROADWELL_MACH=3Dm
>> CONFIG_SND_SOC_INTEL_BYTCR_RT5640_MACH=3Dm
>> CONFIG_SND_SOC_INTEL_CHT_BSW_RT5672_MACH=3Dm
>> CONFIG_SND_SOC_INTEL_CHT_BSW_RT5645_MACH=3Dm
>> CONFIG_SND_SOC_INTEL_CHT_BSW_MAX98090_TI_MACH=3Dm
>> # CONFIG_SND_SOC_QCOM is not set
>> # CONFIG_SND_SOC_XTFPGA_I2S is not set
>> CONFIG_SND_SOC_I2C_AND_SPI=3Dm
>>
>> I've follow the same steps as the installation for Asus T100TA
>> https://wiki.debian.org/InstallingDebianOn/Asus/T100TA
>>
>> and finally I only get the dmesg traces:
>>
>> sst-acpi 80860F28:00: No matching ASoC machine driver found
>> intel-sst-acpi 80860F28:00: No matching machine driver found
>>
>>   From the 'dsdt.dsl' I can see:
>>
>>           Device (I2C2)
>>           {
>>               Name (_ADR, Zero)  // _ADR: Address
>>               Name (_HID, "80860F41" /* Intel Baytrail I2C Host Controll=
er */)  // _HID: Hardware ID
>>               Name (_CID, "80860F41" /* Intel Baytrail I2C Host Controll=
er */)  // _CID: Compatible ID
>>               Name (_DEP, Package (0x01)  // _DEP: Dependencies
>>               {
>>                   PEPD
>>               })
>>               Name (_DDN, "Intel(R) I2C Controller #2 - 80860F42")  // _=
DDN: DOS Device Name
>>               Name (_UID, 0x02)  // _UID: Unique ID
>>               Name (RBUF, ResourceTemplate ()
>>               {
>>                   Memory32Fixed (ReadWrite,
>>                       0x00000000,         // Address Base
>>                       0x00001000,         // Address Length
>>                       _Y12)
>>                   Interrupt (ResourceConsumer, Level, ActiveLow, Exclusi=
ve, ,, )
>>                   {
>>                       0x00000021,
>>                   }
>>                   FixedDMA (0x0012, 0x0002, Width32bit, )
>>                   FixedDMA (0x0013, 0x0003, Width32bit, )
>>               })
>>               Method (_HRV, 0, NotSerialized)  // _HRV: Hardware Revision
>>               {
>>                   Return (SOCS) /* \SOCS */
>>               }
>>
>>               Method (_CRS, 0, NotSerialized)  // _CRS: Current Resource=
 Settings
>>               {
>>                   CreateDWordField (RBUF, \_SB.I2C2._Y12._BAS, B0BA)  //=
 _BAS: Base Address
>>                   CreateDWordField (RBUF, \_SB.I2C2._Y12._LEN, B0LN)  //=
 _LEN: Length
>>                   Store (I20A, B0BA) /* \_SB_.I2C2._CRS.B0BA */
>>                   Store (I20L, B0LN) /* \_SB_.I2C2._CRS.B0LN */
>>                   Return (RBUF) /* \_SB_.I2C2.RBUF */
>>               }
>>
>>               Method (_STA, 0, NotSerialized)  // _STA: Status
>>               {
>>                   If (LOr (LEqual (I20A, Zero), LEqual (L22D, One)))
>>                   {
>>                       Return (Zero)
>>                   }
>>
>>                   Return (0x0F)
>>               }
>>
>>               Method (_PS3, 0, NotSerialized)  // _PS3: Power State 3
>>               {
>>                   Or (PSAT, 0x03, PSAT) /* \_SB_.I2C2.PSAT */
>>                   Or (PSAT, Zero, PSAT) /* \_SB_.I2C2.PSAT */
>>               }
>>
>>               Method (_PS0, 0, NotSerialized)  // _PS0: Power State 0
>>               {
>>                   And (PSAT, 0xFFFFFFFC, PSAT) /* \_SB_.I2C2.PSAT */
>>                   Or (PSAT, Zero, PSAT) /* \_SB_.I2C2.PSAT */
>>               }
>>
>>               OperationRegion (KEYS, SystemMemory, I21A, 0x0100)
>>               Field (KEYS, DWordAcc, NoLock, WriteAsZeros)
>>               {
>>                   Offset (0x84),
>>                   PSAT,   32
>>               }
>>
>>               Device (RTEK)
>>               {
>>                   Name (_ADR, Zero)  // _ADR: Address
>>                   Name (_HID, "INTCCFFD")  // _HID: Hardware ID
>>                   Name (_CID, "INTCCFFD")  // _CID: Compatible ID
>>                   Name (_DDN, "RTEK Codec Controller ")  // _DDN: DOS De=
vice Name
>>                   Name (_UID, 0x02)  // _UID: Unique ID
>>                   Method (_CRS, 0, NotSerialized)  // _CRS: Current Reso=
urce Settings
>>                   {
>>                       Name (SBUF, ResourceTemplate ()
>>                       {
>>                           I2cSerialBus (0x001C, ControllerInitiated, 0x0=
0061A80,
>>                               AddressingMode7Bit, "\\_SB.I2C2",
>>                               0x00, ResourceConsumer, ,
>>                               )
>>                           GpioInt (Edge, ActiveBoth, SharedAndWake, Pull=
None, 0x0000,
>>                               "\\_SB.GPO2", 0x00, ResourceConsumer, ,
>>                               )
>>                               {   // Pin list
>>                                   0x000E
>>                               }
>>                           GpioInt (Edge, ActiveBoth, SharedAndWake, Pull=
None, 0x0000,
>>                               "\\_SB.GPO0", 0x00, ResourceConsumer, ,
>>                               )
>>                               {   // Pin list
>>                                   0x0003
>>                               }
>>                           GpioInt (Edge, ActiveBoth, SharedAndWake, Pull=
None, 0x0000,
>>                               "\\_SB.GPO0", 0x00, ResourceConsumer, ,
>>                               )
>>                               {   // Pin list
>>                                   0x0000
>>                               }
>>                           GpioIo (Shared, PullDefault, 0x0000, 0x0000, I=
oRestrictionInputOnly,
>>                               "\\_SB.GPO2", 0x00, ResourceConsumer, ,
>>                               )
>>                               {   // Pin list
>>                                   0x000E
>>                               }
>>                           GpioIo (Shared, PullDefault, 0x0000, 0x0000, I=
oRestrictionInputOnly,
>>                               "\\_SB.GPO0", 0x00, ResourceConsumer, ,
>>                               )
>>                               {   // Pin list
>>                                   0x0003,
>>                                   0x0000
>>                               }
>>                       })
>>                       Return (SBUF) /* \_SB_.I2C2.RTEK._CRS.SBUF */
>>                   }
>>
>> What am I missing? I suppose I need some changes in the kernel sources b=
ut I don't know
>> where to start. Any help is welcome
>>
>> Regards,
>> Jorge
>>
>> Este mensaje se dirige exclusivamente a su destinatario y puede contener=
 informaci=F3n privilegiada o CONFIDENCIAL. Si no es vd. el destinatario in=
dicado, queda notificado de que la utilizaci=F3n, divulgaci=F3n y/o copia s=
in autorizaci=F3n est=E1 prohibida en virtud de la legislaci=F3n vigente. S=
i ha recibido este mensaje por error, le rogamos que nos lo comunique inmed=
iatamente por esta misma v=EDa y proceda a su destrucci=F3n.
>>
>> This message is intended exclusively for its addressee and may contain i=
nformation that is CONFIDENTIAL and protected by professional privilege.
>> If you are not the intended recipient you are hereby notified that any d=
issemination, copy or disclosure of this communication is strictly prohibit=
ed by law. If this message has been received in error, please immediately n=
otify us via e-mail and delete it.
>> _______________________________________________
>> Alsa-devel mailing list
>> Alsa-devel@alsa-project.org
>> http://mailman.alsa-project.org/mailman/listinfo/alsa-devel
>>
>>
>>
>> _______________________________________________
>> Alsa-devel mailing list
>> Alsa-devel@alsa-project.org
>> http://mailman.alsa-project.org/mailman/listinfo/alsa-devel
>>
>
