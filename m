From: kbuild test robot <lkp@intel.com>
Subject: [asoc:for-4.18 35/37]
 sound/soc/codecs/rt1305.c:1068:15: sparse: constant 562949953421312 is so
 big it is long
Date: Tue, 17 Apr 2018 04:04:46 +0800
Message-ID: <201804170445.e0ec6fbu%fengguang.wu@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga06.intel.com (mga06.intel.com [134.134.136.31])
 by alsa0.perex.cz (Postfix) with ESMTP id 6045F2673D3
 for <alsa-devel@alsa-project.org>; Mon, 16 Apr 2018 22:05:19 +0200 (CEST)
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
To: Shuming Fan <shumingf@realtek.com>
Cc: alsa-devel@alsa-project.org, Mark Brown <broonie@kernel.org>, kbuild-all@01.org
List-Id: alsa-devel@alsa-project.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-4.18
head:   fbeabd09236664f34ea3e4a9f7dcf5a0cdb7fc47
commit: 29bc643ddd7efb741d07c8b2d9a4c3dd9228865b [35/37] ASoC: rt1305: Add RT1305/RT1306 amplifier driver
reproduce:
        # apt-get install sparse
        git checkout 29bc643ddd7efb741d07c8b2d9a4c3dd9228865b
        make ARCH=x86_64 allmodconfig
        make C=1 CF=-D__CHECK_ENDIAN__


sparse warnings: (new ones prefixed by >>)

>> sound/soc/codecs/rt1305.c:1068:15: sparse: constant 562949953421312 is so big it is long
   sound/soc/codecs/rt1305.c:1085:15: sparse: constant 562949953421312 is so big it is long
   sound/soc/codecs/rt1305.c:1179:37: sparse: undefined identifier 'ACPI_PTR'
   sound/soc/codecs/rt1305.c:1179:23: error: implicit declaration of function 'ACPI_PTR'; did you mean 'ERR_PTR'? [-Werror=implicit-function-declaration]
      .acpi_match_table = ACPI_PTR(rt1305_acpi_match)
                          ^~~~~~~~
                          ERR_PTR
   sound/soc/codecs/rt1305.c:1179:23: warning: initialization makes pointer from integer without a cast [-Wint-conversion]
   sound/soc/codecs/rt1305.c:1179:23: note: (near initialization for 'rt1305_i2c_driver.driver.acpi_match_table')
   sound/soc/codecs/rt1305.c:1179:23: error: initializer element is not constant
   sound/soc/codecs/rt1305.c:1179:23: note: (near initialization for 'rt1305_i2c_driver.driver.acpi_match_table')
   cc1: some warnings being treated as errors

vim +1068 sound/soc/codecs/rt1305.c

   992	
   993	static void rt1305_calibrate(struct rt1305_priv *rt1305)
   994	{
   995		unsigned int valmsb, vallsb, offsetl, offsetr;
   996		unsigned int rh, rl, rhl, r0ohm;
   997		u64 r0l, r0r;
   998	
   999		regcache_cache_bypass(rt1305->regmap, true);
  1000	
  1001		rt1305_reset(rt1305->regmap);
  1002		regmap_write(rt1305->regmap, RT1305_ADC_SET_3, 0x0219);
  1003		regmap_write(rt1305->regmap, RT1305_PR_BASE + 0xcf, 0x5548);
  1004		regmap_write(rt1305->regmap, RT1305_PR_BASE + 0xc1, 0x0320);
  1005		regmap_write(rt1305->regmap, RT1305_CLOCK_DETECT, 0x1000);
  1006		regmap_write(rt1305->regmap, RT1305_CLK_1, 0x0600);
  1007		regmap_write(rt1305->regmap, RT1305_POWER_CTRL_3, 0xffd0);
  1008		regmap_write(rt1305->regmap, RT1305_EFUSE_1, 0x0080);
  1009		regmap_write(rt1305->regmap, RT1305_EFUSE_1, 0x0880);
  1010		regmap_write(rt1305->regmap, RT1305_POWER_CTRL_1, 0x0dfe);
  1011	
  1012		/* Sin Gen */
  1013		regmap_write(rt1305->regmap, RT1305_PR_BASE + 0x5d, 0x0442);
  1014	
  1015		regmap_write(rt1305->regmap, RT1305_CAL_EFUSE_CLOCK, 0xb000);
  1016		regmap_write(rt1305->regmap, RT1305_PR_BASE + 0xc3, 0xd4a0);
  1017		regmap_write(rt1305->regmap, RT1305_PR_BASE + 0xcc, 0x00cc);
  1018		regmap_write(rt1305->regmap, RT1305_PR_BASE + 0xc1, 0x0320);
  1019		regmap_write(rt1305->regmap, RT1305_POWER_STATUS, 0x0000);
  1020		regmap_write(rt1305->regmap, RT1305_POWER_CTRL_2, 0xffff);
  1021		regmap_write(rt1305->regmap, RT1305_POWER_CTRL_3, 0xfc20);
  1022		regmap_write(rt1305->regmap, RT1305_PR_BASE + 0x06, 0x00c0);
  1023		regmap_write(rt1305->regmap, RT1305_POWER_CTRL_3, 0xfca0);
  1024		regmap_write(rt1305->regmap, RT1305_POWER_CTRL_3, 0xfce0);
  1025		regmap_write(rt1305->regmap, RT1305_POWER_CTRL_3, 0xfcf0);
  1026	
  1027		/* EFUSE read */
  1028		regmap_write(rt1305->regmap, RT1305_EFUSE_1, 0x0080);
  1029		regmap_write(rt1305->regmap, RT1305_EFUSE_1, 0x0880);
  1030		regmap_write(rt1305->regmap, RT1305_EFUSE_1, 0x0880);
  1031		regmap_write(rt1305->regmap, RT1305_POWER_CTRL_3, 0xfce0);
  1032		regmap_write(rt1305->regmap, RT1305_POWER_CTRL_3, 0xfca0);
  1033		regmap_write(rt1305->regmap, RT1305_POWER_CTRL_3, 0xfc20);
  1034		regmap_write(rt1305->regmap, RT1305_PR_BASE + 0x06, 0x0000);
  1035		regmap_write(rt1305->regmap, RT1305_EFUSE_1, 0x0000);
  1036	
  1037		regmap_read(rt1305->regmap, RT1305_DAC_OFFSET_5, &valmsb);
  1038		regmap_read(rt1305->regmap, RT1305_DAC_OFFSET_6, &vallsb);
  1039		offsetl = valmsb << 16 | vallsb;
  1040		regmap_read(rt1305->regmap, RT1305_DAC_OFFSET_7, &valmsb);
  1041		regmap_read(rt1305->regmap, RT1305_DAC_OFFSET_8, &vallsb);
  1042		offsetr = valmsb << 16 | vallsb;
  1043		pr_info("DC offsetl=0x%x, offsetr=0x%x\n", offsetl, offsetr);
  1044	
  1045		/* R0 calibration */
  1046		regmap_write(rt1305->regmap, RT1305_PR_BASE + 0x5d, 0x9542);
  1047		regmap_write(rt1305->regmap, RT1305_POWER_CTRL_3, 0xfcf0);
  1048		regmap_write(rt1305->regmap, RT1305_POWER_CTRL_2, 0xffff);
  1049		regmap_write(rt1305->regmap, RT1305_POWER_CTRL_1, 0x1dfe);
  1050		regmap_write(rt1305->regmap, RT1305_SILENCE_DETECT, 0x0e13);
  1051		regmap_write(rt1305->regmap, RT1305_CLK_1, 0x0650);
  1052	
  1053		regmap_write(rt1305->regmap, RT1305_PR_BASE + 0x50, 0x0064);
  1054		regmap_write(rt1305->regmap, RT1305_PR_BASE + 0x51, 0x0770);
  1055		regmap_write(rt1305->regmap, RT1305_PR_BASE + 0x52, 0xc30c);
  1056		regmap_write(rt1305->regmap, RT1305_SPK_TEMP_PROTECTION_1, 0x8200);
  1057		regmap_write(rt1305->regmap, RT1305_PR_BASE + 0xd4, 0xfb00);
  1058		regmap_write(rt1305->regmap, RT1305_PR_BASE + 0xd4, 0xff80);
  1059		msleep(2000);
  1060		regmap_read(rt1305->regmap, RT1305_PR_BASE + 0x55, &rh);
  1061		regmap_read(rt1305->regmap, RT1305_PR_BASE + 0x56, &rl);
  1062		rhl = (rh << 16) | rl;
  1063		r0ohm = (rhl*10) / 33554432;
  1064	
  1065		pr_debug("Left_rhl = 0x%x rh=0x%x rl=0x%x\n", rhl, rh, rl);
  1066		pr_info("Left channel %d.%dohm\n", (r0ohm/10), (r0ohm%10));
  1067	
> 1068		r0l = 562949953421312;
  1069		if (rhl != 0)
  1070			do_div(r0l, rhl);
  1071		pr_debug("Left_r0 = 0x%llx\n", r0l);
  1072	
  1073		regmap_write(rt1305->regmap, RT1305_SPK_TEMP_PROTECTION_1, 0x9200);
  1074		regmap_write(rt1305->regmap, RT1305_PR_BASE + 0xd4, 0xfb00);
  1075		regmap_write(rt1305->regmap, RT1305_PR_BASE + 0xd4, 0xff80);
  1076		msleep(2000);
  1077		regmap_read(rt1305->regmap, RT1305_PR_BASE + 0x55, &rh);
  1078		regmap_read(rt1305->regmap, RT1305_PR_BASE + 0x56, &rl);
  1079		rhl = (rh << 16) | rl;
  1080		r0ohm = (rhl*10) / 33554432;
  1081	
  1082		pr_debug("Right_rhl = 0x%x rh=0x%x rl=0x%x\n", rhl, rh, rl);
  1083		pr_info("Right channel %d.%dohm\n", (r0ohm/10), (r0ohm%10));
  1084	
  1085		r0r = 562949953421312;
  1086		if (rhl != 0)
  1087			do_div(r0r, rhl);
  1088		pr_debug("Right_r0 = 0x%llx\n", r0r);
  1089	
  1090		regmap_write(rt1305->regmap, RT1305_SPK_TEMP_PROTECTION_1, 0xc2ec);
  1091	
  1092		if ((r0l > R0_UPPER) && (r0l < R0_LOWER) &&
  1093			(r0r > R0_UPPER) && (r0r < R0_LOWER)) {
  1094			regmap_write(rt1305->regmap, RT1305_PR_BASE + 0x4e,
  1095				(r0l >> 16) & 0xffff);
  1096			regmap_write(rt1305->regmap, RT1305_PR_BASE + 0x4f,
  1097				r0l & 0xffff);
  1098			regmap_write(rt1305->regmap, RT1305_PR_BASE + 0xfe,
  1099				((r0r >> 16) & 0xffff) | 0xf800);
  1100			regmap_write(rt1305->regmap, RT1305_PR_BASE + 0xfd,
  1101				r0r & 0xffff);
  1102		} else {
  1103			pr_err("R0 calibration failed\n");
  1104		}
  1105	
  1106		/* restore some registers */
  1107		regmap_write(rt1305->regmap, RT1305_POWER_CTRL_1, 0x0dfe);
  1108		usleep_range(200000, 400000);
  1109		regmap_write(rt1305->regmap, RT1305_PR_BASE + 0x5d, 0x0442);
  1110		regmap_write(rt1305->regmap, RT1305_CLOCK_DETECT, 0x3000);
  1111		regmap_write(rt1305->regmap, RT1305_CLK_1, 0x0400);
  1112		regmap_write(rt1305->regmap, RT1305_POWER_CTRL_1, 0x0000);
  1113		regmap_write(rt1305->regmap, RT1305_CAL_EFUSE_CLOCK, 0x8000);
  1114		regmap_write(rt1305->regmap, RT1305_POWER_CTRL_2, 0x1020);
  1115		regmap_write(rt1305->regmap, RT1305_POWER_CTRL_3, 0x0000);
  1116	
  1117		regcache_cache_bypass(rt1305->regmap, false);
  1118	}
  1119	

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
