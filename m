From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [RFC 0/5] ASoC multi-component support : core
Date: Fri, 25 Jun 2010 00:12:31 +0100
Message-ID: <661928F7-0509-4E84-A296-0949E2D76EE3@opensource.wolfsonmicro.com>
References: <1277407467.3100.579.camel@odin>
	<4C23CFC0.6080700@bluewatersys.com>
	(sfid-20100624_223607_408551_609C17DE)
Mime-Version: 1.0 (Apple Message framework v1081)
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 2F0992447D
	for <alsa-devel@alsa-project.org>;
	Fri, 25 Jun 2010 01:12:34 +0200 (CEST)
In-Reply-To: <4C23CFC0.6080700@bluewatersys.com>
	(sfid-20100624_223607_408551_609C17DE)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Ryan Mallon <ryan@bluewatersys.com>
Cc: vbarinov <vbarinov@embeddedalley.com>, alsa-devel <alsa-devel@alsa-project.org>, Lars-Peter Clausen <lars@metafoo.de>, Wan ZongShun <mcuos.com@gmail.com>, Sascha Hauer <s.hauer@pengutronix.de>, jassisinghbrar <jassisinghbrar@gmail.com>, Peter Ujfalusi <peter.ujfalusi@nokia.com>, Cliff Cai <cliff.cai@analog.com>, Haojian Zhuang <haojian.zhuang@gmail.com>, Sedji Gaouaou <sedji.gaouaou@atmel.com>, "timur.tabi@gmail.com" <timur.tabi@gmail.com>, "Candelaria Villareal, Jorge" <jorge.candelaria@ti.com>, "vaibhav.bedia" <vaibhav.bedia@ti.com>, Kuninori Morimoto <morimoto.kuninori@renesas.com>, Liam Girdwood <lrg@slimlogic.co.uk>
List-Id: alsa-devel@alsa-project.org

On 24 Jun 2010, at 22:36, Ryan Mallon wrote:

> The following patch fixes the build errors and warnings for the
> ep93xx/Snapper CL15. However, I still get 'No soundcards found' during

Please provide a proper changelog for patches.

> boot. The ep3xx-pcm-audio, ep93xx-i2s and soc-audio devices are all
> present under /sys/bus/platform/devices. Any ideas?


Do you actually see sound cards appearing? The log message at boot
is purely informational, cards can probe at any time.

Define DEBUG at the top of soc-audio.c if the card never appears at all
then look at the log messages - they will say why the card is not being
instantiated.
