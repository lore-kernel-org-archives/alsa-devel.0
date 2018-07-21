From: kbuild test robot <lkp@intel.com>
Subject: Re: [PATCH] ASoC: da7219: Allow pdata to specify a
	VDDIO
Date: Sat, 21 Jul 2018 11:37:52 +0800
Message-ID: <201807211137.jmWeBTni%fengguang.wu@intel.com>
References: <20180721001235.164891-1-djkurtz@chromium.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
 by alsa0.perex.cz (Postfix) with ESMTP id 94978267762
 for <alsa-devel@alsa-project.org>; Sat, 21 Jul 2018 05:38:09 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <20180721001235.164891-1-djkurtz@chromium.org>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
Cc: "moderated list:SOUND" <alsa-devel@alsa-project.org>, Support Opensource <support.opensource@diasemi.com>, Liam Girdwood <lgirdwood@gmail.com>, open list <linux-kernel@vger.kernel.org>, Takashi Iwai <tiwai@suse.com>, Daniel Kurtz <djkurtz@chromium.org>, Akshu Agrawal <akshu.agrawal@amd.com>, Mark Brown <broonie@kernel.org>, kbuild-all@01.org, Dylan Reid <dgreid@chromium.org>, Jimmy Cheng-Yi Chiang <cychiang@google.com>
List-Id: alsa-devel@alsa-project.org

Hi Daniel,

Thank you for the patch! Perhaps something to improve:

[auto build test WARNING on asoc/for-next]
[also build test WARNING on v4.18-rc5 next-20180720]
[if your patch is applied to the wrong git tree, please drop us a note to help improve the system]

url:    https://github.com/0day-ci/linux/commits/Daniel-Kurtz/ASoC-da7219-Allow-pdata-to-specify-a-VDDIO/20180721-082411
base:   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next
reproduce:
        # apt-get install sparse
        make ARCH=x86_64 allmodconfig
        make C=1 CF=-D__CHECK_ENDIAN__


sparse warnings: (new ones prefixed by >>)

   sound/soc/codecs/da7219.c:440:44: sparse: cast to restricted __le16
   sound/soc/codecs/da7219.c:461:13: sparse: incorrect type in assignment (different base types) @@    expected unsigned short [unsigned] [usertype] val @@    got  short [unsigned] [usertype] val @@
   sound/soc/codecs/da7219.c:461:13:    expected unsigned short [unsigned] [usertype] val
   sound/soc/codecs/da7219.c:461:13:    got restricted __le16 [usertype] <noident>
   sound/soc/codecs/da7219.c:817:57: sparse: dubious: x & !y
   sound/soc/codecs/da7219.c:1427:16: sparse: incorrect type in assignment (different base types) @@    expected unsigned short [unsigned] [usertype] offset @@    got  short [unsigned] [usertype] offset @@
   sound/soc/codecs/da7219.c:1427:16:    expected unsigned short [unsigned] [usertype] offset
   sound/soc/codecs/da7219.c:1427:16:    got restricted __le16 [usertype] <noident>
>> sound/soc/codecs/da7219.c:1637:61: sparse: incorrect type in argument 3 (different base types) @@    expected char const **val @@    got uchar const **val @@
   sound/soc/codecs/da7219.c:1637:61:    expected char const **val
   sound/soc/codecs/da7219.c:1637:61:    got unsigned int *<noident>
   sound/soc/codecs/da7219.c: In function 'da7219_fw_to_pdata':
   sound/soc/codecs/da7219.c:1637:53: error: passing argument 3 of 'device_property_read_string' from incompatible pointer type [-Werror=incompatible-pointer-types]
     if (!device_property_read_string(dev, "dlg,vddio", &of_val32))
                                                        ^
   In file included from include/linux/acpi.h:28:0,
                    from sound/soc/codecs/da7219.c:14:
   include/linux/property.h:49:5: note: expected 'const char **' but argument is of type 'u32 * {aka unsigned int *}'
    int device_property_read_string(struct device *dev, const char *propname,
        ^~~~~~~~~~~~~~~~~~~~~~~~~~~
   cc1: some warnings being treated as errors

vim +1637 sound/soc/codecs/da7219.c

  1607	
  1608	static struct da7219_pdata *da7219_fw_to_pdata(struct snd_soc_component *component)
  1609	{
  1610		struct device *dev = component->dev;
  1611		struct da7219_pdata *pdata;
  1612		const char *of_str;
  1613		u32 of_val32;
  1614	
  1615		pdata = devm_kzalloc(dev, sizeof(*pdata), GFP_KERNEL);
  1616		if (!pdata)
  1617			return NULL;
  1618	
  1619		pdata->wakeup_source = device_property_read_bool(dev, "wakeup-source");
  1620	
  1621		pdata->dai_clks_name = "da7219-dai-clks";
  1622		if (device_property_read_string(dev, "clock-output-names",
  1623						&pdata->dai_clks_name))
  1624			dev_warn(dev, "Using default clk name: %s\n",
  1625				 pdata->dai_clks_name);
  1626	
  1627		if (device_property_read_u32(dev, "dlg,micbias-lvl", &of_val32) >= 0)
  1628			pdata->micbias_lvl = da7219_fw_micbias_lvl(dev, of_val32);
  1629		else
  1630			pdata->micbias_lvl = DA7219_MICBIAS_2_2V;
  1631	
  1632		if (!device_property_read_string(dev, "dlg,mic-amp-in-sel", &of_str))
  1633			pdata->mic_amp_in_sel = da7219_fw_mic_amp_in_sel(dev, of_str);
  1634		else
  1635			pdata->mic_amp_in_sel = DA7219_MIC_AMP_IN_SEL_DIFF;
  1636	
> 1637		if (!device_property_read_string(dev, "dlg,vddio", &of_val32))
  1638			pdata->vddio = of_val32;
  1639	
  1640		return pdata;
  1641	}
  1642	

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
