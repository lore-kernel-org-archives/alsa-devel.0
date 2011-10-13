From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH 1/3] ASoC: alc5623: Convert codec->hw_read to
 regmap_read
Date: Fri, 14 Oct 2011 00:32:50 +0100
Message-ID: <20111013233250.GA21690@sirena.org.uk>
References: <1318490575.2857.8.camel@phoenix>
 <20111013165129.GO5193@opensource.wolfsonmicro.com>
 <CAF+7xWkVLNgToGiEn+xqgnii7QozNu0QAf2U-kXRNRtVK0dkqA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <CAF+7xWkVLNgToGiEn+xqgnii7QozNu0QAf2U-kXRNRtVK0dkqA@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Axel Lin <axel.lin@gmail.com>
Cc: linux-kernel@vger.kernel.org, Arnaud Patard <arnaud.patard@rtp-net.org>, Liam Girdwood <lrg@ti.com>, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On Fri, Oct 14, 2011 at 06:39:43AM +0800, Axel Lin wrote:

> +       codec->cache_bypass = 1;
> +       for (i = 0 ; i < codec->driver->reg_cache_size ; i += step) {
> +               snd_soc_read(codec, i);
> +               cache[i] = val;
> +       }
> +       codec->cache_bypass = 0;

Oh, sorry - I misread this and this is what I'm expecting.
