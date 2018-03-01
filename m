From: kbuild test robot <fengguang.wu@intel.com>
Subject: [asoc:for-next 32/53]
 sound/soc/intel/boards/cht_bsw_nau8824.c:137:36: sparse: incorrect type in
 argument 1 (different base types)
Date: Fri, 2 Mar 2018 06:28:22 +0800
Message-ID: <201803020619.H8QS6VYS%fengguang.wu@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
 by alsa0.perex.cz (Postfix) with ESMTP id BCBFC267196
 for <alsa-devel@alsa-project.org>; Thu,  1 Mar 2018 23:29:02 +0100 (CET)
Content-Disposition: inline
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
Cc: alsa-devel@alsa-project.org, kbuild-all@01.org
List-Id: alsa-devel@alsa-project.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next
head:   392b22b9bc76706334efdfe11d3747c9ef8962bf
commit: 77348ef86e9b9fdab2fbb059b8e00c80adfa98ca [32/53] Merge remote-tracking branches 'asoc/topic/msm8916-wcd-digital', 'asoc/topic/nau8540', 'asoc/topic/nau8810' and 'asoc/topic/nau8824' into asoc-next
reproduce:
        # apt-get install sparse
        git checkout 77348ef86e9b9fdab2fbb059b8e00c80adfa98ca
        make ARCH=x86_64 allmodconfig
        make C=1 CF=-D__CHECK_ENDIAN__


sparse warnings: (new ones prefixed by >>)

>> sound/soc/intel/boards/cht_bsw_nau8824.c:137:36: sparse: incorrect type in argument 1 (different base types) @@    expected struct snd_soc_component *component @@    got ct snd_soc_component *component @@
   sound/soc/intel/boards/cht_bsw_nau8824.c:137:36:    expected struct snd_soc_component *component
   sound/soc/intel/boards/cht_bsw_nau8824.c:137:36:    got struct snd_soc_codec *codec
   sound/soc/intel/boards/cht_bsw_nau8824.c: In function 'cht_codec_init':
   sound/soc/intel/boards/cht_bsw_nau8824.c:137:29: error: passing argument 1 of 'nau8824_enable_jack_detect' from incompatible pointer type [-Werror=incompatible-pointer-types]
     nau8824_enable_jack_detect(codec, jack);
                                ^~~~~
   In file included from sound/soc/intel/boards/cht_bsw_nau8824.c:31:0:
   sound/soc/intel/boards/../../codecs/nau8824.h:474:5: note: expected 'struct snd_soc_component *' but argument is of type 'struct snd_soc_codec *'
    int nau8824_enable_jack_detect(struct snd_soc_component *component,
        ^~~~~~~~~~~~~~~~~~~~~~~~~~
   cc1: some warnings being treated as errors

vim +137 sound/soc/intel/boards/cht_bsw_nau8824.c

5b00ce63 John Hsu 2018-02-06  101  
5b00ce63 John Hsu 2018-02-06  102  static int cht_codec_init(struct snd_soc_pcm_runtime *runtime)
5b00ce63 John Hsu 2018-02-06  103  {
5b00ce63 John Hsu 2018-02-06  104  	struct cht_mc_private *ctx = snd_soc_card_get_drvdata(runtime->card);
5b00ce63 John Hsu 2018-02-06  105  	struct snd_soc_jack *jack = &ctx->jack;
5b00ce63 John Hsu 2018-02-06  106  	struct snd_soc_codec *codec = runtime->codec;
5b00ce63 John Hsu 2018-02-06  107  	struct snd_soc_dai *codec_dai = runtime->codec_dai;
5b00ce63 John Hsu 2018-02-06  108  	int ret, jack_type;
5b00ce63 John Hsu 2018-02-06  109  
5b00ce63 John Hsu 2018-02-06  110  	/* TDM 4 slots 24 bit, set Rx & Tx bitmask to 4 active slots */
5b00ce63 John Hsu 2018-02-06  111  	ret = snd_soc_dai_set_tdm_slot(codec_dai, 0xf, 0x1, 4, 24);
5b00ce63 John Hsu 2018-02-06  112  	if (ret < 0) {
5b00ce63 John Hsu 2018-02-06  113  		dev_err(runtime->dev, "can't set codec TDM slot %d\n", ret);
5b00ce63 John Hsu 2018-02-06  114  		return ret;
5b00ce63 John Hsu 2018-02-06  115  	}
5b00ce63 John Hsu 2018-02-06  116  
5b00ce63 John Hsu 2018-02-06  117  	/* NAU88L24 supports 4 butons headset detection
5b00ce63 John Hsu 2018-02-06  118  	 * KEY_MEDIA
5b00ce63 John Hsu 2018-02-06  119  	 * KEY_VOICECOMMAND
5b00ce63 John Hsu 2018-02-06  120  	 * KEY_VOLUMEUP
5b00ce63 John Hsu 2018-02-06  121  	 * KEY_VOLUMEDOWN
5b00ce63 John Hsu 2018-02-06  122  	 */
5b00ce63 John Hsu 2018-02-06  123  	jack_type = SND_JACK_HEADPHONE | SND_JACK_BTN_0 | SND_JACK_BTN_1 |
5b00ce63 John Hsu 2018-02-06  124  		SND_JACK_BTN_2 | SND_JACK_BTN_3;
5b00ce63 John Hsu 2018-02-06  125  	ret = snd_soc_card_jack_new(runtime->card, "Headset", jack_type, jack,
5b00ce63 John Hsu 2018-02-06  126  		cht_bsw_jack_pins, ARRAY_SIZE(cht_bsw_jack_pins));
5b00ce63 John Hsu 2018-02-06  127  	if (ret) {
5b00ce63 John Hsu 2018-02-06  128  		dev_err(runtime->dev,
5b00ce63 John Hsu 2018-02-06  129  			"Headset Jack creation failed %d\n", ret);
5b00ce63 John Hsu 2018-02-06  130  		return ret;
5b00ce63 John Hsu 2018-02-06  131  	}
5b00ce63 John Hsu 2018-02-06  132  	snd_jack_set_key(jack->jack, SND_JACK_BTN_0, KEY_MEDIA);
5b00ce63 John Hsu 2018-02-06  133  	snd_jack_set_key(jack->jack, SND_JACK_BTN_1, KEY_VOICECOMMAND);
5b00ce63 John Hsu 2018-02-06  134  	snd_jack_set_key(jack->jack, SND_JACK_BTN_2, KEY_VOLUMEUP);
5b00ce63 John Hsu 2018-02-06  135  	snd_jack_set_key(jack->jack, SND_JACK_BTN_3, KEY_VOLUMEDOWN);
5b00ce63 John Hsu 2018-02-06  136  
5b00ce63 John Hsu 2018-02-06 @137  	nau8824_enable_jack_detect(codec, jack);
5b00ce63 John Hsu 2018-02-06  138  
5b00ce63 John Hsu 2018-02-06  139  	return ret;
5b00ce63 John Hsu 2018-02-06  140  }
5b00ce63 John Hsu 2018-02-06  141  

:::::: The code at line 137 was first introduced by commit
:::::: 5b00ce63e07fac692400db80d3e1fbd1f1f65701 ASoC: Intel: add nau8824 sound card

:::::: TO: John Hsu <KCHSU0@nuvoton.com>
:::::: CC: Mark Brown <broonie@kernel.org>

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
