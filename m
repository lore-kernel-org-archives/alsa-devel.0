From: kbuild test robot <lkp@intel.com>
Subject: [sound:topic/proc-fixes 71/82] htmldocs:
 sound/core/info.c:886: warning: Function parameter or member 'write' not
 described in 'snd_card_rw_proc_new'
Date: Wed, 6 Feb 2019 05:20:37 +0800
Message-ID: <201902060535.vWuB7eIS%fengguang.wu@intel.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="OXfL5xGRrasGEqWY"
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
 by alsa0.perex.cz (Postfix) with ESMTP id 238F42666B3
 for <alsa-devel@alsa-project.org>; Tue,  5 Feb 2019 22:20:58 +0100 (CET)
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


--OXfL5xGRrasGEqWY
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/tiwai/sound.git topic/proc-fixes
head:   0f66ae449f2ec8e3f4ca30334bb60ce93a3d9822
commit: 2c0283ac599c343937679b178a00ecc453c6899a [71/82] ALSA: info: Add standard helpers for card proc file entries
reproduce: make htmldocs

All warnings (new ones prefixed by >>):

   WARNING: convert(1) not found, for SVG to PDF conversion install ImageMagick (https://www.imagemagick.org)
   include/linux/interrupt.h:268: warning: Function parameter or member 'is_managed' not described in 'irq_affinity_desc'
   block/blk-core.c:685: warning: Excess function parameter 'request_count' description in 'blk_attempt_plug_merge'
   block/blk-core.c:685: warning: Excess function parameter 'request_count' description in 'blk_attempt_plug_merge'
   include/linux/rcupdate_wait.h:1: warning: no structured comments found
   include/linux/rcutree.h:1: warning: no structured comments found
   kernel/rcu/tree.c:710: warning: Excess function parameter 'irq' description in 'rcu_nmi_exit'
   include/linux/gfp.h:1: warning: no structured comments found
   include/net/cfg80211.h:4687: warning: Function parameter or member 'wext.ibss' not described in 'wireless_dev'
   include/net/cfg80211.h:4687: warning: Function parameter or member 'wext.connect' not described in 'wireless_dev'
   include/net/cfg80211.h:4687: warning: Function parameter or member 'wext.keys' not described in 'wireless_dev'
   include/net/cfg80211.h:4687: warning: Function parameter or member 'wext.ie' not described in 'wireless_dev'
   include/net/cfg80211.h:4687: warning: Function parameter or member 'wext.ie_len' not described in 'wireless_dev'
   include/net/cfg80211.h:4687: warning: Function parameter or member 'wext.bssid' not described in 'wireless_dev'
   include/net/cfg80211.h:4687: warning: Function parameter or member 'wext.ssid' not described in 'wireless_dev'
   include/net/cfg80211.h:4687: warning: Function parameter or member 'wext.default_key' not described in 'wireless_dev'
   include/net/cfg80211.h:4687: warning: Function parameter or member 'wext.default_mgmt_key' not described in 'wireless_dev'
   include/net/cfg80211.h:4687: warning: Function parameter or member 'wext.prev_bssid_valid' not described in 'wireless_dev'
   include/net/mac80211.h:2393: warning: Function parameter or member 'radiotap_timestamp.units_pos' not described in 'ieee80211_hw'
   include/net/mac80211.h:2393: warning: Function parameter or member 'radiotap_timestamp.accuracy' not described in 'ieee80211_hw'
   include/net/mac80211.h:1004: warning: Function parameter or member 'control.rates' not described in 'ieee80211_tx_info'
   include/net/mac80211.h:1004: warning: Function parameter or member 'control.rts_cts_rate_idx' not described in 'ieee80211_tx_info'
   include/net/mac80211.h:1004: warning: Function parameter or member 'control.use_rts' not described in 'ieee80211_tx_info'
   include/net/mac80211.h:1004: warning: Function parameter or member 'control.use_cts_prot' not described in 'ieee80211_tx_info'
   include/net/mac80211.h:1004: warning: Function parameter or member 'control.short_preamble' not described in 'ieee80211_tx_info'
   include/net/mac80211.h:1004: warning: Function parameter or member 'control.skip_table' not described in 'ieee80211_tx_info'
   include/net/mac80211.h:1004: warning: Function parameter or member 'control.jiffies' not described in 'ieee80211_tx_info'
   include/net/mac80211.h:1004: warning: Function parameter or member 'control.vif' not described in 'ieee80211_tx_info'
   include/net/mac80211.h:1004: warning: Function parameter or member 'control.hw_key' not described in 'ieee80211_tx_info'
   include/net/mac80211.h:1004: warning: Function parameter or member 'control.flags' not described in 'ieee80211_tx_info'
   include/net/mac80211.h:1004: warning: Function parameter or member 'control.enqueue_time' not described in 'ieee80211_tx_info'
   include/net/mac80211.h:1004: warning: Function parameter or member 'ack' not described in 'ieee80211_tx_info'
   include/net/mac80211.h:1004: warning: Function parameter or member 'ack.cookie' not described in 'ieee80211_tx_info'
   include/net/mac80211.h:1004: warning: Function parameter or member 'status.rates' not described in 'ieee80211_tx_info'
   include/net/mac80211.h:1004: warning: Function parameter or member 'status.ack_signal' not described in 'ieee80211_tx_info'
   include/net/mac80211.h:1004: warning: Function parameter or member 'status.ampdu_ack_len' not described in 'ieee80211_tx_info'
   include/net/mac80211.h:1004: warning: Function parameter or member 'status.ampdu_len' not described in 'ieee80211_tx_info'
   include/net/mac80211.h:1004: warning: Function parameter or member 'status.antenna' not described in 'ieee80211_tx_info'
   include/net/mac80211.h:1004: warning: Function parameter or member 'status.tx_time' not described in 'ieee80211_tx_info'
   include/net/mac80211.h:1004: warning: Function parameter or member 'status.is_valid_ack_signal' not described in 'ieee80211_tx_info'
   include/net/mac80211.h:1004: warning: Function parameter or member 'status.status_driver_data' not described in 'ieee80211_tx_info'
   include/net/mac80211.h:1004: warning: Function parameter or member 'driver_rates' not described in 'ieee80211_tx_info'
   include/net/mac80211.h:1004: warning: Function parameter or member 'pad' not described in 'ieee80211_tx_info'
   include/net/mac80211.h:1004: warning: Function parameter or member 'rate_driver_data' not described in 'ieee80211_tx_info'
   net/mac80211/sta_info.h:590: warning: Function parameter or member 'rx_stats_avg' not described in 'sta_info'
   net/mac80211/sta_info.h:590: warning: Function parameter or member 'rx_stats_avg.signal' not described in 'sta_info'
   net/mac80211/sta_info.h:590: warning: Function parameter or member 'rx_stats_avg.chain_signal' not described in 'sta_info'
   net/mac80211/sta_info.h:590: warning: Function parameter or member 'status_stats.filtered' not described in 'sta_info'
   net/mac80211/sta_info.h:590: warning: Function parameter or member 'status_stats.retry_failed' not described in 'sta_info'
   net/mac80211/sta_info.h:590: warning: Function parameter or member 'status_stats.retry_count' not described in 'sta_info'
   net/mac80211/sta_info.h:590: warning: Function parameter or member 'status_stats.lost_packets' not described in 'sta_info'
   net/mac80211/sta_info.h:590: warning: Function parameter or member 'status_stats.last_tdls_pkt_time' not described in 'sta_info'
   net/mac80211/sta_info.h:590: warning: Function parameter or member 'status_stats.msdu_retries' not described in 'sta_info'
   net/mac80211/sta_info.h:590: warning: Function parameter or member 'status_stats.msdu_failed' not described in 'sta_info'
   net/mac80211/sta_info.h:590: warning: Function parameter or member 'status_stats.last_ack' not described in 'sta_info'
   net/mac80211/sta_info.h:590: warning: Function parameter or member 'status_stats.last_ack_signal' not described in 'sta_info'
   net/mac80211/sta_info.h:590: warning: Function parameter or member 'status_stats.ack_signal_filled' not described in 'sta_info'
   net/mac80211/sta_info.h:590: warning: Function parameter or member 'status_stats.avg_ack_signal' not described in 'sta_info'
   net/mac80211/sta_info.h:590: warning: Function parameter or member 'tx_stats.packets' not described in 'sta_info'
   net/mac80211/sta_info.h:590: warning: Function parameter or member 'tx_stats.bytes' not described in 'sta_info'
   net/mac80211/sta_info.h:590: warning: Function parameter or member 'tx_stats.last_rate' not described in 'sta_info'
   net/mac80211/sta_info.h:590: warning: Function parameter or member 'tx_stats.msdu' not described in 'sta_info'
   kernel/rcu/tree.c:711: warning: Excess function parameter 'irq' description in 'rcu_nmi_exit'
   include/linux/dma-buf.h:304: warning: Function parameter or member 'cb_excl.cb' not described in 'dma_buf'
   include/linux/dma-buf.h:304: warning: Function parameter or member 'cb_excl.poll' not described in 'dma_buf'
   include/linux/dma-buf.h:304: warning: Function parameter or member 'cb_excl.active' not described in 'dma_buf'
   include/linux/dma-buf.h:304: warning: Function parameter or member 'cb_shared.cb' not described in 'dma_buf'
   include/linux/dma-buf.h:304: warning: Function parameter or member 'cb_shared.poll' not described in 'dma_buf'
   include/linux/dma-buf.h:304: warning: Function parameter or member 'cb_shared.active' not described in 'dma_buf'
   include/linux/dma-fence-array.h:54: warning: Function parameter or member 'work' not described in 'dma_fence_array'
   include/linux/firmware/intel/stratix10-svc-client.h:1: warning: no structured comments found
   include/linux/gpio/driver.h:371: warning: Function parameter or member 'init_valid_mask' not described in 'gpio_chip'
   include/linux/iio/hw-consumer.h:1: warning: no structured comments found
   include/linux/input/sparse-keymap.h:46: warning: Function parameter or member 'sw' not described in 'key_entry'
   drivers/mtd/nand/raw/nand_base.c:420: warning: Function parameter or member 'chip' not described in 'nand_fill_oob'
   drivers/mtd/nand/raw/nand_bbt.c:173: warning: Function parameter or member 'this' not described in 'read_bbt'
   drivers/mtd/nand/raw/nand_bbt.c:173: warning: Excess function parameter 'chip' description in 'read_bbt'
   include/linux/regulator/machine.h:199: warning: Function parameter or member 'max_uV_step' not described in 'regulation_constraints'
   include/linux/regulator/driver.h:228: warning: Function parameter or member 'resume' not described in 'regulator_ops'
   arch/s390/include/asm/cio.h:245: warning: Function parameter or member 'esw.esw0' not described in 'irb'
   arch/s390/include/asm/cio.h:245: warning: Function parameter or member 'esw.esw1' not described in 'irb'
   arch/s390/include/asm/cio.h:245: warning: Function parameter or member 'esw.esw2' not described in 'irb'
   arch/s390/include/asm/cio.h:245: warning: Function parameter or member 'esw.esw3' not described in 'irb'
   arch/s390/include/asm/cio.h:245: warning: Function parameter or member 'esw.eadm' not described in 'irb'
   drivers/slimbus/stream.c:1: warning: no structured comments found
>> sound/core/info.c:886: warning: Function parameter or member 'write' not described in 'snd_card_rw_proc_new'
   include/linux/spi/spi.h:180: warning: Function parameter or member 'driver_override' not described in 'spi_device'
   drivers/target/target_core_device.c:1: warning: no structured comments found
   drivers/usb/typec/bus.c:1: warning: no structured comments found
   drivers/usb/typec/class.c:1: warning: no structured comments found
   include/linux/w1.h:281: warning: Function parameter or member 'of_match_table' not described in 'w1_family'
   fs/direct-io.c:257: warning: Excess function parameter 'offset' description in 'dio_complete'
   fs/file_table.c:1: warning: no structured comments found
   fs/libfs.c:477: warning: Excess function parameter 'available' description in 'simple_write_end'
   fs/posix_acl.c:646: warning: Function parameter or member 'inode' not described in 'posix_acl_update_mode'
   fs/posix_acl.c:646: warning: Function parameter or member 'mode_p' not described in 'posix_acl_update_mode'
   fs/posix_acl.c:646: warning: Function parameter or member 'acl' not described in 'posix_acl_update_mode'
   drivers/gpu/drm/amd/amdgpu/amdgpu_mn.c:294: warning: Excess function parameter 'mm' description in 'amdgpu_mn_invalidate_range_start_hsa'
   drivers/gpu/drm/amd/amdgpu/amdgpu_mn.c:294: warning: Excess function parameter 'start' description in 'amdgpu_mn_invalidate_range_start_hsa'
   drivers/gpu/drm/amd/amdgpu/amdgpu_mn.c:294: warning: Excess function parameter 'end' description in 'amdgpu_mn_invalidate_range_start_hsa'
   drivers/gpu/drm/amd/amdgpu/amdgpu_mn.c:343: warning: Excess function parameter 'mm' description in 'amdgpu_mn_invalidate_range_end'
   drivers/gpu/drm/amd/amdgpu/amdgpu_mn.c:343: warning: Excess function parameter 'start' description in 'amdgpu_mn_invalidate_range_end'
   drivers/gpu/drm/amd/amdgpu/amdgpu_mn.c:343: warning: Excess function parameter 'end' description in 'amdgpu_mn_invalidate_range_end'
   drivers/gpu/drm/amd/amdgpu/amdgpu_mn.c:183: warning: Function parameter or member 'blockable' not described in 'amdgpu_mn_read_lock'
   drivers/gpu/drm/amd/amdgpu/amdgpu_mn.c:295: warning: Function parameter or member 'range' not described in 'amdgpu_mn_invalidate_range_start_hsa'
   drivers/gpu/drm/amd/amdgpu/amdgpu_mn.c:295: warning: Excess function parameter 'mm' description in 'amdgpu_mn_invalidate_range_start_hsa'
   drivers/gpu/drm/amd/amdgpu/amdgpu_mn.c:295: warning: Excess function parameter 'start' description in 'amdgpu_mn_invalidate_range_start_hsa'
   drivers/gpu/drm/amd/amdgpu/amdgpu_mn.c:295: warning: Excess function parameter 'end' description in 'amdgpu_mn_invalidate_range_start_hsa'
   drivers/gpu/drm/amd/amdgpu/amdgpu_mn.c:344: warning: Function parameter or member 'range' not described in 'amdgpu_mn_invalidate_range_end'
   drivers/gpu/drm/amd/amdgpu/amdgpu_mn.c:344: warning: Excess function parameter 'mm' description in 'amdgpu_mn_invalidate_range_end'
   drivers/gpu/drm/amd/amdgpu/amdgpu_mn.c:344: warning: Excess function parameter 'start' description in 'amdgpu_mn_invalidate_range_end'
   drivers/gpu/drm/amd/amdgpu/amdgpu_mn.c:344: warning: Excess function parameter 'end' description in 'amdgpu_mn_invalidate_range_end'
   drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c:382: warning: cannot understand function prototype: 'struct amdgpu_vm_pt_cursor '
   drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c:383: warning: cannot understand function prototype: 'struct amdgpu_vm_pt_cursor '
   drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c:555: warning: Function parameter or member 'adev' not described in 'for_each_amdgpu_vm_pt_leaf'
   drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c:555: warning: Function parameter or member 'vm' not described in 'for_each_amdgpu_vm_pt_leaf'
   drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c:555: warning: Function parameter or member 'start' not described in 'for_each_amdgpu_vm_pt_leaf'
   drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c:555: warning: Function parameter or member 'end' not described in 'for_each_amdgpu_vm_pt_leaf'
   drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c:555: warning: Function parameter or member 'cursor' not described in 'for_each_amdgpu_vm_pt_leaf'
   drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c:603: warning: Function parameter or member 'adev' not described in 'for_each_amdgpu_vm_pt_dfs_safe'
   drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c:603: warning: Function parameter or member 'vm' not described in 'for_each_amdgpu_vm_pt_dfs_safe'
   drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c:603: warning: Function parameter or member 'cursor' not described in 'for_each_amdgpu_vm_pt_dfs_safe'
   drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c:603: warning: Function parameter or member 'entry' not described in 'for_each_amdgpu_vm_pt_dfs_safe'
   drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c:845: warning: Function parameter or member 'level' not described in 'amdgpu_vm_bo_param'
   drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c:1353: warning: Function parameter or member 'params' not described in 'amdgpu_vm_update_func'
   drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c:1353: warning: Function parameter or member 'bo' not described in 'amdgpu_vm_update_func'
   drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c:1353: warning: Function parameter or member 'pe' not described in 'amdgpu_vm_update_func'
   drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c:1353: warning: Function parameter or member 'addr' not described in 'amdgpu_vm_update_func'
   drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c:1353: warning: Function parameter or member 'count' not described in 'amdgpu_vm_update_func'
   drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c:1353: warning: Function parameter or member 'incr' not described in 'amdgpu_vm_update_func'
   drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c:1353: warning: Function parameter or member 'flags' not described in 'amdgpu_vm_update_func'
   drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c:1520: warning: Function parameter or member 'params' not described in 'amdgpu_vm_update_huge'
   drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c:1520: warning: Function parameter or member 'bo' not described in 'amdgpu_vm_update_huge'
   drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c:1520: warning: Function parameter or member 'level' not described in 'amdgpu_vm_update_huge'
   drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c:1520: warning: Function parameter or member 'pe' not described in 'amdgpu_vm_update_huge'
   drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c:1520: warning: Function parameter or member 'addr' not described in 'amdgpu_vm_update_huge'
   drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c:1520: warning: Function parameter or member 'count' not described in 'amdgpu_vm_update_huge'
   drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c:1520: warning: Function parameter or member 'incr' not described in 'amdgpu_vm_update_huge'
   drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c:1520: warning: Function parameter or member 'flags' not described in 'amdgpu_vm_update_huge'
   drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c:3096: warning: Function parameter or member 'pasid' not described in 'amdgpu_vm_make_compute'
   drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h:128: warning: Incorrect use of kernel-doc format: Documentation Makefile include scripts source @atomic_obj
   drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h:203: warning: Function parameter or member 'atomic_obj' not described in 'amdgpu_display_manager'
   drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h:203: warning: Function parameter or member 'atomic_obj_lock' not described in 'amdgpu_display_manager'
   drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h:203: warning: Function parameter or member 'backlight_link' not described in 'amdgpu_display_manager'
   drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h:203: warning: Function parameter or member 'backlight_caps' not described in 'amdgpu_display_manager'
   drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h:203: warning: Function parameter or member 'freesync_module' not described in 'amdgpu_display_manager'
   drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h:203: warning: Function parameter or member 'fw_dmcu' not described in 'amdgpu_display_manager'
   drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h:203: warning: Function parameter or member 'dmcu_fw_version' not described in 'amdgpu_display_manager'
   drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c:1: warning: no structured comments found
   include/drm/drm_drv.h:618: warning: Function parameter or member 'gem_prime_pin' not described in 'drm_driver'
   include/drm/drm_drv.h:618: warning: Function parameter or member 'gem_prime_unpin' not described in 'drm_driver'
   include/drm/drm_drv.h:618: warning: Function parameter or member 'gem_prime_res_obj' not described in 'drm_driver'
   include/drm/drm_drv.h:618: warning: Function parameter or member 'gem_prime_get_sg_table' not described in 'drm_driver'
   include/drm/drm_drv.h:618: warning: Function parameter or member 'gem_prime_import_sg_table' not described in 'drm_driver'
   include/drm/drm_drv.h:618: warning: Function parameter or member 'gem_prime_vmap' not described in 'drm_driver'
   include/drm/drm_drv.h:618: warning: Function parameter or member 'gem_prime_vunmap' not described in 'drm_driver'
   include/drm/drm_drv.h:618: warning: Function parameter or member 'gem_prime_mmap' not described in 'drm_driver'
   include/drm/drm_atomic_state_helper.h:1: warning: no structured comments found
   drivers/gpu/drm/drm_dp_helper.c:1362: warning: Function parameter or member 'dsc_dpcd' not described in 'drm_dp_dsc_sink_max_slice_count'
   drivers/gpu/drm/drm_dp_helper.c:1362: warning: Function parameter or member 'is_edp' not described in 'drm_dp_dsc_sink_max_slice_count'
   drivers/gpu/drm/i915/i915_vma.h:49: warning: cannot understand function prototype: 'struct i915_vma '
   drivers/gpu/drm/i915/i915_vma.h:1: warning: no structured comments found
   drivers/gpu/drm/i915/intel_guc_fwif.h:536: warning: cannot understand function prototype: 'struct guc_log_buffer_state '
   drivers/gpu/drm/i915/i915_trace.h:1: warning: no structured comments found
   include/linux/skbuff.h:876: warning: Function parameter or member 'dev_scratch' not described in 'sk_buff'
   include/linux/skbuff.h:876: warning: Function parameter or member 'list' not described in 'sk_buff'
   include/linux/skbuff.h:876: warning: Function parameter or member 'ip_defrag_offset' not described in 'sk_buff'
   include/linux/skbuff.h:876: warning: Function parameter or member 'skb_mstamp_ns' not described in 'sk_buff'
   include/linux/skbuff.h:876: warning: Function parameter or member '__cloned_offset' not described in 'sk_buff'
   include/linux/skbuff.h:876: warning: Function parameter or member 'head_frag' not described in 'sk_buff'
   include/linux/skbuff.h:876: warning: Function parameter or member '__pkt_type_offset' not described in 'sk_buff'
   include/linux/skbuff.h:876: warning: Function parameter or member 'encapsulation' not described in 'sk_buff'
   include/linux/skbuff.h:876: warning: Function parameter or member 'encap_hdr_csum' not described in 'sk_buff'
   include/linux/skbuff.h:876: warning: Function parameter or member 'csum_valid' not described in 'sk_buff'
   include/linux/skbuff.h:876: warning: Function parameter or member '__pkt_vlan_present_offset' not described in 'sk_buff'
   include/linux/skbuff.h:876: warning: Function parameter or member 'vlan_present' not described in 'sk_buff'
   include/linux/skbuff.h:876: warning: Function parameter or member 'csum_complete_sw' not described in 'sk_buff'
   include/linux/skbuff.h:876: warning: Function parameter or member 'csum_level' not described in 'sk_buff'
   include/linux/skbuff.h:876: warning: Function parameter or member 'inner_protocol_type' not described in 'sk_buff'
   include/linux/skbuff.h:876: warning: Function parameter or member 'remcsum_offload' not described in 'sk_buff'
   include/linux/skbuff.h:876: warning: Function parameter or member 'sender_cpu' not described in 'sk_buff'
   include/linux/skbuff.h:876: warning: Function parameter or member 'reserved_tailroom' not described in 'sk_buff'
   include/linux/skbuff.h:876: warning: Function parameter or member 'inner_ipproto' not described in 'sk_buff'
   include/net/sock.h:238: warning: Function parameter or member 'skc_addrpair' not described in 'sock_common'
   include/net/sock.h:238: warning: Function parameter or member 'skc_portpair' not described in 'sock_common'
   include/net/sock.h:238: warning: Function parameter or member 'skc_ipv6only' not described in 'sock_common'

vim +886 sound/core/info.c

   868	
   869	/**
   870	 * snd_card_rw_proc_new - Create a read/write text proc file entry for the card
   871	 * @card: the card instance
   872	 * @name: the file name
   873	 * @private_data: the arbitrary private data
   874	 * @read: the read callback
   875	 *
   876	 * This proc file entry will be registered via snd_card_register() call, and
   877	 * it will be removed automatically at the card removal, too.
   878	 */
   879	int snd_card_rw_proc_new(struct snd_card *card, const char *name,
   880				 void *private_data,
   881				 void (*read)(struct snd_info_entry *,
   882					      struct snd_info_buffer *),
   883				 void (*write)(struct snd_info_entry *entry,
   884					       struct snd_info_buffer *buffer))
   885	{
 > 886		struct snd_info_entry *entry;
   887	
   888		entry = snd_info_create_card_entry(card, name, card->proc_root);
   889		if (!entry)
   890			return -ENOMEM;
   891		snd_info_set_text_ops(entry, private_data, read);
   892		if (write) {
   893			entry->mode |= 0200;
   894			entry->c.text.write = write;
   895		}
   896		return 0;
   897	}
   898	EXPORT_SYMBOL_GPL(snd_card_rw_proc_new);
   899	

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation

--OXfL5xGRrasGEqWY
Content-Type: application/gzip
Content-Disposition: attachment; filename=".config.gz"
Content-Transfer-Encoding: base64

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

--OXfL5xGRrasGEqWY
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--OXfL5xGRrasGEqWY--
