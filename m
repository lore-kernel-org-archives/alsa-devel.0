From: kbuild test robot <lkp@intel.com>
Subject: Re: [PATCH] ALSA: hda - Revert DSP detection on
	legacy	HD-audio driver
Date: Tue, 1 Jan 2019 14:53:00 +0800
Message-ID: <201901011442.TyuFWvdH%fengguang.wu@intel.com>
References: <20181231181720.11396-1-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="a8Wt8u1KmwUX3Y2C"
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
 by alsa0.perex.cz (Postfix) with ESMTP id BA8AD267B24
 for <alsa-devel@alsa-project.org>; Tue,  1 Jan 2019 07:53:36 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <20181231181720.11396-1-tiwai@suse.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel@alsa-project.org, Azat Khuzhin <dohardgopro@gmail.com>, Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>, Hans de Goede <hdegoede@redhat.com>, kbuild-all@01.org, Linus Torvalds <torvalds@linux-foundation.org>
List-Id: alsa-devel@alsa-project.org


--a8Wt8u1KmwUX3Y2C
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi Takashi,

I love your patch! Yet something to improve:

[auto build test ERROR on sound/for-next]
[also build test ERROR on next-20181224]
[cannot apply to v4.20]
[if your patch is applied to the wrong git tree, please drop us a note to help improve the system]

url:    https://github.com/0day-ci/linux/commits/Takashi-Iwai/ALSA-hda-Revert-DSP-detection-on-legacy-HD-audio-driver/20190101-022353
base:   https://git.kernel.org/pub/scm/linux/kernel/git/tiwai/sound.git for-next
config: i386-randconfig-a0-201900 (attached as .config)
compiler: gcc-4.9 (Debian 4.9.4-2) 4.9.4
reproduce:
        # save the attached .config to linux build tree
        make ARCH=i386 

All errors (new ones prefixed by >>):

   sound/soc//intel/skylake/skl.c: In function 'skl_probe':
   sound/soc//intel/skylake/skl.c:976:7: error: 'SND_SKL_PCI_BIND_AUTO' undeclared (first use in this function)
     case SND_SKL_PCI_BIND_AUTO:
          ^
   sound/soc//intel/skylake/skl.c:976:7: note: each undeclared identifier is reported only once for each function it appears in
>> sound/soc//intel/skylake/skl.c:994:7: error: 'SND_SKL_PCI_BIND_LEGACY' undeclared (first use in this function)
     case SND_SKL_PCI_BIND_LEGACY:
          ^
>> sound/soc//intel/skylake/skl.c:997:7: error: 'SND_SKL_PCI_BIND_ASOC' undeclared (first use in this function)
     case SND_SKL_PCI_BIND_ASOC:
          ^

vim +/SND_SKL_PCI_BIND_LEGACY +994 sound/soc//intel/skylake/skl.c

d8c2dab838 Jeeja KP             2015-07-09   967  
d8c2dab838 Jeeja KP             2015-07-09   968  static int skl_probe(struct pci_dev *pci,
d8c2dab838 Jeeja KP             2015-07-09   969  		     const struct pci_device_id *pci_id)
d8c2dab838 Jeeja KP             2015-07-09   970  {
d8c2dab838 Jeeja KP             2015-07-09   971  	struct skl *skl;
d8c2dab838 Jeeja KP             2015-07-09   972  	struct hdac_bus *bus = NULL;
d8c2dab838 Jeeja KP             2015-07-09   973  	int err;
d8c2dab838 Jeeja KP             2015-07-09   974  
d82b51c855 Pierre-Louis Bossart 2018-12-15   975  	switch (skl_pci_binding) {
d82b51c855 Pierre-Louis Bossart 2018-12-15  @976  	case SND_SKL_PCI_BIND_AUTO:
d82b51c855 Pierre-Louis Bossart 2018-12-15   977  		/*
d82b51c855 Pierre-Louis Bossart 2018-12-15   978  		 * detect DSP by checking class/subclass/prog-id information
d82b51c855 Pierre-Louis Bossart 2018-12-15   979  		 * class=04 subclass 03 prog-if 00: no DSP, use legacy driver
d82b51c855 Pierre-Louis Bossart 2018-12-15   980  		 * class=04 subclass 01 prog-if 00: DSP is present
d82b51c855 Pierre-Louis Bossart 2018-12-15   981  		 *   (and may be required e.g. for DMIC or SSP support)
d82b51c855 Pierre-Louis Bossart 2018-12-15   982  		 * class=04 subclass 03 prog-if 80: use DSP or legacy mode
d82b51c855 Pierre-Louis Bossart 2018-12-15   983  		 */
d82b51c855 Pierre-Louis Bossart 2018-12-15   984  		if (pci->class == 0x040300) {
d82b51c855 Pierre-Louis Bossart 2018-12-15   985  			dev_info(&pci->dev, "The DSP is not enabled on this platform, aborting probe\n");
d82b51c855 Pierre-Louis Bossart 2018-12-15   986  			return -ENODEV;
d82b51c855 Pierre-Louis Bossart 2018-12-15   987  		}
d82b51c855 Pierre-Louis Bossart 2018-12-15   988  		if (pci->class != 0x040100 && pci->class != 0x040380) {
d82b51c855 Pierre-Louis Bossart 2018-12-15   989  			dev_err(&pci->dev, "Unknown PCI class/subclass/prog-if information (0x%06x) found, aborting probe\n", pci->class);
d82b51c855 Pierre-Louis Bossart 2018-12-15   990  			return -ENODEV;
d82b51c855 Pierre-Louis Bossart 2018-12-15   991  		}
d82b51c855 Pierre-Louis Bossart 2018-12-15   992  		dev_info(&pci->dev, "DSP detected with PCI class/subclass/prog-if info 0x%06x\n", pci->class);
d82b51c855 Pierre-Louis Bossart 2018-12-15   993  		break;
d82b51c855 Pierre-Louis Bossart 2018-12-15  @994  	case SND_SKL_PCI_BIND_LEGACY:
d82b51c855 Pierre-Louis Bossart 2018-12-15   995  		dev_info(&pci->dev, "Module parameter forced binding with HDaudio legacy, aborting probe\n");
d82b51c855 Pierre-Louis Bossart 2018-12-15   996  		return -ENODEV;
d82b51c855 Pierre-Louis Bossart 2018-12-15  @997  	case SND_SKL_PCI_BIND_ASOC:
d82b51c855 Pierre-Louis Bossart 2018-12-15   998  		dev_info(&pci->dev, "Module parameter forced binding with SKL driver, bypassed detection logic\n");
d82b51c855 Pierre-Louis Bossart 2018-12-15   999  		break;
d82b51c855 Pierre-Louis Bossart 2018-12-15  1000  	default:
d82b51c855 Pierre-Louis Bossart 2018-12-15  1001  		dev_err(&pci->dev, "invalid value for skl_pci_binding module parameter, ignored\n");
d82b51c855 Pierre-Louis Bossart 2018-12-15  1002  		break;
d82b51c855 Pierre-Louis Bossart 2018-12-15  1003  	}
d82b51c855 Pierre-Louis Bossart 2018-12-15  1004  
d8c2dab838 Jeeja KP             2015-07-09  1005  	/* we use ext core ops, so provide NULL for ops here */
d8c2dab838 Jeeja KP             2015-07-09  1006  	err = skl_create(pci, NULL, &skl);
d8c2dab838 Jeeja KP             2015-07-09  1007  	if (err < 0)
d8c2dab838 Jeeja KP             2015-07-09  1008  		return err;
d8c2dab838 Jeeja KP             2015-07-09  1009  
76f56fae1c Rakesh Ughreja       2018-06-01  1010  	bus = skl_to_bus(skl);
d8c2dab838 Jeeja KP             2015-07-09  1011  
76f56fae1c Rakesh Ughreja       2018-06-01  1012  	err = skl_first_init(bus);
f231c34ca9 Pierre-Louis Bossart 2018-12-07  1013  	if (err < 0) {
f231c34ca9 Pierre-Louis Bossart 2018-12-07  1014  		dev_err(bus->dev, "skl_first_init failed with err: %d\n", err);
d8c2dab838 Jeeja KP             2015-07-09  1015  		goto out_free;
f231c34ca9 Pierre-Louis Bossart 2018-12-07  1016  	}
d8c2dab838 Jeeja KP             2015-07-09  1017  
4b235c43de Vinod Koul           2016-02-19  1018  	skl->pci_id = pci->device;
4b235c43de Vinod Koul           2016-02-19  1019  
2e9dc2b645 Vinod Koul           2016-06-22  1020  	device_disable_async_suspend(bus->dev);
2e9dc2b645 Vinod Koul           2016-06-22  1021  
87b2bdf022 Jeeja KP             2015-10-07  1022  	skl->nhlt = skl_nhlt_init(bus->dev);
87b2bdf022 Jeeja KP             2015-10-07  1023  
979cf59acc Wei Yongjun          2016-08-12  1024  	if (skl->nhlt == NULL) {
f231c34ca9 Pierre-Louis Bossart 2018-12-07  1025  #if !IS_ENABLED(CONFIG_SND_SOC_INTEL_SKYLAKE_HDAUDIO_CODEC)
f231c34ca9 Pierre-Louis Bossart 2018-12-07  1026  		dev_err(bus->dev, "no nhlt info found\n");
979cf59acc Wei Yongjun          2016-08-12  1027  		err = -ENODEV;
ab1b732d53 Vinod Koul           2017-05-04  1028  		goto out_free;
f231c34ca9 Pierre-Louis Bossart 2018-12-07  1029  #else
f231c34ca9 Pierre-Louis Bossart 2018-12-07  1030  		dev_warn(bus->dev, "no nhlt info found, continuing to try to enable HDaudio codec\n");
f231c34ca9 Pierre-Louis Bossart 2018-12-07  1031  #endif
f231c34ca9 Pierre-Louis Bossart 2018-12-07  1032  	} else {
87b2bdf022 Jeeja KP             2015-10-07  1033  
0cf5a17159 Subhransu S. Prusty  2017-01-11  1034  		err = skl_nhlt_create_sysfs(skl);
f231c34ca9 Pierre-Louis Bossart 2018-12-07  1035  		if (err < 0) {
f231c34ca9 Pierre-Louis Bossart 2018-12-07  1036  			dev_err(bus->dev, "skl_nhlt_create_sysfs failed with err: %d\n", err);
0cf5a17159 Subhransu S. Prusty  2017-01-11  1037  			goto out_nhlt_free;
f231c34ca9 Pierre-Louis Bossart 2018-12-07  1038  		}
0cf5a17159 Subhransu S. Prusty  2017-01-11  1039  
4b235c43de Vinod Koul           2016-02-19  1040  		skl_nhlt_update_topology_bin(skl);
4b235c43de Vinod Koul           2016-02-19  1041  
bc2bd45b1f Sriram Periyasamy    2017-11-22  1042  		/* create device for dsp clk */
bc2bd45b1f Sriram Periyasamy    2017-11-22  1043  		err = skl_clock_device_register(skl);
f231c34ca9 Pierre-Louis Bossart 2018-12-07  1044  		if (err < 0) {
f231c34ca9 Pierre-Louis Bossart 2018-12-07  1045  			dev_err(bus->dev, "skl_clock_device_register failed with err: %d\n", err);
bc2bd45b1f Sriram Periyasamy    2017-11-22  1046  			goto out_clk_free;
f231c34ca9 Pierre-Louis Bossart 2018-12-07  1047  		}
f231c34ca9 Pierre-Louis Bossart 2018-12-07  1048  	}
f231c34ca9 Pierre-Louis Bossart 2018-12-07  1049  
f231c34ca9 Pierre-Louis Bossart 2018-12-07  1050  	pci_set_drvdata(skl->pci, bus);
f231c34ca9 Pierre-Louis Bossart 2018-12-07  1051  
bc2bd45b1f Sriram Periyasamy    2017-11-22  1052  
752c93aa72 Pankaj Bharadiya     2017-12-18  1053  	err = skl_find_machine(skl, (void *)pci_id->driver_data);
f231c34ca9 Pierre-Louis Bossart 2018-12-07  1054  	if (err < 0) {
f231c34ca9 Pierre-Louis Bossart 2018-12-07  1055  		dev_err(bus->dev, "skl_find_machine failed with err: %d\n", err);
c286b3f960 Jeeja KP             2016-05-05  1056  		goto out_nhlt_free;
f231c34ca9 Pierre-Louis Bossart 2018-12-07  1057  	}
cc18c5fdcd Vinod Koul           2015-11-05  1058  
2a29b200c6 Jeeja KP             2015-10-07  1059  	err = skl_init_dsp(skl);
2a29b200c6 Jeeja KP             2015-10-07  1060  	if (err < 0) {
2a29b200c6 Jeeja KP             2015-10-07  1061  		dev_dbg(bus->dev, "error failed to register dsp\n");
752c93aa72 Pankaj Bharadiya     2017-12-18  1062  		goto out_nhlt_free;
2a29b200c6 Jeeja KP             2015-10-07  1063  	}
0c8ba9d285 Jayachandran B       2015-12-18  1064  	skl->skl_sst->enable_miscbdcge = skl_enable_miscbdcge;
fc9fdd61c4 Sanyog Kale          2018-03-13  1065  	skl->skl_sst->clock_power_gating = skl_clock_power_gating;
7f981bdcf5 Pierre-Louis Bossart 2018-12-07  1066  
ec8ae5703d Vinod Koul           2016-08-04  1067  	if (bus->mlcap)
76f56fae1c Rakesh Ughreja       2018-06-01  1068  		snd_hdac_ext_bus_get_ml_capabilities(bus);
0505700104 Jeeja KP             2015-07-09  1069  
ab1b732d53 Vinod Koul           2017-05-04  1070  	snd_hdac_bus_stop_chip(bus);
ab1b732d53 Vinod Koul           2017-05-04  1071  
d8c2dab838 Jeeja KP             2015-07-09  1072  	/* create device for soc dmic */
d8c2dab838 Jeeja KP             2015-07-09  1073  	err = skl_dmic_device_register(skl);
f231c34ca9 Pierre-Louis Bossart 2018-12-07  1074  	if (err < 0) {
f231c34ca9 Pierre-Louis Bossart 2018-12-07  1075  		dev_err(bus->dev, "skl_dmic_device_register failed with err: %d\n", err);
2a29b200c6 Jeeja KP             2015-10-07  1076  		goto out_dsp_free;
f231c34ca9 Pierre-Louis Bossart 2018-12-07  1077  	}
d8c2dab838 Jeeja KP             2015-07-09  1078  
ab1b732d53 Vinod Koul           2017-05-04  1079  	schedule_work(&skl->probe_work);
d8c2dab838 Jeeja KP             2015-07-09  1080  
d8c2dab838 Jeeja KP             2015-07-09  1081  	return 0;
d8c2dab838 Jeeja KP             2015-07-09  1082  
2a29b200c6 Jeeja KP             2015-10-07  1083  out_dsp_free:
2a29b200c6 Jeeja KP             2015-10-07  1084  	skl_free_dsp(skl);
bc2bd45b1f Sriram Periyasamy    2017-11-22  1085  out_clk_free:
bc2bd45b1f Sriram Periyasamy    2017-11-22  1086  	skl_clock_device_unregister(skl);
c286b3f960 Jeeja KP             2016-05-05  1087  out_nhlt_free:
c286b3f960 Jeeja KP             2016-05-05  1088  	skl_nhlt_free(skl->nhlt);
d8c2dab838 Jeeja KP             2015-07-09  1089  out_free:
76f56fae1c Rakesh Ughreja       2018-06-01  1090  	skl_free(bus);
d8c2dab838 Jeeja KP             2015-07-09  1091  
d8c2dab838 Jeeja KP             2015-07-09  1092  	return err;
d8c2dab838 Jeeja KP             2015-07-09  1093  }
d8c2dab838 Jeeja KP             2015-07-09  1094  

:::::: The code at line 994 was first introduced by commit
:::::: d82b51c855a20eb456ac09f2f40ea98312373263 ALSA: HD-Audio: SKL+: force HDaudio legacy or SKL+ driver selection

:::::: TO: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
:::::: CC: Takashi Iwai <tiwai@suse.de>

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation

--a8Wt8u1KmwUX3Y2C
Content-Type: application/gzip
Content-Disposition: attachment; filename=".config.gz"
Content-Transfer-Encoding: base64

H4sICPoKK1wAAy5jb25maWcAlFxbc9w2sn7Pr5hyXpLasqObFWe39ACCIAcZgmAAci56QSnS
2FFFlnxG8ib+96cb4AXAgMo5W1u7nu4GiEuj++tGQ99/9/2CfH15+nzzcn978/DwbfFp/7g/
3Lzs7xYf7x/2/1nkclHLdsFy3r4D4er+8evfP92ff7hcXLw7O3l38vZw+/NitT887h8W9Onx
4/2nr9D8/unxu++/g/9+D8TPX6Cnw78Xn25v3168+2XxQ77//f7mETr45d3F27Mf3T9AmMq6
4KWh1HBtSkqvvg0k+GHWTGku66uLk19OLkbZitTlyDoZyFz9ZjZSraYeso5XecsFM2zbkqxi
RkvVTvx2qRjJDa8LCf9jWqKxsZ1BaZfkYfG8f/n6ZRomr3lrWL02RJWm4oK3V+dnOOF+ZFI0
HD7TMt0u7p8Xj08v2MPQupKUVMO437xJkQ3pWhnNwGhStZ78kqyZWTFVs8qU17yZxH1OBpyz
NKu6FiTN2V7PtZBzjAtgjAvgjcqff8y3Y3tNAEf4Gn97/XprmVj9YMQ9LWcF6arWLKVuayLY
1ZsfHp8e9z++mfrUO73mDU1+r5Gab434rWMdS3yRKqm1EUxItTOkbQldTp/uNKt4Nv0mHRy3
aJGJokvHgFGAklSReJpqNqT1v+SIrWJs0G44Kovnr78/f3t+2X+etLtkNVOc2pPUKJkx7zB6
LL2UmzSHFQWjLceRF4UR7jxFcg2rc17b45ruRPBSkRaPSJJNl77GIyWXgvA6RTNLzhQu4m7m
U6RVsIGwhHAEW6nSUoppptZ2SEbInIVfKqSiLO9tCUxs4uqGKM3mJ5qzrCsLPTEpDGOlZQcd
uj3MpdedVQZfJCcteYWNtird95pUHBozUxHdGrqjVWKnrd1cH2nYwLb9sTWrW/0q02RKkpzC
h14XE7BbJP+1S8oJqU3X4JAHDW7vP+8PzyklbjldGVkz0FKvq1qa5TXaZ2H1ajzBQGzgGzLn
NHGAXSue2/UZ21hqQnrJyyUqi106pf0mDRw+0bTQtGZpS9ILrGXV1S1Ru0T/vcw0qaERldBm
WBnadD+1N89/Ll5giRY3j3eL55ebl+fFze3t09fHl/vHT9FaQQNDqO0jUF9UUasEKaY1T5ou
QfPJejjM42wynaMBoQzMH7Ruk1NGd6tb0ur0gmiesqgwVq5lNdgHO2NFu4U+VoRhdYDtjw1+
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
LTtF/QEA

--a8Wt8u1KmwUX3Y2C
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--a8Wt8u1KmwUX3Y2C--
