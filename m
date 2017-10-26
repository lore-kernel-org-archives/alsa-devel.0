From: kbuild test robot <fengguang.wu@intel.com>
Subject: [asoc:for-next 16/17]
 sound/soc/codecs/rt5651.c:1874:20: error: redefinition of 'rt5651_irq'
Date: Fri, 27 Oct 2017 01:29:23 +0800
Message-ID: <201710270113.tr5kwuZt%fengguang.wu@intel.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="pWyiEgJYm5f9v55/"
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
 by alsa0.perex.cz (Postfix) with ESMTP id DF6A7266AF8
 for <alsa-devel@alsa-project.org>; Thu, 26 Oct 2017 19:30:19 +0200 (CEST)
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


--pWyiEgJYm5f9v55/
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next
head:   2708a8339e928912307fe5cd1ae66d959caa7279
commit: b16351eba5e00bd7957fb16b98a152e5425ceb74 [16/17] Merge remote-tracking branches 'asoc/topic/sgtl5000', 'asoc/topic/stm32', 'asoc/topic/tas571x', 'asoc/topic/tfa9879' and 'asoc/topic/ts3a277e' into asoc-next
config: xtensa-allyesconfig (attached as .config)
compiler: xtensa-linux-gcc (GCC) 4.9.0
reproduce:
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        git checkout b16351eba5e00bd7957fb16b98a152e5425ceb74
        # save the attached .config to linux build tree
        make.cross ARCH=xtensa 

All error/warnings (new ones prefixed by >>):

>> sound/soc/codecs/rt5651.c:1874:20: error: redefinition of 'rt5651_irq'
    static irqreturn_t rt5651_irq(int irq, void *data)
                       ^
   sound/soc/codecs/rt5651.c:1787:20: note: previous definition of 'rt5651_irq' was here
    static irqreturn_t rt5651_irq(int irq, void *data)
                       ^
>> sound/soc/codecs/rt5651.c:1884:12: error: redefinition of 'rt5651_jack_detect'
    static int rt5651_jack_detect(struct snd_soc_codec *codec, int jack_insert)
               ^
   sound/soc/codecs/rt5651.c:1797:12: note: previous definition of 'rt5651_jack_detect' was here
    static int rt5651_jack_detect(struct snd_soc_codec *codec, int jack_insert)
               ^
>> sound/soc/codecs/rt5651.c:1920:13: error: redefinition of 'rt5651_jack_detect_work'
    static void rt5651_jack_detect_work(struct work_struct *work)
                ^
   sound/soc/codecs/rt5651.c:1833:13: note: previous definition of 'rt5651_jack_detect_work' was here
    static void rt5651_jack_detect_work(struct work_struct *work)
                ^
>> sound/soc/codecs/rt5651.c:1949:5: error: redefinition of 'rt5651_set_jack_detect'
    int rt5651_set_jack_detect(struct snd_soc_codec *codec,
        ^
   sound/soc/codecs/rt5651.c:1862:5: note: previous definition of 'rt5651_set_jack_detect' was here
    int rt5651_set_jack_detect(struct snd_soc_codec *codec,
        ^
   In file included from include/linux/linkage.h:6:0,
                    from include/linux/kernel.h:6,
                    from include/linux/list.h:8,
                    from include/linux/module.h:9,
                    from sound/soc/codecs/rt5651.c:12:
>> include/linux/export.h:67:20: error: redefinition of '__kstrtab_rt5651_set_jack_detect'
     static const char __kstrtab_##sym[]    \
                       ^
   include/linux/export.h:100:25: note: in expansion of macro '___EXPORT_SYMBOL'
    #define __EXPORT_SYMBOL ___EXPORT_SYMBOL
                            ^
   include/linux/export.h:107:2: note: in expansion of macro '__EXPORT_SYMBOL'
     __EXPORT_SYMBOL(sym, "_gpl")
     ^
>> sound/soc/codecs/rt5651.c:1959:1: note: in expansion of macro 'EXPORT_SYMBOL_GPL'
    EXPORT_SYMBOL_GPL(rt5651_set_jack_detect);
    ^
   include/linux/export.h:67:20: note: previous definition of '__kstrtab_rt5651_set_jack_detect' was here
     static const char __kstrtab_##sym[]    \
                       ^
   include/linux/export.h:100:25: note: in expansion of macro '___EXPORT_SYMBOL'
    #define __EXPORT_SYMBOL ___EXPORT_SYMBOL
                            ^
   include/linux/export.h:107:2: note: in expansion of macro '__EXPORT_SYMBOL'
     __EXPORT_SYMBOL(sym, "_gpl")
     ^
   sound/soc/codecs/rt5651.c:1872:1: note: in expansion of macro 'EXPORT_SYMBOL_GPL'
    EXPORT_SYMBOL_GPL(rt5651_set_jack_detect);
    ^
   include/linux/export.h:70:36: error: redefinition of '__ksymtab_rt5651_set_jack_detect'
     static const struct kernel_symbol __ksymtab_##sym  \
                                       ^
   include/linux/export.h:100:25: note: in expansion of macro '___EXPORT_SYMBOL'
    #define __EXPORT_SYMBOL ___EXPORT_SYMBOL
                            ^
   include/linux/export.h:107:2: note: in expansion of macro '__EXPORT_SYMBOL'
     __EXPORT_SYMBOL(sym, "_gpl")
     ^
>> sound/soc/codecs/rt5651.c:1959:1: note: in expansion of macro 'EXPORT_SYMBOL_GPL'
    EXPORT_SYMBOL_GPL(rt5651_set_jack_detect);
    ^
   include/linux/export.h:70:36: note: previous definition of '__ksymtab_rt5651_set_jack_detect' was here
     static const struct kernel_symbol __ksymtab_##sym  \
                                       ^
   include/linux/export.h:100:25: note: in expansion of macro '___EXPORT_SYMBOL'
    #define __EXPORT_SYMBOL ___EXPORT_SYMBOL
                            ^
   include/linux/export.h:107:2: note: in expansion of macro '__EXPORT_SYMBOL'
     __EXPORT_SYMBOL(sym, "_gpl")
     ^
   sound/soc/codecs/rt5651.c:1872:1: note: in expansion of macro 'EXPORT_SYMBOL_GPL'
    EXPORT_SYMBOL_GPL(rt5651_set_jack_detect);
    ^
   sound/soc/codecs/rt5651.c:1833:13: warning: 'rt5651_jack_detect_work' defined but not used [-Wunused-function]
    static void rt5651_jack_detect_work(struct work_struct *work)
                ^
--
   sound/soc//codecs/rt5651.c:1874:20: error: redefinition of 'rt5651_irq'
    static irqreturn_t rt5651_irq(int irq, void *data)
                       ^
   sound/soc//codecs/rt5651.c:1787:20: note: previous definition of 'rt5651_irq' was here
    static irqreturn_t rt5651_irq(int irq, void *data)
                       ^
   sound/soc//codecs/rt5651.c:1884:12: error: redefinition of 'rt5651_jack_detect'
    static int rt5651_jack_detect(struct snd_soc_codec *codec, int jack_insert)
               ^
   sound/soc//codecs/rt5651.c:1797:12: note: previous definition of 'rt5651_jack_detect' was here
    static int rt5651_jack_detect(struct snd_soc_codec *codec, int jack_insert)
               ^
   sound/soc//codecs/rt5651.c:1920:13: error: redefinition of 'rt5651_jack_detect_work'
    static void rt5651_jack_detect_work(struct work_struct *work)
                ^
   sound/soc//codecs/rt5651.c:1833:13: note: previous definition of 'rt5651_jack_detect_work' was here
    static void rt5651_jack_detect_work(struct work_struct *work)
                ^
   sound/soc//codecs/rt5651.c:1949:5: error: redefinition of 'rt5651_set_jack_detect'
    int rt5651_set_jack_detect(struct snd_soc_codec *codec,
        ^
   sound/soc//codecs/rt5651.c:1862:5: note: previous definition of 'rt5651_set_jack_detect' was here
    int rt5651_set_jack_detect(struct snd_soc_codec *codec,
        ^
   In file included from include/linux/linkage.h:6:0,
                    from include/linux/kernel.h:6,
                    from include/linux/list.h:8,
                    from include/linux/module.h:9,
                    from sound/soc//codecs/rt5651.c:12:
>> include/linux/export.h:67:20: error: redefinition of '__kstrtab_rt5651_set_jack_detect'
     static const char __kstrtab_##sym[]    \
                       ^
   include/linux/export.h:100:25: note: in expansion of macro '___EXPORT_SYMBOL'
    #define __EXPORT_SYMBOL ___EXPORT_SYMBOL
                            ^
   include/linux/export.h:107:2: note: in expansion of macro '__EXPORT_SYMBOL'
     __EXPORT_SYMBOL(sym, "_gpl")
     ^
   sound/soc//codecs/rt5651.c:1959:1: note: in expansion of macro 'EXPORT_SYMBOL_GPL'
    EXPORT_SYMBOL_GPL(rt5651_set_jack_detect);
    ^
   include/linux/export.h:67:20: note: previous definition of '__kstrtab_rt5651_set_jack_detect' was here
     static const char __kstrtab_##sym[]    \
                       ^
   include/linux/export.h:100:25: note: in expansion of macro '___EXPORT_SYMBOL'
    #define __EXPORT_SYMBOL ___EXPORT_SYMBOL
                            ^
   include/linux/export.h:107:2: note: in expansion of macro '__EXPORT_SYMBOL'
     __EXPORT_SYMBOL(sym, "_gpl")
     ^
   sound/soc//codecs/rt5651.c:1872:1: note: in expansion of macro 'EXPORT_SYMBOL_GPL'
    EXPORT_SYMBOL_GPL(rt5651_set_jack_detect);
    ^
   include/linux/export.h:70:36: error: redefinition of '__ksymtab_rt5651_set_jack_detect'
     static const struct kernel_symbol __ksymtab_##sym  \
                                       ^
   include/linux/export.h:100:25: note: in expansion of macro '___EXPORT_SYMBOL'
    #define __EXPORT_SYMBOL ___EXPORT_SYMBOL
                            ^
   include/linux/export.h:107:2: note: in expansion of macro '__EXPORT_SYMBOL'
     __EXPORT_SYMBOL(sym, "_gpl")
     ^
   sound/soc//codecs/rt5651.c:1959:1: note: in expansion of macro 'EXPORT_SYMBOL_GPL'
    EXPORT_SYMBOL_GPL(rt5651_set_jack_detect);
    ^
   include/linux/export.h:70:36: note: previous definition of '__ksymtab_rt5651_set_jack_detect' was here
     static const struct kernel_symbol __ksymtab_##sym  \
                                       ^
   include/linux/export.h:100:25: note: in expansion of macro '___EXPORT_SYMBOL'
    #define __EXPORT_SYMBOL ___EXPORT_SYMBOL
                            ^
   include/linux/export.h:107:2: note: in expansion of macro '__EXPORT_SYMBOL'
     __EXPORT_SYMBOL(sym, "_gpl")
     ^
   sound/soc//codecs/rt5651.c:1872:1: note: in expansion of macro 'EXPORT_SYMBOL_GPL'
    EXPORT_SYMBOL_GPL(rt5651_set_jack_detect);
    ^
   sound/soc//codecs/rt5651.c:1833:13: warning: 'rt5651_jack_detect_work' defined but not used [-Wunused-function]
    static void rt5651_jack_detect_work(struct work_struct *work)
                ^

vim +/rt5651_irq +1874 sound/soc/codecs/rt5651.c

b4435130 Carlo Caione 2017-10-20  1786  
80bbe4a3 Carlo Caione 2017-10-20 @1787  static irqreturn_t rt5651_irq(int irq, void *data)
80bbe4a3 Carlo Caione 2017-10-20  1788  {
80bbe4a3 Carlo Caione 2017-10-20  1789  	struct rt5651_priv *rt5651 = data;
80bbe4a3 Carlo Caione 2017-10-20  1790  
80bbe4a3 Carlo Caione 2017-10-20  1791  	queue_delayed_work(system_power_efficient_wq,
80bbe4a3 Carlo Caione 2017-10-20  1792  			   &rt5651->jack_detect_work, msecs_to_jiffies(250));
80bbe4a3 Carlo Caione 2017-10-20  1793  
80bbe4a3 Carlo Caione 2017-10-20  1794  	return IRQ_HANDLED;
80bbe4a3 Carlo Caione 2017-10-20  1795  }
80bbe4a3 Carlo Caione 2017-10-20  1796  
80bbe4a3 Carlo Caione 2017-10-20 @1797  static int rt5651_jack_detect(struct snd_soc_codec *codec, int jack_insert)
80bbe4a3 Carlo Caione 2017-10-20  1798  {
80bbe4a3 Carlo Caione 2017-10-20  1799  	struct snd_soc_dapm_context *dapm = snd_soc_codec_get_dapm(codec);
80bbe4a3 Carlo Caione 2017-10-20  1800  	int jack_type;
80bbe4a3 Carlo Caione 2017-10-20  1801  
80bbe4a3 Carlo Caione 2017-10-20  1802  	if (jack_insert) {
80bbe4a3 Carlo Caione 2017-10-20  1803  		snd_soc_dapm_force_enable_pin(dapm, "LDO");
80bbe4a3 Carlo Caione 2017-10-20  1804  		snd_soc_dapm_sync(dapm);
80bbe4a3 Carlo Caione 2017-10-20  1805  
80bbe4a3 Carlo Caione 2017-10-20  1806  		snd_soc_update_bits(codec, RT5651_MICBIAS,
80bbe4a3 Carlo Caione 2017-10-20  1807  				    RT5651_MIC1_OVCD_MASK |
80bbe4a3 Carlo Caione 2017-10-20  1808  				    RT5651_MIC1_OVTH_MASK |
80bbe4a3 Carlo Caione 2017-10-20  1809  				    RT5651_PWR_CLK12M_MASK |
80bbe4a3 Carlo Caione 2017-10-20  1810  				    RT5651_PWR_MB_MASK,
80bbe4a3 Carlo Caione 2017-10-20  1811  				    RT5651_MIC1_OVCD_EN |
80bbe4a3 Carlo Caione 2017-10-20  1812  				    RT5651_MIC1_OVTH_600UA |
b16351eb Mark Brown   2017-10-26  1813  				    RT5651_PWR_MB_PU |
b16351eb Mark Brown   2017-10-26  1814  				    RT5651_PWR_CLK12M_PU);
b16351eb Mark Brown   2017-10-26  1815  		msleep(100);
b16351eb Mark Brown   2017-10-26  1816  		if (snd_soc_read(codec, RT5651_IRQ_CTRL2) & RT5651_MB1_OC_CLR)
b16351eb Mark Brown   2017-10-26  1817  			jack_type = SND_JACK_HEADPHONE;
b16351eb Mark Brown   2017-10-26  1818  		else
b16351eb Mark Brown   2017-10-26  1819  			jack_type = SND_JACK_HEADSET;
b16351eb Mark Brown   2017-10-26  1820  		snd_soc_update_bits(codec, RT5651_IRQ_CTRL2,
b16351eb Mark Brown   2017-10-26  1821  				    RT5651_MB1_OC_CLR, 0);
b16351eb Mark Brown   2017-10-26  1822  	} else { /* jack out */
b16351eb Mark Brown   2017-10-26  1823  		jack_type = 0;
b16351eb Mark Brown   2017-10-26  1824  
b16351eb Mark Brown   2017-10-26  1825  		snd_soc_update_bits(codec, RT5651_MICBIAS,
b16351eb Mark Brown   2017-10-26  1826  				    RT5651_MIC1_OVCD_MASK,
b16351eb Mark Brown   2017-10-26  1827  				    RT5651_MIC1_OVCD_DIS);
b16351eb Mark Brown   2017-10-26  1828  	}
b16351eb Mark Brown   2017-10-26  1829  
b16351eb Mark Brown   2017-10-26  1830  	return jack_type;
b16351eb Mark Brown   2017-10-26  1831  }
b16351eb Mark Brown   2017-10-26  1832  
b16351eb Mark Brown   2017-10-26  1833  static void rt5651_jack_detect_work(struct work_struct *work)
b16351eb Mark Brown   2017-10-26  1834  {
b16351eb Mark Brown   2017-10-26  1835  	struct rt5651_priv *rt5651 =
b16351eb Mark Brown   2017-10-26  1836  		container_of(work, struct rt5651_priv, jack_detect_work.work);
b16351eb Mark Brown   2017-10-26  1837  
b16351eb Mark Brown   2017-10-26  1838  	int report, val = 0;
b16351eb Mark Brown   2017-10-26  1839  
b16351eb Mark Brown   2017-10-26  1840  	if (!rt5651->codec)
b16351eb Mark Brown   2017-10-26  1841  		return;
b16351eb Mark Brown   2017-10-26  1842  
b16351eb Mark Brown   2017-10-26  1843  	switch (rt5651->pdata.jd_src) {
b16351eb Mark Brown   2017-10-26  1844  	case RT5651_JD1_1:
b16351eb Mark Brown   2017-10-26  1845  		val = snd_soc_read(rt5651->codec, RT5651_INT_IRQ_ST) & 0x1000;
b16351eb Mark Brown   2017-10-26  1846  		break;
b16351eb Mark Brown   2017-10-26  1847  	case RT5651_JD1_2:
b16351eb Mark Brown   2017-10-26  1848  		val = snd_soc_read(rt5651->codec, RT5651_INT_IRQ_ST) & 0x2000;
b16351eb Mark Brown   2017-10-26  1849  		break;
b16351eb Mark Brown   2017-10-26  1850  	case RT5651_JD2:
b16351eb Mark Brown   2017-10-26  1851  		val = snd_soc_read(rt5651->codec, RT5651_INT_IRQ_ST) & 0x4000;
b16351eb Mark Brown   2017-10-26  1852  		break;
b16351eb Mark Brown   2017-10-26  1853  	default:
b16351eb Mark Brown   2017-10-26  1854  		break;
b16351eb Mark Brown   2017-10-26  1855  	}
b16351eb Mark Brown   2017-10-26  1856  
b16351eb Mark Brown   2017-10-26  1857  	report = rt5651_jack_detect(rt5651->codec, !val);
b16351eb Mark Brown   2017-10-26  1858  
b16351eb Mark Brown   2017-10-26  1859  	snd_soc_jack_report(rt5651->hp_jack, report, SND_JACK_HEADSET);
b16351eb Mark Brown   2017-10-26  1860  }
b16351eb Mark Brown   2017-10-26  1861  
b16351eb Mark Brown   2017-10-26  1862  int rt5651_set_jack_detect(struct snd_soc_codec *codec,
b16351eb Mark Brown   2017-10-26  1863  			   struct snd_soc_jack *hp_jack)
b16351eb Mark Brown   2017-10-26  1864  {
b16351eb Mark Brown   2017-10-26  1865  	struct rt5651_priv *rt5651 = snd_soc_codec_get_drvdata(codec);
b16351eb Mark Brown   2017-10-26  1866  
b16351eb Mark Brown   2017-10-26  1867  	rt5651->hp_jack = hp_jack;
b16351eb Mark Brown   2017-10-26  1868  	rt5651_irq(0, rt5651);
3ae08dc0 Bard Liao    2015-12-23  1869  
3ae08dc0 Bard Liao    2015-12-23  1870  	return 0;
3ae08dc0 Bard Liao    2015-12-23  1871  }
b16351eb Mark Brown   2017-10-26  1872  EXPORT_SYMBOL_GPL(rt5651_set_jack_detect);
3ae08dc0 Bard Liao    2015-12-23  1873  
60d5a1a4 Carlo Caione 2017-10-20 @1874  static irqreturn_t rt5651_irq(int irq, void *data)
60d5a1a4 Carlo Caione 2017-10-20  1875  {
60d5a1a4 Carlo Caione 2017-10-20  1876  	struct rt5651_priv *rt5651 = data;
60d5a1a4 Carlo Caione 2017-10-20  1877  
60d5a1a4 Carlo Caione 2017-10-20  1878  	queue_delayed_work(system_power_efficient_wq,
60d5a1a4 Carlo Caione 2017-10-20  1879  			   &rt5651->jack_detect_work, msecs_to_jiffies(250));
60d5a1a4 Carlo Caione 2017-10-20  1880  
60d5a1a4 Carlo Caione 2017-10-20  1881  	return IRQ_HANDLED;
60d5a1a4 Carlo Caione 2017-10-20  1882  }
60d5a1a4 Carlo Caione 2017-10-20  1883  
60d5a1a4 Carlo Caione 2017-10-20 @1884  static int rt5651_jack_detect(struct snd_soc_codec *codec, int jack_insert)
60d5a1a4 Carlo Caione 2017-10-20  1885  {
60d5a1a4 Carlo Caione 2017-10-20  1886  	struct snd_soc_dapm_context *dapm = snd_soc_codec_get_dapm(codec);
60d5a1a4 Carlo Caione 2017-10-20  1887  	int jack_type;
60d5a1a4 Carlo Caione 2017-10-20  1888  
60d5a1a4 Carlo Caione 2017-10-20  1889  	if (jack_insert) {
60d5a1a4 Carlo Caione 2017-10-20  1890  		snd_soc_dapm_force_enable_pin(dapm, "LDO");
60d5a1a4 Carlo Caione 2017-10-20  1891  		snd_soc_dapm_sync(dapm);
60d5a1a4 Carlo Caione 2017-10-20  1892  
60d5a1a4 Carlo Caione 2017-10-20  1893  		snd_soc_update_bits(codec, RT5651_MICBIAS,
60d5a1a4 Carlo Caione 2017-10-20  1894  				    RT5651_MIC1_OVCD_MASK |
60d5a1a4 Carlo Caione 2017-10-20  1895  				    RT5651_MIC1_OVTH_MASK |
60d5a1a4 Carlo Caione 2017-10-20  1896  				    RT5651_PWR_CLK12M_MASK |
60d5a1a4 Carlo Caione 2017-10-20  1897  				    RT5651_PWR_MB_MASK,
60d5a1a4 Carlo Caione 2017-10-20  1898  				    RT5651_MIC1_OVCD_EN |
60d5a1a4 Carlo Caione 2017-10-20  1899  				    RT5651_MIC1_OVTH_600UA |
80bbe4a3 Carlo Caione 2017-10-20  1900  				    RT5651_PWR_MB_PU |
80bbe4a3 Carlo Caione 2017-10-20  1901  				    RT5651_PWR_CLK12M_PU);
80bbe4a3 Carlo Caione 2017-10-20  1902  		msleep(100);
80bbe4a3 Carlo Caione 2017-10-20  1903  		if (snd_soc_read(codec, RT5651_IRQ_CTRL2) & RT5651_MB1_OC_CLR)
80bbe4a3 Carlo Caione 2017-10-20  1904  			jack_type = SND_JACK_HEADPHONE;
80bbe4a3 Carlo Caione 2017-10-20  1905  		else
80bbe4a3 Carlo Caione 2017-10-20  1906  			jack_type = SND_JACK_HEADSET;
80bbe4a3 Carlo Caione 2017-10-20  1907  		snd_soc_update_bits(codec, RT5651_IRQ_CTRL2,
80bbe4a3 Carlo Caione 2017-10-20  1908  				    RT5651_MB1_OC_CLR, 0);
80bbe4a3 Carlo Caione 2017-10-20  1909  	} else { /* jack out */
80bbe4a3 Carlo Caione 2017-10-20  1910  		jack_type = 0;
80bbe4a3 Carlo Caione 2017-10-20  1911  
80bbe4a3 Carlo Caione 2017-10-20  1912  		snd_soc_update_bits(codec, RT5651_MICBIAS,
80bbe4a3 Carlo Caione 2017-10-20  1913  				    RT5651_MIC1_OVCD_MASK,
80bbe4a3 Carlo Caione 2017-10-20  1914  				    RT5651_MIC1_OVCD_DIS);
80bbe4a3 Carlo Caione 2017-10-20  1915  	}
80bbe4a3 Carlo Caione 2017-10-20  1916  
80bbe4a3 Carlo Caione 2017-10-20  1917  	return jack_type;
80bbe4a3 Carlo Caione 2017-10-20  1918  }
80bbe4a3 Carlo Caione 2017-10-20  1919  
80bbe4a3 Carlo Caione 2017-10-20 @1920  static void rt5651_jack_detect_work(struct work_struct *work)
80bbe4a3 Carlo Caione 2017-10-20  1921  {
80bbe4a3 Carlo Caione 2017-10-20  1922  	struct rt5651_priv *rt5651 =
80bbe4a3 Carlo Caione 2017-10-20  1923  		container_of(work, struct rt5651_priv, jack_detect_work.work);
80bbe4a3 Carlo Caione 2017-10-20  1924  
80bbe4a3 Carlo Caione 2017-10-20  1925  	int report, val = 0;
80bbe4a3 Carlo Caione 2017-10-20  1926  
80bbe4a3 Carlo Caione 2017-10-20  1927  	if (!rt5651->codec)
80bbe4a3 Carlo Caione 2017-10-20  1928  		return;
80bbe4a3 Carlo Caione 2017-10-20  1929  
80bbe4a3 Carlo Caione 2017-10-20  1930  	switch (rt5651->pdata.jd_src) {
80bbe4a3 Carlo Caione 2017-10-20  1931  	case RT5651_JD1_1:
80bbe4a3 Carlo Caione 2017-10-20  1932  		val = snd_soc_read(rt5651->codec, RT5651_INT_IRQ_ST) & 0x1000;
80bbe4a3 Carlo Caione 2017-10-20  1933  		break;
80bbe4a3 Carlo Caione 2017-10-20  1934  	case RT5651_JD1_2:
80bbe4a3 Carlo Caione 2017-10-20  1935  		val = snd_soc_read(rt5651->codec, RT5651_INT_IRQ_ST) & 0x2000;
80bbe4a3 Carlo Caione 2017-10-20  1936  		break;
80bbe4a3 Carlo Caione 2017-10-20  1937  	case RT5651_JD2:
80bbe4a3 Carlo Caione 2017-10-20  1938  		val = snd_soc_read(rt5651->codec, RT5651_INT_IRQ_ST) & 0x4000;
80bbe4a3 Carlo Caione 2017-10-20  1939  		break;
80bbe4a3 Carlo Caione 2017-10-20  1940  	default:
80bbe4a3 Carlo Caione 2017-10-20  1941  		break;
80bbe4a3 Carlo Caione 2017-10-20  1942  	}
80bbe4a3 Carlo Caione 2017-10-20  1943  
80bbe4a3 Carlo Caione 2017-10-20  1944  	report = rt5651_jack_detect(rt5651->codec, !val);
80bbe4a3 Carlo Caione 2017-10-20  1945  
80bbe4a3 Carlo Caione 2017-10-20  1946  	snd_soc_jack_report(rt5651->hp_jack, report, SND_JACK_HEADSET);
80bbe4a3 Carlo Caione 2017-10-20  1947  }
80bbe4a3 Carlo Caione 2017-10-20  1948  
80bbe4a3 Carlo Caione 2017-10-20 @1949  int rt5651_set_jack_detect(struct snd_soc_codec *codec,
80bbe4a3 Carlo Caione 2017-10-20  1950  			   struct snd_soc_jack *hp_jack)
80bbe4a3 Carlo Caione 2017-10-20  1951  {
80bbe4a3 Carlo Caione 2017-10-20  1952  	struct rt5651_priv *rt5651 = snd_soc_codec_get_drvdata(codec);
80bbe4a3 Carlo Caione 2017-10-20  1953  
80bbe4a3 Carlo Caione 2017-10-20  1954  	rt5651->hp_jack = hp_jack;
80bbe4a3 Carlo Caione 2017-10-20  1955  	rt5651_irq(0, rt5651);
80bbe4a3 Carlo Caione 2017-10-20  1956  
80bbe4a3 Carlo Caione 2017-10-20  1957  	return 0;
80bbe4a3 Carlo Caione 2017-10-20  1958  }
80bbe4a3 Carlo Caione 2017-10-20 @1959  EXPORT_SYMBOL_GPL(rt5651_set_jack_detect);
80bbe4a3 Carlo Caione 2017-10-20  1960  

:::::: The code at line 1874 was first introduced by commit
:::::: 60d5a1a47b9a8381c08d2263b11ac9c757c87746 ASoC: rt5651: Enable jack detection on JD* pins

:::::: TO: Carlo Caione <carlo@endlessm.com>
:::::: CC: Mark Brown <broonie@kernel.org>

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation

--pWyiEgJYm5f9v55/
Content-Type: application/gzip
Content-Disposition: attachment; filename=".config.gz"
Content-Transfer-Encoding: base64

H4sICJMa8lkAAy5jb25maWcAlFxbc9u4kn6fX6HK7MNu1c7EljOazG75ASRBEUckwRCgZPmF
pdhK4hpHykryzOTfbzd4w410zktift3EpdHoG0D9/NPPM/JyOX7dXZ4eds/P32ef94f9aXfZ
P84+PT3v/3cW8VnO5YxGTP4KzOnT4eWft/9c9ofzbvbu1+t3v179cnpYzFb702H/PAuPh09P
n1+ggafj4aeffwp5HrNlfc9zWkcZuf3eIXeS5kJ7LjeCZvVdmCxJFNUkXfKSySQbGJY0pyUL
62RD2TKRQPh51pJIGSZ1QkTNUr6c19XNfPZ0nh2Ol9l5fxlnW7zzsuW8ZrzgpawzUugcLT25
v72+uuqeIhq3f6VMyNs3b5+fPr79enx8ed6f3/5HlZOM1iVNKRH07a8PSjpvunfhPyHLKpS8
FMNEWfmh3vByNSBBxdJIMmiJ3kkSpLQWMDygg4B/ni3Vgj3jEF++DSIPSr6iec3zWmSF1nrO
ZE3zNUgDh5wxeXsz7wdUciFgWFnBUnr7RhuoQmpJhRyaSnlI0jUtBeO5xgwSIVUq64QLidO/
ffOfh+Nh/189g9gQbUBiK9asCB0A/w9lOuAFF+yuzj5UtKJ+1HmlmU9GM15uayIlCZOBGCck
j1KtqUrQlAXDM6lA5zspw6rMzi8fz9/Pl/3XQcqdVuKiiYRvXH1FSpiwwlzgiGeE5SYmWOZj
qhNGS9Tdrdt4Jhhyel+LaFAt/eNRpFi4xBDWdEXXNJeim7h8+ro/nX1zlyxcgX5RmLemFbB9
knvUmIzn+iYFsIA+eMRCz6Zq3mLGeihseExg28NWEjXuhLIfX1hUb+Xu/OfsAgOd7Q6Ps/Nl
dznPdg8Px5fD5enw2RoxvFCTMORVLlm+NEWnNpmPGIioLkoeUtAnoMtxSr2+GYiSiJWQRAoT
ggVIydZqSBHuPBjj5pDUtMuwmgnfmuTbGmiaYQ0rMBsgeq1ZYXCodywIx922068gtgSTSdN2
db3WE5lySqNa0GUYoE30rLYyaHXA8rm279mq+cNFlHx1u4MtxLDfWCxvr3/vTUHJcrmqBYmp
zXNjK7oIExijUnfNXCxLXhXaWhVkSWsleVoOKNiTcGk9WkZtwMDWosWONIVJV21PA6Y2pJfS
PNcb8IY0IO5om5loVo2wsvZSwljUAZi8DYukZgbBz/nZG7RgkXDA0nDlLRiXlN7rcmrxiK5Z
SHVFagmwEVHbPfrR9U3L2GkuKFzMMnWCh6ueRKQ+1ISGq4KDnqAlAb+rmxvwVaIgsJE1lyBF
neu+GfyS/gwuozQAEJfxnFNpPDd6RyrJrXUG1wXrE9GipCGR+kLYlHo911YPDYmpWyBv5eVL
rQ31TDJoR/CqDHXfXkb18l53TwAEAMwNJL3XVxyAu3uLzq3nd5rUw5oXYFrZPa1jXqp15WVG
ckstLDYBf3iUw3byJIcYh+U80hfO0BLb/GUQnjBcOk3ISyozNLbYOpg4W/w+GEbh4k080ruo
Fl0Bj9hmHqRu3u6FMOCB4GklKUoLdopHED1rAMGl0gTJ1npopOyhHkZqe4SmMVg2Xf9VK3Gl
TyaG/u+sR1BxrZWCG0Jhy5yksaZ4ShA6oIILHYCV8kg3AQuqLTHTtItEayZo9461GVXoqTdf
hKz+ULFypTFC2wEpS6YrAEA0ivR9l5C1En5c9wFR1yaC0Fu9zmAEumsqwuurd52LblOiYn/6
dDx93R0e9jP61/4AsQmBKCXE6AQiq8F3e/tqPMN4j+useaVzU7qtSavAMY2Itd5JKTbXglAM
84mEzGGla6RISeDbhtCSycb9bAQ7LMGRtomBPhigodvAMKEuwTfxbIyakDIC323aRQkpIxr4
GrIQFjMwj0yfD4QNMUuNOA6sYEiVA9AExRtGaq29Bg9RLBIW7wJIokgK2o7GPMTYz5coIi94
SszzJFtWvBJWD2G6shBkJwWzl03Rkg0sDSWN/9L2A6a1GwIqgN6pICWqSZuVmdYVgjfwfiWX
FFNOz4hlAnkDtgd2xB7rZHic8ahKITRHFUXLgsZIW4dlk7WmoKmwYedGu/QOZCkTmFjkCLrL
2BNvqMkEAZsmUF6+GCLFmgOGTBtQHWGIAjIASC5oDCrDcO/EsfD2MAwC9l3RyG+8tIDOi4P9
q1e0zGlal5u7f4u52yDTxQshIX6VP9SHxt4skM3eBxGxWtLO+jdlhZCvf/m4O+8fZ382huzb
6fjp6dlIqJCpHcqtryCj6O02Qk/n6VyxqHBAqrgooqieems6x03tL9roPO/q38dXs0sAmn2Z
0BLWf8RssTzWgxoQIvo/I8pAlynQJN9eWVvB3hs4uBDzEhI5pCr3ws0bPbGfB5Db/e3X2vZ1
yOhathHJd3zM2ciINd17KYar1nCRkGtroBppPvcvncX12+IHuG7e/0hbv13PJ6etTMvtm/OX
3fUbi4quEDIEdxk7Qhc021339Lv70b4FuCGKusBXegoQmNloGkQk1qkQnIaCwW79UBl1uC7o
D8TSCxpFrSFDkHQJSaUnecBibeTCYKO5lKY7dWkwq41JD7MICLTxTKVJ2wTSAWrxwcWyD3an
GBbpJSwlH3DHvCC9DSt2p8sTVqJn8vu3vR5qkVIyqbZGtMY8RJsvgbA4HzhGCXVYQQpDxumU
Cn43TmahGCeSKJ6gFnwDCQ0NxzlKJkKmdw5JiWdKXMTemWZsSbwESUrmI2Qk9MIi4sJHwKpZ
xMQKzCzVjQkkqne1qALPK5AOQeewsd4vfC1W8CZ4euprNo0y3ysI2/Hx0js98MqlX4Ki8urK
ioAr8hFo7O0Ai96L9z6Ktn0cIYLKZx8wxXGwNQNu7sBt4aapaPOZePiyx5MKPQthvKlR5Jzr
NesWjSBMw+G4lDDWtig8tFWllqxbyu6AoGvLYyc7lqZR500c28RbXZ9vHj7932DYP0xMQiOu
toFupTo40KcXeKbX7RCRXxtKmavVEwVE1ujKdQvvVMyQHFEINKui4EbBFiNPlbu4tAaG8DxO
yVK49Cwzqrhr2EQqWcAThw2ToT+4VsFSc0hXLwvGzTO1xrqejg/78/l4ml3AuqrS+6f97vJy
0i1t20TXayxifTAWNQrnN/PAOx4P5034I5xhJSTPPNpi8TVHVZ/On95YDFXeZXpmyQjcPM0K
VMbcSBE7fM1TiKlJufWOsuXyjKt7X4XkmkVpAn4MBsE7RCo4ufrn8erq6uZqOI5cq9QO0npI
aagEhiuLoZ3USlClGUYxEU9YjLpLTCDzbgstzomtQQT9hn9LuoRc3ShCtP0BEwtKIiFAsuYF
MmUkVWehXOXaSreCl/Ps+A1dt+61dUMHDxQVPTCyai6LtGqqPshgshNj+QCoaViGDg/ERv+i
+imMwkWRuYjtPjS8q3UMK97RlPcWsL/8imGw4Xb+IeahpOpTKZxrkVniqKPCmnxdSHOSeMBo
zaE7c2yPGf29eeQCyqFKV+2BiMr1TAYhq8BEjIMzBBhfm0BRMgsggkVehfBrSThKEYkSj1LH
aH9++nzY7E77GZBm4RH+EC/fvh1PsBitNQT8y/F8mT0cD5fT8Rm86uzx9PRX41x7Fnp4/HZ8
OlwMrQaZRFZVR0frBostYdAi7k7k++bPfz9dHr74x6CLetPa/iaIbF5/3l2wUOnuu3YPFymR
qGQ1E0Y5xSbfyTkYnCnbrLHGxZL4qgLdgXRvNyLzpKMLiwLOUwcFzw8TOD7vby+X7+LqvyFd
hAGdjsfL7dvH/V9vT7uvvZXHkhXX86yKpRKPz2WgnZJ0iY5gGcaXbgbUElqr3Ze4WviqxgpI
42LeWLRrHw18uTRNMQA1HnJg9RZvpljlOaxpm9FFzlE4ZivtVQiGsbS0CoSqmfaNGmsfqjtf
baRImQRTkfLmNF3cvrPaD3CnG5FqAzQV5tAKcD0Y5B+lM8Ai2Qrl+mrZlGB9J8sgfr1qgXFw
LXlteAn0ezmXLDZOAFZCE1QXSmZY98uwKgr93r67+mNhVbmw8Ar5fFKo017fzQY8DAfzrKqO
K62LMKVgrgmEj3pEyKE54yg5NI5aIamwTGsP6eYBQciFiLjtT8fvzWbvC2Pj3AeVZjXvb2Ke
6s/COehoS7ognsKoCHSsGLJq5gxvdjTH6RiuroxX4hIvSTWRi9aDOvaqrdsTTU0sI3eqSsHL
CFbw+nowbSEpjcOfLGTEfm5iqJDp8oLXGhVpLekvD7vT4+zj6enxsx7NbmmuHyerx5rPbQQs
F09sUDIbARtXy0rPQ1pOLhIW6OOOFr/P/9Ck+X5+9cdcnxdOACNRFBcLjV3T2Vp1RNDrNc2c
eJ7+s394uew+Pu/V1b+ZOrW6aLPHimgmscCv5bNpbB4j4lMdVVnR94UHAgmkXEZc2LYlwpIV
RpjU1Nx55d3dzUsZE6HZIfbXL97xb3B7X3eH3ef91/3h4okj9SDHjeGyvihkk6ICxQhuM+Ij
qDoigcHfXs+vtAZ5URgdGAc/8NxXpVVMpYlp86GNA4fDCucYzX3fcGg5lcYD2PalWdpEkHaY
kmG+v/x9PP35dPjskR7sX73J5rmOGNFkgtUY88likPrJ7V1cZuYTJjBmUVyheC/UgsykTEGi
CkBqKQu3FqFxK9Rmxz0jpFGPUwRWoG8y5bSiWwdw2xVZaDxYk2fGmrCiuZEQEmGivRqWoFFG
UaKAmCEAUwohu2Ugu8YKvK6JJtqkqZZaDqJfA+ppa1oGXFAPJUyJMIJroBR5YT/XURK6IAYW
LlqS0pIvK5iDLNGi0Ky6swloPXO90Nfz+5oISlAoR8iZmpwHmpRjwTKR1etrH6gZZrHFmIev
GBX2iNa6P0CoivzziXnlAMPchalVNUksgIrCRdztxZpRmQqvQLUV7IEpihdsNhoGquDpc2HW
omyO6QYCSu133X1Uy7DwwShOD1ySjQ9GCHRMyJJr+xubhj+XnlOCnhSw0IOGlR/fQBcbzn0N
JVLfNgMsRvBtoJ+x9/iaLonw4PnaA2LxBpXbQ0p9na5pzj3wlupq18MshWSMM99ootA/qzBa
+mQclLeeMnDgvUrc147bJXBeQ0F7s9OeAUU7yaGE/ApHzicZOk2YZFJimuQAgU3SQXST9NIa
p0XulgAy6pePTw9v9KXJot+Ms2OwaQvzqXVcWNKMfZTaPGJXhOYKILrjOrIN1MIxbwvXvi3G
DdzCtXDYZcYKe+BM31vNq6N2cDGCvmoJF6+YwsWkLdSpSprt5UnrEpSajuFsFCKYdJF6YVwa
RTSPINhWlQC5LahFdAaNoOF9FWJ4sA7xvzzhc3GIVYAn5zbsuvAefKVB12M3/dDlok433hEq
WpIRzbrDYlgHjoDgJzzADJm4/ikP+ppCFm0sFW/dV4pkq5IIiOsyM7UGjpilRiDYQx4PFZQs
gnxbf6v5YAKLlxDgQ453gURp5IutoWVfutCScOIsX02QrG8cXLr1OY/LkOqpVo6XVvNc1RAM
FO/799+cmDA0FNG1v43aWh2d5K6dTsXygxih4ecK8RjRvuBpELvscZyq1GKErpTQalriaCQH
TxIWfooZLWsEEcqRVyC2SpmkI8MgGckjMkKM7TZ7SnIzvxkhMf2UxqB4YnqDDosfMG5e4jdX
OR8VZ1GMjlWQfGz2go29JJ25S88O0mG/PgzkhKaF3xx0HMu0gsTNbCAnzrOqUurGo4VHdGcg
+TRhoDoahCSPeiBsCwcxe90Rs+WLmCNZBEsasZL6rQ/kZTDCu63xku0hesjK1wfcNS0SP9FM
otLEMiqJiZTSfM6rbElzEwstHoHpi3KALq5usjlowKRxUqBatT9nQtAysrL9MtScBNEvZqlJ
oISteRDrLR78ywj+ELNtvoK4IyJqnsIOmLMesr26bmKuTGL9JlwLuIsbVYV3ZcfweBP5cWjc
wXsVvOvVTXnlO1V4Pc8ejl8/Ph32j7P2G2KfR76Ttt/SSWhwJsiCSrvPy+70eX8Z60qScomF
hfZr2AkW9XWVqLJXuHyhj8s1PQuNyxdjuYyvDD0SYTHNkaSv0F8fBB6CqA9iptmMrwW9DNwX
FWoME0MxN6jn3ZxaNsPHE786hDwejew0Jm5Hch4mrKwa9129TBPGfuCS9JUBSdsr+HjwvtU0
yw+pJKTQmT+sNnggq8M7/IW9ab/uLg9fJuyDDBN1aGmmbR4m41M5D93+ItXHklZiJC8ZeCA6
p/nYAnU8eR5sJR2TysDl5lteLsuL+bkmlmpgmlLUlquoJulWFOVhoOvXRT1hqBoGGubTdDH9
PnrN1+U2HnkOLNPr4zlccVlKki+ntRdy8mltSedyupeU5kv9JMTH8qo87HqAS39Fx5o6hVEi
8nDl8Vg+3bNwMb2d+SZ/ZeHsozMfS7IVo3FNx7OSr9oeO+xzOaatf8tDSToWdHQc4Wu2x8pV
PAzcPPf0sUjjFHCEQxU3X+Eq/ZWfgWXSe7QsLJseTHVjFL7a0NB4xqsWt/PfFhbaJBa18asm
FsXYESbRqoQWfQbja7DFzQ1k0qbaQ9p4q0jNPbPuO3XnoEijBGhsss0pwhRtfIpAZLERkbRU
9dmsvaRrYT06VXvErGsPDQj5Ci6guL2etx8QgOmdXU67wxnvQeLngZfjw/F59nzcPc4+7p53
hwe8QHDu70kazTUVAmkdFfeEKhohEMuF6bRRAkn8eLvph+mcuy8i7OGWpd3CxoXS0GFyIfPE
AxG+jp2WAvdFxJwuI2dmwkVoZEP5B2PaIhmfOehYv/TvtXd23749Pz2osvHsy/75m/tmLJ3l
yOPQVsi6oG1Rp237f36gOh3jCVVJVE1e+6UJs2pokxoL7uJdlcfCMaHFH1Jqj6ocaleMcAhY
KHBRVWsY6dq8BhF7W1DFbJsRMYdxZGBNSW1kkj6aArHsU9GSRD4RINErGcjG/M1hvRW/m2Vu
Zc9fjlYUuxKLoFkvBlUCnBWeuxqAt+lQ4seNkFknlIV94KJTpUxtgp+9z1HNgpZBdCuSDdnI
1403hoUZYbAzeWswdsLcTS1fpmMttnkeG2vUI8gukXVlVZKNDUHeXJnfpDY4aL1/XcnYCgFh
mEprV/5a/LuWZWEonWFZTNJgWUx8sCyLW8+m6y3Lwt4/3Qa2CK1dsNDWsphd+1jHGu7MiAm2
JsE7ch/NYy6sdztz4Uy3NRdGILIY29CLsR2tEWjFFu9GaLi6IyQstoyQknSEgONurreOMGRj
g/Qpr06WDsFTi2wpIy2Nmh6d6rM9C78xWHh27mJs6y48Bkzv12/BdI686IvVEQ0P+8sP7GBg
zFUBElwJCaqUGNfKh03ZnI+bmtiembvnNS3BPZNofmnOaqo7eo9rGtj629KAgIeXxr0FjSSd
BTWIhlA1yvureX3jpZCMGx/uaxQ9pNBwNgYvvLhVI9EoZuqmEZwKgUYT0t/9OiX52DRKWqRb
LzEaExiOrfaTXA+pD2+sQaMwruFWyRy8lFkPbG4hhsNdxkbpAZiFIYvOY9reNlQj09yTuPXE
mxF47B0Zl2Ft/HSEQeneGobZ/txVsnv40/iNmO41tx+z5IJPdRQs8cgwNL4QVYTuvpu6Tasu
4OAFtFv9F6jG+PB3SbyX4EbfwG96fV8+Ib87gjFq+3so+go3PRr3T0v9Bxbhwfp1RUSMLBkB
S5by/xm7tua2cSX9V1TzsDWn6mTHutnWVuWBBEkRY4KkCUqi88LSZpQT1zhxKnbOzOyvXzRA
Ut0NyHNSlSj8ugnijkaj0U0c6MKTmcLMV3rcfAgmm+sI3/k0D0bKk7WPWL/IQjFKQQwhAFF1
FVEkbhbXt6sQZjoBn+aouhae/NtNFsVuVi0g+Xsp1uqS+WRL5jzlT4DeEJZbs23R4HdABqZR
mJSGCZuQ7V0WO7A11XIGAbMwQYpChSkXX0kvUu70hzDB5HezvFqGiaq9CxOM8CsLpjyeiPcC
ZcJWiFmM5vchrN/ucZUjgiIEt5LzZ+82RIFVJeaBKDU78mDd3jTUoQm+igM3OaO6LlIKyzqh
6ijz2KelwLurboGmgiKq8VXmvCLluC6qQ42XsQHwe/pIKHMRBK3JepgCUi49cMPUHDv3wAQq
hWOKqmJZEAkPU6FRSN/HRDLfjIStIaSdEWaTJpyd7VtvwlQUyilONVw5mINuBUIc3LQ0TVPo
qutVCOvLYviPdTkqof6jIsjJTxMQyeseZi3h33RrifM8Ypfg+x+nHyez7v4y+HQhS/DA3Yv4
3kuiz9s4AGZa+ChZKkawbrCjmRG151mBrzXMuMGCOgtkQWeB19v0vgigceaD2+CnEu0b5AJu
ftNA4ZKmCZTtPlxmkVd3qQ/fhwoiqoRf9AE4u79MCbRSHih3LQN5CN75s9zFbhsotu++YhST
svu37yNA7t/kGIv4JpOmn2FUIzVklXVAgqfuwTeQK8L7n759evz03H86vrz+NBg+Px1fXh4/
DTprOjpEwerGAJ6acoBbIcsk7XyCnStWPp4dfIycvQ0Ad3g9oH6HtR/T+zqMXgdyQLyyjWjA
ssOVm1mETEnwtR9wq6sgHgGBklo4hDlfRijoBCIJfttywK1RSJBCqhHhbAd/JrRmYg8SRFTK
JEiRteZXaKHgETuIB8Cdnac+viXc28iZUsc+o5KNN28BriNVF4GE3e1pBnIjL5e1lBvwuYQl
r3SL3sVhdsHt+yxKd+Uj6vUjm0DI4mb8pqoCRZdZoNzuboZ/Hdcw24S8LwwEf+YeCBdHtYED
s7HEx3iJQC2ZlBqcy1cQGgXtFMzaGVl3gyFs/O8FIr6MhPCE6CDOeCmCsKJ28jghLndy2plS
1Wm5d75jgiA9v8GEfUc6CXknLVPsuXzvpCOUIefP7u8J/iWQwRCe7rnNWGLzPSD9VleUxxdr
LWoGXeCibolPXnPNBQdbVG400xdLUIOCWQYh3TdtQ596rVg/LIXGrosOMXYu4tzTARvt8Yjg
3ee2m6sOfKU89NSxe4ylLuuxvW3SSJ19emKvAbPX08urJ3/Wdy21cIe9Y1PVZl9RSqKizSPV
RInN9ODF8+Pvp9dZc/zt8XmyMkCGjxHZesGTGRkqAh++ezpzNNi/eONuudtPRN1/L9azr0P+
fzv9+/HjyfecpO4kFqGua2ISGNf3aZvTMf9guiN4OOuzpAvieQA3lephKXYg8RDhlsaDyjxQ
7TwAsaDs/fYwlts8zRJX2oSXFjj3Xur7zoN04UGkLwMgokKACQHcUMTDCWhFSkKMwLzTbuYs
y433jV+j8oPZBkblkmVnV64khTrwAk8zXrsln+XyAjQ5UQnSBPuaEDc3VwEIHJaH4HDiMpPw
i2MZAKz8LNZpdGfdt3Fe/Ws0v7q6CoJ+ZkZCODup0p47nTMugznyucesXiiAoPjdPoIx4vMX
nQ/qKmu9rjWAvTiHizI9XoPDeAi+8On48cR6fC6X83nH6lzUi7UFpyR2Or6YBFSJobN60uA/
Ml6wbh3gHErt4baWPPQWVFYeqkQc+ahzmuzi8eDFHgsFcCqV4vtLcBKSwaoagPqW+I8275Zp
7QEmN/5p1kByNh8BqlAtTSmXCQNIEXosHJtHT4liWRL6jk6LjMa0Q2CfCmxchSkkoh4cL03y
k3Ne+fTj9Pr8/Pr54koC52hliwUIqBDB6rildKJhhQoQMm5JIyPQS20i8GQtQSfEW7BFd1HT
hjBYuMgEj0j5KgiX1Z30Mm8psdB1kBC1+fIuSCm8/Ft4eZBNGqT4VX3+uldJFg9UtcvU9rrr
ghTV7P1qFWpxtfT449pMtD6aBZoyaYu531hL4WHFLqWuz6YWDzTiPiceowOZB6D3+oTfJAdJ
b6/aXlopIqpGmREqG3xANSJM2XyGrf/VvqiwtDVR2Yak6e4i+rU73KhcUB1gMJlpaJwG6D4F
0ZGNSE90BofUXrLDfc1CNEidhXT94DFJLBllW1DsoiZ2CuS59esJnh18Xpi/06ICj4KHqCnN
6qYDTCJt2ikiTl+VuxBTk5qHtCh2RWQkURoThzBBOJfOHgA2wQwNWrnQ675rwpHijmIi6zU4
iUNlaJLId2c9kQ+kVQgM6nfyUiFjVtEjYr7yUIM3lvoiTRC1FCO2dzJEZJ100ODPfcSGScHX
nCdCI8DxJPTf4m1qn7d/w7C/xDG5A3zzQ6M2+Kcvj19fXr+fnvrPrz95jCrF+98JpovuBHv9
AqejR0eRdOtN3jV85S5ALCvncj1AGlybXWqcXhXqMlG3nuvNcxu2F0mV8GJwTTQZa+8ofyLW
l0mqLt6gmVn6MjU/KM8Sg7QgGIN5cyzlEPpyTViGN7LeJsVlomtXP5AZaYPh/kVnwwOew+4c
JNxU+Ys8DgnasFPvb6cFI7uTWIRwz6yfDqAsa+x9YUDBHz6astO239T82YvAMMDUuGMAuUvX
SGb0KcQBL7N9tsyY0J/WObXhGRFwyWSEd57sSAWnyGE9ZpkRw23wbLiV5JATwBILGAMAPuJ9
kMongOb8XZ0nxeSlujwdv8+yx9MTRND78uXH1/EKws+G9R+DwI1vxZoE2ia72dxcRSxZHG4Z
AFgy5ni7DGCGdx0D0MsFq4S6XK9WASjIuVwGINpwZ9hLQEnRVEO0tBAceINIdyPif9ChXntY
OJio36K6XczNL6/pAfVT0a3fVRx2iTfQi7o60N8cGEhlmR2ach0EQ9/crPEZax06hiHnE77X
qBGhxyGJKQ5z/rxtKiuOMc20GeNUyFbRgxugE2HwUc/0eOfo8I8fB3hWcW+uOxc9kt/nJXBv
XYXiCO/7VtV48R6RXrHgDi34eikqvBybmcemnclG2YA9Nho0Es0P1kEzldYHVlmeo80NNCPu
NdHEgV2oj+m4KL28hEFyn0VFQcMsD26T99jP8LjXKIrqcIF2CbUaGLMJwFmZ9DJNqjlq9Q3u
BTMbqwprtC0tcgu244AzxfT9F2Th+KD7/MGUbC91FfYEOLnar3ejbihk+lgJ6kTdSO3kdol7
7iOxufFAMq4GjIzjCVM+eJh7kFJ4ZR0/0iALCQjvp3PTIRIIA56R2jakLC1Fyj052JCA5/hI
yenT8ceTi+fw+K8fzz9eZl9OX56//zU7fj8dZy+P/3f6H6T4gw9C5GLlHBjMrz2KNnOAGt0b
nINRYjI4PQeboW043AdNSoYjsFOmKBTw0bqHh6A21kDs9hxyxVs+7+3hQyyxT1sJUyB4nSb9
wfyU3IV7A+E+mL8z1SbkwfZibfosgkyzgb9gG/OKvjqRnG22DTZgwx68m19MwEbwMUw0rLbP
BqtnVWILcuDB8bdYXqoshEbNTQiOhbpedt1EYgHqvh2/v9DDJvOO01qYfjrpnneGaaacayAb
RriF+7dPTgQqjn95ScTFnRnUPC8sDlVL5AP+1Df4ugelN1lCX9c6S4jva0q21VbVLD80NMFQ
chftzAxgdz461kATqV+aSv2SPR1fPs8+fn78Fjiog3bLJE3y1zRJhZsgCW7mvz4Am/ft+bcL
1Kp9YlkN2T6HgBwosVnTzDD3IkJ4jMUFRsa2TSuVtg3rmDDnxVF5Z/Y6idnyzd+kLt6krt6k
3r793es3ycuFX3NyHsBCfKsAxnJDvIpPTKDwJeqhqUWVEbwSHzeCSuSju1ayvtvgo1cLVAyI
Yu2sbm1vVcdv3+AS/NBFIaaC67PHjxA7jXXZCmbWbgyqwfoc+NxQ3jhxoOf/DNNM2RoIBXZ7
Zf+EWIq0fB8kQEvahjyHtMFkHGeA4jYEddSSqNqMY5tCuEc2E4j14kokrJRGDLYEtnDo9fqK
YeRY0AH0FPKM9VFZlQ+KROW284HZ3btwLwS2farfN2bcMwocmHr9opgcMI1dQZ+ePr0DYeJo
/bsZpsuGBpCqEus1GygO60FzhsMrIBJXrRgKBEjPCuILj8D9oZHO7z9xykZ5vGGmFuv6llW+
Enm9WN4t1mxK0GYDuGYDSRdeldW5B5m/HDPPfVu1UeEUQDYkD6WmjQ3LDNT54hYnZ9e9hZNA
nIz3+PL7u+rrOwFD8pIhhK2JSmzxxTrnFcqI3+r9fOWjLQqJBP3X7IL6VAjWqweURosYKQHe
WOQXUvAoZt3lllDTC0kKEQ0vEvwxhIlJG6ANCjGyvllCZecQcDIGe7wLS5zlZCFzJtxsIHHI
j3N2pL6rSpFLPlVQolvZA96R3+Idgiv+PSsETHw7yThu7fAKcZkutQrgIspC7PAPUVmh2lfy
UpfxjTnObdOVkQ7g++x6fkX1fBPNzARZIbhAZ0m51HJ9FSoQuU9k1+wy9bM7gMM81AdqbeQY
NqxhojdRjYRFB422ddOJHfxFbVp69l/udzEzq8K4wQtOyJaNpn1vw6QFhEezufXXCdXezv/8
08cHZqvTWVm/0xDCE8nQhh7pGuKI0bgyNVgIJXYre7+LErKjBmKmizAB2qrXGUsLdGbmN2PM
ulXLhZ8O5HwX+0B/KCAceKpzCCHGpmfLEKfxcFt4ccVpYNPvCTlAAEfGoa+xrUzSokJh6cTI
G7tSttTaw4AQvDRpY01ACLZH/ewaMI2a4iFMSh7KSElBEx6mkQBGZ1iDE9VFlVEvUeZZkZN4
2HayBGxsTJaI+VLa7GH/hC+2OAIo9QlWmWFH4iuaDdhwhHqOJOagfqtDYTdGatTd3t5srr2U
erMWr3y0hO03tmdw8RQ9oC93pqVifCtvpIDlmNYwvmS9XFj7jCnPH8x4DwUSG15NIrG5vvKT
3Lk6m5IZcVEdhnX1jUQLEjkbozaSoIsQecvp9ji5Cr+bNDGaLeGpHyJdW0sJLyi4rS/8yhSl
srv1QSJhIXDI6VmThWme8IWJCT6KE0kDRq13rUj2yQV4UNLpc7VQ8oGpyiMIuwcKT3LHd7AF
J53kjJm9BbaXnvIbqqdGYzOfcq9SZvEx1fKe+NgDxiyKGxJLzKLs3M8yCgY4pxdBkHUqTAmk
PFAufMDgQ2pui/r48tFX/JlNrIZA0oXUy2J/tcAmNsl6se76pK7aIEjVvZhAFpBkp9QDnbXq
PCpbvKF2my4ljSCDI5joLYQCFmg6aWWmWBNZ6Kbr8BV8oTfLhV5dzXFXUuYTGl93NCtqUeld
AyrUhhlL5nUvCzQZWwWpqGQJJzco1TrRm9urRUQCdOlisbnC164dgje2Y723hmK2tz4hzufE
vHjE7Rc32K4sV+J6uUZ6lUTPr28XuIZgArxZz0koSfDuiQMxg83gcE8j09FmhXd9sBia+jF7
kHo5RClGOSMTyyDBFLXoRdsUQYK9YI/zgmIg05VbLIbVyUWuTI0MpnxPgw43TbxAXeUMrj2w
SLcRdn06wCrqrm9vfPbNUnTXAbTrVj4sk7a/3eR1qvHkGN8YYZtF0LQYP5o/g6bG9E5Naklb
A+3pz+PLTIJ5zg8Ievkye/l8/H76DflnfHr8epr9Zgb74zf477mWWpDx/A4FI5+OWEJxg9zd
ngB3PMeZDeX86fH7lz8gTvZvz398tZ4gnSN7dF0DbH0j0ErVxZiC/Pp6epoZEcqeQrgd+HiC
qYXMAvC+qgPoOaEcYnFfIgqI7hr4zEX+52/fn0Fh9/x9pl+Pr6eZOscX/VlUWv2DH7xC/qbk
xsUor7SZsIlVUypysncWXQEXTy8cABlilO3G476qDgchA7ZCxl6EV1gBR6WTN1iA2JMLeE1k
Jl4Qd/FmhCyi9h2y/lik5FFNXNr3fuxSS7DnRGfzaZvLIXuz17++nWY/m277+z9nr8dvp3/O
RPLODKd/IGPqUbjB0kXeOKz1sUoTi+/x7SaEQRy3BG/YpoS3AQxrYWzJppWE4cJG6iXnYhYv
qu2W9A6LansnBs55SRW149B+YY1oN4x+s5l1PwhL+2+IoiN9ETf9S0fhF3h3ANT2fGI370hN
HfxCUR2c2RZaKgGn/mItZE/w9IPOeBqi28ZLxxSgrIKUuOwWFwmdqcEKC4HpgrGOHWd56Dvz
x44gllBea14/hnvTYYFzRP0KjqiVt8MiEfhOJMUNSXQA4EBT24Dk7rAf3cQeOWDnCDYPZkPY
K/1+jQ4NRha3EKUlDR5JqSrSd++9N8Ge2BmfgTF0yecCYNvwbG/+Ntubv8/25s1sb97I9uY/
yvZmxbINAF/GXReQblBcgOnu3k2de5/dYsH0HaU15ShSnlG13ylvAq9BZq94kUBnasYVhxuh
8Fzp5jnzwQVWaxk5yq4eZXogtz4nAr5PdAYjWcRVF6BwwWwiBOqlbpdBdAG1Yi1Ht+RkAL/1
Fn0RmO9U1LT1Pa/QXaZzwQekAwONawh9chBmbgsT7VueHtd7NcyRg5xILdTxttA+4jmNPrlC
lli1NUHDcPGm3UR1y/lmzouf7VrYUbkI5XwFqr01qZTEenYEI2Kg6fLSpnzq1A9qvRS3Zvgt
LlLA2mfQx8ENQXvZYn6Jd4yGGm2xZQ/jgq5jOa5XlziUX6aajyWDcMukCafWZBa+NzKDaQzT
X3nF3BcRUQG0QgG2IKsCAoNzCSTCFrn7NKFP2XvihQ+W7zoL6Qhd/xDLzfpPPqtAFW1uVgwu
db3kTXhIbuYb3uKhrNcqtC7W6vYK7//d6p7RqrIgt+B2okOeFlpWoXEyyizemfN43pxH8/Wi
O5s6DXg2jAmOl7L8NXICNye5Rvdg19PgUPwLrR0ulyZ53yQRL7BB89rs9X04VQHeqNhxSabS
iRu61OnqRNsVvDkATeyKareXfAxaMm1bJ19O/Q1UgaUTpxMjGwV6HXCMVz/SpiEZA1qtJl2Y
eP76+v356QlMNf54fP1skvr6TmfZ7Ovx1Wzlzld+kcQNSUTEaH2CApOyhaXqGCLSfcSgDs65
GHZfNdiplv0QN6OwoEHE/HrR8UyB+BjKrZYF1pFYKMum7YapgY+8aj7+eHl9/jIz82ioWurE
bDbozhASvdetV/+6Y1+OVXI2wwSWcAYsG9IrQFNKyYtslkcf6asi6f3cAYXPJCO+DxHgABhM
ZBis9gwoOQAaIalThjYi8ioHWyANiObI/sCQXcEbeC95YfeyNWvf5AKj/k/rubYdCX/AIfjO
p0OaSIOTg8zDW6Lls1hrWs4H69vrm46hZiNwvfJAvSb2QRO4DILXHHyo6WGdRc2q3zDIiFPL
a/42gF42AewWZQhdBkHaHy1BtreLOee2IP/ar/b+B/+akU73RC1t0TJtRQCF1QYvtg7Vtzer
+ZqhZvTQkeZQI2r6ZTATweJq4VUPzA9VwbsM+H0hWw6HYotSi2gxX1zxliXqF4fAAWgDYbV5
kmZYXd96CUjO1lY6lzEvUtvIrEh5icgIs8hBlnFVTsZGtazePX99+ouPMja0bP++olsB15qB
OnftwwtSkdMSV99cJrGgtzy517NLlObD4FCE3C35dHx6+t/jx99nv8yeTv86fgwYULiFitlt
2CS9nV3gOA5jyqxfuxbi0RPf3AYGM208YFVi9S9XHjL3EZ9pRazYkiFAW4TPG9VwDEty7wdD
jNnhpXvmC82ADvpCb2M/HQUra0vVysCRb4Kay/CF9K0GZgnbBDMs5448zrYCggBE27Tp4YHo
Jhmf9evn39qF9CUYyUiN5ycD12ljRlwLd4ESojQ0NHsaThBdRrXOKwq2ubTG23tpZPKSf5fV
+4iYXTu5KQIGg7TiJJUSDQRe/uGekK7ZlRGm4jPAh7ShlRnoORjtsW8tQtC84YiFhkHcLS0C
ZUVEfOIZCCyq2hDUZ9jjDtQx8+s2FNzaYmkCw8Hs1kv2A9jrn5EpSC85ljUbTsmsdgDLZJHi
XghYTTeeAEEjoEUKDrJj2+/Y2blNEofQcupjxoVRpxVGQlJce/zZThNjC/dMT8kGDH98ZMP6
owEL6JsGCjGzGzDiQW/EpjMDd2iVpulsvvx/yr6tyXEbWfOv1NOGJ/ZMmBeRoh78QJGUxC7e
mqAkVr0wyt01dsW2uxzV3ed49tcvEiApZCJRnn2wu/R9IO6XBJDI3G3ufjq8vD1f5X//sC97
DmVfYHspCzK1aHewwrI6AgZGqko3tBXYLqNldKguSxSA6lfIdRMPZ9AWuP0sPp6lCPpIDZKi
FqdGhYfCvI9eEHXyA6440hzbR8QB+vbc5H27LxtnCLkBbZ0JpNlQXgroqtTi6i0MvEfcpxVo
qhoVlWbYuiYAA/brhAPI34gnhhepscUj0phMM2FOCiArys11S968zpit+KZcFVJjsIDAldfQ
yz9Qkw22h/ThbOQVlUMy00V1lb4VAhl8unB6QKhrNhU1CzldTGO74tzIjTQ8T7hhaY/tz+vf
kxQ9fRv0IhtEpvhmDBmNX7C23nl//eXCzWlxibmUsygXXorF5j6IEFiqpKSptAROGvQtMwXx
QAQIXcrNXiHSEkNFYwP2yY6GZUPDq+DeHI0Lp+BpGCc/vr7DJu+Rm/fIwEn27ybav5do/16i
vZ0oTKTachHGHy1nHY+qTex6bMoM3v2woNI0lh2+dLNlPmy3sk/jEAoNTJUiE+WysXJ9dpmQ
lWjE8hlK630qRIru3zHOJXlq+/LRHOsGyGYxpb+5UHIzVMhRUvCoKoB14YZCDHCHCI/4bvcH
iNdpeijTJLVT4agoORe3hoXD8mCo/VhbMWUmBBnuU4hS9cYWU2/4g2lSWMEnUzBTyHpcvrys
+f728uuP78+f78T/vHz/9Ptd+vbp95fvz5++/3jjTOJF5vuaSKkeWS/lAQdlaJ6AxyYcIfp0
bxHN7LtkLwVFcQhsgmhczmg9bNGZ0opfkqSIPVOZWB3JqFcgyA8LgtlS4jjRdY1FTceqlTID
k/+PWZowjlxELTK3/xeTJeYwuBBYMV2Zv0UrJubVoqv0aaYwM0Wl+foizCLzBuiGJjtjcW97
dOE3PHSn1lradSppnnZDgZRRFaCeRB6Q+Gt+JXe7hVkqP/RHPmSVZrA3Qno/VZm11NPCGn4o
0MyUFehuVf+e2rqUS1F5lPOVOdC13twgHLmu00dXNSBzfHWe+L6PNac7EATQ4d98BVVnSHaU
H09yl1TYyGwD/XYts+DKB1KRcdeBkEVyy7FC0yXgyyIF/2YoU540DanJH2DBPyM7iwU2GhgC
ySF5j1+TmfFCx26RIFShRbDy8a8C/zRzVTm60rlvzWMI/Xtq9knikelmfvODhPY9/qXWidNV
dvO6IwySAI0M6B2QOSr3pkkj+UPp48LZmygq7BdPc1DP7/EGkNXQxmaQZjRN46JRoUZCSH/L
4iGJXilokZ9y5i9b8y3JETW8+gmZSSnGKFM8iKGosVVBmQb5ZSUImPacMbWHA2zwCIlcB+Dm
yJBjzH2T0m5QjUWeyuGCCmXEkaWXknprWCh9jW1U+XyvPfgcNvlHBg4ZbMNhuJQGjm/Rb4Tp
EH1BkR0zsyilyMxFCPWdbJRzj/kwPm+oL485mpxse+UuBPnBy4vA98x7pxmQi2J1E9vIR+rn
VF9LC0KaIBpr0s4KB5js6VJokL0+xS998mIzGgL6fNswJRtjvsjrne8ZI0tGGgWxeYugJ/qx
7DN6eLFUDFblzavAvO48Nzk+r1gQUkQjwqI+o9uTfRHguUD9puPbjOARz9T699R0Yj6sBrM2
U+Fq6WJEt6yBmc3LaDr/g1+LHSbQyJksPzdzlIe+KIQckOZ5mqimQ43O6yTSfSQyEYBqBBP8
WKYNun40Uzt/KAdxthrxUF8++Am/voByIUgmRn5O5Rid8mDC84fSQjwUBOu8DZYYTo0gOT6Z
RlKAltLiASO4SSQS4l/TKauOvHhzMtr71Pl0TVxCndNrwa9vxAh0gaIosJ189dP0+nbcox+0
b0rInLHKEYXHAlOppSISgSFCmRCKdYOytPHoBxIxwx9q37vnqyIJInNT8aHm69y6Pq4v8QZs
GKGeUF9wP6jhjA6UOCw9W80wIU2oM4+ZuzH144R48rw3uwj8snQ2AAMBA6tK3D8E+Bf9ziy6
LHfaIFXUapRDoLEA3AgKxAKngqhdjmqM7GCR3ABkyAgvYPCshvmS5iWasEk+BRX0Rsf83Mr5
zJRdW1JChgY3WBmCxdUuw4zRDm4wIEvXaUU5bHVCQWj/qSFdHpK9FTdlyBnvpCTam0IQxq06
ELDWNiXNIHXhtnQTuZc3G+xeJMkmwL/Nc2H9W0aIvnmUH41OwXw9LzBlnCxIPphnDQui7+qo
LRfJjsFG0vysWT/0Zt3LX75njrFDkVYNv6w0qdyPmgrlNiCSMAn4hJVLnqZF088B2VvtwB2r
7XvuYNnMNWJNwp2pEDErX45EHAiII5I5XJe5xIbmUubmvlPuD7IiR1OTEbq9R3GfJrQIyK9a
Im6CMyHwOdcckfHqk9zXy8a/AQ8FWJ080HuoOdlZMXSlPlZpiA6QPlZ4c6V/033LjKLBMWNk
YH+kC/Yopwqcgnkl/BFeepp7ZwBo4oW574EAtgIy2TmYNXBOK+yu5GOWbtHyPgP42nYBsQFc
bf8QCUN97eohfQFnNMaam/jhzrwbgd9D21rAhAxKL6C6BhmuJdYmWdjED3YYVUqN/fwOxshv
4sc7R36bAr9pOOGltk8v/J4LaWT1sbfhxzccqph5p7+NoCKt4QrOyIsSiVzDSxTFR54o0YGV
yHaBF/qOoGbRS7FDTwtK4e/4Uom2SvtDlaJXfUh7HOwjm1bmFJDl8LyywSjp+mtA+yEgmJ6G
nt1wGE7OzGttPmwXdbbz7c2fgmVFGfNTV2b4pYWMZ6cdI900/WcMjtRO06lt71nDsRBq41gA
xKBWNyOdoYa9EHHdXvNnMvkVcFDO/dgK/I2mLI0zDcs9Yo930gouu4+JZ+6NNVx1mdxUWXBd
CDsKYlNJg/bRosZFm2HZboZN3b0Fqs3D2Rk8N6Md8twkpV11DtFCmHftJ7nSPtSFKfjoS/Hb
7wwcBpqXT015ZiMeitPZLAb9bQY1g5VT1kkJDG2kB8u36PwlUriUP6b+hJbOFSJHEYCDC5UM
qS8ZEV/LRzTF69/TNUJDYkVDha7DYsb3ZzEbqWWfaBuhysYOZ4dKmwc+R8Qi+q0Y9EzHOOoJ
Ov6CQjw0bYcUcGF0jRU+IrhhuGcdcvNhUF4c0KiBn/QF1L0p7ckhgmxCt2neg+X0nsOmClSz
1Ft6c9Oj7gb1A1EMIlvFGgFFNOy0Z8XPsAOwiHLYp8ghyRzxVJ9HHnUnMvPYlQSioKr6gibH
fMCd2CiC3K10pwd0hiquSNulklLV0JdH0PXUhDYPU5Z38qfTViVc9GCtmfmGhqBD4oUjxmTl
qCfBFEy2DDhlD8dGVo2FK+GZFG25zMChszJLc5IvuSUdyoaAeSp7EP067+RGZpMwYLzF4KEc
C1IpZdZVNPPauM14TR8wXsGD2sH3fD8jxDhgYD6g4UG5hyMErFjTcaTh1R7WxvQdtQ3D9g7D
jTqYTkkcH+2As4BMwHl5xKi6ZsbIUPie+UYErkNl45cZqdf5YQsGtQvQ6Si7c9AfkfbhXAFy
b77bRej9AjrL7zr8Y9oL6GIElNOclFMKDFL/hoDVXUdCKcVffNgu4Rap/ACAPhtw+m0VEGQ1
HGFAymUAUgERqKiiOmWYUwaG4YmMuZlThHoCTTClzQh/GSr0YEZI6RBQpTIgstS02wfIfXpF
Ah1gXXFMxZl82g9V4puGkm5ggEEpR2yRIAeg/A+t9Us2wYydvx1dxG7yt0lqs1meESfABjMV
pjBlEk3GEPow280DUe9LhsnrXWzqKC646Hdbz2PxhMXlINxGtMoWZscyxyoOPKZmGpjSEiYR
mBj3NlxnYpuETPheikvanghfJeK8F+ogBR8+20EwB8Zt6ygOSadJm2AbkFzsi+rePH9R4fpa
Dt0zqZCik1NukCQJ6dxZgDaXS94e03NP+7fK85gEoe9N1ogA8j6t6pKp8I9y9r1eU5LPk+ni
fAkqV6LIH0mHgYrqTq01OsruZOVDlEXfp5MV9lLFXL/KTjv0fOuKRPzV7eLV9MgFYW56PTU6
Z5G/E+RdD15PUPvHKAKzAIzDNIDUjZ+yPSYwAaZAZsVn7TsGgNN/EA6cMio7ZmhnL4NG9+Qn
k59Iv60peopilV4dEBzDZKcU3A7hTO3up9OVIrSmTJTJieTyg7A9+GlqP2RtMdp+GxVLA9O8
Syg97a3U+JTEoL1bqn/FUGZWiGHc7bisz94xzbVsJmVzZVYur61VZdSJ3FxlusqVrjtyP7CU
ti1qqznMlW+FXGU+XXvs47qvdj72Nq4Ry6v6DNv+OBfmapphXVGSoMxFfF/R38RV7AyiaX3G
7N4EqPVobMbBMyixF5L2URQY18bXUq43vmcBUyl6EO5twkpsIbgqR1eo+rfVaQGjvRYwq1IA
pJUCmF0pK2pnh60sFZ7v2NesCZHT4hmw48cTZF1gZW3zp1IEo5C+ZqHfbeMs8kZcbDMhTu0s
RD+ogpZEBPKUDEHk/CpUwEmZKRdIFxGHYI9jbkGE2HO2fSXvVn8L/0b9LaS+lOdS4XN/FY8F
nB6mow01NlR1NnYi2SAe0DchHd8A0Zenm5C+0V2h9+rkFuK9mplDWRmbcTt7M+HKJH5Fb2SD
VOwttOox4PNj9rds9gkjFLCurnNLwwq2BOqzGnuTAURgdUSJHFgEnrgOcDKVu8laHPfnA0OT
rrfA2Nv4GldWFhi25xtA8705gRrjmWjjpSU4NXRMMkQlp+yuATphnQG4NSmR2ZCFIJ0A4IBG
ELgiAALsDbTkMZ1mtIGO7Izcwyzkx5YBSWaqci8Z+tvK8pWOLYlsdnGEgHC3AUCdx738zxf4
efcz/AUh7/LnX3/89ht4GbK8Oy7Ru5K1FwHJXJELgBkgI1Si+aVGv2vyW321hzeV8/kH6kRL
AOhwcrverV4Z3i+N+sYuzA1myjIfCDMLP+mLPTK2AjtMs2fo3zdPky5iai7I8PFMd6bi94KZ
ksSMmYMFNGUK67d6S19bqH7bfrhO8GxA9ndjba5GK6qhzi2sgacVlQXDHG9jarl3wLbWTStb
v81aPOt00cbaewBmBcKKGhJAVx4zsFpp0/aWMY97r6rAaMP3BEvrTY5cKVaZ93oLgnO6ohkX
FE/DN9gsyYrac4nGsY/1FQYzCND93qGcUa4BUFlqGDimku4MkGIsKF42FpTEWJnPkVCNF3mZ
og19LeVGzz/zwfsUH5L2QzCas778vfE81GckFFlQ7NMwif2ZhuRfYWgK0YiJXEzk/ibYeTR7
qLr6YRsSAL7mIUf2ZobJ3sJsQ57hMj4zjtjOzX3TXhtKYa39G0ZduKomfJ+gLbPgtEpGJtUl
rD15G6T2wMFSxDn8jbDWnJkjow11X6olpA6rE48CWwuwslHBPp1Aib8LssKChA3lBNoGYWpD
e/phkhR2XBRKAp/GBfk6IwgLGjNA21mDpJFZOWBJxFpT5pJwuD6tKs2zZAg9juPZRmQnh5M1
tLs2G9bUUZM/JqRr0wtGQgEQz6iAODfLyJr5FZvA0r91cBwlYszlxox6QLgfmFqr+jf9VmMo
JQDRUUOFNWeuFdYX1r9pxBrDEat7sVUFiNgLMsvx+JCbKzVMTY85ttgAv33fdGq7IO8NW3Wr
XTTmK6yPQ4P3azMwdeAriiyKs2jUpw+ZLTBJET8ysygjSTyZJXjDx13w6DuQ+dhcic3XF3D1
DNZevjx/+3a3f3t9+vzr09fPtmeXawk2Z0pYI2uzhm8o6YAmox/DaNPsq8EadMkg86TWc0M+
zasM/8KGMRaEPDABlOwmFXboCYAuZhUymq49ZDPI7i8ezKuAtBnR2VXoeUgv85D2+NY0F1m2
MayqVqAdK4I4CgISCNJjvlVSNLJoITNa4l9gDOhWq1Xa7cldoiwXXOfeADD2Ax1FSrjWvarB
HdL7otqzVDokcX8IzIs2jmU2V7dQtQyy+bDho8iyAFlmRLGjjmYy+WEbmIr0ZoRpgg58LcrO
66UG7W/kdydv8K+p3FQEQf1qQabLBwLWKBh33b9+a2kMKCY9o7lOYWBn/mB60VKo7tfazJP8
ffev5ydlTOHbj1+1lxVzswwf5D11R6Zh1VW0CuQa26Z6+frjr7vfn94+awcu2J9J9/TtG5jA
/SR5LplTKdLVTXn+z0+/P339+vzl7s+31++vn16/LHk1PlVfTMUZmUsrprTFr9FkmKYF48C5
9o9sKlesdFVxH90XD5354lYT/tDHVmDTJ7WGYNbT4lWiC3V6EU9/Laa0nj/Tmpgjj6eQxiQ8
ZNReg4e+HB7xAYDC00s9pb5lr3GurEpYWF4Wp0q2qEWIIq/26dnsiUthM/PESYP7e5nuZrAi
yQbl+9FsJM0c00fz9E6D1zg29Yg1eAJFZ6sClrXWqFtdaFWxd9+e35TCmdWxSeHwgclaSww8
16xNgLPwedeOGvrXeQw48zBEm8TqN7K0aFpb0Y1IrKRVL4C1oWvoIM3Qc2D4Rc3Cr8HU/9Ak
uzJ1medVgfc8+Ds5eN+hFsvZv6zWZbqSmyPMbKboJHCZICS696c93nRz7GXzLo/HBQkAbWw2
MKGHd1M3HcqpghT4wewyd6ZWAoBN+75kYldU56bg/7ipDRLUBsqc5+BedLiJJGtZjuUxRdot
M7B0qPXiYsHlysdebCy8svhVVcytxhIC/FXZ6dXIfpSB+jZKBO/TAyzQf6CfZEDUeA2vdflF
R6HKb8vVvvsfatl0d1/9iRyr+DXigioNPQbHB116Ub/UamxTXDm7Qyu7xuEQrkHGYTROJlQN
SmHmAzKzo6PokAawxkRKBREsjjfmWJU/rHd1Eur7Dn8xddrH5uwl7c8f351excqmO5sGN+En
vUtQ2OEAjmorZIVbM2A+EJkI1LDopJBe3CNvwZqp06Evx5lReTzL1eQL7IZWS/XfSBanupWD
jUlmwadOpKZ6F2FF1heFlNB+8b1g836Yh1+2cYKDfGgfmKSLCwsay6aue5fjev2BFIL2LfIa
tSBSzM5YtMPG1DFjKrMRZscxw/2eS/vj4HtbLpGPQ+DHHJFVndj65pnKSikbFfDcIk4ihq7u
+TxgZXoEq15XcB8NWRpv/Jhnko3PVY/ukVzO6iQ01VkQEXKEFEu3YcTVdG0ufDe06/3AZ4im
uA7mfLMSbVc0cAbDxWY907tVWlvlhxJeEIJNYvbbob2mV9OEsUHB3+DnjiPPDd98MjH1FRth
bapX38omJ4UN23Sh7L5cCw11MA3tOTshs8o3+lptvJDrrqOj44MK/VRwmZYLnOzeXCb2pv6v
MasY0z38lHNUwEBTWpnvfW74/iHnYHhDLP8197U3Ujw0aYeV7RhyEjV+cbMGsVwt3CgQb++V
xiXHFhUcwCFjBrd0C1AlMF/6GbGqxivZOA9tBofxjki5IoBAhmwDKDTtYGMKCVFGtlyE/Bpp
OHtIu5SCUEJi9ADh73Jsbi9iHMfUSog8ItIFW5uOSeVG4hObZfEC7UvjRmNB4KWl7EwcEeYc
aoq6K5q1e9My2oofDwGX5rE3nzIgeKpZ5lzKqb42TcuvnFILSDOOEmVeXMsmN/fXKznU5tJ6
i04ZDXASuHYpGZi66Sspt3Z92XJ5qNOjsmLC5R3M2Lc9l5ii9sjQ0Y0DzWW+vNcylz8Y5vFU
NKcz1375fse1RloXWctlejjLneixTw8j13VE5Jka4CsBotWZbfcRnQ0heDocXAyWXY1mqO5l
T5EiDZeJTqhv0UUHQ6Jk9eAa4BWDadde/dZPDrIiS3OeKjt0xWhQx8E8UTeIU9pc0fNGg7vf
yx8sY73JmTk9T8pqydp6YxUKZkotDRsf3kDQvupAlRVprBh8knR1EpvOzk02zcU2MT1wY3Kb
bLfvcLv3ODw5MjxqYsT3cmfgv/O98kNfm1rjLD0NoSv3ZzAkMWZlz/P7cyD33iFPwgu8timm
MmuS0JRhUaCHJBvqo28ev2N+GERHHT7YAZyVMPPOStQ8tbDEhfibJDbuNPJ054UbN2c+K0Mc
rJHmMalJntK6E6fSleuiGBy5kcOrSh39XHOWSGIGsUzFmeSxbfPSEXdZlbK3uEj8ohnFeW4e
XYW8Hw6BHzh6b4FWKsw4KlVNLtMV+3O0Azi7gtxK+X7i+lhupyJkNgaRtfB9RyeRA/UA53Nl
5wpAJEVUtfUYn6tpEI48l00xlo76qO+3vqNzyi2dlOQax+RS5MN0GKLRc8yZdXlsHZOK+rsv
jydH1Orva+lo2gE8f4ZhNLoLfM72/sbVDO9Nd9d8UA/Jnc1/lVts39HDr/VuO77DmSeblHO1
geIc0696cNfWXSvKwTF86lFMVY+ObDAdOPJUZ364Td5J+L05Rq3xafOhdLQv8GHt5srhHbJQ
Ip2bf2cyATqvM+g3rtVIJd+/M9ZUgJyqY1mZACMyUpT5m4iOLfJqSOkPqUCWyK2qcE1yigwc
q4NSb3kAI2rle3EPUmrINhHaXdBA78wrKo5UPLxTA+rvcghc/XsQm8Q1iGUTqjXMkbqkA88b
31nzdQjHZKtJx9DQpGNFmsmpdOWsQ75cTKavp8EhuoqyKpDUjjjhnq7E4KMdIObqgzNBfBSG
qHOzcfQsce43jvaS1EHuPUK3CCXGJI5c7dGJOPK2junmsRjiIHB0okeye0ZiXVuV+76cLofI
ke2+PdVaBjbjnw/TSnP50diyx5jaBh39GayLlHsBf2PdFWgUNzBiUH3OjHJbkoJxJnzmNtNq
VyC7IRmamt3XKbKMMF8ghKMn62FAh7/zTUud7Db+1F17plCSBGMtF1nN2LvzcukybrfxLpyz
ytDJLoj4+lLkbuv6VK9fkC0+23WdJhu7oMcuSG0MLOwURVdYBVDUUFaDdfRv8HmRtbn9bQZT
gTuDqZRzejhhKgJKwQG2XF9n2mLH4cOOBedMLo/WcEuBtcw6taN7KIjq/Jz72vesVPrieK6g
oR2t0svF211iNcoDP3mnTsYukOOnK6zszEfq70Q+B1BdkSHBHiFPntnryC6tarikd6XXZXJS
iUPZA+szwyXIa8kMX2tHNwOGzVt/n3iRY+ypvte3Q9o/gDFXrgvqrSk/vhTnGHvAxSHPaQl5
4mrEvnVN87EKuVlPwfy0pylm3itr2R6ZVdtZnYZoT4ZgLg3RZvNkJ+fSPrWL318CmOQdE6yi
4+h9euuilWUuNRpR5fZ1SY8wFISyrxBUMxqp9wQ5mH58FoQKVAoPcrgoEebcrcObB6czElDE
vOOakQ1FIhtZFRZPi9JF+XN7BzoCxkU1yaz6Cf/HFiQ03KU9uleb0axEd18alSIBgyLlYw3N
vnWYwBKqkQfd+YM+40KnHZdgW3WZpEzdlLmIIH9x8egbaBM/kzqCY3JcPQsyNSKKEgavNgxY
1Gffu/cZ5lDroxGt9vX709vTp+/Pb7Y+ObIjdTFfKMxOIoc+bUSlbHWYOrnDEuCGna42dhkM
eNqXxC/ouSnHnVxmBtNo4fIe2wHK2OAoJIhis9blFq+RqQxpkyNtCWW0dsB1nT1kVZqbp9PZ
wyNcFpnup9sx1U+cK3zbNqbaaBbq8g9NBkuzeVGxYNPRNDfcPrY1UggzjT9S5Z7paD4U1T4s
+vaMtJM1KrCTj+JSm6ZK5O97DajeIJ7fXp6+2OpTczXC64eHDFmq1UQSmFKaAcoEuh4ctRS5
cl6OeooZ7gAVes9zVtdBCZhmAUwCaXqZBHETYibkyFytDlv2PNn0yrS0+GXDsb3skGVdvBek
GIeiyYvckXbayL7d9oMjb6lSPJsu2Ly1GUKc4PFy2X90tRA4XHfzvXBU8D6rgySMtPLUzXiw
2aiCUy5EiV8diQ5BYjo8MTnLbq9JymmjO5WFo4HhlhOdqOB4hav9S1fjyDFvMe3BNGmsxlXz
+vWf8AEoP8MAUw4cLZW6+XtiasVEnUNBs11uF00zci5P7e5hK14Rwpme3NiF2I60idsRljWL
OeOH3lyhE1NC/O2Xt3HpkxDiNAlmbtDw7bOA513pzrRzipx5brrCEqMBOhP7YM7+SwJZ1oyd
A3ZnO/PjUsBxOpuLlX7nQyTdWiySdGdWzoj7os9TJj9yUolDJrkZdw8ALeh9GNIjOxMS/j+N
5yafPHQpMz3Mwd9LUkUjx4Wew+kKYAbap+e8h92970eB570T0pX78jDGY2wPS/BTweZxIdwD
fRRTyn66Ms5vZ9OsneDTxrQ7B6Cy9Z+FsJugZybEPnO3vuTkBKCbis4bfRdYH0jsNmOEdMoA
H2BVx+bsRjkzI39JUaWRm9HyWGZt1dqLmh3EPdDltlwwA1XB7qqF01k/jJjvkOV6E3VHdin2
Z76hNOX6sL3a66HE3AllQ18RZbiZAnVtpE9n4OoruVLiLQG82Ot6KZ6a5nt7pT9m7EGYGbbr
kJb36ZJZDoFnh/bWp2VXl6C3k1foPAjQLgVnLUoXl2XEQOzxADUbylGZPuCnRkCbWw0NiPJA
oGs6ZKe8pTGrQ5DWVG+aBdL9oAPsa/MB31Vu0pvcNOKyQrAqwFYY7U9u7OqF2v6uYz8gPfRG
EAcPBmE2cR/uYmNfDYqgpTZnp19Nzi/a3NvndZdn7irg3aGU6KcNOuy6oebVjMj6AB27dYsB
VSOX6dXqVPC+UeHFRZh74SE74rpSQCnoBZxG7WD4VmgGQUOVCKwmZb9+MdnmfGkHSjKxXWS2
QXVsfGByNYThYxds3Ay5eaMsKpasMzz65SJVPaAJY0GIGYAVbg9LH5HpMu9m0FGmrASlCC7r
qcUwKA2YIrvC5E4OvxyRoPZRoE36//jy/eXPL89/yf4IiWe/v/zJ5kAudHt9FiWjrKqiMX09
zZGS+fOGIqcIC1wN2SY01UwWosvSXbTxXcRfNoF8IyxgXY1ZV+WYOBVVV/TKAiEmiM60KnF1
bPflYIMyH2aDrceZ+x/fjLqbB/2djFniv79++3736fXr97fXL19g8FsvdFTkpR+ZS+cKxiED
jhSs820UWxj4+Ca1oN19YrBE6k8KEegiUSJdWY4bDDXqJpbEJUoRRbvIAmNkXEBju5h0DuTM
ZQa0Nt1tjPz72/fnP+5+lRU7V+TdT3/IGv7y77vnP359/vz5+fPdz3Oof8qd9CfZrf9B6lot
OqSyxpGmzXjtUDCYbBz2GLS8cSsQRrg9MPJClMdGGYnDkykhbVdHJICo0ss7n6OnppIrDmiN
U9Ax8EgvL+riQkLZRSjrIwXkqO6s6erD42abkHa/L2prbFZdZmrxq3GMF14FDTGyOwVYS94o
qa6apWblradNihvBu1/JnDQB25clKUF/H5IU5d68lpNDVdDuXCPVHoWBVHHYcOCWgOcmlvJR
cCVtZp9Qmeh0wDjYc0gHK2t670SwqtvRuuwzddaphlrxl5RTvj59gTH3s57Hnj4//fndNX/l
ZQtvUM60B+RVQ3pTl5IbHQOcKqxDqHLV7tvhcH58nFosaEpuSOEV1YUMkaFsHsgTFTWVdPCI
XZ/qqzK233/Xa99cQGNOwYWbH2uBL74G2SpVzXneG++vAbGHpYIsk4R6wIIpHW4eAByWHA7H
mxJ0aNJZFrEAqtPZf6A+ue/Ku/rpGzRmdluXrJej8KE+SMCRpX0NHnRC5EVCEeQwEqCxVP9S
j5aAzWfCLIhe2c44Oeu5gdNJWJUAs/dHG6XemxR4HmCrUz1g2JrTFWifgqoaX6ZdghOPtjNW
lzk525tx7BcLQDR8VEV2O6sa9PmAVViyp5WInLflv4eSoiS+D+R4T0JVDdbkTevSCu2SZONP
vWm9fs0Q8jI1g1YeAcwtVDspkn9lmYM4UIKsDSp34IHqo9yfkrCtniIIWKdSwKdRDCXTiSDo
5HumUXgFY3eCAMkChAEDTeIjiVOuSwFNXGN2D7JdCSrUyqcIs9gqkcj8REpjHskWrGqibA8U
tUKd7GTI6Y6CoNY3BMR6hjMUE2gojn2KtOpXNPAmcahSmqmVw1pNipICe1UeDnB0SZhx3GFk
xP5iFUQWToXRMQAXciKV/2A3jkA9PjQf6246zl1onXu7xRySnoTJlCv/Q/s21ZXbttunmXbq
YVggg5JURRyMZCYma9AKqXMTDhcPcoGolc+KvkVzeF3iX7KfyP01uDNJzaeDJ/NcSP5AW1Wt
+yFKYxu0mpRS8JeX56+mLghEABvYW5Sd+XhZ/sCWgySwRGLvYSG07AZFM0z36twIRzRTVY7U
Pw3GklgMbp5j10z89vz1+e3p++ubvR8cOpnF10//h8ngIOeTKElkpK35ghbjU448imHuWKbN
wawv8EkXbzzs/4x8hEYFlATN2e2BrCBzCLj9JZ5MlVBiB4ZeZVpgU5jljlWhyqCBdzuceP7j
9e3fd388/fmn3M9BCFsyU99tN5Y/SYVTuUWDZOOnweFkvvbTGKglUhAkivu2oZFa+0F9VGLJ
CVpz9Jp2NKh5hKmBoU9Hq96wJoKCDgP845lPH8wqZnaQmu6ZprJuuzVqvmZQiHWhrptvn8Ri
a6FF84ieemlUdr0zjbbusmS0op13JKRLZeYyqxV2YQmgGHlsoMDLmEQRwegsr8GK5vBx7Zxw
DKG65PNffz59/Wx3SstCioli5YmZaaz6UOOBZl+hgVXNGmUiVsdmIQ0/o2x40GOl4QcpswSJ
1ctkBWtn2XrEHvL/oFICGsms2k7HVL6Ltn59vRCcvry8gbRRseCsoA9p8zgNQ0Vgeh4x9/Jw
Z3qgmcFka1UmgFFMk9d68FZptY6x1cmjIUpoYuTBhq5xap9k1la3L8jndoNHFknMwYFPu6eC
k9hufAnv7MbXMK1jyxDKgmLv8Aq13vQplL7HW8GICbnbbdbFNyv/pv/R41DdUJWc4060mei6
qOy2luBN16e12edSnvfXuQHEu3ezIRcs37wrMka7lbcsDJPE6kOlaAWdFUcpM2+UCrC2dCX2
7+cCHYbMxNU09uxP2c0wqP/P/3mZD7ktiVWG1IcLyryRaeHyxuQi2JiW7jGTBBxTjxn/gX+t
OcIUxOb8ii9P//2MszoLweCxAkUyC8HoOnGFIZPm2zFMJE4CjLzne+RKDoUwn8nhT2MHETi+
SJzZC30X4Uo8DKesz1yko7Tb2HMQiZNw5CwpzEd86sp4Si+CQn2BzBsaoBTzwq1pkdnkQFrD
QhxlkSxnkseiLhvuEhsFQpIVZeDPAak0mCHUFcvfxF8NWbCLHIV7N3Z4YzS0yBW4wVKxyub+
JmM9PRQ3yUfTBH6xb9uBPFmak2A5HRG4kjRP6EyUnnh24N8beGOWnEXiNM+mfQrnfchZtn6W
Rr6ZH77ACDbl1RlmAoMiMUaVD06Czckz5ksWJs2GZLeJUpvJ8JubBaYj0MQTF+478MDGq+Io
NyCX0GboE/kFF3tTkUHu5MGhPAKXkPuPwXbkopgJfAlOyVP+0U3mw3SWfUE2ArZwuRYXjHxw
1UPEzCX/EkdPKY3wCF/C69dtTPsSfHkFh/sJoLBV15FZ+OFcVNMxPZu38UsCYNNiiyQuwjBt
rJjAZ7K7vLSrkdmBpZB2N16Y5cWcHWM/mp4llvCkcy9wKTrIsk2oYWu+e1oISwpdCBDWzf2o
iZv7tQXHs/kt3SZFLbJGIwX0mCsZ1O0m2jIpa4X6dg4Sm3f4xsfqTa2jAnZMrJpgCvQRTKGI
er+3KTloNn7ENKMidkxtAhFETPJAbM2LHYOQGxgmKpmlcMPEpLcw3BfzLmZrdy41JvRCuWHm
uMVEJdMrh8gLmWruBzkZG6U5XWusEwYeki+m2r+G5ru9083ycPP0HaznM09m4EGegCfgITr6
vuEbJ55weA12plxE5CJiF7FzECGfxi5AumkrMWxH30GELmLjJtjEJREHDmLrimrLVYnI5Bae
S4McI674MHZM8Fygg4Ab7LOxz094U/w8w+CYrJbRvdzf7m3isPXl3uDAE0lwOHJMFG4jYRPL
C3w2Z4dB7sLOA6y1NnmsIj/BrxBWIvBYQoozKQszTavPQtPGZk7lKfZDpvLLfZ0WTLoS70yH
dysuUyDDfqUG00nXgn7INkxO5Qrf+wHXG6qyKdJjwRBqHmPaXBE7LqohkxM507OACHw+qk0Q
MPlVhCPxTRA7Eg9iJnFlZosbsUDEXswkohifmXoUETPzHhA7pjXUS6MtV0LJxHHIpxHHXBsq
ImKKrgh36lxT1VkXsvP0kCHTKWv4ojkE/r7OXJ1Rjs2R6b5VbWoR3lBuPpQoH5brBvWWKa9E
mbap6oRNLWFTS9jUuJFW1ewgqHdcf653bGpyRx0y1a2IDTeSFMFkscuSbciNCyA2AZP9Zsj0
eVQpBvxoY+azQXZ1JtdAbLlGkYTc9DGlB2LnMeVsRBpyk5K6DtgZ5e9q8hxiDsfDICEEXA7l
LDtlh0PHfFP2YRRwI6KqA7mZYAQUNQ+yHU4TNxsmbJAw4WbEeVLihmA6Bt6Wm15hmG82nOAD
4nicMFmUQuxGbsaYtpJMFMZbZmI6Z/nO85hUgAg44rGKfQ4HIyTssilOA1cpEuZaRsLhXyyc
caGpfvAq29SFvw2ZEVJIwWPjMSNAEoHvIOIr8va3pl6LbLOt32G4aUNz+5Cb3EV2imL11rBm
Z2TFcwNfESHTocUwCLaDibqOuXVSTvp+kOQJvxMQvsc1pjKPG/BfbJMtJ/bKWk24DlA2Kbot
N3FuNZJ4yI7xIdsyI2441Rm33g5153PTnMKZXqFwbhDW3YbrK4BzubyUaZzEjHR6GcCBJIcn
AbdRuiZSnvaZjQQQOycRuAimzApnWl/jMPrhHRvLV9skGpgZWlNxw2wdJCW7+onZbmimYCly
4WfiyIobLJLIwq0GQGNdbtMbsOoxn1DLnXeVPky1+MWjgYnctMCm4tuCXftSmbGehr40l6qF
XzyNH9uLHLNFN11L5Yth1TfnAh7SstdGFlhvS9wnYPRFG2T/jz+Zb02qqs1g4WO03ZevcJ7s
QtLCMTQo1E5Yq9akb9nneZLXWyCto2Q1e15cDn3x8b3+cNZ2Zm6UMsFkfQCPFixwubm3mY9t
XzLJCvDzasOLkibDZGx4QGU3Dm3qvuzvr22bM3XRLreZJjrrZ9uhwchXYODqTCrNuvKubIZw
4413oBH/B2fUpR7u6YfKu+yn1z/cH8263HZOQJWqETTC4fmvp2935ddv399+/KFU+ZwxD6Wy
6WX3AaaZQV2XqVXlBIaHmRznfbqNrLoTT398+/H1N3c+i/GhaQWTTzlcWqaLqeNZULIcirqT
gyJFylvGHRbJyMcfT19kU7zTFirqASbXW4SPY7CLt3Y21vclFmM/7F0Q8oZhhZv2mj60prm9
ldJvlid15Vc0MNXmTKhFh1A7OH76/un3z6+/Ob1difYwMLlE8NT1BeiBolzNx272p7PZPJ6I
QxfBRaXVVt6HwazASYpI5ZAh9xu3rb8dgepNI9c4+qqSJyKPIWY7CzbxWJY93NDbTCrkXjvm
IkuHnd/XO+V3nCVFWu+4xCSeRvmGYeZHGdw3YSb36lxK+ZUB9TsKhlDa/VyjXsom45629000
xH7CZencjNwXy4Ua84UUOkO4uuwHrqGbc7ZjK1MrO7LENmCLCadVfAWsKyDzir8eAzCpbhQe
DIAycbQjWKtAQUXZH2DS5koNaqVc7kGvk8HVZIYi1w9DjuN+z+VGkRyel+lQ3HPNvdrIsLlZ
BZbt01UqtlwfkVO3SAWtOw32jynCZ6MIdizrvMylHAZptwUT2Tiuqqy3cgdImiKLoH1NqIxD
zyvEHqNaOZJkW2u8YVCu6Buw4ENBtf5TUKlRu1GqziG5rRcmJL/1sZPrIO4EHZSLFKy+xJsx
piB4SglIrZzryqzZRa3wn78+fXv+fFt6MuzxGYxOZswMmw/64c6ikPc30cgQKBq83HVvz99f
/nh+/fH97vgqV7yvr0gHz17YQLQ29yJcEHPH0LRtx2wT/u4zZUaEWbRxRlTsfx+KRCbA6UAr
RLmvVsfD4vXry6dvd+Lly8un1693+6dP/+fPL09fnw0BwHz3CVEI/OgSoD3sLNDbOEgqK0+t
0tZZk7RZEs8mVJqh+77Mj9YHYPPj3RiXACS/edm+89lCE7SskI0XwLSpD8igMg/GR4cDsRxW
gpCDMWXiApgEsmpZobpoWemIY+U5WJhv8RV8yz4h6EMxM/SxTrMpqxsHaxcXPTVSdjP+9ePr
p+8vsgfOHm/t/dIhJxIxILZil0JFuDXPjRYM6TCqB1dUhV6FTIcg2Xpcasqa36EqxswcATfq
VGXmXS4QylOhZ57aKdTWx1exED2mG0bcBx4Yh5cG6AyN34uqOlA6WyMDmgpbEMUs0KMYDNxK
kt6tL1jMxGveps0YUgBTGHqBAMi8GaywcThg4Gp9pJU+g3YJFsIqAuMcRsOB3NEKCz+V8Uau
gVCDFhFFIyFOAzzTF2UWYkzmAr2fAEmuNBXoAUDmRCAJ9Rgjq9scWcWVBH2OAZh2s+BxYMSA
Me2TtvrVjJI3GjfUfDRxQ3chgyYbG012np0YqJgy4I4LaepuKXCIQyvgsiO8wcXjSKyyq8Fk
Q5z+P+AgzmPEVuJbDeGjDrWieP6cH3kws5M65rD73u09hQkOgryD1ijW11pDYk/sgNInNgq8
TzxSzfNWjmS0yLjsl5ttTA1hKqKOPJ+BqL9VwO8fEtkxAxrafIea7sfIqr90DwZVebAdSFsv
L4m0ADXUL5/eXp+/PH/6/jYLU8DflYtPdOZMBQIQy50KsmYmqkUOGPLuZc1B9KGVxrA25hxL
VdOuSV5TgUqg75kqjFp9ELmGshzPqNitl1I3dOcxKFI8XPJHnocZMHogZkRCC2k9wVpR9ALL
QAMetdeGlbEaTTJycjUvqJbzCbtzL0x6RhP34m7D/uBa+cE2ZIiqDiM6eLmXbApf372t+xkF
12XL7FnU/IbfeSrBhL40NEC7uhbCqq1MbLaVaUFOlbKO0FXkgtFGU0/WtgyWWNiGrnf0nuyG
2bmfcSvz9E7thrFx6Od1aCq5bhKaCW3Hs+rI0/obpQjTDqGtkHHzM0P2/jfiUI5gurytBqQn
dwsARh/P2s6pOKOs3MLAZZS6i3o3lCVvECo2V/cbB9J9Yo50TGHB3+DyKDQ7gME0KXInZzBa
6GepPTa2bTBzn67y1n+Pl2syvKthg5CtCmbMDYvBkF3CjbE3GwZnbzluJJFojN5DdgeYidj8
UcEfM7HzG3MTgJjAZ6tfMWzdHdImCiM+D1hqMPwxKeHdzVyikM2Flu05phTVLvTYTEgqDrY+
233lRB7zVQ5r+5bNomLYilUvNByx4eUVM3zlWWsvphJ21FV6uXFR8TbmKHuPgbkocX1GNiGI
S+INmxFFxc6vdvwEZW1CCMWPD0Vt2c5ubWAoxVawvcWi3M6V2hZrNhrcvCcmDpUQj9yfYirZ
8bHKbRc/ZIEJ+OjIVu3GUHnVYPalg3DMc/auzOAO58fCsQR0lyTx+H6jqMRN7XjKfI19g9eL
bI60dmMGhfdkBkF3ZgZFtoE3RgR1l3ps+wEl+KYVUZ1sY7YF7Q2bwSlZ59IXh/35wAdQwtN0
qc0t+40HlU8/DtnI7a0N5oKQb1S9heE7qr0Vohw/RO1tEeF8dxnwxsni2PbV3MadT7RjItyO
X4vt3RPiyH7I4OjLQkP8xJp0N4IK7piJ2MjoBgAxSCzPrNMJQJp2KA/IbmhPg0mgRpNLtvi1
NN1llaYpgLJXwAShMNwU69cIl0Pdgccs/uHCxyPa5oEn0uaBc8ipFdo6lqml+H+/z1lurJlv
VNWAUXyBsJtDTxSFbWJZClBI61DnAVso7S2Ltz22MQ+1VoDLjxAXE7lNhFmmL9L6EXlmlOkf
276rzkeaZnk8p+aeWELDIAOVpLnQe11VniP9jT3qzdjJhhrSdQCTzW5h0OQ2CI1qo9AJ7Pxk
EYPFqAkXu3oooDbgRapAG7IZEQYK9CbUgzlY3BqgAYIR5UKCgbSHvLocBtqRSU5MYwpKg0FZ
QdAG6m43VH88f355uvv0+vZs25vTX2VpDT5ibh8jVnaLqj1Ow8UVADQkBsi2M0Sf5sq9IUuK
vHdRMIG9Q5kz0oxqq4XI/wVlpvxidP1LmRcwbVwodNlUgUx8Dy4+UnNo3WiKpfmFnlpoQp9Y
1GUDQkraHM3pQ4eAe1BxX1QFcmygueHcIO8fkLG6qAP5H8k4MOq6cwJfwFmFrpc0e22QSQ2V
ghRTQKWQQXO4QKXFAeJSKz1dxydQ2SX3mV31Eg3IenTDZQnbjtaVYt5LJXDnLnCWKMB5kz9I
rgBpTEMzA6h1WKacIRi40kjztBtgBfVjk8ofmhTuKVVfEPizvACXBaLIQGVZTkhCyP/dbpvV
MLavl1XvPsPNPx771+dfPz39YTsYgaC6X5H+QYjFPfgFdTEIdBTa+YEB1RGyI6uyM1y82DzR
UZ9WiSmerrFN+6L5yOEZuCpiia5MfY7Ih0ygXcCNkoOrFhwB3ka6kk3nQwF6kB9Yqgo8L9pn
OUfeyyizgWXapqT1p5k67dns1f0OXsWz3zTXxGMz3l4i88UsIswnjoSY2G+6NAvMkwTEbEPa
9gbls40kCvTQxiCanUzJfI1EObawUkQox72TYZsP/hd5bG/UFJ9BRUVuKnZTfKmAip1p+ZGj
Mj7uHLkAInMwoaP6hnvPZ/uEZHzkyMuk5ABP+Po7N1LGZPuy3LuzY3NotXsPhjh3yMerQV2S
KGS73iXzkHVMg5Fjr+aIsey136WSHbWPWUgns+6aWQBd/xeYnUzn2VbOZKQQj32I7XXrCfX+
Wuyt3IsgMI88dZySGC7LSpB+ffry+tvdcFHWAK0FYRZALr1kLZFmhqn9XkwyAtVKQXUgG+2a
P+UyBJPrSylKWwJSvTD2rKeViKXwsd165pxlolgxADFVm+aFlbXbZ6rCvQn5j9A1/PPnl99e
vj99+ZuaTs8eem5porxYqaneqsRsDELf7CYIdn8wpZXpnRdzTGMOdYzeGZsoG9dM6ahUDeV/
UzUg/6A2mQE6nla43IcyCfP8bKFSdGFnfKAEFS6JhZqUOuuDOwSTmqS8LZfguR4mpHCwENnI
FhReR4xc/HJzdbHxS7f1TLsDJh4w8Ry7pBP3Nt60FzmRTnjsL6Q6AWDwfBik6HO2ibaTG0mf
aZPDzvOY3GrcOjtZ6C4bLpsoYJj8GqB79rVypdjVHx+mgc21FIm4pjr0pXm1tmbuUQq1W6ZW
iuzUlCJ11dqFwaCgvqMCQg5vHkTBlDs9xzHXqSCvHpPXrIiDkAlfZL5pNmXtJVI+Z5qvqosg
4pKtx8r3fXGwmX6ogmQcmT4i/xX3zCB7zH1k+RZw1QGn/Tk/mjuvG4NOH0UtdAI9GS/7IAtm
7dfOnmUoy005qdC9zdhZ/RfMZT89oZn/H+/N+3LHntiTtUbZeX+muAl2ppi5embU3D8ryv/r
u/JM9/n5Xy9fnz/fvT19fnnlM6p6UtmLzmgewE5pdt8fMFaLMohuVr8hvlNel3dZkS0OokjM
3bkSRQInNzimPi0bcUrz9oo5vbVVJyPkWEufaMk0fnCHWrNU0FZtjIyMzWvTNUpMcx4LGltL
MmCx1WCPbZ9aIogCpzwLreQ0AwKdZ4somtyfH13x2dnXTFVX5hbXonrXh+lFxMVDIdiq/Plp
lRQdlVpeBkt+BUyOma4vsnQo8qlss6GyZEUViuvKhz0b66kYy3M9m9p1kMTPjubq0T7dG0Jf
ycjOIv/8+79/fXv5/E7Js9G3OghgTlkqMQ0XzSep2hd3ZpVHho+QQQ0EO5JImPwkrvxIYl/J
UbwvTUVfg2WmEoXr57hSrAi9yBo1KsQ7VN0V1lnofkg2ZOWRkD0xijTd+qEV7wyzxVw4W/Bd
GKaUC8VvFxRrTxdZu5eNiXuUIf2DCfrUmgPVQnLZ+r43mQf5N5jDplbkpLbUasicTnLL5BK4
ZOGULpQa7uBZ1juLZGdFR1huCe2q89ASySivZQmJ9NMNPgVM5VDw5EV9D+sz1wa5Hwbs1HZd
QWoanJuQT/OcPtsyUVjo9CDAvKhL7Mp3PiA+d/A6E3e0TbV6YJkfF1nzY5YeiinLSqvrLs+N
L115kLsBISN6eDdMlnbD2TpPl3UdbzaxTCK3k6jDKGIZcZou7ZmidRiAjqAFn61BDI7Ltn9R
VOmEZGktrFoQIXhQrU3vjsseH3Qq8gz5oGqz+eqKwyaRpXLiynpTb9KgbZc4a5G1AXMpjFgl
FzLT52ax5rCZSqsEN8Z1WhF106Gs7aqWuOxS5ZQJd6zw4buJdvpmhO8Cab0Jt1LW7A4WRV3f
mOg0dNYsPjOXwSqHMl8iu6OVuHpohjxrYcJaFQfwvFjhYbTeezlGUZtbqwIYd7nkrYWvb74/
MKvUSl46u/svXJ137u+IasRCL9d2ZSNlgQrZwsFdDPrDMbAWa5PmMm7ytX3uBs/2i7pOu97K
Ou7b09FuKSFbZA9TEEecLvZ6rGG9GtjHh0DnRTWw3yliqtkirjT1YX+btOyhu7yxP+SdJWgt
3Ae7sdfPMqvUC3URdowDTMZW22qUvyNWk+KlaM5WPamvkJfQFbfbCAYNQuWgUb4HHCPmwkxF
l/JSWh1PgXiDZhJw55kXF/FLvLESCMj9qHsthFv9v1sptQ2HtOXyYvZ+joYOKTepPAcrjM2C
esLfZUnNeZI7LBKh0JsIuduu6+xneKnN7InhvAIofGChdSXW62OCD0UabZH2n1atKDdberVD
sVtIegNDsbW4lNDurTF2izYmGaj7hF6v5WLf009lzynVX1acp7S/Z0FyXXJfIJlOnynAmWJD
bpTqdIeUQG9Vaor4CJ7GARnn0pmQu4KtF5/sbw5xgt4JaJh5zaQZ/SjqF6fZK+CTv+4O9Xzx
f/eTGO6U+QjDk/0tqmS0O+Dh5e35Ck6QfiqLorjzw93mH47NyaHsi5weNs+gvsEyBPFZqwZE
nKntQGVhPVQA+1PwIl5n+fVPeB9vHYfBHnnjWyLHcKEaFdlD1xdCQEZq7FiZbj3e2ZSwU67a
3G1iBzxdTNerMFbLtJHdFdXQDe8zDnUsfUoXR4tVxg7y6eunly9fnt7+vah53P30/cdX+e9/
3X17/vrtFf54CT7JX3++/Nfdv95ev35//vr52z+oNghoLfWXKZUbLlFUSA1hPogYhtTc4c2C
Uj+//Vp9GxZfP71+Vul/fl7+mnMiM/v57lX5Tf/9+cuf8p9Pv7/8ufpyTX/AIePtqz/fXj89
f1s//OPlL9T7lrYnrwlnOE+3m9A6HpXwLtnY53tFGm/8yF4YAQ+s4LXowo19uZWJMPTsAxYR
hRvrshXQKgzs9bm6hIGXllkQWqcO5zz1w41VpmudIEvON9S0TD73oS7YirqzD05AQ3Y/HCbN
qeboc7E2hnVQmqax9lGpgl5ePj+/OgOn+QUcCVgyvIKtE0mAN4mVQ4BjzzpUmWFucQYqsatr
hrkv9kPiW1Umwcga7hKMLfBeeMhf6dxZqiSWeYwtIs2jxO5b+XW39fkTLPt8VsP2fAhPkLYb
q2qHSxf5G2b6lHBkDwq4FvTsIXQNErsdhusOOdMxUKueLt0YajcGRueBEf6EJgCmz239LXdz
HekhbcT2/PWdOOw2UnBijSHVQ7d8x7VHHMChXekK3rFw5Ft7gBnm+/MuTHbWrJDeJwnTBU4i
CW43LdnTH89vT/M87FQykCtyA4cclVU/dZl2Hce0lyC251NAI2sktZeIDStRqzIVarVTe8HO
E25h7VZq5aDjUtuyYXdsvH6YRNaEfhFxHFgDoB52tWcvOAD7djNLuEOPRFZ48DwOvnhsJBcm
SdF7odcx10pN2zaez1J1VLf2/YuI7uPU3mkDavVniW6K7GivLNF9tE/tsznVoyhaDElxb1W4
iLJtWK8S7+HL07ffnX1Y7tTjyB5tIozRA2oNgxkB+4YN3qQqCc+YUF7+kNLIfz+DhL0KLXhx
7nLZ3ULfSkMTyZp9JeX8rGOVQu+fb1LEAVtQbKywzm6j4LSKyXJneafkOxoetpzgXUBPTFpA
fPn26fkLGDh7/fGNSlx0ttiG9vRdR4F2PKKTnoW4H2CITmb42+un6ZOeV7TouchxBrFMOLah
1fVMtaxHDxluv1FqTCHj6pjDHmEQN2DnUpjzzadbmLt4Ac+pCclFbdGrY0Tt0CSEqa2D6j9E
m4bPPqyo/q1JuvLddj0KP0YWqJQkv7wN0CvDj2/fX/94+b/PcAeldw50a6DCy71J3SHTGgYn
xeokQKZOKIlspmDSl6zvZHeJ6bYFkWqz7fpSkY4va1GiboW4IcAGzAgXO0qpuNDJBaa4SDg/
dOTl4+AjbTCTG4nKM+YipHuHuY2Tq8dKfmh677LZrbUxnNlssxGJ56oBmJli63Lb7AO+ozCH
zENrn8Xx/VtzjuzMKTq+LNw1dMiksOmqvSTpBegwOmpoOKc7Z7cTZeBHju5aDjs/dHTJXkp5
rhYZq9DzTRUc1LdqP/dlFW1WFaV5Jvj2fJdf9neH5aRgmdXVu7Bv36Wc/vT2+e6nb0/f5dry
8v35H7dDBXwyJIa9l+wMKXAGY0ufDrTCd95fDEjvtyUYy32QHTRGa4G63JXd1RzICkuSXIT+
zdU5KdSnp1+/PN/977vvz29yWf7+9gLqWY7i5f1IVCOXuSwLcnL9Dq0bkzvrukmSzTbgwDV7
Evqn+E/qWm6CNpYygALN19sqhSH0SaKPlWwR05fMDaStF518dB6yNFSQJHY7e1w7B3aPUE3K
9QjPqt/ES0K70j301nwJGlCtxEsh/HFHv5+HWO5b2dWUrlo7VRn/SMOndt/Wn8ccuOWai1aE
7Dm0Fw9CTv0knOzWVv7rfRKnNGldX2rBXbvYcPfTf9LjRZcgq0ErNloFCSz1Zg0GTH8KqYJH
P5LhU8mtYEK1PFU5NiTpZhzsbie7fMR0+TAijbroh+95OLPgLcAs2lnozu5eugRk4CilX5Kx
ImOnzDC2elAeyPWgZ9CNT5ValLItVfPVYMCCsMVgpjWaf9B6nQ7kxF3r6cJrxZa0rdYx1x+s
HTKbp2JnV4ShnNAxoCs0YDsKnQb1VLRdN2WDkGk2r2/ff79L5c7l5dPT15/vX9+en77eDbeh
8XOmFoh8uDhzJntg4FGl/LaPsHOnBfRpXe8zuSWls2F1zIcwpJHOaMSipocpDQfoucs6+jwy
HafnJAoCDpusa54Zv2wqJmJ/nWJKkf/nc8yOtp8cOwk/tQWeQEnglfJ//X+lO2Rg4GuVhZan
J8ancsv75d/zDunnrqrw9+ho7LZ4wEsPj86ZBmXsrovs7pPM2tvrl+Vs4+5fcuusRABL8gh3
48MH0sLN/hTQztDsO1qfCiMNDBa6NrQnKZB+rUEymGDzR8dXF9AOKJJjZXVWCdLlLR32Uk6j
M5McxnEcEcGvHIPIi0ivVHJ4YHUZ9WqC5PLU9mcRkqGSiqwd6PuRU1Hp+2J96fr6+uXb3Xc4
q/7v5y+vf959ff4fp5x4rusHY347vj39+TtYTrWVho/plPbmAa8GlJ7EsTujd+GmEpr8odXA
clMhCtC8k4N0VL7I0StCxSkH43XNo5MoqgMogWD6vhZQF1hFcsYPe5Y6KHMIjF+tG9leil6/
vpdTtUnDw7pJ7lpy7iZX8sNAsn8s6klZfHfk0cVd6l+MO8z5+uDu1bqoND4BxYbsJFf7GEel
FR4qpAG84M3YqUONnXnBBWSf5gWtG40pq5PdQPKb1vnRVDy6YRPtAzOclfcs/k700xHcsNyu
oxePX3c/6ava7LVbrmj/IX98/dfLbz/enuDmHteUjG1KTV0oAJv2fClSowgzMF+7Ryy8uI/4
JWSimsAWS1UeT6TPXo4F6SXnvCLlpf28PqZH5A4VwKzs5XwxfSxqUvNal+eqNIEw83EkKe3b
7CRI/speDozJas8ubYrVR1f+8u3PL0//vuuevj5/IT1RBZyqSy6YCKyDuxtTNk1byemh87a7
R9O8wC3Ih7ycqkEuYXXh4UMlI4FZgarKd96GDVFJ8riJTDOAN1L+P4UX99l0uYy+d/DCTfN+
QiIuwpP5/pkNkqQpH4sy7VR99D2/98WIno/RQMLbhINfFY5A5dCDqQApTW63yY7Mr5aC+Prd
yqCWvdnQ3r+9fP7tmTSyNqkjE0ubcYvePqhp+1zv1XqRpxlmoFtMRUOMUqk+XhxTcDIITmPz
bgQDiMdi2ieRdwmnw5UMVzlzdUMTbmKrUmGemjqRxAFpEjkLyv/KBFmo1ES5wy9OYS5vxanc
p/PtNdrbAFtOw+H/MXYtS27jSvZXajerviOSet6JXkAkJbGLLxOkRNWGUd1W9ziibPeU7Zi5
fz+ZAEkBiYR8N3bpHBDPRCLxStTLgMSEStXZSiUE9Tdt0RGRSbYXj+AgTnsusonOQvmItvZ0
VcePlw7gCSqauD4S/aDepYQqK0jYopcOcNjT6iyvlg0xAqMdsc84ZgHTwA+tyzRpLawRdSKg
X1ieS5W85AFtqxwF8UoymBzoEBmY692jkqaalABSnAXtg3mGR/3KpJqH/MP76+fb0+8//vwT
RvqEbiyaVTdZIcomMWCYZRdJnpknCg977UfvakGJeV8CfqvnC2E2y3jSwkgPeJYuzxvrPNZI
xFV9hawIh8gKKPM+Vz4pZpfnI9eAtVVnfZqjr55hf21Txgc6hJNXyaeMBJsyEr6U66bCDakB
LwrBz64sRF2n6Cc9FXz6h6pJs2MJiivJzKuTqsra0x03k9nDf5pg37qFEJC1Nk+ZQKTklgcp
bLb0kDaNuqhoFxpULsgTyUch8G2SVPIJMFYKfgMfjJapnXSb5apKoU8dWYH979f3j/qyLt1l
xTZXJosVYV2E9Dc09aHCi0KAlo6s5bW0TxkheN2njT3JMlFHzgWMBVDldsxZIVsb6bArWEhV
49jVpHYZZJCQN2+wu4GMZYKBbPf0d5gc8LwTfBM12Vk4gBO3At2YFczHm1n7wEp+wK7oGQh0
cA7z0KwrWPIq2+xDl3LckQNp1qd4xDm1uxydncyQW3oNeypQk27liPZqKfcZ8kQk2iv9PcRO
kPnJ2zxOXK53ID4tGZGfjmzTQWaGnNoZYRHHaW4TmaS/h4h0LoWZ/iBQXtMKVG5mp/J8bWwt
FVlj6QgwuVAwzfO5qpLKdPmPWAs2nV0vLdi0Kenf1lF8pWnsb2DWVNAxc8TwyeRiSM/qHP2s
Wy0y7mRbFbyOxcc97OwVeEECS0wq3n5vRyEy7kh9WfNF7LH7AgSoXa5IEx2rPDlk5stxWFn6
ZQm7p6U4c6gK0lf3UK1EqY2YuiF7JII3cbTJ9k0lEnlKU9IcXTU8B7tFz6ILFiV1Q6aSCElc
2t+QKtyYe4xzv8KO6No5CGrvgdpNrs3ky8NiES7D1jxaoIhCgjl6PJjLlgpvz9Fq8eFsozD6
7EJzxjGBkTk3QbBNqnBZ2Nj5eAyXUSiWNuxeB1UFXKfrqCCx0rkxYjBVjda7w9FcQBpLBkL5
fKAlPvXbyDwjcK9Xvvru/KgI2SYhL+ncGcs5+x2mj2TYzIptd+fpACOVYrtbBsPFer77TlP3
13fGec7QoraWz0hCbVjKff3NyKXjMd+Ikr6mYlXuOjJ9MBJqxzL11npjw2KsVyeM/OF8pmET
cr3O3znXqbpRLPJYiyFN9huX9+ydoT02ec1x+2QdLPh0mriPS/Pq71HIVrT0IiRvII9zdX2A
5euXb1/fwA4eF1TGu0TsOjv8KStTlQEIf+mn3mWMXn9tz848DxrxJTWvL/KhMM+ZbGF8nHxj
7K/zUuachN4pcHJmwfB/3hWl/HW74Pmmushfw3n19AAjJZhbhwOeZKAxMyTkqoUJAMzYYC7X
XB+HbaqWLOnn1bGyf8GUq+zAprTu1RkE1Jh5RMFg4rxrw9A6GdqVCfk5oMdb8visheMzwaAe
M/MRXyuWMhnI21MI1XHhAEOaJy6YpfHOPCSOeFKItDyipeLEc7okaW1DMv3g6G7EG3EpYDpi
g3FV6Ktt1eGAuyM2+5slsxMyepK0doCkriPclrHBIuuhiSvTz8JUVB+IfjqgtAzJ1OypYUCf
i2OVIdGj4ZfIX6PQqjZtSAxgc9nOtlXiTRUPBxLTGV+tlKki/VxWtqQOyYRlhqaP3HL3TefM
c1QqBeg2Wnho/w4muQys+7YntNsc+MVYva52mQKgSIFhbT/4bHC+LxxBQQpsW/ebou6Wi2Do
REOSqOo8GvRyCYNihKaxP3LLiWMsfVWlvRuliHcb+s6EajV6FVuBbh2L3HpyXCXDlrStxZlC
0tz40xWlPPR3wXplXjK5VxWRHxDqQpRhv2QKVVcXPC0KM/SH5Nz8C1sySf5FEmzNt6p02aU1
89RYtlquSD5B9Wd9zWFqMYvoPdFttwGNFrCQwSKKXUICvLRRFBKlu2+tk2gzpHaXY3xOnGhS
sQhM01thykEPkc/+CvYzI7cKJ9/LZbgNHMzyaX7HYPp+GRJZU261ilZkH0ERbX8geUtEkwta
haCKHSwXVzeg/nrJfL3kviZgYb2HqYcOAqTxqYqICszKJDtWHEbLq9HkNz5szwcmMKitYPEc
sOCocFyCxlHKINosOJBGLINdtHWxNYvR6/EGQ3wbIHMotlRTKGhy74BbCURDn7Rs6V3Gr1/+
4zueKPrr9h1Prrx+/Pj0+49Pb99/+fTl6c9P759xCVkfOcLP7ld6SHykW4PREliT/Rmk4oLO
a/Jtv+BREu1z1RyDkMabVzkRsLxfL9fL1LEYUtk2VcSjXLWD0eOMVmURroh6qOP+REbpJqvb
LKGWW5FGoQPt1gy0IuHUTvg529MyOetrelAS25DqlhHklLBaiqokkaxzH4YkF9fioPWgkp1T
8os68EGlQVBxE7o9XZixehEG01wBXDxose5T7qs7p8r4a0ADKF90jlPuiVV2ASSNnhWffbTe
bfexMjsWgi2o5s9UEd4pe3PZ5uhmDWHxWQtBRcDgYTyjI6zNUpmkrDsWGSHU5RF/hdj+HCfW
WXiam+gnpoqOukndLyGP3qZNe+rjcE4P2xtsADphV726F9hfnAFe0kmFaDdRHAYRjw6taHCD
c5+1DS5fLPHYqhnQ8iI8AvS8wAR3IqDaXrlmFpn44IE5vaaikkEY5i6+Ri8tLnzKDoLORPdx
Yu/1TYFxy3vtwnWVsOCJgVsQa3tBeGLOAuxmotwwzxcn3xPqtmHizKqr3jzaosYgaW/6zDFW
zTPpjft0X+09aaPXdevkt8W2QlrPMFhkUbWdS7ntAFPLmHbCc1+DaZuS/NeJEqz4QES6ih1A
zx32VPEgM22gPVjPUHdTxzUJJmpnPqnBQfTquIyflHWSuZl3jxKaRPyCz3mulyvcgT/ZYbTH
QKf8Mww15qWkfEhbbtbcLx/TlNoFmhHF7hgutBsXZ+I1fY/POS7oNNGMol/9JAa1c5D466Sg
ynsfF+E2WimabcD4eiypLKX1LgIN69R+ql7WoujkmZRNwiSLWNABK0mhM5fqiI776Z3TYjz6
Oo9Hz0No+x7eb7dvf7y+3Z7iupvvPsbaOdU96Oifivnkn7aRJNUyVD4I2TA9DxkpmC6iCOkj
+K6BVMrGht4scVXKkcSJBF1hOWJVWrGYGoxU07ieTsr+6R9F//T719f3j1wVYGQorGvH2tVc
KrfOfH7i5LHNV87oM7P+yhD63nxDxBtP6Z2ydYgulamI/Pay3CwXrkje8UffDB+yId+vSU6f
s+b5UlWM8jWZQTSFSATMM4eE2iGqqEcWVKXJSj9XUZNgIvHcZp5DR/eGUFXrjVyz/ugzif7C
skpNCRowp+2jqXNYnDAw+rroJT9aKYIVidGOY79CT5kumte4bxrXnY9yd3htPqs/bBfr3kcL
pIO1S8uWjXQMP8g9U4QGhnk8rutneIU8s6DNH7CejjTzheh39jveThA9+DIBnqFzb8cjtMzE
agwT7XbDsemcfZ6pzvTRbkKM571du2Q6CM4Ua6TY2pq/K5JnVFnWdX9fIOtN5TlQIZr2w08+
9tS6ETFvcsk6vUpn3QGZttqnTVE1dNsAqH2a50yR8+qSC67G9WlJPHPGZKCsLi5aJU2VMTGJ
pkRXlkpCInycIMb//XXTFiEUfxUYrk7Y8Uf++Pv2fnLHG3lawhDADIV4U4NJNmu4RgCUm5/Z
3OBOXuYAHTVPdN+fF1ZkW3z64/3r7e32x/f3r1/wVphyKfsE4UZvaM7u9T0a9D3Ljvea4sVb
f4VS18ye/sTb2/9++oJOhZxaJul25TLjNlaA2P6M4Lu+itHNqoI9naNNjw1jyCgYTGaczvjZ
RDC1MpFslU3ko9xEkOypY8btifXHrLUmo2Q0i+b7KnrAWm73KLtz1mbvbNtkhcyd+fE9gO6l
3u/9A8K9XBtfSzyw6vr2UB+FXWMvjqH30jshWm58Uxc9ymkxR1vzKI2MT6pJV+W5Flimxdwz
QncNl704GyJ6jjaAZDBxASGcBTcVFV7BWbC9aZqt+7gk2EaMuQH4LuIyrXB3ocvgrLOFJseN
iyLZRNbrrXdCdEPXZtzwg1wQbRgpVsyGroPdmd7LrB8wviKNrKcykKU7eybzKNbto1h3XB+Z
mMff+dO0HXcazHnLCq8i+NKdt5yCAckNArrdqojnZUCXJEZ8FTG2IeJ05XjE13SldcKXXE4R
58oMON2m0/gq2nJdBZVeyCXs04Z7POrFmAjxh8ViF52ZFopltMq5qDTBJK4Jppo0wdQr7kTn
XIUogu7lGwQvVJr0RsdUpCK4Xo3E2pNjuss64578bh5kd+Ppdcj1PbPYMBLeGKOAHkyYiOWO
xTc53QTVBLp+5mLqw8WSa7JxhcGj9HOmjhOxCele0Iz7wjNVonCmcIBbbyXf8d1ixbQt2Mlh
EHKEs8CIqL4DyRc3lfYTX3d8G3FTbd/Sksb5xh45VnyO+FAtI46nRHC7e8oGUTLCdXi8gY1T
3wU3amdS4IyNsc/yYrlbclahtsm2THH91trIMI2jmGi1YawaTXHdUjErbghQzJoZ7RSx48Rj
ZJjKGRlfbPSg1T19jpBgRgfr4YKH8j3rE2YY9b6uYCbFMFUP1pyVgMRmx3SYkeDFcCJZOQQy
WiyYlkYCcsE02sR4U9OsL7lVsAj5WFdB+H9ewpuaItnEmhyGYKYaAY+WnDg2bbhhJA5gbowH
eMdUHExYVgEbC+KenMIkh9M6eqGDx7nJnnfpDHBusFY4o5gR50Rc4YzCULgnXW4w9k3qNM7X
kX+qR1+AuePHgp8bTQwvVDPbpPAH+/m8bOMZXnwLcrIIV9wIicSaM7ZHwlMlI8mXQhbLFacn
ZSvYURdxTuEBvgoZIcGV+d1mza5LZ4NkV0iEDFec/QfEasF1MiQ29CjdTNCjiIo4iN12w+TX
eBTjIclXpxmAbYx7AK4YExkF9KCVTTvndR36J9lTQR5nkJvDaxKMD27e0MpIhOGGW+K55MsF
Z4UCsV5wKko/P8LkQBHccsD8UhHF0as3F74AG3ExpGdG4V0K9wTKiIc8br/bbuGMHM+rzQ6+
ZfsW4Es+/u3KE8+KE1+FM5Lj23rA9UBuhQVxzhpSOKO3uGMBM+6Jh5t3q/VJTz45C1W9VuMJ
v2H6H+Jbtr22W87I1Djf1UaO7WNqJZXPF7vCyh29mHCu9yDOzYzUrrgnPLeK5dtFR5wzxxXu
yeeGl4vd1lPerSf/3HxDbV55yrXz5HPnSZfbXVO4Jz/0oO2M83K944zBS7FbcJY84ny5dpsF
mx9+DV7hTHlf1GmM3bqmR3KRhHnfduWZ8mzoIfOJ2HL2WhEH0YZr5yIP1wGnkEr09slJdsld
7ZgJX1RbbrrX1mIdRAtBi66unaujHOwi8p1mCRl3DKmtwGMj6tNPWP57eS3RD411bsY4SacP
TmeJu5F2MjdI4cewF22bNlcwvpq0PLYni22Esc3aOd/eD9jqDcW/b3+gr1JM2NngwPBi2aax
nQK6RejaqnPhxizbDA2HA0FryynADJkPlitQmufCFNLhsVxSG2n+bJ450Vhb1U668SltzG1u
jWXwi4JVIwXNTd1USfacXkmW6DlnhdWh9WSIwq7kyCOC0FrHqmwyabmcmjCnACk6zaRYnlpH
VTRWEeAFMk4FodhnDZWOQ0OiOlX2qXf928nFsV1vI1JhkCQjJc9X0vRdjG7qYhu8iLw1b9Sp
NK4NuT2MaBaLhMSYtQRoL1l5EiXNXikz6D40wjxWZ80JmCYUKKszqWUsh9tbJnQwLyZZBPww
nzaacbOSEWy6Yp+ntUhChzqCDeGAl1OKfrtoWykHMEXVyZTi10MuJMl+kcVNhffTCVzhKS0q
VEWXtxnT6GWbUaAxb3EgVDW2oGGXE6Ay0yavTDk1QKdodVpCwcqWoq3IryXRTTV0fMvRjwFa
PtxMnHH5Y9Le+EB+JM/Ejp7JoYDoJjKmX+AVe1KIBv3CUPlvqjgWJIegz5zqdQ5IKdDShuqd
R1rLsk5TdF5Ho2tR3GB0SUnGIZE6p6q8KYhIHJs0LYU0dekMuVnAs1K/VVc7XhN1Pmkz2l9B
w8iUduz2BEqhoFjTyZZexTZRJ7UOB+KhNp1Bab3mKOtLlhUV1Vh9BoJsQy9pU9nFnRAn8Zcr
TO8bqtgkKLyqGaxjJwau3SONv8iwm9ezidLJPW+m6LsgjvwbwBhCuxWYfSezkeEpDB2ZDvfl
++3tKZMnT2h1JhRoOwOYXnWKM9uLn8073oXU9Rj14rCNiQY1tZDDKbaTsINZt4HVd2UJGilO
9d1d5bVhrkv7wTWsWecdY/Wgtb7wNHkFseP3eUJQhW+PDjBcTqAJcicepPa5Um+ytYVkog+y
sEHUangs6HiEHgCAW5NONV6cGruoGree/LPg2S3CXfy+fvuOzlvQ9/0beuCkhqv6dL3pFwun
tYYeBYJHnbbTqHOkd6YK0/HDHT1DhhncPkqIcMrmRaEN+vmEVhjalmHbFsVJgkHLfeuUY0rH
U5aq78JgcardrGSyDoJ1zxPROnSJAwgKnpR3CBi6omUYuETFVkI1Z5kWZmYklaTqcTE7NqEO
7zE6qMy3AZPXGYYKqDgqJj2w2eIrBDDJc6KCqVsqQZ3A3ydXqUAv5TJ7uggGjNUtG+GiTg0h
iD769T1Yf37M3qb92z7Fb6/fvrlzRKXiYlLTyidKSoT9kpBQbTFPQ0sYAP/5pKqxrWD+kz59
vP2NTyPgu5EyltnT7z++P+3zZ9Sgg0yePr/+a7pr8/r27evT77enL7fbx9vH/3r6drtZMZ1u
b3+rs7+fv77fnj59+fOrnfsxHGlNDVKXLCblXAgeAfUkel144hOtOIg9Tx7A3LHMA5PMZGKt
W5sc/C1anpJJ0phPtlDOXGI0ud+6opanyhOryEWXCJ6rypTMAEz2Ga+t8NQ4Qx6gimJPDYGM
Dt1+Ha5IRXTCEtns8+tfn7785b75qhRREm9pRapJjtWYgGY1uRussTPXM++4Ot4tf90yZAnG
FyiIwKZOFRmKMXhn3h7UGCOKRduhfTl7wJkwFSfr0ngOcRTJMW0ZFzlziKQTOQxDeeqmyeZF
6ZdE3Vqzk1PEwwzhP48zpCwdI0Oqqeu31+/QsT8/Hd9+3J7y13+Z/ifmz1r4Z21tH91jlLVk
4K5fOQKi9FwRRSt8HCXLZ8u0UCqyEKBdPt6Mh1CVGswq6A351Y4qucSRiwxdrnYZrIpRxMOq
UyEeVp0K8ZOq0wYUXo5wTXr1fWVtjs9w2l/LSjIELpPhPW2Gqg6OV9CZc2zbSxwydRI6daIf
ynn9+Nft+38mP17ffnlHv37YJE/vt//58Qk9lWBD6SDzjZDvauC4fcFHuj6OR73thMDkzuoT
Pjbjr97Q11V0DNR+0V+4HUjhjoOwmWkbdMxWZFKmOEk/uNU+xqryXCWZrUBQamEylgoehWbx
EE7+Z4bqqDvjqDTjo7wm8aEpuVkvWJA3PPHUtU7carD5G0hdtYa310whdcdxwjIhnQ6E0qRk
iLWIOimtEwtqDFNevTjMdbRocI5HDIPjOtJIiQymG3sf2TxH1huTBkeX081sniJzR9dg1Jzy
lDpGiGbx+Jv2pZy6M8Qp7hpmDT1PjXZBsWXptKhTaqJp5tAmGdQRNdQ1ec6sZQ6DyWrTZYZJ
8OFTECJvuSZyaDM+j9sgNA962tQq4qvkqPxae3J/4fGuY3FU1bUo0QHEI/7ht0XN18zEd1KE
fONZIfiy2kEeZnIMQ41HJ0xADWI3xM8zE+z4iraCfPh3wvCSYYRZ/jwpCJLzSuI5l54Eqj2+
txPzglvE7dD5RFO5I+eZSm48qk9zwQpvknv7C4bZLj3f9533u1KcC4+U1nkYLSKWqtpsvV3x
ovn/lF1bc9s4sv4rrnnarTqpFUmRoh7mgQQpiSveTFCynBdW1tFkXOPYKduzOzm//qDBi7qB
prznJY6+Dzc27kCj+1ZEB74R3KrJAI4I+TG5FnV4MndVAxdt+AEZCCWWJDHPc6aBPm2aCEy/
5OQOEQe5L+KKn15mhh7tfIMagEXsSU0g1l50GO3vZiRd1fR+DlNFmZUpX3cQTczEO8F5tNp0
8AXJ5C62lpmjQOTBsTbMQwW2fLM+1Mkq3CxWHh/NOoik57fsSiAtssDITEGuMfdGyaG1G9tR
mhObWthZW5M83VYtvbHUsLlyGqdRcb8SgWdycKVm1HaWGJeEAOo5Nc3NBqDv7xO1WsojY7sj
M6n+HLfmwD3CnVXzuVFwtfItRXrM4iZqzSk7q+6iRknFgKkfSi30nVQrPX32tclO7cHY1w82
nTbGOHuvwhnVkn7WYjgZlQpHteqv6zvm9LOTmYD/eL45CI3MMsCKYVoEWbkHI5ppw3yK2EWV
JPf5ugZas7PCLR1zEiNOoJVBsUMabfPUSuJ0gIOlAjf5+vefb48PX5767Tbf5usdKtu4FbSZ
sqr7XESaIaO44y67glvQHEJYnEqG4pAMWJnvjsQsVRvtjhUNOUH9NoEzqz6u+72FsdgtZGFf
qYChkC48OQH9OC1VtddR68z0zp61+p0Hh3Fbw4FhN4c4FnjgSuU1nidBap3WHHIZdjx8Kw9F
1xt0lyicvYe5tJXz6+OP38+vqrVcbmtoU9lAxzBHtPEOwdpgbhsbG0/YDZScrtuRLrTRJ8Em
zMro8sXRTgEwz5ysS+bEUKMqur6UMNKAghvjSJyIITN6TsOezUBg+8KxSHzfC6wSq9nXdVcu
C1JLTxMRGhWzrfbGwJFu3QXfjE+ZGsQMQfaeB6w9fZ7FYBGukkRxR7cE+25hoyb2Ljf6/tgK
TTSFac0EDQsdQ6JM/E1Xxebwv+lKu0SpDdW7ylruqICp/TWHWNoBmzLJpAkWYCKIva7YWD17
0x0i4XCY5T1xolwLOwqrDMSmeY9Zl+4b/gZo07WmoPr/moUfUbZWJtJqGhNjV9tEWbU3MVYl
YoatpikAU1uXyGaVTwzXRCZyvq6nIBvVDTpzN4DYWalybcMg2UZCw7izpN1GEGk1Fpyq2d4Q
x7YoxPdNixzzgX7M7BmgHgVmTv3S1lgzKYCrZID7+iVJb6GVzWbcj48bORtgcygF7KOuBMGt
44OMBiuz86GGTjafF3hzsK8YjESG6pkNIZLe7Kce5K+kU1b7LLrCq06v1mFXAmgVxCs8KBDN
s0m8ra/Qd2ksosK6edCLnZf/aGewT7Ag/nnz5fnrTfvzx/kTYzimva/xS0L9szsI85hGbag6
qiY5LSrJKvdwF5MfoCVAAVAmoEjmLMMFmssL7BO4vmvAV0fKgTIJV+HKho2TaBW1i6kLhQka
VZWmK1IJqvPU+wcEHnY+/TVbIf4hk39AyI/VfyCysYoGSCZEDBPUDZ7+pCQKVBe+NqM1mah2
VGYodN5uCo6o1GqmiSTeOlOyxe9cLhQoOJciZfM6RUdvjnA5YgN/8fkGEgO4uaEE3Pt1O0Mo
bbZR82FCQduToU64tgTey04YaYp45RiFOmaRCm4JObkzf3MSV6h5OTnAe8+ObzULXbn4Wa8u
0IFuVQA7yJ0wkWSXBWrnaoQctUPsxjQQZJuq5Tz4N7diDCZ1KUh00S6VekpLfL5SpIVsM9It
B4SebhXn7y+vP+X748Mf9vg1RTmU+uCySeUBe6YspGpJVveXE2Ll8HGPHnPUba+QTPH/qXU4
ys7DJ/cT25CN1gVmK8VkSc2AGifV5tZakNouMod1hk69ZuIGTptKOI7b3cGBTrlNJ5UCFcKW
uY5mWxPTcCS9YOlHZh6iCIghkwvqm6ioBb7g15h29LjgQM8GiSklDRatyt0MqbJZ+54ZdEAN
P4GaYqC89tbLJQP6Zrp57funk6XNO3Guw4HW1ykwsJMOiR/YESTuFkeQ2BC5fLFv1uOAch8N
VOCZEXpnl/A8vz2Yjc98h6xB0xfnBFqyS9QmwF3KBX7C2ZcEe/nUSJNuDzk9mu2bWuKGC0tw
reevTRFbrjn7FmQ+OezVjUUU+NgzZI/mwl+TB/d9EtFptQqs/LR70bWZBrRt/y8DrFqidddH
T8uN68R4ZtL4vk3cYG1+cSY9Z5N7ztos3ED0/liMnq8VFv/19Pj8x9+cv+v1ZbONNa/Wnn8+
fwVtHfvp3s3fLi8Y/m6MHTGcKZtVJ+/Bg7sBHqTeZk0lal8fv32zB6NB79tsd6M6uOG0j3Bq
30t1Cwmrtln7Gapokxlml6r1Y0w0EAjPPNwhPLHpTBimN04lHRTztQi1vB5/vIMy0dvNey+0
S3WV5/ffHp/e1f8eXp5/e/x28zeQ7fsX8K9k1tUkwyYqZUa8+NBCR0rG5rg/knVUYrWRfoWb
xVmeYWfokePcq+koAj/xth5Kpv4t1RoEG/u9YLqlqM50hexzZfn0VH8Yps8An6AgUnuGL+B/
dbTN8DsmFChKkkGOH9DMURQKV7Q7Ec0z5nYD8eK0xWfMJvNBzCXLZMtFhpfBOdgKYapKEf5H
dVim/Bcr/ErZKtGQI2NEHYveY8JxNkRWV9jtisl0gq/vnpwvE+K1njUbSDb1HN7yqUo8jBkE
igJf2zUntvN0cXlqO3wx0LSC+p4BwFhDArQTahdwz4OjD9hfXt8fFr/gABKu3PDGBIHzsQzJ
AlQe+86nxzYF3Dw+qxHsty9EqRoCZmW7gRw2RlE1TveVE0zcy2K0O2Sp4T9Ul685kjMBeDwG
ZbLWymNge7lMGI6I4tj/nOJXexfmxMaIG6G2CzETQXorbJNhxBPpeHj9QnG1HyCLVYMVajI4
4DfsmMdmOyje3SUtywUrpoS7+yL0A0YG5gJ3xNV6KiDGUBARrrmPtRy8E2LN50HXbIhQazxs
UWpkmn24YFJqpC887rszmTsuF6MnuMo8KZz5ilpsqPUeQiw42WpmlggZolg6bcgJXeN8lce3
nru3Ycu405R5lBeRZCKAI/gwYPqDZtYOk5ZiwsUC2xCaakT4LfuJUu0214vIJjYFNa46paQ6
KZe3wv2Qy1mF55phWngLl2lszTEk5o2ngvoX/0B1dn1YgvpZz9TneqYLL+YGEqbsgC+Z9DU+
M/Cs+c4brB2uX62Jje2LLJczMg4ctk6gHy5nhxPmi1VXcB2uWxWiXq0NUTCG3KFq4GD+w5kj
kR5RfaT43BjdF49tNaoC14JJsGemBOmd/wdFdFxu0FO47zC1ALjPt4og9LtNVGQ5P68E+gxg
ugkhzJq9LEFBVm7ofxhm+V+ECWkYHKL/Au3BvUm35mjVs3ptwtFjEdjadpcLrkMaByYE5zqk
wrmRXbZ7Z9VGXA9Yhi1XuYB73KypcGzdc8JlEbjcp8W3y5DrYU3tC65vQzNlunB/AMXjPhNe
1il+A406DkyK7KrLc7iFRXkQ7ILj8315W0w+jF+eP6l9/fV+FMli7QZMUoPjOIbItmC7o2I+
RHrCBntndoxMm6XD4VHruVG9WrDr03btNKrA3LcDBz78bMZ6QzIVoQ19Lil5KAPmyxV8YuDi
yBSm904WMt+wadX/2FlaVLv1wvG4JYJsi5prOBGDwsHhiZNsbxedW9cKd8lFUITncoTaPrA5
GK5mptKXR2bcKSrqRHrC28DjVronqEemz648rstqzz2MjHmZNW3i9EeUkyEyeX5+e3m93nuQ
/RA48Lukq3bDF2MXFmbuNRFzJPdQ8LIyMV/xRvK+FF176tISnjjp+5MSPFDeZS3WdoUdee+G
lGLaq7V+z6Tj0RKSl3Bw/wOea+SWnGWAv1EFoA4Vg4pQHHVNhNVbhvaMzQBDDmYzHLHQwOir
S+36MnKckxHK6KuD60xSXu3pkZ7GFFt4CN0ZRzTajIrCAjTr7T0aqii0ZzgDaSmiGiseH8EH
HwlQxvVmkOIFrMFIFnE5qZ1PUcjTXdUQf+9yyVl0EQmsmmTcGYiWGZi0UtXVEIJKSHc2Gvmz
IVat+rsDeXXFFj9RuBCoqu50mQ0F0QG1g5EbyZ080JxH/VUqGi29tIsjrCM8oCiuiBojU6QO
azDyMPyeeqN4ejw/v3O9kX4u+DvHmuuXzjh2kjHJ+LCx7d7oREGdGZXlTqOoGx5O1pMD1acb
aoUrWdKeBU0/kiLLDGtdrRPs8RKkjkrssF3/nJ4uLQy4qXRZfQr3F7tdkUpJ1Ph6NgYTLyP3
y3QUdyDKqWB4HCsiAFAPc3rW3FIiKdKCJSKsbwSATBtR4WMuna7ImOemiijT9mQEbQ5E81BB
xSbAtjthkFVTRHYkV0SA6u/TlX98fFXVbs8ufSjaBy6YpZs4UDE4bMf7sgE33JwPaFFgOSOw
EwUYN0ttY00Pry9vL7+93+x+/ji/fjrefPvz/PaOrFFN+5bdfZ3CYkCK2lDQmwY288ai0c8v
+3PN1yS6+fH68v7y8PKEpJI15NlN1hDtUf1cq6Apdoe8bWi6VkfT4UQkdmmXR7LtcoknHc1u
AG8aAyXzdPb82+uX1/PXT/2b6N5kzKVe+9131tjMlGLb3oO1/WlceHn+9nS2TX0lVbnFg0Iq
MwuLRJvp83EDb9N9ExU2XGWF3tabRK4NZZV7i1AT5GJhodusgQeVVmB42uzawat8tF3KfYBa
4dtJqbBbNd3buEyiz5/VSsgm1v76gmrJbq5Ug3760uCXwNpDAiwLNvj186iaRMBjruqCIIWQ
FKibTBYuVahRzTbF+sL9b3OFOKH9jauaM1TRPqfdPv7VXSzDK8GK6IRDLoygRQYu181xaiDj
qkwskM5rA2i9aR3wXrnWJe7VRkqqvWRZW3gmo9kC1SIn1twRjAdfDAcsjA9PL3Do2MXUMJtI
iBe2E1x4XFGios6Fduukeo76wpkAaiPmBdf5wGN5NX4Tsz4Ytj8qiQSLSicobPEqfBGyueoY
HMqVBQLP4MGSK07rEid7CGbagIZtwWvY5+EVC2OPISNcqBEyslv3JveZFhPBiiOrHLez2wdw
WdZUHSO2TKvauou9sCgRnODYpbKIohYB19ySW8e1BpmuVEzbqZ2Cb9fCwNlZaKJg8h4JJ7AH
CcXlUVwLttWoThLZURSaRGwHLLjcFXzgBAL677eehUufHQmy2aEmdH2fLsEm2ap/7iK11U4q
e4TWbAQJOwuPaRsX2me6AqaZFoLpgKv1iQ5Odiu+0O71olEPIRbtOe5V2mc6LaJPbNFykHVA
rh8ptzp5s/HUAM1JQ3NrhxksLhyXHxysZQ7RyDY5VgIjZ7e+C8eVc+CC2TS7hGnpZEphGyqa
Uq7yakq5xmfu7IQGJDOVCrCOLWZL3s8nXJZJ6y24GeK+1HrgzoJpO1u1gNnVzBJK7chOdsEz
UfeDBFOs27iKmsTlivDPhhfSHtTGDvRp1igFbQ5Xz27z3ByT2MNmzxTzkQouVpEuue8pwBjj
rQWrcTvwXXti1DgjfMCJignCVzzezwucLEs9InMtpme4aaBpE5/pjDJghvuCPLC9JK22vmru
4WYYkc2vRZXM9fKHPOYgLZwhSt3MuhX4q55loU8vZ/heejynd+82c3uIegP80W3N8frYa+Yj
k3bNLYpLHSvgRnqFJwe74nsYttIzlN5pWdyx2Idcp1ezs92pYMrm53FmEbLv/xItNGZkvTaq
8tU+W2szTe8CN63aU6zdw6/fEQIFNH53ormvW1XXoqjnuHafzXJ3KaUg05QiahKLJYLCleMi
DeFG7X3CFBUUfqn53TCs24Sh68Y06R2o1IDnPILWu/ukMMG7bDNshIlpxKZVizks52MbBKrm
v5Pfgfrdn81k1c3b+2ARlR7JRA8P56fz68v38zs5B4iSTHVsF7fuEfJsaG1B+najz+H5y9PL
N7C0+PXx2+P7lydQf1ZFMPNTk3+Ak4HfXbaJBNhFaqI8x2exhCZvzBRDDnvVb7J5Vb8drKGv
fvdWDnBhx5L+6/HT18fX8wOcmM0Uu115NHkNmGXqwd7FWH9O+OXHlweVx/PD+b8QDdmt6N/0
C1bLYEw40eVVf/oE5c/n99/Pb48kvXXokfjq9/ISv4/47efry9vDy4/zzZu+BbTaxiKYpFae
3//z8vqHlt7P/z2//s9N9v3H+av+OMF+kb/WB+39C4PHb7+/27m0Mnf/Wv011YyqhH+Dqc7z
67efN7q5QnPOBE42XREPcj2wNIHQBNYUCM0oCqDu4UYQaRY157eXJ3i38WFtunJNatOVDhll
e8SZpDu+vrj5BJ34+atqoc/I0Owm7mRBHOop5LS9qDz9OH/5488fUJg3sIn69uN8fvgd3bPU
abQ/YM+nPTC4q4pE2eK5w2bxsG6wdZVjR0QGe0jqtpljY6yvT6kkFW2+v8Kmp/YKq8r7fYa8
kuw+vZ//0PxKROo5x+DqfXWYZdtT3cx/CFhSQWR/n9DBrIovdN3+segCa9klR7ABpRb5a9Tw
86wR9q2ERj9nvX/rYYT8+vry+BXf/u3o+wx8AaN+aLXztID3OTUlRNQcU/X9HLU7lHsOLyID
HT9c71tQwdu02yaF2m2eLrW9yZoUTOhZVkU2d3D5UESnrq1aMBioLXgHS5vXHuV62ptMIBWt
VjIs+9cg7ho/G0ZUVSZZmgr8aAwucL7jXzqTOrrPqyj51VmA876A8DLNN/r8mUaDptLhdVKy
xRelW9lt6m0EF45kDVaATPN9d8rLE/zn7jMWohpIWtx4+99dtC0cN1juu01ucXESgMPtpUXs
TmqSWcQlT6ysXDXuezM4E16tY9cOVrJDuOcuZnCfx5cz4bH1W4Qvwzk8sPBaJGrqsAXURGG4
sosjg2ThRnbyCnccl8F3jrOwc5UycdxwzeJEh5jgfDqc1DTuMcUB3GfwdrXy/IbFw/XRwtus
vCe39SOey9Bd2NI8CCdw7GwVTDSXR7hOVPAVk86d9rRYtbQXbHJsXmgIuonh3+FxzUTeZblw
yPHDiGirFxyMl44TurvrqioGDR18vUbMbMMvqlwSZUUnyCsbQNR4cVc1ewrK6oBvugA6LnPs
wlDtTpKsMBCyLAKA3Ozt5Yqo+W2b9J5YLhmALpWuDRpmukYYBrEGGyYdCTW865dnNkNMDo2g
8Rh0gvGR9gWs6pgYSh0Zw1XgCBMnnCNoW7CcvqnJkm2aUAuCI0nfn44okfxUmjtGLpIVI2lm
I0htsEwortOpdhqxQ6IG/bdjlqQVbYGDpYruKHbZ7Qw8uuCCd55qWYMmd52gbe1i2MTDQzEh
mpSaHPx/WuHpWoFdtUwYPpzrwd5SIWqndbbE6kJip1plOrkewidJTQU2xLRqEumNI1GrEQYf
7OV7+DbV6MjCfBcdUz1b101ak3Z+mclHUYiX79/VnlU8vTz8cbN5/fL9DDu0y7ejud9U4UYU
HIhFLdHBAljWxHsvQDuZ7Nkk7MdZiDTeZyFmlwXEPAKipKgznsh8MtVQyrgZRcxqwTIiEelq
wRccOPJ6DXMSjs87UbPsNi2ycqb8blFLclWjwPYuDxZLvoSgP6n+btOSxrmtmuyWjTEqEE+K
SogrTzWjqIQCmE/BMHVXzKRan3hjXjhIJjz3etbVqZzJ+Sh8+vEwEAVE3X5E91UZsWkYdo/G
8OJ+W+LJasRLWXOga4OymWncqp0G4ugt+HrV/HqOCoLZWKt1KI7mkS3qUi55wpGCQeRdhq2O
yfYQs4FROnElictcRNleX/BIAFtT4mIJk627WvB9t6e6oiDPoO0AWbH9IMRR7f4/CLLLNh+E
SNvdByHipJ4PEazWqyvU1c/UAa5+pg5x/TP7IGl5JUjoePzQBtQKTXlazXmbSMGGBhatKOvb
bitEp0b8JUWLwoKzIfBygftBNiWB350CmrNoHxZvRsGAs0ZJJ/q/yq6tuW1cSf8VV57OqdqZ
6G7pYR4okpIY8xaCkhW/sDyOJnFNbGd9OZvZX7/dAEl1N5qZ2SpXyfy6CYIA2GgAfelR5ux4
RiVv6qOR410tqKUNoqmPQgnulb2C3eNkhVtm9T1WKx1dqEVQ2M6/zuxbBT0jW6TFWXwQcq66
CcSUVS2Dy2kw80Hm83AGpxo4V8DLpQauFHClPWil1PNyJV/HglrlV1qVvBa1oGQ1O2gQWSW0
wofpWD6/g0GB2Oqk6QAJ9FO4ywZYNPSwhHYq3AkDgs1LHrUudWqUHHRtyEsj7SLvoQvYYsaV
U8GwjzAfASpNdEaxLh7jkXqno02GabOpTkPPNVgu7Bk0HyVNgHUU+AxgrIBk90tYAOd07MFL
gCdTFZ7q8HJaa/hO5T5MjQZH8USDq5n/Kit8pA8jNwdJP9dojlOmYmjt86TcJXQRvLvGLU8a
68+tQ8zT27NmdGwjRTG3K4eAWrbmSw9ThcJuv1tJimhTnb4n8d510yNcw1y0luimrrNqBCNB
4Flsinwh0eI6lZAbSz4II2lnBOx8MSVzG/yzqetQklrPVe8O107RGrMYQiOGGe3OtDSX4/HR
K6tOA3PpvefRSMgmoZ9IFHRi3FgXKPqTbe2WB56M/301G5vQ2Mkwj7FMTB2Eu6TwKDAuWVCL
Fs5L4w+ekurpQdW2qdGwZjFbJzWlZO3AhAUw3SsEwuEyswcdLrJmv8oJ6gydgxItN6OjMWsQ
V8dWnPLNHPTg29SZN+RwYdRUpddNWX010OAfcIcG60QG5K59sTDT0KzeUz/SdjqAZUCmMNd0
tMV9izFrM1cRfXfBdjXN8rVbTvGryKqlglGFrQXLvd+iNTryksYJknRdEG2x27Rpsh218YBh
iHkLm4wxdz6hDGyLFL4BVkEOytCAPiqcRcsoFEUkIGn3JB+9y2mJJ973dxeWeFHefjnZ+HJ+
Ogh3NzpIbWue909S3Hg1f8twPmvqz7gfnl5P35+f7hR/4Dgr6rhdSDvu7w8vXxTGMjM0yBRe
2p0xibnFhXW/yWGYHOKfMFTlOfpKEV78y/z18np6uCgeL8Kv99//jYfed/d/QDN6gWVRZpfo
EgQdmJtmF6elFOlncveM4OHb0xcozTwp24p2bmi2xwZqkuQbIq7QPx/R5uz9uH5+uv189/Sg
F4W85/BSLr7gr9lRZ06y4yWvKxEFUJEqCDdbjpqwXanaoj++3X6DqvykLt56AcNH+lo8Qeca
SlX2M0p1doKOVXSiojMVVetAFXeCshgy6PQW0oHpGBnUy4httVFQrT+wJYdUZsbfTyNOeTUV
jzxPimMJ3ux82g8zwnVDjT9vjpPVQh8wiMWHTRV/7IZGe3mxfYJB8cjsdFpSsy0ObRB4POi2
YRmJdkWY4PtCURuwiOaMAY9UTHAYIGNISFMGg3cHxjhhwWruffg4m7eNbpMf9S/sNUITH1gE
TgZ3ZeQF3fBVWcqSTY3HOjyH/Il/vN49PbaRDvzKOmbQvmH6ZsdQHaFKbtjuZocfywmN19bC
/ESpBbPgOJ7NLy81wnRK7UrPuIitSwnLmUrgIdxaXO4st7AV8KbMnI+eR67q5QrW1R5usvmc
ntO0cJciTCOE3VEMVfGzgsbZ67SyjFXEdqxhx5EJfUSCbsk2ZZaGNTTNPcJXm2RjiRxuI7qC
aqyV5f5lcUvP93isGKkddNvSRpd1LBPKYq69M+wWVks8V637Sn5qV7rOgjE1z4Rrts+8zsLx
fORyBesoP/hkFHakGQUse1UEq3QylURZUEX0cMcBKwHQYy4S6cQ9jhqnXB1NtBKXvD4OYpW/
OoYfrsajMU1IEE4nPDlDAJPo3AN4QR0osi0El3ybMwuWM2o5CsBqPh83/Mi2RSVAK3kMZyNq
NALAglmemzDgbiymvlpOqRk9Autg/v82E3b+yDBEUxrfFa14F9zKd7Iai2tm93k5u+T8l+L+
S3H/JRV0aFVMk6DA9WrC6Ssa7juwuRhRfkttMMiCeTQRFJDao6OPLZccw2WEPbvicGgtRsYC
xKg/HIqCFX4725KjaS6qE+eHOC1KjIdQxyGzX+j28Sg77hmkFU5VDMYFbHaczDm6S2CeIANn
d2TezajTimZzIUglFo6Xx6MHYugmAdbhZHY5FgCLcY8AnaNwXmShIBEYs6BkDllyYEqN0QBY
MYOkLCynE+oehMCMRhjtzsvwzAamZQx2wts5zpubsWwKt/owQcXQPNhfMi9oN+PKvrcT7iFw
mZpYhMPzVJz4d1j8wHAb543XzMXycYVTedPjZ8huNIaj5VjBqOl6h83MiJrCOXg8GU+XHjha
mvHIK2I8WRoW0a+FF2PuRmVhA0uKkcSWi6V4mMtUKt+rTsPZnJoRtpFXMYp6yNAFoqKDDpuF
jXFEoaTErKBol8pwl36xacdMu2z9/g1WwUKiLqeL3nsg/Hp6sMldjWf0j/uDTblrp0AqbQxz
Rk+Cj7x/DzdLKgqtGtLavbiyjBgQCkdXv9395y4qGTq1OCuXcyXJFO20HT6IBVnVZzLT14q4
axhTds+Vz7TKkSnJu+BDhTJ2ZtjthcpnavFAncamdkFrm681/Hl75HOm+77Sst3hO+tonasH
zLm3bvbVp9z5iLpvwvWUahV4zR1u5rPJmF/PFuKaeVzM56tJJYJWtagApgIY8XotJrOKNxQK
8wV3dpkzYyS4vqSKC14vxuKaP0UqBlPuEbVkERuisqgx1oQ/VzEwW0ymtJowXczHfMqZLyd8
+phdUgMkBFYTpmDZ0GmBJ4EjLwaZkyrROcwXfluf3x4e/mq3gfhod0lc4wOzO7JD0i3/hWuC
pLiFgvxAKEO/yHHhap5P//12erz7q3dm+l/0hoki875M086RzZ0w2d3S29en5/fR/cvr8/3v
b+i6xXyfXFRuF2f36+3L6ZcUbjx9vkifnr5f/AtK/PfFH/0TX8gTaSmb2fSsuv5zlyn+nSDE
Ylh30EJCE/7BHSszm7NF03a88K7lQsli7Osg8nD7qSrYgiYr99MRfUgLqELK3R0cE9mrLQnd
UH5Chkp55Ho7dYZMTu6fbr+9fiWzUoc+v15Ut6+ni+zp8f6VN/kmns3Yp2mBGfuopiOpxyEy
6R/79nD/+f71L6VDs8mUGnVEu5pOgjvUNKh2R5p6t8eEmjQFy642E/pxu2thW+0w3n/1nt5m
kku2KsPrSd+ECXwZr5gu6OF0+/L2fHo4Pb5evEGrecN0NvLG5Iyv2RMx3BJluCXecLvKjlS0
JvkBB9XCDiq2Z0IJbLQRgjYfpiZbROY4hKtDt6N55eGL8wwdFBUyasCHMYg+QLezjYcgBUFP
A9oHZWRWzBLQIsw2aL0bMw8/vKY9EoJcH1MflDDj4cvhmuVig+sFHSp4vaBrfqqDWUN5PIwn
LbstJ0EJoysYjcheVa/ImHSyGtEFEafQpHQWGdOpjG600NisBOeV+WACUPbpEWVZjVhyt+7x
Xva6umIe/CAAZjxYRFFiQA7CUsKzJiOOmWQ8Zkcd9dV0SveO6tBMZ9QC2QI0BUVXQ3R7ZVkg
LLDkwGxOXW32Zj5eTojsPoR5yt/iEGewnqCGzod0MT77PWe3Xx5Pr263ThnGV9z6zF5Tpelq
tFrRQd7uymXBNldBdQ/PEvgOVrCdjge24JA7rossrkGpnfJcpNP5hFqatV+6LV+fhbo6/Yys
TFJdn+2ycM62uwWBv64kEifi7O3b6/33b6cf/GAPlyX7PjJz8nj37f5xqK/oGicPYQmoNBHh
cVu9TVXUQZ2cjyP+xucYa7Sr2vN+bRVlU0FX+7LWyXxJ8hOWnzDUKJXQL2fgfhvu/0ximtr3
p1eY/e693ekIw7PxXZs58+1zAFXMQe0eT4Vizr7OukypSiGrAM1LZ+A0K1etu5hTUZ9PLzhb
Kx/luhwtRtmWfkflhM/TeC2/NYt5s10n69dBVagDpaxYirZdydqpTMfMxNVeiz1qh/EPvEyn
/EYz57tk9loU5DBeEGDTSzmCZKUpqioDjsJKrudMidyVk9GC3HhTBjDRLjyAF9+B5FO3GsMj
hjDwe9ZMV3ZPtB0BTz/uH1AJRV+mz/cvLmiEd1eaREFlI5Y21ETXVBuq85rjikVdQ/Ky/+pP
D99x+aSONxj6SdbUu7jKirDYs2TfNAh8TB24svS4Gi3YxJeVI3ruYq9Jz9Xw4dKp1V7TyS2n
qbbgoklomiMEyiTflgU9XEe0LopU8MX0yN7yYB5AHsXzkMVtsnXbRHB5sX6+//xFOaRF1jBY
jcMjTbiBaG0w3TrHNsFVzEp9un3+rBWaIDeoe3PKPXRQjLx7lrAOkTIp6N4vtSuDC5m2DSFn
nLZLwyj0+ftzBw53poUClQerCLbWbBzcJetDzaGEyjcEbO7fKcfQkgXDgAvUczdB1KbRpdv9
CHKLDou0Nm7MmMw2Fc+p0ENQMQ8tYwGhLSiH6uvUAzCJJ5FM1Uc0JCHKVpU12yS0gQLy6rdx
rwRbs76ARu6uDazbRg0LBh7f5KXBAtgjeiNeKCBiQaXLILxqmM+u22uubaBOKklsTAXMwRjW
NLaCczOCi7oq0pSOTEcJ6h21B3LgOq5AdZEodzJ0GJ4QSSwN8po6wLWo23iTsD0wkaBia+oI
pggxkIIHi1QbDhTJUixYJ17OXUfwzagd7ux0PPRT7nv4dR5dqotYR2z9us4plly10E63WZeZ
5gO4oTYPcGFlF3NkRRB0rQOPqgHgdYUTUoyGgRmnnJ1h3TS3+3Rh3n5/sYZ7Z3nWRqPnjtFw
0W+jolVHUW85UeRJQch283JtnSQUSrM9pgrNuQBi5D3h6mxty63DhVcz5w2oFHYmTDkhNxPx
iA51gekiUU6FroUsvynCrmu5s7ZtKfs1gJDbizq1GXou59YCJt0bXCd4r5Md4vW+Ccuxc8jw
6OUxaCbLHMS3oUKFkZSGtcfRXl3tceJHqkGcUb8Qi2MT7cwgQdapCqzBqPfks3ON3z+9NV+S
54XyMmdrP68Te5L1Iee09vA8Kp2fu0rMElh2DpP9B3ZmSm0t+8/8fNMM06QgWfXLJXzH8eSf
8M0nc788WqPanQbDMmmE7yMH0Jk+G6Anu9nokncZZsbpJhV/zNbA24bQ6lC0KWR5jzJqe5W5
8KEccCbjTjqdnjEhn9W8H9xWs5+ZoKImbPVun0d4MJuebaK80El5VBXUSLMFmnWC93KbcUHr
clO8+/0es4v/19f/af/5z+Nn99+74VKb6YR7NvgcxPa7ZYoCMnd2eYHpJc7FsJJSYVgyULcy
R+hkuJweOFW5EU1MRImoBMabPT1DdGJjw8vuP0jB7ApGEa1W1R2RCRJ3gKgzPyiXjatShUpi
dUJTMtcT6gYWJcwYz+Zoqnc+wkdwj25VXqOiIDu0cmutXJGfgatFeIXJFlk0MAtmWxhgYTwT
mxA9rfWuCA/lMLE0Azd76pmkoFufQm2NJfRCUdfSXs8FbSFfUVs5/IDECatHsh4nZ3r7/BK/
a7e4Ph9/msQXNRvqtA8XsBqwsze3byUEZnaAuGHO2fU5iAr8q/g0YLhoqNXxXC+yV6nxo+XL
9nI1oTnBAOQVRKR153Pveo8BCq0K+EJfFj1UqOyOj/WkoUvWFmiOQU3jI3VwWZgEKhSmPsnE
4b5ip3FAmcrCp8OlTAdLmclSZsOlzH5SSpzbgDfsU+puGaSJr/PDOprwK+/7BWVjbdMA0bUG
5rgHCsvq3oHAGl4puLVI5J4vpCDZR5SktA0l++3zQdTtg17Ih8GbZTMhI26FoycfKfconoPX
H/cFVcGP+qMRpvtJR/+hCAUG3rKGhRVbO283ho/zFmjQQRKjHkYp+YhBwgn2DmmKCdV2erh3
pWha9V/hwebwinQhiUG2XLFwWZRI67Gu5SDqEK3JepodYK0TKeu5nqPao61jDkTreOc9QLS0
A11bkxk+SWXDbSaivhbAptDY5JDuYOXdOpI/Gi3FvbH2CO1DtzRryMY0BHeLTX+U5B/iUNxk
uCY3JJJwG5TLL4c0axthoKDOtZj6rhuTRLqDWom+v58G6ENvZfKiTjakaSIJJA4QO52bQPJ1
iDXYN9bpIUuMSZh9nviO7SXGyLPrRHuQtWHNW1YAtmzXQZWzd3KwGHYOrF2ksg7bZHVzGEtg
Iu4Kaxr1el8XG8OnFdRiGRAytbY4xFUafOJSocdAukZJBSOkiWiSLsKAC4L+5DG8vft6YhOz
mC9aQMqMDt6BWC22VZD5JG8ycnCxxvHbpAlzk0YSDimjYV7esDOFPt+9UPQLLA7eR4fIqh6e
5pGYYrVYjPgUU6QJ3SG9ASZK30ebRl7naX+AEBXmPUj593mtP3IjRExm4A6GHCQLXnf5zsIi
ijHl4G+z6aVGTwrcdzPwAu/uX56Wy/nql/E7jXFfb8iBRV4LeWgB0dIWq667Ny1fTm+fny7+
0N7SqgjszAGBK640Www3S+k3YEF8wyYrQO5TS2RLgrVdGlXUMvEqrnL6KHHaUWeld6lJREfo
JP050+N+C6Ji3QzkeXQ/ovFsxjk7JG1oZPppVpgvVLAHkQ64tu6wjWCKrWTVoTbpKJNcO3E/
XJfpfghT521ZcQvIKVhW09Pg5FzcIW1JIw+3e8zSMe5MxRSAINDYxOCoBpbrQeXB/oTe46pu
2SlKioKJJNw0xXNljF9d2LnOe7kbZmfmsPSmkFDFM2y34H5tT0r6Edk+FfNQNHmRa6OSssB0
VrTVVovA1InqDiBl2gSHYl9BlZWHQf1EH3cIJndCN+DItZHCwBqhR3lzOTjAtiHBE+Q9mqbR
E/2uC2GWYELj4z4wOw1xyk03EZ5dthnZzbKa83bHhuv+rITWbjN1+gW1HHYprnaIyok6T1ju
f/ZoMdh7nDdzD6c3MxUtFPR4o5Vr6kiBZ1e4qbm2MTlvYoUhztZxFMXavZsq2Gboat3qH1jA
tJ8w5eoNI3AeVaSNNAGjJUpoqt0ik9KxFMDH/DjzoYUOCZlYecU7BCMOo8/vJ6dz01EhGbI6
UseEV1BR75Sx4NhAQK156J0SFCY2JdtrOzJ6uUar1dJhMPRk/fSg45upfJwrlHunLc4DibSg
3C5tYaZ0wrR74AJJCignFuzEwlHRc/GxkPOZRQQba8M2/LauAORSz4Jruiiw11N5zWcki834
tbmm+2eOoxl7CD3YyjvhBUsBlqXCUuRAsdxpfKR3PMjnNdbLAz9Ua23YJFEbfOK3d3+enh9P
3359ev7yzrsrSzCIFBPdLa0T3JheijqMV5hZPZcN6a1XcrcH0oY6hHWmuEEquBsT8SvoG6/t
I9lBkdZDkeyiyLahgGwry/a3FBOaRCV0naASf9Jk7uahXYNtZRMxgRpV0CwbUDt56Q09eHN/
XkaCdM8z+7xiOVbsdbOlJnwthgINFjJ5Tt+gpfGhDgi8MRbSXFXruccturhFbTqNKmLp2OJy
xxfaDhBDqkU1TTFM2O2Jv7l2xiYCvI4DjLLc7GC+E6R9GQapeIyc0y1mqyQwr4Le8rnHZJXc
Nh8GbLdxfyV1qGYmWzOHiDBRv8yw5HIwtMsynMdqDAHAd10cFda2depvMzmiqavCR3EY5t5j
CtBrfdRk8DKwGPfKSD0oPtYVj1cdBXwFJ1d0fsMHWrOseKvYS41FG36O4Ku6vP6p6bYAtB0C
JHdbDM2MWtwyyuUwhfoNMMqSOrgIymSQMlzaUA2Wi8HnUO8kQRmsAXXVEJTZIGWw1jQGhaCs
Biir6dA9q8EWXU2H3mc1G3rO8lK8T2IKHB00xTe7YTwZfD6QRFMHJkwSvfyxDk90eKrDA3Wf
6/BChy91eDVQ74GqjAfqMhaVuSqSZVMp2J5jmEsS9He6XOngMIYVYKjheR3vqaV/T6kK0LTU
sj5VSZpqpW2DWMermJrfdnACtWLBwXpCvqdGKezd1CrV++oqofMhEvjGJTsgg4teytotyiur
dF58vb378/7xS+dW+v35/vH1T2du/3B6+XLx9B29iNn2ZZK38TWpkLfLFEwgk8aHOO3laL8R
63bdFI4+0RjmtulKj1CFI5X/lAdZEvIXCJ8evt9/O/3yev9wurj7err788XW+87hz37V49xG
eMSDCygKVl5hUNMldUvP9qaWB7ywyM7cnb+NR5O+zjCzJiXGooV1FV3KVHEQuWiShvTBPgeF
O0LWdUEnHisXiuucxeT1DhJ3UCZGrxI1azOkOqUVt1czTE5PtDpBca9f5ClpX8xnA3het+9Z
Fvbsx8j3b3GvlgUa6zg1DcMsUMPxLECDbVjrUUNsAvab7q7xfxv9GGtcMmudezBub1st2Fll
nB6env+6iE6/v3354sY0bWBQTOLcMM3elYJUUG+oSb8gdCOjG7O856BVTMGVMo43edGe1A5y
3MRUIp0fDyNpI3F3MGQGYM16jdE37CyO02RAYE7lmbM4DU1scYQO0d1WXONlS+dcop37oWDS
/bpjpasmhMU6wmYKaodHFmcpjEpv2PwN3sRBlX5CUeV202aj0QAjz0YoiN3ILjZeF6KFPRri
BluvKw6Zj8BfIFTdnlStFbDcbtJg63Wki+sHk03ijY5dsuW5LNuK7pwHhTu/wy/rAmNGvH13
snZ3+/iF+mHB+mNfKrGyMBHoIBEFP6Y5zihbCd9L+E94mkOQ7uPzUHHlNzs0BK4DwzrZ9UdP
ssMdNwrGk5H/oDPbYF0Ei6zK9UfMoRfuooKJBuTE8xBmRsBgWZAjdrXt6+oihstVvAW5CZLF
xHfi+NxAjPNIn1bwkVdxXDrh5pz3MNZIL2Mv/vXy/f4R44+8/NfFw9vr6ccJ/jm93v3666//
poFSsTRMc7av42PsDUwSM58PWJ39+tpRQAAU12VAzTkdgzXTEDK9rIqDYolhN27ikgNWqGiF
Mk4HB3WBuolJY5/W2SoFZdLLZSMeBd8CKHOxiJ59fkVPnNtdXvRcEt+47UuxBWwne2gI0D1M
HEfQ4xXon4X3nV85CTwAwywEEs144ofbJrSzVqLCdLvaIdY8JVGmm7CCiuagiZ8tB2B2Ued1
26UVTdmgtybOTujyqMDDN4imRCj+6O1VtCPyY6sFVUL/cWRnNwQaCB7zUD2/bYMmrirrte5t
PpaZznTmKDbQPT8rjzwurjG53t9wDZtPBUlq0mDNEaeniI/NErLgChWYj3vWtJZkndidOBP3
ZOHALRv8HAZrqSjMkuP8feDePtNCUlgI5OGnuqAHBda9Hrhpdg9ULjb73BUoqe7a5VLmY8c9
VeR2qGzuZnF276ImIz+TUvBT4/Ax1wnq8PLJpCjbE9diJ9grr/Mt014By/I2reXZ0mAjgFyC
KXrj4W6+8Rr0Gpp+qCFNHpRmV0jRdyZ0yw3xtmuQcdBIIB3siUxe8Lx/HR7kOYZ+wMNBe0M8
cF7XsYMU1Rip9PXeBI908ZMjloq04HXcRgTTPA+7Fm4rUMnOUKaGjlAHINRKIdPOQ8tJO2tf
BG9lRPvaVV6zhg9ilwWVPmD/jqzXwD07Bu2mQR+mDct/0Q091yDCWj7KAjuJsh2A6u3RLv7r
08srmxfSq6hmFv7G2dGB8kjHtGsEBq17EYGNKyeFNdoxCtCuiPGNFFq76OGrBKcvLGZK9wXm
Uw7iL0iihWw5rOouPvIcse4FatvwLnuDEcQroNY0XpBF7S7LRoDrpGaOBhbc76mPloUqPIcR
aTZc9dj5jHsQ+lnmsieusnNruKcY/I6L8pPA1+VGIH6e434kU0s5V6rYRWpbK6hB7tlTG170
VVZEZwjWQrwH3NqziYI6QC8WDPDiJsezDUqAJ7y6EOl3WEyzX5sgxy2BfJ+mqs2QCZihDrIH
abLNMxaKvy1nn3rbImiTJ/cb0ggfCXoctX8200k4ThqZ68Sc7t6eMeqGt4PGD7twvMFXhVIF
CDgKqQGcx15XaGcfCbQ1TvJwuGqiXVPAQwJhONYf40ZZbKwXN3wCVIPxD3r6W9Cuwe4x7Iri
Silzoz3HyxreU2CdBavpNdvTlbc1x02VKWS+cEltqkKQilmCyQ6i6rfFfD5dMM3Duo3n0FT4
weD34tQunlfbY/oJyepupqTjrf1AkAPN22RSGJXsXuXd+5ff7x/fv72cnh+ePp9++Xr69p24
YvbvDcMtyfdHpUVaynmF/U945GLZ44wSw6WVzxHbKN8/4QgOodxo8njsChp0V8xo3VZq5DNn
LIcFx9GtLt/u1YpYOowoqboKjqAscTWPx8QsgFzPBrNP8akYJFjtFV0GStySratPv01Gs+VP
mfdRUtvU8WxnXHDCnFcTn5u0wM1spRZQf5gzip+R/kHX96x8TtLp/rauzyc3WXSG1r1Ga3bB
2B6HaJzYNCUNACIp7S6pJnE+BdRsQ/Ee6iE3QnDlqxFBEcmyGKWqkMpnFiLNK7a0IKXgyCAE
VjdQ6LI4MLj0LkNYhEZHGD+UigKx2jtPh34eRQKGWcIFmzJ3Ihm35FoOeadJtn93d7dJ2Bfx
7v7h9pfHs2UWZbKjx+xsElj2IMkwmS9UtUDjnY/1qAMe73UpWAcYf3v38vV2zF7AhSYpizSh
WW6RgidXKgEGMCimdA+IoprItn01OEqA2CkNzjfJ2ba0ppp7kHIw0uF7Mbi3ETFTdbx3nYK0
szq9WjR+Ks1xTpOaIIxIN1mdXu/e/3n66+X9DwShl3+lgQPYy7UV4/vmMd2ph4sGzY6ajeEq
MxKsSUwrn61xkuF0pbIID1f29J8HVtmut5Upth8+Pg/WRx1pHquT4f+MtxN0/4w7CkJlBEs2
GMGnb/ePbz/6Nz7iNIDbKdSQyK6ehPO5xUCZD6ke5NAjnWUcVH6UiFuM4QbbQZLqXrWA+3Aq
apjRnMeEdfa4rPLbO4GHz399f326uHt6Pl08PV84DeqsfjtmUPq2AfXWZ/DEx9mxHAF91nV6
FSbljmXOFBT/JmGXdwZ91ortafWYyuhPy13VB2sSDNX+qix9bgD9EtAkW6mO8boMFiceFIcK
CAvgYKvUqcX9h3HPTs7dDyZxktBybTfjyTLbpx6BLxMJ6D8elywf9/E+9ij2xx9K2QAe7Osd
rO48nG+HdE2Xb5O8D8QQvL1+xRChd7evp88X8eMdfhewFL34n/vXrxfBy8vT3b0lRbevt973
EYaZ3zIKFu4C+JuMYLr7NJ6ymNCOwcQfk4PSy7sApoI+fNfaht/HJc+LX5W1//5h7XdvqHRm
TP3WWyylfm8tVmoPOSoFwkx5XdktHhfh/fbl61C1s8AvcqeBR+3hh+ycTyG6/3J6efWfUIXT
idI2CGtoPR5FycbvVlX4DHZoFs0UTOFLoI/jFH99WZBFYxrEm8As9FwPg/KnwdOJz93qkh6o
FeFURQ2eemC9rcYr5VMvXQlu7rn//pUFMulnCn8kAcbybnZwvl8nCncV+s0Os/f1JlE6ryN4
NvLdYAiyOE0TXyCHAdptDd1kar+bEfUbNlJeeGN//S9qF9wok6uBpXegdG8ncBRBEyulxFXJ
dvx6+em/e31dqI3Z4udm6U3nMLgyyw/Sv/2mXToJyUOd3FpsOfPHFHORO2O7c27k28fPTw8X
+dvD76fnLmuJVpMgN0kTlprOEFVrmwRsr1NUSeUomriwFE0qI8EDPyR1HVe4N8L21sjk3Wja
WUfQq9BTzZAK03No7dETVV3Prha5RUhH8WcTPK3aJZu8uVzNjz+ntlXptXvCg0FuwyDI+r60
ZzdGU/bJXWUSFscwVlQVpLZx/9TxAGQz99U5xF043yFlhHAon/2ZWmtS4UwGqfsTahzqD/4Y
+t+ZPS3MtnUcDgxWoPvxfQkx3MWpSfy+RtohqWpK4vs8NlCjSiz367TlMfs1Z7PL1DCu0KYA
DWrx0IdpsOVVaC57A2Cd6k5gYrpj79bcZewc8awXO5ZPIvWHmNXlD6skvlz8gWEJ7788uhDe
1h6YnQlmRbRP7VLePufdHdz88h7vALYG1ta/fj89nDerrXPi8PaFTze/vZN3u3U/aRrvfo+j
Mzhc9Rv//f7H31bmJ1siHocVCdZO51zrdZLjY/rDwTZW++/Pt89/XTw/vb3eP1JV0a2M6Yp5
ndRVDB1l2MabPbmw519nuuaGa7uWRYBqbRRyjBBcJ3Q3uw+NGyYyPlpHosMcA1I3MrMvKJWw
UgBhzqDxgnP4eicUXe8bfhfXWeFSOdxtcfiO4vWnJZebhDJTN05alqC6FluXggOaWBWxXAEL
iTdHmqx9XTwk+u3xyOWQ2+9vm5m+hiPYnsZVdNAzqb2NVmhqO4FSQf2rCep8+zlu3bFhbuM6
i0U9TYa6ZnNUK5k6aDN0F+q4Xj9TRwq7hTX+4w3C8ro50sR9LWbjupY+bxJQ96sWDOgR5Bmr
d/ts7REMCGm/3HX4wcOkoXn3Qs32JilVwhoIE5WS3tCNMUKgkRQYfzGAk9fvxIFyUFphWmJT
pEXGI5KfUTycXg6Q4IE/IVExsqbuGGv7deTONiKgPiNo32Vi/Hw0rLnihh89vs5UeEMdT9Y8
/hYzWaHzvSnCxAWBCKoqYAfHNg4ltQ93EBqJNUz+Iu52OM+7vngqg9lqilIzdEIyKiY8rpoL
B6ecUkUf6RyRFmt+pUiUPOUewf2YaC1xyFdc7Rvp1JzeNDW1eQyLKqLbAnhUf27a6iPuPpAa
ZmXCY4n4bwT0DU3kgeGIMX6sqempx6bIa8Uur2D5JC3T8sfSQ+iAtNDiB/VEttDlD+qfZyEM
Tp0qBQbQCrmCYzCRZvZDedhIQOPRj7G82+xzpaaAjic/WH5PtBhP6WGMwTDXNskJN7nB0Whw
MAVJPmS0F8UltTE00hBKGjGBgpTFTQ6Ck9lbtXZYZPj9HzdmHhPsPwMA

--pWyiEgJYm5f9v55/
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--pWyiEgJYm5f9v55/--
