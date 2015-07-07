From: Tyler Yeomans <tyeo098@gmail.com>
Subject: Re: Intel Baytrail Linux Audio
Date: Tue, 07 Jul 2015 17:06:18 -0400
Message-ID: <559C3F4A.5030307@gmail.com>
References: <8D3F6266AEB6384E807C6FFC6FE195E30B49AE39@BGSMSX101.gar.corp.intel.com>
 <20150703143608.7afb34c985d82982e929484e@ao2.it>
 <20150703130658.GA1689228@phare.normalesup.org> <559A90CE.2030105@gmail.com>
 <20150707031950.GD11002@localhost> <559BDB7F.9010105@gmail.com>
 <20150707170821.GL11002@localhost>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="------------000009050904040101040108"
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-qk0-f175.google.com (mail-qk0-f175.google.com
 [209.85.220.175])
 by alsa0.perex.cz (Postfix) with ESMTP id F2953260590
 for <alsa-devel@alsa-project.org>; Tue,  7 Jul 2015 23:06:19 +0200 (CEST)
Received: by qkeo142 with SMTP id o142so149636845qke.1
 for <alsa-devel@alsa-project.org>; Tue, 07 Jul 2015 14:06:19 -0700 (PDT)
In-Reply-To: <20150707170821.GL11002@localhost>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Vinod Koul <vinod.koul@intel.com>
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, Antonio Ospite <ao2@ao2.it>, Nicolas George <george@nsup.org>, "Girdwood,
 Liam R" <liam.r.girdwood@intel.com>, "Nikula,
 Jarkko" <jarkko.nikula@intel.com>
List-Id: alsa-devel@alsa-project.org

This is a multi-part message in MIME format.
--------------000009050904040101040108
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit

Vinod,

I have attached ... what I think is what you're looking for with regards 
to the dynamic debug output.

Additionally, the interrupts report as follows... none:
$ cat /proc/interrupts | grep sst
    7:          0          0          0          0   IO-APIC 
28-fasteoi   intel_sst_driver

Thanks-

Tyler

On 07/07/2015 01:08 PM, Vinod Koul wrote:
> On Tue, Jul 07, 2015 at 10:00:31AM -0400, Tyler Yeomans wrote:
>> Vinod,
>>
>> I am using the ssp0 firmware from:
>> https://git.kernel.org/cgit/linux/kernel/git/vkoul/firmware.git/tree/intel?h=byt.
> Hi Tyler,
>
> Can you enable logs (dynamic debug should help), I want to see if FW
> download was success or not
>
> Also cat /proc/interrupts to see if we are getting interrupts
>
> Thanks


--------------000009050904040101040108
Content-Type: text/plain; charset=UTF-8;
 name="soundout.txt"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename="soundout.txt"

sound/core/init.c:120 [snd]init_info_for_card =_ "unable to create card entry\012"
sound/core/init.c:116 [snd]init_info_for_card =_ "unable to create card info\012"
sound/core/control.c:1520 [snd]snd_ctl_ioctl =_ "unknown ioctl = 0x%x\012"
sound/core/device.c:156 [snd]snd_device_free =_ "device free %p (from %pF), not found\012"
sound/core/device.c:132 [snd]snd_device_disconnect =_ "device disconnect %p (from %pF), not found\012"
sound/core/timer.c:244 [snd_timer]snd_timer_open =_ "ALSA: timer: invalid slave class %i\012"
sound/core/seq/seq_clientmgr.c:2212 [snd_seq]snd_seq_do_ioctl =_ "ALSA: seq unknown ioctl() 0x%x (type='%c', number=0x%02x)\012"
sound/core/seq/seq_clientmgr.c:811 [snd_seq]snd_seq_deliver_event =_ "ALSA: seq: too long delivery path (%d:%d->%d:%d)\012"
sound/core/seq/seq_clientmgr.c:127 [snd_seq]clientptr =_ "ALSA: seq: oops. Trying to get pointer to client %d\012"
sound/core/seq/seq_clientmgr.c:140 [snd_seq]snd_seq_client_use_ptr =_ "ALSA: seq: oops. Trying to get pointer to client %d\012"
sound/core/seq/seq_memory.c:239 [snd_seq]snd_seq_cell_alloc =_ "ALSA: seq: pool is not initialized\012"
sound/core/seq/seq_prioq.c:260 [snd_seq]snd_seq_prioq_cell_peek =_ "ALSA: seq: snd_seq_prioq_cell_in() called with NULL prioq\012"
sound/core/seq/seq_prioq.c:249 [snd_seq]snd_seq_prioq_avail =_ "ALSA: seq: snd_seq_prioq_cell_in() called with NULL prioq\012"
sound/core/seq/seq_prioq.c:224 [snd_seq]snd_seq_prioq_cell_out =_ "ALSA: seq: snd_seq_prioq_cell_in() called with NULL prioq\012"
sound/core/seq/seq_prioq.c:80 [snd_seq]snd_seq_prioq_delete =_ "ALSA: seq: snd_seq_prioq_delete() called with NULL prioq\012"
sound/core/seq/seq_timer.c:253 [snd_seq]snd_seq_timer_set_skew =_ "ALSA: seq: invalid skew base 0x%x\012"
sound/core/seq/seq_timer.c:200 [snd_seq]snd_seq_timer_set_ppq =_ "ALSA: seq: cannot change ppq of a running timer\012"
sound/core/seq/seq_timer.c:79 [snd_seq]snd_seq_timer_delete =_ "ALSA: seq: snd_seq_timer_delete() called with NULL timer\012"
sound/core/rawmidi.c:814 [snd_rawmidi]snd_rawmidi_ioctl =_ "rawmidi: unknown command = 0x%x\012"
sound/core/rawmidi.c:1132 [snd_rawmidi]snd_rawmidi_transmit_ack =_ "snd_rawmidi_transmit_ack: output is not active!!!\012"
sound/core/rawmidi.c:1080 [snd_rawmidi]snd_rawmidi_transmit_peek =_ "snd_rawmidi_transmit_peek: output is not active!!!\012"
sound/core/rawmidi.c:1047 [snd_rawmidi]snd_rawmidi_transmit_empty =_ "snd_rawmidi_transmit_empty: output is not active!!!\012"
sound/core/rawmidi.c:885 [snd_rawmidi]snd_rawmidi_receive =_ "snd_rawmidi_receive: input is not active!!!\012"
sound/core/seq/seq_midi.c:192 [snd_seq_midi]midisynth_subscribe =_ "ALSA: seq_midi: midi input open failed!!!\012"
sound/core/seq/seq_midi.c:234 [snd_seq_midi]midisynth_use =_ "ALSA: seq_midi: midi output open failed!!!\012"
sound/core/seq/seq_midi.c:148 [snd_seq_midi]event_process_midi =_ "ALSA: seq_midi: invalid sysex event flags = 0x%x\012"
sound/core/pcm_native.c:1735 [snd_pcm]snd_pcm_drain =_ "playback drain error (DMA or IRQ trouble?)\012"
sound/core/pcm_native.c:2805 [snd_pcm]snd_pcm_common_ioctl1 =_ "unknown ioctl = 0x%x\012"
sound/core/pcm_native.c:2273 [snd_pcm]snd_pcm_open_substream =_ "snd_pcm_hw_constraints_complete failed\012"
sound/core/pcm_native.c:2262 [snd_pcm]snd_pcm_open_substream =_ "snd_pcm_hw_constraints_init failed\012"
sound/core/pcm_lib.c:1977 [snd_pcm]wait_for_avail =_ "%s write error (DMA or IRQ trouble?)\012"
sound/core/compress_offload.c:988 [snd_compress]snd_compress_deregister =_ "Removing compressed device %s\012"
sound/core/compress_offload.c:966 [snd_compress]snd_compress_register =_ "Registering compressed device %s\012"
sound/core/compress_offload.c:341 [snd_compress]snd_compr_read =_ "avail returned %ld\012"
sound/core/compress_offload.c:248 [snd_compress]snd_compr_write_data =_ "copying %ld at %lld\012"
sound/core/compress_offload.c:304 [snd_compress]snd_compr_write =_ "stream prepared, Houston we are good to go\012"
sound/core/compress_offload.c:286 [snd_compress]snd_compr_write =_ "avail returned %ld\012"
sound/core/compress_offload.c:394 [snd_compress]snd_compr_poll =_ "avail is %ld\012"
sound/core/compress_offload.c:773 [snd_compress]snd_compr_partial_drain =_ "Partial drain returned failure\012"
sound/core/compress_offload.c:712 [snd_compress]snd_compress_wait_for_drain =_ "wait for drain failed with %d\012"
sound/core/compress_offload.c:710 [snd_compress]snd_compress_wait_for_drain =_ "wait aborted by a signal"
sound/core/compress_offload.c:731 [snd_compress]snd_compr_drain =_ "SND_COMPR_TRIGGER_DRAIN failed %d\012"
sound/core/compress_offload.c:208 [snd_compress]snd_compr_calc_avail =_ "ret avail as %lld\012"
sound/core/compress_offload.c:198 [snd_compress]snd_compr_calc_avail =_ "both pointers are same, returning no avail\012"
sound/core/compress_offload.c:195 [snd_compress]snd_compr_calc_avail =_ "both pointers are same, returning full avail\012"
sound/core/compress_offload.c:191 [snd_compress]snd_compr_calc_avail =_ "app wrote %lld, DSP consumed %lld\012"
sound/core/compress_offload.c:186 [snd_compress]snd_compr_calc_avail =_ "detected init and someone forgot to do a write\012"
sound/core/compress_offload.c:168 [snd_compress]snd_compr_update_tstamp =_ "dsp consumed till %d total %d bytes\012"
sound/core/compress_offload.c:872 [snd_compress]snd_compress_dev_register =_ "reg %s for device %s, direction %d\012"
sound/soc/soc-core.c:3163 [snd_soc_core]snd_soc_unregister_codec =_ "ASoC: Unregistered codec '%s'\012"
sound/soc/soc-core.c:3129 [snd_soc_core]snd_soc_register_codec =_ "ASoC: Registered codec '%s'\012"
sound/soc/soc-core.c:3055 [snd_soc_core]snd_soc_register_codec =_ "codec register %s\012"
sound/soc/soc-core.c:2927 [snd_soc_core]snd_soc_remove_platform =_ "ASoC: Unregistered platform '%s'\012"
sound/soc/soc-core.c:2900 [snd_soc_core]snd_soc_register_platform =_ "ASoC: platform register %s\012"
sound/soc/soc-core.c:2883 [snd_soc_core]snd_soc_add_platform =_ "ASoC: Registered platform '%s'\012"
sound/soc/soc-core.c:2556 [snd_soc_core]snd_soc_unregister_dais =_ "ASoC: Unregistered DAI '%s'\012"
sound/soc/soc-core.c:2625 [snd_soc_core]snd_soc_register_dais =_ "ASoC: Registered DAI '%s'\012"
sound/soc/soc-core.c:2581 [snd_soc_core]snd_soc_register_dais =_ "ASoC: dai register %s #%Zu\012"
sound/soc/soc-core.c:2478 [snd_soc_core]snd_soc_unregister_card =_ "ASoC: Unregistered card '%s'\012"
sound/soc/soc-core.c:1334 [snd_soc_core]soc_probe_link_dais =_ "ASoC: probe %s dai link %d late %d\012"
sound/soc/soc-core.c:938 [snd_soc_core]soc_bind_dai_link =_ "ASoC: binding %s at idx %d\012"
sound/soc/soc-core.c:815 [snd_soc_core]soc_resume_deferred =_ "ASoC: resume work completed\012"
sound/soc/soc-core.c:767 [snd_soc_core]soc_resume_deferred =_ "ASoC: CODEC was on over suspend\012"
sound/soc/soc-core.c:733 [snd_soc_core]soc_resume_deferred =_ "ASoC: starting resume work\012"
sound/soc/soc-core.c:867 [snd_soc_core]snd_soc_resume =_ "ASoC: Scheduling resume work\012"
sound/soc/soc-core.c:864 [snd_soc_core]snd_soc_resume =_ "ASoC: Resuming control bus master immediately\012"
sound/soc/soc-core.c:693 [snd_soc_core]snd_soc_suspend =_ "ASoC: CODEC is on over suspend\012"
sound/soc/soc-core.c:678 [snd_soc_core]snd_soc_suspend =_ "ASoC: idle_bias_off CODEC on over suspend\012"
sound/soc/soc-core.c:569 [snd_soc_core]snd_soc_get_pcm_runtime =_ "ASoC: failed to find rtd %s\012"
sound/soc/soc-core.c:555 [snd_soc_core]snd_soc_get_dai_substream =_ "ASoC: failed to find dai link %s\012"
sound/soc/soc-dapm.c:3778 [snd_soc_core]snd_soc_dapm_force_enable_pin_unlocked =_ "ASoC: force enable pin %s\012"
sound/soc/soc-dapm.c:3611 [snd_soc_core]dapm_connect_dai_link_widgets =_ "connected DAI link %s:%s -> %s:%s\012"
sound/soc/soc-dapm.c:3599 [snd_soc_core]dapm_connect_dai_link_widgets =_ "connected DAI link %s:%s -> %s:%s\012"
sound/soc/soc-dapm.c:3570 [snd_soc_core]snd_soc_dapm_link_dai_widgets =_ "%s -> %s\012"
sound/soc/soc-dapm.c:3513 [snd_soc_core]snd_soc_dapm_new_dai_widgets =_ "ASoC: adding %s widget\012"
sound/soc/soc-dapm.c:3494 [snd_soc_core]snd_soc_dapm_new_dai_widgets =_ "ASoC: adding %s widget\012"
sound/soc/soc-dapm.c:3443 [snd_soc_core]snd_soc_dapm_new_pcm =_ "ASoC: adding %s widget\012"
sound/soc/soc-dapm.c:928 [snd_soc_core]dapm_list_add_widget =_ "ASoC: added %s in widget list pos %d\012"
sound/soc/soc-dapm.c:889 [snd_soc_core]snd_soc_dapm_suspend_check =_ "ASoC: %s ignoring suspend\012"
sound/soc/soc-cache.c:49 [snd_soc_core]snd_soc_cache_exit =_ "ASoC: Destroying cache for %s codec\012"
sound/soc/soc-cache.c:29 [snd_soc_core]snd_soc_cache_init =_ "ASoC: Initializing cache for %s codec\012"
sound/soc/soc-pcm.c:2820 [snd_soc_core]soc_dpcm_debugfs_add =_ "ASoC: Failed to create dpcm debugfs directory %s\012"
sound/soc/soc-pcm.c:602 [snd_soc_core]close_delayed_work =_ "ASoC: pop wq checking: %s status: %s waiting: %s\012"
sound/soc/soc-pcm.c:1551 [snd_soc_core]dpcm_fe_dai_startup =_ "ASoC: open FE %s\012"
sound/soc/soc-pcm.c:2406 [snd_soc_core]dpcm_fe_dai_open =_ "ASoC: %s no valid %s route\012"
sound/soc/soc-pcm.c:1804 [snd_soc_core]dpcm_fe_dai_hw_params =_ "ASoC: hw_params FE %s rate %d chan %x fmt %d\012"
sound/soc/soc-pcm.c:2061 [snd_soc_core]dpcm_fe_dai_prepare =_ "ASoC: prepare FE %s\012"
sound/soc/soc-pcm.c:1686 [snd_soc_core]dpcm_fe_dai_hw_free =_ "ASoC: hw_free FE %s\012"
sound/soc/soc-pcm.c:1623 [snd_soc_core]dpcm_fe_dai_shutdown =_ "ASoC: close FE %s\012"
sound/soc/soc-pcm.c:2510 [snd_soc_core]soc_new_pcm =_ "ASoC: registered pcm #%d %s\012"
sound/soc/soc-pcm.c:2378 [snd_soc_core]soc_dpcm_be_digital_mute =_ "ASoC: BE digital mute %s\012"
sound/soc/soc-pcm.c:2127 [snd_soc_core]dpcm_run_update_shutdown =_ "ASoC: trigger FE %s cmd stop\012"
sound/soc/soc-pcm.c:2120 [snd_soc_core]dpcm_run_update_shutdown =_ "ASoC: bespoke trigger FE %s cmd stop\012"
sound/soc/soc-pcm.c:2115 [snd_soc_core]dpcm_run_update_shutdown =_ "ASoC: runtime %s close on FE %s\012"
sound/soc/soc-pcm.c:1970 [snd_soc_core]dpcm_fe_dai_do_trigger =_ "ASoC: bespoke trigger FE %s cmd %d\012"
sound/soc/soc-pcm.c:1962 [snd_soc_core]dpcm_fe_dai_do_trigger =_ "ASoC: post trigger FE %s cmd %d\012"
sound/soc/soc-pcm.c:1942 [snd_soc_core]dpcm_fe_dai_do_trigger =_ "ASoC: pre trigger FE %s cmd %d\012"
sound/soc/soc-pcm.c:2206 [snd_soc_core]dpcm_run_update_startup =_ "ASoC: trigger FE %s cmd start\012"
sound/soc/soc-pcm.c:2197 [snd_soc_core]dpcm_run_update_startup =_ "ASoC: bespoke trigger FE %s cmd start\012"
sound/soc/soc-pcm.c:2157 [snd_soc_core]dpcm_run_update_startup =_ "ASoC: runtime %s open on FE %s\012"
sound/soc/soc-pcm.c:2281 [snd_soc_core]soc_dpcm_runtime_update =_ "ASoC: DPCM runtime update for FE %s\012"
sound/soc/soc-pcm.c:2040 [snd_soc_core]dpcm_be_dai_prepare =_ "ASoC: prepare BE %s\012"
sound/soc/soc-pcm.c:1826 [snd_soc_core]dpcm_do_trigger =_ "ASoC: trigger BE %s cmd %d\012"
sound/soc/soc-pcm.c:1730 [snd_soc_core]dpcm_be_dai_hw_params =_ "ASoC: hw_params BE %s\012"
sound/soc/soc-pcm.c:1668 [snd_soc_core]dpcm_be_dai_hw_free =_ "ASoC: hw_free BE %s\012"
sound/soc/soc-pcm.c:1603 [snd_soc_core]dpcm_be_dai_shutdown =_ "ASoC: close BE %s\012"
sound/soc/soc-pcm.c:216 [snd_soc_core]soc_pcm_apply_symmetry =_ "ASoC: Symmetry forces %d sample bits\012"
sound/soc/soc-pcm.c:199 [snd_soc_core]soc_pcm_apply_symmetry =_ "ASoC: Symmetry forces %d channel(s)\012"
sound/soc/soc-pcm.c:183 [snd_soc_core]soc_pcm_apply_symmetry =_ "ASoC: Symmetry forces %dHz rate\012"
sound/soc/soc-pcm.c:540 [snd_soc_core]soc_pcm_open =_ "ASoC: min rate %d max rate %d\012"
sound/soc/soc-pcm.c:538 [snd_soc_core]soc_pcm_open =_ "ASoC: min ch %d max ch %d\012"
sound/soc/soc-pcm.c:536 [snd_soc_core]soc_pcm_open =_ "ASoC: rate mask 0x%x\012"
sound/soc/soc-pcm.c:535 [snd_soc_core]soc_pcm_open =_ "ASoC: %s <-> %s info:\012"
sound/soc/soc-pcm.c:1436 [snd_soc_core]dpcm_be_dai_startup =_ "ASoC: open %s BE %s\012"
sound/soc/soc-pcm.c:1292 [snd_soc_core]dpcm_prune_paths =_ "ASoC: found %d old BE paths for pruning\012"
sound/soc/soc-pcm.c:1286 [snd_soc_core]dpcm_prune_paths =_ "ASoC: pruning %s BE %s for %s\012"
sound/soc/soc-pcm.c:1097 [snd_soc_core]dpcm_be_connect =_ "connected new DPCM %s path %s %s %s\012"
sound/soc/soc-pcm.c:1345 [snd_soc_core]dpcm_add_paths =_ "ASoC: found %d new BE paths\012"
sound/soc/soc-pcm.c:1249 [snd_soc_core]dpcm_path_get =_ "ASoC: found %d audio %s paths\012"
sound/soc/soc-pcm.c:1127 [snd_soc_core]dpcm_be_reparent =_ "reparent %s path %s %s %s\012"
sound/soc/soc-pcm.c:1150 [snd_soc_core]dpcm_be_disconnect =_ "freed DSP %s path %s %s %s\012"
sound/soc/soc-pcm.c:1143 [snd_soc_core]dpcm_be_disconnect =_ "ASoC: BE %s disconnect check for %s\012"
sound/soc/soc-pcm.c:164 [snd_soc_core]dpcm_dapm_stream_event =_ "ASoC: BE %s event %d dir %d\012"
sound/soc/soc-compress.c:109 [snd_soc_core]soc_compr_open_fe =_ "ASoC: %s no valid %s route\012"
sound/soc/soc-compress.c:167 [snd_soc_core]close_delayed_work =_ "ASoC: pop wq checking: %s status: %s waiting: %s\012"
sound/soc/codecs/rl6231.c:103 [snd_soc_rl6231]rl6231_pll_calc =_ "Only get approximation about PLL\012"
sound/soc/codecs/rt5640.c:1792 [snd_soc_rt5640]rt5640_set_dai_sysclk =_ "Sysclk is %dHz and clock id is %d\012"
sound/soc/codecs/rt5640.c:1853 [snd_soc_rt5640]rt5640_set_dai_pll =_ "bypass=%d m=%d n=%d k=%d\012"
sound/soc/codecs/rt5640.c:1809 [snd_soc_rt5640]rt5640_set_dai_pll =_ "PLL disabled\012"
sound/soc/codecs/rt5640.c:1659 [snd_soc_rt5640]rt5640_hw_params =_ "bclk_ms is %d and pre_div is %d for iis %d\012"
sound/soc/codecs/rt5640.c:1657 [snd_soc_rt5640]rt5640_hw_params =_ "bclk is %dHz and lrck is %dHz\012"
sound/soc/intel/atom/sst-mfld-platform-pcm.c:604 [snd_soc_sst_mfld_platform]sst_platform_pcm_trigger =_ "sst: in pause release\012"
sound/soc/intel/atom/sst-mfld-platform-pcm.c:598 [snd_soc_sst_mfld_platform]sst_platform_pcm_trigger =_ "sst: in pause\012"
sound/soc/intel/atom/sst-mfld-platform-pcm.c:592 [snd_soc_sst_mfld_platform]sst_platform_pcm_trigger =_ "sst: in stop\012"
sound/soc/intel/atom/sst-mfld-platform-pcm.c:586 [snd_soc_sst_mfld_platform]sst_platform_pcm_trigger =_ "sst: Trigger Start\012"
sound/soc/intel/atom/sst-mfld-platform-pcm.c:579 [snd_soc_sst_mfld_platform]sst_platform_pcm_trigger =_ "sst_platform_pcm_trigger called\012"
sound/soc/intel/atom/sst-mfld-platform-pcm.c:288 [snd_soc_sst_mfld_platform]sst_platform_init_stream =_ "setting buffer ptr param\012"
sound/soc/intel/atom/sst-mfld-platform-pcm.c:731 [snd_soc_sst_mfld_platform]sst_platform_remove =_ "sst_platform_remove success\012"
sound/soc/intel/atom/sst-mfld-platform-pcm.c:73 [snd_soc_sst_mfld_platform]sst_unregister_dsp =_ "unreg %s\012"
sound/soc/intel/atom/sst-mfld-platform-pcm.c:51 [snd_soc_sst_mfld_platform]sst_register_dsp =_ "registering device %s\012"
sound/soc/intel/atom/sst-mfld-platform-compress.c:98 [snd_soc_sst_mfld_platform]sst_platform_compr_free =_ "%s: %d\012"
sound/soc/intel/atom/sst-mfld-platform-compress.c:36 [snd_soc_sst_mfld_platform]sst_compr_fragment_elapsed =_ "fragment elapsed by driver\012"
sound/soc/intel/atom/sst-mfld-platform-compress.c:45 [snd_soc_sst_mfld_platform]sst_drain_notify =_ "drain notify by driver\012"
sound/soc/intel/atom/sst-mfld-platform-compress.c:119 [snd_soc_sst_mfld_platform]sst_platform_compr_set_params =_ "compr_set_params: fill stream params ret_val = 0x%x\012"
sound/soc/intel/atom/sst-mfld-platform-compress.c:214 [snd_soc_sst_mfld_platform]sst_platform_compr_pointer =_ "calc bytes offset/copied bytes as %d\012"
sound/soc/intel/atom/sst-atom-controls.c:1358 [snd_soc_sst_mfld_platform]sst_map_modules_to_pipe =_ "widget type=%d name=%s\012"
sound/soc/intel/atom/sst-atom-controls.c:842 [snd_soc_sst_mfld_platform]sst_set_be_modules =_ "Enter: widget=%s\012"
sound/soc/intel/atom/sst-atom-controls.c:864 [snd_soc_sst_mfld_platform]sst_set_media_path =_ "task=%u, location=%#x\012"
sound/soc/intel/atom/sst-atom-controls.c:862 [snd_soc_sst_mfld_platform]sst_set_media_path =_ "widget=%s\012"
sound/soc/intel/atom/sst-atom-controls.c:307 [snd_soc_sst_mfld_platform]sst_find_and_send_pipe_algo =_ "Found algo control name=%s pipe=%s\012"
sound/soc/intel/atom/sst-atom-controls.c:301 [snd_soc_sst_mfld_platform]sst_find_and_send_pipe_algo =_ "Enter: widget=%s\012"
sound/soc/intel/atom/sst-atom-controls.c:899 [snd_soc_sst_mfld_platform]sst_set_media_loop =_ "Enter:widget=%s\012"
sound/soc/intel/atom/sst-atom-controls.c:574 [snd_soc_sst_mfld_platform]fill_swm_input =_ "input id: %#x, nb_inputs: %d\012"
sound/soc/intel/atom/sst-atom-controls.c:562 [snd_soc_sst_mfld_platform]fill_swm_input =_ "reg: %#x\012"
sound/soc/intel/atom/sst-atom-controls.c:634 [snd_soc_sst_mfld_platform]sst_swm_mixer_event =_ "val = %#x\012"
sound/soc/intel/atom/sst-atom-controls.c:623 [snd_soc_sst_mfld_platform]sst_swm_mixer_event =_ "widget = %s\012"
sound/soc/intel/atom/sst-atom-controls.c:489 [snd_soc_sst_mfld_platform]sst_gain_put =_ "%s: Ramp Delay%d\012"
sound/soc/intel/atom/sst-atom-controls.c:483 [snd_soc_sst_mfld_platform]sst_gain_put =_ "%s: Mute %d\012"
sound/soc/intel/atom/sst-atom-controls.c:478 [snd_soc_sst_mfld_platform]sst_gain_put =_ "%s: Volume %d, %d\012"
sound/soc/intel/atom/sst-atom-controls.c:353 [snd_soc_sst_mfld_platform]sst_algo_control_set =_ "control_name=%s\012"
sound/soc/intel/atom/sst-atom-controls.c:182 [snd_soc_sst_mfld_platform]sst_slot_get =_ "%s - %s map = %#x\012"
sound/soc/intel/atom/sst-atom-controls.c:256 [snd_soc_sst_mfld_platform]sst_slot_put =_ "%s %s map = %#x\012"
sound/soc/intel/atom/sst-atom-controls.c:405 [snd_soc_sst_mfld_platform]sst_send_gain_cmd =_ "Enter\012"
sound/soc/intel/atom/sst-atom-controls.c:599 [snd_soc_sst_mfld_platform]sst_set_pipe_gain =_ "control name=%s\012"
sound/soc/intel/atom/sst-atom-controls.c:1208 [snd_soc_sst_mfld_platform]sst_send_pipe_gains =_ "send gain for widget=%s\012"
sound/soc/intel/atom/sst-atom-controls.c:1197 [snd_soc_sst_mfld_platform]sst_send_pipe_gains =_ "Stream name=%s\012"
sound/soc/intel/atom/sst-atom-controls.c:1189 [snd_soc_sst_mfld_platform]sst_send_pipe_gains =_ "send gains for widget=%s\012"
sound/soc/intel/atom/sst-atom-controls.c:1178 [snd_soc_sst_mfld_platform]sst_send_pipe_gains =_ "Stream name=%s\012"
sound/soc/intel/atom/sst-atom-controls.c:1174 [snd_soc_sst_mfld_platform]sst_send_pipe_gains =_ "enter, dai-name=%s dir=%d\012"
sound/soc/intel/atom/sst-atom-controls.c:808 [snd_soc_sst_mfld_platform]send_ssp_cmd =_ "ssp_id: %u\012"
sound/soc/intel/atom/sst-atom-controls.c:51 [snd_soc_sst_mfld_platform]sst_fill_byte_control =_ "writing to lpe: "
sound/soc/intel/atom/sst-atom-controls.c:739 [snd_soc_sst_mfld_platform]sst_handle_vb_timer =_ "enable=%u, usage=%d\012"
sound/soc/intel/atom/sst/sst.c:406 [snd_intel_sst_core]intel_sst_runtime_suspend =_ "LPE is already in RESET state, No action\012"
sound/soc/intel/atom/sst/sst.c:310 [snd_intel_sst_core]sst_context_init =_ "Requesting FW %s now...\012"
sound/soc/intel/atom/sst/sst.c:296 [snd_intel_sst_core]sst_context_init =_ "Registered IRQ %#x\012"
sound/soc/intel/atom/sst/sst_ipc.c:231 [snd_intel_sst_core]process_fw_init =_ "*** FW Init msg came***\012"
sound/soc/intel/atom/sst/sst_ipc.c:268 [snd_intel_sst_core]process_fw_async_msg =_ "Period elapsed rcvd for pipe id 0x%x\012"
sound/soc/intel/atom/sst/sst_ipc.c:362 [snd_intel_sst_core]sst_process_reply_mrfld =_ "cmd_id %d\012"
sound/soc/intel/atom/sst/sst_ipc.c:328 [snd_intel_sst_core]sst_process_reply_mrfld =_ "IPC process message header %x payload %x\012"
sound/soc/intel/atom/sst/sst_ipc.c:171 [snd_intel_sst_core]sst_post_message_mrfld =_ "sst: size = 0x%x\012"
sound/soc/intel/atom/sst/sst_ipc.c:169 [snd_intel_sst_core]sst_post_message_mrfld =_ "sst: Post message: header = %x\012"
sound/soc/intel/atom/sst/sst_ipc.c:159 [snd_intel_sst_core]sst_post_message_mrfld =_ "Busy not free... post later\012"
sound/soc/intel/atom/sst/sst_ipc.c:153 [snd_intel_sst_core]sst_post_message_mrfld =_ "Empty msg queue... NO Action\012"
sound/soc/intel/atom/sst/sst_ipc.c:133 [snd_intel_sst_core]sst_post_message_mrfld =_ "Enter: sync: %d\012"
sound/soc/intel/atom/sst/sst_ipc.c:109 [snd_intel_sst_core]sst_free_block =_ "pvt_id freed --> %d\012"
sound/soc/intel/atom/sst/sst_ipc.c:105 [snd_intel_sst_core]sst_free_block =_ "Enter\012"
sound/soc/intel/atom/sst/sst_ipc.c:97 [snd_intel_sst_core]sst_wake_up_block =_ "Block not found or a response received for a short msg for ipc %d, drv_id %d\012"
sound/soc/intel/atom/sst/sst_ipc.c:84 [snd_intel_sst_core]sst_wake_up_block =_ "free up the block\012"
sound/soc/intel/atom/sst/sst_ipc.c:82 [snd_intel_sst_core]sst_wake_up_block =_ "Block ipc %d, drv_id %d\012"
sound/soc/intel/atom/sst/sst_ipc.c:77 [snd_intel_sst_core]sst_wake_up_block =_ "Enter\012"
sound/soc/intel/atom/sst/sst_ipc.c:42 [snd_intel_sst_core]sst_create_block =_ "Enter\012"
sound/soc/intel/atom/sst/sst_stream.c:433 [snd_intel_sst_core]sst_free_stream =_ "SST DBG:BADQRC for stream\012"
sound/soc/intel/atom/sst/sst_stream.c:429 [snd_intel_sst_core]sst_free_stream =_ "SST DBG:Stream freed\012"
sound/soc/intel/atom/sst/sst_stream.c:425 [snd_intel_sst_core]sst_free_stream =_ "sst: wait for free returned %d\012"
sound/soc/intel/atom/sst/sst_stream.c:399 [snd_intel_sst_core]sst_free_stream =_ "SST DBG:sst_free_stream for %d\012"
sound/soc/intel/atom/sst/sst_stream.c:362 [snd_intel_sst_core]sst_drain_stream =_ "SST DBG:sst_drain_stream for %d\012"
sound/soc/intel/atom/sst/sst_stream.c:344 [snd_intel_sst_core]sst_drop_stream =_ "BADQRC for stream, state %x\012"
sound/soc/intel/atom/sst/sst_stream.c:328 [snd_intel_sst_core]sst_drop_stream =_ "SST DBG:sst_drop_stream for %d\012"
sound/soc/intel/atom/sst/sst_stream.c:283 [snd_intel_sst_core]sst_resume_stream =_ "SST DBG:sst_resume_stream for %d\012"
sound/soc/intel/atom/sst/sst_stream.c:265 [snd_intel_sst_core]sst_pause_stream =_ "SST DBG:BADRQC for stream\012 "
sound/soc/intel/atom/sst/sst_stream.c:239 [snd_intel_sst_core]sst_pause_stream =_ "SST DBG:sst_pause_stream for %d\012"
sound/soc/intel/atom/sst/sst_stream.c:216 [snd_intel_sst_core]sst_send_byte_stream_mrfld =_ "read back %d bytes"
sound/soc/intel/atom/sst/sst_stream.c:197 [snd_intel_sst_core]sst_send_byte_stream_mrfld =_ "msg->mrfld_header.p.header_low_payload:%d"
sound/soc/intel/atom/sst/sst_stream.c:184 [snd_intel_sst_core]sst_send_byte_stream_mrfld =_ "length is %d\012"
sound/soc/intel/atom/sst/sst_stream.c:173 [snd_intel_sst_core]sst_send_byte_stream_mrfld =_ "type:%u ipc_msg:%u block:%u task_id:%u pipe: %#x length:%#x\012"
sound/soc/intel/atom/sst/sst_stream.c:149 [snd_intel_sst_core]sst_start_stream =_ "sst_start_stream for %d\012"
sound/soc/intel/atom/sst/sst_stream.c:101 [snd_intel_sst_core]sst_alloc_stream_mrfld =_ "assigned pipe id 0x%x to task %d\012"
sound/soc/intel/atom/sst/sst_stream.c:99 [snd_intel_sst_core]sst_alloc_stream_mrfld =_ "alloc tstamp location = 0x%x\012"
sound/soc/intel/atom/sst/sst_stream.c:47 [snd_intel_sst_core]sst_alloc_stream_mrfld =_ "Enter\012"
sound/soc/intel/atom/sst/sst_drv_interface.c:652 [snd_intel_sst_core]sst_stream_init =_ "pcm_substream %p, period_elapsed %p, sfreq %d, status %d\012"
sound/soc/intel/atom/sst/sst_drv_interface.c:643 [snd_intel_sst_core]sst_stream_init =_ "setting the period ptrs\012"
sound/soc/intel/atom/sst/sst_drv_interface.c:538 [snd_intel_sst_core]sst_calc_tstamp =_ "buffer ptr %llu pcm_delay rep: %llu\012"
sound/soc/intel/atom/sst/sst_drv_interface.c:532 [snd_intel_sst_core]sst_calc_tstamp =_ "pcm delay %zu in bytes\012"
sound/soc/intel/atom/sst/sst_drv_interface.c:520 [snd_intel_sst_core]sst_calc_tstamp =_ "mrfld hardware_counter %llu in bytes\012"
sound/soc/intel/atom/sst/sst_drv_interface.c:518 [snd_intel_sst_core]sst_calc_tstamp =_ "mrfld ring_buffer_counter %llu in bytes\012"
sound/soc/intel/atom/sst/sst_drv_interface.c:504 [snd_intel_sst_core]sst_close_pcm_stream =_ "Exit\012"
sound/soc/intel/atom/sst/sst_drv_interface.c:488 [snd_intel_sst_core]sst_close_pcm_stream =_ "stream in reset state...\012"
sound/soc/intel/atom/sst/sst_drv_interface.c:212 [snd_intel_sst_core]sst_cdev_open =_ "stream allocated in sst_cdev_open %d\012"
sound/soc/intel/atom/sst/sst_drv_interface.c:390 [snd_intel_sst_core]sst_cdev_tstamp =_ "rendered %d\012"
sound/soc/intel/atom/sst/sst_drv_interface.c:389 [snd_intel_sst_core]sst_cdev_tstamp =_ "Ptr Query on strid = %d  copied_total %d, decodec %d\012"
sound/soc/intel/atom/sst/sst_drv_interface.c:387 [snd_intel_sst_core]sst_cdev_tstamp =_ "PCM  = %u\012"
sound/soc/intel/atom/sst/sst_drv_interface.c:379 [snd_intel_sst_core]sst_cdev_tstamp =_ "rb_counter %llu in bytes\012"
sound/soc/intel/atom/sst/sst_drv_interface.c:283 [snd_intel_sst_core]sst_cdev_ack =_ "bytes sent to fw %llu inc by %ld\012"
sound/soc/intel/atom/sst/sst_drv_interface.c:274 [snd_intel_sst_core]sst_cdev_ack =_ "bytes copied %d inc by %ld\012"
sound/soc/intel/atom/sst/sst_drv_interface.c:254 [snd_intel_sst_core]sst_cdev_close =_ "End\012"
sound/soc/intel/atom/sst/sst_drv_interface.c:239 [snd_intel_sst_core]sst_cdev_close =_ "stream in reset state...\012"
sound/soc/intel/atom/sst/sst_drv_interface.c:305 [snd_intel_sst_core]sst_cdev_set_metadata =_ "pipe id = %d\012"
sound/soc/intel/atom/sst/sst_drv_interface.c:299 [snd_intel_sst_core]sst_cdev_set_metadata =_ "set metadata for stream %d\012"
sound/soc/intel/atom/sst/sst_drv_interface.c:167 [snd_intel_sst_core]sst_power_control =_ "Disable: pm usage count: %d\012"
sound/soc/intel/atom/sst/sst_drv_interface.c:153 [snd_intel_sst_core]sst_power_control =_ "Enable: pm usage count: %d\012"
sound/soc/intel/atom/sst/sst_drv_interface.c:460 [snd_intel_sst_core]sst_cdev_fragment_elapsed =_ "fragment elapsed from firmware for str_id %d\012"
sound/soc/intel/atom/sst/sst_drv_interface.c:72 [snd_intel_sst_core]sst_get_stream_allocated =_ "Stream allocated %d\012"
sound/soc/intel/atom/sst/sst_loader.c:456 [snd_intel_sst_core]sst_load_fw =_ "fw load successful!!!\012"
sound/soc/intel/atom/sst/sst_loader.c:412 [snd_intel_sst_core]sst_load_fw =_ "sst: FW not in memory retry to download\012"
sound/soc/intel/atom/sst/sst_loader.c:405 [snd_intel_sst_core]sst_load_fw =_ "sst_load_fw\012"
sound/soc/intel/atom/sst/sst_loader.c:393 [snd_intel_sst_core]sst_post_download_mrfld =_ "config written to DCCM\012"
sound/soc/intel/atom/sst/sst_loader.c:191 [snd_intel_sst_core]sst_parse_module_memcpy =_ "module entrypoint 0x%x\012"
sound/soc/intel/atom/sst/sst_loader.c:190 [snd_intel_sst_core]sst_parse_module_memcpy =_ "module sign %s size %x blocks %x type %x\012"
sound/soc/intel/atom/sst/sst_loader.c:128 [snd_intel_sst_core]sst_validate_fw_image =_ "header sign=%s size=%x modules=%x fmt=%x size=%zx\012"
sound/soc/intel/atom/sst/sst_loader.c:121 [snd_intel_sst_core]sst_validate_fw_image =_ "Enter\012"
sound/soc/intel/atom/sst/sst_loader.c:305 [snd_intel_sst_core]sst_cache_and_parse_fw =_ "phys: %lx"
sound/soc/intel/atom/sst/sst_loader.c:304 [snd_intel_sst_core]sst_cache_and_parse_fw =_ "copied fw to %p"
sound/soc/intel/atom/sst/sst_loader.c:340 [snd_intel_sst_core]sst_firmware_load_cb =_ "Request Fw completed\012"
sound/soc/intel/atom/sst/sst_loader.c:324 [snd_intel_sst_core]sst_firmware_load_cb =_ "Enter\012"
sound/soc/intel/atom/sst/sst_loader.c:111 [snd_intel_sst_core]sst_start_mrfld =_ "sst: Starting the DSP_merrifield:%llx\012"
sound/soc/intel/atom/sst/sst_loader.c:103 [snd_intel_sst_core]sst_start_mrfld =_ "value:0x%llx\012"
sound/soc/intel/atom/sst/sst_loader.c:97 [snd_intel_sst_core]sst_start_mrfld =_ "value:0x%llx\012"
sound/soc/intel/atom/sst/sst_loader.c:95 [snd_intel_sst_core]sst_start_mrfld =_ "sst: Starting the DSP in mrfld LALALALA\012"
sound/soc/intel/atom/sst/sst_loader.c:82 [snd_intel_sst_core]intel_sst_reset_dsp_mrfld =_ "value:0x%llx\012"
sound/soc/intel/atom/sst/sst_loader.c:76 [snd_intel_sst_core]intel_sst_reset_dsp_mrfld =_ "value:0x%llx\012"
sound/soc/intel/atom/sst/sst_loader.c:70 [snd_intel_sst_core]intel_sst_reset_dsp_mrfld =_ "value:0x%llx\012"
sound/soc/intel/atom/sst/sst_loader.c:67 [snd_intel_sst_core]intel_sst_reset_dsp_mrfld =_ "sst: Resetting the DSP in mrfld\012"
sound/soc/intel/atom/sst/sst_pvt.c:403 [snd_intel_sst_core]get_stream_id_mrfld =_ "no such pipe_id(%u)"
sound/soc/intel/atom/sst/sst_pvt.c:353 [snd_intel_sst_core]sst_assign_pvt_id =_ "pvt_id assigned --> %d\012"
sound/soc/intel/atom/sst/sst_pvt.c:265 [snd_intel_sst_core]sst_prepare_and_post_msg =_ "msg->mrfld_header.p.header_low_payload:%d"
sound/soc/intel/atom/sst/sst_pvt.c:263 [snd_intel_sst_core]sst_prepare_and_post_msg =_ "response rqd: %x"
sound/soc/intel/atom/sst/sst_pvt.c:261 [snd_intel_sst_core]sst_prepare_and_post_msg =_ "header:%x\012"
sound/soc/intel/atom/sst/sst_pvt.c:255 [snd_intel_sst_core]sst_prepare_and_post_msg =_ "pvt_id = %d, pipe id = %d, task = %d ipc_msg: %d\012"
sound/soc/intel/atom/sst/sst_pvt.c:142 [snd_intel_sst_core]sst_wait_timeout =_ "message ret: %d\012"
sound/soc/intel/atom/sst/sst_pvt.c:140 [snd_intel_sst_core]sst_wait_timeout =_ "Event wake %x\012"
sound/soc/intel/atom/sst/sst_pvt.c:134 [snd_intel_sst_core]sst_wait_timeout =_ "waiting for condition %x ipc %d drv_id %d\012"
sound/soc/intel/atom/sst/sst_pvt.c:103 [snd_intel_sst_core]sst_wait_interruptible =_ "event up\012"
sound/soc/intel/atom/sst/sst_acpi.c:277 [snd_intel_sst_acpi]sst_acpi_probe =_ "ACPI device id: %x\012"
sound/soc/intel/atom/sst/sst_acpi.c:262 [snd_intel_sst_acpi]sst_acpi_probe =_ "for %s"

--------------000009050904040101040108
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--------------000009050904040101040108--
