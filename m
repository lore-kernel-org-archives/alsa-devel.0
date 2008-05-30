From: Juergen Beisert <jbe@pengutronix.de>
Subject: Re: Digital Audio Multiplexer of the i.MX27 processor
Date: Fri, 30 May 2008 11:17:12 +0200
Message-ID: <200805301117.13847.jbe@pengutronix.de>
References: <200805271713.49868.jbe@pengutronix.de>
	<24a2bfdf0805300157w5483557fi7d0106f52face5c7@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from metis.extern.pengutronix.de (metis.extern.pengutronix.de
	[83.236.181.26]) by alsa0.perex.cz (Postfix) with ESMTP id 25E9424407
	for <alsa-devel@alsa-project.org>;
	Fri, 30 May 2008 11:17:20 +0200 (CEST)
In-Reply-To: <24a2bfdf0805300157w5483557fi7d0106f52face5c7@mail.gmail.com>
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
Cc: Aditya Shankar <mc.aditya@gmail.com>
List-Id: alsa-devel@alsa-project.org

Aditya,

On Friday 30 May 2008 10:57, Aditya Shankar wrote:
> On Tue, May 27, 2008 at 5:13 PM, Juergen Beisert <jbe@pengutronix.de> wro=
te:
> > Hi,
> >
> > does anybody understand the DAM unit in the i.MX27 processor?
> > This routing device drivers me crazy, as I do not understand how to rou=
te
> > clocks, syncs and the data signals of my internal i2s unit to the
> > processor's
> > pins.
>
>  The DAM in the Freescale chip has 3 internal ports and 3 external ports.

Are you sure? It seems the DAM unit in the i.MX27 has two on chip ports and =

four external ports.

This I found yet (comparing mx27ads sources with mx27ads schematics):

  SSI     DAM       ext. pins
---------------------------------------
 SSI1    port_1
 SSI2    port_2
         port_3        ???
         port_4   SSI1_* pin group  <-- connected to PMIC on my board
         port_5   SSI2_* pin group
         port_6        ???

There are still the SSI3_* and SSI4_* pin groups, where I'm not sure about =

their connection to DAM unit's ports.

> > All I can see is, when I enable the internal SSI unit in i2s mode, the
> > DMA unit transfers some data into it, but the SSI unit does not shift it
> > out. So
> > everything stops, the DMA timeouts and I cannot hear anything. I can see
> > the
> > external device generates clock and frame signals, but it seems they do
> > not reach the internal SSI unit.
>
>  When you configure the SSI in a slave mode, the PMIC
> ( or your external device)will drive the FS and the clock
>  required.

SSI1 is configured as a slave, FS and clocks are inputs. Routing through th=
e =

DAM unit seems to work now, as the SSI unit shifts out the data I'm writing =

into its FIFO.

> You say that the clock and frame sync from the ext. device is generated.
>  SO can you check if the SSI is interrupting the DMA.

This is currently my problem. The DMA does not work. If I enable the DMA it =

seems to write something into the SSI FIFO. I can check it by reading the =

FIFO counter. But at this point of time SSI1's dma_req is still disabled =

(TDMAE is 0 in register SIER)! When I enable TDMAE after enabling the DMA =

channel, next the DMA unit outputs an error: Error while transfer (DSESR bi=
t =

of the used channel goes 1).  When I transfer the sound data in software it =

works. I'm confused.

Juergen

-- =

Dipl.-Ing. Juergen Beisert | http://www.pengutronix.de
=A0Pengutronix - Linux Solutions for Science and Industry
=A0   Handelsregister: Amtsgericht Hildesheim, HRA 2686
=A0 =A0 =A0    Vertretung Sued/Muenchen, Germany
   Phone: +49-8766-939 228 |  Fax: +49-5121-206917-9
