From: kbuild test robot <lkp@intel.com>
Subject: Re: [PATCH V3 2/5] drm/i915: Add support for audio
 driver notifications
Date: Tue, 10 Jan 2017 09:27:00 +0800
Message-ID: <201701100951.Y9EVEa5W%fengguang.wu@intel.com>
References: <20170110050841.31900-3-jerome.anand@intel.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="BOKacYhQ+x31HxR3"
Return-path: <intel-gfx-bounces@lists.freedesktop.org>
Content-Disposition: inline
In-Reply-To: <20170110050841.31900-3-jerome.anand@intel.com>
List-Unsubscribe: <https://lists.freedesktop.org/mailman/options/intel-gfx>,
 <mailto:intel-gfx-request@lists.freedesktop.org?subject=unsubscribe>
List-Archive: <https://lists.freedesktop.org/archives/intel-gfx>
List-Post: <mailto:intel-gfx@lists.freedesktop.org>
List-Help: <mailto:intel-gfx-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/intel-gfx>,
 <mailto:intel-gfx-request@lists.freedesktop.org?subject=subscribe>
Errors-To: intel-gfx-bounces@lists.freedesktop.org
Sender: "Intel-gfx" <intel-gfx-bounces@lists.freedesktop.org>
To: Jerome Anand <jerome.anand@intel.com>
Cc: alsa-devel@alsa-project.org, tiwai@suse.de, intel-gfx@lists.freedesktop.org, broonie@kernel.org, rakesh.a.ughreja@intel.com, kbuild-all@01.org
List-Id: alsa-devel@alsa-project.org


--BOKacYhQ+x31HxR3
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi Jerome,

[auto build test WARNING on ]

url:    https://github.com/0day-ci/linux/commits/Jerome-Anand/Add-support-for-Legacy-HDMI-audio-drivers/20170110-062228
base:    
reproduce: make htmldocs

All warnings (new ones prefixed by >>):

   make[3]: warning: jobserver unavailable: using -j1.  Add '+' to parent make rule.
   include/linux/init.h:1: warning: no structured comments found
   include/linux/kthread.h:26: warning: Excess function parameter '...' description in 'kthread_create'
   kernel/sys.c:1: warning: no structured comments found
   drivers/dma-buf/seqno-fence.c:1: warning: no structured comments found
   include/drm/drm_drv.h:444: warning: No description found for parameter 'firstopen'
   include/drm/drm_drv.h:444: warning: No description found for parameter 'open'
   include/drm/drm_drv.h:444: warning: No description found for parameter 'preclose'
   include/drm/drm_drv.h:444: warning: No description found for parameter 'postclose'
   include/drm/drm_drv.h:444: warning: No description found for parameter 'lastclose'
   include/drm/drm_drv.h:444: warning: No description found for parameter 'dma_ioctl'
   include/drm/drm_drv.h:444: warning: No description found for parameter 'dma_quiescent'
   include/drm/drm_drv.h:444: warning: No description found for parameter 'context_dtor'
   include/drm/drm_drv.h:444: warning: No description found for parameter 'set_busid'
   include/drm/drm_drv.h:444: warning: No description found for parameter 'irq_handler'
   include/drm/drm_drv.h:444: warning: No description found for parameter 'irq_preinstall'
   include/drm/drm_drv.h:444: warning: No description found for parameter 'irq_postinstall'
   include/drm/drm_drv.h:444: warning: No description found for parameter 'irq_uninstall'
   include/drm/drm_drv.h:444: warning: No description found for parameter 'debugfs_init'
   include/drm/drm_drv.h:444: warning: No description found for parameter 'debugfs_cleanup'
   include/drm/drm_drv.h:444: warning: No description found for parameter 'gem_open_object'
   include/drm/drm_drv.h:444: warning: No description found for parameter 'gem_close_object'
   include/drm/drm_drv.h:444: warning: No description found for parameter 'prime_handle_to_fd'
   include/drm/drm_drv.h:444: warning: No description found for parameter 'prime_fd_to_handle'
   include/drm/drm_drv.h:444: warning: No description found for parameter 'gem_prime_export'
   include/drm/drm_drv.h:444: warning: No description found for parameter 'gem_prime_import'
   include/drm/drm_drv.h:444: warning: No description found for parameter 'gem_prime_pin'
   include/drm/drm_drv.h:444: warning: No description found for parameter 'gem_prime_unpin'
   include/drm/drm_drv.h:444: warning: No description found for parameter 'gem_prime_res_obj'
   include/drm/drm_drv.h:444: warning: No description found for parameter 'gem_prime_get_sg_table'
   include/drm/drm_drv.h:444: warning: No description found for parameter 'gem_prime_import_sg_table'
   include/drm/drm_drv.h:444: warning: No description found for parameter 'gem_prime_vmap'
   include/drm/drm_drv.h:444: warning: No description found for parameter 'gem_prime_vunmap'
   include/drm/drm_drv.h:444: warning: No description found for parameter 'gem_prime_mmap'
   include/drm/drm_drv.h:444: warning: No description found for parameter 'vgaarb_irq'
   include/drm/drm_drv.h:444: warning: No description found for parameter 'gem_vm_ops'
   include/drm/drm_drv.h:444: warning: No description found for parameter 'major'
   include/drm/drm_drv.h:444: warning: No description found for parameter 'minor'
   include/drm/drm_drv.h:444: warning: No description found for parameter 'patchlevel'
   include/drm/drm_drv.h:444: warning: No description found for parameter 'name'
   include/drm/drm_drv.h:444: warning: No description found for parameter 'desc'
   include/drm/drm_drv.h:444: warning: No description found for parameter 'date'
   include/drm/drm_drv.h:444: warning: No description found for parameter 'driver_features'
   include/drm/drm_drv.h:444: warning: No description found for parameter 'dev_priv_size'
   include/drm/drm_drv.h:444: warning: No description found for parameter 'ioctls'
   include/drm/drm_drv.h:444: warning: No description found for parameter 'num_ioctls'
   include/drm/drm_drv.h:444: warning: No description found for parameter 'fops'
   include/drm/drm_drv.h:444: warning: No description found for parameter 'legacy_dev_list'
>> drivers/gpu/drm/i915/intel_lpe_audio.c:355: warning: Excess function parameter 'connected' description in 'intel_lpe_audio_notify'
   drivers/gpu/drm/i915/intel_lpe_audio.c:356: warning: Excess function parameter 'connected' description in 'intel_lpe_audio_notify'
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

vim +355 drivers/gpu/drm/i915/intel_lpe_audio.c

   339	}
   340	
   341	
   342	/**
   343	 * intel_lpe_audio_notify() - notify lpe audio event
   344	 * audio driver and i915
   345	 * @dev_priv: the i915 drm device private data
   346	 * @eld : ELD data
   347	 * @port: port id
   348	 * @tmds_clk_speed: tmds clock frequency in Hz
   349	 * @connected: hdmi connected/disconnected
   350	 *
   351	 * Notify lpe audio driver of eld change.
   352	 */
   353	void intel_lpe_audio_notify(struct drm_i915_private *dev_priv,
   354				void *eld, int port, int tmds_clk_speed)
 > 355	{
   356		unsigned long irq_flags;
   357		struct intel_hdmi_lpe_audio_pdata *pdata = NULL;
   358	
   359		if (!HAS_LPE_AUDIO(dev_priv))
   360			return;
   361	
   362		pdata = dev_get_platdata(
   363			&(dev_priv->lpe_audio.platdev->dev));

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation

--BOKacYhQ+x31HxR3
Content-Type: application/gzip
Content-Disposition: attachment; filename=".config.gz"
Content-Transfer-Encoding: base64

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

--BOKacYhQ+x31HxR3
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: inline

X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KSW50ZWwtZ2Z4
IG1haWxpbmcgbGlzdApJbnRlbC1nZnhAbGlzdHMuZnJlZWRlc2t0b3Aub3JnCmh0dHBzOi8vbGlz
dHMuZnJlZWRlc2t0b3Aub3JnL21haWxtYW4vbGlzdGluZm8vaW50ZWwtZ2Z4Cg==

--BOKacYhQ+x31HxR3--
