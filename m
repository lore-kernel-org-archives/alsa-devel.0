From: Peter Ujfalusi <peter.ujfalusi@ti.com>
Subject: Re: recording problem in beagleboard-mcbsp
Date: Tue, 14 Apr 2015 15:39:06 +0300
Message-ID: <552D0A6A.20800@ti.com>
References: <CAES_P+8NEcMfDSDVT5d0UHU4mo8d2-3rJg31zf5GRT0HaLVXYw@mail.gmail.com>	<CAES_P+-yk29wzBMhO3uYjr1fnXt8iyskr77QLc=AvwCuX=Najg@mail.gmail.com>	<CAES_P+-ufoqcY++WzvS42tyQLfd2zzuANNp2rPwuUk3x_Tn-jg@mail.gmail.com>	<551C3D19.2050200@ti.com>	<CAES_P+_zc1u=grsF4J3rH+uwamWTOrgQKYmcY-9p6b=W9-PxUA@mail.gmail.com>	<5523A1F3.2000701@ti.com>	<CAES_P+_nr4LvcU-WQ=ZuhNwCSRuUs=xenqKGpupYAgx01fnATg@mail.gmail.com>	<5524FA51.9060606@ti.com>	<CAES_P+8oJ0xDJ-2w02Q0pZmgQyY9tyaRB=+_PqMhTdwuYNRShw@mail.gmail.com>	<55266B38.6030503@ti.com>
 <CAES_P+-5vgq1LxSsUQLua4j06M4U8+ogLgnEK5KJ-4QPJs1vJQ@mail.gmail.com>
 <552BDD3E.5080607@ti.com> <552CE047.1030505@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from arroyo.ext.ti.com (arroyo.ext.ti.com [192.94.94.40])
 by alsa0.perex.cz (Postfix) with ESMTP id 9B84926054A
 for <alsa-devel@alsa-project.org>; Tue, 14 Apr 2015 14:39:09 +0200 (CEST)
In-Reply-To: <552CE047.1030505@ti.com>
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

On 04/14/2015 12:39 PM, Peter Ujfalusi wrote:
> OK, got another SD card.
> McBSP3 in master mode works (no codec connected) playback and capture as =
well.
> =

> The pins for McBSP3:
> OMAP3_CORE1_IOPAD(0x2172, PIN_OUTPUT | MUX_MODE0) /* mcbsp3_fsx.mcbsp3_fs=
x */
> OMAP3_CORE1_IOPAD(0x2178, PIN_OUTPUT | MUX_MODE1) /* uart2_tx.mcbsp3_clkx=
 */
> OMAP3_CORE1_IOPAD(0x2174, PIN_OUTPUT | MUX_MODE1) /* uart2_cts.mcbsp3_dx =
*/
> OMAP3_CORE1_IOPAD(0x2176, PIN_INPUT | MUX_MODE1)  /* uart2_rts.mcbsp3_dr =
*/
> =

> I still not sure why McBSP1 is not working..

This pinctrl setting is not correct for McBSP3. I was changing the registers
on the fly, that's why it was working when I replied.

In McBSP3 master mode, you need:
OMAP3_CORE1_IOPAD(0x2172, PIN_INPUT | MUX_MODE0) /* mcbsp3_fsx.mcbsp3_fsx */
OMAP3_CORE1_IOPAD(0x2178, PIN_INPUT | MUX_MODE1) /* uart2_tx.mcbsp3_clkx */
OMAP3_CORE1_IOPAD(0x2174, PIN_OUTPUT | MUX_MODE1) /* uart2_cts.mcbsp3_dx */
OMAP3_CORE1_IOPAD(0x2176, PIN_INPUT | MUX_MODE1)  /* uart2_rts.mcbsp3_dr */

Which would work in McBSP3 slave mode as well.
Playback, capture works (McBSP3 master). I have connected DX to DR and
captured whatever I was playing. Came back fine.

As for McBSP1 I think this should get it working:
OMAP3_CORE1_IOPAD(0x2196, PIN_INPUT | MUX_MODE0) /* mcbsp1_fsx.mcbsp1_fsx */
OMAP3_CORE1_IOPAD(0x218e, PIN_INPUT | MUX_MODE0) /* mcbsp1_fsr.mcbsp1_fsr */
OMAP3_CORE1_IOPAD(0x2198, PIN_INPUT | MUX_MODE0) /* mcbsp1_clkx.mcbsp1_clkx=
 */
OMAP3_CORE1_IOPAD(0x218c, PIN_INPUT | MUX_MODE0) /* mcbsp1_clkr.mcbsp1_clkr=
 */
OMAP3_CORE1_IOPAD(0x2190, PIN_OUTPUT | MUX_MODE0) /* mcbsp1_dx.mcbsp1_dx */
OMAP3_CORE1_IOPAD(0x2192, PIN_INPUT | MUX_MODE0)  /* mcbsp1_dr.mcbsp1_dr */

If McBSP1 is slave, then connect the FS to both FSX and FSR and do the same
for CLK.

-- =

P=E9ter
