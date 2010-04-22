From: Liam Girdwood <lrg@slimlogic.co.uk>
Subject: Re: ASoC - Support for multiple components
Date: Thu, 22 Apr 2010 12:27:53 +0100
Message-ID: <1271935673.3228.335.camel@odin>
References: <1271686144.3208.305.camel@odin>
	<k2ved82fe3e1004211407qae60e223of729dff1b6e34d83@mail.gmail.com>
	<p2ned82fe3e1004211513zffc1ae64k7e12daf4a3cac648@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-wy0-f179.google.com (mail-wy0-f179.google.com
	[74.125.82.179])
	by alsa0.perex.cz (Postfix) with ESMTP id 4686710388C
	for <alsa-devel@alsa-project.org>;
	Thu, 22 Apr 2010 13:28:00 +0200 (CEST)
Received: by wyb36 with SMTP id 36so570119wyb.38
	for <alsa-devel@alsa-project.org>; Thu, 22 Apr 2010 04:27:58 -0700 (PDT)
In-Reply-To: <p2ned82fe3e1004211513zffc1ae64k7e12daf4a3cac648@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Timur Tabi <timur@freescale.com>
Cc: vbarinov <vbarinov@embeddedalley.com>, alsa-devel <alsa-devel@alsa-project.org>, Joonyoung Shim <jy0922.shim@samsung.com>, mano@roarinelk.homelinux.net, Mark Brown <broonie@opensource.wolfsonmicro.com>, Cliff Cai <cliff.cai@analog.com>, Haojian Zhuang <haojian.zhuang@gmail.com>, dg@emlix.com, Grant Likely <grant.likely@secretlab.ca>, Sedji Gaouaou <sedji.gaouaou@atmel.com>, "kyungmin.park" <kyungmin.park@samsung.com>, "Candelaria Villareal, Jorge" <jorge.candelaria@ti.com>, ben-linux <ben-linux@fluff.org>, Kuninori Morimoto <morimoto.kuninori@renesas.com>, Sascha Hauer <s.hauer@pengutronix.de>, anemo@mba.ocn.ne.jp
List-Id: alsa-devel@alsa-project.org

On Wed, 2010-04-21 at 17:13 -0500, Timur Tabi wrote:
> On Wed, Apr 21, 2010 at 4:07 PM, Timur Tabi <timur@freescale.com> wrote:
> 
> > Cirrus Logic CS4270 ALSA SoC Codec Driver
> > cs4270 0-004f: found device at i2c address 4F
> > cs4270 0-004f: hardware revision 3
> > cs4270 0-004f: codec register CS4270 79
> > cs4270 0-004f: dai register cs4270 0
> > Registered DAI 'cs4270.0'
> > Registered codec 'CS4270.79'
> > ...
> >
> > soc-audio soc-audio: CODEC CS4270 not registered
> >
> > Does this mean that my fabric driver should be looking for "CS4270.79"
> > instead of just "CS4270"?
> 

I've appended a component ID to each instantiated ASoC component to
distinguish similar/same component types from each other. e.g. consider
a board with two CS4270 codecs.  The component ID used here is unique to
the device and is either the platform_device ID, I2C address or SPI chip
select. Although, it doesn't really matter what the ID source is as long
as it's unique to that device.

> Ok, I figured out the solution.  I need to add this to mpc8610_hpcd_probe():
> 
> +       iprop = of_get_property(codec_np, "reg", NULL);
> +       if (!iprop) {
> +               dev_err(&ofdev->dev, "codec node is missing 'reg' property\n");
> +               goto error;
> +       }
> +       machine_data->dai.codec_id = *iprop;
> 

Applied.

> So I have another question.  Currently, I need to do this:
> 
> 	machine_data->dai.codec_dai_drv = &cs4270_dai; /* The codec_dai we want */
> 
> In other words, I still need to have a global variable in my codec
> driver called "cs4270_dai" that the fabric driver has to access.  This
> is a real problem because it means that my fabric driver has to be
> hard-coded with the information on the codec that's attached to the
> SSI.  However, I already have that information in the device tree, I
> can extract all the information I need from the device tree.  If I can
> get rid of the assignment of "cs4270_dai", I can make my machine
> driver completely codec-independent.

The use of ID here is to deprecate the passing in of the 'driver' struct
so it can be removed in a subsequent patch. I'm trying to make the
changes as small as possible here, but let me see how much difference
changing this now will make to the current patch size. 

Liam

-- 
Freelance Developer, SlimLogic Ltd
ASoC and Voltage Regulator Maintainer.
http://www.slimlogic.co.uk
