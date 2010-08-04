From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH v4 1/1] ASoC: TI WL1273 FM Radio Codec.
Date: Wed, 4 Aug 2010 17:31:11 +0100
Message-ID: <20100804163111.GC32504@rakim.wolfsonmicro.main>
References: <1280914979-21235-1-git-send-email-matti.j.aaltonen@nokia.com>
	<1280914979-21235-2-git-send-email-matti.j.aaltonen@nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 772F524627
	for <alsa-devel@alsa-project.org>;
	Wed,  4 Aug 2010 18:31:13 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <1280914979-21235-2-git-send-email-matti.j.aaltonen@nokia.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: "Matti J. Aaltonen" <matti.j.aaltonen@nokia.com>
Cc: alsa-devel@alsa-project.org, peter.ujfalusi@nokia.com, lrg@slimlogic.co.uk
List-Id: alsa-devel@alsa-project.org

On Wed, Aug 04, 2010 at 12:42:59PM +0300, Matti J. Aaltonen wrote:
> This is an ALSA codec for the Texas Instruments WL1273 FM Radio.

This basically looks OK but...

> +/* codec private data */
> +struct wl1273_priv {
> +	struct snd_soc_codec codec;
> +	enum wl1273_mode mode;
> +	struct wl1273_core *core;
> +	unsigned int channels;
> +};

...why would anything outside the driver be peering into this?
