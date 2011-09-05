From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH 2/3] ASoC: Allow codecs to provide their
 own regmap configuration
Date: Mon, 5 Sep 2011 10:29:17 -0700
Message-ID: <20110905172916.GG3889@opensource.wolfsonmicro.com>
References: <1315228682-1097-1-git-send-email-lars@metafoo.de>
	<1315228682-1097-2-git-send-email-lars@metafoo.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id B7E3D24141
	for <alsa-devel@alsa-project.org>;
	Mon,  5 Sep 2011 19:29:21 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <1315228682-1097-2-git-send-email-lars@metafoo.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Lars-Peter Clausen <lars@metafoo.de>
Cc: Scott Jiang <scott.jiang.linux@gmail.com>, alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org, device-drivers-devel@blackfin.uclinux.org, uclinux-dist-devel@blackfin.uclinux.org, Liam Girdwood <lrg@ti.com>
List-Id: alsa-devel@alsa-project.org

On Mon, Sep 05, 2011 at 03:18:01PM +0200, Lars-Peter Clausen wrote:
> Currently a codec can either do the whole regmap initialization on its own or
> provide only the register and value bit size and let the core handle
> initialization. This patch allows a codec to provide a complete regmap
> configuration while still letting ASoC core handle the regmap initialization
> and setup.

I'd rather not do this, the only value is the copying of the word size
setup out of the regmap config is to allow us to use the ASoC cache code
but the idea is to push the cache down out of ASoC into the regmap code
so this function should just be a trivial indirection for the regmap
init which isn't useful.

> - * Register formats are frequently shared between many I2C and SPI
> - * devices.  In order to promote code reuse the ASoC core provides
> - * some standard implementations of CODEC read and write operations
> - * which can be set up using this function.
> - *
> - * The caller is responsible for allocating and initialising the
> - * actual cache.
> - *
> - * Note that at present this code cannot be used by CODECs with
> - * volatile registers.
> + * Legacy and convenience wrapper around snd_soc_codec_regmap_init
>   */

This is a useful but unrelated change.
