From: kbuild test robot <lkp@intel.com>
Subject: Re: [PATCH 11/19] ASoC: wm8776: Convert to
 module_i2c/spi_driver()
Date: Wed, 16 Nov 2016 01:51:18 +0800
Message-ID: <201611160117.MkKHlyTQ%fengguang.wu@intel.com>
References: <87lgwl8gzl.wl%kuninori.morimoto.gx@renesas.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="dDRMvlgZJXvWKvBx"
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
 by alsa0.perex.cz (Postfix) with ESMTP id 7BBEA2665AB
 for <alsa-devel@alsa-project.org>; Tue, 15 Nov 2016 18:51:23 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <87lgwl8gzl.wl%kuninori.morimoto.gx@renesas.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Cc: Linux-ALSA <alsa-devel@alsa-project.org>, Mark Brown <broonie@kernel.org>, kbuild-all@01.org, Simon <horms@verge.net.au>
List-Id: alsa-devel@alsa-project.org


--dDRMvlgZJXvWKvBx
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi Kuninori,

[auto build test WARNING on v4.9-rc5]
[cannot apply to asoc/for-next next-20161115]
[if your patch is applied to the wrong git tree, please drop us a note to help improve the system]

url:    https://github.com/0day-ci/linux/commits/Kuninori-Morimoto/ASoC-Convert-to-module_i2c-spi_driver/20161116-005820
config: x86_64-randconfig-x014-201646 (attached as .config)
compiler: gcc-6 (Debian 6.2.0-3) 6.2.0 20160901
reproduce:
        # save the attached .config to linux build tree
        make ARCH=x86_64 

All warnings (new ones prefixed by >>):

   In file included from sound/soc/codecs/wm8776.c:15:0:
   include/linux/module.h:130:27: error: redefinition of '__inittest'
     static inline initcall_t __inittest(void)  \
                              ^
   include/linux/device.h:1353:1: note: in expansion of macro 'module_init'
    module_init(__driver##_init); \
    ^~~~~~~~~~~
   include/linux/i2c.h:751:2: note: in expansion of macro 'module_driver'
     module_driver(__i2c_driver, i2c_add_driver, \
     ^~~~~~~~~~~~~
>> sound/soc/codecs/wm8776.c:547:1: note: in expansion of macro 'module_i2c_driver'
    module_i2c_driver(wm8776_i2c_driver);
    ^~~~~~~~~~~~~~~~~
   include/linux/module.h:130:27: note: previous definition of '__inittest' was here
     static inline initcall_t __inittest(void)  \
                              ^
   include/linux/device.h:1353:1: note: in expansion of macro 'module_init'
    module_init(__driver##_init); \
    ^~~~~~~~~~~
   include/linux/spi/spi.h:290:2: note: in expansion of macro 'module_driver'
     module_driver(__spi_driver, spi_register_driver, \
     ^~~~~~~~~~~~~
>> sound/soc/codecs/wm8776.c:498:1: note: in expansion of macro 'module_spi_driver'
    module_spi_driver(wm8776_spi_driver);
    ^~~~~~~~~~~~~~~~~
   include/linux/module.h:132:6: error: redefinition of 'init_module'
     int init_module(void) __attribute__((alias(#initfn)));
         ^
   include/linux/device.h:1353:1: note: in expansion of macro 'module_init'
    module_init(__driver##_init); \
    ^~~~~~~~~~~
   include/linux/i2c.h:751:2: note: in expansion of macro 'module_driver'
     module_driver(__i2c_driver, i2c_add_driver, \
     ^~~~~~~~~~~~~
>> sound/soc/codecs/wm8776.c:547:1: note: in expansion of macro 'module_i2c_driver'
    module_i2c_driver(wm8776_i2c_driver);
    ^~~~~~~~~~~~~~~~~
   include/linux/module.h:132:6: note: previous definition of 'init_module' was here
     int init_module(void) __attribute__((alias(#initfn)));
         ^
   include/linux/device.h:1353:1: note: in expansion of macro 'module_init'
    module_init(__driver##_init); \
    ^~~~~~~~~~~
   include/linux/spi/spi.h:290:2: note: in expansion of macro 'module_driver'
     module_driver(__spi_driver, spi_register_driver, \
     ^~~~~~~~~~~~~
>> sound/soc/codecs/wm8776.c:498:1: note: in expansion of macro 'module_spi_driver'
    module_spi_driver(wm8776_spi_driver);
    ^~~~~~~~~~~~~~~~~
   include/linux/module.h:136:27: error: redefinition of '__exittest'
     static inline exitcall_t __exittest(void)  \
                              ^
   include/linux/device.h:1358:1: note: in expansion of macro 'module_exit'
    module_exit(__driver##_exit);
    ^~~~~~~~~~~
   include/linux/i2c.h:751:2: note: in expansion of macro 'module_driver'
     module_driver(__i2c_driver, i2c_add_driver, \
     ^~~~~~~~~~~~~
>> sound/soc/codecs/wm8776.c:547:1: note: in expansion of macro 'module_i2c_driver'
    module_i2c_driver(wm8776_i2c_driver);
    ^~~~~~~~~~~~~~~~~
   include/linux/module.h:136:27: note: previous definition of '__exittest' was here
     static inline exitcall_t __exittest(void)  \
                              ^
   include/linux/device.h:1358:1: note: in expansion of macro 'module_exit'
    module_exit(__driver##_exit);
    ^~~~~~~~~~~
   include/linux/spi/spi.h:290:2: note: in expansion of macro 'module_driver'
     module_driver(__spi_driver, spi_register_driver, \
     ^~~~~~~~~~~~~
>> sound/soc/codecs/wm8776.c:498:1: note: in expansion of macro 'module_spi_driver'
    module_spi_driver(wm8776_spi_driver);
    ^~~~~~~~~~~~~~~~~
   include/linux/module.h:138:7: error: redefinition of 'cleanup_module'
     void cleanup_module(void) __attribute__((alias(#exitfn)));
          ^
   include/linux/device.h:1358:1: note: in expansion of macro 'module_exit'
    module_exit(__driver##_exit);
    ^~~~~~~~~~~
   include/linux/i2c.h:751:2: note: in expansion of macro 'module_driver'
     module_driver(__i2c_driver, i2c_add_driver, \
     ^~~~~~~~~~~~~
>> sound/soc/codecs/wm8776.c:547:1: note: in expansion of macro 'module_i2c_driver'
    module_i2c_driver(wm8776_i2c_driver);
    ^~~~~~~~~~~~~~~~~
   include/linux/module.h:138:7: note: previous definition of 'cleanup_module' was here
     void cleanup_module(void) __attribute__((alias(#exitfn)));
          ^
   include/linux/device.h:1358:1: note: in expansion of macro 'module_exit'
    module_exit(__driver##_exit);
    ^~~~~~~~~~~
   include/linux/spi/spi.h:290:2: note: in expansion of macro 'module_driver'
     module_driver(__spi_driver, spi_register_driver, \
     ^~~~~~~~~~~~~
>> sound/soc/codecs/wm8776.c:498:1: note: in expansion of macro 'module_spi_driver'
    module_spi_driver(wm8776_spi_driver);
    ^~~~~~~~~~~~~~~~~

vim +/module_i2c_driver +547 sound/soc/codecs/wm8776.c

   492			.name	= "wm8776",
   493			.of_match_table = wm8776_of_match,
   494		},
   495		.probe		= wm8776_spi_probe,
   496		.remove		= wm8776_spi_remove,
   497	};
 > 498	module_spi_driver(wm8776_spi_driver);
   499	#endif /* CONFIG_SPI_MASTER */
   500	
   501	#if IS_ENABLED(CONFIG_I2C)
   502	static int wm8776_i2c_probe(struct i2c_client *i2c,
   503				    const struct i2c_device_id *id)
   504	{
   505		struct wm8776_priv *wm8776;
   506		int ret;
   507	
   508		wm8776 = devm_kzalloc(&i2c->dev, sizeof(struct wm8776_priv),
   509				      GFP_KERNEL);
   510		if (wm8776 == NULL)
   511			return -ENOMEM;
   512	
   513		wm8776->regmap = devm_regmap_init_i2c(i2c, &wm8776_regmap);
   514		if (IS_ERR(wm8776->regmap))
   515			return PTR_ERR(wm8776->regmap);
   516	
   517		i2c_set_clientdata(i2c, wm8776);
   518	
   519		ret =  snd_soc_register_codec(&i2c->dev,
   520				&soc_codec_dev_wm8776, wm8776_dai, ARRAY_SIZE(wm8776_dai));
   521	
   522		return ret;
   523	}
   524	
   525	static int wm8776_i2c_remove(struct i2c_client *client)
   526	{
   527		snd_soc_unregister_codec(&client->dev);
   528		return 0;
   529	}
   530	
   531	static const struct i2c_device_id wm8776_i2c_id[] = {
   532		{ "wm8775", WM8775 },
   533		{ "wm8776", WM8776 },
   534		{ }
   535	};
   536	MODULE_DEVICE_TABLE(i2c, wm8776_i2c_id);
   537	
   538	static struct i2c_driver wm8776_i2c_driver = {
   539		.driver = {
   540			.name = "wm8776",
   541			.of_match_table = wm8776_of_match,
   542		},
   543		.probe =    wm8776_i2c_probe,
   544		.remove =   wm8776_i2c_remove,
   545		.id_table = wm8776_i2c_id,
   546	};
 > 547	module_i2c_driver(wm8776_i2c_driver);
   548	#endif
   549	
   550	MODULE_DESCRIPTION("ASoC WM8776 driver");

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation

--dDRMvlgZJXvWKvBx
Content-Type: application/gzip
Content-Disposition: attachment; filename=".config.gz"
Content-Transfer-Encoding: base64

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

--dDRMvlgZJXvWKvBx
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--dDRMvlgZJXvWKvBx--
