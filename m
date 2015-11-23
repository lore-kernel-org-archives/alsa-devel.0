From: Jorge Fernandez Monteagudo <jorgefm@cirsa.com>
Subject: Re: Intel SST and HP ElitePad 1000 G2
Date: Mon, 23 Nov 2015 16:13:12 +0100
Message-ID: <6A230045C5A9854B97A1D40971AC8BE1023ACE601C@NTMBOX.central.cirsa.com>
References: <6A230045C5A9854B97A1D40971AC8BE1023ACE6013@NTMBOX.central.cirsa.com>
Mime-Version: 1.0
Content-Type: multipart/mixed;
 boundary="_002_6A230045C5A9854B97A1D40971AC8BE1023ACE601CNTMBOXcentral_"
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mta2-data1.cirsa.com (pegasus.cirsa.com [195.77.234.26])
 by alsa0.perex.cz (Postfix) with ESMTP id 15F80265357
 for <alsa-devel@alsa-project.org>; Mon, 23 Nov 2015 16:17:46 +0100 (CET)
In-Reply-To: <6A230045C5A9854B97A1D40971AC8BE1023ACE6013@NTMBOX.central.cirsa.com>
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
To: Jorge Fernandez Monteagudo <jorgefm@cirsa.com>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

--_002_6A230045C5A9854B97A1D40971AC8BE1023ACE601CNTMBOXcentral_
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

Hi,

I've been able to get the audio working in the HP ElitePad 1000G2 tablet.
Attached the patch I've used in a 4.2.5 to get it working.

Basically in this tablet the rt5640 realtek audio codec is identified with
INTCCFFD. I don't know how to share 'byt-rt5640.c' with two identifiers
because I had to change:

@@ -186,7 +194,7 @@
 		.stream_name =3D "Audio",
 		.cpu_dai_name =3D "baytrail-pcm-audio",
 		.codec_dai_name =3D "rt5640-aif1",
-		.codec_name =3D "i2c-10EC5640:00",
+		.codec_name =3D "i2c-INTCCFFD:00",
 		.platform_name =3D "baytrail-pcm-audio",
 		.dai_fmt =3D SND_SOC_DAIFMT_I2S | SND_SOC_DAIFMT_NB_NF |
 			   SND_SOC_DAIFMT_CBS_CFS,

but the correct will be to two both of them.

Regards

________________________________________
From: alsa-devel-bounces@alsa-project.org [alsa-devel-bounces@alsa-project.=
org] On Behalf Of Jorge Fernandez Monteagudo [jorgefm@cirsa.com]
Sent: Friday, November 20, 2015 4:27 PM
To: alsa-devel@alsa-project.org
Subject: [alsa-devel] Intel SST and HP ElitePad 1000 G2

Hi,

This is my first email in this list, and my last chance to make my tablet
audio system work

I'm trying to get my tablet audio system working but I'm run out of ideas.
The HP ElitePad 1000 G2 it's an Atom Z3795 1.60GHz Bay Trail-T tablet.

I'm using a kernel 4.2.5 with all the SST configs enabled:

CONFIG_SND_SST_MFLD_PLATFORM=3Dm
CONFIG_SND_SST_IPC=3Dm
CONFIG_SND_SST_IPC_ACPI=3Dm
CONFIG_SND_SOC_INTEL_SST=3Dm
CONFIG_SND_SOC_INTEL_SST_ACPI=3Dm
CONFIG_SND_SOC_INTEL_HASWELL=3Dm
CONFIG_SND_SOC_INTEL_BAYTRAIL=3Dm
CONFIG_SND_SOC_INTEL_HASWELL_MACH=3Dm
CONFIG_SND_SOC_INTEL_BYT_RT5640_MACH=3Dm
CONFIG_SND_SOC_INTEL_BYT_MAX98090_MACH=3Dm
CONFIG_SND_SOC_INTEL_BROADWELL_MACH=3Dm
CONFIG_SND_SOC_INTEL_BYTCR_RT5640_MACH=3Dm
CONFIG_SND_SOC_INTEL_CHT_BSW_RT5672_MACH=3Dm
CONFIG_SND_SOC_INTEL_CHT_BSW_RT5645_MACH=3Dm
CONFIG_SND_SOC_INTEL_CHT_BSW_MAX98090_TI_MACH=3Dm
# CONFIG_SND_SOC_QCOM is not set
# CONFIG_SND_SOC_XTFPGA_I2S is not set
CONFIG_SND_SOC_I2C_AND_SPI=3Dm

I've follow the same steps as the installation for Asus T100TA
https://wiki.debian.org/InstallingDebianOn/Asus/T100TA

and finally I only get the dmesg traces:

sst-acpi 80860F28:00: No matching ASoC machine driver found
intel-sst-acpi 80860F28:00: No matching machine driver found

>From the 'dsdt.dsl' I can see:

        Device (I2C2)
        {
            Name (_ADR, Zero)  // _ADR: Address
            Name (_HID, "80860F41" /* Intel Baytrail I2C Host Controller */=
)  // _HID: Hardware ID
            Name (_CID, "80860F41" /* Intel Baytrail I2C Host Controller */=
)  // _CID: Compatible ID
            Name (_DEP, Package (0x01)  // _DEP: Dependencies
            {
                PEPD
            })
            Name (_DDN, "Intel(R) I2C Controller #2 - 80860F42")  // _DDN: =
DOS Device Name
            Name (_UID, 0x02)  // _UID: Unique ID
            Name (RBUF, ResourceTemplate ()
            {
                Memory32Fixed (ReadWrite,
                    0x00000000,         // Address Base
                    0x00001000,         // Address Length
                    _Y12)
                Interrupt (ResourceConsumer, Level, ActiveLow, Exclusive, ,=
, )
                {
                    0x00000021,
                }
                FixedDMA (0x0012, 0x0002, Width32bit, )
                FixedDMA (0x0013, 0x0003, Width32bit, )
            })
            Method (_HRV, 0, NotSerialized)  // _HRV: Hardware Revision
            {
                Return (SOCS) /* \SOCS */
            }

            Method (_CRS, 0, NotSerialized)  // _CRS: Current Resource Sett=
ings
            {
                CreateDWordField (RBUF, \_SB.I2C2._Y12._BAS, B0BA)  // _BAS=
: Base Address
                CreateDWordField (RBUF, \_SB.I2C2._Y12._LEN, B0LN)  // _LEN=
: Length
                Store (I20A, B0BA) /* \_SB_.I2C2._CRS.B0BA */
                Store (I20L, B0LN) /* \_SB_.I2C2._CRS.B0LN */
                Return (RBUF) /* \_SB_.I2C2.RBUF */
            }

            Method (_STA, 0, NotSerialized)  // _STA: Status
            {
                If (LOr (LEqual (I20A, Zero), LEqual (L22D, One)))
                {
                    Return (Zero)
                }

                Return (0x0F)
            }

            Method (_PS3, 0, NotSerialized)  // _PS3: Power State 3
            {
                Or (PSAT, 0x03, PSAT) /* \_SB_.I2C2.PSAT */
                Or (PSAT, Zero, PSAT) /* \_SB_.I2C2.PSAT */
            }

            Method (_PS0, 0, NotSerialized)  // _PS0: Power State 0
            {
                And (PSAT, 0xFFFFFFFC, PSAT) /* \_SB_.I2C2.PSAT */
                Or (PSAT, Zero, PSAT) /* \_SB_.I2C2.PSAT */
            }

            OperationRegion (KEYS, SystemMemory, I21A, 0x0100)
            Field (KEYS, DWordAcc, NoLock, WriteAsZeros)
            {
                Offset (0x84),
                PSAT,   32
            }

            Device (RTEK)
            {
                Name (_ADR, Zero)  // _ADR: Address
                Name (_HID, "INTCCFFD")  // _HID: Hardware ID
                Name (_CID, "INTCCFFD")  // _CID: Compatible ID
                Name (_DDN, "RTEK Codec Controller ")  // _DDN: DOS Device =
Name
                Name (_UID, 0x02)  // _UID: Unique ID
                Method (_CRS, 0, NotSerialized)  // _CRS: Current Resource =
Settings
                {
                    Name (SBUF, ResourceTemplate ()
                    {
                        I2cSerialBus (0x001C, ControllerInitiated, 0x00061A=
80,
                            AddressingMode7Bit, "\\_SB.I2C2",
                            0x00, ResourceConsumer, ,
                            )
                        GpioInt (Edge, ActiveBoth, SharedAndWake, PullNone,=
 0x0000,
                            "\\_SB.GPO2", 0x00, ResourceConsumer, ,
                            )
                            {   // Pin list
                                0x000E
                            }
                        GpioInt (Edge, ActiveBoth, SharedAndWake, PullNone,=
 0x0000,
                            "\\_SB.GPO0", 0x00, ResourceConsumer, ,
                            )
                            {   // Pin list
                                0x0003
                            }
                        GpioInt (Edge, ActiveBoth, SharedAndWake, PullNone,=
 0x0000,
                            "\\_SB.GPO0", 0x00, ResourceConsumer, ,
                            )
                            {   // Pin list
                                0x0000
                            }
                        GpioIo (Shared, PullDefault, 0x0000, 0x0000, IoRest=
rictionInputOnly,
                            "\\_SB.GPO2", 0x00, ResourceConsumer, ,
                            )
                            {   // Pin list
                                0x000E
                            }
                        GpioIo (Shared, PullDefault, 0x0000, 0x0000, IoRest=
rictionInputOnly,
                            "\\_SB.GPO0", 0x00, ResourceConsumer, ,
                            )
                            {   // Pin list
                                0x0003,
                                0x0000
                            }
                    })
                    Return (SBUF) /* \_SB_.I2C2.RTEK._CRS.SBUF */
                }

What am I missing? I suppose I need some changes in the kernel sources but =
I don't know
where to start. Any help is welcome

Regards,
Jorge

Este mensaje se dirige exclusivamente a su destinatario y puede contener in=
formaci=F3n privilegiada o CONFIDENCIAL. Si no es vd. el destinatario indic=
ado, queda notificado de que la utilizaci=F3n, divulgaci=F3n y/o copia sin =
autorizaci=F3n est=E1 prohibida en virtud de la legislaci=F3n vigente. Si h=
a recibido este mensaje por error, le rogamos que nos lo comunique inmediat=
amente por esta misma v=EDa y proceda a su destrucci=F3n.

This message is intended exclusively for its addressee and may contain info=
rmation that is CONFIDENTIAL and protected by professional privilege.
If you are not the intended recipient you are hereby notified that any diss=
emination, copy or disclosure of this communication is strictly prohibited =
by law. If this message has been received in error, please immediately noti=
fy us via e-mail and delete it.
_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
http://mailman.alsa-project.org/mailman/listinfo/alsa-devel

--_002_6A230045C5A9854B97A1D40971AC8BE1023ACE601CNTMBOXcentral_
Content-Type: text/x-patch; name="audio-hp-elitepad-1000g2.diff"
Content-Description: audio-hp-elitepad-1000g2.diff
Content-Disposition: attachment; filename="audio-hp-elitepad-1000g2.diff";
	size=1907; creation-date="Mon, 23 Nov 2015 15:17:05 GMT";
	modification-date="Mon, 23 Nov 2015 15:17:05 GMT"
Content-Transfer-Encoding: base64

ZGlmZiAtdU5yIG9yaWcvc291bmQvc29jL2NvZGVjcy9ydDU2NDAuYyBsaW51eC00LjIuNS9zb3Vu
ZC9zb2MvY29kZWNzL3J0NTY0MC5jCi0tLSBvcmlnL3NvdW5kL3NvYy9jb2RlY3MvcnQ1NjQwLmMJ
MjAxNS0xMC0yNyAwMTo1Mzo1OS4wMDAwMDAwMDAgKzAxMDAKKysrIGxpbnV4LTQuMi41L3NvdW5k
L3NvYy9jb2RlY3MvcnQ1NjQwLmMJMjAxNS0xMS0yMyAxMjowNzowMS41NTU5NjkxODcgKzAxMDAK
QEAgLTIxNTksNiArMjE1OSw3IEBACiAJeyAiSU5UMzNDQSIsIDAgfSwKIAl7ICIxMEVDNTY0MCIs
IDAgfSwKIAl7ICIxMEVDNTY0MiIsIDAgfSwKKwl7ICJJTlRDQ0ZGRCIsIDAgfSwKIAl7IH0sCiB9
OwogTU9EVUxFX0RFVklDRV9UQUJMRShhY3BpLCBydDU2NDBfYWNwaV9tYXRjaCk7CmRpZmYgLXVO
ciBvcmlnL3NvdW5kL3NvYy9pbnRlbC9ib2FyZHMvYnl0LXJ0NTY0MC5jIGxpbnV4LTQuMi41L3Nv
dW5kL3NvYy9pbnRlbC9ib2FyZHMvYnl0LXJ0NTY0MC5jCi0tLSBvcmlnL3NvdW5kL3NvYy9pbnRl
bC9ib2FyZHMvYnl0LXJ0NTY0MC5jCTIwMTUtMTAtMjcgMDE6NTM6NTkuMDAwMDAwMDAwICswMTAw
CisrKyBsaW51eC00LjIuNS9zb3VuZC9zb2MvaW50ZWwvYm9hcmRzL2J5dC1ydDU2NDAuYwkyMDE1
LTExLTIzIDE1OjI2OjQ0LjUwNzY1MzgzNSArMDEwMApAQCAtMTI1LDYgKzEyNSwxNCBAQAogCQku
ZHJpdmVyX2RhdGEgPSAodW5zaWduZWQgbG9uZyAqKShCWVRfUlQ1NjQwX0RNSUMyX01BUCB8CiAJ
CQkJCQkgQllUX1JUNTY0MF9ETUlDX0VOKSwKIAl9LAorCXsKKwkJLmNhbGxiYWNrID0gYnl0X3J0
NTY0MF9xdWlya19jYiwKKwkJLm1hdGNoZXMgPSB7CisJCQlETUlfTUFUQ0goRE1JX1NZU19WRU5E
T1IsICJIZXdsZXR0LVBhY2thcmQiKSwKKwkJCURNSV9NQVRDSChETUlfUFJPRFVDVF9OQU1FLCAi
SFAgRWxpdGVQYWQgMTAwMCBHMiIpLAorCQl9LAorCQkuZHJpdmVyX2RhdGEgPSAodW5zaWduZWQg
bG9uZyAqKUJZVF9SVDU2NDBfSU4xX01BUCwKKwl9LAogCXt9CiB9OwogCkBAIC0xODYsNyArMTk0
LDcgQEAKIAkJLnN0cmVhbV9uYW1lID0gIkF1ZGlvIiwKIAkJLmNwdV9kYWlfbmFtZSA9ICJiYXl0
cmFpbC1wY20tYXVkaW8iLAogCQkuY29kZWNfZGFpX25hbWUgPSAicnQ1NjQwLWFpZjEiLAotCQku
Y29kZWNfbmFtZSA9ICJpMmMtMTBFQzU2NDA6MDAiLAorCQkuY29kZWNfbmFtZSA9ICJpMmMtSU5U
Q0NGRkQ6MDAiLAogCQkucGxhdGZvcm1fbmFtZSA9ICJiYXl0cmFpbC1wY20tYXVkaW8iLAogCQku
ZGFpX2ZtdCA9IFNORF9TT0NfREFJRk1UX0kyUyB8IFNORF9TT0NfREFJRk1UX05CX05GIHwKIAkJ
CSAgIFNORF9TT0NfREFJRk1UX0NCU19DRlMsCmRpZmYgLXVOciBvcmlnL3NvdW5kL3NvYy9pbnRl
bC9jb21tb24vc3N0LWFjcGkuYyBsaW51eC00LjIuNS9zb3VuZC9zb2MvaW50ZWwvY29tbW9uL3Nz
dC1hY3BpLmMKLS0tIG9yaWcvc291bmQvc29jL2ludGVsL2NvbW1vbi9zc3QtYWNwaS5jCTIwMTUt
MTAtMjcgMDE6NTM6NTkuMDAwMDAwMDAwICswMTAwCisrKyBsaW51eC00LjIuNS9zb3VuZC9zb2Mv
aW50ZWwvY29tbW9uL3NzdC1hY3BpLmMJMjAxNS0xMS0yMyAxMjowOTozNy43MzUwMDE5NzkgKzAx
MDAKQEAgLTI0OSw2ICsyNDksNyBAQAogc3RhdGljIHN0cnVjdCBzc3RfYWNwaV9tYWNoIGJheXRy
YWlsX21hY2hpbmVzW10gPSB7CiAJeyAiMTBFQzU2NDAiLCAiYnl0LXJ0NTY0MCIsICJpbnRlbC9m
d19zc3RfMGYyOC5iaW4tNDhrSHpfaTJzX21hc3RlciIgfSwKIAl7ICIxOTNDOTg5MCIsICJieXQt
bWF4OTgwOTAiLCAiaW50ZWwvZndfc3N0XzBmMjguYmluLTQ4a0h6X2kyc19tYXN0ZXIiIH0sCisJ
eyAiSU5UQ0NGRkQiLCAiYnl0LXJ0NTY0MCIsICJpbnRlbC9md19zc3RfMGYyOC5iaW4tNDhrSHpf
aTJzX21hc3RlciIgfSwKIAl7fQogfTsKIAo=

--_002_6A230045C5A9854B97A1D40971AC8BE1023ACE601CNTMBOXcentral_
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--_002_6A230045C5A9854B97A1D40971AC8BE1023ACE601CNTMBOXcentral_--
