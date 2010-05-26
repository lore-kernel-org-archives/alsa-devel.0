From: Stuart Longland <redhatter@gentoo.org>
Subject: Re: ASoC: Hooking a TI CODEC to a i.MX27 MCU
Date: Wed, 26 May 2010 23:21:36 +1000
Message-ID: <20100526132129.GA13644@www.longlandclan.yi.org>
References: <20100524074946.GC16346@www.longlandclan.yi.org>
	<1274698156.3064.93.camel@odin>
	<20100525004126.GA10968@www.longlandclan.yi.org>
	<20100525022646.GA18030@www.longlandclan.yi.org>
	<1274806007.4728.3.camel@gnutoo-desktop>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from helicon.mas.viperplatform.net.au
	(helicon.mas.viperplatform.net.au [202.147.75.21])
	by alsa0.perex.cz (Postfix) with ESMTP id 2212D103970
	for <alsa-devel@alsa-project.org>;
	Wed, 26 May 2010 15:21:43 +0200 (CEST)
Received: from eryx.mas.viperplatform.net.au ([172.16.5.11])
	by helicon.mas.viperplatform.net.au with esmtp (Exim 4.43)
	id 1OHGYF-0001qX-Bf
	for alsa-devel@alsa-project.org; Wed, 26 May 2010 23:21:39 +1000
Received: from mail by eryx.mas.viperplatform.net.au with spam-scanned (Exim
	4.43) id 1OHGYE-0000bP-VW
	for alsa-devel@alsa-project.org; Wed, 26 May 2010 23:21:39 +1000
Received: from [172.16.100.13] (helo=helicon.mas.viperplatform.net.au)
	by eryx.mas.viperplatform.net.au with esmtp (Exim 4.43)
	id 1OHGYE-0000bM-US
	for alsa-devel@alsa-project.org; Wed, 26 May 2010 23:21:38 +1000
Received: from [203.94.56.252] (helo=longlandclan.yi.org)
	by helicon.mas.viperplatform.net.au with esmtp (Exim 4.43)
	id 1OHGYD-0001pW-NC
	for alsa-devel@alsa-project.org; Wed, 26 May 2010 23:21:38 +1000
Content-Disposition: inline
In-Reply-To: <1274806007.4728.3.camel@gnutoo-desktop>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: gnutoo <GNUtoo@no-log.org>, Liam Girdwood <lrg@slimlogic.co.uk>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On Tue, May 25, 2010 at 06:46:47PM +0200, gnutoo wrote:
> On Tue, 2010-05-25 at 12:26 +1000, Stuart Longland wrote:
> > If there's any interest, I can format that as a patch and submit it...
> I'm very interested...
> I've an I.MX31 and a tlv320aic3x
> =

> I've tried to import your driver in our 2.6.30 tree
> ( http://gitorious.org/bug/bug-1x-linux-2-6-30/commits/bug1x-2.6.30 )
> and I have now the following issue:
> =

> # modprobe bugsound
> No device for DAI tlv320aic3x
> bug1x_soc_init: hello...
> bug1x_soc_init: bug1x_snd_device =3D c79240c0
> bug1x_soc_init: calling platform_set_drvdata( c79240c0, bf07b66c)
> bug1x_soc_init: calling platform_device_add(c79240c0)
> bug1x_soc_init: platform_device_add(c79240c0) =3D 0
> bug1x_soc_init =3D 0 (success)
> =

> I'll re-read the mails and try harder...
> Thanks a lot!!!!

Well, the "No device for DAI" message seems to be related to what's
registered for your board's I=B2C bus... e.g. I have in a file;
arch/arm/mach-mx2/mach-tx27.c (this isn't in tree yet; but I hope to
contribute it someday):

static struct i2c_board_info tx27_i2c0_devices[] __initdata =3D {
        {
                I2C_BOARD_INFO("24c16", 0x50),
                .platform_data =3D &tx27_eeprom,
                .type =3D "24c16",
        },
        {
                I2C_BOARD_INFO("tlv320aic3204", 0x18),
                .type =3D "tlv320aic3204",
        },
#if defined(CONFIG_RTC_DRV_DS1307) ||
defined(CONFIG_RTC_DRV_DS1307_MODULE)
        {
                I2C_BOARD_INFO("ds1339", 0x68/*DS1339_CHIP_ID*/),
                .type =3D "ds1339",
        },
#endif
};

That seems to help with getting the CODEC initialised and probed
correctly.  Likewise; similar is needed for the i.MX I=B2S bus, simply
having the driver in-kernel isn't enough:

in my board_init function:
        mxc_register_device(&imx_ssi_device0, &tx27_ssi_pdata[0]);
        /*mxc_register_device(&imx_ssi_device1, &tx27_ssi_pdata[1]);*/

Note the second one is commented out; I cannot seem to register both,
the second one always fails.  The tx27_ssi_pdata is straightforward:

static struct imx_ssi_platform_data tx27_ssi_pdata[] =3D {
        /* SSI1 */
        {
                .flags                  =3D 0,
        },
        /* SSI2 */
        {
                .flags                  =3D 0,
        },
};

I'm not sure if this is right; but it seems to work.  On this project,
my issue now is getting data out of the I=B2S bus.  The CODEC is
generating the bit clock and frame sync; I *think* I have AUDMUX set up
correctly -- HPCR1 is set to output receive data, frame sync & clock all
sourced from HPCR3; HPCR3 is set to receive data from HPCR1, and take
its frame sync & clock from the external port... I'll provide my debugfs
patch for audmux-v1.c and its output tomorrow.

At the moment, when I go to play audio; I see the CODEC being set up ...
but despite the clocks being present -- I see no audio data, and the DMA
transfer eventually times out with the message "playback write error
(DMA or IRQ trouble?)" after 10 seconds.  Would anyone know where I'd
look for that?  Is there something else needed in the configuration of
the SSI driver for this to work?

Thanks for the assistance thus far.
Regards,
-- =

Stuart Longland (aka Redhatter, VK4MSL)      .'''.
Gentoo Linux/MIPS Cobalt and Docs Developer  '.'` :
. . . . . . . . . . . . . . . . . . . . . .   .'.'
http://dev.gentoo.org/~redhatter             :.'

I haven't lost my mind...
  ...it's backed up on a tape somewhere.
