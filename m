From: "Aditya Shankar" <mc.aditya@gmail.com>
Subject: Re: Digital Audio Multiplexer of the i.MX27 processor
Date: Fri, 30 May 2008 10:57:01 +0200
Message-ID: <24a2bfdf0805300157w5483557fi7d0106f52face5c7@mail.gmail.com>
References: <200805271713.49868.jbe@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from fk-out-0910.google.com (fk-out-0910.google.com [209.85.128.191])
	by alsa0.perex.cz (Postfix) with ESMTP id 3F3C1243F6
	for <alsa-devel@alsa-project.org>;
	Fri, 30 May 2008 10:57:02 +0200 (CEST)
Received: by fk-out-0910.google.com with SMTP id b27so118782fka.0
	for <alsa-devel@alsa-project.org>; Fri, 30 May 2008 01:57:01 -0700 (PDT)
In-Reply-To: <200805271713.49868.jbe@pengutronix.de>
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
To: Juergen Beisert <jbe@pengutronix.de>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Juergen,

On Tue, May 27, 2008 at 5:13 PM, Juergen Beisert <jbe@pengutronix.de> wrote:

> Hi,
>
> does anybody understand the DAM unit in the i.MX27 processor?
> This routing device drivers me crazy, as I do not understand how to route
> clocks, syncs and the data signals of my internal i2s unit to the
> processor's
> pins.


 The DAM in the Freescale chip has 3 internal ports and 3 external ports.
   The 3 internal ports connect to the on chip peripherals like the SSI. The
    external ports can be configured to connect to the off-chip codecs or
the PMIC
    The internal ports are wired to the SSI1 , SSI2 and the SAP while the
external ports
    can be configured via the IOMUX settings to connect to the PMIC or
another peripheral.



>
> All I can see is, when I enable the internal SSI unit in i2s mode, the DMA
> unit transfers some data into it, but the SSI unit does not shift it out.
> So
> everything stops, the DMA timeouts and I cannot hear anything. I can see
> the
> external device generates clock and frame signals, but it seems they do not
> reach the internal SSI unit.


 When you configure the SSI in a slave mode, the PMIC
( or your external device)will drive the FS and the clock
 required.  If you are using the file mxc-alsa-pmic.c ,
 then with SSI1 you will be mostly be connected Voice codec through
the DAM. Your configuration will
 be SSI1 -> DAM port 1 -> DAM port 4 -> Codec( ext device)
You say that the clock and frame sync from the ext. device is generated.
 SO can you check if the SSI is interrupting the DMA. If this does not
happen,
 your app can time out. Also if the DAM external port is not configured
properly
 to connect to your external device, your app would time out.
This DAM port config is done through a gpio configuration with the function
gpio_ssi_active()  in the file mx27_ads_gpio.c under arch/arm/mach-mx27
You can verify this as well.

Hope this helps.

Aditya


>
> Has anybody a working DAM configuration which uses the internal SSI#1 as an
> i2s slave, an external i2s device connected to the SSI#1 pin group of this
> processor which acts as a master (I did not find anything in the manual,
> how
> the relation between the internal so called port-1 to port-6 at the DAM
> unit
> and the 4 external SSI1...SSI4 pin groups are). Means the external i2s
> device
> generates the clock and frame signal and the internal SSI#1 unit in i2s
> mode
> should use it to send serial sound data to the external device.
>
> Juergen
> --
> Dipl.-Ing. Juergen Beisert | http://www.pengutronix.de
>  Pengutronix - Linux Solutions for Science and Industry
>     Handelsregister: Amtsgericht Hildesheim, HRA 2686
>          Vertretung Sued/Muenchen, Germany
>   Phone: +49-8766-939 228 |  Fax: +49-5121-206917-9
> _______________________________________________
> Alsa-devel mailing list
> Alsa-devel@alsa-project.org
> http://mailman.alsa-project.org/mailman/listinfo/alsa-devel
>
