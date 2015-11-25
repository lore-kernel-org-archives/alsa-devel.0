From: Jorge Fernandez Monteagudo <jorgefm@cirsa.com>
Subject: Re: Intel SST and HP ElitePad 1000 G2
Date: Wed, 25 Nov 2015 09:49:41 +0100
Message-ID: <6A230045C5A9854B97A1D40971AC8BE1023ACE6022@NTMBOX.central.cirsa.com>
References: <6A230045C5A9854B97A1D40971AC8BE1023ACE6013@NTMBOX.central.cirsa.com>
 <6A230045C5A9854B97A1D40971AC8BE1023ACE601C@NTMBOX.central.cirsa.com>
 <565346A2.8060702@linux.intel.com>
 <6A230045C5A9854B97A1D40971AC8BE1023ACE601E@NTMBOX.central.cirsa.com>,
 <56547FE6.6050204@linux.intel.com>
Mime-Version: 1.0
Content-Type: multipart/mixed;
 boundary="_002_6A230045C5A9854B97A1D40971AC8BE1023ACE6022NTMBOXcentral_"
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mta2-data1.cirsa.com (pegasus.cirsa.com [195.77.234.26])
 by alsa0.perex.cz (Postfix) with ESMTP id 11AF6261583
 for <alsa-devel@alsa-project.org>; Wed, 25 Nov 2015 09:49:47 +0100 (CET)
In-Reply-To: <56547FE6.6050204@linux.intel.com>
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
To: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

--_002_6A230045C5A9854B97A1D40971AC8BE1023ACE6022NTMBOXcentral_
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

Hi,

I've generated a new kernel, a 4.3.0, only with=20

CONFIG_SND_SST_MFLD_PLATFORM=3Dm
CONFIG_SND_SST_IPC=3Dm
CONFIG_SND_SST_IPC_ACPI=3Dm
CONFIG_SND_SOC_INTEL_SST=3Dm
CONFIG_SND_SOC_INTEL_SST_ACPI=3Dm
CONFIG_SND_SOC_INTEL_BAYTRAIL=3Dm
CONFIG_SND_SOC_INTEL_BYT_MAX98090_MACH=3Dm
CONFIG_SND_SOC_INTEL_BYTCR_RT5640_MACH=3Dm
CONFIG_SND_SOC_I2C_AND_SPI=3Dm

and I've downloaded the firmware this repository (I don't know this git is =
the official one)
from http://git.kernel.org/cgit/linux/kernel/git/firmware/linux-firmware.gi=
t

But I have no audio. The firmware is loaded, I see this traces

[    4.013712] baytrail-pcm-audio baytrail-pcm-audio: FW version: 04.05.13.=
a0
[    4.013714] baytrail-pcm-audio baytrail-pcm-audio: Build type: a0
[    4.013716] baytrail-pcm-audio baytrail-pcm-audio: Build date: Apr  2 20=
14 14:14:39

but the mapping is not done. In the 4.2.5 kernel I see

[    4.256939] byt-rt5640 byt-rt5640: rt5640-aif1 <-> baytrail-pcm-audio ma=
pping ok

Both attached.

Another problem. In the working 4.2.5 kernel, when I run my application, a =
game which
plays sounds, in a few minutes the system is totally frozen, in some cases,=
 with a sound
looping endlessly. I'm trying to get a kernel trace to debug this situation=
... Any hint is welcome!

Regards

________________________________________
From: Pierre-Louis Bossart [pierre-louis.bossart@linux.intel.com]
Sent: Tuesday, November 24, 2015 4:19 PM
To: Jorge Fernandez Monteagudo; alsa-devel@alsa-project.org
Subject: Re: [alsa-devel] Intel SST and HP ElitePad 1000 G2

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

the .config looks problematic, you can't have both haswell/broadwell
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
>> I've been able to get the audio working in the HP ElitePad 1000G2 tablet=
.
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
>> This is my first email in this list, and my last chance to make my table=
t
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
>>               Method (_HRV, 0, NotSerialized)  // _HRV: Hardware Revisio=
n
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


--_002_6A230045C5A9854B97A1D40971AC8BE1023ACE6022NTMBOXcentral_
Content-Type: application/gzip; name="dmesg.tar.gz"
Content-Description: dmesg.tar.gz
Content-Disposition: attachment; filename="dmesg.tar.gz"; size=24431;
	creation-date="Wed, 25 Nov 2015 08:46:24 GMT";
	modification-date="Wed, 25 Nov 2015 08:46:24 GMT"
Content-Transfer-Encoding: base64

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

--_002_6A230045C5A9854B97A1D40971AC8BE1023ACE6022NTMBOXcentral_
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--_002_6A230045C5A9854B97A1D40971AC8BE1023ACE6022NTMBOXcentral_--
