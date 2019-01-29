From: kbuild test robot <lkp@intel.com>
Subject: [asoc:for-5.1 73/74] sound/soc/codecs/Kconfig:1348:
	syntax error
Date: Tue, 29 Jan 2019 19:05:11 +0800
Message-ID: <201901291910.GIXDmr2i%fengguang.wu@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga06.intel.com (mga06.intel.com [134.134.136.31])
 by alsa0.perex.cz (Postfix) with ESMTP id AEA6B267454
 for <alsa-devel@alsa-project.org>; Tue, 29 Jan 2019 12:05:30 +0100 (CET)
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
To: Shunli Wang <shunli.wang@mediatek.com>
Cc: alsa-devel@alsa-project.org, Mark Brown <broonie@kernel.org>, kbuild-all@01.org
List-Id: alsa-devel@alsa-project.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-5.1
head:   7ca80f232e810b758ba72daef8f189c34a20bd32
commit: 6a8d4198ca80deb2f978260a096fa651229cf4a2 [73/74] ASoC: mediatek: mt6358: add codec driver
config: x86_64-kexec
compiler: gcc-7 (Debian 7.4.0-2) 7.4.0
reproduce:
        git checkout 6a8d4198ca80deb2f978260a096fa651229cf4a2
        # save the attached .config to linux build tree
        make ARCH=x86_64 

All errors (new ones prefixed by >>):

>> sound/soc/codecs/Kconfig:1348: syntax error
   sound/soc/codecs/Kconfig:1347:warning: ignoring unsupported character '.'
>> sound/soc/codecs/Kconfig:1347: unknown statement "external"
   make[2]: *** [oldconfig] Error 1
   make[1]: *** [oldconfig] Error 2
   make: *** [sub-make] Error 2
--
>> sound/soc/codecs/Kconfig:1348: syntax error
   sound/soc/codecs/Kconfig:1347:warning: ignoring unsupported character '.'
>> sound/soc/codecs/Kconfig:1347: unknown statement "external"
   make[2]: *** [olddefconfig] Error 1
   make[1]: *** [olddefconfig] Error 2
   make: *** [sub-make] Error 2

vim +1348 sound/soc/codecs/Kconfig

    12	
    13	config SND_SOC_ALL_CODECS
    14		tristate "Build all ASoC CODEC drivers"
    15		depends on COMPILE_TEST
    16		select SND_SOC_88PM860X if MFD_88PM860X
    17		select SND_SOC_L3
    18		select SND_SOC_AB8500_CODEC if ABX500_CORE
    19		select SND_SOC_AC97_CODEC
    20		select SND_SOC_AD1836 if SPI_MASTER
    21		select SND_SOC_AD193X_SPI if SPI_MASTER
    22		select SND_SOC_AD193X_I2C if I2C
    23		select SND_SOC_AD1980 if SND_SOC_AC97_BUS
    24		select SND_SOC_AD73311
    25		select SND_SOC_ADAU1373 if I2C
    26		select SND_SOC_ADAU1761_I2C if I2C
    27		select SND_SOC_ADAU1761_SPI if SPI
    28		select SND_SOC_ADAU1781_I2C if I2C
    29		select SND_SOC_ADAU1781_SPI if SPI
    30		select SND_SOC_ADAV801 if SPI_MASTER
    31		select SND_SOC_ADAV803 if I2C
    32		select SND_SOC_ADAU1977_SPI if SPI_MASTER
    33		select SND_SOC_ADAU1977_I2C if I2C
    34		select SND_SOC_ADAU1701 if I2C
    35		select SND_SOC_ADAU7002
    36		select SND_SOC_ADS117X
    37		select SND_SOC_AK4104 if SPI_MASTER
    38		select SND_SOC_AK4118 if I2C
    39		select SND_SOC_AK4458 if I2C
    40		select SND_SOC_AK4535 if I2C
    41		select SND_SOC_AK4554
    42		select SND_SOC_AK4613 if I2C
    43		select SND_SOC_AK4641 if I2C
    44		select SND_SOC_AK4642 if I2C
    45		select SND_SOC_AK4671 if I2C
    46		select SND_SOC_AK5386
    47		select SND_SOC_AK5558 if I2C
    48		select SND_SOC_ALC5623 if I2C
    49		select SND_SOC_ALC5632 if I2C
    50		select SND_SOC_BT_SCO
    51		select SND_SOC_BD28623
    52		select SND_SOC_CQ0093VC
    53		select SND_SOC_CS35L32 if I2C
    54		select SND_SOC_CS35L33 if I2C
    55		select SND_SOC_CS35L34 if I2C
    56		select SND_SOC_CS35L35 if I2C
    57		select SND_SOC_CS42L42 if I2C
    58		select SND_SOC_CS42L51_I2C if I2C
    59		select SND_SOC_CS42L52 if I2C && INPUT
    60		select SND_SOC_CS42L56 if I2C && INPUT
    61		select SND_SOC_CS42L73 if I2C
    62		select SND_SOC_CS4265 if I2C
    63		select SND_SOC_CS4270 if I2C
    64		select SND_SOC_CS4271_I2C if I2C
    65		select SND_SOC_CS4271_SPI if SPI_MASTER
    66		select SND_SOC_CS42XX8_I2C if I2C
    67		select SND_SOC_CS43130 if I2C
    68		select SND_SOC_CS4341 if SND_SOC_I2C_AND_SPI
    69		select SND_SOC_CS4349 if I2C
    70		select SND_SOC_CS47L24 if MFD_CS47L24
    71		select SND_SOC_CS53L30 if I2C
    72		select SND_SOC_CX20442 if TTY
    73		select SND_SOC_DA7210 if SND_SOC_I2C_AND_SPI
    74		select SND_SOC_DA7213 if I2C
    75		select SND_SOC_DA7218 if I2C
    76		select SND_SOC_DA7219 if I2C
    77		select SND_SOC_DA732X if I2C
    78		select SND_SOC_DA9055 if I2C
    79		select SND_SOC_DMIC if GPIOLIB
    80		select SND_SOC_ES8316 if I2C
    81		select SND_SOC_ES8328_SPI if SPI_MASTER
    82		select SND_SOC_ES8328_I2C if I2C
    83		select SND_SOC_ES7134
    84		select SND_SOC_ES7241
    85		select SND_SOC_GTM601
    86		select SND_SOC_HDAC_HDMI
    87		select SND_SOC_HDAC_HDA
    88		select SND_SOC_ICS43432
    89		select SND_SOC_INNO_RK3036
    90		select SND_SOC_ISABELLE if I2C
    91		select SND_SOC_JZ4740_CODEC
    92		select SND_SOC_LM4857 if I2C
    93		select SND_SOC_LM49453 if I2C
    94		select SND_SOC_MAX98088 if I2C
    95		select SND_SOC_MAX98090 if I2C
    96		select SND_SOC_MAX98095 if I2C
    97		select SND_SOC_MAX98357A if GPIOLIB
    98		select SND_SOC_MAX98371 if I2C
    99		select SND_SOC_MAX98504 if I2C
   100		select SND_SOC_MAX9867 if I2C
   101		select SND_SOC_MAX98925 if I2C
   102		select SND_SOC_MAX98926 if I2C
   103		select SND_SOC_MAX98927 if I2C
   104		select SND_SOC_MAX98373 if I2C
   105		select SND_SOC_MAX9850 if I2C
   106		select SND_SOC_MAX9860 if I2C
   107		select SND_SOC_MAX9759
   108		select SND_SOC_MAX9768 if I2C
   109		select SND_SOC_MAX9877 if I2C
   110		select SND_SOC_MC13783 if MFD_MC13XXX
   111		select SND_SOC_ML26124 if I2C
   112		select SND_SOC_MT6351 if MTK_PMIC_WRAP
   113		select SND_SOC_MT6358 if MTK_PMIC_WRAP
   114		select SND_SOC_NAU8540 if I2C
   115		select SND_SOC_NAU8810 if I2C
   116		select SND_SOC_NAU8822 if I2C
   117		select SND_SOC_NAU8824 if I2C
   118		select SND_SOC_NAU8825 if I2C
   119		select SND_SOC_HDMI_CODEC
   120		select SND_SOC_PCM1681 if I2C
   121		select SND_SOC_PCM1789_I2C if I2C
   122		select SND_SOC_PCM179X_I2C if I2C
   123		select SND_SOC_PCM179X_SPI if SPI_MASTER
   124		select SND_SOC_PCM186X_I2C if I2C
   125		select SND_SOC_PCM186X_SPI if SPI_MASTER
   126		select SND_SOC_PCM3008
   127		select SND_SOC_PCM3060_I2C if I2C
   128		select SND_SOC_PCM3060_SPI if SPI_MASTER
   129		select SND_SOC_PCM3168A_I2C if I2C
   130		select SND_SOC_PCM3168A_SPI if SPI_MASTER
   131		select SND_SOC_PCM5102A
   132		select SND_SOC_PCM512x_I2C if I2C
   133		select SND_SOC_PCM512x_SPI if SPI_MASTER
   134		select SND_SOC_RK3328
   135		select SND_SOC_RT274 if I2C
   136		select SND_SOC_RT286 if I2C
   137		select SND_SOC_RT298 if I2C
   138		select SND_SOC_RT1305 if I2C
   139		select SND_SOC_RT5514 if I2C
   140		select SND_SOC_RT5616 if I2C
   141		select SND_SOC_RT5631 if I2C
   142		select SND_SOC_RT5640 if I2C
   143		select SND_SOC_RT5645 if I2C
   144		select SND_SOC_RT5651 if I2C
   145		select SND_SOC_RT5659 if I2C
   146		select SND_SOC_RT5660 if I2C
   147		select SND_SOC_RT5663 if I2C
   148		select SND_SOC_RT5665 if I2C
   149		select SND_SOC_RT5668 if I2C
   150		select SND_SOC_RT5670 if I2C
   151		select SND_SOC_RT5677 if I2C && SPI_MASTER
   152		select SND_SOC_RT5682 if I2C
   153		select SND_SOC_SGTL5000 if I2C
   154		select SND_SOC_SI476X if MFD_SI476X_CORE
   155		select SND_SOC_SIMPLE_AMPLIFIER
   156		select SND_SOC_SIRF_AUDIO_CODEC
   157		select SND_SOC_SPDIF
   158		select SND_SOC_SSM2305
   159		select SND_SOC_SSM2518 if I2C
   160		select SND_SOC_SSM2602_SPI if SPI_MASTER
   161		select SND_SOC_SSM2602_I2C if I2C
   162		select SND_SOC_SSM4567 if I2C
   163		select SND_SOC_STA32X if I2C
   164		select SND_SOC_STA350 if I2C
   165		select SND_SOC_STA529 if I2C
   166		select SND_SOC_STAC9766 if SND_SOC_AC97_BUS
   167		select SND_SOC_STI_SAS
   168		select SND_SOC_TAS2552 if I2C
   169		select SND_SOC_TAS5086 if I2C
   170		select SND_SOC_TAS571X if I2C
   171		select SND_SOC_TAS5720 if I2C
   172		select SND_SOC_TAS6424 if I2C
   173		select SND_SOC_TDA7419 if I2C
   174		select SND_SOC_TFA9879 if I2C
   175		select SND_SOC_TLV320AIC23_I2C if I2C
   176		select SND_SOC_TLV320AIC23_SPI if SPI_MASTER
   177		select SND_SOC_TLV320AIC26 if SPI_MASTER
   178		select SND_SOC_TLV320AIC31XX if I2C
   179		select SND_SOC_TLV320AIC32X4_I2C if I2C
   180		select SND_SOC_TLV320AIC32X4_SPI if SPI_MASTER
   181		select SND_SOC_TLV320AIC3X if I2C
   182		select SND_SOC_TPA6130A2 if I2C
   183		select SND_SOC_TLV320DAC33 if I2C
   184		select SND_SOC_TSCS42XX if I2C
   185		select SND_SOC_TSCS454 if I2C
   186		select SND_SOC_TS3A227E if I2C
   187		select SND_SOC_TWL4030 if TWL4030_CORE
   188		select SND_SOC_TWL6040 if TWL6040_CORE
   189		select SND_SOC_UDA134X
   190		select SND_SOC_UDA1380 if I2C
   191		select SND_SOC_WL1273 if MFD_WL1273_CORE
   192		select SND_SOC_WM0010 if SPI_MASTER
   193		select SND_SOC_WM1250_EV1 if I2C
   194		select SND_SOC_WM2000 if I2C
   195		select SND_SOC_WM2200 if I2C
   196		select SND_SOC_WM5100 if I2C
   197		select SND_SOC_WM5102 if MFD_WM5102
   198		select SND_SOC_WM5110 if MFD_WM5110
   199		select SND_SOC_WM8350 if MFD_WM8350
   200		select SND_SOC_WM8400 if MFD_WM8400
   201		select SND_SOC_WM8510 if SND_SOC_I2C_AND_SPI
   202		select SND_SOC_WM8523 if I2C
   203		select SND_SOC_WM8524 if GPIOLIB
   204		select SND_SOC_WM8580 if I2C
   205		select SND_SOC_WM8711 if SND_SOC_I2C_AND_SPI
   206		select SND_SOC_WM8727
   207		select SND_SOC_WM8728 if SND_SOC_I2C_AND_SPI
   208		select SND_SOC_WM8731 if SND_SOC_I2C_AND_SPI
   209		select SND_SOC_WM8737 if SND_SOC_I2C_AND_SPI
   210		select SND_SOC_WM8741 if SND_SOC_I2C_AND_SPI
   211		select SND_SOC_WM8750 if SND_SOC_I2C_AND_SPI
   212		select SND_SOC_WM8753 if SND_SOC_I2C_AND_SPI
   213		select SND_SOC_WM8770 if SPI_MASTER
   214		select SND_SOC_WM8776 if SND_SOC_I2C_AND_SPI
   215		select SND_SOC_WM8782
   216		select SND_SOC_WM8804_I2C if I2C
   217		select SND_SOC_WM8804_SPI if SPI_MASTER
   218		select SND_SOC_WM8900 if I2C
   219		select SND_SOC_WM8903 if I2C
   220		select SND_SOC_WM8904 if I2C
   221		select SND_SOC_WM8940 if I2C
   222		select SND_SOC_WM8955 if I2C
   223		select SND_SOC_WM8960 if I2C
   224		select SND_SOC_WM8961 if I2C
   225		select SND_SOC_WM8962 if I2C && INPUT
   226		select SND_SOC_WM8971 if I2C
   227		select SND_SOC_WM8974 if I2C
   228		select SND_SOC_WM8978 if I2C
   229		select SND_SOC_WM8983 if SND_SOC_I2C_AND_SPI
   230		select SND_SOC_WM8985 if SND_SOC_I2C_AND_SPI
   231		select SND_SOC_WM8988 if SND_SOC_I2C_AND_SPI
   232		select SND_SOC_WM8990 if I2C
   233		select SND_SOC_WM8991 if I2C
   234		select SND_SOC_WM8993 if I2C
   235		select SND_SOC_WM8994 if MFD_WM8994
   236		select SND_SOC_WM8995 if SND_SOC_I2C_AND_SPI
   237		select SND_SOC_WM8996 if I2C
   238		select SND_SOC_WM8997 if MFD_WM8997
   239		select SND_SOC_WM8998 if MFD_WM8998
   240		select SND_SOC_WM9081 if I2C
   241		select SND_SOC_WM9090 if I2C
   242		select SND_SOC_WM9705 if (SND_SOC_AC97_BUS || SND_SOC_AC97_BUS_NEW)
   243		select SND_SOC_WM9712 if (SND_SOC_AC97_BUS || SND_SOC_AC97_BUS_NEW)
   244		select SND_SOC_WM9713 if (SND_SOC_AC97_BUS || SND_SOC_AC97_BUS_NEW)
   245	        help
   246	          Normally ASoC codec drivers are only built if a machine driver which
   247	          uses them is also built since they are only usable with a machine
   248	          driver.  Selecting this option will allow these drivers to be built
   249	          without an explicit machine driver for test and development purposes.
   250	
   251		  Support for the bus types used to access the codecs to be built must
   252		  be selected separately.
   253	
   254	          If unsure select "N".
   255	
   256	config SND_SOC_88PM860X
   257		tristate
   258	
   259	config SND_SOC_ARIZONA
   260		tristate
   261		default y if SND_SOC_CS47L24=y
   262		default y if SND_SOC_WM5102=y
   263		default y if SND_SOC_WM5110=y
   264		default y if SND_SOC_WM8997=y
   265		default y if SND_SOC_WM8998=y
   266		default m if SND_SOC_CS47L24=m
   267		default m if SND_SOC_WM5102=m
   268		default m if SND_SOC_WM5110=m
   269		default m if SND_SOC_WM8997=m
   270		default m if SND_SOC_WM8998=m
   271	
   272	config SND_SOC_WM_HUBS
   273		tristate
   274		default y if SND_SOC_WM8993=y || SND_SOC_WM8994=y
   275		default m if SND_SOC_WM8993=m || SND_SOC_WM8994=m
   276	
   277	config SND_SOC_WM_ADSP
   278		tristate
   279		select SND_SOC_COMPRESS
   280		default y if SND_SOC_CS47L24=y
   281		default y if SND_SOC_WM5102=y
   282		default y if SND_SOC_WM5110=y
   283		default y if SND_SOC_WM2200=y
   284		default m if SND_SOC_CS47L24=m
   285		default m if SND_SOC_WM5102=m
   286		default m if SND_SOC_WM5110=m
   287		default m if SND_SOC_WM2200=m
   288	
   289	config SND_SOC_AB8500_CODEC
   290		tristate
   291	
   292	config SND_SOC_AC97_CODEC
   293		tristate "Build generic ASoC AC97 CODEC driver"
   294		select SND_AC97_CODEC
   295		select SND_SOC_AC97_BUS
   296	
   297	config SND_SOC_AD1836
   298		tristate
   299	
   300	config SND_SOC_AD193X
   301		tristate
   302	
   303	config SND_SOC_AD193X_SPI
   304		tristate
   305		select SND_SOC_AD193X
   306	
   307	config SND_SOC_AD193X_I2C
   308		tristate
   309		select SND_SOC_AD193X
   310	
   311	config SND_SOC_AD1980
   312		select REGMAP_AC97
   313		tristate
   314	
   315	config SND_SOC_AD73311
   316		tristate
   317	
   318	config SND_SOC_ADAU_UTILS
   319		tristate
   320	
   321	config SND_SOC_ADAU1373
   322		tristate
   323		select SND_SOC_ADAU_UTILS
   324	
   325	config SND_SOC_ADAU1701
   326		tristate "Analog Devices ADAU1701 CODEC"
   327		depends on I2C
   328		select SND_SOC_SIGMADSP_I2C
   329	
   330	config SND_SOC_ADAU17X1
   331		tristate
   332		select SND_SOC_SIGMADSP_REGMAP
   333		select SND_SOC_ADAU_UTILS
   334	
   335	config SND_SOC_ADAU1761
   336		tristate
   337		select SND_SOC_ADAU17X1
   338	
   339	config SND_SOC_ADAU1761_I2C
   340		tristate "Analog Devices AU1761 CODEC - I2C"
   341		depends on I2C
   342		select SND_SOC_ADAU1761
   343		select REGMAP_I2C
   344	
   345	config SND_SOC_ADAU1761_SPI
   346		tristate "Analog Devices AU1761 CODEC - SPI"
   347		depends on SPI
   348		select SND_SOC_ADAU1761
   349		select REGMAP_SPI
   350	
   351	config SND_SOC_ADAU1781
   352		select SND_SOC_ADAU17X1
   353		tristate
   354	
   355	config SND_SOC_ADAU1781_I2C
   356		tristate
   357		select SND_SOC_ADAU1781
   358		select REGMAP_I2C
   359	
   360	config SND_SOC_ADAU1781_SPI
   361		tristate
   362		select SND_SOC_ADAU1781
   363		select REGMAP_SPI
   364	
   365	config SND_SOC_ADAU1977
   366		tristate
   367	
   368	config SND_SOC_ADAU1977_SPI
   369		tristate
   370		select SND_SOC_ADAU1977
   371		select REGMAP_SPI
   372	
   373	config SND_SOC_ADAU1977_I2C
   374		tristate
   375		select SND_SOC_ADAU1977
   376		select REGMAP_I2C
   377	
   378	config SND_SOC_ADAU7002
   379		tristate "Analog Devices ADAU7002 Stereo PDM-to-I2S/TDM Converter"
   380	
   381	config SND_SOC_ADAV80X
   382		tristate
   383	
   384	config SND_SOC_ADAV801
   385		tristate
   386		select SND_SOC_ADAV80X
   387	
   388	config SND_SOC_ADAV803
   389		tristate
   390		select SND_SOC_ADAV80X
   391	
   392	config SND_SOC_ADS117X
   393		tristate
   394	
   395	config SND_SOC_AK4104
   396		tristate "AKM AK4104 CODEC"
   397		depends on SPI_MASTER
   398	
   399	config SND_SOC_AK4118
   400		tristate "AKM AK4118 CODEC"
   401		depends on I2C
   402		select REGMAP_I2C
   403	
   404	config SND_SOC_AK4458
   405		tristate "AKM AK4458 CODEC"
   406		depends on I2C
   407		select REGMAP_I2C
   408	
   409	config SND_SOC_AK4535
   410		tristate
   411	
   412	config SND_SOC_AK4554
   413		tristate "AKM AK4554 CODEC"
   414	
   415	config SND_SOC_AK4613
   416		tristate "AKM AK4613 CODEC"
   417		depends on I2C
   418	
   419	config SND_SOC_AK4641
   420		tristate
   421	
   422	config SND_SOC_AK4642
   423		tristate "AKM AK4642 CODEC"
   424		depends on I2C
   425	
   426	config SND_SOC_AK4671
   427		tristate
   428	
   429	config SND_SOC_AK5386
   430		tristate "AKM AK5638 CODEC"
   431	
   432	config SND_SOC_AK5558
   433		tristate "AKM AK5558 CODEC"
   434		depends on I2C
   435		select REGMAP_I2C
   436	
   437	config SND_SOC_ALC5623
   438	       tristate "Realtek ALC5623 CODEC"
   439		depends on I2C
   440	
   441	config SND_SOC_ALC5632
   442		tristate
   443	
   444	config SND_SOC_BD28623
   445		tristate "ROHM BD28623 CODEC"
   446		help
   447		  Enable support for ROHM BD28623MUV Class D speaker amplifier.
   448		  This codec does not have any control buses such as I2C, it
   449		  detect format of I2S automatically.
   450	
   451	config SND_SOC_BT_SCO
   452		tristate "Dummy BT SCO codec driver"
   453	
   454	config SND_SOC_CPCAP
   455		tristate "Motorola CPCAP codec"
   456		depends on MFD_CPCAP
   457	
   458	config SND_SOC_CQ0093VC
   459		tristate
   460	
   461	config SND_SOC_CS35L32
   462		tristate "Cirrus Logic CS35L32 CODEC"
   463		depends on I2C
   464	
   465	config SND_SOC_CS35L33
   466		tristate "Cirrus Logic CS35L33 CODEC"
   467		depends on I2C
   468	
   469	config SND_SOC_CS35L34
   470		tristate "Cirrus Logic CS35L34 CODEC"
   471		depends on I2C
   472	
   473	config SND_SOC_CS35L35
   474		tristate "Cirrus Logic CS35L35 CODEC"
   475		depends on I2C
   476	
   477	config SND_SOC_CS42L42
   478		tristate "Cirrus Logic CS42L42 CODEC"
   479		depends on I2C
   480	
   481	config SND_SOC_CS42L51
   482		tristate
   483	
   484	config SND_SOC_CS42L51_I2C
   485		tristate "Cirrus Logic CS42L51 CODEC (I2C)"
   486		depends on I2C
   487		select SND_SOC_CS42L51
   488	
   489	config SND_SOC_CS42L52
   490		tristate "Cirrus Logic CS42L52 CODEC"
   491		depends on I2C && INPUT
   492	
   493	config SND_SOC_CS42L56
   494		tristate "Cirrus Logic CS42L56 CODEC"
   495		depends on I2C && INPUT
   496	
   497	config SND_SOC_CS42L73
   498		tristate "Cirrus Logic CS42L73 CODEC"
   499		depends on I2C
   500	
   501	config SND_SOC_CS4265
   502		tristate "Cirrus Logic CS4265 CODEC"
   503		depends on I2C
   504		select REGMAP_I2C
   505	
   506	# Cirrus Logic CS4270 Codec
   507	config SND_SOC_CS4270
   508		tristate "Cirrus Logic CS4270 CODEC"
   509		depends on I2C
   510	
   511	# Cirrus Logic CS4270 Codec VD = 3.3V Errata
   512	# Select if you are affected by the errata where the part will not function
   513	# if MCLK divide-by-1.5 is selected and VD is set to 3.3V.  The driver will
   514	# not select any sample rates that require MCLK to be divided by 1.5.
   515	config SND_SOC_CS4270_VD33_ERRATA
   516		bool
   517		depends on SND_SOC_CS4270
   518	
   519	config SND_SOC_CS4271
   520		tristate
   521	
   522	config SND_SOC_CS4271_I2C
   523		tristate "Cirrus Logic CS4271 CODEC (I2C)"
   524		depends on I2C
   525		select SND_SOC_CS4271
   526		select REGMAP_I2C
   527	
   528	config SND_SOC_CS4271_SPI
   529		tristate "Cirrus Logic CS4271 CODEC (SPI)"
   530		depends on SPI_MASTER
   531		select SND_SOC_CS4271
   532		select REGMAP_SPI
   533	
   534	config SND_SOC_CS42XX8
   535		tristate
   536	
   537	config SND_SOC_CS42XX8_I2C
   538		tristate "Cirrus Logic CS42448/CS42888 CODEC (I2C)"
   539		depends on I2C
   540		select SND_SOC_CS42XX8
   541		select REGMAP_I2C
   542	
   543	# Cirrus Logic CS43130 HiFi DAC
   544	config SND_SOC_CS43130
   545	        tristate "Cirrus Logic CS43130 CODEC"
   546	        depends on I2C
   547	
   548	config SND_SOC_CS4341
   549		tristate "Cirrus Logic CS4341 CODEC"
   550		depends on SND_SOC_I2C_AND_SPI
   551		select REGMAP_I2C if I2C
   552		select REGMAP_SPI if SPI_MASTER
   553	
   554	# Cirrus Logic CS4349 HiFi DAC
   555	config SND_SOC_CS4349
   556		tristate "Cirrus Logic CS4349 CODEC"
   557		depends on I2C
   558	
   559	config SND_SOC_CS47L24
   560		tristate
   561	
   562	# Cirrus Logic Quad-Channel ADC
   563	config SND_SOC_CS53L30
   564		tristate "Cirrus Logic CS53L30 CODEC"
   565		depends on I2C
   566	
   567	config SND_SOC_CX20442
   568		tristate
   569		depends on TTY
   570	
   571	config SND_SOC_JZ4740_CODEC
   572		select REGMAP_MMIO
   573		tristate
   574	
   575	config SND_SOC_L3
   576	       tristate
   577	
   578	config SND_SOC_DA7210
   579	        tristate
   580	
   581	config SND_SOC_DA7213
   582	        tristate
   583	
   584	config SND_SOC_DA7218
   585		tristate
   586	
   587	config SND_SOC_DA7219
   588	        tristate
   589	
   590	config SND_SOC_DA732X
   591	        tristate
   592	
   593	config SND_SOC_DA9055
   594		tristate
   595	
   596	config SND_SOC_DMIC
   597		tristate "Generic Digital Microphone CODEC"
   598		depends on GPIOLIB
   599		help
   600		  Enable support for the Generic Digital Microphone CODEC.
   601		  Select this if your sound card has DMICs.
   602	
   603	config SND_SOC_HDMI_CODEC
   604		tristate
   605		select SND_PCM_ELD
   606		select SND_PCM_IEC958
   607		select HDMI
   608	
   609	config SND_SOC_ES7134
   610	       tristate "Everest Semi ES7134 CODEC"
   611	
   612	config SND_SOC_ES7241
   613	       tristate "Everest Semi ES7241 CODEC"
   614	
   615	config SND_SOC_ES8316
   616		tristate "Everest Semi ES8316 CODEC"
   617		depends on I2C
   618	
   619	config SND_SOC_ES8328
   620		tristate
   621	
   622	config SND_SOC_ES8328_I2C
   623		tristate "Everest Semi ES8328 CODEC (I2C)"
   624		depends on I2C
   625		select SND_SOC_ES8328
   626	
   627	config SND_SOC_ES8328_SPI
   628		tristate "Everest Semi ES8328 CODEC (SPI)"
   629		depends on SPI_MASTER
   630		select SND_SOC_ES8328
   631	
   632	config SND_SOC_GTM601
   633		tristate 'GTM601 UMTS modem audio codec'
   634	
   635	config SND_SOC_HDAC_HDMI
   636		tristate
   637		select SND_HDA_EXT_CORE
   638		select SND_PCM_ELD
   639		select HDMI
   640	
   641	config SND_SOC_HDAC_HDA
   642		tristate
   643		select SND_HDA
   644	
   645	config SND_SOC_ICS43432
   646		tristate
   647	
   648	config SND_SOC_INNO_RK3036
   649		tristate "Inno codec driver for RK3036 SoC"
   650		select REGMAP_MMIO
   651	
   652	config SND_SOC_ISABELLE
   653	        tristate
   654	
   655	config SND_SOC_LM49453
   656		tristate
   657	
   658	config SND_SOC_MAX98088
   659		tristate "Maxim MAX98088/9 Low-Power, Stereo Audio Codec"
   660		depends on I2C
   661	
   662	config SND_SOC_MAX98090
   663	       tristate
   664	
   665	config SND_SOC_MAX98095
   666	       tristate
   667	
   668	config SND_SOC_MAX98357A
   669	       tristate
   670	
   671	config SND_SOC_MAX98371
   672	       tristate
   673	
   674	config SND_SOC_MAX98504
   675		tristate "Maxim MAX98504 speaker amplifier"
   676		depends on I2C
   677	
   678	config SND_SOC_MAX9867
   679		tristate "Maxim MAX9867 CODEC"
   680		depends on I2C
   681	
   682	config SND_SOC_MAX98925
   683	       tristate
   684	
   685	config SND_SOC_MAX98926
   686		tristate
   687	
   688	config SND_SOC_MAX98927
   689		tristate "Maxim Integrated MAX98927 Speaker Amplifier"
   690		depends on I2C
   691	
   692	config SND_SOC_MAX98373
   693		tristate "Maxim Integrated MAX98373 Speaker Amplifier"
   694		depends on I2C
   695	
   696	config SND_SOC_MAX9850
   697		tristate
   698	
   699	config SND_SOC_MAX9860
   700		tristate "Maxim MAX9860 Mono Audio Voice Codec"
   701		depends on I2C
   702		select REGMAP_I2C
   703	
   704	config SND_SOC_MSM8916_WCD_ANALOG
   705		tristate "Qualcomm MSM8916 WCD Analog Codec"
   706		depends on SPMI || COMPILE_TEST
   707	
   708	config SND_SOC_MSM8916_WCD_DIGITAL
   709		tristate "Qualcomm MSM8916 WCD DIGITAL Codec"
   710		select REGMAP_MMIO
   711	
   712	config SND_SOC_PCM1681
   713		tristate "Texas Instruments PCM1681 CODEC"
   714		depends on I2C
   715	
   716	config SND_SOC_PCM1789
   717		tristate
   718	
   719	config SND_SOC_PCM1789_I2C
   720		tristate "Texas Instruments PCM1789 CODEC (I2C)"
   721		depends on I2C
   722		select SND_SOC_PCM1789
   723		help
   724		  Enable support for Texas Instruments PCM1789 CODEC.
   725		  Select this if your PCM1789 is connected via an I2C bus.
   726	
   727	config SND_SOC_PCM179X
   728		tristate
   729	
   730	config SND_SOC_PCM179X_I2C
   731		tristate "Texas Instruments PCM179X CODEC (I2C)"
   732		depends on I2C
   733		select SND_SOC_PCM179X
   734		help
   735		  Enable support for Texas Instruments PCM179x CODEC.
   736		  Select this if your PCM179x is connected via an I2C bus.
   737	
   738	config SND_SOC_PCM179X_SPI
   739		tristate "Texas Instruments PCM179X CODEC (SPI)"
   740		depends on SPI_MASTER
   741		select SND_SOC_PCM179X
   742		help
   743		  Enable support for Texas Instruments PCM179x CODEC.
   744		  Select this if your PCM179x is connected via an SPI bus.
   745	
   746	config SND_SOC_PCM186X
   747		tristate
   748	
   749	config SND_SOC_PCM186X_I2C
   750		tristate "Texas Instruments PCM186x CODECs - I2C"
   751		depends on I2C
   752		select SND_SOC_PCM186X
   753		select REGMAP_I2C
   754	
   755	config SND_SOC_PCM186X_SPI
   756		tristate "Texas Instruments PCM186x CODECs - SPI"
   757		depends on SPI_MASTER
   758		select SND_SOC_PCM186X
   759		select REGMAP_SPI
   760	
   761	config SND_SOC_PCM3008
   762	       tristate
   763	
   764	config SND_SOC_PCM3060
   765	       tristate
   766	
   767	config SND_SOC_PCM3060_I2C
   768		tristate "Texas Instruments PCM3060 CODEC - I2C"
   769		depends on I2C
   770		select SND_SOC_PCM3060
   771		select REGMAP_I2C
   772	
   773	config SND_SOC_PCM3060_SPI
   774		tristate "Texas Instruments PCM3060 CODEC - SPI"
   775		depends on SPI_MASTER
   776		select SND_SOC_PCM3060
   777		select REGMAP_SPI
   778	
   779	config SND_SOC_PCM3168A
   780		tristate
   781	
   782	config SND_SOC_PCM3168A_I2C
   783		tristate "Texas Instruments PCM3168A CODEC - I2C"
   784		depends on I2C
   785		select SND_SOC_PCM3168A
   786		select REGMAP_I2C
   787	
   788	config SND_SOC_PCM3168A_SPI
   789		tristate "Texas Instruments PCM3168A CODEC - SPI"
   790		depends on SPI_MASTER
   791		select SND_SOC_PCM3168A
   792		select REGMAP_SPI
   793	
   794	config SND_SOC_PCM5102A
   795		tristate
   796	
   797	config SND_SOC_PCM512x
   798		tristate
   799	
   800	config SND_SOC_PCM512x_I2C
   801		tristate "Texas Instruments PCM512x CODECs - I2C"
   802		depends on I2C
   803		select SND_SOC_PCM512x
   804		select REGMAP_I2C
   805	
   806	config SND_SOC_PCM512x_SPI
   807		tristate "Texas Instruments PCM512x CODECs - SPI"
   808		depends on SPI_MASTER
   809		select SND_SOC_PCM512x
   810		select REGMAP_SPI
   811	
   812	config SND_SOC_RK3328
   813		tristate "Rockchip RK3328 audio CODEC"
   814		select REGMAP_MMIO
   815	
   816	config SND_SOC_RL6231
   817		tristate
   818		default y if SND_SOC_RT5514=y
   819		default y if SND_SOC_RT5616=y
   820		default y if SND_SOC_RT5640=y
   821		default y if SND_SOC_RT5645=y
   822		default y if SND_SOC_RT5651=y
   823		default y if SND_SOC_RT5659=y
   824		default y if SND_SOC_RT5660=y
   825		default y if SND_SOC_RT5663=y
   826		default y if SND_SOC_RT5665=y
   827		default y if SND_SOC_RT5668=y
   828		default y if SND_SOC_RT5670=y
   829		default y if SND_SOC_RT5677=y
   830		default y if SND_SOC_RT5682=y
   831		default y if SND_SOC_RT1305=y
   832		default m if SND_SOC_RT5514=m
   833		default m if SND_SOC_RT5616=m
   834		default m if SND_SOC_RT5640=m
   835		default m if SND_SOC_RT5645=m
   836		default m if SND_SOC_RT5651=m
   837		default m if SND_SOC_RT5659=m
   838		default m if SND_SOC_RT5660=m
   839		default m if SND_SOC_RT5663=m
   840		default m if SND_SOC_RT5665=m
   841		default m if SND_SOC_RT5668=m
   842		default m if SND_SOC_RT5670=m
   843		default m if SND_SOC_RT5677=m
   844		default m if SND_SOC_RT5682=m
   845		default m if SND_SOC_RT1305=m
   846	
   847	config SND_SOC_RL6347A
   848		tristate
   849		default y if SND_SOC_RT274=y
   850		default y if SND_SOC_RT286=y
   851		default y if SND_SOC_RT298=y
   852		default m if SND_SOC_RT274=m
   853		default m if SND_SOC_RT286=m
   854		default m if SND_SOC_RT298=m
   855	
   856	config SND_SOC_RT274
   857		tristate
   858		depends on I2C
   859	
   860	config SND_SOC_RT286
   861		tristate
   862		depends on I2C
   863	
   864	config SND_SOC_RT298
   865		tristate
   866		depends on I2C
   867	
   868	config SND_SOC_RT1305
   869		tristate
   870	
   871	config SND_SOC_RT5514
   872		tristate
   873	
   874	config SND_SOC_RT5514_SPI
   875		tristate
   876	
   877	config SND_SOC_RT5514_SPI_BUILTIN
   878		bool # force RT5514_SPI to be built-in to avoid link errors
   879		default SND_SOC_RT5514=y && SND_SOC_RT5514_SPI=m
   880	
   881	config SND_SOC_RT5616
   882		tristate "Realtek RT5616 CODEC"
   883		depends on I2C
   884	
   885	config SND_SOC_RT5631
   886		tristate "Realtek ALC5631/RT5631 CODEC"
   887		depends on I2C
   888	
   889	config SND_SOC_RT5640
   890		tristate
   891	
   892	config SND_SOC_RT5645
   893	        tristate
   894	
   895	config SND_SOC_RT5651
   896		tristate
   897	
   898	config SND_SOC_RT5659
   899		tristate
   900	
   901	config SND_SOC_RT5660
   902		tristate
   903	
   904	config SND_SOC_RT5663
   905		tristate
   906	
   907	config SND_SOC_RT5665
   908		tristate
   909	
   910	config SND_SOC_RT5668
   911		tristate
   912	
   913	config SND_SOC_RT5670
   914		tristate
   915	
   916	config SND_SOC_RT5677
   917		tristate
   918		select REGMAP_I2C
   919		select REGMAP_IRQ
   920	
   921	config SND_SOC_RT5677_SPI
   922		tristate
   923		default SND_SOC_RT5677 && SPI
   924	
   925	config SND_SOC_RT5682
   926		tristate
   927	
   928	#Freescale sgtl5000 codec
   929	config SND_SOC_SGTL5000
   930		tristate "Freescale SGTL5000 CODEC"
   931		depends on I2C
   932	
   933	config SND_SOC_SI476X
   934		tristate
   935	
   936	config SND_SOC_SIGMADSP
   937		tristate
   938		select CRC32
   939	
   940	config SND_SOC_SIGMADSP_I2C
   941		tristate
   942		select SND_SOC_SIGMADSP
   943	
   944	config SND_SOC_SIGMADSP_REGMAP
   945		tristate
   946		select SND_SOC_SIGMADSP
   947	
   948	config SND_SOC_SIMPLE_AMPLIFIER
   949		tristate "Simple Audio Amplifier"
   950		select GPIOLIB
   951	
   952	config SND_SOC_SIRF_AUDIO_CODEC
   953		tristate "SiRF SoC internal audio codec"
   954		select REGMAP_MMIO
   955	
   956	config SND_SOC_SPDIF
   957		tristate "S/PDIF CODEC"
   958	
   959	config SND_SOC_SSM2305
   960		tristate "Analog Devices SSM2305 Class-D Amplifier"
   961		help
   962		  Enable support for Analog Devices SSM2305 filterless
   963		  high-efficiency mono Class-D audio power amplifiers.
   964	
   965	config SND_SOC_SSM2518
   966		tristate
   967	
   968	config SND_SOC_SSM2602
   969		tristate
   970	
   971	config SND_SOC_SSM2602_SPI
   972		tristate "Analog Devices SSM2602 CODEC - SPI"
   973		depends on SPI_MASTER
   974		select SND_SOC_SSM2602
   975		select REGMAP_SPI
   976	
   977	config SND_SOC_SSM2602_I2C
   978		tristate "Analog Devices SSM2602 CODEC - I2C"
   979		depends on I2C
   980		select SND_SOC_SSM2602
   981		select REGMAP_I2C
   982	
   983	config SND_SOC_SSM4567
   984		tristate "Analog Devices ssm4567 amplifier driver support"
   985		depends on I2C
   986	
   987	config SND_SOC_STA32X
   988		tristate "STA326, STA328 and STA329 speaker amplifier"
   989		depends on I2C
   990		select REGMAP_I2C
   991	
   992	config SND_SOC_STA350
   993		tristate "STA350 speaker amplifier"
   994		depends on I2C
   995	
   996	config SND_SOC_STA529
   997		tristate
   998	
   999	config SND_SOC_STAC9766
  1000		tristate
  1001	
  1002	config SND_SOC_STI_SAS
  1003		tristate "codec Audio support for STI SAS codec"
  1004	
  1005	config SND_SOC_TAS2552
  1006		tristate "Texas Instruments TAS2552 Mono Audio amplifier"
  1007		depends on I2C
  1008	
  1009	config SND_SOC_TAS5086
  1010		tristate "Texas Instruments TAS5086 speaker amplifier"
  1011		depends on I2C
  1012	
  1013	config SND_SOC_TAS571X
  1014		tristate "Texas Instruments TAS571x power amplifiers"
  1015		depends on I2C
  1016		help
  1017		  Enable support for Texas Instruments TAS5707, TAS5711, TAS5717,
  1018		  TAS5719 and TAS5721 power amplifiers
  1019	
  1020	config SND_SOC_TAS5720
  1021		tristate "Texas Instruments TAS5720 Mono Audio amplifier"
  1022		depends on I2C
  1023		help
  1024		  Enable support for Texas Instruments TAS5720L/M high-efficiency mono
  1025		  Class-D audio power amplifiers.
  1026	
  1027	config SND_SOC_TAS6424
  1028		tristate "Texas Instruments TAS6424 Quad-Channel Audio amplifier"
  1029		depends on I2C
  1030		help
  1031		  Enable support for Texas Instruments TAS6424 high-efficiency
  1032		  digital input quad-channel Class-D audio power amplifiers.
  1033	
  1034	config SND_SOC_TDA7419
  1035		tristate "ST TDA7419 audio processor"
  1036		depends on I2C
  1037		select REGMAP_I2C
  1038	
  1039	config SND_SOC_TFA9879
  1040		tristate "NXP Semiconductors TFA9879 amplifier"
  1041		depends on I2C
  1042	
  1043	config SND_SOC_TLV320AIC23
  1044		tristate
  1045	
  1046	config SND_SOC_TLV320AIC23_I2C
  1047		tristate "Texas Instruments TLV320AIC23 audio CODEC - I2C"
  1048		depends on I2C
  1049		select SND_SOC_TLV320AIC23
  1050	
  1051	config SND_SOC_TLV320AIC23_SPI
  1052		tristate "Texas Instruments TLV320AIC23 audio CODEC - SPI"
  1053		depends on SPI_MASTER
  1054		select SND_SOC_TLV320AIC23
  1055	
  1056	config SND_SOC_TLV320AIC26
  1057		tristate
  1058		depends on SPI
  1059	
  1060	config SND_SOC_TLV320AIC31XX
  1061		tristate "Texas Instruments TLV320AIC31xx CODECs"
  1062		depends on I2C
  1063		select REGMAP_I2C
  1064	
  1065	config SND_SOC_TLV320AIC32X4
  1066		tristate
  1067	
  1068	config SND_SOC_TLV320AIC32X4_I2C
  1069		tristate "Texas Instruments TLV320AIC32x4 audio CODECs - I2C"
  1070		depends on I2C
  1071		select SND_SOC_TLV320AIC32X4
  1072	
  1073	config SND_SOC_TLV320AIC32X4_SPI
  1074		tristate "Texas Instruments TLV320AIC32x4 audio CODECs - SPI"
  1075		depends on SPI_MASTER
  1076		select SND_SOC_TLV320AIC32X4
  1077	
  1078	config SND_SOC_TLV320AIC3X
  1079		tristate "Texas Instruments TLV320AIC3x CODECs"
  1080		depends on I2C
  1081	
  1082	config SND_SOC_TLV320DAC33
  1083		tristate
  1084	
  1085	config SND_SOC_TS3A227E
  1086		tristate "TI Headset/Mic detect and keypress chip"
  1087		depends on I2C
  1088	
  1089	config SND_SOC_TSCS42XX
  1090		tristate "Tempo Semiconductor TSCS42xx CODEC"
  1091		depends on I2C
  1092		select REGMAP_I2C
  1093		help
  1094		  Add support for Tempo Semiconductor's TSCS42xx audio CODEC.
  1095	
  1096	config SND_SOC_TSCS454
  1097		tristate "Tempo Semiconductor TSCS454 CODEC"
  1098		depends on I2C
  1099		select REGMAP_I2C
  1100		help
  1101		  Add support for Tempo Semiconductor's TSCS454 audio CODEC.
  1102	
  1103	config SND_SOC_TWL4030
  1104		select MFD_TWL4030_AUDIO
  1105		tristate
  1106	
  1107	config SND_SOC_TWL6040
  1108		tristate
  1109	
  1110	config SND_SOC_UDA134X
  1111	       tristate
  1112	
  1113	config SND_SOC_UDA1380
  1114	        tristate
  1115		depends on I2C
  1116	
  1117	config SND_SOC_WL1273
  1118		tristate
  1119	
  1120	config SND_SOC_WM0010
  1121		tristate
  1122	
  1123	config SND_SOC_WM1250_EV1
  1124		tristate
  1125	
  1126	config SND_SOC_WM2000
  1127		tristate
  1128	
  1129	config SND_SOC_WM2200
  1130		tristate
  1131	
  1132	config SND_SOC_WM5100
  1133		tristate
  1134	
  1135	config SND_SOC_WM5102
  1136		tristate
  1137	
  1138	config SND_SOC_WM5110
  1139		tristate
  1140	
  1141	config SND_SOC_WM8350
  1142		tristate
  1143	
  1144	config SND_SOC_WM8400
  1145		tristate
  1146	
  1147	config SND_SOC_WM8510
  1148		tristate "Wolfson Microelectronics WM8510 CODEC"
  1149		depends on SND_SOC_I2C_AND_SPI
  1150	
  1151	config SND_SOC_WM8523
  1152		tristate "Wolfson Microelectronics WM8523 DAC"
  1153		depends on I2C
  1154	
  1155	config SND_SOC_WM8524
  1156		tristate "Wolfson Microelectronics WM8524 DAC"
  1157		depends on GPIOLIB
  1158	
  1159	config SND_SOC_WM8580
  1160		tristate "Wolfson Microelectronics WM8580 and WM8581 CODECs"
  1161		depends on I2C
  1162	
  1163	config SND_SOC_WM8711
  1164		tristate "Wolfson Microelectronics WM8711 CODEC"
  1165		depends on SND_SOC_I2C_AND_SPI
  1166	
  1167	config SND_SOC_WM8727
  1168		tristate
  1169	
  1170	config SND_SOC_WM8728
  1171		tristate "Wolfson Microelectronics WM8728 DAC"
  1172		depends on SND_SOC_I2C_AND_SPI
  1173	
  1174	config SND_SOC_WM8731
  1175		tristate "Wolfson Microelectronics WM8731 CODEC"
  1176		depends on SND_SOC_I2C_AND_SPI
  1177	
  1178	config SND_SOC_WM8737
  1179		tristate "Wolfson Microelectronics WM8737 ADC"
  1180		depends on SND_SOC_I2C_AND_SPI
  1181	
  1182	config SND_SOC_WM8741
  1183		tristate "Wolfson Microelectronics WM8737 DAC"
  1184		depends on SND_SOC_I2C_AND_SPI
  1185	
  1186	config SND_SOC_WM8750
  1187		tristate "Wolfson Microelectronics WM8750 CODEC"
  1188		depends on SND_SOC_I2C_AND_SPI
  1189	
  1190	config SND_SOC_WM8753
  1191		tristate "Wolfson Microelectronics WM8753 CODEC"
  1192		depends on SND_SOC_I2C_AND_SPI
  1193	
  1194	config SND_SOC_WM8770
  1195		tristate "Wolfson Microelectronics WM8770 CODEC"
  1196		depends on SPI_MASTER
  1197	
  1198	config SND_SOC_WM8776
  1199		tristate "Wolfson Microelectronics WM8776 CODEC"
  1200		depends on SND_SOC_I2C_AND_SPI
  1201	
  1202	config SND_SOC_WM8782
  1203		tristate "Wolfson Microelectronics WM8782 ADC"
  1204	
  1205	config SND_SOC_WM8804
  1206		tristate
  1207	
  1208	config SND_SOC_WM8804_I2C
  1209		tristate "Wolfson Microelectronics WM8804 S/PDIF transceiver I2C"
  1210		depends on I2C
  1211		select SND_SOC_WM8804
  1212		select REGMAP_I2C
  1213	
  1214	config SND_SOC_WM8804_SPI
  1215		tristate "Wolfson Microelectronics WM8804 S/PDIF transceiver SPI"
  1216		depends on SPI_MASTER
  1217		select SND_SOC_WM8804
  1218		select REGMAP_SPI
  1219	
  1220	config SND_SOC_WM8900
  1221		tristate
  1222	
  1223	config SND_SOC_WM8903
  1224		tristate "Wolfson Microelectronics WM8903 CODEC"
  1225		depends on I2C
  1226	
  1227	config SND_SOC_WM8904
  1228		tristate "Wolfson Microelectronics WM8904 CODEC"
  1229		depends on I2C
  1230	
  1231	config SND_SOC_WM8940
  1232	        tristate
  1233	
  1234	config SND_SOC_WM8955
  1235		tristate
  1236	
  1237	config SND_SOC_WM8960
  1238		tristate "Wolfson Microelectronics WM8960 CODEC"
  1239		depends on I2C
  1240	
  1241	config SND_SOC_WM8961
  1242		tristate
  1243	
  1244	config SND_SOC_WM8962
  1245		tristate "Wolfson Microelectronics WM8962 CODEC"
  1246		depends on I2C && INPUT
  1247	
  1248	config SND_SOC_WM8971
  1249		tristate
  1250	
  1251	config SND_SOC_WM8974
  1252		tristate "Wolfson Microelectronics WM8974 codec"
  1253		depends on I2C
  1254	
  1255	config SND_SOC_WM8978
  1256		tristate "Wolfson Microelectronics WM8978 codec"
  1257		depends on I2C
  1258	
  1259	config SND_SOC_WM8983
  1260		tristate
  1261	
  1262	config SND_SOC_WM8985
  1263		tristate "Wolfson Microelectronics WM8985 and WM8758 codec driver"
  1264		depends on SND_SOC_I2C_AND_SPI
  1265	
  1266	config SND_SOC_WM8988
  1267		tristate
  1268	
  1269	config SND_SOC_WM8990
  1270		tristate
  1271	
  1272	config SND_SOC_WM8991
  1273		tristate
  1274	
  1275	config SND_SOC_WM8993
  1276		tristate
  1277	
  1278	config SND_SOC_WM8994
  1279		tristate
  1280	
  1281	config SND_SOC_WM8995
  1282		tristate
  1283	
  1284	config SND_SOC_WM8996
  1285		tristate
  1286	
  1287	config SND_SOC_WM8997
  1288		tristate
  1289	
  1290	config SND_SOC_WM8998
  1291		tristate
  1292	
  1293	config SND_SOC_WM9081
  1294		tristate
  1295		depends on I2C
  1296	
  1297	config SND_SOC_WM9090
  1298		tristate
  1299	
  1300	config SND_SOC_WM9705
  1301		tristate
  1302		select REGMAP_AC97
  1303		select AC97_BUS_COMPAT if AC97_BUS_NEW
  1304	
  1305	config SND_SOC_WM9712
  1306		tristate
  1307		select REGMAP_AC97
  1308		select AC97_BUS_COMPAT if AC97_BUS_NEW
  1309	
  1310	config SND_SOC_WM9713
  1311		tristate
  1312		select REGMAP_AC97
  1313		select AC97_BUS_COMPAT if AC97_BUS_NEW
  1314	
  1315	config SND_SOC_ZX_AUD96P22
  1316		tristate "ZTE ZX AUD96P22 CODEC"
  1317		depends on I2C
  1318		select REGMAP_I2C
  1319	
  1320	# Amp
  1321	config SND_SOC_LM4857
  1322		tristate
  1323	
  1324	config SND_SOC_MAX9759
  1325		tristate "Maxim MAX9759 speaker Amplifier"
  1326		select GPIOLIB
  1327	
  1328	config SND_SOC_MAX9768
  1329		tristate
  1330	
  1331	config SND_SOC_MAX9877
  1332		tristate
  1333	
  1334	config SND_SOC_MC13783
  1335		tristate
  1336	
  1337	config SND_SOC_ML26124
  1338		tristate
  1339	
  1340	config SND_SOC_MT6351
  1341		tristate "MediaTek MT6351 Codec"
  1342	
  1343	config SND_SOC_MT6358
  1344		tristate "MediaTek MT6358 Codec"
  1345		help
  1346		  Enable support for the platform which uses MT6358 as
> 1347		external codec device.
> 1348	

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
