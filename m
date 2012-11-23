From: kbuild test robot <fengguang.wu@intel.com>
Subject: [asoc:topic/wm8994 8/8]
	sound/soc/codecs/wm8994.c:3454:29: error: invalid type
	argument of '->' (have 'struct wm8994_pdata')
Date: Fri, 23 Nov 2012 23:09:48 +0800
Message-ID: <50af91bc.kc73BWFFYUWIx0iS%fengguang.wu@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
 by alsa0.perex.cz (Postfix) with ESMTP id 4998F26031F
 for <alsa-devel@alsa-project.org>; Fri, 23 Nov 2012 16:10:46 +0100 (CET)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@opensource.wolfsonmicro.com>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

tree:   git://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git topic/wm8994
head:   0b1a5f157fd0248cb96cbd2dda3b9c5e8ab21b82
commit: 0b1a5f157fd0248cb96cbd2dda3b9c5e8ab21b82 [8/8] ASoC: wm8994: Use pdata cached in MFD driver
config: make ARCH=i386 allyesconfig

All error/warnings:

sound/soc/codecs/wm8994.c: In function 'wm8958_default_micdet':
sound/soc/codecs/wm8994.c:3454:29: error: invalid type argument of '->' (have 'struct wm8994_pdata')

vim +3454 sound/soc/codecs/wm8994.c

af6b6fe4 Mark Brown 2011-11-30  3448  
c986564b Mark Brown 2012-03-12  3449  			wm1811_jackdet_set_mode(codec,
c986564b Mark Brown 2012-03-12  3450  						WM1811_JACKDET_MODE_JACK);
c986564b Mark Brown 2012-03-12  3451  
c986564b Mark Brown 2012-03-12  3452  			mutex_unlock(&wm8994->accdet_lock);
c986564b Mark Brown 2012-03-12  3453  
0b1a5f15 Mark Brown 2012-10-08 @3454  			if (wm8994->wm8994->pdata->jd_ext_cap)
07fb9d9e Mark Brown 2012-02-21  3455  				snd_soc_dapm_disable_pin(&codec->dapm,
07fb9d9e Mark Brown 2012-02-21  3456  							 "MICBIAS2");
af6b6fe4 Mark Brown 2011-11-30  3457  		}

---
0-DAY kernel build testing backend         Open Source Technology Center
Fengguang Wu, Yuanhan Liu                              Intel Corporation
