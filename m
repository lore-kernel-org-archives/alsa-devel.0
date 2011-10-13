From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH 1/3] ASoC: alc5623: Convert codec->hw_read
 to regmap_read
Date: Fri, 14 Oct 2011 00:34:14 +0100
Message-ID: <20111013233414.GB21690@sirena.org.uk>
References: <1318490575.2857.8.camel@phoenix>
	<20111013165129.GO5193@opensource.wolfsonmicro.com>
	<CAF+7xWkVLNgToGiEn+xqgnii7QozNu0QAf2U-kXRNRtVK0dkqA@mail.gmail.com>
	<20111013225237.GA2952@opensource.wolfsonmicro.com>
	<CAF+7xWm-X6ydYVp5j+HzMZaFkja+2cEMC2BnXRBoNJTqj=x7OA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
	by alsa0.perex.cz (Postfix) with ESMTP id 5DE6324364
	for <alsa-devel@alsa-project.org>;
	Fri, 14 Oct 2011 01:34:16 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <CAF+7xWm-X6ydYVp5j+HzMZaFkja+2cEMC2BnXRBoNJTqj=x7OA@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Axel Lin <axel.lin@gmail.com>
Cc: alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org, Arnaud Patard <arnaud.patard@rtp-net.org>, Liam Girdwood <lrg@ti.com>
List-Id: alsa-devel@alsa-project.org

On Fri, Oct 14, 2011 at 07:29:33AM +0800, Axel Lin wrote:

> I check the regmap code, it seems cache_bypsss is only set
> if map->cache_type == REGCACHE_NONE or by regcache_cache_bypass().

That's in regmap.  Any ASoC drivers which haven't been converted to
directly use regmap will still use the ASoC copy of the cache code.

> +       regcache_cache_bypass(codec->control_data, true);
> +       for (i = 0 ; i < codec->driver->reg_cache_size ; i += step) {
> +               regmap_read(codec->control_data, i, &val);
> +               cache[i] = val;
> +       }
> +       regcache_cache_bypass(codec->control_data, false);

This is what a driver which uses regmap directly should do.
