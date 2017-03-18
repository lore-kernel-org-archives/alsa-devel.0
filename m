From: Krzysztof Kozlowski <krzk@kernel.org>
Subject: Re: [PATCH] ASoC: samsung: constify snd_soc_ops
	structures
Date: Sat, 18 Mar 2017 17:34:40 +0200
Message-ID: <20170318153440.mujlcov2ikj4ckbc@kozik-lap>
References: <1489849299-11340-1-git-send-email-bhumirks@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-wr0-f195.google.com (mail-wr0-f195.google.com
 [209.85.128.195])
 by alsa0.perex.cz (Postfix) with ESMTP id 88B7F266AF1
 for <alsa-devel@alsa-project.org>; Sat, 18 Mar 2017 16:34:47 +0100 (CET)
Received: by mail-wr0-f195.google.com with SMTP id u108so12865197wrb.2
 for <alsa-devel@alsa-project.org>; Sat, 18 Mar 2017 08:34:47 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <1489849299-11340-1-git-send-email-bhumirks@gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Bhumika Goyal <bhumirks@gmail.com>
Cc: alsa-devel@alsa-project.org, sbkim73@samsung.com, linux-kernel@vger.kernel.org, tiwai@suse.com, lgirdwood@gmail.com, julia.lawall@lip6.fr, broonie@kernel.org, s.nawrocki@samsung.com
List-Id: alsa-devel@alsa-project.org

On Sat, Mar 18, 2017 at 08:31:39PM +0530, Bhumika Goyal wrote:
> Declare snd_soc_ops structures as const as they are only stored
> in the ops field of a snd_soc_dai_link structure. This field is
> of type const, so snd_soc_ops structures having this property
> can be made const too.
> 
> Cross compiled the files arndale_rt5631.o, h1940_uda1380.o, jive_wm8750.o,
> littlemill.o, neo1973_wm8753.o and rx1950_uda1380.o for arm architecture.
> 
> Signed-off-by: Bhumika Goyal <bhumirks@gmail.com>
> ---
>  sound/soc/samsung/arndale_rt5631.c  | 2 +-
>  sound/soc/samsung/h1940_uda1380.c   | 2 +-
>  sound/soc/samsung/jive_wm8750.c     | 2 +-
>  sound/soc/samsung/littlemill.c      | 2 +-
>  sound/soc/samsung/neo1973_wm8753.c  | 2 +-
>  sound/soc/samsung/rx1950_uda1380.c  | 2 +-
>  sound/soc/samsung/s3c24xx_simtec.c  | 2 +-
>  sound/soc/samsung/s3c24xx_uda134x.c | 2 +-
>  sound/soc/samsung/smartq_wm8987.c   | 2 +-
>  sound/soc/samsung/smdk_spdif.c      | 2 +-
>  sound/soc/samsung/smdk_wm8580.c     | 2 +-
>  sound/soc/samsung/smdk_wm8994.c     | 2 +-
>  sound/soc/samsung/smdk_wm8994pcm.c  | 2 +-
>  sound/soc/samsung/tm2_wm5110.c      | 2 +-
>  sound/soc/samsung/tobermory.c       | 2 +-
>  15 files changed, 15 insertions(+), 15 deletions(-)
> 

Reviewed-by: Krzysztof Kozlowski <krzk@kernel.org>

Best regards,
Krzysztof
