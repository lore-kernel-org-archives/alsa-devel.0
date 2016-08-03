From: kbuild test robot <lkp@intel.com>
Subject: Re: [alsa-devel] [PATCH 3/xx][sample] ASoC: remove codec duplicated
 callback function
Date: Wed, 3 Aug 2016 13:48:48 +0800
Message-ID: <201608031324.ODMUNZOF%fengguang.wu@intel.com>
References: <87fuqm8xur.wl%kuninori.morimoto.gx@renesas.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="OgqxwSJOaUobr8KG"
Return-path: <linux-renesas-soc-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <87fuqm8xur.wl%kuninori.morimoto.gx@renesas.com>
Sender: linux-renesas-soc-owner@vger.kernel.org
To: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Cc: kbuild-all@01.org, Mark Brown <broonie@kernel.org>, linux-renesas-soc@vger.kernel.org, Linux-ALSA <alsa-devel@alsa-project.org>, Simon <horms@verge.net.au>, Liam Girdwood <lgirdwood@gmail.com>
List-Id: alsa-devel@alsa-project.org


--OgqxwSJOaUobr8KG
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi Kuninori,

[auto build test ERROR on asoc/for-next]
[also build test ERROR on v4.7 next-20160802]
[if your patch is applied to the wrong git tree, please drop us a note to help improve the system]

url:    https://github.com/0day-ci/linux/commits/Kuninori-Morimoto/ASoC-remove-codec-duplicated-callback-function/20160803-130552
base:   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next
config: i386-randconfig-s1-201631 (attached as .config)
compiler: gcc-6 (Debian 6.1.1-9) 6.1.1 20160705
reproduce:
        # save the attached .config to linux build tree
        make ARCH=i386 

All error/warnings (new ones prefixed by >>):

>> sound/soc/codecs/adau1701.c:768:2: error: unknown field 'controls' specified in initializer
     .controls  = adau1701_controls,
     ^
>> sound/soc/codecs/adau1701.c:768:2: warning: the address of 'adau1701_controls' will always evaluate as 'true' [-Waddress]
>> sound/soc/codecs/adau1701.c:769:2: error: unknown field 'num_controls' specified in initializer
     .num_controls  = ARRAY_SIZE(adau1701_controls),
     ^
   In file included from include/linux/list.h:8:0,
                    from include/linux/module.h:9,
                    from sound/soc/codecs/adau1701.c:11:
   include/linux/kernel.h:54:25: warning: initialization makes pointer from integer without a cast [-Wint-conversion]
    #define ARRAY_SIZE(arr) (sizeof(arr) / sizeof((arr)[0]) + __must_be_array(arr))
                            ^
>> sound/soc/codecs/adau1701.c:769:19: note: in expansion of macro 'ARRAY_SIZE'
     .num_controls  = ARRAY_SIZE(adau1701_controls),
                      ^~~~~~~~~~
   include/linux/kernel.h:54:25: note: (near initialization for 'adau1701_codec_drv.seq_notifier')
    #define ARRAY_SIZE(arr) (sizeof(arr) / sizeof((arr)[0]) + __must_be_array(arr))
                            ^
>> sound/soc/codecs/adau1701.c:769:19: note: in expansion of macro 'ARRAY_SIZE'
     .num_controls  = ARRAY_SIZE(adau1701_controls),
                      ^~~~~~~~~~
>> sound/soc/codecs/adau1701.c:770:2: error: unknown field 'dapm_widgets' specified in initializer
     .dapm_widgets  = adau1701_dapm_widgets,
     ^
>> sound/soc/codecs/adau1701.c:770:2: warning: the address of 'adau1701_dapm_widgets' will always evaluate as 'true' [-Waddress]
>> sound/soc/codecs/adau1701.c:771:2: error: unknown field 'num_dapm_widgets' specified in initializer
     .num_dapm_widgets = ARRAY_SIZE(adau1701_dapm_widgets),
     ^
   In file included from include/linux/list.h:8:0,
                    from include/linux/module.h:9,
                    from sound/soc/codecs/adau1701.c:11:
   include/linux/kernel.h:54:25: warning: excess elements in struct initializer
    #define ARRAY_SIZE(arr) (sizeof(arr) / sizeof((arr)[0]) + __must_be_array(arr))
                            ^
   sound/soc/codecs/adau1701.c:771:22: note: in expansion of macro 'ARRAY_SIZE'
     .num_dapm_widgets = ARRAY_SIZE(adau1701_dapm_widgets),
                         ^~~~~~~~~~
   include/linux/kernel.h:54:25: note: (near initialization for 'adau1701_codec_drv')
    #define ARRAY_SIZE(arr) (sizeof(arr) / sizeof((arr)[0]) + __must_be_array(arr))
                            ^
   sound/soc/codecs/adau1701.c:771:22: note: in expansion of macro 'ARRAY_SIZE'
     .num_dapm_widgets = ARRAY_SIZE(adau1701_dapm_widgets),
                         ^~~~~~~~~~
>> sound/soc/codecs/adau1701.c:772:2: error: unknown field 'dapm_routes' specified in initializer
     .dapm_routes  = adau1701_dapm_routes,
     ^
>> sound/soc/codecs/adau1701.c:772:18: warning: excess elements in struct initializer
     .dapm_routes  = adau1701_dapm_routes,
                     ^~~~~~~~~~~~~~~~~~~~
   sound/soc/codecs/adau1701.c:772:18: note: (near initialization for 'adau1701_codec_drv')
>> sound/soc/codecs/adau1701.c:773:2: error: unknown field 'num_dapm_routes' specified in initializer
     .num_dapm_routes = ARRAY_SIZE(adau1701_dapm_routes),
     ^
   In file included from include/linux/list.h:8:0,
                    from include/linux/module.h:9,
                    from sound/soc/codecs/adau1701.c:11:
   include/linux/kernel.h:54:25: warning: excess elements in struct initializer
    #define ARRAY_SIZE(arr) (sizeof(arr) / sizeof((arr)[0]) + __must_be_array(arr))
                            ^
   sound/soc/codecs/adau1701.c:773:21: note: in expansion of macro 'ARRAY_SIZE'
     .num_dapm_routes = ARRAY_SIZE(adau1701_dapm_routes),
                        ^~~~~~~~~~
   include/linux/kernel.h:54:25: note: (near initialization for 'adau1701_codec_drv')
    #define ARRAY_SIZE(arr) (sizeof(arr) / sizeof((arr)[0]) + __must_be_array(arr))
                            ^
   sound/soc/codecs/adau1701.c:773:21: note: in expansion of macro 'ARRAY_SIZE'
     .num_dapm_routes = ARRAY_SIZE(adau1701_dapm_routes),
                        ^~~~~~~~~~
--
>> sound/soc/codecs/ak4104.c:248:2: error: unknown field 'dapm_widgets' specified in initializer
     .dapm_widgets = ak4104_dapm_widgets,
     ^
>> sound/soc/codecs/ak4104.c:248:18: error: initialization from incompatible pointer type [-Werror=incompatible-pointer-types]
     .dapm_widgets = ak4104_dapm_widgets,
                     ^~~~~~~~~~~~~~~~~~~
   sound/soc/codecs/ak4104.c:248:18: note: (near initialization for 'soc_codec_device_ak4104.component_driver.name')
>> sound/soc/codecs/ak4104.c:249:2: error: unknown field 'num_dapm_widgets' specified in initializer
     .num_dapm_widgets = ARRAY_SIZE(ak4104_dapm_widgets),
     ^
   In file included from include/linux/list.h:8:0,
                    from include/linux/module.h:9,
                    from sound/soc/codecs/ak4104.c:12:
   include/linux/kernel.h:54:25: warning: initialization makes pointer from integer without a cast [-Wint-conversion]
    #define ARRAY_SIZE(arr) (sizeof(arr) / sizeof((arr)[0]) + __must_be_array(arr))
                            ^
>> sound/soc/codecs/ak4104.c:249:22: note: in expansion of macro 'ARRAY_SIZE'
     .num_dapm_widgets = ARRAY_SIZE(ak4104_dapm_widgets),
                         ^~~~~~~~~~
   include/linux/kernel.h:54:25: note: (near initialization for 'soc_codec_device_ak4104.set_sysclk')
    #define ARRAY_SIZE(arr) (sizeof(arr) / sizeof((arr)[0]) + __must_be_array(arr))
                            ^
>> sound/soc/codecs/ak4104.c:249:22: note: in expansion of macro 'ARRAY_SIZE'
     .num_dapm_widgets = ARRAY_SIZE(ak4104_dapm_widgets),
                         ^~~~~~~~~~
>> sound/soc/codecs/ak4104.c:250:2: error: unknown field 'dapm_routes' specified in initializer
     .dapm_routes = ak4104_dapm_routes,
     ^
   sound/soc/codecs/ak4104.c:250:17: error: initialization from incompatible pointer type [-Werror=incompatible-pointer-types]
     .dapm_routes = ak4104_dapm_routes,
                    ^~~~~~~~~~~~~~~~~~
   sound/soc/codecs/ak4104.c:250:17: note: (near initialization for 'soc_codec_device_ak4104.set_pll')
>> sound/soc/codecs/ak4104.c:251:2: error: unknown field 'num_dapm_routes' specified in initializer
     .num_dapm_routes = ARRAY_SIZE(ak4104_dapm_routes),
     ^
   In file included from include/linux/list.h:8:0,
                    from include/linux/module.h:9,
                    from sound/soc/codecs/ak4104.c:12:
   include/linux/kernel.h:54:25: warning: initialization makes pointer from integer without a cast [-Wint-conversion]
    #define ARRAY_SIZE(arr) (sizeof(arr) / sizeof((arr)[0]) + __must_be_array(arr))
                            ^
   sound/soc/codecs/ak4104.c:251:21: note: in expansion of macro 'ARRAY_SIZE'
     .num_dapm_routes = ARRAY_SIZE(ak4104_dapm_routes),
                        ^~~~~~~~~~
   include/linux/kernel.h:54:25: note: (near initialization for 'soc_codec_device_ak4104.get_regmap')
    #define ARRAY_SIZE(arr) (sizeof(arr) / sizeof((arr)[0]) + __must_be_array(arr))
                            ^
   sound/soc/codecs/ak4104.c:251:21: note: in expansion of macro 'ARRAY_SIZE'
     .num_dapm_routes = ARRAY_SIZE(ak4104_dapm_routes),
                        ^~~~~~~~~~
>> sound/soc/codecs/ak4104.c:242:62: warning: missing braces around initializer [-Wmissing-braces]
    static struct snd_soc_codec_driver soc_codec_device_ak4104 = {
                                                                 ^
   sound/soc/codecs/ak4104.c:242:62: note: (near initialization for 'soc_codec_device_ak4104')
   cc1: some warnings being treated as errors
--
>> sound/soc/codecs/ak4554.c:68:2: error: unknown field 'dapm_widgets' specified in initializer
     .dapm_widgets = ak4554_dapm_widgets,
     ^
>> sound/soc/codecs/ak4554.c:68:18: error: initialization from incompatible pointer type [-Werror=incompatible-pointer-types]
     .dapm_widgets = ak4554_dapm_widgets,
                     ^~~~~~~~~~~~~~~~~~~
   sound/soc/codecs/ak4554.c:68:18: note: (near initialization for 'soc_codec_dev_ak4554.probe')
>> sound/soc/codecs/ak4554.c:69:2: error: unknown field 'num_dapm_widgets' specified in initializer
     .num_dapm_widgets = ARRAY_SIZE(ak4554_dapm_widgets),
     ^
   In file included from include/linux/list.h:8:0,
                    from include/linux/module.h:9,
                    from sound/soc/codecs/ak4554.c:12:
   include/linux/kernel.h:54:25: warning: initialization makes pointer from integer without a cast [-Wint-conversion]
    #define ARRAY_SIZE(arr) (sizeof(arr) / sizeof((arr)[0]) + __must_be_array(arr))
                            ^
>> sound/soc/codecs/ak4554.c:69:22: note: in expansion of macro 'ARRAY_SIZE'
     .num_dapm_widgets = ARRAY_SIZE(ak4554_dapm_widgets),
                         ^~~~~~~~~~
   include/linux/kernel.h:54:25: note: (near initialization for 'soc_codec_dev_ak4554.remove')
    #define ARRAY_SIZE(arr) (sizeof(arr) / sizeof((arr)[0]) + __must_be_array(arr))
                            ^
>> sound/soc/codecs/ak4554.c:69:22: note: in expansion of macro 'ARRAY_SIZE'
     .num_dapm_widgets = ARRAY_SIZE(ak4554_dapm_widgets),
                         ^~~~~~~~~~
>> sound/soc/codecs/ak4554.c:70:2: error: unknown field 'dapm_routes' specified in initializer
     .dapm_routes = ak4554_dapm_routes,
     ^
   sound/soc/codecs/ak4554.c:70:17: error: initialization from incompatible pointer type [-Werror=incompatible-pointer-types]
     .dapm_routes = ak4554_dapm_routes,
                    ^~~~~~~~~~~~~~~~~~
   sound/soc/codecs/ak4554.c:70:17: note: (near initialization for 'soc_codec_dev_ak4554.suspend')
>> sound/soc/codecs/ak4554.c:71:2: error: unknown field 'num_dapm_routes' specified in initializer
     .num_dapm_routes = ARRAY_SIZE(ak4554_dapm_routes),
     ^
   In file included from include/linux/list.h:8:0,
                    from include/linux/module.h:9,
                    from sound/soc/codecs/ak4554.c:12:
   include/linux/kernel.h:54:25: warning: initialization makes pointer from integer without a cast [-Wint-conversion]
    #define ARRAY_SIZE(arr) (sizeof(arr) / sizeof((arr)[0]) + __must_be_array(arr))
                            ^
   sound/soc/codecs/ak4554.c:71:21: note: in expansion of macro 'ARRAY_SIZE'
     .num_dapm_routes = ARRAY_SIZE(ak4554_dapm_routes),
                        ^~~~~~~~~~
   include/linux/kernel.h:54:25: note: (near initialization for 'soc_codec_dev_ak4554.resume')
    #define ARRAY_SIZE(arr) (sizeof(arr) / sizeof((arr)[0]) + __must_be_array(arr))
                            ^
   sound/soc/codecs/ak4554.c:71:21: note: in expansion of macro 'ARRAY_SIZE'
     .num_dapm_routes = ARRAY_SIZE(ak4554_dapm_routes),
                        ^~~~~~~~~~
   cc1: some warnings being treated as errors
--
>> sound/soc/codecs/cs35l32.c:234:2: error: unknown field 'dapm_widgets' specified in initializer
     .dapm_widgets = cs35l32_dapm_widgets,
     ^
>> sound/soc/codecs/cs35l32.c:234:18: error: initialization from incompatible pointer type [-Werror=incompatible-pointer-types]
     .dapm_widgets = cs35l32_dapm_widgets,
                     ^~~~~~~~~~~~~~~~~~~~
   sound/soc/codecs/cs35l32.c:234:18: note: (near initialization for 'soc_codec_dev_cs35l32.set_pll')
>> sound/soc/codecs/cs35l32.c:235:2: error: unknown field 'num_dapm_widgets' specified in initializer
     .num_dapm_widgets = ARRAY_SIZE(cs35l32_dapm_widgets),
     ^
   In file included from include/linux/list.h:8:0,
                    from include/linux/module.h:9,
                    from sound/soc/codecs/cs35l32.c:14:
   include/linux/kernel.h:54:25: warning: initialization makes pointer from integer without a cast [-Wint-conversion]
    #define ARRAY_SIZE(arr) (sizeof(arr) / sizeof((arr)[0]) + __must_be_array(arr))
                            ^
>> sound/soc/codecs/cs35l32.c:235:22: note: in expansion of macro 'ARRAY_SIZE'
     .num_dapm_widgets = ARRAY_SIZE(cs35l32_dapm_widgets),
                         ^~~~~~~~~~
   include/linux/kernel.h:54:25: note: (near initialization for 'soc_codec_dev_cs35l32.get_regmap')
    #define ARRAY_SIZE(arr) (sizeof(arr) / sizeof((arr)[0]) + __must_be_array(arr))
                            ^
>> sound/soc/codecs/cs35l32.c:235:22: note: in expansion of macro 'ARRAY_SIZE'
     .num_dapm_widgets = ARRAY_SIZE(cs35l32_dapm_widgets),
                         ^~~~~~~~~~
>> sound/soc/codecs/cs35l32.c:236:2: error: unknown field 'dapm_routes' specified in initializer
     .dapm_routes = cs35l32_audio_map,
     ^
   sound/soc/codecs/cs35l32.c:236:17: error: initialization from incompatible pointer type [-Werror=incompatible-pointer-types]
     .dapm_routes = cs35l32_audio_map,
                    ^~~~~~~~~~~~~~~~~
   sound/soc/codecs/cs35l32.c:236:17: note: (near initialization for 'soc_codec_dev_cs35l32.read')
>> sound/soc/codecs/cs35l32.c:237:2: error: unknown field 'num_dapm_routes' specified in initializer
     .num_dapm_routes = ARRAY_SIZE(cs35l32_audio_map),
     ^
   In file included from include/linux/list.h:8:0,
                    from include/linux/module.h:9,
                    from sound/soc/codecs/cs35l32.c:14:
   include/linux/kernel.h:54:25: warning: initialization makes pointer from integer without a cast [-Wint-conversion]
    #define ARRAY_SIZE(arr) (sizeof(arr) / sizeof((arr)[0]) + __must_be_array(arr))
                            ^
   sound/soc/codecs/cs35l32.c:237:21: note: in expansion of macro 'ARRAY_SIZE'
     .num_dapm_routes = ARRAY_SIZE(cs35l32_audio_map),
                        ^~~~~~~~~~
   include/linux/kernel.h:54:25: note: (near initialization for 'soc_codec_dev_cs35l32.write')
    #define ARRAY_SIZE(arr) (sizeof(arr) / sizeof((arr)[0]) + __must_be_array(arr))
                            ^
   sound/soc/codecs/cs35l32.c:237:21: note: in expansion of macro 'ARRAY_SIZE'
     .num_dapm_routes = ARRAY_SIZE(cs35l32_audio_map),
                        ^~~~~~~~~~
>> sound/soc/codecs/cs35l32.c:239:2: error: unknown field 'controls' specified in initializer
     .controls = cs35l32_snd_controls,
     ^
>> sound/soc/codecs/cs35l32.c:239:14: warning: initialization makes integer from pointer without a cast [-Wint-conversion]
     .controls = cs35l32_snd_controls,
                 ^~~~~~~~~~~~~~~~~~~~
   sound/soc/codecs/cs35l32.c:239:14: note: (near initialization for 'soc_codec_dev_cs35l32.reg_cache_size')
>> sound/soc/codecs/cs35l32.c:240:2: error: unknown field 'num_controls' specified in initializer
     .num_controls = ARRAY_SIZE(cs35l32_snd_controls),
     ^
   cc1: some warnings being treated as errors
--
>> sound/soc/codecs/cs42l73.c:1260:2: error: unknown field 'dapm_widgets' specified in initializer
     .dapm_widgets = cs42l73_dapm_widgets,
     ^
>> sound/soc/codecs/cs42l73.c:1260:18: error: initialization from incompatible pointer type [-Werror=incompatible-pointer-types]
     .dapm_widgets = cs42l73_dapm_widgets,
                     ^~~~~~~~~~~~~~~~~~~~
   sound/soc/codecs/cs42l73.c:1260:18: note: (near initialization for 'soc_codec_dev_cs42l73.seq_notifier')
>> sound/soc/codecs/cs42l73.c:1261:2: error: unknown field 'num_dapm_widgets' specified in initializer
     .num_dapm_widgets = ARRAY_SIZE(cs42l73_dapm_widgets),
     ^
>> sound/soc/codecs/cs42l73.c:1262:2: error: unknown field 'dapm_routes' specified in initializer
     .dapm_routes = cs42l73_audio_map,
     ^
>> sound/soc/codecs/cs42l73.c:1262:17: warning: excess elements in struct initializer
     .dapm_routes = cs42l73_audio_map,
                    ^~~~~~~~~~~~~~~~~
   sound/soc/codecs/cs42l73.c:1262:17: note: (near initialization for 'soc_codec_dev_cs42l73')
>> sound/soc/codecs/cs42l73.c:1263:2: error: unknown field 'num_dapm_routes' specified in initializer
     .num_dapm_routes = ARRAY_SIZE(cs42l73_audio_map),
     ^
   In file included from include/linux/list.h:8:0,
                    from include/linux/module.h:9,
                    from sound/soc/codecs/cs42l73.c:15:
   include/linux/kernel.h:54:25: warning: excess elements in struct initializer
    #define ARRAY_SIZE(arr) (sizeof(arr) / sizeof((arr)[0]) + __must_be_array(arr))
                            ^
>> sound/soc/codecs/cs42l73.c:1263:21: note: in expansion of macro 'ARRAY_SIZE'
     .num_dapm_routes = ARRAY_SIZE(cs42l73_audio_map),
                        ^~~~~~~~~~
   include/linux/kernel.h:54:25: note: (near initialization for 'soc_codec_dev_cs42l73')
    #define ARRAY_SIZE(arr) (sizeof(arr) / sizeof((arr)[0]) + __must_be_array(arr))
                            ^
>> sound/soc/codecs/cs42l73.c:1263:21: note: in expansion of macro 'ARRAY_SIZE'
     .num_dapm_routes = ARRAY_SIZE(cs42l73_audio_map),
                        ^~~~~~~~~~
>> sound/soc/codecs/cs42l73.c:1265:2: error: unknown field 'controls' specified in initializer
     .controls = cs42l73_snd_controls,
     ^
   sound/soc/codecs/cs42l73.c:1265:14: warning: excess elements in struct initializer
     .controls = cs42l73_snd_controls,
                 ^~~~~~~~~~~~~~~~~~~~
   sound/soc/codecs/cs42l73.c:1265:14: note: (near initialization for 'soc_codec_dev_cs42l73')
>> sound/soc/codecs/cs42l73.c:1266:2: error: unknown field 'num_controls' specified in initializer
     .num_controls = ARRAY_SIZE(cs42l73_snd_controls),
     ^
   In file included from include/linux/list.h:8:0,
                    from include/linux/module.h:9,
                    from sound/soc/codecs/cs42l73.c:15:
   include/linux/kernel.h:54:25: warning: excess elements in struct initializer
    #define ARRAY_SIZE(arr) (sizeof(arr) / sizeof((arr)[0]) + __must_be_array(arr))
                            ^
   sound/soc/codecs/cs42l73.c:1266:18: note: in expansion of macro 'ARRAY_SIZE'
     .num_controls = ARRAY_SIZE(cs42l73_snd_controls),
                     ^~~~~~~~~~
   include/linux/kernel.h:54:25: note: (near initialization for 'soc_codec_dev_cs42l73')
    #define ARRAY_SIZE(arr) (sizeof(arr) / sizeof((arr)[0]) + __must_be_array(arr))
                            ^
   sound/soc/codecs/cs42l73.c:1266:18: note: in expansion of macro 'ARRAY_SIZE'
     .num_controls = ARRAY_SIZE(cs42l73_snd_controls),
                     ^~~~~~~~~~
   cc1: some warnings being treated as errors
..

vim +/num_controls +769 sound/soc/codecs/adau1701.c

64fcc1fd Pascal Huerst      2015-04-20  762  	.remove			= adau1701_remove,
64fcc1fd Pascal Huerst      2015-04-20  763  	.resume			= adau1701_resume,
64fcc1fd Pascal Huerst      2015-04-20  764  	.suspend		= adau1701_suspend,
631ed8a2 Lars-Peter Clausen 2011-06-13  765  	.set_bias_level		= adau1701_set_bias_level,
eb3032f8 Axel Lin           2012-01-27  766  	.idle_bias_off		= true,
631ed8a2 Lars-Peter Clausen 2011-06-13  767  
631ed8a2 Lars-Peter Clausen 2011-06-13 @768  	.controls		= adau1701_controls,
631ed8a2 Lars-Peter Clausen 2011-06-13 @769  	.num_controls		= ARRAY_SIZE(adau1701_controls),
631ed8a2 Lars-Peter Clausen 2011-06-13 @770  	.dapm_widgets		= adau1701_dapm_widgets,
631ed8a2 Lars-Peter Clausen 2011-06-13 @771  	.num_dapm_widgets	= ARRAY_SIZE(adau1701_dapm_widgets),
631ed8a2 Lars-Peter Clausen 2011-06-13 @772  	.dapm_routes		= adau1701_dapm_routes,
631ed8a2 Lars-Peter Clausen 2011-06-13 @773  	.num_dapm_routes	= ARRAY_SIZE(adau1701_dapm_routes),
631ed8a2 Lars-Peter Clausen 2011-06-13  774  
631ed8a2 Lars-Peter Clausen 2011-06-13  775  	.set_sysclk		= adau1701_set_sysclk,
631ed8a2 Lars-Peter Clausen 2011-06-13  776  };

:::::: The code at line 769 was first introduced by commit
:::::: 631ed8a2134dae17d9e17f3c35c7290720f85199 ASoC: Add ADAU1701 codec driver

:::::: TO: Lars-Peter Clausen <lars@metafoo.de>
:::::: CC: Mark Brown <broonie@opensource.wolfsonmicro.com>

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation

--OgqxwSJOaUobr8KG
Content-Type: application/octet-stream
Content-Disposition: attachment; filename=".config.gz"
Content-Transfer-Encoding: base64

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

--OgqxwSJOaUobr8KG--
