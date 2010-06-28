From: Jarkko Nikula <jhnikula@gmail.com>
Subject: Re: [RFC 0/5] ASoC multi-component support : core
Date: Mon, 28 Jun 2010 10:16:21 +0300
Message-ID: <20100628101621.c811a1da.jhnikula@gmail.com>
References: <1277407467.3100.579.camel@odin>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-ww0-f51.google.com (mail-ww0-f51.google.com [74.125.82.51])
	by alsa0.perex.cz (Postfix) with ESMTP id ED83F1037EC
	for <alsa-devel@alsa-project.org>;
	Mon, 28 Jun 2010 09:15:24 +0200 (CEST)
Received: by wwb13 with SMTP id 13so1291189wwb.38
	for <alsa-devel@alsa-project.org>; Mon, 28 Jun 2010 00:15:23 -0700 (PDT)
In-Reply-To: <1277407467.3100.579.camel@odin>
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
Cc: vbarinov <vbarinov@embeddedalley.com>, alsa-devel <alsa-devel@alsa-project.org>, Mark Brown <broonie@opensource.wolfsonmicro.com>, Wan ZongShun <mcuos.com@gmail.com>, Sascha Hauer <s.hauer@pengutronix.de>, jassisinghbrar <jassisinghbrar@gmail.com>, Peter Ujfalusi <peter.ujfalusi@nokia.com>, Cliff Cai <cliff.cai@analog.com>, Zhuang <haojian.zhuang@gmail.com>, Sedji Gaouaou <sedji.gaouaou@atmel.com>, "timur.tabi@gmail.com" <timur.tabi@gmail.com>, Lars-Peter Clausen <lars@metafoo.de>, "Candelaria Villareal,  Jorge" <jorge.candelaria@ti.com>, "vaibhav.bedia" <vaibhav.bedia@ti.com>, Kuninori Morimoto <morimoto.kuninori@renesas.com>, Haojian@alsa-project.org, Ryan Mallon <ryan@bluewatersys.com>
List-Id: alsa-devel@alsa-project.org

On Thu, 24 Jun 2010 20:24:27 +0100
Liam Girdwood <lrg@slimlogic.co.uk> wrote:

> I've so far tested the new multi-component enumeration on the TI OMAP
> and Marvell PXA platforms with AC97, MFD and I2C based CODECs. I do
> however need ASoC platform maintainers to test on their systems (as I
> only have a subset of the hardware). Some ASOC platforms do need a
> little extra checking/fixups too :- 
> 
I wouldn't expect much problems from OMAPs. Beagle with TWL4030 works
out of box and I would expect other boards using TWL4030 to work as
well.

If some board doesn't work then fix is most probably just
adding .codec_id = I2C address of the codec (or -1) to snd_soc_dai_link
structure of that machine.


-- 
Jarkko
