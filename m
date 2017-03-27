From: Ed McNicholas <emcnicholas@bogen.com>
Subject: ALSA Overlay 24bit data 32bit slots
Date: Mon, 27 Mar 2017 16:30:01 +0000
Message-ID: <BN3PR0701MB16888D7C159EED2A635A647AA2330@BN3PR0701MB1688.namprd07.prod.outlook.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============6712559013365440572=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from NAM01-BN3-obe.outbound.protection.outlook.com
 (mail-bn3nam01on0090.outbound.protection.outlook.com [104.47.33.90])
 by alsa0.perex.cz (Postfix) with ESMTP id A526A26583C
 for <alsa-devel@alsa-project.org>; Mon, 27 Mar 2017 18:30:04 +0200 (CEST)
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
To: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

--===============6712559013365440572==
Content-Language: en-US
Content-Type: multipart/related;
	boundary="_004_BN3PR0701MB16888D7C159EED2A635A647AA2330BN3PR0701MB1688_";
	type="multipart/alternative"

--_004_BN3PR0701MB16888D7C159EED2A635A647AA2330BN3PR0701MB1688_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

I am interfacing with a dsp that we have programmed and there are only opti=
ons for slot widths of 16 or 32 bits but we are using a 24 bit data format.=
 When I record using

arecord -v -f S32_LE -r 48000 -t wav -c4 /home/nyquist/test.wav

I get valid audio recording but the lower 8bits is 0 as would be expected. =
When I record using :

arecord -v -f S24_LE -r 48000 -t wav -c4 /home/nyquist/test.wav

I get garbage as it appears to be using 24bit wide tdm slots.  My overlay i=
s below and I have set what I believe are the correct slot configurations f=
or the device.  We have 4 channel input and one channel output 32bit slot w=
idth.

Any help would be greatly appreciated as I am sure I am missing something.

/dts-v1/;
/plugin/;

#include <dt-bindings/gpio/gpio.h>
#include <dt-bindings/pinctrl/am33xx.h>
#include <dt-bindings/interrupt-controller/irq.h>
#include <dt-bindings/input/linux-event-codes.h>


/ {
                compatible =3D "ti,beaglebone", "ti,beaglebone-black", "ti,=
beaglebone-green";

                /* identification */
                part-number =3D "NQ-ASB-01";
                version =3D "00A0", "A0";

                fragment@0 {
                                target =3D <&am33xx_pinmux>;
                                __overlay__ {

                                                bone_audio_cape_audio_pins:=
 pinmux_bone_audio_cape_audio_pins {
                                                                pinctrl-sin=
gle,pins =3D <
                                                                           =
     0x190 (PIN_INPUT_PULLDOWN | MUX_MODE0) /* mcasp0_aclkx.mcasp0_aclkx */
                                                                           =
     0x194 (PIN_INPUT_PULLDOWN | MUX_MODE0) /* mcasp0_fsx.mcasp0_fsx, INPUT=
 */
                                                                           =
     0x198 (PIN_INPUT_PULLDOWN | MUX_MODE0) /* mcasp0_axr0.mcasp0_axr0 */
                                                                           =
     0x19c (PIN_INPUT_PULLDOWN | MUX_MODE2) /* mcasp0_ahclkr.mcasp0_axr2 */
                                                                           =
     0x1ac (PIN_INPUT_PULLDOWN | MUX_MODE0) /* MCASP0_AHCLKX -> MCASP0_AHCL=
KX (I2S_MCLK_OUT)- in */
                                                                           =
     0x06c ( PIN_OUTPUT_PULLUP | MUX_MODE7 ) /* mcasp0_axr1 GPIO1_27 | OUTP=
UT | PULLUP */
                                                                >;
                                                };
                                                /* dsp SPI Pins */
                                                bb_spi0_pins: pinmux_bb_spi=
0_pins {
                                                                pinctrl-sin=
gle,pins =3D <
                                                                           =
     0x150 0x30         /* p84 spi0_sclk.spi0_sclk, INPUT_PULLUP | MODE0 */
                                                                           =
     0x154 0x30         /* p85 spi0_d0.spi0_d0, INPUT_PULLUP | MODE0 */
                                                                           =
     0x158 0x10         /* p86 spi0_d1.spi0_d1, OUTPUT_PULLUP | MODE0 */
                                                                           =
     0x15c 0x10          /* p87 spi0_cs0.spi0_cs0, OUTPUT_PULLUP | MODE0 */
                                                                >;
                                                };
                                };
                };

                /* Relay Spi Interface */
                fragment@1 {
                                target =3D <&spi0>;
                                __overlay__ {
                                                #address-cells =3D <1>;
                                                #size-cells =3D <0>;

                                                status =3D "okay";
                                                pinctrl-names =3D "default"=
;
                                                pinctrl-0 =3D <&bb_spi0_pin=
s>;
                                                ti,pio-mode; /* disable dma=
 when used as an overlay, dma gets stuck at 160 bits... */
                                                ti,pindir-d0-out-d1-in =3D =
<1>;

                                                dspspi: channel@0 {
                                                                #address-ce=
lls =3D <1>;
                                                                #size-cells=
 =3D <0>;
                                                                #sound-dai-=
cells =3D <0>;

                                                                compatible =
=3D "nq,dsp";

                                                                reg =3D <0>=
;
                                                                spi-max-fre=
quency =3D <16000000>;
                                                                spi-cpha;
                                                };
                                };
                };
                /* MCASP Interface */
                fragment@2 {
                                target =3D <&mcasp0>;
                                __overlay__ {
                                                #sound-dai-cells =3D <0>;
                                                compatible =3D "ti,am33xx-m=
casp-audio";
                                                pinctrl-names =3D "default"=
;
                                                pinctrl-0 =3D <&bone_audio_=
cape_audio_pins>;
                                                status =3D "okay";
                                                op-mode =3D <0>;          /=
* MCASP_IIS_MODE */
                                                tdm-slots =3D <4>;
                                                serial-dir =3D <  /* 0: INA=
CTIVE, 1: TX, 2: RX */
                                                                2 0 1 0
                                                                0 0 0 0
                                                                0 0 0 0
                                                                0 0 0 0
                                                >;
                                                tx-num-evt =3D <1>;
                                                rx-num-evt =3D <1>;
                                };
                };
                /*Sound Interface Config */
                fragment@3 {
                                target-path=3D"/";
                                __overlay__ {
                                                sound {
                                                                compatible =
=3D "simple-audio-card";
                                                                simple-audi=
o-card,name =3D "Nyquist Mixer DSP";
                                                                simple-audi=
o-card,format =3D "dsp_a";
                                                                simple-audi=
o-card,bitclock-master =3D <&sound_master>;
                                                                simple-audi=
o-card,frame-master =3D <&sound_master>;

                                                                simple-audi=
o-card,widgets =3D
                                                                           =
     "Line", "Line In";

                                                                simple-audi=
o-card,cpu {
                                                                           =
     sound-dai =3D <&mcasp0>;
                                                                           =
     dai-tdm-slot-num =3D <4>;
                                                                           =
     dai-tdm-slot-width =3D <32>;
                                                                           =
     dai-tdm-slot-tx-mask =3D <1 0 0 0>;
                                                                           =
     dai-tdm-slot-rx-mask =3D <1 1 1 1>;
                                                                };

                                                                sound_maste=
r: simple-audio-card,codec {
                                                                           =
     sound-dai =3D <&dspspi>;
                                                                           =
     dai-tdm-slot-num =3D <4>;
                                                                           =
     dai-tdm-slot-width =3D <32>;
                                                                           =
     dai-tdm-slot-tx-mask =3D <1 0 0 0>;
                                                                           =
     dai-tdm-slot-rx-mask =3D <1 1 1 1>;
                                                                };
                                                };
                                };

                };
};


Ed McNicholas
Sr Embedded Engineer

[Bogen Signature Logo]<http://www.bogen.com/>
Bogen Communications, Inc.
3862 Quadrangle Blvd
Suite 150
Orlando, FL 32817
Direct: (201) 995-2087
Cell: (321) 217-5518


--_004_BN3PR0701MB16888D7C159EED2A635A647AA2330BN3PR0701MB1688_
Content-Type: image/jpeg; name="image001.jpg"
Content-Description: image001.jpg
Content-Disposition: inline; filename="image001.jpg"; size=1940;
	creation-date="Mon, 27 Mar 2017 16:30:00 GMT";
	modification-date="Mon, 27 Mar 2017 16:30:00 GMT"
Content-ID: <image001.jpg@01D2A6F5.D65D6910>
Content-Transfer-Encoding: base64

/9j/4AAQSkZJRgABAQEAYABgAAD/2wBDAAoHBwgHBgoICAgLCgoLDhgQDg0NDh0VFhEYIx8lJCIf
IiEmKzcvJik0KSEiMEExNDk7Pj4+JS5ESUM8SDc9Pjv/2wBDAQoLCw4NDhwQEBw7KCIoOzs7Ozs7
Ozs7Ozs7Ozs7Ozs7Ozs7Ozs7Ozs7Ozs7Ozs7Ozs7Ozs7Ozs7Ozs7Ozs7Ozv/wAARCAAXAIADASIA
AhEBAxEB/8QAHwAAAQUBAQEBAQEAAAAAAAAAAAECAwQFBgcICQoL/8QAtRAAAgEDAwIEAwUFBAQA
AAF9AQIDAAQRBRIhMUEGE1FhByJxFDKBkaEII0KxwRVS0fAkM2JyggkKFhcYGRolJicoKSo0NTY3
ODk6Q0RFRkdISUpTVFVWV1hZWmNkZWZnaGlqc3R1dnd4eXqDhIWGh4iJipKTlJWWl5iZmqKjpKWm
p6ipqrKztLW2t7i5usLDxMXGx8jJytLT1NXW19jZ2uHi4+Tl5ufo6erx8vP09fb3+Pn6/8QAHwEA
AwEBAQEBAQEBAQAAAAAAAAECAwQFBgcICQoL/8QAtREAAgECBAQDBAcFBAQAAQJ3AAECAxEEBSEx
BhJBUQdhcRMiMoEIFEKRobHBCSMzUvAVYnLRChYkNOEl8RcYGRomJygpKjU2Nzg5OkNERUZHSElK
U1RVVldYWVpjZGVmZ2hpanN0dXZ3eHl6goOEhYaHiImKkpOUlZaXmJmaoqOkpaanqKmqsrO0tba3
uLm6wsPExcbHyMnK0tPU1dbX2Nna4uPk5ebn6Onq8vP09fb3+Pn6/9oADAMBAAIRAxEAPwCvFql+
0yLJqF5sLANslYnHfHPWtO9u4Y7V2tdR13zR93z/AJU/E5rVj+Hl1BdJ5es26ToQygKdwI6HGa0L
jw14gvUks5/FCSqw+eIr1HuK7HUhfRnzlPC4hRalF3/rzMrwfrOoxzXU9xqDT21vA7m3kk3O5AyN
oPNZsuu6x4l1SK1e+a3W4kCKiMVRM+uOtdVoPgaDS7xNQur9Z/LyFVRhOeOT369Kj1L4eWU8jz6d
ffZQDko3zKp+vUVPPT5ma/VsW6MV2eqvuOHw1tDHltSuTN/f2jGfp/8AXrl57/WPCmsS2cGpNKIW
HBYsjDryD0rpR4c8UrCYl8TJ5SjB+dsgfXFNsPh3beaZtS1E3ODudI+AfqxOaFNL4ncqph5yt7Gm
4vvf/glXxB43vmsrJLEfZWuIBLI4GSMkjC57cdaj0Hw1P4h046nqWrXPlsW2qrljx1JJ/lXU614W
0zW7aKIMLd7dAsTxY+VewI7isGw8La9pqSf2Tr9v5BPzDPy/iORSUo8to6MudCt7bmqpyj5f5GBP
Hp9rMr6P4lkQd/MDqR+IHNaN3rl5c+E7mN9US5mgmj2zQ7kfac8E4GatXPg7UdQkjbVNcswAMqEU
Dj1A4q+3gaz/ALElsbC9BmmZHeaQ7shSegHQU3OGl2ZRw+I97ljZWfX9Ls4ixvpJZWF5qWoogXgw
MXOfpmr4ms2IH9sa5ycf6s//ABVbVh4J1GxZ7iw8QQxHG13jHb0JzV7/AIR3xMCB/wAJVyRkDHUV
TnG+j/r7iKeFrKPvRd/6/vI5/wAYG70m9srKLULlhFaqC/mFS53Hk89aqafr2ueHriKaVpZIZ0Di
OdiyyL6g9q6XU/Bl3rn2aY6vDLJDAIpJMbt7Ak54+tb6aHYz6Db6Rf8Al3AiQR7gcEMB1HcGp9pF
RSepr9UryqylFuPb/I5LxX4oh1bRbObTrmSCUSkSxByrL8vfHUe9b3w/mln8PM80ryt57Dc7Fj29
aw5vhs/myGHVYhEp/jTlR74Na+k+GLyz02KC21ZCqyM5aLODn+dTJw5LJmlGOJ9v7SpHoZmheFdQ
02ZIb3RLS6vFndzrpuAZTnOH2kZ3DONvSquneCtYgbTIDptra3lndia41tLktJcqDlhtxuJccEMc
Ciiuc9grP8NNXbw7NH9smFw941wLAXH7gt5uQ+f9z+Hpnmpr74care2XiFvts8L39zLJHaRz4iuB
x5Zb+7g5yO/GaKKALFz4Z8R21trljaWNvcx63BEnnNc7Ps7CMI24Y+YcZGKhuvAOvLLrVxp94kM8
9rFawqz5iuoxDscOv8Jzyp7UUUAEngfXntb2NPKXzLTTo/LM5C3HkqRJExHIB6Z71cvPDuq3eh3G
l6X4dsdDW+ljS5ZbgEGIZ3ZCjvwvHOCaKKAKUngLVJNAOk3VlYXDWl9E9lOGzi237niy3IC8jB6g
1f1zwVqN1qOp/wBkCGytZtOhggCPsBKyFmjIXlQw4yPWiigCjdeC9WvItRax0a00SKbTXtfscVwG
FzISMM2BgBcHB6nNOPgTW4r+3iaf7bpkOmT28SNPsmiaRVzHv7rkcHt0NFFAGh4TttU8LFLC806I
RX10IrcoYxKiLGSWlK4VumOOfWqN74E1TUNSkMjGCCTXZL0Swz7ZEjMIVWHuGHSiigCI+CvE8kN+
181rfvJqcdzJCJDEl/EsezDY+6ehweMius0G2udOjEcPhu20yKecmSOG4U7F2/fIAwSSMYH1oooA
/9k=

--_004_BN3PR0701MB16888D7C159EED2A635A647AA2330BN3PR0701MB1688_--

--===============6712559013365440572==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============6712559013365440572==--
