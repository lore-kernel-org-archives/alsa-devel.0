From: Sascha Hauer <s.hauer@pengutronix.de>
Subject: Re: imx-ssi.c & SND_SOC_DAIFMT_I2S
Date: Wed, 26 May 2010 12:37:53 +0200
Message-ID: <20100526103753.GQ17272@pengutronix.de>
References: <4BFCEB10.6000205@eukrea.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-15"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de
	[92.198.50.35]) by alsa0.perex.cz (Postfix) with ESMTP id DDD80103918
	for <alsa-devel@alsa-project.org>;
	Wed, 26 May 2010 12:37:54 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <4BFCEB10.6000205@eukrea.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Eric =?iso-8859-15?Q?B=E9nard?= <eric@eukrea.com>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Hi Eric,

On Wed, May 26, 2010 at 11:34:08AM +0200, Eric B=E9nard wrote:
> Hi Sascha,
>
> while trying to get a TI TLV320AIC23B codec configured as I2S master to  =

> work with an i.MX27 using the latest git kernel, I noticed there may be  =

> a problem in the slave I2S setting in imx-ssi.c
>
> Please find two captures of the I2S bus signals :
> - http://eukrea.com/tmp/initial_i2s.png : this is not an I2S signal,  =

> both left & right are sent while Frame Sync is high (so I only get mono  =

> output)
> - http://eukrea.com/tmp/i2s_slave.png : when I set I2S_MODE to 0x2 in  =

> SCR register (scr |=3D SSI_SCR_NET | 0x40; at line 101 of imx-ssi.c), thu=
s  =

> setting the SSI in "I2S slave mode", I get a real I2S signal as shown on  =

> this capture.
>
> I understand the actual I2S configuration may work with the Freescale's  =

> PMIC but this chipset may not be fully I2S compliant and I think that  =

> the actual setting prevent real I2S codecs from being used with the i.MX.
>
> Am I wrong here ?
> Shouldn't we use the I2S slave mode of the SSI instead of what is done  =

> actually ?

I just had a look at the oscilloscope. For me it seems to make no
difference whether I use I2S mode or what is done in current driver.
Both look like your second picture.
So we can change it if there are no other objections.

Sascha

-- =

Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
