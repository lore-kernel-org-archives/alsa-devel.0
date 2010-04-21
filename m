From: Timur Tabi <timur@freescale.com>
Subject: Re: ASoC - Support for multiple components
Date: Wed, 21 Apr 2010 17:13:00 -0500
Message-ID: <p2ned82fe3e1004211513zffc1ae64k7e12daf4a3cac648@mail.gmail.com>
References: <1271686144.3208.305.camel@odin>
	<k2ved82fe3e1004211407qae60e223of729dff1b6e34d83@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-pw0-f51.google.com (mail-pw0-f51.google.com
	[209.85.160.51]) by alsa0.perex.cz (Postfix) with ESMTP id 1F8F02465C
	for <alsa-devel@alsa-project.org>;
	Thu, 22 Apr 2010 00:13:31 +0200 (CEST)
Received: by pwj8 with SMTP id 8so4936162pwj.38
	for <alsa-devel@alsa-project.org>; Wed, 21 Apr 2010 15:13:30 -0700 (PDT)
In-Reply-To: <k2ved82fe3e1004211407qae60e223of729dff1b6e34d83@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Liam Girdwood <lrg@slimlogic.co.uk>
Cc: vbarinov <vbarinov@embeddedalley.com>, alsa-devel <alsa-devel@alsa-project.org>, Joonyoung Shim <jy0922.shim@samsung.com>, mano@roarinelk.homelinux.net, Mark Brown <broonie@opensource.wolfsonmicro.com>, Cliff Cai <cliff.cai@analog.com>, Haojian Zhuang <haojian.zhuang@gmail.com>, dg@emlix.com, Grant Likely <grant.likely@secretlab.ca>, Sedji Gaouaou <sedji.gaouaou@atmel.com>, "kyungmin.park" <kyungmin.park@samsung.com>, "Candelaria Villareal, Jorge" <jorge.candelaria@ti.com>, ben-linux <ben-linux@fluff.org>, Kuninori Morimoto <morimoto.kuninori@renesas.com>, Sascha Hauer <s.hauer@pengutronix.de>, anemo@mba.ocn.ne.jp
List-Id: alsa-devel@alsa-project.org

On Wed, Apr 21, 2010 at 4:07 PM, Timur Tabi <timur@freescale.com> wrote:

> Cirrus Logic CS4270 ALSA SoC Codec Driver
> cs4270 0-004f: found device at i2c address 4F
> cs4270 0-004f: hardware revision 3
> cs4270 0-004f: codec register CS4270 79
> cs4270 0-004f: dai register cs4270 0
> Registered DAI 'cs4270.0'
> Registered codec 'CS4270.79'
> ...
>
> soc-audio soc-audio: CODEC CS4270 not registered
>
> Does this mean that my fabric driver should be looking for "CS4270.79"
> instead of just "CS4270"?

Ok, I figured out the solution.  I need to add this to mpc8610_hpcd_probe():

+       iprop = of_get_property(codec_np, "reg", NULL);
+       if (!iprop) {
+               dev_err(&ofdev->dev, "codec node is missing 'reg' property\n");
+               goto error;
+       }
+       machine_data->dai.codec_id = *iprop;

So I have another question.  Currently, I need to do this:

	machine_data->dai.codec_dai_drv = &cs4270_dai; /* The codec_dai we want */

In other words, I still need to have a global variable in my codec
driver called "cs4270_dai" that the fabric driver has to access.  This
is a real problem because it means that my fabric driver has to be
hard-coded with the information on the codec that's attached to the
SSI.  However, I already have that information in the device tree, I
can extract all the information I need from the device tree.  If I can
get rid of the assignment of "cs4270_dai", I can make my machine
driver completely codec-independent.

-- 
Timur Tabi
Linux kernel developer at Freescale
