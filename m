From: Philip Prindeville <philipp_subx@redfish-solutions.com>
Subject: Re: Disagreement about versions following CVS update
Date: Fri, 19 Aug 2005 17:43:22 -0600
Message-ID: <43066E9A.3010705@redfish-solutions.com>
References: <43063408.60402@redfish-solutions.com>	 <1124483804.25424.50.camel@mindpipe>	 <43064B0B.9080402@redfish-solutions.com>	 <1124486050.25424.52.camel@mindpipe>	 <43065A7F.6070904@redfish-solutions.com>	 <1124490358.25424.72.camel@mindpipe>	 <43066945.7020405@redfish-solutions.com> <1124494135.25424.98.camel@mindpipe>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <1124494135.25424.98.camel@mindpipe>
Sender: alsa-devel-admin@lists.sourceforge.net
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Lee Revell <rlrevell@joe-job.com>
Cc: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

Lee Revell wrote:

>On Fri, 2005-08-19 at 17:20 -0600, Philip Prindeville wrote:
>  
>
>>Yep.
>>
>>    
>>
>
>What does dmesg say?
>
>Lee
>
>  
>

It says:

snd_seq_device: disagrees about version of symbol snd_info_register
snd_seq_device: Unknown symbol snd_info_register
snd_seq_device: disagrees about version of symbol 
snd_info_create_module_entry
snd_seq_device: Unknown symbol snd_info_create_module_entry
snd_seq_device: disagrees about version of symbol snd_info_free_entry
snd_seq_device: Unknown symbol snd_info_free_entry
snd_seq_device: disagrees about version of symbol snd_seq_root
snd_seq_device: Unknown symbol snd_seq_root
snd_seq_device: disagrees about version of symbol snd_device_new
snd_seq_device: Unknown symbol snd_device_new
snd_seq_device: disagrees about version of symbol snd_info_unregister
snd_seq_device: Unknown symbol snd_info_unregister
snd_rawmidi: disagrees about version of symbol snd_info_register
snd_rawmidi: Unknown symbol snd_info_register
snd_rawmidi: disagrees about version of symbol 
snd_ctl_unregister_ioctl_compat
snd_rawmidi: Unknown symbol snd_ctl_unregister_ioctl_compat
snd_rawmidi: Unknown symbol snd_seq_device_new
snd_rawmidi: disagrees about version of symbol snd_info_free_entry
snd_rawmidi: Unknown symbol snd_info_free_entry
snd_rawmidi: Unknown symbol snd_unregister_oss_device
snd_rawmidi: Unknown symbol snd_register_oss_device
snd_rawmidi: disagrees about version of symbol snd_ctl_register_ioctl
snd_rawmidi: Unknown symbol snd_ctl_register_ioctl
snd_rawmidi: disagrees about version of symbol snd_card_file_add
snd_rawmidi: Unknown symbol snd_card_file_add
snd_rawmidi: Unknown symbol snd_oss_info_register
snd_rawmidi: disagrees about version of symbol snd_unregister_device
snd_rawmidi: Unknown symbol snd_unregister_device
snd_rawmidi: disagrees about version of symbol snd_device_new
snd_rawmidi: Unknown symbol snd_device_new
snd_rawmidi: disagrees about version of symbol snd_ctl_unregister_ioctl
snd_rawmidi: Unknown symbol snd_ctl_unregister_ioctl
snd_rawmidi: disagrees about version of symbol snd_ctl_register_ioctl_compat
snd_rawmidi: Unknown symbol snd_ctl_register_ioctl_compat
snd_rawmidi: disagrees about version of symbol snd_info_create_card_entry
snd_rawmidi: Unknown symbol snd_info_create_card_entry
snd_rawmidi: disagrees about version of symbol snd_device_free
snd_rawmidi: Unknown symbol snd_device_free
snd_rawmidi: disagrees about version of symbol snd_card_file_remove
snd_rawmidi: Unknown symbol snd_card_file_remove
snd_rawmidi: disagrees about version of symbol snd_info_unregister
snd_rawmidi: Unknown symbol snd_info_unregister
snd_rawmidi: disagrees about version of symbol snd_device_register
snd_rawmidi: Unknown symbol snd_device_register
snd_rawmidi: disagrees about version of symbol snd_register_device
snd_rawmidi: Unknown symbol snd_register_device
snd_mpu401_uart: Unknown symbol snd_rawmidi_receive
snd_mpu401_uart: Unknown symbol snd_rawmidi_transmit_ack
snd_mpu401_uart: Unknown symbol snd_rawmidi_transmit_peek
snd_mpu401_uart: Unknown symbol snd_rawmidi_new
snd_mpu401_uart: Unknown symbol snd_rawmidi_set_ops
snd_mpu401_uart: disagrees about version of symbol snd_device_free
snd_mpu401_uart: Unknown symbol snd_device_free
snd_timer: disagrees about version of symbol snd_info_register
snd_timer: Unknown symbol snd_info_register
snd_timer: disagrees about version of symbol snd_info_create_module_entry
snd_timer: Unknown symbol snd_info_create_module_entry
snd_timer: disagrees about version of symbol snd_info_free_entry
snd_timer: Unknown symbol snd_info_free_entry
snd_timer: Unknown symbol snd_oss_info_register
snd_timer: disagrees about version of symbol snd_unregister_device
snd_timer: Unknown symbol snd_unregister_device
snd_timer: disagrees about version of symbol snd_device_new
snd_timer: Unknown symbol snd_device_new
snd_timer: disagrees about version of symbol snd_info_unregister
snd_timer: Unknown symbol snd_info_unregister
snd_timer: disagrees about version of symbol snd_register_device
snd_timer: Unknown symbol snd_register_device
snd_timer: disagrees about version of symbol snd_info_register
snd_timer: Unknown symbol snd_info_register
snd_timer: disagrees about version of symbol snd_info_create_module_entry
snd_timer: Unknown symbol snd_info_create_module_entry
snd_timer: disagrees about version of symbol snd_info_free_entry
snd_timer: Unknown symbol snd_info_free_entry
snd_timer: Unknown symbol snd_oss_info_register
snd_timer: disagrees about version of symbol snd_unregister_device
snd_timer: Unknown symbol snd_unregister_device
snd_timer: disagrees about version of symbol snd_device_new
snd_timer: Unknown symbol snd_device_new
snd_timer: disagrees about version of symbol snd_info_unregister
snd_timer: Unknown symbol snd_info_unregister
snd_timer: disagrees about version of symbol snd_register_device
snd_timer: Unknown symbol snd_register_device
snd_pcm: disagrees about version of symbol snd_info_register
snd_pcm: Unknown symbol snd_info_register
snd_pcm: disagrees about version of symbol snd_info_create_module_entry
snd_pcm: Unknown symbol snd_info_create_module_entry
snd_pcm: disagrees about version of symbol snd_ctl_unregister_ioctl_compat
snd_pcm: Unknown symbol snd_ctl_unregister_ioctl_compat
snd_pcm: Unknown symbol snd_timer_notify
snd_pcm: Unknown symbol snd_timer_interrupt
snd_pcm: disagrees about version of symbol snd_info_free_entry
snd_pcm: Unknown symbol snd_info_free_entry
snd_pcm: disagrees about version of symbol snd_ctl_register_ioctl
snd_pcm: Unknown symbol snd_ctl_register_ioctl
snd_pcm: disagrees about version of symbol snd_card_file_add
snd_pcm: Unknown symbol snd_card_file_add
snd_pcm: disagrees about version of symbol snd_unregister_device
snd_pcm: Unknown symbol snd_unregister_device
snd_pcm: Unknown symbol snd_timer_new
snd_pcm: disagrees about version of symbol snd_device_new
snd_pcm: Unknown symbol snd_device_new
snd_pcm: disagrees about version of symbol snd_ctl_unregister_ioctl
snd_pcm: Unknown symbol snd_ctl_unregister_ioctl
snd_pcm: disagrees about version of symbol snd_ctl_register_ioctl_compat
snd_pcm: Unknown symbol snd_ctl_register_ioctl_compat
snd_pcm: disagrees about version of symbol snd_info_create_card_entry
snd_pcm: Unknown symbol snd_info_create_card_entry
snd_pcm: disagrees about version of symbol snd_power_wait
snd_pcm: Unknown symbol snd_power_wait
snd_pcm: disagrees about version of symbol snd_device_free
snd_pcm: Unknown symbol snd_device_free
snd_pcm: disagrees about version of symbol snd_card_file_remove
snd_pcm: Unknown symbol snd_card_file_remove
snd_pcm: disagrees about version of symbol snd_info_unregister
snd_pcm: Unknown symbol snd_info_unregister
snd_pcm: disagrees about version of symbol snd_device_register
snd_pcm: Unknown symbol snd_device_register
snd_pcm: disagrees about version of symbol snd_register_device
snd_pcm: Unknown symbol snd_register_device
snd_ac97_codec: disagrees about version of symbol snd_info_register
snd_ac97_codec: Unknown symbol snd_info_register
snd_ac97_codec: disagrees about version of symbol snd_ctl_add
snd_ac97_codec: Unknown symbol snd_ctl_add
snd_ac97_codec: disagrees about version of symbol snd_info_free_entry
snd_ac97_codec: Unknown symbol snd_info_free_entry
snd_ac97_codec: Unknown symbol snd_interval_refine
snd_ac97_codec: disagrees about version of symbol snd_ctl_find_id
snd_ac97_codec: Unknown symbol snd_ctl_find_id
snd_ac97_codec: disagrees about version of symbol snd_ctl_new1
snd_ac97_codec: Unknown symbol snd_ctl_new1
snd_ac97_codec: disagrees about version of symbol snd_ctl_remove_id
snd_ac97_codec: Unknown symbol snd_ctl_remove_id
snd_ac97_codec: disagrees about version of symbol snd_component_add
snd_ac97_codec: Unknown symbol snd_component_add
snd_ac97_codec: Unknown symbol snd_pcm_hw_rule_add
snd_ac97_codec: disagrees about version of symbol snd_device_new
snd_ac97_codec: Unknown symbol snd_device_new
snd_ac97_codec: disagrees about version of symbol snd_info_create_card_entry
snd_ac97_codec: Unknown symbol snd_info_create_card_entry
snd_ac97_codec: disagrees about version of symbol snd_info_unregister
snd_ac97_codec: Unknown symbol snd_info_unregister
snd_via82xx: disagrees about version of symbol snd_ctl_add
snd_via82xx: Unknown symbol snd_ctl_add
snd_via82xx: Unknown symbol snd_ac97_resume
snd_via82xx: Unknown symbol snd_pcm_new
snd_via82xx: Unknown symbol snd_pcm_limit_hw_rates
snd_via82xx: disagrees about version of symbol snd_card_register
snd_via82xx: Unknown symbol snd_card_register
snd_via82xx: disagrees about version of symbol snd_card_free
snd_via82xx: Unknown symbol snd_card_free
snd_via82xx: Unknown symbol snd_pcm_lib_preallocate_pages_for_all
snd_via82xx: disagrees about version of symbol snd_card_proc_new
snd_via82xx: Unknown symbol snd_card_proc_new
snd_via82xx: Unknown symbol snd_ac97_set_rate
snd_via82xx: Unknown symbol snd_pcm_format_physical_width
snd_via82xx: Unknown symbol snd_ac97_update_bits
snd_via82xx: Unknown symbol snd_ac97_mixer
snd_via82xx: Unknown symbol snd_ac97_bus
snd_via82xx: disagrees about version of symbol snd_ctl_find_id
snd_via82xx: Unknown symbol snd_ctl_find_id
snd_via82xx: disagrees about version of symbol snd_ctl_new1
snd_via82xx: Unknown symbol snd_ctl_new1
snd_via82xx: disagrees about version of symbol snd_card_new
snd_via82xx: Unknown symbol snd_card_new
snd_via82xx: Unknown symbol snd_ac97_suspend
snd_via82xx: Unknown symbol snd_pcm_lib_malloc_pages
snd_via82xx: Unknown symbol snd_pcm_lib_ioctl
snd_via82xx: Unknown symbol snd_pcm_lib_free_pages
snd_via82xx: Unknown symbol snd_pcm_set_ops
snd_via82xx: disagrees about version of symbol snd_card_set_pm_callback
snd_via82xx: Unknown symbol snd_card_set_pm_callback
snd_via82xx: Unknown symbol snd_pcm_hw_constraint_list
snd_via82xx: disagrees about version of symbol snd_device_new
snd_via82xx: Unknown symbol snd_device_new
snd_via82xx: Unknown symbol snd_pcm_sgbuf_ops_page
snd_via82xx: Unknown symbol snd_mpu401_uart_interrupt
snd_via82xx: Unknown symbol snd_ac97_get_short_name
snd_via82xx: Unknown symbol snd_pcm_suspend_all
snd_via82xx: Unknown symbol snd_pcm_hw_constraint_integer
snd_via82xx: Unknown symbol snd_mpu401_uart_new
snd_via82xx: Unknown symbol snd_pcm_period_elapsed
snd_via82xx: Unknown symbol snd_ac97_tune_hardware




-------------------------------------------------------
SF.Net email is Sponsored by the Better Software Conference & EXPO
September 19-22, 2005 * San Francisco, CA * Development Lifecycle Practices
Agile & Plan-Driven Development * Managing Projects & Teams * Testing & QA
Security * Process Improvement & Measurement * http://www.sqe.com/bsce5sf
