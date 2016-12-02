From: kbuild test robot <lkp@intel.com>
Subject: Re: [PATCH] ALSA: core: update supported sample rates
Date: Sat, 3 Dec 2016 03:45:34 +0800
Message-ID: <201612030325.3Y6Uaa2F%fengguang.wu@intel.com>
References: <c372493a-cbd1-4750-86c1-10c1fff178b2@EX4.ad.cirrus.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
 by alsa0.perex.cz (Postfix) with ESMTP id D66C026698C
 for <alsa-devel@alsa-project.org>; Fri,  2 Dec 2016 20:46:29 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <c372493a-cbd1-4750-86c1-10c1fff178b2@EX4.ad.cirrus.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
Cc: brian.austin@cirrus.com, tiwai@suse.com, alsa-devel@alsa-project.org, paul.handrigan@cirrus.com, o-takashi@sakamocchi.jp, kbuild-all@01.org, jeeja.kp@intel.com, ckeepax@opensource.wolfsonmicro.com, li.xu@cirrus.com
List-Id: alsa-devel@alsa-project.org

Hi Li,

[auto build test WARNING on sound/for-next]
[also build test WARNING on v4.9-rc7 next-20161202]
[if your patch is applied to the wrong git tree, please drop us a note to help improve the system]

url:    https://github.com/0day-ci/linux/commits/Li-Xu/ALSA-core-update-supported-sample-rates/20161203-023018
base:   https://git.kernel.org/pub/scm/linux/kernel/git/tiwai/sound.git for-next
reproduce:
        # apt-get install sparse
        make ARCH=x86_64 allmodconfig
        make C=1 CF=-D__CHECK_ENDIAN__


sparse warnings: (new ones prefixed by >>)

>> sound/usb/caiaq/audio.c:199:2: sparse: "Change this table"
   include/linux/compiler.h:253:8: sparse: attribute 'no_sanitize_address': unknown attribute
   sound/usb/caiaq/audio.c:199:2: error: #error "Change this table"
    #error "Change this table"
     ^~~~~

vim +199 sound/usb/caiaq/audio.c

523f1dce sound/usb/caiaq/caiaq-audio.c Daniel Mack    2007-03-26  183  static int snd_usb_caiaq_pcm_hw_params(struct snd_pcm_substream *sub,
523f1dce sound/usb/caiaq/caiaq-audio.c Daniel Mack    2007-03-26  184  				       struct snd_pcm_hw_params *hw_params)
523f1dce sound/usb/caiaq/caiaq-audio.c Daniel Mack    2007-03-26  185  {
fc76f863 sound/usb/caiaq/audio.c       Antonio Ospite 2013-06-21  186  	return snd_pcm_lib_alloc_vmalloc_buffer(sub,
fc76f863 sound/usb/caiaq/audio.c       Antonio Ospite 2013-06-21  187  						params_buffer_bytes(hw_params));
523f1dce sound/usb/caiaq/caiaq-audio.c Daniel Mack    2007-03-26  188  }
523f1dce sound/usb/caiaq/caiaq-audio.c Daniel Mack    2007-03-26  189  
523f1dce sound/usb/caiaq/caiaq-audio.c Daniel Mack    2007-03-26  190  static int snd_usb_caiaq_pcm_hw_free(struct snd_pcm_substream *sub)
523f1dce sound/usb/caiaq/caiaq-audio.c Daniel Mack    2007-03-26  191  {
1c8470ce sound/usb/caiaq/audio.c       Daniel Mack    2013-03-03  192  	struct snd_usb_caiaqdev *cdev = snd_pcm_substream_chip(sub);
1c8470ce sound/usb/caiaq/audio.c       Daniel Mack    2013-03-03  193  	deactivate_substream(cdev, sub);
fc76f863 sound/usb/caiaq/audio.c       Antonio Ospite 2013-06-21  194  	return snd_pcm_lib_free_vmalloc_buffer(sub);
523f1dce sound/usb/caiaq/caiaq-audio.c Daniel Mack    2007-03-26  195  }
523f1dce sound/usb/caiaq/caiaq-audio.c Daniel Mack    2007-03-26  196  
523f1dce sound/usb/caiaq/caiaq-audio.c Daniel Mack    2007-03-26  197  /* this should probably go upstream */
523f1dce sound/usb/caiaq/caiaq-audio.c Daniel Mack    2007-03-26  198  #if SNDRV_PCM_RATE_5512 != 1 << 0 || SNDRV_PCM_RATE_192000 != 1 << 12
523f1dce sound/usb/caiaq/caiaq-audio.c Daniel Mack    2007-03-26 @199  #error "Change this table"
523f1dce sound/usb/caiaq/caiaq-audio.c Daniel Mack    2007-03-26  200  #endif
523f1dce sound/usb/caiaq/caiaq-audio.c Daniel Mack    2007-03-26  201  
523f1dce sound/usb/caiaq/caiaq-audio.c Daniel Mack    2007-03-26  202  static unsigned int rates[] = { 5512, 8000, 11025, 16000, 22050, 32000, 44100,
523f1dce sound/usb/caiaq/caiaq-audio.c Daniel Mack    2007-03-26  203  				48000, 64000, 88200, 96000, 176400, 192000 };
523f1dce sound/usb/caiaq/caiaq-audio.c Daniel Mack    2007-03-26  204  
523f1dce sound/usb/caiaq/caiaq-audio.c Daniel Mack    2007-03-26  205  static int snd_usb_caiaq_pcm_prepare(struct snd_pcm_substream *substream)
523f1dce sound/usb/caiaq/caiaq-audio.c Daniel Mack    2007-03-26  206  {
523f1dce sound/usb/caiaq/caiaq-audio.c Daniel Mack    2007-03-26  207  	int bytes_per_sample, bpp, ret, i;

:::::: The code at line 199 was first introduced by commit
:::::: 523f1dce37434a9a6623bf46e7893e2b4b10ac3c [ALSA] Add Native Instrument usb audio device support

:::::: TO: Daniel Mack <daniel@caiaq.org>
:::::: CC: Jaroslav Kysela <perex@suse.cz>

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
