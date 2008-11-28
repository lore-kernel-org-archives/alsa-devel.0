From: Juergen Beisert <jbe@pengutronix.de>
Subject: Re: (SoC) Does i.MX27's SSI work as I2S clock master?
Date: Fri, 28 Nov 2008 15:45:09 +0100
Message-ID: <200811281545.10208.jbe@pengutronix.de>
References: <D66C4C05-340D-4A6E-98FC-7B36F4059C36@drvlabo.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de
	[92.198.50.35]) by alsa0.perex.cz (Postfix) with ESMTP id D936C246AB
	for <alsa-devel@alsa-project.org>; Fri, 28 Nov 2008 15:45:15 +0100 (CET)
In-Reply-To: <D66C4C05-340D-4A6E-98FC-7B36F4059C36@drvlabo.jp>
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
Cc: ngc@drvlabo.jp
List-Id: alsa-devel@alsa-project.org

On Dienstag, 25. November 2008, ngc@drvlabo.jp wrote:
> Now I'm porting WM8728 driver with i.MX27ADS, based on Freescale's BSP
> kernel(2.6.22) and refering to ALSA SoC git repository.
>
> I'm connecting the WM8728 to the SSI2 controller via SSI-3 signal set.
> Then, my ADS board has altered:
>   i.MX27         WM8728
>   ---------------------
>   SSI3_CLK       BCLKIN
>   SSI3_FS        LRCIN
>   SSI3_TXDAT     DIN
>   TOUT/SSI2_MCLK  MCLK
>
> Of course, I added some codes to configure GPIO pins as appropriate into
> board specific sources.
>
> Then, I'm trying to play sounds via WM8728 and
> have not hear any sounds yet.
> I checked SSI-3 signal set with an oscilloscope,
> no clock signal appears on SSI3_CLK.
> I tried the various SSI setting, I2S normal, I2S master,
> asychronous/synchronous, normal mode/network mode, ...
> But, I can't see clock signal, yet.
>
>
> I want to know an example setting to act i.MX' SSI as I2S clock master.

Maybe the SPI-DAM-PIN mapping could help you:

SSI1_* pin group is port 4 at the DAM unit
SSI2_* pin group is port 5 at the DAM unit
SSI3_* pin group is port 6 at the DAM unit
SSI4_* pin group is port 3 at the DAM unit

I didn't find this info in the datasheet yet. 

Regards,
Juergen

-- 
 Dipl.-Ing. Juergen Beisert | http://www.pengutronix.de
 Pengutronix - Linux Solutions for Science and Industry
   Handelsregister:  Amtsgericht Hildesheim, HRA 2686
          Vertretung Sued/Muenchen, Germany
  Phone: +49-8766-939 228  | Fax: +49-5121-206917-5555
