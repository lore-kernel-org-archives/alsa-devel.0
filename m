From: "Jin, Yao" <yao.jin@linux.intel.com>
Subject: Re: [PATCH] ASoC: Intel: Add suspend_pre and
 resume_post for Braswell snd_soc_card
Date: Thu, 12 Mar 2015 08:52:22 +0800
Message-ID: <5500E346.8020700@linux.intel.com>
References: <1426045713-1738-1-git-send-email-yao.jin@linux.intel.com>
 <20150311125047.GD28806@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
 by alsa0.perex.cz (Postfix) with ESMTP id 1416F265497
 for <alsa-devel@alsa-project.org>; Thu, 12 Mar 2015 01:52:26 +0100 (CET)
In-Reply-To: <20150311125047.GD28806@sirena.org.uk>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@kernel.org>
Cc: mengdong.lin@intel.com, alsa-devel@alsa-project.org, subhransu.s.prusty@intel.com, lgirdwood@gmail.com, bardliao@realtek.com
List-Id: alsa-devel@alsa-project.org

Hi Mark, Bard,

This patch has dependency on Bard's patch "ASoC: rt5670: export jack
suspend/resume APIs". I pull the Mark's for-next branch right now and I
can see Bard's patch "ASoC: rt5670: export jack suspend/resume APIs" has
been integrated.

So there now is only one build error in rt5670.c:

sound/soc/codecs/rt5670.c: In function 'is_sys_clk_from_pll':
sound/soc/codecs/rt5670.c:702:38: error: 'struct snd_soc_dapm_widget'
has no member named 'codec'
  struct snd_soc_codec *codec = source->codec;
                                      ^
After I fix it with my change as following, the build is successful.

--- a/sound/soc/codecs/rt5670.c
+++ b/sound/soc/codecs/rt5670.c
@@ -699,7 +699,7 @@ static int set_dmic_clk(struct snd_soc_dapm_widget *w,
 static int is_sys_clk_from_pll(struct snd_soc_dapm_widget *source,
                         struct snd_soc_dapm_widget *sink)
 {
-       struct snd_soc_codec *codec = source->codec;
+       struct snd_soc_codec *codec = snd_soc_dapm_to_codec(source->dapm);
        struct rt5670_priv *rt5670 = snd_soc_codec_get_drvdata(codec);

        if (rt5670->sysclk_src == RT5670_SCLK_S_PLL1)

Could Bard take a look at it?

For my patch, the build is successful.

ASoC: Intel: Add suspend_pre and resume_post for Braswell snd_soc_card
ASoC: Intel: move the jack creation to Braswell machine driver

Thanks
Jin Yao

On 2015/3/11 20:50, Mark Brown wrote:
> On Wed, Mar 11, 2015 at 11:48:33AM +0800, Jin Yao wrote:
>> On Braswell, we need to add some machine specific setting before suspend
>> and after resume. For example, disable/enable jack detection in codec so
>> use snd_soc_card suspend_pre and resume_post ops for this purpose.
> 
> Reverted since it doesn't build!
> 
