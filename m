From: kbuild test robot <lkp-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Subject: Re: [alsa-devel] [PATCH v2 6/8] regulator: arizona-micbias: Add
 regulator driver for Arizona micbiases
Date: Wed, 29 Mar 2017 14:18:23 +0800
Message-ID: <201703291403.z4sFz6z9%fengguang.wu@intel.com>
References: <1490710484-25277-6-git-send-email-ckeepax@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="C7zPtVaVf+AK4Oqc"
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1490710484-25277-6-git-send-email-ckeepax-yzvPICuk2AATkU/dhu1WVueM+bqZidxxQQ4Iyu8u01E@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Charles Keepax <ckeepax-yzvPICuk2AATkU/dhu1WVueM+bqZidxxQQ4Iyu8u01E@public.gmane.org>
Cc: kbuild-all-JC7UmRfGjtg@public.gmane.org, broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, mark.rutland-5wv7dgnIgG8@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, alsa-devel-K7yf7f+aM1XWsZ/bQMPhNw@public.gmane.org, patches-yzvPICuk2AATkU/dhu1WVueM+bqZidxxQQ4Iyu8u01E@public.gmane.org, lgirdwood-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, lee.jones-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org
List-Id: alsa-devel@alsa-project.org


--C7zPtVaVf+AK4Oqc
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi Charles,

[auto build test WARNING on regulator/for-next]
[also build test WARNING on v4.11-rc4 next-20170328]
[if your patch is applied to the wrong git tree, please drop us a note to help improve the system]

url:    https://github.com/0day-ci/linux/commits/Charles-Keepax/regulator-arizona-micsupp-Avoid-potential-memory-leak-reading-init_data/20170329-112224
base:   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/regulator.git for-next
config: i386-randconfig-x0-03291136 (attached as .config)
compiler: gcc-6 (Debian 6.2.0-3) 6.2.0 20160901
reproduce:
        # save the attached .config to linux build tree
        make ARCH=i386 

All warnings (new ones prefixed by >>):

   In file included from include/linux/err.h:4:0,
                    from include/linux/clk.h:15,
                    from drivers//mfd/arizona-core.c:13:
   drivers//mfd/arizona-core.c: In function 'arizona_dev_init':
   drivers//mfd/arizona-core.c:1408:33: error: 'struct arizona_micbias' has no member named 'mV'
      if (!arizona->pdata.micbias[i].mV &&
                                    ^
   include/linux/compiler.h:160:30: note: in definition of macro '__trace_if'
     if (__builtin_constant_p(!!(cond)) ? !!(cond) :   \
                                 ^~~~
>> drivers//mfd/arizona-core.c:1408:3: note: in expansion of macro 'if'
      if (!arizona->pdata.micbias[i].mV &&
      ^~
   drivers//mfd/arizona-core.c:1409:33: error: 'struct arizona_micbias' has no member named 'bypass'
          !arizona->pdata.micbias[i].bypass)
                                    ^
   include/linux/compiler.h:160:30: note: in definition of macro '__trace_if'
     if (__builtin_constant_p(!!(cond)) ? !!(cond) :   \
                                 ^~~~
>> drivers//mfd/arizona-core.c:1408:3: note: in expansion of macro 'if'
      if (!arizona->pdata.micbias[i].mV &&
      ^~
   drivers//mfd/arizona-core.c:1408:33: error: 'struct arizona_micbias' has no member named 'mV'
      if (!arizona->pdata.micbias[i].mV &&
                                    ^
   include/linux/compiler.h:160:42: note: in definition of macro '__trace_if'
     if (__builtin_constant_p(!!(cond)) ? !!(cond) :   \
                                             ^~~~
>> drivers//mfd/arizona-core.c:1408:3: note: in expansion of macro 'if'
      if (!arizona->pdata.micbias[i].mV &&
      ^~
   drivers//mfd/arizona-core.c:1409:33: error: 'struct arizona_micbias' has no member named 'bypass'
          !arizona->pdata.micbias[i].bypass)
                                    ^
   include/linux/compiler.h:160:42: note: in definition of macro '__trace_if'
     if (__builtin_constant_p(!!(cond)) ? !!(cond) :   \
                                             ^~~~
>> drivers//mfd/arizona-core.c:1408:3: note: in expansion of macro 'if'
      if (!arizona->pdata.micbias[i].mV &&
      ^~
   drivers//mfd/arizona-core.c:1408:33: error: 'struct arizona_micbias' has no member named 'mV'
      if (!arizona->pdata.micbias[i].mV &&
                                    ^
   include/linux/compiler.h:171:16: note: in definition of macro '__trace_if'
      ______r = !!(cond);     \
                   ^~~~
>> drivers//mfd/arizona-core.c:1408:3: note: in expansion of macro 'if'
      if (!arizona->pdata.micbias[i].mV &&
      ^~
   drivers//mfd/arizona-core.c:1409:33: error: 'struct arizona_micbias' has no member named 'bypass'
          !arizona->pdata.micbias[i].bypass)
                                    ^
   include/linux/compiler.h:171:16: note: in definition of macro '__trace_if'
      ______r = !!(cond);     \
                   ^~~~
>> drivers//mfd/arizona-core.c:1408:3: note: in expansion of macro 'if'
      if (!arizona->pdata.micbias[i].mV &&
      ^~
   drivers//mfd/arizona-core.c:1413:33: error: 'struct arizona_micbias' has no member named 'mV'
      if (!arizona->pdata.micbias[i].mV)
                                    ^
   include/linux/compiler.h:160:30: note: in definition of macro '__trace_if'
     if (__builtin_constant_p(!!(cond)) ? !!(cond) :   \
                                 ^~~~
   drivers//mfd/arizona-core.c:1413:3: note: in expansion of macro 'if'
      if (!arizona->pdata.micbias[i].mV)
      ^~
   drivers//mfd/arizona-core.c:1413:33: error: 'struct arizona_micbias' has no member named 'mV'
      if (!arizona->pdata.micbias[i].mV)
                                    ^
   include/linux/compiler.h:160:42: note: in definition of macro '__trace_if'
     if (__builtin_constant_p(!!(cond)) ? !!(cond) :   \
                                             ^~~~
   drivers//mfd/arizona-core.c:1413:3: note: in expansion of macro 'if'
      if (!arizona->pdata.micbias[i].mV)
      ^~
   drivers//mfd/arizona-core.c:1413:33: error: 'struct arizona_micbias' has no member named 'mV'
      if (!arizona->pdata.micbias[i].mV)
                                    ^
   include/linux/compiler.h:171:16: note: in definition of macro '__trace_if'
      ______r = !!(cond);     \
                   ^~~~
   drivers//mfd/arizona-core.c:1413:3: note: in expansion of macro 'if'
      if (!arizona->pdata.micbias[i].mV)
      ^~
   drivers//mfd/arizona-core.c:1414:29: error: 'struct arizona_micbias' has no member named 'mV'
       arizona->pdata.micbias[i].mV = 2800;
                                ^
   drivers//mfd/arizona-core.c:1416:35: error: 'struct arizona_micbias' has no member named 'mV'
      val = (arizona->pdata.micbias[i].mV - 1500) / 100;
                                      ^
   In file included from include/linux/err.h:4:0,
                    from include/linux/clk.h:15,
                    from drivers//mfd/arizona-core.c:13:
   drivers//mfd/arizona-core.c:1423:32: error: 'struct arizona_micbias' has no member named 'discharge'
      if (arizona->pdata.micbias[i].discharge)
                                   ^
   include/linux/compiler.h:160:30: note: in definition of macro '__trace_if'
     if (__builtin_constant_p(!!(cond)) ? !!(cond) :   \
                                 ^~~~
   drivers//mfd/arizona-core.c:1423:3: note: in expansion of macro 'if'
      if (arizona->pdata.micbias[i].discharge)
      ^~
   drivers//mfd/arizona-core.c:1423:32: error: 'struct arizona_micbias' has no member named 'discharge'
      if (arizona->pdata.micbias[i].discharge)
                                   ^
   include/linux/compiler.h:160:42: note: in definition of macro '__trace_if'
     if (__builtin_constant_p(!!(cond)) ? !!(cond) :   \
                                             ^~~~
   drivers//mfd/arizona-core.c:1423:3: note: in expansion of macro 'if'
      if (arizona->pdata.micbias[i].discharge)
      ^~
   drivers//mfd/arizona-core.c:1423:32: error: 'struct arizona_micbias' has no member named 'discharge'
      if (arizona->pdata.micbias[i].discharge)
                                   ^
   include/linux/compiler.h:171:16: note: in definition of macro '__trace_if'
      ______r = !!(cond);     \
                   ^~~~
   drivers//mfd/arizona-core.c:1423:3: note: in expansion of macro 'if'
      if (arizona->pdata.micbias[i].discharge)
      ^~
   drivers//mfd/arizona-core.c:1426:32: error: 'struct arizona_micbias' has no member named 'soft_start'
      if (arizona->pdata.micbias[i].soft_start)
                                   ^
   include/linux/compiler.h:160:30: note: in definition of macro '__trace_if'
     if (__builtin_constant_p(!!(cond)) ? !!(cond) :   \
                                 ^~~~
   drivers//mfd/arizona-core.c:1426:3: note: in expansion of macro 'if'
      if (arizona->pdata.micbias[i].soft_start)
      ^~
   drivers//mfd/arizona-core.c:1426:32: error: 'struct arizona_micbias' has no member named 'soft_start'
      if (arizona->pdata.micbias[i].soft_start)
                                   ^
   include/linux/compiler.h:160:42: note: in definition of macro '__trace_if'
     if (__builtin_constant_p(!!(cond)) ? !!(cond) :   \
                                             ^~~~
   drivers//mfd/arizona-core.c:1426:3: note: in expansion of macro 'if'
      if (arizona->pdata.micbias[i].soft_start)
      ^~
   drivers//mfd/arizona-core.c:1426:32: error: 'struct arizona_micbias' has no member named 'soft_start'
      if (arizona->pdata.micbias[i].soft_start)
                                   ^
   include/linux/compiler.h:171:16: note: in definition of macro '__trace_if'
      ______r = !!(cond);     \
                   ^~~~
   drivers//mfd/arizona-core.c:1426:3: note: in expansion of macro 'if'
      if (arizona->pdata.micbias[i].soft_start)
      ^~
   drivers//mfd/arizona-core.c:1429:32: error: 'struct arizona_micbias' has no member named 'bypass'
      if (arizona->pdata.micbias[i].bypass)
                                   ^
   include/linux/compiler.h:160:30: note: in definition of macro '__trace_if'
     if (__builtin_constant_p(!!(cond)) ? !!(cond) :   \
                                 ^~~~
   drivers//mfd/arizona-core.c:1429:3: note: in expansion of macro 'if'
      if (arizona->pdata.micbias[i].bypass)

vim +/if +1408 drivers//mfd/arizona-core.c

3cc72986 Mark Brown 2012-06-19  1392  				   ARIZONA_CLK_32K_SRC_MASK,
3cc72986 Mark Brown 2012-06-19  1393  				   arizona->pdata.clk32k_src - 1);
767c6dc0 Mark Brown 2013-03-19  1394  		arizona_clk32k_enable(arizona);
3cc72986 Mark Brown 2012-06-19  1395  		break;
3cc72986 Mark Brown 2012-06-19  1396  	case ARIZONA_32KZ_NONE:
3cc72986 Mark Brown 2012-06-19  1397  		regmap_update_bits(arizona->regmap, ARIZONA_CLOCK_32K_1,
3cc72986 Mark Brown 2012-06-19  1398  				   ARIZONA_CLK_32K_SRC_MASK, 2);
3cc72986 Mark Brown 2012-06-19  1399  		break;
3cc72986 Mark Brown 2012-06-19  1400  	default:
3cc72986 Mark Brown 2012-06-19  1401  		dev_err(arizona->dev, "Invalid 32kHz clock source: %d\n",
3cc72986 Mark Brown 2012-06-19  1402  			arizona->pdata.clk32k_src);
3cc72986 Mark Brown 2012-06-19  1403  		ret = -EINVAL;
59db9691 Mark Brown 2012-07-09  1404  		goto err_reset;
3cc72986 Mark Brown 2012-06-19  1405  	}
3cc72986 Mark Brown 2012-06-19  1406  
3d91f828 Mark Brown 2013-01-29  1407  	for (i = 0; i < ARIZONA_MAX_MICBIAS; i++) {
544c7aad Mark Brown 2013-01-29 @1408  		if (!arizona->pdata.micbias[i].mV &&
544c7aad Mark Brown 2013-01-29  1409  		    !arizona->pdata.micbias[i].bypass)
3d91f828 Mark Brown 2013-01-29  1410  			continue;
3d91f828 Mark Brown 2013-01-29  1411  
544c7aad Mark Brown 2013-01-29  1412  		/* Apply default for bypass mode */
544c7aad Mark Brown 2013-01-29  1413  		if (!arizona->pdata.micbias[i].mV)
544c7aad Mark Brown 2013-01-29  1414  			arizona->pdata.micbias[i].mV = 2800;
544c7aad Mark Brown 2013-01-29  1415  
3d91f828 Mark Brown 2013-01-29  1416  		val = (arizona->pdata.micbias[i].mV - 1500) / 100;

:::::: The code at line 1408 was first introduced by commit
:::::: 544c7aadd7d4309ed01fcd787d393db67eb7eaea mfd: arizona: Support configuring MICBIASes into bypass mode

:::::: TO: Mark Brown <broonie-yzvPICuk2AATkU/dhu1WVueM+bqZidxxQQ4Iyu8u01E@public.gmane.org>
:::::: CC: Samuel Ortiz <sameo-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation

--C7zPtVaVf+AK4Oqc
Content-Type: application/gzip
Content-Disposition: attachment; filename=".config.gz"
Content-Transfer-Encoding: base64

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
Tm7k3MIm0xeq/weEQKoeYpUBAA==

--C7zPtVaVf+AK4Oqc--
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
