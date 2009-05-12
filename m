From: Ernesto Torres <skullmate@gmail.com>
Subject: Output frequency configuration for I2S in beagleboard?
	(underrun problem)
Date: Tue, 12 May 2009 18:28:58 -0500
Message-ID: <fb44c3530905121628i56a92ea8x10f966b7aa4ebc00@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-bw0-f167.google.com (mail-bw0-f167.google.com
	[209.85.218.167])
	by alsa0.perex.cz (Postfix) with ESMTP id E30EF10387D
	for <alsa-devel@alsa-project.org>;
	Wed, 13 May 2009 01:28:58 +0200 (CEST)
Received: by bwz11 with SMTP id 11so315384bwz.32
	for <alsa-devel@alsa-project.org>; Tue, 12 May 2009 16:28:58 -0700 (PDT)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: alsa-devel <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

Hi,

I would like to know the actual configuration for the output of the Beagle
Board I2S, from the OMAP35x Reference Manual, on page 2887:

=95 Enable the Sample Rate Generator (take it out of reset).
  Set McBSPi.MCBSPLP_SPCR2_REG[6] GRSTbit to1 to enable the Sample Rate
Generator.
  After the Sample Rate Generator is enabled, wait for 2 CLKG cycles for the
Sample Rate Generator
  logic to stabilize.
*  On the next rising edge of CLKSRG, the CLKG signal transitions to '1' and
starts clocking with a
  frequency equal to (input clock frequency)/(CLKGDV + 1).*
=95 If necessary, enable the receiver and/or the transmitter.

It says the clocking will start with the frequency of input clock (I thougth
it is 26Mhz but i've been told is 96Khz, not quite sure) and CLKGDV is a
variable number to get a desired frequency.

from omap-mcbsp.c:

*static int omap_mcbsp_dai_set_clkdiv(struct snd_soc_dai *cpu_dai,
                     int div_id, int div)
{
    struct omap_mcbsp_data *mcbsp_data =3D to_mcbsp(cpu_dai->private_data);
    struct omap_mcbsp_reg_cfg *regs =3D &mcbsp_data->regs;
    dbg("omap_mcbsp_dai_set_clkdiv START");
    if (div_id !=3D OMAP_MCBSP_CLKGDV)
        return -ENODEV;
    dbg("div: %d",div);
    regs->srgr1    |=3D CLKGDV(div - 1);
                dbg("omap_mcbsp_dai_set_clkdiv END");
    return 0;
}*

Here, the value is asigned to srgr1. I capture all actions from startup and
from aplay but this function is never called. Do you know when it should be
called or where we can find the div value?

I'm having trouble adapting an external codec from the beagle, and I think
it may be because of the output frequency from the beagle. I'm getting some
underruns during playback(with aplay) and I don't know exactly where to
begin.  Suggestions are welcome.

Thanks for your help

Best regards,
Ernesto
