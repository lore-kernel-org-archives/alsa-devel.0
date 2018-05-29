From: kbuild test robot <lkp@intel.com>
Subject: Re: [PATCH] ALSA: usb-audio: Allow non-vmalloc buffer
 for PCM buffers
Date: Tue, 29 May 2018 11:32:27 +0800
Message-ID: <201805291158.QzP1l1wJ%fengguang.wu@intel.com>
References: <20180528130921.16058-1-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
 by alsa0.perex.cz (Postfix) with ESMTP id 32B43267196
 for <alsa-devel@alsa-project.org>; Tue, 29 May 2018 05:33:18 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <20180528130921.16058-1-tiwai@suse.de>
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
Cc: alsa-devel@alsa-project.org, kbuild-all@01.org
List-Id: alsa-devel@alsa-project.org

Hi Takashi,

I love your patch! Perhaps something to improve:

[auto build test WARNING on sound/for-next]
[also build test WARNING on v4.17-rc7]
[if your patch is applied to the wrong git tree, please drop us a note to help improve the system]

url:    https://github.com/0day-ci/linux/commits/Takashi-Iwai/ALSA-usb-audio-Allow-non-vmalloc-buffer-for-PCM-buffers/20180529-093537
base:   https://git.kernel.org/pub/scm/linux/kernel/git/tiwai/sound.git for-next
reproduce:
        # apt-get install sparse
        make ARCH=x86_64 allmodconfig
        make C=1 CF=-D__CHECK_ENDIAN__


sparse warnings: (new ones prefixed by >>)

   sound/usb/pcm.c:1078:36: sparse: expression using sizeof(void)
   sound/usb/pcm.c:1078:36: sparse: expression using sizeof(void)
   sound/usb/pcm.c:1181:25: sparse: expression using sizeof(void)
   sound/usb/pcm.c:1181:25: sparse: expression using sizeof(void)
>> sound/usb/pcm.c:1729:25: sparse: incorrect type in initializer (different argument counts) @@    expected int ( *open )( ... ) @@    got int ( *open )( ... ) @@
   sound/usb/pcm.c:1729:25:    expected int ( *open )( ... )
   sound/usb/pcm.c:1729:25:    got int ( *<noident> )( ... )
>> sound/usb/pcm.c:1730:25: sparse: incorrect type in initializer (different argument counts) @@    expected int ( *close )( ... ) @@    got int ( *close )( ... ) @@
   sound/usb/pcm.c:1730:25:    expected int ( *close )( ... )
   sound/usb/pcm.c:1730:25:    got int ( *<noident> )( ... )
   sound/usb/pcm.c:1741:25: sparse: incorrect type in initializer (different argument counts) @@    expected int ( *open )( ... ) @@    got int ( *open )( ... ) @@
   sound/usb/pcm.c:1741:25:    expected int ( *open )( ... )
   sound/usb/pcm.c:1741:25:    got int ( *<noident> )( ... )
   sound/usb/pcm.c:1742:25: sparse: incorrect type in initializer (different argument counts) @@    expected int ( *close )( ... ) @@    got int ( *close )( ... ) @@
   sound/usb/pcm.c:1742:25:    expected int ( *close )( ... )
   sound/usb/pcm.c:1742:25:    got int ( *<noident> )( ... )
   sound/usb/pcm.c:1729:11: error: initialization of 'int (*)(struct snd_pcm_substream *)' from incompatible pointer type 'int (*)(struct snd_pcm_substream *, int)' [-Werror=incompatible-pointer-types]
     .open =  snd_usb_pcm_open,
              ^~~~~~~~~~~~~~~~
   sound/usb/pcm.c:1729:11: note: (near initialization for 'snd_usb_playback_dev_ops.open')
   sound/usb/pcm.c:1730:11: error: initialization of 'int (*)(struct snd_pcm_substream *)' from incompatible pointer type 'int (*)(struct snd_pcm_substream *, int)' [-Werror=incompatible-pointer-types]
     .close = snd_usb_pcm_close,
              ^~~~~~~~~~~~~~~~~
   sound/usb/pcm.c:1730:11: note: (near initialization for 'snd_usb_playback_dev_ops.close')
   sound/usb/pcm.c:1741:11: error: initialization of 'int (*)(struct snd_pcm_substream *)' from incompatible pointer type 'int (*)(struct snd_pcm_substream *, int)' [-Werror=incompatible-pointer-types]
     .open =  snd_usb_pcm_open,
              ^~~~~~~~~~~~~~~~
   sound/usb/pcm.c:1741:11: note: (near initialization for 'snd_usb_capture_dev_ops.open')
   sound/usb/pcm.c:1742:11: error: initialization of 'int (*)(struct snd_pcm_substream *)' from incompatible pointer type 'int (*)(struct snd_pcm_substream *, int)' [-Werror=incompatible-pointer-types]
     .close = snd_usb_pcm_close,
              ^~~~~~~~~~~~~~~~~
   sound/usb/pcm.c:1742:11: note: (near initialization for 'snd_usb_capture_dev_ops.close')
   cc1: some warnings being treated as errors

vim +1729 sound/usb/pcm.c

  1727	
  1728	static const struct snd_pcm_ops snd_usb_playback_dev_ops = {
> 1729		.open =		snd_usb_pcm_open,
> 1730		.close =	snd_usb_pcm_close,
  1731		.ioctl =	snd_pcm_lib_ioctl,
  1732		.hw_params =	snd_usb_hw_params,
  1733		.hw_free =	snd_usb_hw_free,
  1734		.prepare =	snd_usb_pcm_prepare,
  1735		.trigger =	snd_usb_substream_playback_trigger,
  1736		.pointer =	snd_usb_pcm_pointer,
  1737		.page =		snd_pcm_sgbuf_ops_page,
  1738	};
  1739	

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
