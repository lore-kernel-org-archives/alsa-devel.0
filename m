From: Peter Ujfalusi <peter.ujfalusi@ti.com>
Subject: Re: recording problem in beagleboard-mcbsp
Date: Tue, 14 Apr 2015 12:39:19 +0300
Message-ID: <552CE047.1030505@ti.com>
References: <CAES_P+8NEcMfDSDVT5d0UHU4mo8d2-3rJg31zf5GRT0HaLVXYw@mail.gmail.com>	<CAES_P+-yk29wzBMhO3uYjr1fnXt8iyskr77QLc=AvwCuX=Najg@mail.gmail.com>	<CAES_P+-ufoqcY++WzvS42tyQLfd2zzuANNp2rPwuUk3x_Tn-jg@mail.gmail.com>	<551C3D19.2050200@ti.com>	<CAES_P+_zc1u=grsF4J3rH+uwamWTOrgQKYmcY-9p6b=W9-PxUA@mail.gmail.com>	<5523A1F3.2000701@ti.com>	<CAES_P+_nr4LvcU-WQ=ZuhNwCSRuUs=xenqKGpupYAgx01fnATg@mail.gmail.com>	<5524FA51.9060606@ti.com>	<CAES_P+8oJ0xDJ-2w02Q0pZmgQyY9tyaRB=+_PqMhTdwuYNRShw@mail.gmail.com>	<55266B38.6030503@ti.com>
 <CAES_P+-5vgq1LxSsUQLua4j06M4U8+ogLgnEK5KJ-4QPJs1vJQ@mail.gmail.com>
 <552BDD3E.5080607@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from arroyo.ext.ti.com (arroyo.ext.ti.com [192.94.94.40])
 by alsa0.perex.cz (Postfix) with ESMTP id 764CF260540
 for <alsa-devel@alsa-project.org>; Tue, 14 Apr 2015 11:39:24 +0200 (CEST)
In-Reply-To: <552BDD3E.5080607@ti.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: noman pouigt <variksla@gmail.com>
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, "broonie@kernel.org" <broonie@kernel.org>
List-Id: alsa-devel@alsa-project.org

On 04/13/2015 06:14 PM, Peter Ujfalusi wrote:
> On 04/10/2015 02:02 AM, noman pouigt wrote:
>>> Or to switch to use McBSP3.
>>
>> tried this as well but even playback didn't work.
>> +       mcbsp3_pins: pinmux_mcbsp3_pins {
>> +                pinctrl-single,pins =3D <
>> +                        OMAP3_CORE1_IOPAD(0x216C, PIN_OUTPUT | MUX_MODE=
1)
>> +                        OMAP3_CORE1_IOPAD(0x216E, PIN_INPUT | MUX_MODE1)
>> +                        OMAP3_CORE1_IOPAD(0x2170, PIN_OUTPUT | MUX_MODE=
1)
>> +                        OMAP3_CORE1_IOPAD(0x2172, PIN_OUTPUT | MUX_MODE=
0)
>> +                >;
>> +        };
> =

> Should be:
> mcbsp3_pins: pinmux_mcbsp3_pins {
> 	pinctrl-single,pins =3D <
> 		OMAP3_CORE1_IOPAD(0x2172, PIN_INPUT | MUX_MODE0) /* FSX */
> 		OMAP3_CORE1_IOPAD(0x2178, PIN_INPUT | MUX_MODE1) /* CLKX */
> 		OMAP3_CORE1_IOPAD(0x2174, PIN_OUTPUT | MUX_MODE1) /* DX */
> 		OMAP3_CORE1_IOPAD(0x2176, PIN_INPUT | MUX_MODE1) /* DR */
> 	>;
> };

> =

> Based on the schematics.
> =

> But for some reason I did not got capture working with this for the first=
 try.
> Then my MicroSD card decided that it is now in Write Protected mode and c=
an
> not recover it, no matter how I try (MicroSD does not have physical switc=
h).
> =

> Have you tried to attach the codec to McBSP2? There is a P18 on the backs=
ide
> of the xM (near to the MicroSD slot, 4 pin square c onnector) with
> FSX/CLKX/DR/DX of McBSP2. You will need smaller pins to connect the line =
to
> this header
> =

> The strange thing is that McBSP2 and 3 are mostly identical (they only ha=
ve
> different FIFO size) and McBSP3 is used in N9 to connect with twl5030 cod=
ec
> while the McBSP2 is used with tlv320dac33. I know they work(ed) since I w=
rote
> the audio support for the phone back in the days.
> =

> I need to find a spare MicrSD card now to boot the board, which I do not =
have ATM.
> =

> In any ways right now I have no idea why McBSP1 is not working as it shou=
ld,
> it is odd never the less.


OK, got another SD card.
McBSP3 in master mode works (no codec connected) playback and capture as we=
ll.

The pins for McBSP3:
OMAP3_CORE1_IOPAD(0x2172, PIN_OUTPUT | MUX_MODE0) /* mcbsp3_fsx.mcbsp3_fsx =
*/
OMAP3_CORE1_IOPAD(0x2178, PIN_OUTPUT | MUX_MODE1) /* uart2_tx.mcbsp3_clkx */
OMAP3_CORE1_IOPAD(0x2174, PIN_OUTPUT | MUX_MODE1) /* uart2_cts.mcbsp3_dx */
OMAP3_CORE1_IOPAD(0x2176, PIN_INPUT | MUX_MODE1)  /* uart2_rts.mcbsp3_dr */

I still not sure why McBSP1 is not working..

-- =

P=E9ter
