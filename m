From: kbuild test robot <lkp@intel.com>
Subject: Re: [PATCH 1/5] ASoC: add mt6351 codec driver
Date: Sun, 15 Apr 2018 03:37:23 +0800
Message-ID: <201804150152.6RDSYQWG%fengguang.wu@intel.com>
References: <20180413090242.4211-2-kaichieh.chuang@mediatek.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="zhXaljGHf11kAtnf"
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
 by alsa0.perex.cz (Postfix) with ESMTP id DA44426732C
 for <alsa-devel@alsa-project.org>; Sat, 14 Apr 2018 21:37:43 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <20180413090242.4211-2-kaichieh.chuang@mediatek.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
Cc: alsa-devel@alsa-project.org, wsd_upstream@mediatek.com, chipeng.chang@mediatek.com, garlic.tseng@mediatek.com, broonie@kernel.org, linux-mediatek@lists.infradead.org, kbuild-all@01.org, kaichieh.chuang@mediatek.com
List-Id: alsa-devel@alsa-project.org


--zhXaljGHf11kAtnf
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi KaiChieh,

Thank you for the patch! Perhaps something to improve:

[auto build test WARNING on asoc/for-next]
[also build test WARNING on v4.16 next-20180413]
[if your patch is applied to the wrong git tree, please drop us a note to help improve the system]

url:    https://github.com/0day-ci/linux/commits/KaiChieh-Chuang/ASoC-add-mt6351-codec-driver/20180414-110824
base:   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next
config: x86_64-randconfig-x016-201815 (attached as .config)
compiler: gcc-7 (Debian 7.3.0-1) 7.3.0
reproduce:
        # save the attached .config to linux build tree
        make ARCH=x86_64 

All warnings (new ones prefixed by >>):

   In file included from include/linux/string.h:6:0,
                    from include/linux/dma-mapping.h:6,
                    from sound/soc/codecs/mt6351.c:12:
   sound/soc/codecs/mt6351.c: In function 'mt_hp_event':
   include/linux/compiler.h:58:2: warning: this 'if' clause does not guard... [-Wmisleading-indentation]
     if (__builtin_constant_p(!!(cond)) ? !!(cond) :   \
     ^
   include/linux/compiler.h:56:23: note: in expansion of macro '__trace_if'
    #define if(cond, ...) __trace_if( (cond , ## __VA_ARGS__) )
                          ^~~~~~~~~~
>> sound/soc/codecs/mt6351.c:912:8: note: in expansion of macro 'if'
      else if (priv->hp_en_counter < 0)
           ^~
   sound/soc/codecs/mt6351.c:918:4: note: ...this statement, but the latter is misleadingly indented as if it were guarded by the 'if'
       hp_zcd_disable(codec);
       ^~~~~~~~~~~~~~
   In file included from include/linux/string.h:6:0,
                    from include/linux/dma-mapping.h:6,
                    from sound/soc/codecs/mt6351.c:12:
   include/linux/compiler.h:58:2: warning: this 'if' clause does not guard... [-Wmisleading-indentation]
     if (__builtin_constant_p(!!(cond)) ? !!(cond) :   \
     ^
   include/linux/compiler.h:56:23: note: in expansion of macro '__trace_if'
    #define if(cond, ...) __trace_if( (cond , ## __VA_ARGS__) )
                          ^~~~~~~~~~
   sound/soc/codecs/mt6351.c:928:8: note: in expansion of macro 'if'
      else if (priv->hp_en_counter < 0)
           ^~
   sound/soc/codecs/mt6351.c:933:4: note: ...this statement, but the latter is misleadingly indented as if it were guarded by the 'if'
       snd_soc_update_bits(codec,
       ^~~~~~~~~~~~~~~~~~~

vim +/if +912 sound/soc/codecs/mt6351.c

   834	
   835	static int mt_hp_event(struct snd_soc_dapm_widget *w,
   836			       struct snd_kcontrol *kcontrol,
   837			       int event)
   838	{
   839		struct snd_soc_codec *codec = snd_soc_dapm_to_codec(w->dapm);
   840		struct mt6351_priv *priv = snd_soc_codec_get_drvdata(codec);
   841	
   842		dev_dbg(priv->dev, "%s(), event 0x%x, hp_en_counter %d\n",
   843			__func__, event, priv->hp_en_counter);
   844	
   845		switch (event) {
   846		case SND_SOC_DAPM_PRE_PMU:
   847			priv->hp_en_counter++;
   848			if (priv->hp_en_counter > 1)
   849				break;	/* already enabled, do nothing */
   850			else if (priv->hp_en_counter <= 0)
   851				dev_err(priv->dev, "%s(), hp_en_counter %d <= 0\n",
   852					__func__,
   853					priv->hp_en_counter);
   854	
   855			hp_zcd_disable(codec);
   856	
   857			/* from yoyo HQA script */
   858			snd_soc_update_bits(codec, MT6351_AUDDEC_ANA_CON6,
   859					    0x0700, 0x0700);
   860			/* Set HPR/HPL gain as minimum (~ -40dB) */
   861			snd_soc_update_bits(codec, MT6351_ZCD_CON2, 0xffff, 0x0F9F);
   862			/* Set HS gain as minimum (~ -40dB) */
   863			snd_soc_update_bits(codec, MT6351_ZCD_CON3, 0xffff, 0x001F);
   864			/* De_OSC of HP */
   865			snd_soc_update_bits(codec, MT6351_AUDDEC_ANA_CON2,
   866					    0x0001, 0x0001);
   867			/* enable output STBENH */
   868			snd_soc_update_bits(codec, MT6351_AUDDEC_ANA_CON1,
   869					    0xffff, 0x2000);
   870			/* De_OSC of voice, enable output STBENH */
   871			snd_soc_update_bits(codec, MT6351_AUDDEC_ANA_CON1,
   872					    0xffff, 0x2100);
   873			/* Enable voice driver */
   874			snd_soc_update_bits(codec, MT6351_AUDDEC_ANA_CON0,
   875					    0x0010, 0xE090);
   876			/* Enable pre-charge buffer  */
   877			snd_soc_update_bits(codec, MT6351_AUDDEC_ANA_CON1,
   878					    0xffff, 0x2140);
   879	
   880			usleep_range(50, 60);
   881	
   882			/* Apply digital DC compensation value to DAC */
   883			set_hp_gain_zero(codec);
   884	
   885			/* Enable HPR/HPL */
   886			snd_soc_update_bits(codec, MT6351_AUDDEC_ANA_CON1,
   887					    0xffff, 0x2100);
   888			/* Disable pre-charge buffer */
   889			snd_soc_update_bits(codec, MT6351_AUDDEC_ANA_CON1,
   890					    0xffff, 0x2000);
   891			/* Disable De_OSC of voice */
   892			snd_soc_update_bits(codec, MT6351_AUDDEC_ANA_CON0,
   893					    0x0010, 0xF4EF);
   894			/* Disable voice buffer */
   895	
   896			/* from yoyo HQ */
   897			snd_soc_update_bits(codec, MT6351_AUDDEC_ANA_CON6,
   898					    0x0700, 0x0300);
   899	
   900			/* Enable ZCD, for minimize pop noise */
   901			/* when adjust gain during HP buffer on */
   902			hp_zcd_enable(codec);
   903	
   904			/* apply volume setting */
   905			hp_gain_ramp_set(codec, HP_GAIN_RESTORE);
   906	
   907			break;
   908		case SND_SOC_DAPM_PRE_PMD:
   909			priv->hp_en_counter--;
   910			if (priv->hp_en_counter > 0)
   911				break;	/* still being used, don't close */
 > 912			else if (priv->hp_en_counter < 0)
   913				dev_err(priv->dev, "%s(), hp_en_counter %d <= 0\n",
   914					__func__,
   915					priv->hp_en_counter);
   916	
   917				/* Disable AUD_ZCD */
   918				hp_zcd_disable(codec);
   919	
   920				/* Set HPR/HPL gain as -1dB, step by step */
   921				hp_gain_ramp_set(codec, HP_GAIN_SET_ZERO);
   922	
   923				set_hp_gain_zero(codec);
   924			break;
   925		case SND_SOC_DAPM_POST_PMD:
   926			if (priv->hp_en_counter > 0)
   927				break;	/* still being used, don't close */
   928			else if (priv->hp_en_counter < 0)
   929				dev_err(priv->dev, "%s(), hp_en_counter %d <= 0\n",
   930					__func__,
   931					priv->hp_en_counter);
   932				/* reset*/
   933				snd_soc_update_bits(codec,
   934						    MT6351_AUDDEC_ANA_CON6,
   935						    0x0700,
   936						    0x0000);
   937				/* De_OSC of HP */
   938				snd_soc_update_bits(codec,
   939						    MT6351_AUDDEC_ANA_CON2,
   940						    0x0001,
   941						    0x0000);
   942			break;
   943		default:
   944			break;
   945		}
   946	
   947		return 0;
   948	}
   949	

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation

--zhXaljGHf11kAtnf
Content-Type: application/gzip
Content-Disposition: attachment; filename=".config.gz"
Content-Transfer-Encoding: base64

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

--zhXaljGHf11kAtnf
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--zhXaljGHf11kAtnf--
