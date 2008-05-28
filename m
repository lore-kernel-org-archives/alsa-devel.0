From: Juergen Beisert <jbe@pengutronix.de>
Subject: Re: Digital Audio Multiplexer of the i.MX27 processor
Date: Wed, 28 May 2008 10:42:53 +0200
Message-ID: <200805281042.54104.jbe@pengutronix.de>
References: <200805271713.49868.jbe@pengutronix.de>
	<483C9330.6040402@wurmsdobler.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from metis.extern.pengutronix.de (metis.extern.pengutronix.de
	[83.236.181.26])
	by alsa0.perex.cz (Postfix) with ESMTP id CDF3B103837
	for <alsa-devel@alsa-project.org>;
	Wed, 28 May 2008 10:43:01 +0200 (CEST)
In-Reply-To: <483C9330.6040402@wurmsdobler.org>
Content-Disposition: inline
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
Cc: Peter Wurmsdobler <peter@wurmsdobler.org>
List-Id: alsa-devel@alsa-project.org

Peter,

On Wednesday 28 May 2008 01:03, Peter Wurmsdobler wrote:
> > does anybody understand the DAM unit in the i.MX27 processor?
>
> Not that I really understand the AUDMUX unit, but the current Freescale
> BSP (19 Dec 2007) contains an audio/alsa driver which makes use of the
> AUDMUX, or DAM, in order to route audio streams to/from the mx27's SSI1
> and SSI2 to the PMIC's SSIs. PMIC is a the power management and audio
> chip which is on the ADS board. Unfortunately I do not have the file
> with me, it is called ./sound/arm/mxc-pmic-alsa.c I believe.
>
> I will be back in office next week, maybe we can have a chat then, if it
> is not too late.

Yes, I know this file. And I'm using the code from this file to setup my DA=
M =

hardware. But I'm not sure if I connect the right ports in the right way to =

each other. My external PMIC is connected to the processor's SSI1_* pins. A=
nd =

it provides i2s clock and frame signal. But the internal SSI unit does not =

send any data, so I believe it does not get these signals from the PMIC.

BTW: The last instruction in the DAM code in sound/arm/mxc-pmic-alsa.c is:
  writel(AUD_MUX_CONF, IO_ADDRESS(AUDMUX_BASE_ADDR) + 0x38);
but the last valid register in the DAM unit is at AUDMUX_BASE_ADDR + 0x1C..=
..

Juergen
-- =

Dipl.-Ing. Juergen Beisert | http://www.pengutronix.de
=A0Pengutronix - Linux Solutions for Science and Industry
=A0   Handelsregister: Amtsgericht Hildesheim, HRA 2686
=A0 =A0 =A0    Vertretung Sued/Muenchen, Germany
   Phone: +49-8766-939 228 |  Fax: +49-5121-206917-9
