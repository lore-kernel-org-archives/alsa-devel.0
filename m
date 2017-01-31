From: kbuild test robot <fengguang.wu@intel.com>
Subject: [sound:topic/intel-lpe-audio-cleanup 12/49] htmldocs:
 drivers/gpu/drm/i915/intel_lpe_audio.c:337: warning: No description found
 for parameter 'pipe'
Date: Wed, 1 Feb 2017 06:40:56 +0800
Message-ID: <201702010655.y5wAMnSY%fengguang.wu@intel.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="6c2NcOVqGQ03X4Wi"
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
 by alsa0.perex.cz (Postfix) with ESMTP id 09AF1266652
 for <alsa-devel@alsa-project.org>; Tue, 31 Jan 2017 23:41:08 +0100 (CET)
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
To: Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel@alsa-project.org, kbuild-all@01.org
List-Id: alsa-devel@alsa-project.org


--6c2NcOVqGQ03X4Wi
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/tiwai/sound.git topic/intel-lpe-audio-cleanup
head:   4d0f8298c72c6c084d5e62235f05d152d61e9bdc
commit: 8e4d2c9fe684af0219d3a05d07460f1e881945b1 [12/49] drm/i915: Pass pipe to LPE audio notification
reproduce: make htmldocs

All warnings (new ones prefixed by >>):

   make[3]: warning: jobserver unavailable: using -j1.  Add '+' to parent make rule.
   include/linux/init.h:1: warning: no structured comments found
   include/linux/kthread.h:26: warning: Excess function parameter '...' description in 'kthread_create'
   kernel/sys.c:1: warning: no structured comments found
   drivers/dma-buf/seqno-fence.c:1: warning: no structured comments found
   include/drm/drm_drv.h:409: warning: No description found for parameter 'load'
   include/drm/drm_drv.h:409: warning: No description found for parameter 'firstopen'
   include/drm/drm_drv.h:409: warning: No description found for parameter 'open'
   include/drm/drm_drv.h:409: warning: No description found for parameter 'preclose'
   include/drm/drm_drv.h:409: warning: No description found for parameter 'postclose'
   include/drm/drm_drv.h:409: warning: No description found for parameter 'lastclose'
   include/drm/drm_drv.h:409: warning: No description found for parameter 'unload'
   include/drm/drm_drv.h:409: warning: No description found for parameter 'dma_ioctl'
   include/drm/drm_drv.h:409: warning: No description found for parameter 'dma_quiescent'
   include/drm/drm_drv.h:409: warning: No description found for parameter 'context_dtor'
   include/drm/drm_drv.h:409: warning: No description found for parameter 'set_busid'
   include/drm/drm_drv.h:409: warning: No description found for parameter 'irq_handler'
   include/drm/drm_drv.h:409: warning: No description found for parameter 'irq_preinstall'
   include/drm/drm_drv.h:409: warning: No description found for parameter 'irq_postinstall'
   include/drm/drm_drv.h:409: warning: No description found for parameter 'irq_uninstall'
   include/drm/drm_drv.h:409: warning: No description found for parameter 'debugfs_init'
   include/drm/drm_drv.h:409: warning: No description found for parameter 'debugfs_cleanup'
   include/drm/drm_drv.h:409: warning: No description found for parameter 'gem_open_object'
   include/drm/drm_drv.h:409: warning: No description found for parameter 'gem_close_object'
   include/drm/drm_drv.h:409: warning: No description found for parameter 'prime_handle_to_fd'
   include/drm/drm_drv.h:409: warning: No description found for parameter 'prime_fd_to_handle'
   include/drm/drm_drv.h:409: warning: No description found for parameter 'gem_prime_export'
   include/drm/drm_drv.h:409: warning: No description found for parameter 'gem_prime_import'
   include/drm/drm_drv.h:409: warning: No description found for parameter 'gem_prime_pin'
   include/drm/drm_drv.h:409: warning: No description found for parameter 'gem_prime_unpin'
   include/drm/drm_drv.h:409: warning: No description found for parameter 'gem_prime_res_obj'
   include/drm/drm_drv.h:409: warning: No description found for parameter 'gem_prime_get_sg_table'
   include/drm/drm_drv.h:409: warning: No description found for parameter 'gem_prime_import_sg_table'
   include/drm/drm_drv.h:409: warning: No description found for parameter 'gem_prime_vmap'
   include/drm/drm_drv.h:409: warning: No description found for parameter 'gem_prime_vunmap'
   include/drm/drm_drv.h:409: warning: No description found for parameter 'gem_prime_mmap'
   include/drm/drm_drv.h:409: warning: No description found for parameter 'vgaarb_irq'
   include/drm/drm_drv.h:409: warning: No description found for parameter 'gem_vm_ops'
   include/drm/drm_drv.h:409: warning: No description found for parameter 'major'
   include/drm/drm_drv.h:409: warning: No description found for parameter 'minor'
   include/drm/drm_drv.h:409: warning: No description found for parameter 'patchlevel'
   include/drm/drm_drv.h:409: warning: No description found for parameter 'name'
   include/drm/drm_drv.h:409: warning: No description found for parameter 'desc'
   include/drm/drm_drv.h:409: warning: No description found for parameter 'date'
   include/drm/drm_drv.h:409: warning: No description found for parameter 'driver_features'
   include/drm/drm_drv.h:409: warning: No description found for parameter 'dev_priv_size'
   include/drm/drm_drv.h:409: warning: No description found for parameter 'ioctls'
   include/drm/drm_drv.h:409: warning: No description found for parameter 'num_ioctls'
   include/drm/drm_drv.h:409: warning: No description found for parameter 'fops'
   include/drm/drm_drv.h:409: warning: No description found for parameter 'legacy_dev_list'
>> drivers/gpu/drm/i915/intel_lpe_audio.c:337: warning: No description found for parameter 'pipe'
   drivers/gpu/drm/i915/intel_lpe_audio.c:337: warning: No description found for parameter 'dp_output'
   drivers/gpu/drm/i915/intel_lpe_audio.c:337: warning: No description found for parameter 'link_rate'
   drivers/gpu/drm/i915/intel_lpe_audio.c:338: warning: No description found for parameter 'pipe'
   drivers/gpu/drm/i915/intel_lpe_audio.c:338: warning: No description found for parameter 'dp_output'
   drivers/gpu/drm/i915/intel_lpe_audio.c:338: warning: No description found for parameter 'link_rate'
   drivers/media/dvb-core/dvb_frontend.h:677: warning: No description found for parameter 'refcount'
   drivers/char/tpm/tpm_vtpm_proxy.c:73: warning: No description found for parameter 'filp'
   drivers/char/tpm/tpm_vtpm_proxy.c:73: warning: No description found for parameter 'buf'
   drivers/char/tpm/tpm_vtpm_proxy.c:73: warning: No description found for parameter 'count'
   drivers/char/tpm/tpm_vtpm_proxy.c:73: warning: No description found for parameter 'off'
   drivers/char/tpm/tpm_vtpm_proxy.c:123: warning: No description found for parameter 'filp'
   drivers/char/tpm/tpm_vtpm_proxy.c:123: warning: No description found for parameter 'buf'
   drivers/char/tpm/tpm_vtpm_proxy.c:123: warning: No description found for parameter 'count'
   drivers/char/tpm/tpm_vtpm_proxy.c:123: warning: No description found for parameter 'off'
   drivers/char/tpm/tpm_vtpm_proxy.c:203: warning: No description found for parameter 'proxy_dev'
   sound/soc/soc-core.c:994: warning: No description found for parameter 'stream_name'
   Documentation/core-api/assoc_array.rst:13: WARNING: Enumerated list ends without a blank line; unexpected unindent.
   Documentation/doc-guide/sphinx.rst:110: ERROR: Unknown target name: "sphinx c domain".
   include/net/cfg80211.h:3154: ERROR: Unexpected indentation.
   include/net/mac80211.h:3214: ERROR: Unexpected indentation.
   include/net/mac80211.h:3217: WARNING: Block quote ends without a blank line; unexpected unindent.
   include/net/mac80211.h:3219: ERROR: Unexpected indentation.
   include/net/mac80211.h:3220: WARNING: Block quote ends without a blank line; unexpected unindent.
   include/net/mac80211.h:1773: ERROR: Unexpected indentation.
   include/net/mac80211.h:1777: WARNING: Block quote ends without a blank line; unexpected unindent.
   kernel/sched/fair.c:7587: WARNING: Inline emphasis start-string without end-string.
   kernel/time/timer.c:1240: ERROR: Unexpected indentation.
   kernel/time/timer.c:1242: ERROR: Unexpected indentation.
   kernel/time/timer.c:1243: WARNING: Block quote ends without a blank line; unexpected unindent.
   include/linux/wait.h:121: WARNING: Block quote ends without a blank line; unexpected unindent.
   include/linux/wait.h:124: ERROR: Unexpected indentation.
   include/linux/wait.h:126: WARNING: Block quote ends without a blank line; unexpected unindent.
   kernel/time/hrtimer.c:1021: WARNING: Block quote ends without a blank line; unexpected unindent.
   kernel/signal.c:317: WARNING: Inline literal start-string without end-string.
   drivers/message/fusion/mptbase.c:5051: WARNING: Definition list ends without a blank line; unexpected unindent.
   drivers/tty/serial/serial_core.c:1897: WARNING: Definition list ends without a blank line; unexpected unindent.
   include/linux/spi/spi.h:369: ERROR: Unexpected indentation.
   drivers/usb/core/message.c:481: ERROR: Unexpected indentation.
   drivers/usb/core/message.c:482: WARNING: Block quote ends without a blank line; unexpected unindent.
   Documentation/driver-api/usb.rst:623: ERROR: Unknown target name: "usb_type".
   Documentation/driver-api/usb.rst:623: ERROR: Unknown target name: "usb_dir".
   Documentation/driver-api/usb.rst:623: ERROR: Unknown target name: "usb_recip".
   Documentation/driver-api/usb.rst:689: ERROR: Unknown target name: "usbdevfs_urb_type".
   sound/soc/soc-core.c:2508: ERROR: Unknown target name: "snd_soc_daifmt".
   sound/core/jack.c:312: ERROR: Unknown target name: "snd_jack_btn".
   Documentation/translations/ko_KR/howto.rst:293: WARNING: Inline emphasis start-string without end-string.
   WARNING: dvipng command 'dvipng' cannot be run (needed for math display), check the imgmath_dvipng setting

vim +/pipe +337 drivers/gpu/drm/i915/intel_lpe_audio.c

eef57324 Jerome Anand         2017-01-25  321  }
46d196ec Jerome Anand         2017-01-25  322  
46d196ec Jerome Anand         2017-01-25  323  
46d196ec Jerome Anand         2017-01-25  324  /**
46d196ec Jerome Anand         2017-01-25  325   * intel_lpe_audio_notify() - notify lpe audio event
46d196ec Jerome Anand         2017-01-25  326   * audio driver and i915
46d196ec Jerome Anand         2017-01-25  327   * @dev_priv: the i915 drm device private data
46d196ec Jerome Anand         2017-01-25  328   * @eld : ELD data
46d196ec Jerome Anand         2017-01-25  329   * @port: port id
46d196ec Jerome Anand         2017-01-25  330   * @tmds_clk_speed: tmds clock frequency in Hz
46d196ec Jerome Anand         2017-01-25  331   *
46d196ec Jerome Anand         2017-01-25  332   * Notify lpe audio driver of eld change.
46d196ec Jerome Anand         2017-01-25  333   */
46d196ec Jerome Anand         2017-01-25  334  void intel_lpe_audio_notify(struct drm_i915_private *dev_priv,
8e4d2c9f Takashi Iwai         2017-01-31  335  			    void *eld, int port, int pipe, int tmds_clk_speed,
5114001f Pierre-Louis Bossart 2017-01-31  336  			    bool dp_output, int link_rate)
46d196ec Jerome Anand         2017-01-25 @337  {
46d196ec Jerome Anand         2017-01-25  338  	unsigned long irq_flags;
46d196ec Jerome Anand         2017-01-25  339  	struct intel_hdmi_lpe_audio_pdata *pdata = NULL;
2ca74624 Pierre-Louis Bossart 2017-01-31  340  	u32 audio_enable;
2ca74624 Pierre-Louis Bossart 2017-01-31  341  	i915_reg_t mmio;
46d196ec Jerome Anand         2017-01-25  342  
46d196ec Jerome Anand         2017-01-25  343  	if (!HAS_LPE_AUDIO(dev_priv))
46d196ec Jerome Anand         2017-01-25  344  		return;
46d196ec Jerome Anand         2017-01-25  345  

:::::: The code at line 337 was first introduced by commit
:::::: 46d196ec460b9c45ca225f815c0b05f9de67290d drm/i915: Add support for audio driver notifications

:::::: TO: Jerome Anand <jerome.anand@intel.com>
:::::: CC: Takashi Iwai <tiwai@suse.de>

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation

--6c2NcOVqGQ03X4Wi
Content-Type: application/gzip
Content-Disposition: attachment; filename=".config.gz"
Content-Transfer-Encoding: base64

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

--6c2NcOVqGQ03X4Wi
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--6c2NcOVqGQ03X4Wi--
