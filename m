From: "John Utz" <john.utz@dmx.com>
Subject: Re: Blacklist (Re:  ALSA API as standards)
Date: Mon, 26 Nov 2007 10:36:41 -0800
Message-ID: <20071126103641.3cd519f8@jutz-gnto64>
References: <s5h3auzwof5.wl%tiwai@suse.de>
	<s5hy7cprp01.wl%tiwai@suse.de> <s5hve7trnk9.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail.dmxmusic.com (mail.dmxmusic.com [199.201.237.35])
	by alsa0.perex.cz (Postfix) with ESMTP id E1CF924883
	for <alsa-devel@alsa-project.org>; Mon, 26 Nov 2007 19:37:13 +0100 (CET)
In-Reply-To: <s5hve7trnk9.wl%tiwai@suse.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Wow, Takashi!

What a mighty collection of stuff, tnx for taking the time to enumerate
all of this!

On Fri, 23 Nov 2007 16:25:42 +0100
"Takashi Iwai" <tiwai@suse.de> wrote:

> At Fri, 23 Nov 2007 15:54:38 +0100,
> I wrote:
> > 
> > At Wed, 21 Nov 2007 17:31:26 +0100,
> > I wrote:
> > > 
> > > What I'd like to do now are:
> > > 
> > > - create a list of "standard" functions to be passed to LSB
> > > - clean up and actually drop some non-used functions
> > > - remove some functions from export list (in Versions file)
> > > 
> > > I'll try to create a list.  Basically it'll be almost as same as
> > > the list of functions with count > 0, plus some related ones.
> > 
> > OK, here is the white list.  I paste it below at this time.
> > 
> > It doesn't include the new functions regarding TLV and dB level.
> > Also, some functions are not listed intentionally.  They will be
> > listed in the next mail.
> 
> Here it is, the black list.
> 
> These are functions that are not worth to be in the standard list.
> They are never used or shouldn't be used any more.  Some are functions
> / variables that are exported but supposed to be internal-only.
> 
> I think we can mark them deprecated and get rid of the header files in
> future.
> 
> 
> Takashi
> 
> ===
> 
> /* internal only */
> snd_shm_area_create
> snd_shm_area_share
> snd_shm_area_destroy
> 
> /* internal only */
> snd_dlopen
> snd_dlsym
> snd_dlclose
> 
> /* internal only */
> snd_user_file
> snd_dlsym_start
> 
> /* conf.c - no use */
> snd_config_load_override
> snd_config_update_r
> 
> /* internal */
> snd_config_search_alias_hooks
> snd_config_substitute
> 
> /* deprecated */
> snd_names_list
> snd_names_list_free
> 
> /* ctl - no use */
> snd_ctl_open_lconf
> /* no use, and they can be redundant (retrieved from *_get_id()) */
> snd_ctl_event_elem_get_numid
> snd_ctl_event_elem_get_interface
> snd_ctl_event_elem_get_device
> snd_ctl_event_elem_get_subdevice
> snd_ctl_event_elem_get_name
> snd_ctl_event_elem_get_index
> /* ditto */
> snd_ctl_elem_list_get_interface
> snd_ctl_elem_list_get_device
> snd_ctl_elem_list_get_subdevice
> snd_ctl_elem_list_get_index
> 
> /* dimension feature isn't properly used */
> snd_ctl_elem_info_get_dimensions
> snd_ctl_elem_info_get_dimension
> 
> /* no use, redundant */
> snd_ctl_elem_info_get_interface
> snd_ctl_elem_info_get_device
> snd_ctl_elem_info_get_subdevice
> snd_ctl_elem_info_get_index
> snd_ctl_elem_info_set_numid
> /* ditto */
> snd_ctl_elem_info_set_interface
> snd_ctl_elem_info_set_device
> snd_ctl_elem_info_set_subdevice
> snd_ctl_elem_info_set_name
> snd_ctl_elem_info_set_index
> /* ditto */
> snd_ctl_elem_value_get_interface
> snd_ctl_elem_value_get_device
> snd_ctl_elem_value_get_subdevice
> snd_ctl_elem_value_get_index
> /* ditto */
> snd_ctl_elem_value_set_numid
> snd_ctl_elem_value_set_interface
> snd_ctl_elem_value_set_device
> snd_ctl_elem_value_set_subdevice
> snd_ctl_elem_value_set_name
> snd_ctl_elem_value_set_index
> 
> /* a wrong symbol name */
> snd_ctl_elem_set_bytes
> 
> /* no use, redundant */
> snd_hctl_elem_get_numid
> snd_hctl_elem_get_interface
> snd_hctl_elem_get_device
> snd_hctl_elem_get_subdevice
> snd_hctl_elem_get_name
> snd_hctl_elem_get_index
> 
> /* deprecated */
> snd_ctl_set_power_state
> snd_ctl_get_power_state
> 
> /* deprecated */
> snd_sctl_build
> snd_sctl_free
> snd_sctl_install
> snd_sctl_remove
> 
> /* mixer class is never used properly */
> snd_mixer_class_unregister
> snd_mixer_class_register
> snd_mixer_add_elem
> snd_mixer_remove_elem
> snd_mixer_elem_new
> snd_mixer_elem_add
> snd_mixer_elem_remove
> snd_mixer_elem_free
> snd_mixer_elem_info
> snd_mixer_elem_value
> snd_mixer_elem_attach
> snd_mixer_elem_detach
> snd_mixer_elem_empty
> snd_mixer_elem_get_private
> snd_mixer_class_sizeof
> snd_mixer_class_malloc
> snd_mixer_class_free
> snd_mixer_class_copy
> snd_mixer_class_get_mixer
> snd_mixer_class_get_event
> snd_mixer_class_get_private
> snd_mixer_class_get_compare
> snd_mixer_class_set_event
> snd_mixer_class_set_private
> snd_mixer_class_set_private_free
> snd_mixer_class_set_compare
> 
> /* deprecated */
> snd_pcm_set_params
> snd_pcm_get_params
> 
> /* useless parameters, implemented on no driver properly */
> snd_pcm_hw_params_is_batch
> snd_pcm_hw_params_is_block_transfer
> snd_pcm_hw_params_can_overrange
> snd_pcm_hw_params_get_fifo_size
> 
> /* *_set_first() and *_set_last() are almost useless */
> snd_pcm_hw_params_set_access_first
> snd_pcm_hw_params_set_access_last
> snd_pcm_hw_params_set_format_first
> snd_pcm_hw_params_set_format_last
> 
> /* subformat is useless, so far; we have even no proper definition */
> snd_pcm_hw_params_get_subformat
> snd_pcm_hw_params_test_subformat
> snd_pcm_hw_params_set_subformat
> snd_pcm_hw_params_set_subformat_first
> snd_pcm_hw_params_set_subformat_last
> snd_pcm_hw_params_set_subformat_mask
> snd_pcm_hw_params_get_subformat_mask
> 
> /* set_min(), set_max(), set_minmax() are useless, too */
> snd_pcm_hw_params_set_channels_min
> snd_pcm_hw_params_set_channels_max
> snd_pcm_hw_params_set_channels_minmax
> snd_pcm_hw_params_set_channels_first
> snd_pcm_hw_params_set_channels_last
> snd_pcm_hw_params_set_rate_min
> snd_pcm_hw_params_set_rate_max
> snd_pcm_hw_params_set_rate_minmax
> snd_pcm_hw_params_set_rate_first
> snd_pcm_hw_params_set_rate_last
> 
> /* export_buffer feature is never used except for aserver */
> snd_pcm_hw_params_set_export_buffer
> snd_pcm_hw_params_get_export_buffer
> 
> /* min, max */
> snd_pcm_hw_params_set_period_time_min
> snd_pcm_hw_params_set_period_time_max
> snd_pcm_hw_params_set_period_time_minmax
> snd_pcm_hw_params_set_period_time_first
> snd_pcm_hw_params_set_period_time_last
> snd_pcm_hw_params_set_period_size_min
> snd_pcm_hw_params_set_period_size_max
> snd_pcm_hw_params_set_period_size_minmax
> snd_pcm_hw_params_set_period_size_first
> snd_pcm_hw_params_set_period_size_last
> snd_pcm_hw_params_set_period_size_integer
> snd_pcm_hw_params_set_periods_min
> snd_pcm_hw_params_set_periods_max
> snd_pcm_hw_params_set_periods_minmax
> snd_pcm_hw_params_set_periods_first
> snd_pcm_hw_params_set_periods_last
> snd_pcm_hw_params_set_buffer_time_min
> snd_pcm_hw_params_set_buffer_time_max
> snd_pcm_hw_params_set_buffer_time_minmax
> snd_pcm_hw_params_set_buffer_time_first
> snd_pcm_hw_params_set_buffer_time_last
> snd_pcm_hw_params_set_buffer_size_min
> snd_pcm_hw_params_set_buffer_size_max
> snd_pcm_hw_params_set_buffer_size_minmax
> snd_pcm_hw_params_set_buffer_size_first
> snd_pcm_hw_params_set_buffer_size_last
> 
> /* tick_time is never used by any apps */
> snd_pcm_hw_params_get_tick_time
> snd_pcm_hw_params_get_tick_time_min
> snd_pcm_hw_params_get_tick_time_max
> snd_pcm_hw_params_test_tick_time
> snd_pcm_hw_params_set_tick_time
> snd_pcm_hw_params_set_tick_time_min
> snd_pcm_hw_params_set_tick_time_max
> snd_pcm_hw_params_set_tick_time_minmax
> snd_pcm_hw_params_set_tick_time_near
> snd_pcm_hw_params_set_tick_time_first
> snd_pcm_hw_params_set_tick_time_last
> snd_pcm_hw_params_get_min_align
> 
> /* sleep_min is never used by apps (except for aplay as an option) */
> snd_pcm_sw_params_set_sleep_min
> snd_pcm_sw_params_get_sleep_min
> 
> /* xfer_align is also superfluous */
> snd_pcm_sw_params_set_xfer_align
> snd_pcm_sw_params_get_xfer_align
> 
> /* subformat is not defined nor used */
> snd_pcm_subformat_mask_sizeof
> snd_pcm_subformat_mask_malloc
> snd_pcm_subformat_mask_free
> snd_pcm_subformat_mask_copy
> snd_pcm_subformat_mask_none
> snd_pcm_subformat_mask_any
> snd_pcm_subformat_mask_test
> snd_pcm_subformat_mask_empty
> snd_pcm_subformat_mask_set
> snd_pcm_subformat_mask_reset
> snd_pcm_status_get_overrange
> snd_pcm_subformat_name
> snd_pcm_subformat_description
> 
> /* this can be in the whitelist */
> snd_pcm_format_size
> 
> /* should use snd_pcm_format_set_silence() */
> snd_pcm_format_silence
> snd_pcm_format_silence_16
> snd_pcm_format_silence_32
> snd_pcm_format_silence_64
> 
> /* no real use of hook plugin (for apps) */
> snd_pcm_hook_get_pcm
> snd_pcm_hook_get_private
> snd_pcm_hook_set_private
> snd_pcm_hook_add
> snd_pcm_hook_remove
> 
> /* no real use of meter plugin (for apps) */
> snd_pcm_meter_get_bufsize
> snd_pcm_meter_get_channels
> snd_pcm_meter_get_rate
> snd_pcm_meter_get_now
> snd_pcm_meter_get_boundary
> snd_pcm_meter_add_scope
> snd_pcm_meter_search_scope
> snd_pcm_scope_malloc
> snd_pcm_scope_set_ops
> snd_pcm_scope_set_name
> snd_pcm_scope_get_name
> snd_pcm_scope_get_callback_private
> snd_pcm_scope_set_callback_private
> snd_pcm_scope_s16_open
> snd_pcm_scope_s16_get_channel_buffer
> 
> /* unfinished API, deprecated */
> snd_spcm_init
> snd_spcm_init_duplex
> snd_spcm_init_get_params
> 
> /* deprecated */
> snd_pcm_start_mode_name
> snd_pcm_xrun_mode_name
> snd_pcm_sw_params_set_start_mode
> snd_pcm_sw_params_get_start_mode
> snd_pcm_sw_params_set_xrun_mode
> snd_pcm_sw_params_get_xrun_mode
> 
> /* timer_query is never used, so far */
> snd_timer_query_open
> snd_timer_query_open_lconf
> snd_timer_query_close
> snd_timer_query_next_device
> snd_timer_query_info
> snd_timer_query_params
> snd_timer_query_status
> snd_timer_open_lconf
> 
> /* ditto for timer_ginfo */
> snd_timer_ginfo_sizeof
> snd_timer_ginfo_malloc
> snd_timer_ginfo_free
> snd_timer_ginfo_copy
> snd_timer_ginfo_set_tid
> snd_timer_ginfo_get_tid
> snd_timer_ginfo_get_flags
> snd_timer_ginfo_get_card
> snd_timer_ginfo_get_id
> snd_timer_ginfo_get_name
> snd_timer_ginfo_get_resolution
> snd_timer_ginfo_get_resolution_min
> snd_timer_ginfo_get_resolution_max
> snd_timer_ginfo_get_clients
> snd_timer_info_get_ticks
> 
> /* no use */
> snd_seq_open_lconf
> 
> /* the sequencer filters are never used by any apps */
> snd_seq_client_info_get_broadcast_filter
> snd_seq_client_info_get_error_bounce
> snd_seq_client_info_get_event_filter
> snd_seq_client_info_set_broadcast_filter
> snd_seq_client_info_set_error_bounce
> snd_seq_client_info_set_event_filter
> 
> /* pool adjustment has little demand */
> snd_seq_client_pool_sizeof
> snd_seq_client_pool_malloc
> snd_seq_client_pool_free
> snd_seq_client_pool_copy
> snd_seq_client_pool_get_client
> snd_seq_client_pool_get_output_pool
> snd_seq_client_pool_get_input_pool
> snd_seq_client_pool_get_output_room
> snd_seq_client_pool_get_output_free
> snd_seq_client_pool_get_input_free
> snd_seq_client_pool_set_output_pool
> snd_seq_client_pool_set_input_pool
> snd_seq_client_pool_set_output_room
> snd_seq_get_client_pool
> snd_seq_set_client_pool
> 
> /* ditto for queue_info */
> snd_seq_queue_info_sizeof
> snd_seq_queue_info_malloc
> snd_seq_queue_info_free
> snd_seq_queue_info_copy
> snd_seq_queue_info_get_queue
> snd_seq_queue_info_get_name
> snd_seq_queue_info_get_owner
> snd_seq_queue_info_get_locked
> snd_seq_queue_info_get_flags
> snd_seq_queue_info_set_name
> snd_seq_queue_info_set_owner
> snd_seq_queue_info_set_locked
> snd_seq_queue_info_set_flags
> snd_seq_create_queue
> snd_seq_get_queue_info
> snd_seq_set_queue_info
> snd_seq_query_named_queue
> snd_seq_get_queue_usage
> snd_seq_set_queue_usage
> 
> /* the queue tempo skew isn't used */
> snd_seq_queue_tempo_get_skew
> snd_seq_queue_tempo_get_skew_base
> snd_seq_queue_tempo_set_skew
> snd_seq_queue_tempo_set_skew_base
> 
> /* no use */
> snd_seq_queue_timer_sizeof
> snd_seq_queue_timer_malloc
> snd_seq_queue_timer_free
> snd_seq_queue_timer_copy
> snd_seq_queue_timer_get_queue
> snd_seq_queue_timer_get_type
> snd_seq_queue_timer_get_id
> snd_seq_queue_timer_get_resolution
> snd_seq_queue_timer_set_type
> snd_seq_queue_timer_set_id
> snd_seq_queue_timer_set_resolution
> snd_seq_get_queue_timer
> snd_seq_set_queue_timer
> 
> /* no use */
> snd_seq_remove_events_sizeof
> snd_seq_remove_events_malloc
> snd_seq_remove_events_free
> snd_seq_remove_events_copy
> snd_seq_remove_events_get_condition
> snd_seq_remove_events_get_queue
> snd_seq_remove_events_get_time
> snd_seq_remove_events_get_dest
> snd_seq_remove_events_get_channel
> snd_seq_remove_events_get_event_type
> snd_seq_remove_events_get_tag
> snd_seq_remove_events_set_condition
> snd_seq_remove_events_set_queue
> snd_seq_remove_events_set_time
> snd_seq_remove_events_set_dest
> snd_seq_remove_events_set_channel
> snd_seq_remove_events_set_event_type
> snd_seq_remove_events_set_tag
> snd_seq_remove_events
> 
> /* superfluous trivial functions */
> snd_seq_set_bit
> snd_seq_change_bit
> snd_seq_get_bit
> 
> /* no use */
> snd_seq_set_client_event_filter
> snd_seq_set_client_pool_output
> snd_seq_set_client_pool_output_room
> snd_seq_set_client_pool_input
> snd_seq_reset_pool_output
> snd_seq_reset_pool_input
> 
> _______________________________________________
> Alsa-devel mailing list
> Alsa-devel@alsa-project.org
> http://mailman.alsa-project.org/mailman/listinfo/alsa-devel
> 
