From: Michael Leun <lkml20150926@newton.leun.net>
Subject: Baytrail based HDMI Stick Orbsmart AW-01: No sound
Date: Sat, 26 Sep 2015 22:09:23 +0200
Message-ID: <20150926220923.2bb02248@xenia.leun.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from stator.leun.net (stator.leun.net [85.214.203.199])
 by alsa0.perex.cz (Postfix) with ESMTP id 855B72606E9
 for <alsa-devel@alsa-project.org>; Sat, 26 Sep 2015 22:11:08 +0200 (CEST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
Cc: oder_chiou@realtek.com, bardliao@realtek.com, yang.jie@linux.intel.com
List-Id: alsa-devel@alsa-project.org

Hi,

I've an baytrail / Z3735F based HDMI Stick "Orbsmart AW-01", but sound
does not work.

I'm a little lost finding out what is missing / required to make it
work.

I compiled an 4.3-rc2 vanilla kernel with hopefully each and everything
turned on relating soc/sound.

In dmesg I get:

[...]
[    4.252522] sst-acpi 80860F28:00: No matching ASoC machine driver found
[    5.863177] intel_sst_acpi 80860F28:00: No matching machine driver found
[...]

It looks like there is rt5640 based sound recognized:

[ml@orb ~]$ find /sys -name '*5640*' -print
/sys/bus/i2c/drivers/rt5640
/sys/bus/acpi/devices/10EC5640:00
/sys/bus/acpi/devices/10EC5640:01
/sys/devices/LNXSYSTM:00/LNXSYBUS:00/80860F41:01/10EC5640:00
/sys/devices/LNXSYSTM:00/LNXSYBUS:00/80860F41:01/10EC5640:01
find: "/sys/kernel/debug": Keine Berechtigung
/sys/module/i2c_core/holders/snd_soc_rt5640
/sys/module/snd_soc_rl6231/holders/snd_soc_rt5640
/sys/module/snd_soc_rt5640
/sys/module/snd_soc_rt5640/drivers/i2c:rt5640
/sys/module/snd_soc_core/holders/snd_soc_rt5640
/sys/module/regmap_i2c/holders/snd_soc_rt5640
/sys/module/snd_pcm/holders/snd_soc_rt5640
[ml@orb ~]$

This are the sound related modules loaded:

[ml@orb ~]$ lsmod|grep snd
snd_intel_sst_acpi     16384  0
snd_intel_sst_core     65536  1 snd_intel_sst_acpi
snd_soc_rt5640        106496  0
snd_soc_sst_mfld_platform    73728  1 snd_intel_sst_core
snd_soc_rl6231         16384  1 snd_soc_rt5640
snd_soc_core          155648  2 snd_soc_rt5640,snd_soc_sst_mfld_platform
snd_compress           20480  1 snd_soc_core
regmap_i2c             16384  1 snd_soc_rt5640
snd_pcm_dmaengine      16384  1 snd_soc_core
ac97_bus               16384  1 snd_soc_core
snd_pcm                86016  4 snd_soc_rt5640,snd_soc_core,snd_soc_sst_mfld_platform,snd_pcm_dmaengine
snd_timer              28672  1 snd_pcm
snd                    65536  5 snd_soc_core,snd_timer,snd_pcm,snd_soc_sst_mfld_platform,snd_compress
soundcore              16384  1 snd
i2c_core               49152  7 drm,i915,snd_soc_rt5640,i2c_designware_platform,regmap_i2c,drm_kms_helper,i2c_algo_bit
snd_soc_sst_acpi       16384  0
[ml@orb ~]$ 

-- 
Best Regards,

Michael Leun
