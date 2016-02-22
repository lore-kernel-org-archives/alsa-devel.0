From: Martin Kepplinger <martink@posteo.de>
Subject: Re: [BUG] [REGRESSION] [BISECTED] -rc1 breaks audio over HDMI for
 i915
Date: Mon, 22 Feb 2016 11:24:05 +0100
Message-ID: <56CAE1C5.4070107@posteo.de>
References: <56B98888.5000702@posteo.de> <s5h4mdixg4n.wl-tiwai@suse.de>
 <56BB7187.1020108@posteo.de> <s5hegcjipk4.wl-tiwai@suse.de>
 <56BDD990.1070900@posteo.de> <s5hegcif37m.wl-tiwai@suse.de>
 <56BE0044.9080500@posteo.de> <s5h37sxgazv.wl-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: multipart/mixed;
 boundary="------------090104010606010606050305"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <s5h37sxgazv.wl-tiwai@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
To: Takashi Iwai <tiwai@suse.de>
Cc: david.henningsson@canonical.com, han.lu@intel.com, libin.yang@intel.com, treding@nvidia.com, perex@perex.cz, alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

This is a multi-part message in MIME format.
--------------090104010606010606050305
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit

Am 2016-02-12 um 17:16 schrieb Takashi Iwai:
> On Fri, 12 Feb 2016 16:54:44 +0100,
> Martin Kepplinger wrote:
>>
>> Am 2016-02-12 um 14:49 schrieb Takashi Iwai:
>>> On Fri, 12 Feb 2016 14:09:36 +0100,
>>> Martin Kepplinger wrote:
>>>>
>>>> Am 2016-02-11 um 10:06 schrieb Takashi Iwai:
>>>>> On Wed, 10 Feb 2016 18:21:11 +0100,
>>>>> Martin Kepplinger wrote:
>>>>>>
>>>>>> Am 2016-02-09 um 12:44 schrieb Takashi Iwai:
>>>>>>> On Tue, 09 Feb 2016 07:34:48 +0100,
>>>>>>> Martin Kepplinger wrote:
>>>>>>>>
>>>>>>>> The following change:
>>>>>>>>
>>>>>>>> 788d441 ALSA: hda - Use component ops for i915 HDMI/DP audio jack handling
>>>>>>>>
>>>>>>>> breaks audio over HDMI on my snd_hda_intel laptop. It is the first bad
>>>>>>>> commit.
>>>>>>>>
>>>>>>>> This was merged for -rc1 and isn't fixed until now, so I got nervous.
>>>>>>>> There are
>>>>>>>> no errors in the log that stand out. I'm no sound or alsa developer, and
>>>>>>>> just reverting it isn't easy since there is stuff depending on this.
>>>>>>>>
>>>>>>>> I'm happy to test possible fixes and hope v4.5 not to ship with such a big
>>>>>>>> regression ;)
>>>>>>>
>>>>>>> Could you give a bit more detail about your hardware?  At best, give
>>>>>>> alsa-info.sh output (run with --no-upload option).  Also, give the
>>>>>>> output of dmesg, too.
>>>>>>>
>>>>>>> In addition, what shows /proc/asound/card*/eld#*.* files?  Does any of
>>>>>>> it show the proper connection state and ELD?
>>>>>>
>>>>>> alsa-info and dmesg are appended, and
>>>>>>
>>>>>> root@laptop:/home/martin/dev# cat /proc/asound/card*/eld#*
>>>>>> monitor_present		0
>>>>>> eld_valid		0
>>>>>
>>>>> OK, then could you put some debug print in intel_pin_eld_notify() in
>>>>> sound/pci/hda/patch_hdmi.c?  This is the callback to be called by i915
>>>>> driver at enabling / disabling HDMI/DP audio.
>>>>
>>>> intel_pin_eld_notify() is called during HDMI plugin with
>>>>
>>>> audio_ptr: ffff880242ea8800, port 1
>>>>
>>>> and doesn't return early.
>>>
>>> OK, so it was processed but the ELD wasn't updated by some reason.
>>>
>>>>> (Also, to be sure, check whether snd_hdac_i915_register_notifier() in
>>>>>  sound/hda/hda_i915.c is called, too.)
>>>>
>>>> snd_hdac_i915_register_notifier() is called during boot.
>>>>
>>>>>
>>>>> If intel_pin_eld_notify() is registered but never called, it implies
>>>>> something wrong in i915 driver side.  If it gets called, we need to
>>>>> track down: what port value was passed there, and how
>>>>> hdmi_present_sense() and sync_eld_via_acomp() behave there.
>>>>
>>>> I'll try to look at said path, if you have no other idea in the meantime.
>>>
>>> Put some debug prints in sync_eld_via_acomp(), e.g. check whether
>>> snd_hdac_acomp_get_eld() returns an error or snd_hdmi_parse_eld()
>>> returns an error.  If you got an error, track down more deeply.
>>>
>>> For example, the former function is defined in sound/hda/hdac_i915.c,
>>> and it calls the function i915_audio_component_get_eld() in
>>> drivers/gpu/drm/i915/intel_audio.c.  You can follow what returns an
>>> error.
>>>
>>> Similarly, the latter function is defined in sound/pci/hda/hda_eld.c.
>>> Usually you see a kernel message for parse errors, so I guess this
>>> isn't the case, though.
>>>
>>
>> no error in either of the functions. size is always 0, after boot and
>> after HDMI plugin. is that normal?
> 
> No, it means that no connection is reported back.  Check the call of
> i915_audio_component_get_eld() as mentioned in the above.
> Does it return 0?  Also I suppose monitor_present is set to false?
> If so, it implies that intel_audio_codec_enable() isn't called.
> 
> When the above is true, boot with drm.debug=0x0e, and give the kernel
> messages.
> 

The above is true and -rc5 didn't fix the problem. I append "dmesg|grep
drm" with drm.debug=0x0e. HDMI is plugged in at about 90 seconds in.

                        martin



--------------090104010606010606050305
Content-Type: text/plain; charset=UTF-8;
 name="boot_without_hdmi_plugin_at_90.txt"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename="boot_without_hdmi_plugin_at_90.txt"

[    2.385845] [drm:intel_opregion_setup] graphic opregion physical addr: 0xa6fb2018
[    2.385860] [drm:intel_opregion_setup] Public ACPI methods supported
[    2.385862] [drm:intel_opregion_setup] SWSCI supported
[    2.392036] [drm:swsci_setup] SWSCI GBDA callbacks 00000cf3, SBCB callbacks 00000241
[    2.392041] [drm:intel_opregion_setup] ASLE supported
[    2.392051] [drm:intel_opregion_setup] ASLE extension supported
[    2.392058] [drm:intel_opregion_setup] Found valid VBT in ACPI OpRegion (Mailbox #4)
[    2.392341] [drm:intel_device_info_runtime_init] slice total: 0
[    2.392345] [drm:intel_device_info_runtime_init] subslice total: 0
[    2.392348] [drm:intel_device_info_runtime_init] subslice per slice: 0
[    2.392351] [drm:intel_device_info_runtime_init] EU total: 0
[    2.392355] [drm:intel_device_info_runtime_init] EU per subslice: 0
[    2.392358] [drm:intel_device_info_runtime_init] has slice power gating: n
[    2.392361] [drm:intel_device_info_runtime_init] has subslice power gating: n
[    2.392364] [drm:intel_device_info_runtime_init] has EU power gating: n
[    2.392368] [drm] Supports vblank timestamp caching Rev 2 (21.10.2013).
[    2.392380] [drm] Driver supports precise vblank timestamp query.
[    2.392391] [drm:init_vbt_defaults] Set default to SSC at 120000 kHz
[    2.392395] [drm:intel_bios_init] VBT signature "$VBT SNB/IVB-MOBILE ", BDB version 165
[    2.392400] [drm:parse_general_features] BDB_GENERAL_FEATURES int_tv_support 0 int_crt_support 1 lvds_use_ssc 1 lvds_ssc_freq 120000 display_clock_mode 0 fdi_rx_polarity_inverted 0
[    2.392403] [drm:parse_general_definitions] crt_ddc_bus_pin: 2
[    2.392408] [drm:parse_lfp_panel_data] DRRS supported mode is static
[    2.392413] [drm:parse_lfp_panel_data] Found panel mode in BIOS VBT tables:
[    2.392419] [drm:drm_mode_debug_printmodeline] Modeline 0:"1366x768" 0 71000 1366 1407 1434 1500 768 771 775 788 0x8 0xa
[    2.392423] [drm:parse_lfp_panel_data] VBT initial LVDS value 300300
[    2.392427] [drm:parse_lfp_backlight] VBT backlight PWM modulation frequency 1000 Hz, active high, min brightness 0, level 255
[    2.392432] [drm:parse_sdvo_panel_data] Found SDVO panel mode in BIOS VBT tables:
[    2.392438] [drm:drm_mode_debug_printmodeline] Modeline 0:"1600x1200" 0 162000 1600 1664 1856 2160 1200 1201 1204 1250 0x8 0xa
[    2.392441] [drm:parse_sdvo_device_mapping] No SDVO device info is found in VBT
[    2.392446] [drm:parse_driver_features] DRRS State Enabled:1
[    2.392464] [drm:intel_dsm_pci_probe] no _DSM method for intel device
[    2.392477] [drm:i915_gem_init_stolen] Memory reserved for graphics device: 131072K, usable: 131072K
[    2.392482] [drm:intel_power_well_enable] enabling always-on
[    2.392961] [drm:intel_print_wm_latency] Primary WM0 latency 7 (0.7 usec)
[    2.392966] [drm:intel_print_wm_latency] Primary WM1 latency 3 (1.5 usec)
[    2.392970] [drm:intel_print_wm_latency] Primary WM2 latency 4 (2.0 usec)
[    2.392974] [drm:intel_print_wm_latency] Primary WM3 latency 22 (11.0 usec)
[    2.392978] [drm:intel_print_wm_latency] Sprite WM0 latency 7 (0.7 usec)
[    2.392981] [drm:intel_print_wm_latency] Sprite WM1 latency 3 (1.5 usec)
[    2.392985] [drm:intel_print_wm_latency] Sprite WM2 latency 4 (2.0 usec)
[    2.392990] [drm:intel_print_wm_latency] Sprite WM3 latency 22 (11.0 usec)
[    2.392993] [drm:intel_print_wm_latency] Cursor WM0 latency 7 (0.7 usec)
[    2.392998] [drm:intel_print_wm_latency] Cursor WM1 latency 3 (1.5 usec)
[    2.393002] [drm:intel_print_wm_latency] Cursor WM2 latency 4 (2.0 usec)
[    2.393006] [drm:intel_print_wm_latency] Cursor WM3 latency 22 (11.0 usec)
[    2.393010] [drm:snb_wm_latency_quirk] WM latency values increased to avoid potential underruns
[    2.393014] [drm:intel_print_wm_latency] Primary WM0 latency 12 (1.2 usec)
[    2.393018] [drm:intel_print_wm_latency] Primary WM1 latency 3 (1.5 usec)
[    2.393021] [drm:intel_print_wm_latency] Primary WM2 latency 4 (2.0 usec)
[    2.393025] [drm:intel_print_wm_latency] Primary WM3 latency 22 (11.0 usec)
[    2.393029] [drm:intel_print_wm_latency] Sprite WM0 latency 12 (1.2 usec)
[    2.393032] [drm:intel_print_wm_latency] Sprite WM1 latency 3 (1.5 usec)
[    2.393036] [drm:intel_print_wm_latency] Sprite WM2 latency 4 (2.0 usec)
[    2.393040] [drm:intel_print_wm_latency] Sprite WM3 latency 22 (11.0 usec)
[    2.393046] [drm:intel_print_wm_latency] Cursor WM0 latency 12 (1.2 usec)
[    2.393049] [drm:intel_print_wm_latency] Cursor WM1 latency 3 (1.5 usec)
[    2.393055] [drm:intel_print_wm_latency] Cursor WM2 latency 4 (2.0 usec)
[    2.393059] [drm:intel_print_wm_latency] Cursor WM3 latency 22 (11.0 usec)
[    2.393064] [drm:intel_modeset_init] 2 display pipes available.
[    2.393097] [drm:intel_update_cdclk] Current CD clock rate: 400000 kHz
[    2.393101] [drm:intel_update_max_cdclk] Max CD clock rate: 400000 kHz
[    2.393103] [drm:intel_update_max_cdclk] Max dotclock rate: 360000 kHz
[    2.408452] [drm:intel_lvds_init] using preferred mode from EDID: 
[    2.408461] [drm:drm_mode_debug_printmodeline] Modeline 30:"1366x768" 60 71000 1366 1407 1434 1500 768 771 775 788 0x48 0xa
[    2.408471] [drm:intel_lvds_init] detected single-link lvds configuration
[    2.408598] [drm:intel_panel_setup_backlight] Connector LVDS-1 backlight initialized, enabled, brightness 976/976
[    2.408751] [drm:intel_crt_reset] crt adpa set to 0xf40000
[    2.408762] [drm:intel_gmbus_force_bit] enabling bit-banging on i915 gmbus dpb. force bit now 1
[    2.409236] [drm:intel_sdvo_read_byte] i2c transfer returned -6
[    2.409239] [drm:intel_sdvo_init] No SDVO device found on SDVOB
[    2.409285] [drm:intel_gmbus_force_bit] disabling bit-banging on i915 gmbus dpb. force bit now 0
[    2.409938] [drm:intel_dp_init_connector] Adding DP connector on port B
[    2.410009] [drm:intel_dp_aux_init] registering DPDDC-B bus for card0-DP-1
[    2.410064] [drm:ironlake_init_pch_refclk] has_panel 1 has_lvds 1 has_ck505 0
[    2.410068] [drm:ironlake_init_pch_refclk] Using SSC on panel
[    2.410489] [drm:intel_modeset_readout_hw_state] [CRTC:21] hw state readout: enabled
[    2.410492] [drm:intel_modeset_readout_hw_state] [CRTC:25] hw state readout: disabled
[    2.410498] [drm:intel_modeset_readout_hw_state] PCH DPLL A hw state readout: crtc_mask 0x00000001, on 1
[    2.410505] [drm:intel_modeset_readout_hw_state] PCH DPLL B hw state readout: crtc_mask 0x00000000, on 0
[    2.410513] [drm:intel_modeset_readout_hw_state] [ENCODER:28:LVDS-28] hw state readout: enabled, pipe A
[    2.410518] [drm:intel_modeset_readout_hw_state] [ENCODER:34:DAC-34] hw state readout: disabled, pipe A
[    2.410523] [drm:intel_modeset_readout_hw_state] [ENCODER:35:TMDS-35] hw state readout: disabled, pipe A
[    2.410526] [drm:intel_modeset_readout_hw_state] [ENCODER:40:TMDS-40] hw state readout: disabled, pipe A
[    2.410531] [drm:intel_modeset_readout_hw_state] [CONNECTOR:27:LVDS-1] hw state readout: enabled
[    2.410535] [drm:intel_modeset_readout_hw_state] [CONNECTOR:33:VGA-1] hw state readout: disabled
[    2.410539] [drm:intel_modeset_readout_hw_state] [CONNECTOR:36:HDMI-A-1] hw state readout: disabled
[    2.410542] [drm:intel_modeset_readout_hw_state] [CONNECTOR:41:DP-1] hw state readout: disabled
[    2.410559] [drm:intel_dump_pipe_config] [CRTC:21][setup_hw_state] config ffff8802454fb400 for pipe A
[    2.410561] [drm:intel_dump_pipe_config] cpu_transcoder: A
[    2.410563] [drm:intel_dump_pipe_config] pipe bpp: 18, dithering: 0
[    2.410566] [drm:intel_dump_pipe_config] fdi/pch: 1, lanes: 1, gmch_m: 4963259, gmch_n: 8388608, link_m: 137868, link_n: 524288, tu: 64
[    2.410569] [drm:intel_dump_pipe_config] dp: 0, lanes: 0, gmch_m: 0, gmch_n: 0, link_m: 0, link_n: 0, tu: 0
[    2.410571] [drm:intel_dump_pipe_config] dp: 0, lanes: 0, gmch_m2: 0, gmch_n2: 0, link_m2: 0, link_n2: 0, tu2: 0
[    2.410574] [drm:intel_dump_pipe_config] audio: 0, infoframes: 0
[    2.410575] [drm:intel_dump_pipe_config] requested mode:
[    2.410579] [drm:drm_mode_debug_printmodeline] Modeline 0:"1366x768" 60 70714 1366 1407 1434 1500 768 771 775 788 0x40 0xa
[    2.410581] [drm:intel_dump_pipe_config] adjusted mode:
[    2.410584] [drm:drm_mode_debug_printmodeline] Modeline 0:"1366x768" 60 70714 1366 1407 1434 1500 768 771 775 788 0x40 0xa
[    2.410588] [drm:intel_dump_crtc_timings] crtc timings: 70714 1366 1407 1434 1500 768 771 775 788, type: 0x40 flags: 0xa
[    2.410590] [drm:intel_dump_pipe_config] port clock: 70714
[    2.410592] [drm:intel_dump_pipe_config] pipe src size: 720x400
[    2.410594] [drm:intel_dump_pipe_config] num_scalers: 0, scaler_users: 0x0, scaler_id: 0
[    2.410596] [drm:intel_dump_pipe_config] gmch pfit: control: 0x00000000, ratios: 0x00000000, lvds border: 0x00000000
[    2.410599] [drm:intel_dump_pipe_config] pch pfit: pos: 0x00000000, size: 0x05560300, enabled
[    2.410600] [drm:intel_dump_pipe_config] ips: 0
[    2.410602] [drm:intel_dump_pipe_config] double wide: 0
[    2.410605] [drm:intel_dump_pipe_config] dpll_hw_state: dpll: 0x88046004, dpll_md: 0x0, fp0: 0x21007, fp1: 0x30d07
[    2.410606] [drm:intel_dump_pipe_config] planes on this crtc
[    2.410609] [drm:intel_dump_pipe_config] STANDARD PLANE:18 plane: 0.0 idx: 0 disabled, scaler_id = 0
[    2.410612] [drm:intel_dump_pipe_config] CURSOR PLANE:20 plane: 0.1 idx: 1 disabled, scaler_id = 0
[    2.410614] [drm:intel_dump_pipe_config] STANDARD PLANE:22 plane: 0.1 idx: 2 disabled, scaler_id = 0
[    2.410618] [drm:intel_dump_pipe_config] [CRTC:25][setup_hw_state] config ffff8802454e1400 for pipe B
[    2.410620] [drm:intel_dump_pipe_config] cpu_transcoder: B
[    2.410622] [drm:intel_dump_pipe_config] pipe bpp: 0, dithering: 0
[    2.410624] [drm:intel_dump_pipe_config] fdi/pch: 0, lanes: 0, gmch_m: 0, gmch_n: 0, link_m: 0, link_n: 0, tu: 0
[    2.410627] [drm:intel_dump_pipe_config] dp: 0, lanes: 0, gmch_m: 0, gmch_n: 0, link_m: 0, link_n: 0, tu: 0
[    2.410630] [drm:intel_dump_pipe_config] dp: 0, lanes: 0, gmch_m2: 0, gmch_n2: 0, link_m2: 0, link_n2: 0, tu2: 0
[    2.410633] [drm:intel_dump_pipe_config] audio: 0, infoframes: 0
[    2.410635] [drm:intel_dump_pipe_config] requested mode:
[    2.410640] [drm:drm_mode_debug_printmodeline] Modeline 0:"" 0 0 0 0 0 0 0 0 0 0 0x0 0x0
[    2.410643] [drm:intel_dump_pipe_config] adjusted mode:
[    2.410647] [drm:drm_mode_debug_printmodeline] Modeline 0:"" 0 0 0 0 0 0 0 0 0 0 0x0 0x0
[    2.410651] [drm:intel_dump_crtc_timings] crtc timings: 0 0 0 0 0 0 0 0 0, type: 0x0 flags: 0x0
[    2.410654] [drm:intel_dump_pipe_config] port clock: 0
[    2.410657] [drm:intel_dump_pipe_config] pipe src size: 0x0
[    2.410660] [drm:intel_dump_pipe_config] num_scalers: 0, scaler_users: 0x0, scaler_id: 0
[    2.410664] [drm:intel_dump_pipe_config] gmch pfit: control: 0x00000000, ratios: 0x00000000, lvds border: 0x00000000
[    2.410667] [drm:intel_dump_pipe_config] pch pfit: pos: 0x00000000, size: 0x00000000, disabled
[    2.410670] [drm:intel_dump_pipe_config] ips: 0
[    2.410672] [drm:intel_dump_pipe_config] double wide: 0
[    2.410676] [drm:intel_dump_pipe_config] dpll_hw_state: dpll: 0x0, dpll_md: 0x0, fp0: 0x0, fp1: 0x0
[    2.410678] [drm:intel_dump_pipe_config] planes on this crtc
[    2.410683] [drm:intel_dump_pipe_config] STANDARD PLANE:23 plane: 1.0 idx: 3 disabled, scaler_id = 0
[    2.410687] [drm:intel_dump_pipe_config] CURSOR PLANE:24 plane: 1.2 idx: 4 disabled, scaler_id = 0
[    2.410692] [drm:intel_dump_pipe_config] STANDARD PLANE:26 plane: 1.1 idx: 5 disabled, scaler_id = 0
[    2.411039] [drm:i915_gem_setup_global_gtt] clearing unused GTT space: [0, 7ffff000]
[    2.414219] [drm:gen6_ppgtt_init] Allocated pde space (2M) at GTT entry: 7fdf0
[    2.416392] [drm:i915_gem_context_init] HW context support initialized
[    2.416412] [drm:init_status_page] render ring hws offset: 0x7fff2000
[    2.416500] [drm:intel_init_pipe_control] render ring pipe control offset: 0x00020000
[    2.416515] [drm:init_status_page] bsd ring hws offset: 0x00021000
[    2.416604] [drm:init_status_page] blitter ring hws offset: 0x00042000
[    2.418803] [drm:intel_update_cdclk] Current CD clock rate: 400000 kHz
[    2.418826] [drm:gen6_check_mch_setup] Wrong MCH_SSKPD value: 0x16040307 This can cause underruns.
[    2.419172] [drm:intel_backlight_device_register] Connector LVDS-1 backlight sysfs interface registered
[    2.419179] [drm:intel_fbdev_init_bios] pipe A not active or no fb, skipping
[    2.419182] [drm:intel_fbdev_init_bios] pipe B not active or no fb, skipping
[    2.419185] [drm:intel_fbdev_init_bios] no active fbs found, not using BIOS config
[    2.419212] [drm:drm_helper_probe_single_connector_modes] [CONNECTOR:27:LVDS-1]
[    2.419218] [drm:intel_lvds_detect] [CONNECTOR:27:LVDS-1]
[    2.419224] [drm:drm_helper_probe_single_connector_modes] [CONNECTOR:27:LVDS-1] status updated from unknown to connected
[    2.419248] [drm:drm_helper_probe_single_connector_modes] [CONNECTOR:27:LVDS-1] probed modes :
[    2.419256] [drm:drm_mode_debug_printmodeline] Modeline 30:"1366x768" 60 71000 1366 1407 1434 1500 768 771 775 788 0x48 0xa
[    2.419260] [drm:drm_helper_probe_single_connector_modes] [CONNECTOR:33:VGA-1]
[    2.419264] [drm:intel_crt_detect] [CONNECTOR:33:VGA-1] force=1
[    2.419271] [drm:intel_ironlake_crt_detect_hotplug] trigger hotplug detect cycle: adpa=0xf40000
[    2.420136] [drm:intel_didl_outputs] 8 outputs detected
[    2.428736] [drm:intel_ironlake_crt_detect_hotplug] ironlake hotplug adpa=0xf40000, result 0
[    2.428741] [drm:intel_crt_detect] CRT not detected via hotplug
[    2.428915] [drm:do_gmbus_xfer] GMBUS [i915 gmbus vga] NAK for addr: 0050 w(1)
[    2.428919] [drm:do_gmbus_xfer] GMBUS [i915 gmbus vga] NAK on first message, retry
[    2.429088] [drm:do_gmbus_xfer] GMBUS [i915 gmbus vga] NAK for addr: 0050 w(1)
[    2.429093] [drm:drm_do_probe_ddc_edid] drm: skipping non-existent adapter i915 gmbus vga
[    2.429097] [drm:intel_crt_get_edid] CRT GMBUS EDID read failed, retry using GPIO bit-banging
[    2.429101] [drm:intel_gmbus_force_bit] enabling bit-banging on i915 gmbus vga. force bit now 1
[    2.429479] [drm:drm_do_probe_ddc_edid] drm: skipping non-existent adapter i915 gmbus vga
[    2.429482] [drm:intel_gmbus_force_bit] disabling bit-banging on i915 gmbus vga. force bit now 0
[    2.429484] [drm:intel_crt_detect_ddc] CRT not detected via DDC:0x50 [no valid EDID found]
[    2.429488] [drm:drm_helper_probe_single_connector_modes] [CONNECTOR:33:VGA-1] status updated from unknown to disconnected
[    2.429494] [drm:drm_helper_probe_single_connector_modes] [CONNECTOR:33:VGA-1] disconnected
[    2.429498] [drm:drm_helper_probe_single_connector_modes] [CONNECTOR:36:HDMI-A-1]
[    2.429500] [drm:intel_hdmi_detect] [CONNECTOR:36:HDMI-A-1]
[    2.556769] [drm:intel_hdmi_detect] Live status not up!
[    2.556782] [drm:drm_helper_probe_single_connector_modes] [CONNECTOR:36:HDMI-A-1] status updated from unknown to disconnected
[    2.556786] [drm:drm_helper_probe_single_connector_modes] [CONNECTOR:36:HDMI-A-1] disconnected
[    2.556791] [drm:drm_helper_probe_single_connector_modes] [CONNECTOR:41:DP-1]
[    2.556793] [drm:intel_dp_detect] [CONNECTOR:41:DP-1]
[    2.556798] [drm:drm_helper_probe_single_connector_modes] [CONNECTOR:41:DP-1] status updated from unknown to disconnected
[    2.556801] [drm:drm_helper_probe_single_connector_modes] [CONNECTOR:41:DP-1] disconnected
[    2.556806] [drm:drm_setup_crtcs] 
[    2.556810] [drm:drm_enable_connectors] connector 27 enabled? yes
[    2.556812] [drm:drm_enable_connectors] connector 33 enabled? no
[    2.556814] [drm:drm_enable_connectors] connector 36 enabled? no
[    2.556817] [drm:drm_enable_connectors] connector 41 enabled? no
[    2.556823] [drm:intel_fb_initial_config] looking for cmdline mode on connector LVDS-1
[    2.556828] [drm:intel_fb_initial_config] looking for preferred mode on connector LVDS-1 0
[    2.556833] [drm:intel_fb_initial_config] connector LVDS-1 on pipe A [CRTC:21]: 1366x768
[    2.556837] [drm:intel_fb_initial_config] connector VGA-1 not enabled, skipping
[    2.556940] [drm] Initialized i915 1.6.0 20151218 for 0000:00:02.0 on minor 0
[    2.556963] [drm:intel_fb_initial_config] connector HDMI-A-1 not enabled, skipping
[    2.556967] [drm:intel_fb_initial_config] connector DP-1 not enabled, skipping
[    2.556973] [drm:drm_setup_crtcs] desired mode 1366x768 set on crtc 21 (0,0)
[    2.556981] [drm:intelfb_create] no BIOS fb, allocating a new one
[    2.556988] [drm:i915_gem_object_create_stolen] creating stolen object: size=408000
[    2.557006] [drm:i915_pages_create_for_stolen] offset=0x0, size=4227072
[    2.557870] [drm:intelfb_create] allocated 1366x768 fb: 0x00064000, bo ffff8800a1f36dc0
[    2.557992] fbcon: inteldrmfb (fb0) is primary device
[    2.558111] [drm:connected_sink_compute_bpp] [CONNECTOR:27:LVDS-1] checking for sink bpp constrains
[    2.558112] [drm:connected_sink_compute_bpp] clamping display bpp (was 36) to default limit of 24
[    2.558114] [drm:intel_lvds_compute_config] forcing display bpp (was 24) to LVDS (18)
[    2.558117] [drm:ironlake_check_fdi_lanes] checking fdi config on pipe A, lanes 1
[    2.558119] [drm:intel_modeset_pipe_config] hw max bpp: 36, pipe bpp: 18, dithering: 1
[    2.558122] [drm:intel_dump_pipe_config] [CRTC:21][modeset] config ffff880242f5e400 for pipe A
[    2.558123] [drm:intel_dump_pipe_config] cpu_transcoder: A
[    2.558124] [drm:intel_dump_pipe_config] pipe bpp: 18, dithering: 1
[    2.558126] [drm:intel_dump_pipe_config] fdi/pch: 1, lanes: 1, gmch_m: 2481629, gmch_n: 4194304, link_m: 137868, link_n: 524288, tu: 64
[    2.558127] [drm:intel_dump_pipe_config] dp: 0, lanes: 0, gmch_m: 0, gmch_n: 0, link_m: 0, link_n: 0, tu: 0
[    2.558129] [drm:intel_dump_pipe_config] dp: 0, lanes: 0, gmch_m2: 0, gmch_n2: 0, link_m2: 0, link_n2: 0, tu2: 0
[    2.558130] [drm:intel_dump_pipe_config] audio: 0, infoframes: 0
[    2.558131] [drm:intel_dump_pipe_config] requested mode:
[    2.558134] [drm:drm_mode_debug_printmodeline] Modeline 0:"1366x768" 60 71000 1366 1407 1434 1500 768 771 775 788 0x48 0xa
[    2.558135] [drm:intel_dump_pipe_config] adjusted mode:
[    2.558138] [drm:drm_mode_debug_printmodeline] Modeline 0:"1366x768" 60 71000 1366 1407 1434 1500 768 771 775 788 0x48 0xa
[    2.558140] [drm:intel_dump_crtc_timings] crtc timings: 71000 1366 1407 1434 1500 768 771 775 788, type: 0x48 flags: 0xa
[    2.558141] [drm:intel_dump_pipe_config] port clock: 71000
[    2.558142] [drm:intel_dump_pipe_config] pipe src size: 1366x768
[    2.558143] [drm:intel_dump_pipe_config] num_scalers: 0, scaler_users: 0x0, scaler_id: 0
[    2.558145] [drm:intel_dump_pipe_config] gmch pfit: control: 0x00000000, ratios: 0x00000000, lvds border: 0x00000000
[    2.558146] [drm:intel_dump_pipe_config] pch pfit: pos: 0x00000000, size: 0x00000000, disabled
[    2.558147] [drm:intel_dump_pipe_config] ips: 0
[    2.558148] [drm:intel_dump_pipe_config] double wide: 0
[    2.558150] [drm:intel_dump_pipe_config] dpll_hw_state: dpll: 0x88046004, dpll_md: 0x0, fp0: 0x21007, fp1: 0x30d07
[    2.558150] [drm:intel_dump_pipe_config] planes on this crtc
[    2.558152] [drm:intel_dump_pipe_config] STANDARD PLANE:18 plane: 0.0 idx: 0 disabled, scaler_id = 0
[    2.558154] [drm:intel_dump_pipe_config] CURSOR PLANE:20 plane: 0.1 idx: 1 disabled, scaler_id = 0
[    2.558155] [drm:intel_dump_pipe_config] STANDARD PLANE:22 plane: 0.1 idx: 2 disabled, scaler_id = 0
[    2.558162] [drm:ironlake_get_refclk] using SSC reference clock of 120000 kHz
[    2.558194] [drm:intel_get_shared_dpll] CRTC:21 allocated PCH DPLL A
[    2.558195] [drm:intel_get_shared_dpll] using PCH DPLL A for pipe A
[    2.558213] [drm:intel_panel_actually_set_backlight] set backlight PWM = 0
[    2.558223] [drm:intel_disable_pipe] disabling pipe A
[    2.835018] [drm:intel_disable_shared_dpll] disable PCH DPLL A (active 1, on? 1) for crtc 21
[    2.835023] [drm:intel_disable_shared_dpll] disabling PCH DPLL A
[    2.835239] [drm:intel_prepare_shared_dpll] setting up PCH DPLL A
[    2.835799] [drm:intel_enable_pipe] enabling pipe A
[    2.836606] [drm:gen6_fdi_link_train] FDI_RX_IIR 0x700
[    2.836607] [drm:gen6_fdi_link_train] FDI train 1 done.
[    2.837259] [drm:gen6_fdi_link_train] FDI_RX_IIR 0x600
[    2.837260] [drm:gen6_fdi_link_train] FDI train 2 done.
[    2.837261] [drm:gen6_fdi_link_train] FDI train done.
[    2.837264] [drm:intel_enable_shared_dpll] enable PCH DPLL A (active 0, on? 0) for crtc 21
[    2.837266] [drm:intel_enable_shared_dpll] enabling PCH DPLL A
[    3.308497] [drm:intel_panel_enable_backlight] pipe A
[    3.308507] [drm:intel_panel_actually_set_backlight] set backlight PWM = 976
[    3.324599] [drm:set_no_fbc_reason] Disabling FBC: disabled per chip default
[    3.358083] [drm:intel_connector_check_state] [CONNECTOR:27:LVDS-1]
[    3.358090] [drm:check_encoder_state] [ENCODER:28:LVDS-28]
[    3.358094] [drm:check_encoder_state] [ENCODER:34:DAC-34]
[    3.358099] [drm:check_encoder_state] [ENCODER:35:TMDS-35]
[    3.358104] [drm:check_encoder_state] [ENCODER:40:TMDS-40]
[    3.358112] [drm:check_crtc_state] [CRTC:21]
[    3.358137] [drm:check_shared_dpll_state] PCH DPLL A
[    3.358143] [drm:check_shared_dpll_state] PCH DPLL B
[    3.358160] [drm:drm_fb_helper_hotplug_event] 
[    3.358164] [drm:drm_helper_probe_single_connector_modes] [CONNECTOR:27:LVDS-1]
[    3.358167] [drm:intel_lvds_detect] [CONNECTOR:27:LVDS-1]
[    3.358192] [drm:drm_helper_probe_single_connector_modes] [CONNECTOR:27:LVDS-1] probed modes :
[    3.358199] [drm:drm_mode_debug_printmodeline] Modeline 30:"1366x768" 60 71000 1366 1407 1434 1500 768 771 775 788 0x48 0xa
[    3.358202] [drm:drm_helper_probe_single_connector_modes] [CONNECTOR:33:VGA-1]
[    3.358206] [drm:intel_crt_detect] [CONNECTOR:33:VGA-1] force=1
[    3.358212] [drm:intel_ironlake_crt_detect_hotplug] ironlake hotplug adpa=0xf40000, result 0
[    3.358214] [drm:intel_crt_detect] CRT not detected via hotplug
[    3.358382] [drm:do_gmbus_xfer] GMBUS [i915 gmbus vga] NAK for addr: 0050 w(1)
[    3.358384] [drm:do_gmbus_xfer] GMBUS [i915 gmbus vga] NAK on first message, retry
[    3.358545] [drm:do_gmbus_xfer] GMBUS [i915 gmbus vga] NAK for addr: 0050 w(1)
[    3.358549] [drm:drm_do_probe_ddc_edid] drm: skipping non-existent adapter i915 gmbus vga
[    3.358552] [drm:intel_crt_get_edid] CRT GMBUS EDID read failed, retry using GPIO bit-banging
[    3.358555] [drm:intel_gmbus_force_bit] enabling bit-banging on i915 gmbus vga. force bit now 1
[    3.358922] [drm:drm_do_probe_ddc_edid] drm: skipping non-existent adapter i915 gmbus vga
[    3.358925] [drm:intel_gmbus_force_bit] disabling bit-banging on i915 gmbus vga. force bit now 0
[    3.358927] [drm:intel_crt_detect_ddc] CRT not detected via DDC:0x50 [no valid EDID found]
[    3.358931] [drm:drm_helper_probe_single_connector_modes] [CONNECTOR:33:VGA-1] disconnected
[    3.358935] [drm:drm_helper_probe_single_connector_modes] [CONNECTOR:36:HDMI-A-1]
[    3.358938] [drm:intel_hdmi_detect] [CONNECTOR:36:HDMI-A-1]
[    3.484833] [drm:intel_hdmi_detect] Live status not up!
[    3.484833] [drm:drm_helper_probe_single_connector_modes] [CONNECTOR:36:HDMI-A-1] disconnected
[    3.484837] [drm:drm_helper_probe_single_connector_modes] [CONNECTOR:41:DP-1]
[    3.484839] [drm:intel_dp_detect] [CONNECTOR:41:DP-1]
[    3.484845] [drm:drm_helper_probe_single_connector_modes] [CONNECTOR:41:DP-1] disconnected
[    3.484852] [drm:drm_setup_crtcs] 
[    3.484855] [drm:drm_enable_connectors] connector 27 enabled? yes
[    3.484857] [drm:drm_enable_connectors] connector 33 enabled? no
[    3.484859] [drm:drm_enable_connectors] connector 36 enabled? no
[    3.484860] [drm:drm_enable_connectors] connector 41 enabled? no
[    3.484864] [drm:intel_fb_initial_config] looking for cmdline mode on connector LVDS-1
[    3.484866] [drm:intel_fb_initial_config] looking for preferred mode on connector LVDS-1 0
[    3.484869] [drm:intel_fb_initial_config] connector LVDS-1 on pipe A [CRTC:21]: 1366x768
[    3.484871] [drm:intel_fb_initial_config] connector VGA-1 not enabled, skipping
[    3.484872] [drm:intel_fb_initial_config] connector HDMI-A-1 not enabled, skipping
[    3.484874] [drm:intel_fb_initial_config] connector DP-1 not enabled, skipping
[    3.484877] [drm:drm_setup_crtcs] desired mode 1366x768 set on crtc 21 (0,0)
[    3.516863] i915 0000:00:02.0: fb0: inteldrmfb frame buffer device
[    3.566329] [drm:intel_backlight_device_update_status] updating intel_backlight, brightness=976/976
[    3.566335] [drm:intel_panel_actually_set_backlight] set backlight PWM = 976
[    3.817220] [drm:intel_print_rc6_info] Enabling RC6 states: RC6 on RC6p off RC6pp off
[    4.862180] [drm:i915_gem_open] 
[    4.915309] [drm:i915_gem_open] 
[    4.915340] [drm:drm_mode_getresources] CRTC[2] CONNECTORS[4] ENCODERS[4]
[    4.916525] [drm:i915_gem_open] 
[    4.916549] [drm:drm_mode_getresources] CRTC[2] CONNECTORS[4] ENCODERS[4]
[    4.916556] [drm:drm_mode_getresources] [CRTC:21:crtc-0]
[    4.916560] [drm:drm_mode_getresources] [CRTC:25:crtc-1]
[    4.916563] [drm:drm_mode_getresources] [ENCODER:28:LVDS-28]
[    4.916567] [drm:drm_mode_getresources] [ENCODER:34:DAC-34]
[    4.916570] [drm:drm_mode_getresources] [ENCODER:35:TMDS-35]
[    4.916573] [drm:drm_mode_getresources] [ENCODER:40:TMDS-40]
[    4.916577] [drm:drm_mode_getresources] [CONNECTOR:27:LVDS-1]
[    4.916580] [drm:drm_mode_getresources] [CONNECTOR:33:VGA-1]
[    4.916583] [drm:drm_mode_getresources] [CONNECTOR:36:HDMI-A-1]
[    4.916586] [drm:drm_mode_getresources] [CONNECTOR:41:DP-1]
[    4.916590] [drm:drm_mode_getresources] CRTC[2] CONNECTORS[4] ENCODERS[4]
[    4.919855] [drm:i915_gem_open] 
[    4.919994] [drm:i915_gem_open] 
[    4.920548] [drm:drm_mode_getresources] CRTC[2] CONNECTORS[4] ENCODERS[4]
[    4.920558] [drm:drm_mode_getresources] [CRTC:21:crtc-0]
[    4.920562] [drm:drm_mode_getresources] [CRTC:25:crtc-1]
[    4.920566] [drm:drm_mode_getresources] [ENCODER:28:LVDS-28]
[    4.920569] [drm:drm_mode_getresources] [ENCODER:34:DAC-34]
[    4.920572] [drm:drm_mode_getresources] [ENCODER:35:TMDS-35]
[    4.920576] [drm:drm_mode_getresources] [ENCODER:40:TMDS-40]
[    4.920579] [drm:drm_mode_getresources] [CONNECTOR:27:LVDS-1]
[    4.920582] [drm:drm_mode_getresources] [CONNECTOR:33:VGA-1]
[    4.920585] [drm:drm_mode_getresources] [CONNECTOR:36:HDMI-A-1]
[    4.920588] [drm:drm_mode_getresources] [CONNECTOR:41:DP-1]
[    4.920592] [drm:drm_mode_getresources] CRTC[2] CONNECTORS[4] ENCODERS[4]
[    4.920645] [drm:drm_mode_getconnector] [CONNECTOR:27:?]
[    4.920650] [drm:drm_helper_probe_single_connector_modes] [CONNECTOR:27:LVDS-1]
[    4.920654] [drm:intel_lvds_detect] [CONNECTOR:27:LVDS-1]
[    4.920673] [drm:drm_helper_probe_single_connector_modes] [CONNECTOR:27:LVDS-1] probed modes :
[    4.920680] [drm:drm_mode_debug_printmodeline] Modeline 30:"1366x768" 60 71000 1366 1407 1434 1500 768 771 775 788 0x48 0xa
[    4.920687] [drm:drm_mode_getconnector] [CONNECTOR:27:?]
[    4.921007] [drm:intel_panel_get_backlight] get backlight PWM = 976
[    4.921053] [drm:drm_mode_getconnector] [CONNECTOR:33:?]
[    4.921058] [drm:drm_helper_probe_single_connector_modes] [CONNECTOR:33:VGA-1]
[    4.921061] [drm:intel_crt_detect] [CONNECTOR:33:VGA-1] force=1
[    4.921067] [drm:intel_ironlake_crt_detect_hotplug] ironlake hotplug adpa=0xf40000, result 0
[    4.921071] [drm:intel_crt_detect] CRT not detected via hotplug
[    4.921243] [drm:do_gmbus_xfer] GMBUS [i915 gmbus vga] NAK for addr: 0050 w(1)
[    4.921247] [drm:do_gmbus_xfer] GMBUS [i915 gmbus vga] NAK on first message, retry
[    4.921413] [drm:do_gmbus_xfer] GMBUS [i915 gmbus vga] NAK for addr: 0050 w(1)
[    4.921421] [drm:drm_do_probe_ddc_edid] drm: skipping non-existent adapter i915 gmbus vga
[    4.921424] [drm:intel_crt_get_edid] CRT GMBUS EDID read failed, retry using GPIO bit-banging
[    4.921429] [drm:intel_gmbus_force_bit] enabling bit-banging on i915 gmbus vga. force bit now 1
[    4.921819] [drm:drm_do_probe_ddc_edid] drm: skipping non-existent adapter i915 gmbus vga
[    4.921823] [drm:intel_gmbus_force_bit] disabling bit-banging on i915 gmbus vga. force bit now 0
[    4.921827] [drm:intel_crt_detect_ddc] CRT not detected via DDC:0x50 [no valid EDID found]
[    4.921832] [drm:drm_helper_probe_single_connector_modes] [CONNECTOR:33:VGA-1] disconnected
[    4.921840] [drm:drm_mode_getconnector] [CONNECTOR:33:?]
[    4.921844] [drm:drm_helper_probe_single_connector_modes] [CONNECTOR:33:VGA-1]
[    4.921848] [drm:intel_crt_detect] [CONNECTOR:33:VGA-1] force=1
[    4.921854] [drm:intel_ironlake_crt_detect_hotplug] ironlake hotplug adpa=0xf40000, result 0
[    4.921857] [drm:intel_crt_detect] CRT not detected via hotplug
[    4.922021] [drm:do_gmbus_xfer] GMBUS [i915 gmbus vga] NAK for addr: 0050 w(1)
[    4.922024] [drm:do_gmbus_xfer] GMBUS [i915 gmbus vga] NAK on first message, retry
[    4.922185] [drm:do_gmbus_xfer] GMBUS [i915 gmbus vga] NAK for addr: 0050 w(1)
[    4.922190] [drm:drm_do_probe_ddc_edid] drm: skipping non-existent adapter i915 gmbus vga
[    4.922193] [drm:intel_crt_get_edid] CRT GMBUS EDID read failed, retry using GPIO bit-banging
[    4.922197] [drm:intel_gmbus_force_bit] enabling bit-banging on i915 gmbus vga. force bit now 1
[    4.922551] [drm:drm_do_probe_ddc_edid] drm: skipping non-existent adapter i915 gmbus vga
[    4.922556] [drm:intel_gmbus_force_bit] disabling bit-banging on i915 gmbus vga. force bit now 0
[    4.922559] [drm:intel_crt_detect_ddc] CRT not detected via DDC:0x50 [no valid EDID found]
[    4.922564] [drm:drm_helper_probe_single_connector_modes] [CONNECTOR:33:VGA-1] disconnected
[    4.922614] [drm:drm_mode_getconnector] [CONNECTOR:36:?]
[    4.922619] [drm:drm_helper_probe_single_connector_modes] [CONNECTOR:36:HDMI-A-1]
[    4.922623] [drm:intel_hdmi_detect] [CONNECTOR:36:HDMI-A-1]
[    5.048969] [drm:intel_hdmi_detect] Live status not up!
[    5.048979] [drm:drm_helper_probe_single_connector_modes] [CONNECTOR:36:HDMI-A-1] disconnected
[    5.048996] [drm:drm_mode_getconnector] [CONNECTOR:36:?]
[    5.049002] [drm:drm_helper_probe_single_connector_modes] [CONNECTOR:36:HDMI-A-1]
[    5.049005] [drm:intel_hdmi_detect] [CONNECTOR:36:HDMI-A-1]
[    5.176978] [drm:intel_hdmi_detect] Live status not up!
[    5.176988] [drm:drm_helper_probe_single_connector_modes] [CONNECTOR:36:HDMI-A-1] disconnected
[    5.177094] [drm:drm_mode_getconnector] [CONNECTOR:41:?]
[    5.177100] [drm:drm_helper_probe_single_connector_modes] [CONNECTOR:41:DP-1]
[    5.177104] [drm:intel_dp_detect] [CONNECTOR:41:DP-1]
[    5.177112] [drm:drm_helper_probe_single_connector_modes] [CONNECTOR:41:DP-1] disconnected
[    5.177117] [drm:drm_mode_getconnector] [CONNECTOR:41:?]
[    5.177120] [drm:drm_helper_probe_single_connector_modes] [CONNECTOR:41:DP-1]
[    5.177123] [drm:intel_dp_detect] [CONNECTOR:41:DP-1]
[    5.177128] [drm:drm_helper_probe_single_connector_modes] [CONNECTOR:41:DP-1] disconnected
[    5.177186] [drm:drm_mode_getconnector] [CONNECTOR:27:?]
[    5.177191] [drm:drm_helper_probe_single_connector_modes] [CONNECTOR:27:LVDS-1]
[    5.177194] [drm:intel_lvds_detect] [CONNECTOR:27:LVDS-1]
[    5.177215] [drm:drm_helper_probe_single_connector_modes] [CONNECTOR:27:LVDS-1] probed modes :
[    5.177223] [drm:drm_mode_debug_printmodeline] Modeline 30:"1366x768" 60 71000 1366 1407 1434 1500 768 771 775 788 0x48 0xa
[    5.177229] [drm:drm_mode_getconnector] [CONNECTOR:27:?]
[    5.180466] [drm:drm_mode_getconnector] [CONNECTOR:33:?]
[    5.180476] [drm:drm_helper_probe_single_connector_modes] [CONNECTOR:33:VGA-1]
[    5.180481] [drm:intel_crt_detect] [CONNECTOR:33:VGA-1] force=1
[    5.180489] [drm:intel_ironlake_crt_detect_hotplug] ironlake hotplug adpa=0xf40000, result 0
[    5.180492] [drm:intel_crt_detect] CRT not detected via hotplug
[    5.181372] [drm:do_gmbus_xfer] GMBUS [i915 gmbus vga] NAK for addr: 0050 w(1)
[    5.181377] [drm:do_gmbus_xfer] GMBUS [i915 gmbus vga] NAK on first message, retry
[    5.184750] [drm:do_gmbus_xfer] GMBUS [i915 gmbus vga] NAK for addr: 0050 w(1)
[    5.184759] [drm:drm_do_probe_ddc_edid] drm: skipping non-existent adapter i915 gmbus vga
[    5.184763] [drm:intel_crt_get_edid] CRT GMBUS EDID read failed, retry using GPIO bit-banging
[    5.184767] [drm:intel_gmbus_force_bit] enabling bit-banging on i915 gmbus vga. force bit now 1
[    5.185285] [drm:drm_do_probe_ddc_edid] drm: skipping non-existent adapter i915 gmbus vga
[    5.185290] [drm:intel_gmbus_force_bit] disabling bit-banging on i915 gmbus vga. force bit now 0
[    5.185293] [drm:intel_crt_detect_ddc] CRT not detected via DDC:0x50 [no valid EDID found]
[    5.185299] [drm:drm_helper_probe_single_connector_modes] [CONNECTOR:33:VGA-1] disconnected
[    5.185314] [drm:drm_mode_getconnector] [CONNECTOR:33:?]
[    5.185318] [drm:drm_helper_probe_single_connector_modes] [CONNECTOR:33:VGA-1]
[    5.185321] [drm:intel_crt_detect] [CONNECTOR:33:VGA-1] force=1
[    5.185327] [drm:intel_ironlake_crt_detect_hotplug] ironlake hotplug adpa=0xf40000, result 0
[    5.185330] [drm:intel_crt_detect] CRT not detected via hotplug
[    5.188387] [drm:do_gmbus_xfer] GMBUS [i915 gmbus vga] NAK for addr: 0050 w(1)
[    5.188394] [drm:do_gmbus_xfer] GMBUS [i915 gmbus vga] NAK on first message, retry
[    5.188663] [drm:do_gmbus_xfer] GMBUS [i915 gmbus vga] NAK for addr: 0050 w(1)
[    5.188670] [drm:drm_do_probe_ddc_edid] drm: skipping non-existent adapter i915 gmbus vga
[    5.188674] [drm:intel_crt_get_edid] CRT GMBUS EDID read failed, retry using GPIO bit-banging
[    5.188678] [drm:intel_gmbus_force_bit] enabling bit-banging on i915 gmbus vga. force bit now 1
[    5.189259] [drm:drm_do_probe_ddc_edid] drm: skipping non-existent adapter i915 gmbus vga
[    5.189265] [drm:intel_gmbus_force_bit] disabling bit-banging on i915 gmbus vga. force bit now 0
[    5.189268] [drm:intel_crt_detect_ddc] CRT not detected via DDC:0x50 [no valid EDID found]
[    5.189274] [drm:drm_helper_probe_single_connector_modes] [CONNECTOR:33:VGA-1] disconnected
[    5.189355] [drm:drm_mode_getconnector] [CONNECTOR:36:?]
[    5.189361] [drm:drm_helper_probe_single_connector_modes] [CONNECTOR:36:HDMI-A-1]
[    5.189365] [drm:intel_hdmi_detect] [CONNECTOR:36:HDMI-A-1]
[    5.321051] [drm:intel_hdmi_detect] Live status not up!
[    5.321060] [drm:drm_helper_probe_single_connector_modes] [CONNECTOR:36:HDMI-A-1] disconnected
[    5.321075] [drm:drm_mode_getconnector] [CONNECTOR:36:?]
[    5.321079] [drm:drm_helper_probe_single_connector_modes] [CONNECTOR:36:HDMI-A-1]
[    5.321081] [drm:intel_hdmi_detect] [CONNECTOR:36:HDMI-A-1]
[    5.449030] [drm:intel_hdmi_detect] Live status not up!
[    5.449036] [drm:drm_helper_probe_single_connector_modes] [CONNECTOR:36:HDMI-A-1] disconnected
[    5.449106] [drm:drm_mode_getconnector] [CONNECTOR:41:?]
[    5.449110] [drm:drm_helper_probe_single_connector_modes] [CONNECTOR:41:DP-1]
[    5.449112] [drm:intel_dp_detect] [CONNECTOR:41:DP-1]
[    5.449157] [drm:drm_helper_probe_single_connector_modes] [CONNECTOR:41:DP-1] disconnected
[    5.449161] [drm:drm_mode_getconnector] [CONNECTOR:41:?]
[    5.449163] [drm:drm_helper_probe_single_connector_modes] [CONNECTOR:41:DP-1]
[    5.449165] [drm:intel_dp_detect] [CONNECTOR:41:DP-1]
[    5.449168] [drm:drm_helper_probe_single_connector_modes] [CONNECTOR:41:DP-1] disconnected
[    5.769106] [drm:intel_backlight_device_update_status] updating intel_backlight, brightness=976/976
[    5.769115] [drm:intel_panel_actually_set_backlight] set backlight PWM = 976
[    5.769270] [drm:intel_backlight_device_update_status] updating intel_backlight, brightness=976/976
[    5.769275] [drm:intel_panel_actually_set_backlight] set backlight PWM = 976
[    5.770027] [drm:drm_mode_addfb2] [FB:43]
[    5.770108] [drm:drm_mode_setcrtc] [CRTC:21:crtc-0]
[    5.770118] [drm:drm_mode_setcrtc] [CONNECTOR:27:LVDS-1]
[    5.787820] [drm:drm_mode_setcrtc] [CRTC:25:crtc-1]
[    6.382874] [drm:i915_gem_open] 
[    6.403483] [drm:i915_gem_context_create_ioctl] HW context 1 created
[    6.406436] [drm:i915_gem_context_destroy_ioctl] HW context 1 destroyed
[    6.987835] [drm:drm_mode_getconnector] [CONNECTOR:27:?]
[    6.987843] [drm:drm_helper_probe_single_connector_modes] [CONNECTOR:27:LVDS-1]
[    6.987846] [drm:intel_lvds_detect] [CONNECTOR:27:LVDS-1]
[    6.987862] [drm:drm_helper_probe_single_connector_modes] [CONNECTOR:27:LVDS-1] probed modes :
[    6.987867] [drm:drm_mode_debug_printmodeline] Modeline 30:"1366x768" 60 71000 1366 1407 1434 1500 768 771 775 788 0x48 0xa
[    6.987873] [drm:drm_mode_getconnector] [CONNECTOR:27:?]
[    6.988278] [drm:drm_mode_getconnector] [CONNECTOR:33:?]
[    6.988284] [drm:drm_helper_probe_single_connector_modes] [CONNECTOR:33:VGA-1]
[    6.988289] [drm:intel_crt_detect] [CONNECTOR:33:VGA-1] force=1
[    6.988298] [drm:intel_ironlake_crt_detect_hotplug] ironlake hotplug adpa=0xf40000, result 0
[    6.988300] [drm:intel_crt_detect] CRT not detected via hotplug
[    6.989445] [drm:do_gmbus_xfer] GMBUS [i915 gmbus vga] NAK for addr: 0050 w(1)
[    6.989451] [drm:do_gmbus_xfer] GMBUS [i915 gmbus vga] NAK on first message, retry
[    6.989616] [drm:do_gmbus_xfer] GMBUS [i915 gmbus vga] NAK for addr: 0050 w(1)
[    6.989621] [drm:drm_do_probe_ddc_edid] drm: skipping non-existent adapter i915 gmbus vga
[    6.989626] [drm:intel_crt_get_edid] CRT GMBUS EDID read failed, retry using GPIO bit-banging
[    6.989630] [drm:intel_gmbus_force_bit] enabling bit-banging on i915 gmbus vga. force bit now 1
[    6.989987] [drm:drm_do_probe_ddc_edid] drm: skipping non-existent adapter i915 gmbus vga
[    6.989992] [drm:intel_gmbus_force_bit] disabling bit-banging on i915 gmbus vga. force bit now 0
[    6.989996] [drm:intel_crt_detect_ddc] CRT not detected via DDC:0x50 [no valid EDID found]
[    6.990001] [drm:drm_helper_probe_single_connector_modes] [CONNECTOR:33:VGA-1] disconnected
[    6.990014] [drm:drm_mode_getconnector] [CONNECTOR:33:?]
[    6.990019] [drm:drm_helper_probe_single_connector_modes] [CONNECTOR:33:VGA-1]
[    6.990023] [drm:intel_crt_detect] [CONNECTOR:33:VGA-1] force=1
[    6.990029] [drm:intel_ironlake_crt_detect_hotplug] ironlake hotplug adpa=0xf40000, result 0
[    6.990032] [drm:intel_crt_detect] CRT not detected via hotplug
[    6.990195] [drm:do_gmbus_xfer] GMBUS [i915 gmbus vga] NAK for addr: 0050 w(1)
[    6.990201] [drm:do_gmbus_xfer] GMBUS [i915 gmbus vga] NAK on first message, retry
[    6.990366] [drm:do_gmbus_xfer] GMBUS [i915 gmbus vga] NAK for addr: 0050 w(1)
[    6.990372] [drm:drm_do_probe_ddc_edid] drm: skipping non-existent adapter i915 gmbus vga
[    6.990375] [drm:intel_crt_get_edid] CRT GMBUS EDID read failed, retry using GPIO bit-banging
[    6.990378] [drm:intel_gmbus_force_bit] enabling bit-banging on i915 gmbus vga. force bit now 1
[    6.990734] [drm:drm_do_probe_ddc_edid] drm: skipping non-existent adapter i915 gmbus vga
[    6.990738] [drm:intel_gmbus_force_bit] disabling bit-banging on i915 gmbus vga. force bit now 0
[    6.990741] [drm:intel_crt_detect_ddc] CRT not detected via DDC:0x50 [no valid EDID found]
[    6.990745] [drm:drm_helper_probe_single_connector_modes] [CONNECTOR:33:VGA-1] disconnected
[    6.990764] [drm:drm_mode_getconnector] [CONNECTOR:36:?]
[    6.990769] [drm:drm_helper_probe_single_connector_modes] [CONNECTOR:36:HDMI-A-1]
[    6.990772] [drm:intel_hdmi_detect] [CONNECTOR:36:HDMI-A-1]
[    7.117164] [drm:intel_hdmi_detect] Live status not up!
[    7.117174] [drm:drm_helper_probe_single_connector_modes] [CONNECTOR:36:HDMI-A-1] disconnected
[    7.117201] [drm:drm_mode_getconnector] [CONNECTOR:36:?]
[    7.117206] [drm:drm_helper_probe_single_connector_modes] [CONNECTOR:36:HDMI-A-1]
[    7.117209] [drm:intel_hdmi_detect] [CONNECTOR:36:HDMI-A-1]
[    7.245265] [drm:intel_hdmi_detect] Live status not up!
[    7.245278] [drm:drm_helper_probe_single_connector_modes] [CONNECTOR:36:HDMI-A-1] disconnected
[    7.245335] [drm:drm_mode_getconnector] [CONNECTOR:41:?]
[    7.245342] [drm:drm_helper_probe_single_connector_modes] [CONNECTOR:41:DP-1]
[    7.245346] [drm:intel_dp_detect] [CONNECTOR:41:DP-1]
[    7.245354] [drm:drm_helper_probe_single_connector_modes] [CONNECTOR:41:DP-1] disconnected
[    7.245359] [drm:drm_mode_getconnector] [CONNECTOR:41:?]
[    7.245362] [drm:drm_helper_probe_single_connector_modes] [CONNECTOR:41:DP-1]
[    7.245365] [drm:intel_dp_detect] [CONNECTOR:41:DP-1]
[    7.245370] [drm:drm_helper_probe_single_connector_modes] [CONNECTOR:41:DP-1] disconnected
[    7.248275] [drm:i915_gem_open] 
[    7.271783] [drm:i915_gem_context_create_ioctl] HW context 1 created
[    7.274062] [drm:i915_gem_context_destroy_ioctl] HW context 1 destroyed
[    7.279895] [drm:i915_gem_context_create_ioctl] HW context 1 created
[    7.314121] [drm:intel_panel_get_backlight] get backlight PWM = 976
[    7.314150] [drm:intel_backlight_device_update_status] updating intel_backlight, brightness=976/976
[    7.314153] [drm:intel_panel_actually_set_backlight] set backlight PWM = 976
[    7.315684] [drm:intel_panel_get_backlight] get backlight PWM = 976
[    7.315723] [drm:intel_backlight_device_update_status] updating intel_backlight, brightness=976/976
[    7.315728] [drm:intel_panel_actually_set_backlight] set backlight PWM = 976
[    8.667379] [drm:intel_panel_get_backlight] get backlight PWM = 976
[    8.667411] [drm:intel_backlight_device_update_status] updating intel_backlight, brightness=976/976
[    8.667414] [drm:intel_panel_actually_set_backlight] set backlight PWM = 976
[    8.675110] [drm:drm_mode_getconnector] [CONNECTOR:27:?]
[    8.675118] [drm:drm_helper_probe_single_connector_modes] [CONNECTOR:27:LVDS-1]
[    8.675121] [drm:intel_lvds_detect] [CONNECTOR:27:LVDS-1]
[    8.675137] [drm:drm_helper_probe_single_connector_modes] [CONNECTOR:27:LVDS-1] probed modes :
[    8.675142] [drm:drm_mode_debug_printmodeline] Modeline 30:"1366x768" 60 71000 1366 1407 1434 1500 768 771 775 788 0x48 0xa
[    8.675147] [drm:drm_mode_getconnector] [CONNECTOR:27:?]
[    8.675562] [drm:drm_mode_getconnector] [CONNECTOR:33:?]
[    8.675568] [drm:drm_helper_probe_single_connector_modes] [CONNECTOR:33:VGA-1]
[    8.675572] [drm:intel_crt_detect] [CONNECTOR:33:VGA-1] force=1
[    8.675581] [drm:intel_ironlake_crt_detect_hotplug] ironlake hotplug adpa=0xf40000, result 0
[    8.675584] [drm:intel_crt_detect] CRT not detected via hotplug
[    8.675760] [drm:do_gmbus_xfer] GMBUS [i915 gmbus vga] NAK for addr: 0050 w(1)
[    8.675765] [drm:do_gmbus_xfer] GMBUS [i915 gmbus vga] NAK on first message, retry
[    8.675932] [drm:do_gmbus_xfer] GMBUS [i915 gmbus vga] NAK for addr: 0050 w(1)
[    8.675937] [drm:drm_do_probe_ddc_edid] drm: skipping non-existent adapter i915 gmbus vga
[    8.675941] [drm:intel_crt_get_edid] CRT GMBUS EDID read failed, retry using GPIO bit-banging
[    8.675945] [drm:intel_gmbus_force_bit] enabling bit-banging on i915 gmbus vga. force bit now 1
[    8.676301] [drm:drm_do_probe_ddc_edid] drm: skipping non-existent adapter i915 gmbus vga
[    8.676306] [drm:intel_gmbus_force_bit] disabling bit-banging on i915 gmbus vga. force bit now 0
[    8.676309] [drm:intel_crt_detect_ddc] CRT not detected via DDC:0x50 [no valid EDID found]
[    8.676314] [drm:drm_helper_probe_single_connector_modes] [CONNECTOR:33:VGA-1] disconnected
[    8.676322] [drm:drm_mode_getconnector] [CONNECTOR:33:?]
[    8.676326] [drm:drm_helper_probe_single_connector_modes] [CONNECTOR:33:VGA-1]
[    8.676330] [drm:intel_crt_detect] [CONNECTOR:33:VGA-1] force=1
[    8.676335] [drm:intel_ironlake_crt_detect_hotplug] ironlake hotplug adpa=0xf40000, result 0
[    8.676338] [drm:intel_crt_detect] CRT not detected via hotplug
[    8.676567] [drm:do_gmbus_xfer] GMBUS [i915 gmbus vga] NAK for addr: 0050 w(1)
[    8.676583] [drm:do_gmbus_xfer] GMBUS [i915 gmbus vga] NAK on first message, retry
[    8.676770] [drm:do_gmbus_xfer] GMBUS [i915 gmbus vga] NAK for addr: 0050 w(1)
[    8.676778] [drm:drm_do_probe_ddc_edid] drm: skipping non-existent adapter i915 gmbus vga
[    8.676782] [drm:intel_crt_get_edid] CRT GMBUS EDID read failed, retry using GPIO bit-banging
[    8.676787] [drm:intel_gmbus_force_bit] enabling bit-banging on i915 gmbus vga. force bit now 1
[    8.677143] [drm:drm_do_probe_ddc_edid] drm: skipping non-existent adapter i915 gmbus vga
[    8.677145] [drm:intel_gmbus_force_bit] disabling bit-banging on i915 gmbus vga. force bit now 0
[    8.677147] [drm:intel_crt_detect_ddc] CRT not detected via DDC:0x50 [no valid EDID found]
[    8.677150] [drm:drm_helper_probe_single_connector_modes] [CONNECTOR:33:VGA-1] disconnected
[    8.677167] [drm:drm_mode_getconnector] [CONNECTOR:36:?]
[    8.677170] [drm:drm_helper_probe_single_connector_modes] [CONNECTOR:36:HDMI-A-1]
[    8.677172] [drm:intel_hdmi_detect] [CONNECTOR:36:HDMI-A-1]
[    8.801414] [drm:intel_hdmi_detect] Live status not up!
[    8.801428] [drm:drm_helper_probe_single_connector_modes] [CONNECTOR:36:HDMI-A-1] disconnected
[    8.801475] [drm:drm_mode_getconnector] [CONNECTOR:36:?]
[    8.801481] [drm:drm_helper_probe_single_connector_modes] [CONNECTOR:36:HDMI-A-1]
[    8.801484] [drm:intel_hdmi_detect] [CONNECTOR:36:HDMI-A-1]
[    8.929425] [drm:intel_hdmi_detect] Live status not up!
[    8.929439] [drm:drm_helper_probe_single_connector_modes] [CONNECTOR:36:HDMI-A-1] disconnected
[    8.929503] [drm:drm_mode_getconnector] [CONNECTOR:41:?]
[    8.929510] [drm:drm_helper_probe_single_connector_modes] [CONNECTOR:41:DP-1]
[    8.929514] [drm:intel_dp_detect] [CONNECTOR:41:DP-1]
[    8.929523] [drm:drm_helper_probe_single_connector_modes] [CONNECTOR:41:DP-1] disconnected
[    8.929529] [drm:drm_mode_getconnector] [CONNECTOR:41:?]
[    8.929532] [drm:drm_helper_probe_single_connector_modes] [CONNECTOR:41:DP-1]
[    8.929536] [drm:intel_dp_detect] [CONNECTOR:41:DP-1]
[    8.929541] [drm:drm_helper_probe_single_connector_modes] [CONNECTOR:41:DP-1] disconnected
[    9.311506] [drm:drm_mode_addfb2] [FB:45]
[    9.434770] [drm:drm_mode_addfb2] [FB:43]
[    9.468625] [drm:drm_mode_addfb2] [FB:45]
[    9.474006] [drm:drm_mode_addfb2] [FB:46]
[    9.510879] [drm:drm_mode_addfb2] [FB:43]
[    9.524282] [drm:drm_mode_addfb2] [FB:45]
[    9.547128] [drm:drm_mode_addfb2] [FB:43]
[    9.557894] [drm:drm_mode_addfb2] [FB:45]
[    9.574656] [drm:drm_mode_addfb2] [FB:43]
[    9.591349] [drm:drm_mode_addfb2] [FB:45]
[    9.608071] [drm:drm_mode_addfb2] [FB:43]
[    9.624798] [drm:drm_mode_addfb2] [FB:45]
[    9.641571] [drm:drm_mode_addfb2] [FB:46]
[    9.672676] [drm:drm_mode_addfb2] [FB:43]
[    9.691868] [drm:drm_mode_addfb2] [FB:45]
[    9.708717] [drm:drm_mode_addfb2] [FB:43]
[    9.725354] [drm:drm_mode_addfb2] [FB:45]
[    9.742551] [drm:drm_mode_addfb2] [FB:46]
[    9.758853] [drm:drm_mode_addfb2] [FB:43]
[    9.775616] [drm:drm_mode_addfb2] [FB:45]
[    9.792353] [drm:drm_mode_addfb2] [FB:43]
[    9.809113] [drm:drm_mode_addfb2] [FB:45]
[    9.825919] [drm:drm_mode_addfb2] [FB:43]
[    9.842739] [drm:drm_mode_addfb2] [FB:45]
[    9.859584] [drm:drm_mode_addfb2] [FB:43]
[    9.876205] [drm:drm_mode_addfb2] [FB:45]
[    9.892919] [drm:drm_mode_addfb2] [FB:43]
[    9.909673] [drm:drm_mode_addfb2] [FB:45]
[    9.926420] [drm:drm_mode_addfb2] [FB:43]
[    9.943187] [drm:drm_mode_addfb2] [FB:46]
[    9.960036] [drm:drm_mode_addfb2] [FB:43]
[    9.976713] [drm:drm_mode_addfb2] [FB:45]
[    9.993479] [drm:drm_mode_addfb2] [FB:43]
[   10.020853] [drm:drm_mode_addfb2] [FB:45]
[   10.027019] [drm:drm_mode_addfb2] [FB:43]
[   10.043799] [drm:drm_mode_addfb2] [FB:45]
[   10.060577] [drm:drm_mode_addfb2] [FB:43]
[   10.077357] [drm:drm_mode_addfb2] [FB:45]
[   10.094137] [drm:drm_mode_addfb2] [FB:43]
[   10.110894] [drm:drm_mode_addfb2] [FB:45]
[   10.127572] [drm:drm_mode_addfb2] [FB:43]
[   10.144278] [drm:drm_mode_addfb2] [FB:45]
[   10.161120] [drm:drm_mode_addfb2] [FB:43]
[   10.177916] [drm:drm_mode_addfb2] [FB:45]
[   10.194680] [drm:drm_mode_addfb2] [FB:43]
[   10.211419] [drm:drm_mode_addfb2] [FB:45]
[   10.228217] [drm:drm_mode_addfb2] [FB:43]
[   10.244972] [drm:drm_mode_addfb2] [FB:45]
[   10.261607] [drm:drm_mode_addfb2] [FB:43]
[   10.278457] [drm:drm_mode_addfb2] [FB:45]
[   10.295127] [drm:drm_mode_addfb2] [FB:43]
[   10.311867] [drm:drm_mode_addfb2] [FB:45]
[   10.378519] [drm:drm_mode_addfb2] [FB:43]
[   10.429068] [drm:drm_mode_addfb2] [FB:45]
[   10.446022] [drm:drm_mode_addfb2] [FB:43]
[   10.462628] [drm:drm_mode_addfb2] [FB:45]
[   10.479386] [drm:drm_mode_addfb2] [FB:43]
[   10.496116] [drm:drm_mode_addfb2] [FB:45]
[   10.517023] [drm:drm_mode_addfb2] [FB:43]
[   10.537662] [drm:drm_mode_addfb2] [FB:45]
[   10.551847] [drm:drm_mode_addfb2] [FB:43]
[   10.569785] [drm:drm_mode_addfb2] [FB:45]
[   10.580062] [drm:drm_mode_addfb2] [FB:43]
[   10.596810] [drm:drm_mode_addfb2] [FB:45]
[   10.613587] [drm:drm_mode_addfb2] [FB:43]
[   10.630321] [drm:drm_mode_addfb2] [FB:45]
[   10.647077] [drm:drm_mode_addfb2] [FB:43]
[   10.663855] [drm:drm_mode_addfb2] [FB:45]
[   10.680602] [drm:drm_mode_addfb2] [FB:43]
[   10.697347] [drm:drm_mode_addfb2] [FB:45]
[   10.714084] [drm:drm_mode_addfb2] [FB:43]
[   10.730878] [drm:drm_mode_addfb2] [FB:45]
[   10.747635] [drm:drm_mode_addfb2] [FB:43]
[   10.764384] [drm:drm_mode_addfb2] [FB:45]
[   13.302005] [drm:drm_mode_addfb2] [FB:43]
[   13.318698] [drm:drm_mode_addfb2] [FB:45]
[   13.333249] [drm:drm_mode_addfb2] [FB:43]
[   13.351162] [drm:drm_mode_addfb2] [FB:45]
[   13.366732] [drm:drm_mode_addfb2] [FB:43]
[   13.383857] [drm:drm_mode_addfb2] [FB:45]
[   13.401245] [drm:drm_mode_addfb2] [FB:43]
[   13.417395] [drm:drm_mode_addfb2] [FB:45]
[   13.434642] [drm:drm_mode_addfb2] [FB:43]
[   13.450799] [drm:drm_mode_addfb2] [FB:45]
[   13.461921] [drm:drm_mode_addfb2] [FB:43]
[   13.478776] [drm:drm_mode_addfb2] [FB:45]
[   13.495530] [drm:drm_mode_addfb2] [FB:43]
[   13.512290] [drm:drm_mode_addfb2] [FB:45]
[   13.529050] [drm:drm_mode_addfb2] [FB:43]
[   13.545804] [drm:drm_mode_addfb2] [FB:45]
[   14.582716] [drm:drm_mode_getconnector] [CONNECTOR:27:?]
[   14.582726] [drm:drm_helper_probe_single_connector_modes] [CONNECTOR:27:LVDS-1]
[   14.582729] [drm:intel_lvds_detect] [CONNECTOR:27:LVDS-1]
[   14.582745] [drm:drm_helper_probe_single_connector_modes] [CONNECTOR:27:LVDS-1] probed modes :
[   14.582750] [drm:drm_mode_debug_printmodeline] Modeline 30:"1366x768" 60 71000 1366 1407 1434 1500 768 771 775 788 0x48 0xa
[   14.582755] [drm:drm_mode_getconnector] [CONNECTOR:27:?]
[   14.583088] [drm:drm_mode_getconnector] [CONNECTOR:33:?]
[   14.583092] [drm:drm_helper_probe_single_connector_modes] [CONNECTOR:33:VGA-1]
[   14.583095] [drm:intel_crt_detect] [CONNECTOR:33:VGA-1] force=1
[   14.583102] [drm:intel_ironlake_crt_detect_hotplug] ironlake hotplug adpa=0xf40000, result 0
[   14.583104] [drm:intel_crt_detect] CRT not detected via hotplug
[   14.583268] [drm:do_gmbus_xfer] GMBUS [i915 gmbus vga] NAK for addr: 0050 w(1)
[   14.583271] [drm:do_gmbus_xfer] GMBUS [i915 gmbus vga] NAK on first message, retry
[   14.583430] [drm:do_gmbus_xfer] GMBUS [i915 gmbus vga] NAK for addr: 0050 w(1)
[   14.583435] [drm:drm_do_probe_ddc_edid] drm: skipping non-existent adapter i915 gmbus vga
[   14.583437] [drm:intel_crt_get_edid] CRT GMBUS EDID read failed, retry using GPIO bit-banging
[   14.583440] [drm:intel_gmbus_force_bit] enabling bit-banging on i915 gmbus vga. force bit now 1
[   14.583788] [drm:drm_do_probe_ddc_edid] drm: skipping non-existent adapter i915 gmbus vga
[   14.583791] [drm:intel_gmbus_force_bit] disabling bit-banging on i915 gmbus vga. force bit now 0
[   14.583794] [drm:intel_crt_detect_ddc] CRT not detected via DDC:0x50 [no valid EDID found]
[   14.583799] [drm:drm_helper_probe_single_connector_modes] [CONNECTOR:33:VGA-1] disconnected
[   14.583808] [drm:drm_mode_getconnector] [CONNECTOR:33:?]
[   14.583811] [drm:drm_helper_probe_single_connector_modes] [CONNECTOR:33:VGA-1]
[   14.583814] [drm:intel_crt_detect] [CONNECTOR:33:VGA-1] force=1
[   14.583818] [drm:intel_ironlake_crt_detect_hotplug] ironlake hotplug adpa=0xf40000, result 0
[   14.583820] [drm:intel_crt_detect] CRT not detected via hotplug
[   14.583978] [drm:do_gmbus_xfer] GMBUS [i915 gmbus vga] NAK for addr: 0050 w(1)
[   14.583981] [drm:do_gmbus_xfer] GMBUS [i915 gmbus vga] NAK on first message, retry
[   14.584135] [drm:do_gmbus_xfer] GMBUS [i915 gmbus vga] NAK for addr: 0050 w(1)
[   14.584137] [drm:drm_do_probe_ddc_edid] drm: skipping non-existent adapter i915 gmbus vga
[   14.584139] [drm:intel_crt_get_edid] CRT GMBUS EDID read failed, retry using GPIO bit-banging
[   14.584141] [drm:intel_gmbus_force_bit] enabling bit-banging on i915 gmbus vga. force bit now 1
[   14.584490] [drm:drm_do_probe_ddc_edid] drm: skipping non-existent adapter i915 gmbus vga
[   14.584492] [drm:intel_gmbus_force_bit] disabling bit-banging on i915 gmbus vga. force bit now 0
[   14.584494] [drm:intel_crt_detect_ddc] CRT not detected via DDC:0x50 [no valid EDID found]
[   14.584497] [drm:drm_helper_probe_single_connector_modes] [CONNECTOR:33:VGA-1] disconnected
[   14.584507] [drm:drm_mode_getconnector] [CONNECTOR:36:?]
[   14.584510] [drm:drm_helper_probe_single_connector_modes] [CONNECTOR:36:HDMI-A-1]
[   14.584513] [drm:intel_hdmi_detect] [CONNECTOR:36:HDMI-A-1]
[   14.709970] [drm:intel_hdmi_detect] Live status not up!
[   14.709983] [drm:drm_helper_probe_single_connector_modes] [CONNECTOR:36:HDMI-A-1] disconnected
[   14.710027] [drm:drm_mode_getconnector] [CONNECTOR:36:?]
[   14.710032] [drm:drm_helper_probe_single_connector_modes] [CONNECTOR:36:HDMI-A-1]
[   14.710036] [drm:intel_hdmi_detect] [CONNECTOR:36:HDMI-A-1]
[   14.837970] [drm:intel_hdmi_detect] Live status not up!
[   14.837988] [drm:drm_helper_probe_single_connector_modes] [CONNECTOR:36:HDMI-A-1] disconnected
[   14.838045] [drm:drm_mode_getconnector] [CONNECTOR:41:?]
[   14.838052] [drm:drm_helper_probe_single_connector_modes] [CONNECTOR:41:DP-1]
[   14.838055] [drm:intel_dp_detect] [CONNECTOR:41:DP-1]
[   14.838063] [drm:drm_helper_probe_single_connector_modes] [CONNECTOR:41:DP-1] disconnected
[   14.838069] [drm:drm_mode_getconnector] [CONNECTOR:41:?]
[   14.838072] [drm:drm_helper_probe_single_connector_modes] [CONNECTOR:41:DP-1]
[   14.838075] [drm:intel_dp_detect] [CONNECTOR:41:DP-1]
[   14.838080] [drm:drm_helper_probe_single_connector_modes] [CONNECTOR:41:DP-1] disconnected
[   14.842308] [drm:i915_gem_open] 
[   14.857855] [drm:i915_gem_context_create_ioctl] HW context 1 created
[   14.859907] [drm:i915_gem_context_destroy_ioctl] HW context 1 destroyed
[   14.864321] [drm:i915_gem_context_create_ioctl] HW context 1 created
[   14.912197] [drm:intel_panel_get_backlight] get backlight PWM = 976
[   14.912241] [drm:intel_backlight_device_update_status] updating intel_backlight, brightness=976/976
[   14.912246] [drm:intel_panel_actually_set_backlight] set backlight PWM = 976
[   14.913693] [drm:intel_panel_get_backlight] get backlight PWM = 976
[   14.913730] [drm:intel_backlight_device_update_status] updating intel_backlight, brightness=976/976
[   14.913735] [drm:intel_panel_actually_set_backlight] set backlight PWM = 976
[   16.574107] [drm:drm_mode_getconnector] [CONNECTOR:27:?]
[   16.574117] [drm:drm_helper_probe_single_connector_modes] [CONNECTOR:27:LVDS-1]
[   16.574121] [drm:intel_lvds_detect] [CONNECTOR:27:LVDS-1]
[   16.574143] [drm:drm_helper_probe_single_connector_modes] [CONNECTOR:27:LVDS-1] probed modes :
[   16.574150] [drm:drm_mode_debug_printmodeline] Modeline 30:"1366x768" 60 71000 1366 1407 1434 1500 768 771 775 788 0x48 0xa
[   16.574157] [drm:drm_mode_getconnector] [CONNECTOR:27:?]
[   16.574601] [drm:drm_mode_getconnector] [CONNECTOR:33:?]
[   16.574608] [drm:drm_helper_probe_single_connector_modes] [CONNECTOR:33:VGA-1]
[   16.574612] [drm:intel_crt_detect] [CONNECTOR:33:VGA-1] force=1
[   16.574620] [drm:intel_ironlake_crt_detect_hotplug] ironlake hotplug adpa=0xf40000, result 0
[   16.574624] [drm:intel_crt_detect] CRT not detected via hotplug
[   16.574917] [drm:do_gmbus_xfer] GMBUS [i915 gmbus vga] NAK for addr: 0050 w(1)
[   16.574921] [drm:do_gmbus_xfer] GMBUS [i915 gmbus vga] NAK on first message, retry
[   16.575087] [drm:do_gmbus_xfer] GMBUS [i915 gmbus vga] NAK for addr: 0050 w(1)
[   16.575093] [drm:drm_do_probe_ddc_edid] drm: skipping non-existent adapter i915 gmbus vga
[   16.575097] [drm:intel_crt_get_edid] CRT GMBUS EDID read failed, retry using GPIO bit-banging
[   16.575101] [drm:intel_gmbus_force_bit] enabling bit-banging on i915 gmbus vga. force bit now 1
[   16.575457] [drm:drm_do_probe_ddc_edid] drm: skipping non-existent adapter i915 gmbus vga
[   16.575462] [drm:intel_gmbus_force_bit] disabling bit-banging on i915 gmbus vga. force bit now 0
[   16.575466] [drm:intel_crt_detect_ddc] CRT not detected via DDC:0x50 [no valid EDID found]
[   16.575471] [drm:drm_helper_probe_single_connector_modes] [CONNECTOR:33:VGA-1] disconnected
[   16.575482] [drm:drm_mode_getconnector] [CONNECTOR:33:?]
[   16.575486] [drm:drm_helper_probe_single_connector_modes] [CONNECTOR:33:VGA-1]
[   16.575490] [drm:intel_crt_detect] [CONNECTOR:33:VGA-1] force=1
[   16.575496] [drm:intel_ironlake_crt_detect_hotplug] ironlake hotplug adpa=0xf40000, result 0
[   16.575499] [drm:intel_crt_detect] CRT not detected via hotplug
[   16.575673] [drm:do_gmbus_xfer] GMBUS [i915 gmbus vga] NAK for addr: 0050 w(1)
[   16.575676] [drm:do_gmbus_xfer] GMBUS [i915 gmbus vga] NAK on first message, retry
[   16.575847] [drm:do_gmbus_xfer] GMBUS [i915 gmbus vga] NAK for addr: 0050 w(1)
[   16.575853] [drm:drm_do_probe_ddc_edid] drm: skipping non-existent adapter i915 gmbus vga
[   16.575857] [drm:intel_crt_get_edid] CRT GMBUS EDID read failed, retry using GPIO bit-banging
[   16.575860] [drm:intel_gmbus_force_bit] enabling bit-banging on i915 gmbus vga. force bit now 1
[   16.576221] [drm:drm_do_probe_ddc_edid] drm: skipping non-existent adapter i915 gmbus vga
[   16.576227] [drm:intel_gmbus_force_bit] disabling bit-banging on i915 gmbus vga. force bit now 0
[   16.576229] [drm:intel_crt_detect_ddc] CRT not detected via DDC:0x50 [no valid EDID found]
[   16.576234] [drm:drm_helper_probe_single_connector_modes] [CONNECTOR:33:VGA-1] disconnected
[   16.576259] [drm:drm_mode_getconnector] [CONNECTOR:36:?]
[   16.576264] [drm:drm_helper_probe_single_connector_modes] [CONNECTOR:36:HDMI-A-1]
[   16.576268] [drm:intel_hdmi_detect] [CONNECTOR:36:HDMI-A-1]
[   16.702037] [drm:intel_hdmi_detect] Live status not up!
[   16.702046] [drm:drm_helper_probe_single_connector_modes] [CONNECTOR:36:HDMI-A-1] disconnected
[   16.702074] [drm:drm_mode_getconnector] [CONNECTOR:36:?]
[   16.702079] [drm:drm_helper_probe_single_connector_modes] [CONNECTOR:36:HDMI-A-1]
[   16.702083] [drm:intel_hdmi_detect] [CONNECTOR:36:HDMI-A-1]
[   16.830059] [drm:intel_hdmi_detect] Live status not up!
[   16.830068] [drm:drm_helper_probe_single_connector_modes] [CONNECTOR:36:HDMI-A-1] disconnected
[   16.830106] [drm:drm_mode_getconnector] [CONNECTOR:41:?]
[   16.830112] [drm:drm_helper_probe_single_connector_modes] [CONNECTOR:41:DP-1]
[   16.830116] [drm:intel_dp_detect] [CONNECTOR:41:DP-1]
[   16.830123] [drm:drm_helper_probe_single_connector_modes] [CONNECTOR:41:DP-1] disconnected
[   16.830128] [drm:drm_mode_getconnector] [CONNECTOR:41:?]
[   16.830132] [drm:drm_helper_probe_single_connector_modes] [CONNECTOR:41:DP-1]
[   16.830135] [drm:intel_dp_detect] [CONNECTOR:41:DP-1]
[   16.830140] [drm:drm_helper_probe_single_connector_modes] [CONNECTOR:41:DP-1] disconnected
[   18.541523] [drm:i915_gem_open] 
[   18.564587] [drm:drm_mode_addfb2] [FB:43]
[   18.606099] [drm:i915_gem_context_create_ioctl] HW context 1 created
[   18.618890] [drm:i915_gem_context_destroy_ioctl] HW context 1 destroyed
[   18.919163] [drm:drm_mode_addfb2] [FB:45]
[   18.950044] [drm:drm_mode_addfb2] [FB:43]
[   18.975510] [drm:drm_mode_addfb2] [FB:45]
[   19.321483] [drm:i915_gem_context_create_ioctl] HW context 1 created
[   19.919379] [drm:drm_mode_addfb2] [FB:43]
[   19.936317] [drm:drm_mode_addfb2] [FB:45]
[   19.952842] [drm:drm_mode_addfb2] [FB:43]
[   19.978852] [drm:drm_mode_addfb2] [FB:45]
[   20.243124] [drm:drm_mode_addfb2] [FB:43]
[   20.310299] [drm:drm_mode_addfb2] [FB:45]
[   20.324487] [drm:drm_mode_addfb2] [FB:43]
[   20.387895] [drm:drm_mode_addfb2] [FB:45]
[   20.410310] [drm:drm_mode_addfb2] [FB:43]
[   21.427857] [drm:drm_mode_addfb2] [FB:46]
[   22.527829] [drm:drm_mode_addfb2] [FB:43]
[   22.585946] [drm:drm_mode_addfb2] [FB:45]
[   22.603988] [drm:drm_mode_addfb2] [FB:43]
[   22.703175] [drm:drm_mode_addfb2] [FB:45]
[   36.802794] [drm:drm_mode_addfb2] [FB:46]
[   39.807509] [drm:drm_mode_addfb2] [FB:45]
[   46.532998] [drm:drm_mode_addfb2] [FB:46]
[   92.500770] [drm:intel_get_hpd_pins] hotplug event received, stat 0x00200000, dig 0x00101012, pins 0x00000020
[   92.500782] [drm:intel_hpd_irq_handler] digital hpd port B - long
[   92.500787] [drm:intel_hpd_irq_storm_detect] Received HPD interrupt on PIN 5 - cnt: 0
[   92.500856] [drm:intel_dp_hpd_pulse] got hpd irq on port B - long
[   92.503438] [drm:intel_dp_aux_ch] dp_aux_ch timeout status 0x7143003f
[   92.505981] [drm:intel_dp_aux_ch] dp_aux_ch timeout status 0x7143003f
[   92.515573] [drm:intel_dp_aux_ch] dp_aux_ch timeout status 0x7143003f
[   92.523583] [drm:intel_dp_aux_ch] dp_aux_ch timeout status 0x7143003f
[   92.529075] [drm:i915_hotplug_work_func] running encoder hotplug functions
[   92.529085] [drm:i915_hotplug_work_func] Connector HDMI-A-1 (pin 5) received hotplug event.
[   92.529089] [drm:intel_hdmi_detect] [CONNECTOR:36:HDMI-A-1]
[   92.554324] [drm:drm_detect_monitor_audio] Monitor has basic audio support
[   92.554338] [drm:intel_hpd_irq_event] [CONNECTOR:36:HDMI-A-1] status updated from disconnected to connected
[   92.554344] [drm:i915_hotplug_work_func] Connector DP-1 (pin 5) received hotplug event.
[   92.554349] [drm:intel_dp_detect] [CONNECTOR:41:DP-1]
[   92.556837] [drm:intel_dp_aux_ch] dp_aux_ch timeout status 0x7143003f
[   92.559324] [drm:intel_dp_aux_ch] dp_aux_ch timeout status 0x7143003f
[   92.567442] [drm:intel_dp_aux_ch] dp_aux_ch timeout status 0x7143003f
[   92.575557] [drm:intel_dp_aux_ch] dp_aux_ch timeout status 0x7143003f
[   92.583322] [drm:drm_mode_getconnector] [CONNECTOR:27:?]
[   92.583332] [drm:drm_helper_probe_single_connector_modes] [CONNECTOR:27:LVDS-1]
[   92.583337] [drm:intel_lvds_detect] [CONNECTOR:27:LVDS-1]
[   92.583357] [drm:drm_helper_probe_single_connector_modes] [CONNECTOR:27:LVDS-1] probed modes :
[   92.583364] [drm:drm_mode_debug_printmodeline] Modeline 30:"1366x768" 60 71000 1366 1407 1434 1500 768 771 775 788 0x48 0xa
[   92.583371] [drm:drm_mode_getconnector] [CONNECTOR:27:?]
[   92.583722] [drm:drm_mode_getconnector] [CONNECTOR:33:?]
[   92.583726] [drm:drm_helper_probe_single_connector_modes] [CONNECTOR:33:VGA-1]
[   92.583729] [drm:intel_crt_detect] [CONNECTOR:33:VGA-1] force=1
[   92.583736] [drm:intel_ironlake_crt_detect_hotplug] ironlake hotplug adpa=0xf40000, result 0
[   92.583738] [drm:intel_crt_detect] CRT not detected via hotplug
[   92.583965] [drm:do_gmbus_xfer] GMBUS [i915 gmbus vga] NAK for addr: 0050 w(1)
[   92.583970] [drm:do_gmbus_xfer] GMBUS [i915 gmbus vga] NAK on first message, retry
[   92.584155] [drm:do_gmbus_xfer] GMBUS [i915 gmbus vga] NAK for addr: 0050 w(1)
[   92.584164] [drm:drm_do_probe_ddc_edid] drm: skipping non-existent adapter i915 gmbus vga
[   92.584168] [drm:intel_crt_get_edid] CRT GMBUS EDID read failed, retry using GPIO bit-banging
[   92.584172] [drm:intel_gmbus_force_bit] enabling bit-banging on i915 gmbus vga. force bit now 1
[   92.584540] [drm:drm_do_probe_ddc_edid] drm: skipping non-existent adapter i915 gmbus vga
[   92.584544] [drm:intel_gmbus_force_bit] disabling bit-banging on i915 gmbus vga. force bit now 0
[   92.584547] [drm:intel_crt_detect_ddc] CRT not detected via DDC:0x50 [no valid EDID found]
[   92.584551] [drm:drm_helper_probe_single_connector_modes] [CONNECTOR:33:VGA-1] disconnected
[   92.584562] [drm:drm_mode_getconnector] [CONNECTOR:33:?]
[   92.584565] [drm:drm_helper_probe_single_connector_modes] [CONNECTOR:33:VGA-1]
[   92.584568] [drm:intel_crt_detect] [CONNECTOR:33:VGA-1] force=1
[   92.584573] [drm:intel_ironlake_crt_detect_hotplug] ironlake hotplug adpa=0xf40000, result 0
[   92.584576] [drm:intel_crt_detect] CRT not detected via hotplug
[   92.584748] [drm:do_gmbus_xfer] GMBUS [i915 gmbus vga] NAK for addr: 0050 w(1)
[   92.584752] [drm:do_gmbus_xfer] GMBUS [i915 gmbus vga] NAK on first message, retry
[   92.584919] [drm:do_gmbus_xfer] GMBUS [i915 gmbus vga] NAK for addr: 0050 w(1)
[   92.584925] [drm:drm_do_probe_ddc_edid] drm: skipping non-existent adapter i915 gmbus vga
[   92.584928] [drm:intel_crt_get_edid] CRT GMBUS EDID read failed, retry using GPIO bit-banging
[   92.584932] [drm:intel_gmbus_force_bit] enabling bit-banging on i915 gmbus vga. force bit now 1
[   92.585320] [drm:drm_do_probe_ddc_edid] drm: skipping non-existent adapter i915 gmbus vga
[   92.585323] [drm:intel_gmbus_force_bit] disabling bit-banging on i915 gmbus vga. force bit now 0
[   92.585325] [drm:intel_crt_detect_ddc] CRT not detected via DDC:0x50 [no valid EDID found]
[   92.585328] [drm:drm_helper_probe_single_connector_modes] [CONNECTOR:33:VGA-1] disconnected
[   92.585340] [drm:drm_mode_getconnector] [CONNECTOR:36:?]
[   92.585343] [drm:drm_helper_probe_single_connector_modes] [CONNECTOR:36:HDMI-A-1]
[   92.585346] [drm:intel_hdmi_detect] [CONNECTOR:36:HDMI-A-1]
[   92.610525] [drm:drm_detect_monitor_audio] Monitor has basic audio support
[   92.610668] [drm:drm_edid_to_eld] ELD monitor SyncMaster
[   92.610677] [drm:parse_hdmi_vsdb] HDMI: DVI dual 0, max TMDS clock 0, latency present 0 0, video latency 0 0, audio latency 0 0
[   92.610681] [drm:drm_edid_to_eld] ELD size 36, SAD count 1
[   92.610735] [drm:drm_helper_probe_single_connector_modes] [CONNECTOR:36:HDMI-A-1] probed modes :
[   92.610743] [drm:drm_mode_debug_printmodeline] Modeline 45:"1920x1080" 60 148500 1920 2008 2052 2200 1080 1084 1089 1125 0x48 0x5
[   92.610751] [drm:drm_mode_debug_printmodeline] Modeline 72:"1920x1080" 60 148352 1920 2008 2052 2200 1080 1084 1089 1125 0x40 0x5
[   92.610758] [drm:drm_mode_debug_printmodeline] Modeline 48:"1920x1080i" 60 74250 1920 2008 2052 2200 1080 1084 1094 1125 0x40 0x15
[   92.610764] [drm:drm_mode_debug_printmodeline] Modeline 73:"1920x1080i" 60 74176 1920 2008 2052 2200 1080 1084 1094 1125 0x40 0x15
[   92.610771] [drm:drm_mode_debug_printmodeline] Modeline 65:"1920x1080" 50 148500 1920 2448 2492 2640 1080 1084 1089 1125 0x40 0x5
[   92.610777] [drm:drm_mode_debug_printmodeline] Modeline 52:"1920x1080i" 50 74250 1920 2448 2492 2640 1080 1084 1094 1125 0x40 0x15
[   92.610784] [drm:drm_mode_debug_printmodeline] Modeline 54:"1600x1200" 60 162000 1600 1664 1856 2160 1200 1201 1204 1250 0x40 0x5
[   92.610790] [drm:drm_mode_debug_printmodeline] Modeline 59:"1680x1050" 60 119000 1680 1728 1760 1840 1050 1053 1059 1080 0x40 0x9
[   92.610797] [drm:drm_mode_debug_printmodeline] Modeline 55:"1280x1024" 60 108000 1280 1328 1440 1688 1024 1025 1028 1066 0x40 0x5
[   92.610803] [drm:drm_mode_debug_printmodeline] Modeline 58:"1440x900" 60 88750 1440 1488 1520 1600 900 903 909 926 0x40 0x9
[   92.610810] [drm:drm_mode_debug_printmodeline] Modeline 56:"1280x960" 60 108000 1280 1376 1488 1800 960 961 964 1000 0x40 0x5
[   92.610816] [drm:drm_mode_debug_printmodeline] Modeline 57:"1280x800" 60 71000 1280 1328 1360 1440 800 803 809 823 0x40 0x9
[   92.610823] [drm:drm_mode_debug_printmodeline] Modeline 49:"1280x720" 60 74250 1280 1390 1430 1650 720 725 730 750 0x40 0x5
[   92.610829] [drm:drm_mode_debug_printmodeline] Modeline 74:"1280x720" 60 74176 1280 1390 1430 1650 720 725 730 750 0x40 0x5
[   92.610835] [drm:drm_mode_debug_printmodeline] Modeline 50:"1280x720" 50 74250 1280 1720 1760 1980 720 725 730 750 0x40 0x5
[   92.610841] [drm:drm_mode_debug_printmodeline] Modeline 63:"1024x768" 60 65000 1024 1048 1184 1344 768 771 777 806 0x40 0xa
[   92.610848] [drm:drm_mode_debug_printmodeline] Modeline 60:"800x600" 60 40000 800 840 968 1056 600 601 605 628 0x40 0x5
[   92.610854] [drm:drm_mode_debug_printmodeline] Modeline 61:"800x600" 56 36000 800 824 896 1024 600 601 603 625 0x40 0x5
[   92.610860] [drm:drm_mode_debug_printmodeline] Modeline 51:"720x576" 50 27000 720 732 796 864 576 581 586 625 0x40 0xa
[   92.610866] [drm:drm_mode_debug_printmodeline] Modeline 75:"720x480" 60 27027 720 736 798 858 480 489 495 525 0x40 0xa
[   92.610873] [drm:drm_mode_debug_printmodeline] Modeline 53:"720x480" 60 27000 720 736 798 858 480 489 495 525 0x40 0xa
[   92.610879] [drm:drm_mode_debug_printmodeline] Modeline 62:"640x480" 60 25200 640 656 752 800 480 490 492 525 0x40 0xa
[   92.610885] [drm:drm_mode_debug_printmodeline] Modeline 76:"640x480" 60 25175 640 656 752 800 480 490 492 525 0x40 0xa
[   92.610913] [drm:drm_mode_getconnector] [CONNECTOR:36:?]
[   92.611157] [drm:drm_mode_getconnector] [CONNECTOR:41:?]
[   92.611170] [drm:drm_helper_probe_single_connector_modes] [CONNECTOR:41:DP-1]
[   92.611174] [drm:intel_dp_detect] [CONNECTOR:41:DP-1]
[   92.613665] [drm:intel_dp_aux_ch] dp_aux_ch timeout status 0x7143003f
[   92.616138] [drm:intel_dp_aux_ch] dp_aux_ch timeout status 0x7143003f
[   92.623479] [drm:intel_dp_aux_ch] dp_aux_ch timeout status 0x7143003f
[   92.631558] [drm:intel_dp_aux_ch] dp_aux_ch timeout status 0x7143003f
[   92.637080] [drm:drm_helper_probe_single_connector_modes] [CONNECTOR:41:DP-1] disconnected
[   92.637101] [drm:drm_mode_getconnector] [CONNECTOR:41:?]
[   92.637104] [drm:drm_helper_probe_single_connector_modes] [CONNECTOR:41:DP-1]
[   92.637107] [drm:intel_dp_detect] [CONNECTOR:41:DP-1]
[   92.639595] [drm:intel_dp_aux_ch] dp_aux_ch timeout status 0x7143003f
[   92.642075] [drm:intel_dp_aux_ch] dp_aux_ch timeout status 0x7143003f
[   92.651563] [drm:intel_dp_aux_ch] dp_aux_ch timeout status 0x7143003f
[   92.659569] [drm:intel_dp_aux_ch] dp_aux_ch timeout status 0x7143003f
[   92.665084] [drm:drm_helper_probe_single_connector_modes] [CONNECTOR:41:DP-1] disconnected
[   92.667174] [drm:intel_panel_get_backlight] get backlight PWM = 976
[   92.667206] [drm:intel_backlight_device_update_status] updating intel_backlight, brightness=976/976
[   92.667209] [drm:intel_panel_actually_set_backlight] set backlight PWM = 976
[   92.672660] [drm:drm_mode_addfb2] [FB:64]
[   92.672724] [drm:drm_mode_setcrtc] [CRTC:21:crtc-0]
[   92.672731] [drm:drm_mode_setcrtc] [CONNECTOR:27:LVDS-1]
[   92.702499] [drm:drm_mode_setcrtc] [CRTC:21:crtc-0]
[   92.702509] [drm:drm_mode_setcrtc] [CONNECTOR:36:HDMI-A-1]
[   92.702529] [drm:connected_sink_compute_bpp] [CONNECTOR:36:HDMI-A-1] checking for sink bpp constrains
[   92.702532] [drm:connected_sink_compute_bpp] clamping display bpp (was 36) to EDID reported max of 24
[   92.702537] [drm:intel_hdmi_compute_config] picking bpc to 8 for HDMI output
[   92.702539] [drm:intel_hdmi_compute_config] forcing pipe bpc to 24 for HDMI
[   92.702542] [drm:ironlake_check_fdi_lanes] checking fdi config on pipe A, lanes 2
[   92.702545] [drm:intel_modeset_pipe_config] hw max bpp: 36, pipe bpp: 24, dithering: 0
[   92.702549] [drm:intel_dump_pipe_config] [CRTC:21][modeset] config ffff8800371e6800 for pipe A
[   92.702551] [drm:intel_dump_pipe_config] cpu_transcoder: A
[   92.702553] [drm:intel_dump_pipe_config] pipe bpp: 24, dithering: 0
[   92.702556] [drm:intel_dump_pipe_config] fdi/pch: 1, lanes: 2, gmch_m: 6920601, gmch_n: 8388608, link_m: 288358, link_n: 524288, tu: 64
[   92.702559] [drm:intel_dump_pipe_config] dp: 0, lanes: 0, gmch_m: 0, gmch_n: 0, link_m: 0, link_n: 0, tu: 0
[   92.702562] [drm:intel_dump_pipe_config] dp: 0, lanes: 0, gmch_m2: 0, gmch_n2: 0, link_m2: 0, link_n2: 0, tu2: 0
[   92.702564] [drm:intel_dump_pipe_config] audio: 1, infoframes: 1
[   92.702566] [drm:intel_dump_pipe_config] requested mode:
[   92.702570] [drm:drm_mode_debug_printmodeline] Modeline 0:"" 0 148500 1920 2008 2052 2200 1080 1084 1089 1125 0x0 0x5
[   92.702572] [drm:intel_dump_pipe_config] adjusted mode:
[   92.702575] [drm:drm_mode_debug_printmodeline] Modeline 0:"" 0 148500 1920 2008 2052 2200 1080 1084 1089 1125 0x0 0x5
[   92.702578] [drm:intel_dump_crtc_timings] crtc timings: 148500 1920 2008 2052 2200 1080 1084 1089 1125, type: 0x0 flags: 0x5
[   92.702580] [drm:intel_dump_pipe_config] port clock: 148500
[   92.702583] [drm:intel_dump_pipe_config] pipe src size: 1920x1080
[   92.702585] [drm:intel_dump_pipe_config] num_scalers: 0, scaler_users: 0x0, scaler_id: 0
[   92.702587] [drm:intel_dump_pipe_config] gmch pfit: control: 0x00000000, ratios: 0x00000000, lvds border: 0x00000000
[   92.702590] [drm:intel_dump_pipe_config] pch pfit: pos: 0x00000000, size: 0x00000000, disabled
[   92.702592] [drm:intel_dump_pipe_config] ips: 0
[   92.702594] [drm:intel_dump_pipe_config] double wide: 0
[   92.702596] [drm:intel_dump_pipe_config] dpll_hw_state: dpll: 0x88046004, dpll_md: 0x0, fp0: 0x21007, fp1: 0x21007
[   92.702598] [drm:intel_dump_pipe_config] planes on this crtc
[   92.702601] [drm:intel_dump_pipe_config] STANDARD PLANE:18 plane: 0.0 idx: 0 enabled
[   92.702604] [drm:intel_dump_pipe_config] 	FB:64, fb = 3286x1080 format = 0x34325258
[   92.702607] [drm:intel_dump_pipe_config] 	scaler:0 src (0, 0) 1366x768 dst (0, 0) 1366x768
[   92.702610] [drm:intel_dump_pipe_config] CURSOR PLANE:20 plane: 0.1 idx: 1 disabled, scaler_id = 0
[   92.702613] [drm:intel_dump_pipe_config] STANDARD PLANE:22 plane: 0.1 idx: 2 disabled, scaler_id = 0
[   92.702655] [drm:intel_get_shared_dpll] CRTC:21 allocated PCH DPLL A
[   92.702657] [drm:intel_get_shared_dpll] using PCH DPLL A for pipe A
[   92.702680] [drm:intel_panel_actually_set_backlight] set backlight PWM = 0
[   92.702689] [drm:intel_disable_pipe] disabling pipe A
[   92.985917] [drm:intel_disable_shared_dpll] disable PCH DPLL A (active 1, on? 1) for crtc 21
[   92.985931] [drm:intel_disable_shared_dpll] disabling PCH DPLL A
[   92.986158] [drm:intel_prepare_shared_dpll] setting up PCH DPLL A
[   92.986772] [drm:intel_enable_pipe] enabling pipe A
[   92.987585] [drm:gen6_fdi_link_train] FDI_RX_IIR 0x100
[   92.987589] [drm:gen6_fdi_link_train] FDI train 1 done.
[   92.988241] [drm:gen6_fdi_link_train] FDI_RX_IIR 0x600
[   92.988245] [drm:gen6_fdi_link_train] FDI train 2 done.
[   92.988247] [drm:gen6_fdi_link_train] FDI train done.
[   92.988254] [drm:intel_enable_shared_dpll] enable PCH DPLL A (active 0, on? 0) for crtc 21
[   92.988257] [drm:intel_enable_shared_dpll] enabling PCH DPLL A
[   92.989638] [drm:intel_enable_hdmi_audio] Enabling HDMI audio on pipe A
[   92.989648] [drm:intel_audio_codec_enable] ELD on [CONNECTOR:36:HDMI-A-1], [ENCODER:35:TMDS-35]
[   92.989653] [drm:ilk_audio_codec_enable] Enable audio codec on port B, pipe A, 36 bytes ELD
[   92.989670] [drm:audio_config_hdmi_pixel_clock] Configuring HDMI audio for pixel clock 148500 (0x00090000)
[   93.023157] [drm:intel_connector_check_state] [CONNECTOR:27:LVDS-1]
[   93.023171] [drm:intel_connector_check_state] [CONNECTOR:36:HDMI-A-1]
[   93.023178] [drm:check_encoder_state] [ENCODER:28:LVDS-28]
[   93.023185] [drm:check_encoder_state] [ENCODER:34:DAC-34]
[   93.023189] [drm:check_encoder_state] [ENCODER:35:TMDS-35]
[   93.023193] [drm:check_encoder_state] [ENCODER:40:TMDS-40]
[   93.023204] [drm:check_crtc_state] [CRTC:21]
[   93.023231] [drm:check_shared_dpll_state] PCH DPLL A
[   93.023238] [drm:check_shared_dpll_state] PCH DPLL B
[   93.023415] [drm:intel_panel_get_backlight] get backlight PWM = 0
[   93.023462] [drm:intel_backlight_device_update_status] updating intel_backlight, brightness=0/976
[   93.025919] [drm:drm_mode_setcrtc] [CRTC:25:crtc-1]
[   93.025934] [drm:drm_mode_setcrtc] [CONNECTOR:27:LVDS-1]
[   93.025962] [drm:connected_sink_compute_bpp] [CONNECTOR:27:LVDS-1] checking for sink bpp constrains
[   93.025967] [drm:connected_sink_compute_bpp] clamping display bpp (was 36) to default limit of 24
[   93.025972] [drm:intel_lvds_compute_config] forcing display bpp (was 24) to LVDS (18)
[   93.025979] [drm:ironlake_check_fdi_lanes] checking fdi config on pipe B, lanes 1
[   93.025984] [drm:intel_modeset_pipe_config] hw max bpp: 36, pipe bpp: 18, dithering: 1
[   93.025990] [drm:intel_dump_pipe_config] [CRTC:25][modeset] config ffff88008d917c00 for pipe B
[   93.025994] [drm:intel_dump_pipe_config] cpu_transcoder: B
[   93.025998] [drm:intel_dump_pipe_config] pipe bpp: 18, dithering: 1
[   93.026004] [drm:intel_dump_pipe_config] fdi/pch: 1, lanes: 1, gmch_m: 2481629, gmch_n: 4194304, link_m: 137868, link_n: 524288, tu: 64
[   93.026009] [drm:intel_dump_pipe_config] dp: 0, lanes: 0, gmch_m: 0, gmch_n: 0, link_m: 0, link_n: 0, tu: 0
[   93.026015] [drm:intel_dump_pipe_config] dp: 0, lanes: 0, gmch_m2: 0, gmch_n2: 0, link_m2: 0, link_n2: 0, tu2: 0
[   93.026019] [drm:intel_dump_pipe_config] audio: 0, infoframes: 0
[   93.026022] [drm:intel_dump_pipe_config] requested mode:
[   93.026029] [drm:drm_mode_debug_printmodeline] Modeline 0:"" 0 71000 1366 1407 1434 1500 768 771 775 788 0x0 0xa
[   93.026033] [drm:intel_dump_pipe_config] adjusted mode:
[   93.026040] [drm:drm_mode_debug_printmodeline] Modeline 0:"1366x768" 60 71000 1366 1407 1434 1500 768 771 775 788 0x48 0xa
[   93.026046] [drm:intel_dump_crtc_timings] crtc timings: 71000 1366 1407 1434 1500 768 771 775 788, type: 0x48 flags: 0xa
[   93.026050] [drm:intel_dump_pipe_config] port clock: 71000
[   93.026054] [drm:intel_dump_pipe_config] pipe src size: 1366x768
[   93.026058] [drm:intel_dump_pipe_config] num_scalers: 0, scaler_users: 0x0, scaler_id: 0
[   93.026063] [drm:intel_dump_pipe_config] gmch pfit: control: 0x00000000, ratios: 0x00000000, lvds border: 0x00000000
[   93.026067] [drm:intel_dump_pipe_config] pch pfit: pos: 0x00000000, size: 0x00000000, disabled
[   93.026071] [drm:intel_dump_pipe_config] ips: 0
[   93.026074] [drm:intel_dump_pipe_config] double wide: 0
[   93.026079] [drm:intel_dump_pipe_config] dpll_hw_state: dpll: 0x0, dpll_md: 0x0, fp0: 0x0, fp1: 0x0
[   93.026087] [drm:intel_dump_pipe_config] planes on this crtc
[   93.026092] [drm:intel_dump_pipe_config] STANDARD PLANE:23 plane: 1.0 idx: 3 disabled, scaler_id = 0
[   93.026097] [drm:intel_dump_pipe_config] CURSOR PLANE:24 plane: 1.2 idx: 4 disabled, scaler_id = 0
[   93.026102] [drm:intel_dump_pipe_config] STANDARD PLANE:26 plane: 1.1 idx: 5 disabled, scaler_id = 0
[   93.026113] [drm:ironlake_get_refclk] using SSC reference clock of 120000 kHz
[   93.026175] [drm:intel_get_shared_dpll] CRTC:25 allocated PCH DPLL B
[   93.026179] [drm:intel_get_shared_dpll] using PCH DPLL B for pipe B
[   93.026211] [drm:intel_prepare_shared_dpll] setting up PCH DPLL B
[   93.026802] [drm:intel_enable_pipe] enabling pipe B
[   93.027615] [drm:gen6_fdi_link_train] FDI_RX_IIR 0x100
[   93.027619] [drm:gen6_fdi_link_train] FDI train 1 done.
[   93.028272] [drm:gen6_fdi_link_train] FDI_RX_IIR 0x600
[   93.028276] [drm:gen6_fdi_link_train] FDI train 2 done.
[   93.028279] [drm:gen6_fdi_link_train] FDI train done.
[   93.028286] [drm:intel_enable_shared_dpll] enable PCH DPLL B (active 0, on? 0) for crtc 25
[   93.028290] [drm:intel_enable_shared_dpll] enabling PCH DPLL B
[   93.454175] [drm:intel_panel_enable_backlight] pipe B
[   93.454191] [drm:intel_panel_actually_set_backlight] set backlight PWM = 976
[   93.499000] [drm:intel_connector_check_state] [CONNECTOR:27:LVDS-1]
[   93.499014] [drm:check_encoder_state] [ENCODER:28:LVDS-28]
[   93.499019] [drm:check_encoder_state] [ENCODER:34:DAC-34]
[   93.499025] [drm:check_encoder_state] [ENCODER:35:TMDS-35]
[   93.499028] [drm:check_encoder_state] [ENCODER:40:TMDS-40]
[   93.499036] [drm:check_crtc_state] [CRTC:25]
[   93.499060] [drm:check_shared_dpll_state] PCH DPLL A
[   93.499068] [drm:check_shared_dpll_state] PCH DPLL B
[   93.499199] [drm:intel_backlight_device_update_status] updating intel_backlight, brightness=0/976
[   93.499205] [drm:intel_panel_actually_set_backlight] set backlight PWM = 0
[   93.529077] [drm:intel_panel_get_backlight] get backlight PWM = 0
[   93.529121] [drm:intel_backlight_device_update_status] updating intel_backlight, brightness=0/976
[   93.529126] [drm:intel_panel_actually_set_backlight] set backlight PWM = 0
[   93.569022] [drm:intel_panel_get_backlight] get backlight PWM = 0
[   93.569096] [drm:intel_backlight_device_update_status] updating intel_backlight, brightness=0/976
[   93.569101] [drm:intel_panel_actually_set_backlight] set backlight PWM = 0
[   93.606699] [drm:drm_mode_getconnector] [CONNECTOR:27:?]
[   93.606707] [drm:drm_helper_probe_single_connector_modes] [CONNECTOR:27:LVDS-1]
[   93.606710] [drm:intel_lvds_detect] [CONNECTOR:27:LVDS-1]
[   93.606727] [drm:drm_helper_probe_single_connector_modes] [CONNECTOR:27:LVDS-1] probed modes :
[   93.606731] [drm:drm_mode_debug_printmodeline] Modeline 30:"1366x768" 60 71000 1366 1407 1434 1500 768 771 775 788 0x48 0xa
[   93.606737] [drm:drm_mode_getconnector] [CONNECTOR:27:?]
[   93.607174] [drm:drm_mode_getconnector] [CONNECTOR:33:?]
[   93.607181] [drm:drm_helper_probe_single_connector_modes] [CONNECTOR:33:VGA-1]
[   93.607185] [drm:intel_crt_detect] [CONNECTOR:33:VGA-1] force=1
[   93.607193] [drm:intel_ironlake_crt_detect_hotplug] ironlake hotplug adpa=0xf40000, result 0
[   93.607197] [drm:intel_crt_detect] CRT not detected via hotplug
[   93.607398] [drm:do_gmbus_xfer] GMBUS [i915 gmbus vga] NAK for addr: 0050 w(1)
[   93.607402] [drm:do_gmbus_xfer] GMBUS [i915 gmbus vga] NAK on first message, retry
[   93.607574] [drm:do_gmbus_xfer] GMBUS [i915 gmbus vga] NAK for addr: 0050 w(1)
[   93.607580] [drm:drm_do_probe_ddc_edid] drm: skipping non-existent adapter i915 gmbus vga
[   93.607584] [drm:intel_crt_get_edid] CRT GMBUS EDID read failed, retry using GPIO bit-banging
[   93.607588] [drm:intel_gmbus_force_bit] enabling bit-banging on i915 gmbus vga. force bit now 1
[   93.607946] [drm:drm_do_probe_ddc_edid] drm: skipping non-existent adapter i915 gmbus vga
[   93.607951] [drm:intel_gmbus_force_bit] disabling bit-banging on i915 gmbus vga. force bit now 0
[   93.607955] [drm:intel_crt_detect_ddc] CRT not detected via DDC:0x50 [no valid EDID found]
[   93.607960] [drm:drm_helper_probe_single_connector_modes] [CONNECTOR:33:VGA-1] disconnected
[   93.607969] [drm:drm_mode_getconnector] [CONNECTOR:33:?]
[   93.607973] [drm:drm_helper_probe_single_connector_modes] [CONNECTOR:33:VGA-1]
[   93.607977] [drm:intel_crt_detect] [CONNECTOR:33:VGA-1] force=1
[   93.607982] [drm:intel_ironlake_crt_detect_hotplug] ironlake hotplug adpa=0xf40000, result 0
[   93.607985] [drm:intel_crt_detect] CRT not detected via hotplug
[   93.608165] [drm:do_gmbus_xfer] GMBUS [i915 gmbus vga] NAK for addr: 0050 w(1)
[   93.608168] [drm:do_gmbus_xfer] GMBUS [i915 gmbus vga] NAK on first message, retry
[   93.608375] [drm:do_gmbus_xfer] GMBUS [i915 gmbus vga] NAK for addr: 0050 w(1)
[   93.608380] [drm:drm_do_probe_ddc_edid] drm: skipping non-existent adapter i915 gmbus vga
[   93.608384] [drm:intel_crt_get_edid] CRT GMBUS EDID read failed, retry using GPIO bit-banging
[   93.608388] [drm:intel_gmbus_force_bit] enabling bit-banging on i915 gmbus vga. force bit now 1
[   93.608748] [drm:drm_do_probe_ddc_edid] drm: skipping non-existent adapter i915 gmbus vga
[   93.608750] [drm:intel_gmbus_force_bit] disabling bit-banging on i915 gmbus vga. force bit now 0
[   93.608752] [drm:intel_crt_detect_ddc] CRT not detected via DDC:0x50 [no valid EDID found]
[   93.608754] [drm:drm_helper_probe_single_connector_modes] [CONNECTOR:33:VGA-1] disconnected
[   93.608769] [drm:drm_mode_getconnector] [CONNECTOR:36:?]
[   93.608772] [drm:drm_helper_probe_single_connector_modes] [CONNECTOR:36:HDMI-A-1]
[   93.608778] [drm:intel_hdmi_detect] [CONNECTOR:36:HDMI-A-1]
[   93.634074] [drm:drm_detect_monitor_audio] Monitor has basic audio support
[   93.634174] [drm:drm_edid_to_eld] ELD monitor SyncMaster
[   93.634180] [drm:parse_hdmi_vsdb] HDMI: DVI dual 0, max TMDS clock 0, latency present 0 0, video latency 0 0, audio latency 0 0
[   93.634183] [drm:drm_edid_to_eld] ELD size 36, SAD count 1
[   93.634229] [drm:drm_helper_probe_single_connector_modes] [CONNECTOR:36:HDMI-A-1] probed modes :
[   93.634235] [drm:drm_mode_debug_printmodeline] Modeline 45:"1920x1080" 60 148500 1920 2008 2052 2200 1080 1084 1089 1125 0x48 0x5
[   93.634239] [drm:drm_mode_debug_printmodeline] Modeline 72:"1920x1080" 60 148352 1920 2008 2052 2200 1080 1084 1089 1125 0x40 0x5
[   93.634244] [drm:drm_mode_debug_printmodeline] Modeline 48:"1920x1080i" 60 74250 1920 2008 2052 2200 1080 1084 1094 1125 0x40 0x15
[   93.634248] [drm:drm_mode_debug_printmodeline] Modeline 73:"1920x1080i" 60 74176 1920 2008 2052 2200 1080 1084 1094 1125 0x40 0x15
[   93.634253] [drm:drm_mode_debug_printmodeline] Modeline 65:"1920x1080" 50 148500 1920 2448 2492 2640 1080 1084 1089 1125 0x40 0x5
[   93.634257] [drm:drm_mode_debug_printmodeline] Modeline 52:"1920x1080i" 50 74250 1920 2448 2492 2640 1080 1084 1094 1125 0x40 0x15
[   93.634261] [drm:drm_mode_debug_printmodeline] Modeline 54:"1600x1200" 60 162000 1600 1664 1856 2160 1200 1201 1204 1250 0x40 0x5
[   93.634265] [drm:drm_mode_debug_printmodeline] Modeline 59:"1680x1050" 60 119000 1680 1728 1760 1840 1050 1053 1059 1080 0x40 0x9
[   93.634270] [drm:drm_mode_debug_printmodeline] Modeline 55:"1280x1024" 60 108000 1280 1328 1440 1688 1024 1025 1028 1066 0x40 0x5
[   93.634274] [drm:drm_mode_debug_printmodeline] Modeline 58:"1440x900" 60 88750 1440 1488 1520 1600 900 903 909 926 0x40 0x9
[   93.634278] [drm:drm_mode_debug_printmodeline] Modeline 56:"1280x960" 60 108000 1280 1376 1488 1800 960 961 964 1000 0x40 0x5
[   93.634283] [drm:drm_mode_debug_printmodeline] Modeline 57:"1280x800" 60 71000 1280 1328 1360 1440 800 803 809 823 0x40 0x9
[   93.634287] [drm:drm_mode_debug_printmodeline] Modeline 49:"1280x720" 60 74250 1280 1390 1430 1650 720 725 730 750 0x40 0x5
[   93.634291] [drm:drm_mode_debug_printmodeline] Modeline 74:"1280x720" 60 74176 1280 1390 1430 1650 720 725 730 750 0x40 0x5
[   93.634296] [drm:drm_mode_debug_printmodeline] Modeline 50:"1280x720" 50 74250 1280 1720 1760 1980 720 725 730 750 0x40 0x5
[   93.634300] [drm:drm_mode_debug_printmodeline] Modeline 63:"1024x768" 60 65000 1024 1048 1184 1344 768 771 777 806 0x40 0xa
[   93.634304] [drm:drm_mode_debug_printmodeline] Modeline 60:"800x600" 60 40000 800 840 968 1056 600 601 605 628 0x40 0x5
[   93.634308] [drm:drm_mode_debug_printmodeline] Modeline 61:"800x600" 56 36000 800 824 896 1024 600 601 603 625 0x40 0x5
[   93.634312] [drm:drm_mode_debug_printmodeline] Modeline 51:"720x576" 50 27000 720 732 796 864 576 581 586 625 0x40 0xa
[   93.634316] [drm:drm_mode_debug_printmodeline] Modeline 75:"720x480" 60 27027 720 736 798 858 480 489 495 525 0x40 0xa
[   93.634320] [drm:drm_mode_debug_printmodeline] Modeline 53:"720x480" 60 27000 720 736 798 858 480 489 495 525 0x40 0xa
[   93.634324] [drm:drm_mode_debug_printmodeline] Modeline 62:"640x480" 60 25200 640 656 752 800 480 490 492 525 0x40 0xa
[   93.634328] [drm:drm_mode_debug_printmodeline] Modeline 76:"640x480" 60 25175 640 656 752 800 480 490 492 525 0x40 0xa
[   93.634359] [drm:drm_mode_getconnector] [CONNECTOR:36:?]
[   93.634544] [drm:drm_mode_getconnector] [CONNECTOR:41:?]
[   93.634547] [drm:drm_helper_probe_single_connector_modes] [CONNECTOR:41:DP-1]
[   93.634550] [drm:intel_dp_detect] [CONNECTOR:41:DP-1]
[   93.637017] [drm:intel_dp_aux_ch] dp_aux_ch timeout status 0x7143003f
[   93.639486] [drm:intel_dp_aux_ch] dp_aux_ch timeout status 0x7143003f
[   93.647561] [drm:intel_dp_aux_ch] dp_aux_ch timeout status 0x7143003f
[   93.655636] [drm:intel_dp_aux_ch] dp_aux_ch timeout status 0x7143003f
[   93.661135] [drm:drm_helper_probe_single_connector_modes] [CONNECTOR:41:DP-1] disconnected
[   93.661169] [drm:drm_mode_getconnector] [CONNECTOR:41:?]
[   93.661173] [drm:drm_helper_probe_single_connector_modes] [CONNECTOR:41:DP-1]
[   93.661176] [drm:intel_dp_detect] [CONNECTOR:41:DP-1]
[   93.663651] [drm:intel_dp_aux_ch] dp_aux_ch timeout status 0x7143003f
[   93.666120] [drm:intel_dp_aux_ch] dp_aux_ch timeout status 0x7143003f
[   93.675646] [drm:intel_dp_aux_ch] dp_aux_ch timeout status 0x7143003f
[   93.683639] [drm:intel_dp_aux_ch] dp_aux_ch timeout status 0x7143003f
[   93.689180] [drm:drm_helper_probe_single_connector_modes] [CONNECTOR:41:DP-1] disconnected
[   93.691678] [drm:intel_panel_get_backlight] get backlight PWM = 0
[   93.691710] [drm:intel_backlight_device_update_status] updating intel_backlight, brightness=0/976
[   93.691713] [drm:intel_panel_actually_set_backlight] set backlight PWM = 0
[   93.845507] [drm:drm_mode_addfb2] [FB:43]
[   93.882939] [drm:drm_mode_addfb2] [FB:64]
[   93.915094] [drm:drm_mode_addfb2] [FB:43]
[   93.940384] [drm:drm_mode_addfb2] [FB:64]
[   93.956454] [drm:drm_mode_addfb2] [FB:43]
[   94.119363] [drm:drm_mode_addfb2] [FB:64]
[   94.722051] [drm:drm_mode_addfb2] [FB:43]
[   97.874217] [drm:intel_panel_get_backlight] get backlight PWM = 0
[   97.874251] [drm:intel_backlight_device_update_status] updating intel_backlight, brightness=0/976
[   97.874254] [drm:intel_panel_actually_set_backlight] set backlight PWM = 0
[   97.874332] [drm:connected_sink_compute_bpp] [CONNECTOR:27:LVDS-1] checking for sink bpp constrains
[   97.874335] [drm:connected_sink_compute_bpp] clamping display bpp (was 36) to default limit of 24
[   97.874339] [drm:intel_lvds_compute_config] forcing display bpp (was 24) to LVDS (18)
[   97.874343] [drm:ironlake_check_fdi_lanes] checking fdi config on pipe B, lanes 1
[   97.874345] [drm:intel_modeset_pipe_config] hw max bpp: 36, pipe bpp: 18, dithering: 1
[   97.874349] [drm:intel_dump_pipe_config] [CRTC:25][modeset] config ffff880243cb5400 for pipe B
[   97.874351] [drm:intel_dump_pipe_config] cpu_transcoder: B
[   97.874353] [drm:intel_dump_pipe_config] pipe bpp: 18, dithering: 1
[   97.874356] [drm:intel_dump_pipe_config] fdi/pch: 1, lanes: 1, gmch_m: 2481629, gmch_n: 4194304, link_m: 137868, link_n: 524288, tu: 64
[   97.874359] [drm:intel_dump_pipe_config] dp: 0, lanes: 0, gmch_m: 0, gmch_n: 0, link_m: 0, link_n: 0, tu: 0
[   97.874361] [drm:intel_dump_pipe_config] dp: 0, lanes: 0, gmch_m2: 0, gmch_n2: 0, link_m2: 0, link_n2: 0, tu2: 0
[   97.874363] [drm:intel_dump_pipe_config] audio: 0, infoframes: 0
[   97.874365] [drm:intel_dump_pipe_config] requested mode:
[   97.874369] [drm:drm_mode_debug_printmodeline] Modeline 0:"" 0 71000 1366 1407 1434 1500 768 771 775 788 0x0 0xa
[   97.874371] [drm:intel_dump_pipe_config] adjusted mode:
[   97.874375] [drm:drm_mode_debug_printmodeline] Modeline 0:"1366x768" 60 71000 1366 1407 1434 1500 768 771 775 788 0x48 0xa
[   97.874378] [drm:intel_dump_crtc_timings] crtc timings: 71000 1366 1407 1434 1500 768 771 775 788, type: 0x48 flags: 0xa
[   97.874380] [drm:intel_dump_pipe_config] port clock: 71000
[   97.874382] [drm:intel_dump_pipe_config] pipe src size: 1366x768
[   97.874385] [drm:intel_dump_pipe_config] num_scalers: 0, scaler_users: 0x0, scaler_id: 0
[   97.874387] [drm:intel_dump_pipe_config] gmch pfit: control: 0x00000000, ratios: 0x00000000, lvds border: 0x00000000
[   97.874390] [drm:intel_dump_pipe_config] pch pfit: pos: 0x00000000, size: 0x00000000, disabled
[   97.874391] [drm:intel_dump_pipe_config] ips: 0
[   97.874393] [drm:intel_dump_pipe_config] double wide: 0
[   97.874396] [drm:intel_dump_pipe_config] dpll_hw_state: dpll: 0x88046004, dpll_md: 0x0, fp0: 0x21007, fp1: 0x21007
[   97.874398] [drm:intel_dump_pipe_config] planes on this crtc
[   97.874400] [drm:intel_dump_pipe_config] STANDARD PLANE:23 plane: 1.0 idx: 3 enabled
[   97.874404] [drm:intel_dump_pipe_config] 	FB:43, fb = 3286x1080 format = 0x34325258
[   97.874407] [drm:intel_dump_pipe_config] 	scaler:0 src (0, 312) 1366x768 dst (0, 0) 1366x768
[   97.874410] [drm:intel_dump_pipe_config] CURSOR PLANE:24 plane: 1.2 idx: 4 disabled, scaler_id = 0
[   97.874413] [drm:intel_dump_pipe_config] STANDARD PLANE:26 plane: 1.1 idx: 5 disabled, scaler_id = 0
[   97.874420] [drm:ironlake_get_refclk] using SSC reference clock of 120000 kHz
[   97.874454] [drm:intel_get_shared_dpll] CRTC:25 allocated PCH DPLL B
[   97.874456] [drm:intel_get_shared_dpll] using PCH DPLL B for pipe B
[   97.875297] [drm:intel_panel_actually_set_backlight] set backlight PWM = 0
[   97.875307] [drm:intel_disable_pipe] disabling pipe B
[   98.158167] [drm:intel_disable_shared_dpll] disable PCH DPLL B (active 1, on? 1) for crtc 25
[   98.158183] [drm:intel_disable_shared_dpll] disabling PCH DPLL B
[   98.158424] [drm:intel_connector_check_state] [CONNECTOR:27:LVDS-1]
[   98.158431] [drm:check_encoder_state] [ENCODER:28:LVDS-28]
[   98.158437] [drm:check_encoder_state] [ENCODER:34:DAC-34]
[   98.158443] [drm:check_encoder_state] [ENCODER:35:TMDS-35]
[   98.158447] [drm:check_encoder_state] [ENCODER:40:TMDS-40]
[   98.158454] [drm:check_crtc_state] [CRTC:25]
[   98.158461] [drm:check_shared_dpll_state] PCH DPLL A
[   98.158468] [drm:check_shared_dpll_state] PCH DPLL B
[   98.159765] [drm:intel_backlight_device_update_status] updating intel_backlight, brightness=0/976
[   98.159990] [drm:connected_sink_compute_bpp] [CONNECTOR:36:HDMI-A-1] checking for sink bpp constrains
[   98.159996] [drm:connected_sink_compute_bpp] clamping display bpp (was 36) to EDID reported max of 24
[   98.160003] [drm:intel_hdmi_compute_config] picking bpc to 8 for HDMI output
[   98.160007] [drm:intel_hdmi_compute_config] forcing pipe bpc to 24 for HDMI
[   98.160012] [drm:ironlake_check_fdi_lanes] checking fdi config on pipe A, lanes 2
[   98.160017] [drm:intel_modeset_pipe_config] hw max bpp: 36, pipe bpp: 24, dithering: 0
[   98.160023] [drm:intel_dump_pipe_config] [CRTC:21][modeset] config ffff880243cb5400 for pipe A
[   98.160026] [drm:intel_dump_pipe_config] cpu_transcoder: A
[   98.160029] [drm:intel_dump_pipe_config] pipe bpp: 24, dithering: 0
[   98.160035] [drm:intel_dump_pipe_config] fdi/pch: 1, lanes: 2, gmch_m: 6920601, gmch_n: 8388608, link_m: 288358, link_n: 524288, tu: 64
[   98.160040] [drm:intel_dump_pipe_config] dp: 0, lanes: 0, gmch_m: 0, gmch_n: 0, link_m: 0, link_n: 0, tu: 0
[   98.160045] [drm:intel_dump_pipe_config] dp: 0, lanes: 0, gmch_m2: 0, gmch_n2: 0, link_m2: 0, link_n2: 0, tu2: 0
[   98.160048] [drm:intel_dump_pipe_config] audio: 1, infoframes: 1
[   98.160051] [drm:intel_dump_pipe_config] requested mode:
[   98.160058] [drm:drm_mode_debug_printmodeline] Modeline 0:"" 0 148500 1920 2008 2052 2200 1080 1084 1089 1125 0x0 0x5
[   98.160061] [drm:intel_dump_pipe_config] adjusted mode:
[   98.160066] [drm:drm_mode_debug_printmodeline] Modeline 0:"" 0 148500 1920 2008 2052 2200 1080 1084 1089 1125 0x0 0x5
[   98.160072] [drm:intel_dump_crtc_timings] crtc timings: 148500 1920 2008 2052 2200 1080 1084 1089 1125, type: 0x0 flags: 0x5
[   98.160075] [drm:intel_dump_pipe_config] port clock: 148500
[   98.160079] [drm:intel_dump_pipe_config] pipe src size: 1920x1080
[   98.160082] [drm:intel_dump_pipe_config] num_scalers: 0, scaler_users: 0x0, scaler_id: 0
[   98.160087] [drm:intel_dump_pipe_config] gmch pfit: control: 0x00000000, ratios: 0x00000000, lvds border: 0x00000000
[   98.160091] [drm:intel_dump_pipe_config] pch pfit: pos: 0x00000000, size: 0x00000000, disabled
[   98.160094] [drm:intel_dump_pipe_config] ips: 0
[   98.160097] [drm:intel_dump_pipe_config] double wide: 0
[   98.160101] [drm:intel_dump_pipe_config] dpll_hw_state: dpll: 0xc4020002, dpll_md: 0x0, fp0: 0x21007, fp1: 0x21007
[   98.160104] [drm:intel_dump_pipe_config] planes on this crtc
[   98.160109] [drm:intel_dump_pipe_config] STANDARD PLANE:18 plane: 0.0 idx: 0 enabled
[   98.160114] [drm:intel_dump_pipe_config] 	FB:43, fb = 3286x1080 format = 0x34325258
[   98.160120] [drm:intel_dump_pipe_config] 	scaler:0 src (1366, 0) 1920x1080 dst (0, 0) 1920x1080
[   98.160124] [drm:intel_dump_pipe_config] CURSOR PLANE:20 plane: 0.1 idx: 1 enabled
[   98.160128] [drm:intel_dump_pipe_config] 	FB:46, fb = 64x64 format = 0x34325241
[   98.160133] [drm:intel_dump_pipe_config] 	scaler:0 src (0, 0) 64x64 dst (7, 280) 64x64
[   98.160139] [drm:intel_dump_pipe_config] STANDARD PLANE:22 plane: 0.1 idx: 2 disabled, scaler_id = 0
[   98.160248] [drm:intel_get_shared_dpll] CRTC:21 allocated PCH DPLL A
[   98.160253] [drm:intel_get_shared_dpll] using PCH DPLL A for pipe A
[   98.160284] [drm:ilk_audio_codec_disable] Disable audio codec on port B, pipe A
[   98.160310] [drm:intel_disable_pipe] disabling pipe A
[   98.190305] [drm:intel_disable_shared_dpll] disable PCH DPLL A (active 1, on? 1) for crtc 21
[   98.190319] [drm:intel_disable_shared_dpll] disabling PCH DPLL A
[   98.190542] [drm:intel_power_well_disable] disabling always-on
[   98.190548] [drm:intel_power_well_enable] enabling always-on
[   98.190555] [drm:intel_power_well_disable] disabling always-on
[   98.190568] [drm:intel_connector_check_state] [CONNECTOR:36:HDMI-A-1]
[   98.190575] [drm:check_encoder_state] [ENCODER:28:LVDS-28]
[   98.190580] [drm:check_encoder_state] [ENCODER:34:DAC-34]
[   98.190585] [drm:check_encoder_state] [ENCODER:35:TMDS-35]
[   98.190589] [drm:check_encoder_state] [ENCODER:40:TMDS-40]
[   98.190595] [drm:check_crtc_state] [CRTC:21]
[   98.190601] [drm:check_shared_dpll_state] PCH DPLL A
[   98.190608] [drm:check_shared_dpll_state] PCH DPLL B
[   98.194957] [drm:drm_mode_addfb2] [FB:64]
[   98.197689] [drm:drm_mode_setcrtc] [CRTC:25:crtc-1]
[   98.197700] [drm:drm_mode_setcrtc] [CONNECTOR:36:HDMI-A-1]
[   98.197725] [drm:connected_sink_compute_bpp] [CONNECTOR:36:HDMI-A-1] checking for sink bpp constrains
[   98.197727] [drm:connected_sink_compute_bpp] clamping display bpp (was 36) to EDID reported max of 24
[   98.197734] [drm:intel_hdmi_compute_config] picking bpc to 8 for HDMI output
[   98.197736] [drm:intel_hdmi_compute_config] forcing pipe bpc to 24 for HDMI
[   98.197740] [drm:ironlake_check_fdi_lanes] checking fdi config on pipe B, lanes 1
[   98.197742] [drm:intel_modeset_pipe_config] hw max bpp: 36, pipe bpp: 24, dithering: 0
[   98.197746] [drm:intel_dump_pipe_config] [CRTC:25][modeset] config ffff88009863d400 for pipe B
[   98.197748] [drm:intel_dump_pipe_config] cpu_transcoder: B
[   98.197750] [drm:intel_dump_pipe_config] pipe bpp: 24, dithering: 0
[   98.197753] [drm:intel_dump_pipe_config] fdi/pch: 1, lanes: 1, gmch_m: 3029219, gmch_n: 4194304, link_m: 126217, link_n: 524288, tu: 64
[   98.197756] [drm:intel_dump_pipe_config] dp: 0, lanes: 0, gmch_m: 0, gmch_n: 0, link_m: 0, link_n: 0, tu: 0
[   98.197759] [drm:intel_dump_pipe_config] dp: 0, lanes: 0, gmch_m2: 0, gmch_n2: 0, link_m2: 0, link_n2: 0, tu2: 0
[   98.197761] [drm:intel_dump_pipe_config] audio: 1, infoframes: 1
[   98.197763] [drm:intel_dump_pipe_config] requested mode:
[   98.197767] [drm:drm_mode_debug_printmodeline] Modeline 0:"" 0 65000 1024 1048 1184 1344 768 771 777 806 0x0 0xa
[   98.197769] [drm:intel_dump_pipe_config] adjusted mode:
[   98.197772] [drm:drm_mode_debug_printmodeline] Modeline 0:"" 0 65000 1024 1048 1184 1344 768 771 777 806 0x0 0xa
[   98.197775] [drm:intel_dump_crtc_timings] crtc timings: 65000 1024 1048 1184 1344 768 771 777 806, type: 0x0 flags: 0xa
[   98.197777] [drm:intel_dump_pipe_config] port clock: 65000
[   98.197780] [drm:intel_dump_pipe_config] pipe src size: 1024x768
[   98.197782] [drm:intel_dump_pipe_config] num_scalers: 0, scaler_users: 0x0, scaler_id: 0
[   98.197784] [drm:intel_dump_pipe_config] gmch pfit: control: 0x00000000, ratios: 0x00000000, lvds border: 0x00000000
[   98.197787] [drm:intel_dump_pipe_config] pch pfit: pos: 0x00000000, size: 0x00000000, disabled
[   98.197788] [drm:intel_dump_pipe_config] ips: 0
[   98.197790] [drm:intel_dump_pipe_config] double wide: 0
[   98.197793] [drm:intel_dump_pipe_config] dpll_hw_state: dpll: 0x88046004, dpll_md: 0x0, fp0: 0x21007, fp1: 0x21007
[   98.197795] [drm:intel_dump_pipe_config] planes on this crtc
[   98.197797] [drm:intel_dump_pipe_config] STANDARD PLANE:23 plane: 1.0 idx: 3 enabled
[   98.197801] [drm:intel_dump_pipe_config] 	FB:43, fb = 3286x1080 format = 0x34325258
[   98.197804] [drm:intel_dump_pipe_config] 	scaler:0 src (0, 312) 0x0 dst (0, 0) 0x0
[   98.197807] [drm:intel_dump_pipe_config] CURSOR PLANE:24 plane: 1.2 idx: 4 disabled, scaler_id = 0
[   98.197809] [drm:intel_dump_pipe_config] STANDARD PLANE:26 plane: 1.1 idx: 5 disabled, scaler_id = 0
[   98.197839] [drm:intel_get_shared_dpll] CRTC:25 allocated PCH DPLL A
[   98.197841] [drm:intel_get_shared_dpll] using PCH DPLL A for pipe B
[   98.199731] [drm:intel_power_well_enable] enabling always-on
[   98.199740] [drm:intel_prepare_shared_dpll] setting up PCH DPLL A
[   98.200320] [drm:intel_enable_pipe] enabling pipe B
[   98.201129] [drm:gen6_fdi_link_train] FDI_RX_IIR 0x100
[   98.201132] [drm:gen6_fdi_link_train] FDI train 1 done.
[   98.201784] [drm:gen6_fdi_link_train] FDI_RX_IIR 0x600
[   98.201789] [drm:gen6_fdi_link_train] FDI train 2 done.
[   98.201793] [drm:gen6_fdi_link_train] FDI train done.
[   98.201799] [drm:intel_enable_shared_dpll] enable PCH DPLL A (active 0, on? 0) for crtc 25
[   98.201803] [drm:intel_enable_shared_dpll] enabling PCH DPLL A
[   98.203176] [drm:intel_enable_hdmi_audio] Enabling HDMI audio on pipe B
[   98.203179] [drm:intel_audio_codec_enable] ELD on [CONNECTOR:36:HDMI-A-1], [ENCODER:35:TMDS-35]
[   98.203182] [drm:ilk_audio_codec_enable] Enable audio codec on port B, pipe B, 36 bytes ELD
[   98.203195] [drm:audio_config_hdmi_pixel_clock] HDMI audio pixel clock setting for 65000 not found, falling back to defaults
[   98.203198] [drm:audio_config_hdmi_pixel_clock] Configuring HDMI audio for pixel clock 25200 (0x00010000)
[   98.253537] [drm:intel_connector_check_state] [CONNECTOR:27:LVDS-1]
[   98.253553] [drm:intel_connector_check_state] [CONNECTOR:36:HDMI-A-1]
[   98.253560] [drm:check_encoder_state] [ENCODER:28:LVDS-28]
[   98.253567] [drm:check_encoder_state] [ENCODER:34:DAC-34]
[   98.253573] [drm:check_encoder_state] [ENCODER:35:TMDS-35]
[   98.253577] [drm:check_encoder_state] [ENCODER:40:TMDS-40]
[   98.253589] [drm:check_crtc_state] [CRTC:21]
[   98.253596] [drm:check_crtc_state] [CRTC:25]
[   98.253622] [drm:check_shared_dpll_state] PCH DPLL A
[   98.253630] [drm:check_shared_dpll_state] PCH DPLL B
[   98.253922] [drm:intel_backlight_device_update_status] updating intel_backlight, brightness=0/976
[   98.254616] [drm:drm_mode_setcrtc] [CRTC:21:crtc-0]
[   98.254625] [drm:drm_mode_setcrtc] [CONNECTOR:27:LVDS-1]
[   98.254643] [drm:connected_sink_compute_bpp] [CONNECTOR:27:LVDS-1] checking for sink bpp constrains
[   98.254645] [drm:connected_sink_compute_bpp] clamping display bpp (was 36) to default limit of 24
[   98.254648] [drm:intel_lvds_compute_config] forcing display bpp (was 24) to LVDS (18)
[   98.254652] [drm:ironlake_check_fdi_lanes] checking fdi config on pipe A, lanes 1
[   98.254654] [drm:intel_modeset_pipe_config] hw max bpp: 36, pipe bpp: 18, dithering: 1
[   98.254658] [drm:intel_dump_pipe_config] [CRTC:21][modeset] config ffff880243cb5400 for pipe A
[   98.254660] [drm:intel_dump_pipe_config] cpu_transcoder: A
[   98.254662] [drm:intel_dump_pipe_config] pipe bpp: 18, dithering: 1
[   98.254665] [drm:intel_dump_pipe_config] fdi/pch: 1, lanes: 1, gmch_m: 2481629, gmch_n: 4194304, link_m: 137868, link_n: 524288, tu: 64
[   98.254668] [drm:intel_dump_pipe_config] dp: 0, lanes: 0, gmch_m: 0, gmch_n: 0, link_m: 0, link_n: 0, tu: 0
[   98.254671] [drm:intel_dump_pipe_config] dp: 0, lanes: 0, gmch_m2: 0, gmch_n2: 0, link_m2: 0, link_n2: 0, tu2: 0
[   98.254673] [drm:intel_dump_pipe_config] audio: 0, infoframes: 0
[   98.254675] [drm:intel_dump_pipe_config] requested mode:
[   98.254679] [drm:drm_mode_debug_printmodeline] Modeline 0:"" 0 65000 1024 1048 1184 1344 768 771 777 806 0x0 0xa
[   98.254681] [drm:intel_dump_pipe_config] adjusted mode:
[   98.254685] [drm:drm_mode_debug_printmodeline] Modeline 0:"1366x768" 60 71000 1366 1407 1434 1500 768 771 775 788 0x48 0xa
[   98.254688] [drm:intel_dump_crtc_timings] crtc timings: 71000 1366 1407 1434 1500 768 771 775 788, type: 0x48 flags: 0xa
[   98.254690] [drm:intel_dump_pipe_config] port clock: 71000
[   98.254692] [drm:intel_dump_pipe_config] pipe src size: 1024x768
[   98.254695] [drm:intel_dump_pipe_config] num_scalers: 0, scaler_users: 0x0, scaler_id: 0
[   98.254697] [drm:intel_dump_pipe_config] gmch pfit: control: 0x00000000, ratios: 0x00000000, lvds border: 0x00000000
[   98.254699] [drm:intel_dump_pipe_config] pch pfit: pos: 0x00ab0000, size: 0x04000300, enabled
[   98.254701] [drm:intel_dump_pipe_config] ips: 0
[   98.254703] [drm:intel_dump_pipe_config] double wide: 0
[   98.254706] [drm:intel_dump_pipe_config] dpll_hw_state: dpll: 0xc4020002, dpll_md: 0x0, fp0: 0x21007, fp1: 0x21007
[   98.254707] [drm:intel_dump_pipe_config] planes on this crtc
[   98.254710] [drm:intel_dump_pipe_config] STANDARD PLANE:18 plane: 0.0 idx: 0 enabled
[   98.254713] [drm:intel_dump_pipe_config] 	FB:43, fb = 3286x1080 format = 0x34325258
[   98.254716] [drm:intel_dump_pipe_config] 	scaler:0 src (1366, 0) 0x0 dst (0, 0) 0x0
[   98.254719] [drm:intel_dump_pipe_config] CURSOR PLANE:20 plane: 0.1 idx: 1 enabled
[   98.254721] [drm:intel_dump_pipe_config] 	FB:46, fb = 64x64 format = 0x34325241
[   98.254725] [drm:intel_dump_pipe_config] 	scaler:0 src (0, 0) 4294967289x4294967016 dst (7, 280) 4294967289x4294967016
[   98.254727] [drm:intel_dump_pipe_config] STANDARD PLANE:22 plane: 0.1 idx: 2 disabled, scaler_id = 0
[   98.254737] [drm:ironlake_get_refclk] using SSC reference clock of 120000 kHz
[   98.254788] [drm:intel_get_shared_dpll] CRTC:21 allocated PCH DPLL B
[   98.254791] [drm:intel_get_shared_dpll] using PCH DPLL B for pipe A
[   98.254820] [drm:intel_prepare_shared_dpll] setting up PCH DPLL B
[   98.255412] [drm:intel_enable_pipe] enabling pipe A
[   98.256232] [drm:gen6_fdi_link_train] FDI_RX_IIR 0x100
[   98.256236] [drm:gen6_fdi_link_train] FDI train 1 done.
[   98.256889] [drm:gen6_fdi_link_train] FDI_RX_IIR 0x600
[   98.256893] [drm:gen6_fdi_link_train] FDI train 2 done.
[   98.256895] [drm:gen6_fdi_link_train] FDI train done.
[   98.256902] [drm:intel_enable_shared_dpll] enable PCH DPLL B (active 0, on? 0) for crtc 21
[   98.256907] [drm:intel_enable_shared_dpll] enabling PCH DPLL B
[   98.558274] [drm:intel_panel_enable_backlight] pipe A
[   98.558291] [drm:intel_panel_actually_set_backlight] set backlight PWM = 976
[   98.593570] [drm:intel_connector_check_state] [CONNECTOR:27:LVDS-1]
[   98.593584] [drm:check_encoder_state] [ENCODER:28:LVDS-28]
[   98.593589] [drm:check_encoder_state] [ENCODER:34:DAC-34]
[   98.593595] [drm:check_encoder_state] [ENCODER:35:TMDS-35]
[   98.593598] [drm:check_encoder_state] [ENCODER:40:TMDS-40]
[   98.593604] [drm:check_crtc_state] [CRTC:21]
[   98.593629] [drm:check_shared_dpll_state] PCH DPLL A
[   98.593636] [drm:check_shared_dpll_state] PCH DPLL B
[   98.597328] [drm:intel_backlight_device_update_status] updating intel_backlight, brightness=0/976
[   98.597335] [drm:intel_panel_actually_set_backlight] set backlight PWM = 0
[   98.625227] [drm:i915_gem_context_destroy_ioctl] HW context 1 destroyed
[   98.627331] [drm:intel_panel_get_backlight] get backlight PWM = 0
[   98.627364] [drm:intel_backlight_device_update_status] updating intel_backlight, brightness=0/976
[   98.627367] [drm:intel_panel_actually_set_backlight] set backlight PWM = 0
[   98.660741] [drm:drm_mode_getconnector] [CONNECTOR:27:?]
[   98.660751] [drm:drm_helper_probe_single_connector_modes] [CONNECTOR:27:LVDS-1]
[   98.660755] [drm:intel_lvds_detect] [CONNECTOR:27:LVDS-1]
[   98.660774] [drm:drm_helper_probe_single_connector_modes] [CONNECTOR:27:LVDS-1] probed modes :
[   98.660781] [drm:drm_mode_debug_printmodeline] Modeline 30:"1366x768" 60 71000 1366 1407 1434 1500 768 771 775 788 0x48 0xa
[   98.660788] [drm:drm_mode_getconnector] [CONNECTOR:27:?]
[   98.661114] [drm:drm_mode_getconnector] [CONNECTOR:33:?]
[   98.661120] [drm:drm_helper_probe_single_connector_modes] [CONNECTOR:33:VGA-1]
[   98.661123] [drm:intel_crt_detect] [CONNECTOR:33:VGA-1] force=1
[   98.661133] [drm:intel_ironlake_crt_detect_hotplug] ironlake hotplug adpa=0xf40000, result 0
[   98.661136] [drm:intel_crt_detect] CRT not detected via hotplug
[   98.661373] [drm:do_gmbus_xfer] GMBUS [i915 gmbus vga] NAK for addr: 0050 w(1)
[   98.661378] [drm:do_gmbus_xfer] GMBUS [i915 gmbus vga] NAK on first message, retry
[   98.661631] [drm:do_gmbus_xfer] GMBUS [i915 gmbus vga] NAK for addr: 0050 w(1)
[   98.661637] [drm:drm_do_probe_ddc_edid] drm: skipping non-existent adapter i915 gmbus vga
[   98.661641] [drm:intel_crt_get_edid] CRT GMBUS EDID read failed, retry using GPIO bit-banging
[   98.661645] [drm:intel_gmbus_force_bit] enabling bit-banging on i915 gmbus vga. force bit now 1
[   98.661996] [drm:drm_do_probe_ddc_edid] drm: skipping non-existent adapter i915 gmbus vga
[   98.661999] [drm:intel_gmbus_force_bit] disabling bit-banging on i915 gmbus vga. force bit now 0
[   98.662001] [drm:intel_crt_detect_ddc] CRT not detected via DDC:0x50 [no valid EDID found]
[   98.662005] [drm:drm_helper_probe_single_connector_modes] [CONNECTOR:33:VGA-1] disconnected
[   98.662015] [drm:drm_mode_getconnector] [CONNECTOR:33:?]
[   98.662018] [drm:drm_helper_probe_single_connector_modes] [CONNECTOR:33:VGA-1]
[   98.662021] [drm:intel_crt_detect] [CONNECTOR:33:VGA-1] force=1
[   98.662024] [drm:intel_ironlake_crt_detect_hotplug] ironlake hotplug adpa=0xf40000, result 0
[   98.662026] [drm:intel_crt_detect] CRT not detected via hotplug
[   98.662196] [drm:do_gmbus_xfer] GMBUS [i915 gmbus vga] NAK for addr: 0050 w(1)
[   98.662201] [drm:do_gmbus_xfer] GMBUS [i915 gmbus vga] NAK on first message, retry
[   98.662359] [drm:do_gmbus_xfer] GMBUS [i915 gmbus vga] NAK for addr: 0050 w(1)
[   98.662364] [drm:drm_do_probe_ddc_edid] drm: skipping non-existent adapter i915 gmbus vga
[   98.662368] [drm:intel_crt_get_edid] CRT GMBUS EDID read failed, retry using GPIO bit-banging
[   98.662372] [drm:intel_gmbus_force_bit] enabling bit-banging on i915 gmbus vga. force bit now 1
[   98.662726] [drm:drm_do_probe_ddc_edid] drm: skipping non-existent adapter i915 gmbus vga
[   98.662731] [drm:intel_gmbus_force_bit] disabling bit-banging on i915 gmbus vga. force bit now 0
[   98.662736] [drm:intel_crt_detect_ddc] CRT not detected via DDC:0x50 [no valid EDID found]
[   98.662740] [drm:drm_helper_probe_single_connector_modes] [CONNECTOR:33:VGA-1] disconnected
[   98.662770] [drm:drm_mode_getconnector] [CONNECTOR:36:?]
[   98.662775] [drm:drm_helper_probe_single_connector_modes] [CONNECTOR:36:HDMI-A-1]
[   98.662782] [drm:intel_hdmi_detect] [CONNECTOR:36:HDMI-A-1]
[   98.687715] [drm:drm_detect_monitor_audio] Monitor has basic audio support
[   98.687827] [drm:drm_edid_to_eld] ELD monitor SyncMaster
[   98.687833] [drm:parse_hdmi_vsdb] HDMI: DVI dual 0, max TMDS clock 0, latency present 0 0, video latency 0 0, audio latency 0 0
[   98.687836] [drm:drm_edid_to_eld] ELD size 36, SAD count 1
[   98.687891] [drm:drm_helper_probe_single_connector_modes] [CONNECTOR:36:HDMI-A-1] probed modes :
[   98.687898] [drm:drm_mode_debug_printmodeline] Modeline 45:"1920x1080" 60 148500 1920 2008 2052 2200 1080 1084 1089 1125 0x48 0x5
[   98.687904] [drm:drm_mode_debug_printmodeline] Modeline 72:"1920x1080" 60 148352 1920 2008 2052 2200 1080 1084 1089 1125 0x40 0x5
[   98.687910] [drm:drm_mode_debug_printmodeline] Modeline 48:"1920x1080i" 60 74250 1920 2008 2052 2200 1080 1084 1094 1125 0x40 0x15
[   98.687915] [drm:drm_mode_debug_printmodeline] Modeline 73:"1920x1080i" 60 74176 1920 2008 2052 2200 1080 1084 1094 1125 0x40 0x15
[   98.687921] [drm:drm_mode_debug_printmodeline] Modeline 65:"1920x1080" 50 148500 1920 2448 2492 2640 1080 1084 1089 1125 0x40 0x5
[   98.687927] [drm:drm_mode_debug_printmodeline] Modeline 52:"1920x1080i" 50 74250 1920 2448 2492 2640 1080 1084 1094 1125 0x40 0x15
[   98.687932] [drm:drm_mode_debug_printmodeline] Modeline 54:"1600x1200" 60 162000 1600 1664 1856 2160 1200 1201 1204 1250 0x40 0x5
[   98.687938] [drm:drm_mode_debug_printmodeline] Modeline 59:"1680x1050" 60 119000 1680 1728 1760 1840 1050 1053 1059 1080 0x40 0x9
[   98.687943] [drm:drm_mode_debug_printmodeline] Modeline 55:"1280x1024" 60 108000 1280 1328 1440 1688 1024 1025 1028 1066 0x40 0x5
[   98.687949] [drm:drm_mode_debug_printmodeline] Modeline 58:"1440x900" 60 88750 1440 1488 1520 1600 900 903 909 926 0x40 0x9
[   98.687955] [drm:drm_mode_debug_printmodeline] Modeline 56:"1280x960" 60 108000 1280 1376 1488 1800 960 961 964 1000 0x40 0x5
[   98.687960] [drm:drm_mode_debug_printmodeline] Modeline 57:"1280x800" 60 71000 1280 1328 1360 1440 800 803 809 823 0x40 0x9
[   98.687965] [drm:drm_mode_debug_printmodeline] Modeline 49:"1280x720" 60 74250 1280 1390 1430 1650 720 725 730 750 0x40 0x5
[   98.687971] [drm:drm_mode_debug_printmodeline] Modeline 74:"1280x720" 60 74176 1280 1390 1430 1650 720 725 730 750 0x40 0x5
[   98.687977] [drm:drm_mode_debug_printmodeline] Modeline 50:"1280x720" 50 74250 1280 1720 1760 1980 720 725 730 750 0x40 0x5
[   98.687982] [drm:drm_mode_debug_printmodeline] Modeline 63:"1024x768" 60 65000 1024 1048 1184 1344 768 771 777 806 0x40 0xa
[   98.687988] [drm:drm_mode_debug_printmodeline] Modeline 60:"800x600" 60 40000 800 840 968 1056 600 601 605 628 0x40 0x5
[   98.687993] [drm:drm_mode_debug_printmodeline] Modeline 61:"800x600" 56 36000 800 824 896 1024 600 601 603 625 0x40 0x5
[   98.687998] [drm:drm_mode_debug_printmodeline] Modeline 51:"720x576" 50 27000 720 732 796 864 576 581 586 625 0x40 0xa
[   98.688004] [drm:drm_mode_debug_printmodeline] Modeline 75:"720x480" 60 27027 720 736 798 858 480 489 495 525 0x40 0xa
[   98.688009] [drm:drm_mode_debug_printmodeline] Modeline 53:"720x480" 60 27000 720 736 798 858 480 489 495 525 0x40 0xa
[   98.688014] [drm:drm_mode_debug_printmodeline] Modeline 62:"640x480" 60 25200 640 656 752 800 480 490 492 525 0x40 0xa
[   98.688020] [drm:drm_mode_debug_printmodeline] Modeline 76:"640x480" 60 25175 640 656 752 800 480 490 492 525 0x40 0xa
[   98.688062] [drm:drm_mode_getconnector] [CONNECTOR:36:?]
[   98.688247] [drm:drm_mode_getconnector] [CONNECTOR:41:?]
[   98.688252] [drm:drm_helper_probe_single_connector_modes] [CONNECTOR:41:DP-1]
[   98.688255] [drm:intel_dp_detect] [CONNECTOR:41:DP-1]
[   98.690728] [drm:intel_dp_aux_ch] dp_aux_ch timeout status 0x7143003f
[   98.693186] [drm:intel_dp_aux_ch] dp_aux_ch timeout status 0x7143003f
[   98.699999] [drm:intel_dp_aux_ch] dp_aux_ch timeout status 0x7143003f
[   98.708012] [drm:intel_dp_aux_ch] dp_aux_ch timeout status 0x7143003f
[   98.713549] [drm:drm_helper_probe_single_connector_modes] [CONNECTOR:41:DP-1] disconnected
[   98.713576] [drm:drm_mode_getconnector] [CONNECTOR:41:?]
[   98.713580] [drm:drm_helper_probe_single_connector_modes] [CONNECTOR:41:DP-1]
[   98.713582] [drm:intel_dp_detect] [CONNECTOR:41:DP-1]
[   98.716049] [drm:intel_dp_aux_ch] dp_aux_ch timeout status 0x7143003f
[   98.718565] [drm:intel_dp_aux_ch] dp_aux_ch timeout status 0x7143003f
[   98.727997] [drm:intel_dp_aux_ch] dp_aux_ch timeout status 0x7143003f
[   98.735993] [drm:intel_dp_aux_ch] dp_aux_ch timeout status 0x7143003f
[   98.741545] [drm:drm_helper_probe_single_connector_modes] [CONNECTOR:41:DP-1] disconnected
[   98.742749] [drm:intel_panel_get_backlight] get backlight PWM = 0
[   98.742794] [drm:intel_backlight_device_update_status] updating intel_backlight, brightness=0/976
[   98.742799] [drm:intel_panel_actually_set_backlight] set backlight PWM = 0
[   98.771967] [drm:intel_panel_get_backlight] get backlight PWM = 0
[   98.772002] [drm:intel_backlight_device_update_status] updating intel_backlight, brightness=0/976
[   98.772005] [drm:intel_panel_actually_set_backlight] set backlight PWM = 0
[   98.794802] [drm:intel_panel_get_backlight] get backlight PWM = 0
[   98.794836] [drm:intel_backlight_device_update_status] updating intel_backlight, brightness=0/976
[   98.794839] [drm:intel_panel_actually_set_backlight] set backlight PWM = 0
[   98.817798] [drm:intel_panel_get_backlight] get backlight PWM = 0
[   98.817833] [drm:intel_backlight_device_update_status] updating intel_backlight, brightness=0/976
[   98.817836] [drm:intel_panel_actually_set_backlight] set backlight PWM = 0
[   98.981619] [drm:drm_mode_addfb2] [FB:46]
[   99.034204] [drm:drm_mode_addfb2] [FB:66]
[   99.069923] [drm:drm_mode_addfb2] [FB:46]
[   99.089450] [drm:drm_mode_addfb2] [FB:66]
[   99.107449] [drm:drm_mode_addfb2] [FB:46]
[   99.215036] [drm:drm_mode_addfb2] [FB:66]
[   99.816833] [drm:drm_mode_addfb2] [FB:46]
[  138.989863] [drm:drm_mode_addfb2] [FB:66]

--------------090104010606010606050305--
