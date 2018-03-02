From: kbuild test robot <fengguang.wu@intel.com>
Subject: [asoc:topic/intel 22/22]
 sound/soc/intel/boards/cht_bsw_nau8824.c:137:36: sparse: incorrect type in
 argument 1 (different base types)
Date: Fri, 2 Mar 2018 22:19:04 +0800
Message-ID: <201803022202.Ejpect8F%fengguang.wu@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
 by alsa0.perex.cz (Postfix) with ESMTP id 3CA35267377
 for <alsa-devel@alsa-project.org>; Fri,  2 Mar 2018 15:19:43 +0100 (CET)
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
To: John Hsu <KCHSU0@nuvoton.com>
Cc: alsa-devel@alsa-project.org, Mark Brown <broonie@kernel.org>, kbuild-all@01.org
List-Id: alsa-devel@alsa-project.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git topic/intel
head:   3bf045d15f52529e8abe26543dbe22af44efb41a
commit: 3bf045d15f52529e8abe26543dbe22af44efb41a [22/22] ASoC: Intel: fix argument error in nau8824 machine
reproduce:
        # apt-get install sparse
        git checkout 3bf045d15f52529e8abe26543dbe22af44efb41a
        make ARCH=x86_64 allmodconfig
        make C=1 CF=-D__CHECK_ENDIAN__


sparse warnings: (new ones prefixed by >>)

>> sound/soc/intel/boards/cht_bsw_nau8824.c:137:36: sparse: incorrect type in argument 1 (different base types) @@    expected struct snd_soc_codec *codec @@    got strustruct snd_soc_codec *codec @@
   sound/soc/intel/boards/cht_bsw_nau8824.c:137:36:    expected struct snd_soc_codec *codec
   sound/soc/intel/boards/cht_bsw_nau8824.c:137:36:    got struct snd_soc_component *component
   sound/soc/intel/boards/cht_bsw_nau8824.c: In function 'cht_codec_init':
   sound/soc/intel/boards/cht_bsw_nau8824.c:137:29: error: passing argument 1 of 'nau8824_enable_jack_detect' from incompatible pointer type [-Werror=incompatible-pointer-types]
     nau8824_enable_jack_detect(component, jack);
                                ^~~~~~~~~
   In file included from sound/soc/intel/boards/cht_bsw_nau8824.c:31:0:
   sound/soc/intel/boards/../../codecs/nau8824.h:474:5: note: expected 'struct snd_soc_codec *' but argument is of type 'struct snd_soc_component *'
    int nau8824_enable_jack_detect(struct snd_soc_codec *codec,
        ^~~~~~~~~~~~~~~~~~~~~~~~~~
   cc1: some warnings being treated as errors

vim +137 sound/soc/intel/boards/cht_bsw_nau8824.c

   101	
   102	static int cht_codec_init(struct snd_soc_pcm_runtime *runtime)
   103	{
   104		struct cht_mc_private *ctx = snd_soc_card_get_drvdata(runtime->card);
   105		struct snd_soc_jack *jack = &ctx->jack;
   106		struct snd_soc_dai *codec_dai = runtime->codec_dai;
   107		struct snd_soc_component *component = codec_dai->component;
   108		int ret, jack_type;
   109	
   110		/* TDM 4 slots 24 bit, set Rx & Tx bitmask to 4 active slots */
   111		ret = snd_soc_dai_set_tdm_slot(codec_dai, 0xf, 0x1, 4, 24);
   112		if (ret < 0) {
   113			dev_err(runtime->dev, "can't set codec TDM slot %d\n", ret);
   114			return ret;
   115		}
   116	
   117		/* NAU88L24 supports 4 butons headset detection
   118		 * KEY_MEDIA
   119		 * KEY_VOICECOMMAND
   120		 * KEY_VOLUMEUP
   121		 * KEY_VOLUMEDOWN
   122		 */
   123		jack_type = SND_JACK_HEADPHONE | SND_JACK_BTN_0 | SND_JACK_BTN_1 |
   124			SND_JACK_BTN_2 | SND_JACK_BTN_3;
   125		ret = snd_soc_card_jack_new(runtime->card, "Headset", jack_type, jack,
   126			cht_bsw_jack_pins, ARRAY_SIZE(cht_bsw_jack_pins));
   127		if (ret) {
   128			dev_err(runtime->dev,
   129				"Headset Jack creation failed %d\n", ret);
   130			return ret;
   131		}
   132		snd_jack_set_key(jack->jack, SND_JACK_BTN_0, KEY_MEDIA);
   133		snd_jack_set_key(jack->jack, SND_JACK_BTN_1, KEY_VOICECOMMAND);
   134		snd_jack_set_key(jack->jack, SND_JACK_BTN_2, KEY_VOLUMEUP);
   135		snd_jack_set_key(jack->jack, SND_JACK_BTN_3, KEY_VOLUMEDOWN);
   136	
 > 137		nau8824_enable_jack_detect(component, jack);
   138	
   139		return ret;
   140	}
   141	

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
