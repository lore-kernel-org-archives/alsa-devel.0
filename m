From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH] ASoC: pxa: remove incorrect do_div() call
Date: Mon, 23 Nov 2015 09:54:22 +0100
Message-ID: <4678926.Vc1QsAaFQ0@wuerfel>
References: <7580645.enu4DmUPIv@wuerfel> <5652CA09.5080101@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mout.kundenserver.de (mout.kundenserver.de [217.72.192.75])
 by alsa0.perex.cz (Postfix) with ESMTP id B8B5A2651CB
 for <alsa-devel@alsa-project.org>; Mon, 23 Nov 2015 09:54:32 +0100 (CET)
In-Reply-To: <5652CA09.5080101@linaro.org>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: zhangfei <zhangfei.gao@linaro.org>
Cc: alsa-devel@alsa-project.org, Leo Yan <leoy@marvell.com>, Liam Girdwood <lgirdwood@gmail.com>, Haojian Zhuang <haojian.zhuang@gmail.com>, linux-kernel@vger.kernel.org, broonie@kernel.org, linux-arm-kernel@lists.infradead.org, Robert Jarzmik <robert.jarzmik@free.fr>, Daniel Mack <daniel@zonque.org>
List-Id: alsa-devel@alsa-project.org

On Monday 23 November 2015 16:10:49 zhangfei wrote:
> On 11/20/2015 05:32 PM, Arnd Bergmann wrote:
> > diff --git a/sound/soc/pxa/brownstone.c b/sound/soc/pxa/brownstone.c
> > index 6147e86e9b0f..416ea646c3b1 100644
> > --- a/sound/soc/pxa/brownstone.c
> > +++ b/sound/soc/pxa/brownstone.c
> > @@ -63,8 +63,7 @@ static int brownstone_wm8994_hw_params(struct snd_pcm_substream *substream,
> >               sysclk    = params_rate(params) * 512;
> >               sspa_mclk = params_rate(params) * 64;
> >       }
> > -     sspa_div = freq_out;
> > -     do_div(sspa_div, sspa_mclk);
> > +     sspa_div = freq_out / sspa_mclk;
> >
> >       snd_soc_dai_set_sysclk(cpu_dai, MMP_SSPA_CLK_AUDIO, freq_out, 0);
> >       snd_soc_dai_set_pll(cpu_dai, MMP_SYSCLK, 0, freq_out, sysclk);
> >
> 
> Thanks Arnd.
> 
> Looks sspa_div is not used at all.
> So we can remove sspa_div as well as do_div.
> 
> What do you think.

Good idea. I see that Mark has already applied the original patch, and with
my new version, gcc should be smart enough to completely optimize out the
division and the unused variable. This means the effect of the patch
is very small, but if Mark wants it, he can apply the below.

	Arnd

8<---
Subject: ASoC: remove unused variable

As pointed out by Zhangfei Gao, the sspa_div variable in
brownstone_wm8994_hw_params() is completely unused, so as a cleanup
following a prior patch, this removes both the variable and the division.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>

diff --git a/sound/soc/pxa/brownstone.c b/sound/soc/pxa/brownstone.c
index 416ea646c3b1..ec522e94b0e2 100644
--- a/sound/soc/pxa/brownstone.c
+++ b/sound/soc/pxa/brownstone.c
@@ -52,7 +52,6 @@ static int brownstone_wm8994_hw_params(struct snd_pcm_substream *substream,
 	struct snd_soc_dai *codec_dai = rtd->codec_dai;
 	struct snd_soc_dai *cpu_dai = rtd->cpu_dai;
 	int freq_out, sspa_mclk, sysclk;
-	int sspa_div;
 
 	if (params_rate(params) > 11025) {
 		freq_out  = params_rate(params) * 512;
@@ -63,7 +62,6 @@ static int brownstone_wm8994_hw_params(struct snd_pcm_substream *substream,
 		sysclk    = params_rate(params) * 512;
 		sspa_mclk = params_rate(params) * 64;
 	}
-	sspa_div = freq_out / sspa_mclk;
 
 	snd_soc_dai_set_sysclk(cpu_dai, MMP_SSPA_CLK_AUDIO, freq_out, 0);
 	snd_soc_dai_set_pll(cpu_dai, MMP_SYSCLK, 0, freq_out, sysclk);
