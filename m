From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [RFC 0/5] ASoC multi-component support : core
Date: Thu, 1 Jul 2010 20:35:58 +0100
Message-ID: <20100701193558.GF17698@sirena.org.uk>
References: <1277407467.3100.579.camel@odin>
	<20100628101621.c811a1da.jhnikula@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
	by alsa0.perex.cz (Postfix) with ESMTP id 2C18C24459
	for <alsa-devel@alsa-project.org>;
	Thu,  1 Jul 2010 21:36:16 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <20100628101621.c811a1da.jhnikula@gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Jarkko Nikula <jhnikula@gmail.com>
Cc: vbarinov <vbarinov@embeddedalley.com>, alsa-devel <alsa-devel@alsa-project.org>, Lars-Peter Clausen <lars@metafoo.de>, Wan ZongShun <mcuos.com@gmail.com>, Haojian@alsa-project.org, Sascha Hauer <s.hauer@pengutronix.de>, jassisinghbrar <jassisinghbrar@gmail.com>, Peter Ujfalusi <peter.ujfalusi@nokia.com>, Cliff Cai <cliff.cai@analog.com>, Zhuang <haojian.zhuang@gmail.com>, Sedji Gaouaou <sedji.gaouaou@atmel.com>, "timur.tabi@gmail.com" <timur.tabi@gmail.com>, "Candelaria Villareal, Jorge" <jorge.candelaria@ti.com>, "vaibhav.bedia" <vaibhav.bedia@ti.com>, Kuninori Morimoto <morimoto.kuninori@renesas.com>, Ryan Mallon <ryan@bluewatersys.com>, Liam Girdwood <lrg@slimlogic.co.uk>
List-Id: alsa-devel@alsa-project.org

On Mon, Jun 28, 2010 at 10:16:21AM +0300, Jarkko Nikula wrote:

> If some board doesn't work then fix is most probably just
> adding .codec_id = I2C address of the codec (or -1) to snd_soc_dai_link
> structure of that machine.

This issue appears to apply to the overwhelming majority of machine
drivers.  

I suspect that it'd be more straightforward to convert to using a dev_id
with NULL as the wildcard match - this allows us to cope with deduping
over multiple I2C buses, cope with non-numeric IDs and (more to the
point here) will mean that we don't need to go through all the machine
drivers initialising the codec_id.
