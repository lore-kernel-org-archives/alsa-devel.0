From: Roberto Fichera <kernel@tekno-soft.it>
Subject: iMX6SX having SSI TXC from external and TXFS from
 internal, is it possible?
Date: Tue, 30 Aug 2016 10:56:26 +0200
Message-ID: <861643f9-d219-0b43-7033-45336e3cd27c@tekno-soft.it>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail.tekno-soft.it (li153-180.members.linode.com
 [109.74.206.180])
 by alsa0.perex.cz (Postfix) with ESMTP id 79C74266A17
 for <alsa-devel@alsa-project.org>; Tue, 30 Aug 2016 10:56:47 +0200 (CEST)
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
Cc: Markus Pargmann <mpa@pengutronix.de>, Fabio Estevam <fabio.estevam@freescale.com>, "shawn.guo@linaro.org" <shawn.guo@linaro.org>, "arnaud.mouiche@invoxia.com" <arnaud.mouiche@invoxia.com>
List-Id: alsa-devel@alsa-project.org

Hi,
 
I'm playing with a custom iMX6SX board having the SSI connected to a SLIC in TDM mode.
SSI has TXC (PCLK) coming from an external oscillator running at 2.048MHz while TXFS (FSYNC)
is set to be generated from internal or at least this is what I'm trying to do.

The SSI documentation is not really clear in case, so wondering to know if it is possible to generate
FSYNC with this particular configuration: SSI set in I2S normal mode, synchronous transfers, network mode,
TXC taken from external oscillator.

The relevant part reported in iMX6SXRM doc (62.8.4 SSI Clocking) is:
 
"In master and synchronous mode, the unused port SRCK is used as network clock (oversampling clock)
enabled by the SCR register bit 15, SYS_CLK_EN. This network clock is an oversampling clock of the frame
sync clock (STFS). In this mode, the word length (WL), Prescaler Range (PSR), Prescaler Modulus (PM) and
Frame rate (DC) selects the ratio of network clock to sampling clock STFS. In case of I2S mode, the network
clock (oversampling clock) can be made available on this port if the SYS_CLK_EN bit is set."
 
Accordingly with Figure 62-22 in the iMX6SX reference manual network clock on SRCK can be activated
only when both TXDIR and SYS_CLK_EN are set. But if TXDIR is set I cannot get STCK from external
oscillator because SSI is now generating it from internal. I've also changed the way how audmux is routing
FYSNC, internal port is SSI1 and external is SSI6
 
int audmux_config(unsigned int master, unsigned int slave)
{
unsigned int ptcr, pdcr;
 
ptcr = IMX_AUDMUX_V2_PTCR_SYN /* Synchronous mode */
        | IMX_AUDMUX_V2_PTCR_TCSEL(slave); /* transmit clock select from external port */
pdcr = IMX_AUDMUX_V2_PDCR_RXDSEL(slave);
audmux_v2_configure_port(master, ptcr, pdcr); /* configure internal port */
 
ptcr = IMX_AUDMUX_V2_PTCR_SYN
        | IMX_AUDMUX_V2_PTCR_TFSDIR /* Transmit Frame Sync from Internal */
        | IMX_AUDMUX_V2_PTCR_TFSEL(master); /* from master port */
pdcr = IMX_AUDMUX_V2_PDCR_RXDSEL(master);
audmux_v2_configure_port(slave, ptcr, pdcr); /* configure external port */
return 0;
}
 
and SSI1 is set as:
 
scr = CCSR_SSI_SCR_I2S_MODE_NORMAL |
         CCSR_SSI_SCR_SYN | /* Synchronous mode */
         CCSR_SSI_SCR_NET; /* Network mode to enable TDM */
 
stcr = CCSR_SSI_STCR_TXBIT0 | /* LSB Aligned */
           CCSR_SSI_STCR_TFDIR | /* Transmit Frame Direction Internal - generated internally */
           CCSR_SSI_STCR_TFEN0 | /* Enable TX FIFO0 */
           CCSR_SSI_STCR_TSCKP; /* Transmit Clock Polarity - Data Clocked out on falling edge */

Doesn't anyone know if it's possible to have this particular TDM configuration?

Thanks in advance,
Roberto Fichera.
