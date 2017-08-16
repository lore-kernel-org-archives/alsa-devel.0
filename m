From: Krzysztof Kozlowski <krzk@kernel.org>
Subject: Re: [PATCH 6/7] ASoC: samsung: make snd_soc_ops const
Date: Wed, 16 Aug 2017 21:22:32 +0200
Message-ID: <20170816192232.5g7armlu5xpxwz62@kozik-lap>
References: <1502902770-3758-1-git-send-email-bhumirks@gmail.com>
 <1502902770-3758-7-git-send-email-bhumirks@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1502902770-3758-7-git-send-email-bhumirks@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Bhumika Goyal <bhumirks@gmail.com>
Cc: julia.lawall@lip6.fr, lgirdwood@gmail.com, broonie@kernel.org, perex@perex.cz, tiwai@suse.com, daniel@zonque.org, haojian.zhuang@gmail.com, robert.jarzmik@free.fr, heiko@sntech.de, sbkim73@samsung.com, s.nawrocki@samsung.com, alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-rockchip@lists.infradead.org
List-Id: alsa-devel@alsa-project.org

On Wed, Aug 16, 2017 at 10:29:29PM +0530, Bhumika Goyal wrote:
> Make these const as they are only stored in the ops field of a
> snd_soc_dai_link structure, which is const.
> Done using Coccinelle.
> 
> Signed-off-by: Bhumika Goyal <bhumirks@gmail.com>
> ---
>  sound/soc/samsung/jive_wm8750.c     | 2 +-
>  sound/soc/samsung/s3c24xx_simtec.c  | 2 +-
>  sound/soc/samsung/s3c24xx_uda134x.c | 2 +-
>  sound/soc/samsung/smdk_spdif.c      | 2 +-
>  4 files changed, 4 insertions(+), 4 deletions(-)
> 

Reviewed-by: Krzysztof Kozlowski <krzk@kernel.org>

Best regards,
Krzysztof
